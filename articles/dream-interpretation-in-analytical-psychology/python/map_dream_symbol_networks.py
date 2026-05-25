"""
Dream Interpretation in Analytical Psychology
Python Workflow: Dream symbol networks across a series

This script is a conceptual network demonstration.
It is not a clinical tool, diagnostic instrument, dream interpretation
system, treatment recommendation system, prediction tool, or proof of
Jungian theory.
"""

from pathlib import Path
from collections import Counter
from itertools import combinations
import re

import pandas as pd
import networkx as nx

ARTICLE_DIR = Path("articles/dream-interpretation-in-analytical-psychology")
DATA_PATH = ARTICLE_DIR / "data/raw/synthetic_dream_series.csv"
DICTIONARY_PATH = ARTICLE_DIR / "data/raw/dream_symbol_motif_dictionary.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

df = pd.read_csv(DATA_PATH)
motif_dictionary_df = pd.read_csv(DICTIONARY_PATH)

term_to_motif = dict(zip(motif_dictionary_df["term"], motif_dictionary_df["motif"]))
motif_family = dict(zip(motif_dictionary_df["motif"], motif_dictionary_df["motif_family"]))

records = []

for _, row in df.iterrows():
    words = re.findall(r"[a-zA-Z]+", str(row["text"]).lower())
    motif_counts = Counter(term_to_motif[word] for word in words if word in term_to_motif)

    for motif, count in motif_counts.items():
        records.append(
            {
                "dream_id": row["dream_id"],
                "person_id": row["person_id"],
                "time": row["time"],
                "phase": row["phase"],
                "dream_series_type": row["dream_series_type"],
                "motif": motif,
                "motif_family": motif_family.get(motif, "other"),
                "count": count,
            }
        )

motif_df = pd.DataFrame(records)

if motif_df.empty:
    raise ValueError("No motifs found. Check the corpus and motif dictionary.")

# ------------------------------------------------------------
# Full dream-series motif co-occurrence graph
# ------------------------------------------------------------

G = nx.Graph()

for motif in sorted(motif_dictionary_df["motif"].unique()):
    G.add_node(motif, motif_family=motif_family.get(motif, "other"))

for dream_id, group in motif_df.groupby("dream_id"):
    motifs = sorted(group["motif"].unique())

    for source, target in combinations(motifs, 2):
        if G.has_edge(source, target):
            G[source][target]["weight"] += 1
        else:
            G.add_edge(source, target, weight=1)

active_nodes = [node for node, degree in dict(G.degree()).items() if degree > 0]
G_active = G.subgraph(active_nodes).copy()

degree_centrality = nx.degree_centrality(G_active)
betweenness_centrality = nx.betweenness_centrality(G_active, weight="weight")

metrics_df = pd.DataFrame(
    {
        "motif": list(G_active.nodes()),
        "motif_family": [G_active.nodes[motif].get("motif_family", "other") for motif in G_active.nodes()],
        "degree_centrality": [degree_centrality[motif] for motif in G_active.nodes()],
        "betweenness_centrality": [betweenness_centrality[motif] for motif in G_active.nodes()],
        "weighted_degree": [G_active.degree(motif, weight="weight") for motif in G_active.nodes()],
    }
).sort_values(["betweenness_centrality", "weighted_degree"], ascending=False)

# ------------------------------------------------------------
# Global motif frequency
# ------------------------------------------------------------

freq_df = (
    motif_df.groupby(["motif", "motif_family"], as_index=False)["count"]
    .sum()
    .rename(columns={"count": "frequency"})
    .sort_values("frequency", ascending=False)
)

# ------------------------------------------------------------
# Early / middle / late phase network metrics
# ------------------------------------------------------------

phase_metrics = []

for phase, subset in motif_df.groupby("phase"):
    H = nx.Graph()

    for motif in sorted(motif_dictionary_df["motif"].unique()):
        H.add_node(motif, motif_family=motif_family.get(motif, "other"))

    for dream_id, group in subset.groupby("dream_id"):
        motifs = sorted(group["motif"].unique())

        for source, target in combinations(motifs, 2):
            if H.has_edge(source, target):
                H[source][target]["weight"] += 1
            else:
                H.add_edge(source, target, weight=1)

    active = [node for node, degree in dict(H.degree()).items() if degree > 0]
    H_active = H.subgraph(active).copy()

    if len(H_active.nodes()) > 1:
        phase_degree = nx.degree_centrality(H_active)
        phase_betweenness = nx.betweenness_centrality(H_active, weight="weight")

        for motif in H_active.nodes():
            phase_metrics.append(
                {
                    "phase": phase,
                    "motif": motif,
                    "motif_family": H_active.nodes[motif].get("motif_family", "other"),
                    "degree_centrality": phase_degree[motif],
                    "betweenness_centrality": phase_betweenness[motif],
                    "weighted_degree": H_active.degree(motif, weight="weight"),
                }
            )

phase_metrics_df = pd.DataFrame(phase_metrics)

# ------------------------------------------------------------
# Track symbolic development over time
# ------------------------------------------------------------

motif_trajectory = (
    motif_df.groupby(["time", "motif", "motif_family"], as_index=False)["count"]
    .sum()
    .rename(columns={"count": "motif_count"})
)

family_trajectory = (
    motif_df.groupby(["time", "motif_family"], as_index=False)["count"]
    .sum()
    .rename(columns={"count": "family_count"})
)

dream_level = (
    motif_df.groupby(["dream_id", "person_id", "time", "phase", "dream_series_type", "motif_family"], as_index=False)["count"]
    .sum()
    .pivot_table(
        index=["dream_id", "person_id", "time", "phase", "dream_series_type"],
        columns="motif_family",
        values="count",
        fill_value=0,
    )
    .reset_index()
)

for col in ["compensatory", "prospective", "structural", "local", "other"]:
    if col not in dream_level.columns:
        dream_level[col] = 0

dream_level["prospective_minus_compensatory"] = (
    dream_level["prospective"] - dream_level["compensatory"]
)

# ------------------------------------------------------------
# Centrality change by phase
# ------------------------------------------------------------

if not phase_metrics_df.empty:
    pivot = phase_metrics_df.pivot_table(
        index=["motif", "motif_family"],
        columns="phase",
        values="betweenness_centrality",
        fill_value=0,
    ).reset_index()

    for phase in ["early", "middle", "late"]:
        if phase not in pivot.columns:
            pivot[phase] = 0

    pivot["late_minus_early"] = pivot["late"] - pivot["early"]
    centrality_change_df = pivot.sort_values("late_minus_early", ascending=False)
else:
    centrality_change_df = pd.DataFrame()

# ------------------------------------------------------------
# Export outputs
# ------------------------------------------------------------

motif_df.to_csv(OUTPUT_DIR / "dream_motif_counts.csv", index=False)
metrics_df.to_csv(OUTPUT_DIR / "dream_symbol_network_metrics.csv", index=False)
freq_df.to_csv(OUTPUT_DIR / "dream_motif_frequency.csv", index=False)
phase_metrics_df.to_csv(OUTPUT_DIR / "dream_phase_network_metrics.csv", index=False)
motif_trajectory.to_csv(OUTPUT_DIR / "dream_motif_trajectory.csv", index=False)
family_trajectory.to_csv(OUTPUT_DIR / "dream_motif_family_trajectory.csv", index=False)
dream_level.to_csv(OUTPUT_DIR / "dream_level_motif_family_scores.csv", index=False)
centrality_change_df.to_csv(OUTPUT_DIR / "dream_motif_centrality_change.csv", index=False)

edge_df = nx.to_pandas_edgelist(G_active)
edge_df.to_csv(OUTPUT_DIR / "dream_symbol_network_edges.csv", index=False)

print("Network metrics")
print(metrics_df)

print("\nMotif frequency")
print(freq_df)

print("\nPhase metrics")
print(phase_metrics_df)

print("\nMotif trajectory")
print(motif_trajectory)

print("\nCentrality change")
print(centrality_change_df)
