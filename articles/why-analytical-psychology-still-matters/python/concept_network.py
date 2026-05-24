"""
Why Analytical Psychology Still Matters
Python Workflow: Concept network model

This script is a conceptual demonstration only.
It is not a diagnostic, clinical, or psychological assessment tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd

ARTICLE_DIR = Path("articles/why-analytical-psychology-still-matters")
OUT_TABLE = ARTICLE_DIR / "outputs" / "tables" / "concept_network_metrics.csv"

G = nx.DiGraph()

nodes = {
    "symbolic_depth": "resource",
    "dream_life": "resource",
    "meaning_coherence": "resource",
    "shadow_awareness": "resource",
    "cultural_interpretation": "resource",
    "clinical_utility": "resource",
    "spiritual_seriousness": "resource",
    "revision_capacity": "resource",
    "trauma_informed_revision": "revision",
    "gender_critical_revision": "revision",
    "historical_cultural_humility": "revision",
    "symbolic_loss": "modern_pressure",
    "projection_intensity": "modern_pressure",
    "existential_dislocation": "modern_pressure",
    "institutional_mistrust": "modern_pressure",
    "doctrinal_rigidity": "risk",
    "symbolic_overreach": "risk",
    "contemporary_relevance": "outcome",
}

for node, node_type in nodes.items():
    G.add_node(node, node_type=node_type)

edges = [
    ("symbolic_depth", "meaning_coherence", 0.55),
    ("dream_life", "meaning_coherence", 0.42),
    ("shadow_awareness", "clinical_utility", 0.46),
    ("cultural_interpretation", "contemporary_relevance", 0.45),
    ("meaning_coherence", "contemporary_relevance", 0.62),
    ("clinical_utility", "contemporary_relevance", 0.56),
    ("spiritual_seriousness", "contemporary_relevance", 0.40),
    ("revision_capacity", "contemporary_relevance", 0.65),
    ("trauma_informed_revision", "revision_capacity", 0.48),
    ("gender_critical_revision", "revision_capacity", 0.38),
    ("historical_cultural_humility", "revision_capacity", 0.52),
    ("symbolic_loss", "contemporary_relevance", 0.34),
    ("projection_intensity", "contemporary_relevance", 0.32),
    ("existential_dislocation", "contemporary_relevance", 0.42),
    ("institutional_mistrust", "contemporary_relevance", 0.28),
    ("doctrinal_rigidity", "contemporary_relevance", -0.64),
    ("symbolic_overreach", "contemporary_relevance", -0.50),
    ("doctrinal_rigidity", "revision_capacity", -0.42),
    ("symbolic_overreach", "clinical_utility", -0.25),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

degree = nx.degree_centrality(G)
in_degree = nx.in_degree_centrality(G)
out_degree = nx.out_degree_centrality(G)
betweenness = nx.betweenness_centrality(G, weight="weight")

metrics = pd.DataFrame(
    {
        "node": list(G.nodes()),
        "node_type": [G.nodes[n]["node_type"] for n in G.nodes()],
        "degree_centrality": [degree[n] for n in G.nodes()],
        "in_degree_centrality": [in_degree[n] for n in G.nodes()],
        "out_degree_centrality": [out_degree[n] for n in G.nodes()],
        "betweenness_centrality": [betweenness[n] for n in G.nodes()],
    }
).sort_values(["betweenness_centrality", "degree_centrality"], ascending=False)

OUT_TABLE.parent.mkdir(parents=True, exist_ok=True)
metrics.to_csv(OUT_TABLE, index=False)

print(metrics)
print(f"\nSaved metrics to: {OUT_TABLE}")
