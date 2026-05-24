"""
Analytical Psychology and Literary Interpretation
Python Workflow: Literary motifs as a symbolic network

This script is a research-method scaffold for motif co-occurrence and symbolic-network exploration.
It is not an automated interpretation system, author diagnosis, psychological assessment tool,
or empirical proof of archetypes.
"""

from pathlib import Path
from collections import Counter
from itertools import combinations
import re

import pandas as pd
import networkx as nx

ARTICLE_DIR = Path("articles/analytical-psychology-and-literary-interpretation")
CORPUS_PATH = ARTICLE_DIR / "data" / "raw" / "literary_symbol_corpus.csv"
DICTIONARY_PATH = ARTICLE_DIR / "data" / "raw" / "motif_dictionary.csv"
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

corpus = pd.read_csv(CORPUS_PATH)
motif_dictionary = pd.read_csv(DICTIONARY_PATH)

motif_terms = set(motif_dictionary["motif"].dropna().astype(str).str.lower())

def tokenize(text: str) -> list[str]:
    cleaned = re.sub(r"[^a-zA-Z\s]", " ", str(text).lower())
    return [token for token in cleaned.split() if token]

corpus["tokens"] = corpus["text"].apply(tokenize)

# Motif frequencies.
all_tokens = [token for tokens in corpus["tokens"] for token in tokens]
freq_df = (
    pd.DataFrame(
        Counter(token for token in all_tokens if token in motif_terms).items(),
        columns=["motif", "frequency"],
    )
    .sort_values("frequency", ascending=False)
)

# Document-level motif density.
doc_rows = []

for _, row in corpus.iterrows():
    motif_counts = Counter(token for token in row["tokens"] if token in motif_terms)
    total_tokens = len(row["tokens"])

    for motif, count in motif_counts.items():
        doc_rows.append(
            {
                "doc_id": row["doc_id"],
                "genre": row["genre"],
                "period": row["period"],
                "author": row["author"],
                "title": row["title"],
                "motif": motif,
                "count": count,
                "total_tokens": total_tokens,
            }
        )

doc_motif_df = pd.DataFrame(doc_rows)

if doc_motif_df.empty:
    doc_density_df = pd.DataFrame()
else:
    doc_density_df = (
        doc_motif_df
        .groupby(["doc_id", "genre", "period", "author", "title"], as_index=False)
        .agg(total_motifs=("count", "sum"), total_tokens=("total_tokens", "first"))
    )
    doc_density_df["symbolic_density"] = doc_density_df["total_motifs"] / doc_density_df["total_tokens"]
    doc_density_df = doc_density_df.sort_values("symbolic_density", ascending=False)

# Build co-occurrence graph.
G = nx.Graph()

for _, row in corpus.iterrows():
    present_terms = sorted(set(token for token in row["tokens"] if token in motif_terms))

    for motif in present_terms:
        if not G.has_node(motif):
            cluster = motif_dictionary.loc[
                motif_dictionary["motif"].str.lower() == motif,
                "cluster"
            ]
            G.add_node(
                motif,
                frequency=0,
                cluster=cluster.iloc[0] if not cluster.empty else "unknown",
            )

    for token in row["tokens"]:
        if token in motif_terms:
            G.nodes[token]["frequency"] += 1

    for source, target in combinations(present_terms, 2):
        if G.has_edge(source, target):
            G[source][target]["weight"] += 1
        else:
            G.add_edge(source, target, weight=1)

if len(G.nodes) > 0:
    degree_centrality = nx.degree_centrality(G)
    betweenness_centrality = nx.betweenness_centrality(G, weight="weight")
    clustering = nx.clustering(G, weight="weight")

    metrics_df = pd.DataFrame(
        {
            "motif": list(G.nodes()),
            "cluster": [G.nodes[m].get("cluster", "unknown") for m in G.nodes()],
            "frequency": [G.nodes[m].get("frequency", 0) for m in G.nodes()],
            "degree_centrality": [degree_centrality[m] for m in G.nodes()],
            "betweenness_centrality": [betweenness_centrality[m] for m in G.nodes()],
            "clustering": [clustering[m] for m in G.nodes()],
        }
    ).sort_values(
        ["betweenness_centrality", "degree_centrality", "frequency"],
        ascending=False,
    )
else:
    metrics_df = pd.DataFrame()

edge_rows = []

for source, target, attrs in G.edges(data=True):
    edge_rows.append(
        {
            "source": source,
            "target": target,
            "weight": attrs.get("weight", 1),
            "source_cluster": G.nodes[source].get("cluster", "unknown"),
            "target_cluster": G.nodes[target].get("cluster", "unknown"),
        }
    )

edges_df = pd.DataFrame(edge_rows).sort_values("weight", ascending=False) if edge_rows else pd.DataFrame()

# Interpretive caution scores.
if not doc_density_df.empty:
    max_motifs = max(doc_density_df["total_motifs"].max(), 1)
    interpretive_df = doc_density_df.copy()
    interpretive_df["formal_centrality_proxy"] = (interpretive_df["symbolic_density"] * 1.8).clip(upper=1)
    interpretive_df["affective_charge_proxy"] = (interpretive_df["total_motifs"] / max_motifs).clip(upper=1)
    interpretive_df["historical_specificity_proxy"] = interpretive_df["period"].apply(
        lambda period: 0.80 if period in {"traditional", "ancient", "medieval"} else (
            0.75 if period in {"nineteenth_century", "early_modern"} else 0.70
        )
    )
    interpretive_df["reductive_overgeneralization_proxy"] = 0.25
    interpretive_df["interpretive_depth_proxy"] = (
        0.35 * interpretive_df["symbolic_density"]
        + 0.25 * interpretive_df["formal_centrality_proxy"]
        + 0.20 * interpretive_df["affective_charge_proxy"]
        + 0.20 * interpretive_df["historical_specificity_proxy"]
        - 0.30 * interpretive_df["reductive_overgeneralization_proxy"]
    )
    interpretive_df = interpretive_df.sort_values("interpretive_depth_proxy", ascending=False)
else:
    interpretive_df = pd.DataFrame()

freq_df.to_csv(OUTPUT_TABLES / "motif_frequencies.csv", index=False)
doc_motif_df.to_csv(OUTPUT_TABLES / "document_motif_counts.csv", index=False)
doc_density_df.to_csv(OUTPUT_TABLES / "document_symbolic_density.csv", index=False)
metrics_df.to_csv(OUTPUT_TABLES / "motif_network_metrics.csv", index=False)
edges_df.to_csv(OUTPUT_TABLES / "motif_network_edges.csv", index=False)
interpretive_df.to_csv(OUTPUT_TABLES / "interpretive_depth_proxy_scores.csv", index=False)

print("Motif frequencies")
print(freq_df)
print("\nDocument symbolic density")
print(doc_density_df)
print("\nNetwork metrics")
print(metrics_df)
print("\nSymbolic network edges")
print(edges_df)
print("\nInterpretive depth proxy scores")
print(interpretive_df)
print(f"\nSaved outputs to: {OUTPUT_TABLES}")
