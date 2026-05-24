"""
Critiques of Jungian Psychology: Evidence, Culture, and Universality
Python Workflow: Competing-claims critique network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, cultural-ranking, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd

ARTICLE_DIR = Path("articles/critiques-of-jungian-psychology-evidence-culture-and-universality")
OUT_METRICS = ARTICLE_DIR / "outputs" / "tables" / "critique_network_metrics.csv"
OUT_CLAIMS = ARTICLE_DIR / "outputs" / "tables" / "claim_critique_pressure.csv"
OUT_CONTROLS = ARTICLE_DIR / "outputs" / "tables" / "revision_controls.csv"

G = nx.DiGraph()

nodes = {
    "archetypes": "claim",
    "collective_unconscious": "claim",
    "symbolic_interpretation": "claim",
    "individuation": "claim",
    "anima_animus": "claim",
    "synchronicity": "claim",
    "shadow": "claim",
    "persona": "claim",
    "empirical_testability": "critique",
    "cultural_specificity": "critique",
    "gender_essentialism": "critique",
    "universalization_risk": "critique",
    "coloniality_race": "critique",
    "confirmation_bias": "critique",
    "clinical_safety": "critique",
    "clinical_utility": "defense",
    "symbolic_usefulness": "defense",
    "phenomenological_depth": "defense",
    "methodological_explicitness": "control",
    "cultural_humility": "control",
    "gender_critical_revision": "control",
}

for node, node_type in nodes.items():
    G.add_node(node, node_type=node_type)

edges = [
    ("archetypes", "universalization_risk", 0.72),
    ("archetypes", "confirmation_bias", 0.48),
    ("archetypes", "symbolic_usefulness", 0.68),

    ("collective_unconscious", "empirical_testability", 0.82),
    ("collective_unconscious", "universalization_risk", 0.70),
    ("collective_unconscious", "cultural_specificity", 0.54),

    ("symbolic_interpretation", "clinical_utility", 0.58),
    ("symbolic_interpretation", "symbolic_usefulness", 0.76),
    ("symbolic_interpretation", "confirmation_bias", 0.52),

    ("individuation", "phenomenological_depth", 0.62),
    ("individuation", "cultural_specificity", 0.50),

    ("anima_animus", "gender_essentialism", 0.84),
    ("anima_animus", "gender_critical_revision", 0.54),

    ("synchronicity", "empirical_testability", 0.78),
    ("synchronicity", "phenomenological_depth", 0.46),

    ("shadow", "clinical_utility", 0.66),
    ("shadow", "symbolic_usefulness", 0.64),

    ("persona", "clinical_utility", 0.52),
    ("persona", "symbolic_usefulness", 0.56),

    ("coloniality_race", "universalization_risk", 0.46),
    ("cultural_specificity", "universalization_risk", -0.52),
    ("cultural_humility", "universalization_risk", -0.58),
    ("cultural_humility", "coloniality_race", -0.42),
    ("gender_critical_revision", "gender_essentialism", -0.64),
    ("methodological_explicitness", "empirical_testability", -0.36),
    ("methodological_explicitness", "confirmation_bias", -0.48),
    ("methodological_explicitness", "universalization_risk", -0.44),
    ("clinical_safety", "clinical_utility", -0.24),
    ("clinical_utility", "empirical_testability", -0.18),
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

claim_nodes = [
    node for node, attrs in G.nodes(data=True)
    if attrs["node_type"] == "claim"
]

claim_edges = []

for claim in claim_nodes:
    for _, target, data in G.out_edges(claim, data=True):
        claim_edges.append(
            {
                "claim": claim,
                "target": target,
                "target_type": G.nodes[target]["node_type"],
                "weight": data["weight"],
            }
        )

claim_edge_df = pd.DataFrame(claim_edges)

claim_summary = (
    claim_edge_df
    .assign(
        critique_weight=lambda x: x.apply(
            lambda row: row["weight"] if row["target_type"] == "critique" else 0,
            axis=1,
        ),
        defense_weight=lambda x: x.apply(
            lambda row: row["weight"] if row["target_type"] == "defense" else 0,
            axis=1,
        ),
        control_weight=lambda x: x.apply(
            lambda row: row["weight"] if row["target_type"] == "control" else 0,
            axis=1,
        ),
    )
    .groupby("claim")
    .agg(
        critique_pressure=("critique_weight", "sum"),
        defense_support=("defense_weight", "sum"),
        control_revision=("control_weight", "sum"),
        total_outgoing_weight=("weight", "sum"),
        number_of_links=("weight", "count"),
    )
    .reset_index()
    .sort_values("critique_pressure", ascending=False)
)

control_nodes = [
    node for node, attrs in G.nodes(data=True)
    if attrs["node_type"] == "control"
]

control_edges = []

for control in control_nodes:
    for _, target, data in G.out_edges(control, data=True):
        control_edges.append(
            {
                "control": control,
                "target": target,
                "target_type": G.nodes[target]["node_type"],
                "weight": data["weight"],
            }
        )

control_df = pd.DataFrame(control_edges).sort_values("weight")

OUT_METRICS.parent.mkdir(parents=True, exist_ok=True)
metrics.to_csv(OUT_METRICS, index=False)
claim_summary.to_csv(OUT_CLAIMS, index=False)
control_df.to_csv(OUT_CONTROLS, index=False)

print("Critique-network metrics")
print(metrics)
print("\nSynthetic critique pressure by claim")
print(claim_summary)
print("\nControls and revision pathways")
print(control_df)
print(f"\nSaved metrics to: {OUT_METRICS}")
print(f"Saved claim critique pressure to: {OUT_CLAIMS}")
print(f"Saved revision controls to: {OUT_CONTROLS}")
