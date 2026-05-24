"""
Relational and Developmental Jungian Psychotherapy
Python Workflow: Dynamic relational field network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, treatment recommendation,
therapist-evaluation, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/relational-and-developmental-jungian-psychotherapy")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "relational_field_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "relational_field_centrality.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "developmental_integration_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "relational_symbolic_balance.csv"

# ------------------------------------------------------------
# Build a simplified relational Jungian therapy network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "therapeutic_relationship": {"activation": 0.74, "node_type": "field"},
    "attachment_security": {"activation": 0.48, "node_type": "developmental_capacity"},
    "affect_regulation": {"activation": 0.46, "node_type": "regulation"},
    "rupture_intensity": {"activation": 0.34, "node_type": "field_risk"},
    "repair_capacity": {"activation": 0.38, "node_type": "field_capacity"},
    "symbolization": {"activation": 0.36, "node_type": "symbolic_capacity"},
    "dream_richness": {"activation": 0.30, "node_type": "symbolic_capacity"},
    "fragmentation": {"activation": 0.58, "node_type": "risk"},
    "shame_load": {"activation": 0.52, "node_type": "risk"},
    "embodied_safety": {"activation": 0.42, "node_type": "regulation"},
    "reflective_self": {"activation": 0.36, "node_type": "self_capacity"},
    "developmental_integration": {"activation": 0.30, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("therapeutic_relationship", "attachment_security", 0.50),
    ("therapeutic_relationship", "affect_regulation", 0.46),
    ("therapeutic_relationship", "repair_capacity", 0.42),
    ("therapeutic_relationship", "embodied_safety", 0.36),

    ("attachment_security", "symbolization", 0.36),
    ("attachment_security", "reflective_self", 0.32),
    ("affect_regulation", "symbolization", 0.42),
    ("affect_regulation", "fragmentation", -0.34),
    ("embodied_safety", "affect_regulation", 0.38),
    ("embodied_safety", "fragmentation", -0.26),

    ("rupture_intensity", "fragmentation", 0.34),
    ("rupture_intensity", "shame_load", 0.28),
    ("repair_capacity", "rupture_intensity", -0.36),
    ("repair_capacity", "attachment_security", 0.30),
    ("repair_capacity", "reflective_self", 0.34),

    ("shame_load", "symbolization", -0.30),
    ("shame_load", "reflective_self", -0.28),
    ("fragmentation", "symbolization", -0.34),
    ("fragmentation", "developmental_integration", -0.48),

    ("symbolization", "dream_richness", 0.46),
    ("symbolization", "reflective_self", 0.44),
    ("dream_richness", "reflective_self", 0.24),
    ("reflective_self", "developmental_integration", 0.52),
    ("repair_capacity", "developmental_integration", 0.34),
    ("embodied_safety", "developmental_integration", 0.24),
    ("developmental_integration", "fragmentation", -0.28),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(24):
    treatment_field = np.random.normal(0.62, 0.18)
    rupture_pressure = np.random.normal(0.30, 0.12)
    new_activations = {}

    for node in G.nodes():
        incoming = 0.0

        for predecessor in G.predecessors(node):
            incoming += (
                G.nodes[predecessor]["activation"]
                * G[predecessor][node]["weight"]
            )

        base = G.nodes[node]["activation"]
        node_type = G.nodes[node]["node_type"]

        if node_type in {
            "field",
            "developmental_capacity",
            "regulation",
            "field_capacity",
            "symbolic_capacity",
            "self_capacity",
            "outcome",
        }:
            updated = base + 0.08 * treatment_field + 0.10 * incoming
        elif node_type == "field_risk":
            updated = base + 0.08 * rupture_pressure + 0.08 * incoming
        else:
            updated = base + 0.06 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Gradual stabilizing effect as treatment field strengthens.
    new_activations["therapeutic_relationship"] = min(
        new_activations["therapeutic_relationship"] + 0.015,
        3.0,
    )

    # Fragmentation and shame decline slightly as integration improves.
    new_activations["fragmentation"] *= 0.97
    new_activations["shame_load"] *= 0.985

    for node in G.nodes():
        G.nodes[node]["activation"] = new_activations[node]

    history.append({"step": step, **new_activations})

results_df = pd.DataFrame(history)

# ------------------------------------------------------------
# Centrality metrics
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
# Inputs to developmental integration
# ------------------------------------------------------------

integration_inputs = []

for predecessor in G.predecessors("developmental_integration"):
    integration_inputs.append(
        {
            "source": predecessor,
            "source_type": G.nodes[predecessor]["node_type"],
            "weight": G[predecessor]["developmental_integration"]["weight"],
            "final_activation": G.nodes[predecessor]["activation"],
            "weighted_contribution": (
                G.nodes[predecessor]["activation"]
                * G[predecessor]["developmental_integration"]["weight"]
            ),
        }
    )

integration_input_df = pd.DataFrame(integration_inputs).sort_values(
    "weighted_contribution",
    ascending=False,
)

# ------------------------------------------------------------
# Relational-symbolic balance metrics
# ------------------------------------------------------------

results_df["relational_capacity_index"] = results_df[
    [
        "therapeutic_relationship",
        "attachment_security",
        "affect_regulation",
        "repair_capacity",
        "embodied_safety",
    ]
].mean(axis=1)

results_df["symbolic_capacity_index"] = results_df[
    ["symbolization", "dream_richness", "reflective_self"]
].mean(axis=1)

results_df["risk_index"] = results_df[
    ["fragmentation", "shame_load", "rupture_intensity"]
].mean(axis=1)

results_df["integration_minus_risk"] = (
    results_df["developmental_integration"] - results_df["risk_index"]
)

balance_df = results_df[
    [
        "step",
        "relational_capacity_index",
        "symbolic_capacity_index",
        "risk_index",
        "rupture_intensity",
        "repair_capacity",
        "symbolization",
        "reflective_self",
        "developmental_integration",
        "integration_minus_risk",
    ]
]

results_df.to_csv(OUT_HISTORY, index=False)
centrality_df.to_csv(OUT_CENTRALITY, index=False)
integration_input_df.to_csv(OUT_INTEGRATION_INPUTS, index=False)
balance_df.to_csv(OUT_BALANCE, index=False)

print("Activation history")
print(results_df)
print("\nNetwork centrality")
print(centrality_df)
print("\nInputs to developmental integration")
print(integration_input_df)
print("\nRelational-symbolic balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved developmental integration inputs to: {OUT_INTEGRATION_INPUTS}")
print(f"Saved relational-symbolic balance table to: {OUT_BALANCE}")
