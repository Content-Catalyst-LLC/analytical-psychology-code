"""
What Is Analytical Psychology?
Python Workflow: Semantic clustering and symbolic networks

Synthetic-data demonstration only.
Not for diagnosis, therapy, private dream interpretation, psychological
assessment, employment screening, or individual prediction.
"""

from pathlib import Path
from itertools import combinations
import re

import pandas as pd
import networkx as nx
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.cluster import AgglomerativeClustering
from sklearn.metrics.pairwise import cosine_similarity

ARTICLE_DIR = Path("articles/what-is-analytical-psychology")
DATA_DIR = ARTICLE_DIR / "data/raw"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

df = pd.read_csv(DATA_DIR / "symbolic_corpus.csv")
dictionary = pd.read_csv(DATA_DIR / "symbol_dictionary.csv")
concepts = pd.read_csv(DATA_DIR / "analytical_psychology_concepts.csv")

symbol_terms = set(dictionary["symbol"].tolist())
symbol_clusters = dict(zip(dictionary["symbol"], dictionary["cluster"]))

# ------------------------------------------------------------
# 1. Preprocess text
# ------------------------------------------------------------

def preprocess_text(text: str) -> str:
    tokens = re.findall(r"[a-z]+", str(text).lower())
    return " ".join(tokens)

df["clean_text"] = df["text"].apply(preprocess_text)

# ------------------------------------------------------------
# 2. TF-IDF representation and clustering
# ------------------------------------------------------------

vectorizer = TfidfVectorizer(max_features=500, ngram_range=(1, 2))
tfidf_matrix = vectorizer.fit_transform(df["clean_text"])

similarity_matrix = cosine_similarity(tfidf_matrix)

n_clusters = min(5, max(2, len(df) // 4))
cluster_model = AgglomerativeClustering(
    n_clusters=n_clusters,
    metric="euclidean",
    linkage="ward"
)

df["symbolic_cluster"] = cluster_model.fit_predict(tfidf_matrix.toarray())

# ------------------------------------------------------------
# 3. Build symbolic co-occurrence network
# ------------------------------------------------------------

G = nx.Graph()
symbol_rows = []

for _, row in df.iterrows():
    tokens = set(row["clean_text"].split())
    present_terms = sorted(symbol_terms.intersection(tokens))

    for term in present_terms:
        G.add_node(term, cluster=symbol_clusters.get(term, "unknown"))
        symbol_rows.append(
            {
                "document_id": row["document_id"],
                "source_type": row["source_type"],
                "phase": row["phase"],
                "symbol": term,
                "cluster": symbol_clusters.get(term, "unknown"),
            }
        )

    for source, target in combinations(present_terms, 2):
        if G.has_edge(source, target):
            G[source][target]["weight"] += 1
        else:
            G.add_edge(source, target, weight=1)

symbol_df = pd.DataFrame(symbol_rows)

# ------------------------------------------------------------
# 4. Network metrics
# ------------------------------------------------------------

degree_centrality = nx.degree_centrality(G)
betweenness_centrality = nx.betweenness_centrality(G, weight="weight")
weighted_degree = dict(G.degree(weight="weight"))

centrality_df = pd.DataFrame(
    {
        "symbol": list(G.nodes()),
        "cluster": [G.nodes[s]["cluster"] for s in G.nodes()],
        "degree_centrality": [degree_centrality[s] for s in G.nodes()],
        "betweenness_centrality": [betweenness_centrality[s] for s in G.nodes()],
        "weighted_degree": [weighted_degree[s] for s in G.nodes()],
    }
).sort_values(["betweenness_centrality", "weighted_degree"], ascending=[False, False])

cluster_summary = (
    centrality_df.groupby("cluster", as_index=False)
    .agg(
        symbol_count=("symbol", "count"),
        mean_degree_centrality=("degree_centrality", "mean"),
        mean_betweenness_centrality=("betweenness_centrality", "mean"),
        mean_weighted_degree=("weighted_degree", "mean"),
    )
    .sort_values("mean_betweenness_centrality", ascending=False)
)

source_symbol_summary = (
    symbol_df.groupby(["source_type", "cluster", "symbol"], as_index=False)
    .size()
    .rename(columns={"size": "count"})
    .sort_values(["source_type", "count"], ascending=[True, False])
)

phase_symbol_summary = (
    symbol_df.groupby(["phase", "cluster"], as_index=False)
    .size()
    .rename(columns={"size": "count"})
    .sort_values(["phase", "count"], ascending=[True, False])
)

# ------------------------------------------------------------
# 5. Export outputs
# ------------------------------------------------------------

df.to_csv(OUTPUT_DIR / "symbolic_corpus_clusters.csv", index=False)
symbol_df.to_csv(OUTPUT_DIR / "symbol_document_membership.csv", index=False)
centrality_df.to_csv(OUTPUT_DIR / "symbol_network_centrality.csv", index=False)
cluster_summary.to_csv(OUTPUT_DIR / "symbol_cluster_summary.csv", index=False)
source_symbol_summary.to_csv(OUTPUT_DIR / "source_symbol_summary.csv", index=False)
phase_symbol_summary.to_csv(OUTPUT_DIR / "phase_symbol_summary.csv", index=False)
concepts.to_csv(OUTPUT_DIR / "analytical_psychology_concepts.csv", index=False)
nx.to_pandas_edgelist(G).to_csv(OUTPUT_DIR / "symbol_network_edges.csv", index=False)

print("\nSymbolic corpus with clusters")
print(df[["document_id", "source_type", "phase", "symbolic_cluster", "text"]])

print("\nSymbol centrality")
print(centrality_df)

print("\nCluster summary")
print(cluster_summary)

print("\nInterpretive guardrails:")
print("- Symbol clustering is not proof of archetypal universality.")
print("- Personal association and cultural context come before amplification.")
print("- Similar symbols may function differently across traditions.")
print("- Model outputs support interpretation; they do not replace it.")
