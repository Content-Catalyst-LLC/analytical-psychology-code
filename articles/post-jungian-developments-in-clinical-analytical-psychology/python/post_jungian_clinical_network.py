"""
Post-Jungian Developments in Clinical Analytical Psychology
Python Workflow: Dynamic clinical evolution network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, treatment recommendation, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/post-jungian-developments-in-clinical-analytical-psychology")
OUT_HISTORY = ARTICLE_DIR / "outputs" / "tables" / "clinical_network_activation_history.csv"
OUT_CENTRALITY = ARTICLE_DIR / "outputs" / "tables" / "clinical_network_centrality.csv"
OUT_ADEQUACY_INPUTS = ARTICLE_DIR / "outputs" / "tables" / "clinical_adequacy_inputs.csv"
OUT_SUMMARY = ARTICLE_DIR / "outputs" / "tables" / "clinical_network_core_revision_risk_summary.csv"

# ------------------------------------------------------------
# Build a simplified post-Jungian clinical network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "symbolic_depth": {"activation": 0.80, "node_type": "jungian_core"},
    "dream_work": {"activation": 0.72, "node_type": "jungian_core"},
    "complex_theory": {"activation": 0.76, "node_type": "jungian_core"},
    "individuation": {"activation": 0.70, "node_type": "jungian_core"},
    "attachment_theory": {"activation": 0.48, "node_type": "developmental_revision"},
    "developmental_precision": {"activation": 0.50, "node_type": "developmental_revision"},
    "relational_field": {"activation": 0.58, "node_type": "relational_revision"},
    "countertransference": {"activation": 0.54, "node_type": "relational_revision"},
    "trauma_sensitivity": {"activation": 0.52, "node_type": "trauma_revision"},
    "dissociation_awareness": {"activation": 0.46, "node_type": "trauma_revision"},
    "embodied_regulation": {"activation": 0.44, "node_type": "embodied_revision"},
    "cultural_responsiveness": {"activation": 0.42, "node_type": "critical_revision"},
    "clinical_adequacy": {"activation": 0.40, "node_type": "outcome"},
    "symbolic_readiness": {"activation": 0.38, "node_type": "outcome"},
    "doctrinal_rigidity": {"activation": 0.34, "node_type": "risk"},
    "abstraction_risk": {"activation": 0.30, "node_type": "risk"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("symbolic_depth", "clinical_adequacy", 0.34),
    ("dream_work", "symbolic_depth", 0.32),
    ("complex_theory", "clinical_adequacy", 0.28),
    ("individuation", "clinical_adequacy", 0.30),

    ("attachment_theory", "developmental_precision", 0.50),
    ("developmental_precision", "symbolic_readiness", 0.42),
    ("developmental_precision", "clinical_adequacy", 0.44),

    ("relational_field", "clinical_adequacy", 0.48),
    ("countertransference", "relational_field", 0.46),
    ("relational_field", "symbolic_depth", 0.22),
    ("symbolic_depth", "relational_field", 0.22),

    ("trauma_sensitivity", "clinical_adequacy", 0.52),
    ("trauma_sensitivity", "symbolic_readiness", 0.46),
    ("dissociation_awareness", "trauma_sensitivity", 0.44),
    ("dissociation_awareness", "symbolic_readiness", 0.36),

    ("embodied_regulation", "symbolic_readiness", 0.42),
    ("embodied_regulation", "clinical_adequacy", 0.34),

    ("cultural_responsiveness", "clinical_adequacy", 0.32),
    ("cultural_responsiveness", "abstraction_risk", -0.30),

    ("doctrinal_rigidity", "clinical_adequacy", -0.42),
    ("doctrinal_rigidity", "abstraction_risk", 0.48),
    ("abstraction_risk", "clinical_adequacy", -0.34),
    ("symbolic_readiness", "clinical_adequacy", 0.38),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(18):
    field_pressure = np.random.normal(0.65, 0.20)
    clinical_pressure = np.random.normal(0.55, 0.18)
    new_activations = {}

    for node in G.nodes():
        incoming = 0.0

        for predecessor in G.predecessors(node):
            incoming += (
                G.nodes[predecessor]["activation"] *
                G[predecessor][node]["weight"]
            )

        base = G.nodes[node]["activation"]
        node_type = G.nodes[node]["node_type"]

        if node_type in {
            "developmental_revision",
            "relational_revision",
            "trauma_revision",
            "embodied_revision",
            "critical_revision",
        }:
            updated = base + 0.10 * field_pressure + 0.10 * incoming
        elif node_type == "jungian_core":
            updated = base + 0.05 * field_pressure + 0.08 * incoming
        elif node_type == "risk":
            updated = base + 0.03 * clinical_pressure + 0.08 * incoming
        else:
            updated = base + 0.09 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    for node in G.nodes():
        G.nodes[node]["activation"] = new_activations[node]

    history.append({"step": step, **new_activations})

results_df = pd.DataFrame(history)

# ------------------------------------------------------------
# Compute centrality metrics
# ------------------------------------------------------------

centrality_df = pd.DataFrame(
    {
        "node": list(G.nodes()),
        "node_type": [G.nodes[n]["node_type"] for n in G.nodes()],
        "betweenness": list(nx.betweenness_centrality(G, weight="weight").values()),
        "degree_centrality": list(nx.degree_centrality(G).values()),
        "out_degree": [G.out_degree(n) for n in G.nodes()],
        "in_degree": [G.in_degree(n) for n in G.nodes()],
        "final_activation": [G.nodes[n]["activation"] for n in G.nodes()],
    }
).sort_values(["betweenness", "degree_centrality"], ascending=False)

# ------------------------------------------------------------
# Inspect inputs to clinical adequacy
# ------------------------------------------------------------

adequacy_inputs = []

for predecessor in G.predecessors("clinical_adequacy"):
    adequacy_inputs.append(
        {
            "source": predecessor,
            "source_type": G.nodes[predecessor]["node_type"],
            "weight": G[predecessor]["clinical_adequacy"]["weight"],
            "final_activation": G.nodes[predecessor]["activation"],
            "weighted_contribution": (
                G.nodes[predecessor]["activation"]
                * G[predecessor]["clinical_adequacy"]["weight"]
            ),
        }
    )

adequacy_input_df = pd.DataFrame(adequacy_inputs).sort_values(
    "weighted_contribution",
    ascending=False,
)

# ------------------------------------------------------------
# Compare Jungian core, revision nodes, and risk nodes
# ------------------------------------------------------------

core_nodes = [
    "symbolic_depth",
    "dream_work",
    "complex_theory",
    "individuation",
]

revision_nodes = [
    "attachment_theory",
    "developmental_precision",
    "relational_field",
    "countertransference",
    "trauma_sensitivity",
    "dissociation_awareness",
    "embodied_regulation",
    "cultural_responsiveness",
]

risk_nodes = [
    "doctrinal_rigidity",
    "abstraction_risk",
]

results_df["jungian_core_activation"] = results_df[core_nodes].mean(axis=1)
results_df["revision_activation"] = results_df[revision_nodes].mean(axis=1)
results_df["risk_activation"] = results_df[risk_nodes].mean(axis=1)
results_df["revision_minus_risk"] = (
    results_df["revision_activation"] -
    results_df["risk_activation"]
)

summary_df = results_df[
    [
        "step",
        "jungian_core_activation",
        "revision_activation",
        "risk_activation",
        "revision_minus_risk",
        "symbolic_readiness",
        "clinical_adequacy",
    ]
]

OUT_HISTORY.parent.mkdir(parents=True, exist_ok=True)
results_df.to_csv(OUT_HISTORY, index=False)
centrality_df.to_csv(OUT_CENTRALITY, index=False)
adequacy_input_df.to_csv(OUT_ADEQUACY_INPUTS, index=False)
summary_df.to_csv(OUT_SUMMARY, index=False)

print("Activation history")
print(results_df)
print("\nNetwork centrality")
print(centrality_df)
print("\nInputs to clinical adequacy")
print(adequacy_input_df)
print("\nCore, revision, and risk summary")
print(summary_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved adequacy inputs to: {OUT_ADEQUACY_INPUTS}")
print(f"Saved summary to: {OUT_SUMMARY}")
