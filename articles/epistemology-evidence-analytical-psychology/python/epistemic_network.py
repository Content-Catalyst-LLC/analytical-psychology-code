"""
Epistemology and Evidence in Analytical Psychology
Python Workflow: Jungian knowledge claims as an epistemic network

This script is a conceptual demonstration only.
It is not a clinical, diagnostic, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd

ARTICLE_DIR = Path("articles/epistemology-evidence-analytical-psychology")
OUT_TABLE = ARTICLE_DIR / "outputs" / "tables" / "epistemic_network_metrics.csv"
OUT_SUPPORT = ARTICLE_DIR / "outputs" / "tables" / "claim_support_summary.csv"

G = nx.DiGraph()

nodes = {
    "dream_interpretation": "claim",
    "archetypes": "claim",
    "collective_unconscious": "claim",
    "therapy_outcomes": "claim",
    "comparative_symbolism": "claim",
    "phenomenological_description": "claim",
    "clinical_heuristic": "claim",
    "empirical_support": "warrant",
    "clinical_utility": "warrant",
    "hermeneutic_coherence": "warrant",
    "phenomenological_adequacy": "warrant",
    "contextual_specificity": "warrant",
    "methodological_explicitness": "control",
    "disconfirming_evidence": "control",
    "ambiguity_inflation": "risk",
    "universalizing_force": "risk",
    "selective_evidence": "risk",
}

for node, node_type in nodes.items():
    G.add_node(node, node_type=node_type)

edges = [
    ("empirical_support", "therapy_outcomes", 0.72),
    ("clinical_utility", "therapy_outcomes", 0.54),
    ("clinical_utility", "dream_interpretation", 0.60),
    ("clinical_utility", "clinical_heuristic", 0.68),
    ("hermeneutic_coherence", "dream_interpretation", 0.58),
    ("hermeneutic_coherence", "comparative_symbolism", 0.62),
    ("hermeneutic_coherence", "archetypes", 0.40),
    ("phenomenological_adequacy", "dream_interpretation", 0.52),
    ("phenomenological_adequacy", "phenomenological_description", 0.76),
    ("phenomenological_adequacy", "archetypes", 0.34),
    ("contextual_specificity", "comparative_symbolism", 0.56),
    ("contextual_specificity", "phenomenological_description", 0.44),
    ("methodological_explicitness", "archetypes", 0.46),
    ("methodological_explicitness", "collective_unconscious", 0.40),
    ("methodological_explicitness", "comparative_symbolism", 0.48),
    ("methodological_explicitness", "dream_interpretation", 0.38),
    ("disconfirming_evidence", "methodological_explicitness", 0.52),
    ("ambiguity_inflation", "archetypes", -0.62),
    ("ambiguity_inflation", "collective_unconscious", -0.72),
    ("ambiguity_inflation", "comparative_symbolism", -0.42),
    ("universalizing_force", "comparative_symbolism", -0.48),
    ("universalizing_force", "collective_unconscious", -0.58),
    ("selective_evidence", "comparative_symbolism", -0.52),
    ("selective_evidence", "archetypes", -0.44),
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

claim_inputs = []

for claim in claim_nodes:
    for source, _, data in G.in_edges(claim, data=True):
        claim_inputs.append(
            {
                "claim": claim,
                "input": source,
                "input_type": G.nodes[source]["node_type"],
                "weight": data["weight"],
            }
        )

claim_input_df = pd.DataFrame(claim_inputs)

support_summary = (
    claim_input_df
    .groupby("claim")
    .agg(
        positive_support=("weight", lambda x: x[x > 0].sum()),
        negative_pressure=("weight", lambda x: x[x < 0].sum()),
        net_support=("weight", "sum"),
        number_of_inputs=("weight", "count"),
    )
    .reset_index()
    .sort_values("net_support", ascending=False)
)

OUT_TABLE.parent.mkdir(parents=True, exist_ok=True)
metrics.to_csv(OUT_TABLE, index=False)
support_summary.to_csv(OUT_SUPPORT, index=False)

print("Network metrics")
print(metrics)
print("\nNet synthetic epistemic support by claim")
print(support_summary)
print(f"\nSaved metrics to: {OUT_TABLE}")
print(f"Saved support summary to: {OUT_SUPPORT}")
