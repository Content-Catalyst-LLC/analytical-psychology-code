"""
Python Workflow: Archetypal motifs as semantic networks

Synthetic methods demonstration only. This script does not prove archetypes,
diagnose people, interpret private dreams, or replace scholarly interpretation.
"""

from pathlib import Path
from collections import Counter
from itertools import combinations
import re

import pandas as pd
import networkx as nx

ARTICLE_DIR = Path("articles/what-is-an-archetype-pattern-image-and-psychic-structure")
DATA_DIR = ARTICLE_DIR / "data/raw"
OUTPUT_TABLES = ARTICLE_DIR / "outputs/tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

df = pd.read_csv(DATA_DIR / "archetypal_corpus.csv")
motif_dictionary = pd.read_csv(DATA_DIR / "motif_dictionary.csv")
motif_terms = set(motif_dictionary["motif"].str.lower())

def tokenize(text: str) -> list[str]:
    return re.findall(r"[a-z]+", str(text).lower())

doc_rows = []

for _, row in df.iterrows():
    tokens = tokenize(row["text"])
    motif_counts = Counter(token for token in tokens if token in motif_terms)

    for motif, count in motif_counts.items():
        doc_rows.append(
            {
                "doc_id": row["doc_id"],
                "source_type": row["source_type"],
                "culture_group": row["culture_group"],
                "motif": motif,
                "count": count,
            }
        )

motif_df = pd.DataFrame(doc_rows)

if motif_df.empty:
    raise ValueError("No motif terms were found in the corpus.")

motif_df.to_csv(OUTPUT_TABLES / "motif_document_counts.csv", index=False)

summary_df = (
    motif_df.groupby(["source_type", "culture_group", "motif"], as_index=False)["count"]
    .sum()
    .sort_values(["count", "source_type", "culture_group"], ascending=[False, True, True])
)

summary_df.to_csv(OUTPUT_TABLES / "motif_summary_by_context.csv", index=False)

G = nx.Graph()

for _, row in df.iterrows():
    tokens = tokenize(row["text"])
    present_terms = sorted(set(token for token in tokens if token in motif_terms))

    for motif in present_terms:
        if not G.has_node(motif):
            cluster_series = motif_dictionary.loc[motif_dictionary["motif"] == motif, "cluster"]
            G.add_node(motif, cluster=cluster_series.iloc[0] if not cluster_series.empty else "unknown")

    for source, target in combinations(present_terms, 2):
        if G.has_edge(source, target):
            G[source][target]["weight"] += 1
        else:
            G.add_edge(source, target, weight=1)

degree_centrality = nx.degree_centrality(G)
betweenness_centrality = nx.betweenness_centrality(G, weight="weight")
weighted_degree = dict(G.degree(weight="weight"))

metrics_df = pd.DataFrame(
    {
        "motif": list(G.nodes()),
        "cluster": [G.nodes[m].get("cluster", "unknown") for m in G.nodes()],
        "degree_centrality": [degree_centrality[m] for m in G.nodes()],
        "betweenness_centrality": [betweenness_centrality[m] for m in G.nodes()],
        "weighted_degree": [weighted_degree[m] for m in G.nodes()],
    }
).sort_values(
    ["betweenness_centrality", "weighted_degree"],
    ascending=[False, False],
)

metrics_df.to_csv(OUTPUT_TABLES / "motif_network_metrics.csv", index=False)

component_rows = []

for component_id, component in enumerate(nx.connected_components(G), start=1):
    for motif in sorted(component):
        component_rows.append({"component_id": component_id, "motif": motif})

components_df = pd.DataFrame(component_rows)
components_df.to_csv(OUTPUT_TABLES / "motif_components.csv", index=False)

edges_df = nx.to_pandas_edgelist(G)
edges_df.to_csv(OUTPUT_TABLES / "motif_network_edges.csv", index=False)

context_matrix = (
    motif_df.pivot_table(
        index="motif",
        columns="source_type",
        values="count",
        aggfunc="sum",
        fill_value=0,
    )
    .reset_index()
)

context_matrix.to_csv(OUTPUT_TABLES / "motif_by_source_matrix.csv", index=False)

cluster_summary = (
    metrics_df.groupby("cluster", as_index=False)
    .agg(
        motif_count=("motif", "count"),
        mean_degree_centrality=("degree_centrality", "mean"),
        mean_betweenness_centrality=("betweenness_centrality", "mean"),
        mean_weighted_degree=("weighted_degree", "mean"),
    )
    .sort_values("mean_weighted_degree", ascending=False)
)

cluster_summary.to_csv(OUTPUT_TABLES / "motif_cluster_summary.csv", index=False)

print("\nMotif metrics")
print(metrics_df)
print("\nMotif summary by context")
print(summary_df)
print("\nCluster summary")
print(cluster_summary)
print("\nGuardrails:")
print("- Co-occurrence is not proof of archetypal universality.")
print("- Motif recurrence must be compared against genre, transmission, culture, and context.")
print("- Network clusters support interpretation; they do not replace it.")
