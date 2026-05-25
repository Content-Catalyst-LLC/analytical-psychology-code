"""
Myth, Symbol, and the Archetypal Imagination
Python Workflow: Archetypal symbol network mapping

This script is a conceptual and educational motif-network demonstration.
It does not prove archetypes, interpret private dreams, classify religions,
rank cultures, automate sacred interpretation, or replace historical,
anthropological, theological, literary, political, or clinical expertise.
"""

from pathlib import Path
from collections import Counter
from itertools import combinations
import re

import pandas as pd
import networkx as nx

ARTICLE_DIR = Path("articles/myth-symbol-and-the-archetypal-imagination")
DATA_PATH = ARTICLE_DIR / "data/raw/myth_symbol_corpus.csv"
DICTIONARY_PATH = ARTICLE_DIR / "data/raw/motif_dictionary.csv"
OUTPUT_TABLES = ARTICLE_DIR / "outputs/tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

# ------------------------------------------------------------
# Load corpus and motif dictionary
# ------------------------------------------------------------

df = pd.read_csv(DATA_PATH)
motif_dictionary_df = pd.read_csv(DICTIONARY_PATH)

term_to_motif = dict(zip(motif_dictionary_df["term"], motif_dictionary_df["motif"]))
motif_to_cluster = dict(zip(motif_dictionary_df["motif"], motif_dictionary_df["cluster"]))

# ------------------------------------------------------------
# Extract motif presence by document
# ------------------------------------------------------------

records = []

for _, row in df.iterrows():
    words = re.findall(r"[a-zA-Z]+", str(row["text"]).lower())
    motif_counts = Counter(term_to_motif[word] for word in words if word in term_to_motif)

    for motif, count in motif_counts.items():
        records.append(
            {
                "doc_id": row["doc_id"],
                "source_type": row["source_type"],
                "culture_group": row["culture_group"],
                "time_period": row["time_period"],
                "title": row["title"],
                "motif": motif,
                "cluster": motif_to_cluster.get(motif, "unknown"),
                "count": count,
            }
        )

motif_df = pd.DataFrame(records)

if motif_df.empty:
    raise ValueError("No motifs found. Check corpus text and motif dictionary.")

# ------------------------------------------------------------
# Build motif co-occurrence graph
# ------------------------------------------------------------

G = nx.Graph()

for motif in sorted(motif_dictionary_df["motif"].unique()):
    G.add_node(motif, cluster=motif_to_cluster.get(motif, "unknown"))

for doc_id, group in motif_df.groupby("doc_id"):
    motifs = sorted(group["motif"].unique())

    for source, target in combinations(motifs, 2):
        if G.has_edge(source, target):
            G[source][target]["weight"] += 1
        else:
            G.add_edge(source, target, weight=1)

non_isolated_nodes = [node for node, degree in dict(G.degree()).items() if degree > 0]
G_active = G.subgraph(non_isolated_nodes).copy()

# ------------------------------------------------------------
# Compute graph metrics
# ------------------------------------------------------------

degree_centrality = nx.degree_centrality(G_active)
betweenness_centrality = nx.betweenness_centrality(G_active, weight="weight")

if len(G_active.nodes()) > 1:
    eigenvector_centrality = nx.eigenvector_centrality(G_active, weight="weight", max_iter=1000)
else:
    eigenvector_centrality = {node: 0.0 for node in G_active.nodes()}

metrics_df = pd.DataFrame(
    {
        "motif": list(G_active.nodes()),
        "cluster": [G_active.nodes[motif].get("cluster", "unknown") for motif in G_active.nodes()],
        "degree_centrality": [degree_centrality[motif] for motif in G_active.nodes()],
        "betweenness_centrality": [betweenness_centrality[motif] for motif in G_active.nodes()],
        "eigenvector_centrality": [eigenvector_centrality[motif] for motif in G_active.nodes()],
        "weighted_degree": [G_active.degree(motif, weight="weight") for motif in G_active.nodes()],
    }
).sort_values(["betweenness_centrality", "weighted_degree"], ascending=False)

# ------------------------------------------------------------
# Frequency and context tables
# ------------------------------------------------------------

frequency_df = (
    motif_df.groupby(["motif", "cluster"], as_index=False)["count"]
    .sum()
    .rename(columns={"count": "frequency"})
    .sort_values("frequency", ascending=False)
)

context_df = (
    motif_df.groupby(["motif", "cluster", "source_type", "culture_group"], as_index=False)["count"]
    .sum()
    .rename(columns={"count": "context_frequency"})
    .sort_values(["motif", "context_frequency"], ascending=[True, False])
)

source_type_df = (
    motif_df.groupby(["source_type", "motif", "cluster"], as_index=False)["count"]
    .sum()
    .rename(columns={"count": "source_frequency"})
    .sort_values(["source_type", "source_frequency"], ascending=[True, False])
)

political_myth_df = (
    motif_df[motif_df["source_type"].str.contains("political", na=False)]
    .groupby(["motif", "cluster"], as_index=False)["count"]
    .sum()
    .rename(columns={"count": "political_frequency"})
    .sort_values("political_frequency", ascending=False)
)

# ------------------------------------------------------------
# Compare source-type subnetworks
# ------------------------------------------------------------

subnetwork_metrics = []

for source_type, subset in motif_df.groupby("source_type"):
    H = nx.Graph()

    for motif in sorted(motif_dictionary_df["motif"].unique()):
        H.add_node(motif, cluster=motif_to_cluster.get(motif, "unknown"))

    for doc_id, group in subset.groupby("doc_id"):
        motifs = sorted(group["motif"].unique())

        for source, target in combinations(motifs, 2):
            if H.has_edge(source, target):
                H[source][target]["weight"] += 1
            else:
                H.add_edge(source, target, weight=1)

    active_nodes = [node for node, degree in dict(H.degree()).items() if degree > 0]
    H_active = H.subgraph(active_nodes).copy()

    if len(H_active.nodes()) > 1:
        centrality = nx.degree_centrality(H_active)

        for motif, value in centrality.items():
            subnetwork_metrics.append(
                {
                    "source_type": source_type,
                    "motif": motif,
                    "cluster": H_active.nodes[motif].get("cluster", "unknown"),
                    "degree_centrality": value,
                    "weighted_degree": H_active.degree(motif, weight="weight"),
                }
            )

subnetwork_df = pd.DataFrame(subnetwork_metrics)

# ------------------------------------------------------------
# Export results
# ------------------------------------------------------------

motif_df.to_csv(OUTPUT_TABLES / "motif_document_counts.csv", index=False)
metrics_df.to_csv(OUTPUT_TABLES / "motif_network_metrics.csv", index=False)
frequency_df.to_csv(OUTPUT_TABLES / "motif_frequency.csv", index=False)
context_df.to_csv(OUTPUT_TABLES / "motif_context_frequency.csv", index=False)
source_type_df.to_csv(OUTPUT_TABLES / "motif_source_type_profile.csv", index=False)
political_myth_df.to_csv(OUTPUT_TABLES / "political_myth_profile.csv", index=False)
subnetwork_df.to_csv(OUTPUT_TABLES / "motif_subnetwork_metrics.csv", index=False)

edge_df = nx.to_pandas_edgelist(G_active)
edge_df.to_csv(OUTPUT_TABLES / "motif_network_edges.csv", index=False)

print("Motif frequency")
print(frequency_df)

print("\nNetwork metrics")
print(metrics_df)

print("\nContext frequencies")
print(context_df)

print("\nPolitical myth profile")
print(political_myth_df)

print("\nSubnetwork metrics")
print(subnetwork_df)
