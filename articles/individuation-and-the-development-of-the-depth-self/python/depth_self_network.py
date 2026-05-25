"""
Individuation and the Development of the Depth Self
Python Workflow: Dynamic depth-self integration network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, treatment recommendation,
personality assessment, life prediction, or evaluation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/individuation-and-the-development-of-the-depth-self")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "depth_self_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "depth_self_network_centrality.csv"
OUT_DEPTH_INPUTS = OUTPUT_TABLES / "depth_self_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "individuation_balance.csv"

# ------------------------------------------------------------
# Build a simplified individuation network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "ego": {"activation": 0.82, "node_type": "ego_capacity"},
    "persona": {"activation": 0.88, "node_type": "adaptive_structure"},
    "shadow": {"activation": 0.38, "node_type": "unconscious_content"},
    "complexes": {"activation": 0.52, "node_type": "developmental_pressure"},
    "symbolic_center": {"activation": 0.42, "node_type": "self_symbol"},
    "reflective_capacity": {"activation": 0.62, "node_type": "integration_capacity"},
    "body_awareness": {"activation": 0.40, "node_type": "embodied_capacity"},
    "ethical_accountability": {"activation": 0.44, "node_type": "ethical_capacity"},
    "relational_life": {"activation": 0.50, "node_type": "relational_field"},
    "dream_function": {"activation": 0.46, "node_type": "symbolic_capacity"},
    "depth_self": {"activation": 0.32, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("ego", "persona", 0.36),
    ("ego", "reflective_capacity", 0.48),
    ("ego", "ethical_accountability", 0.30),

    ("persona", "shadow", 0.28),
    ("persona", "complexes", 0.22),

    ("complexes", "shadow", 0.42),
    ("complexes", "dream_function", 0.30),
    ("complexes", "depth_self", -0.24),

    ("shadow", "reflective_capacity", 0.34),
    ("shadow", "ethical_accountability", 0.30),
    ("shadow", "depth_self", 0.42),

    ("symbolic_center", "depth_self", 0.62),
    ("symbolic_center", "reflective_capacity", 0.38),
    ("symbolic_center", "ethical_accountability", 0.28),

    ("dream_function", "symbolic_center", 0.34),
    ("dream_function", "shadow", 0.26),

    ("reflective_capacity", "depth_self", 0.50),
    ("reflective_capacity", "complexes", -0.22),

    ("body_awareness", "depth_self", 0.32),
    ("body_awareness", "reflective_capacity", 0.24),

    ("ethical_accountability", "depth_self", 0.36),
    ("relational_life", "shadow", 0.22),
    ("relational_life", "ethical_accountability", 0.32),
    ("relational_life", "depth_self", 0.28),

    ("depth_self", "ego", 0.28),
    ("depth_self", "persona", -0.18),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(20):
    compensation_pressure = np.random.normal(0.68, 0.20)
    integration_support = np.random.normal(0.46, 0.14)
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
            "unconscious_content",
            "developmental_pressure",
            "self_symbol",
            "symbolic_capacity",
        }:
            updated = base + 0.10 * compensation_pressure + 0.10 * incoming
        elif node_type in {
            "ego_capacity",
            "integration_capacity",
            "embodied_capacity",
            "ethical_capacity",
            "relational_field",
            "outcome",
        }:
            updated = base + 0.08 * integration_support + 0.10 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Individuation gradually relativizes persona dominance.
    new_activations["persona"] *= 0.975

    # Reflective capacity and ethical accountability strengthen through repeated integration.
    new_activations["reflective_capacity"] = min(
        new_activations["reflective_capacity"] + 0.018,
        3.0,
    )
    new_activations["ethical_accountability"] = min(
        new_activations["ethical_accountability"] + 0.014,
        3.0,
    )

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
# Inputs to depth self
# ------------------------------------------------------------

depth_self_inputs = []

for predecessor in G.predecessors("depth_self"):
    depth_self_inputs.append(
        {
            "source": predecessor,
            "source_type": G.nodes[predecessor]["node_type"],
            "weight": G[predecessor]["depth_self"]["weight"],
            "final_activation": G.nodes[predecessor]["activation"],
            "weighted_contribution": (
                G.nodes[predecessor]["activation"]
                * G[predecessor]["depth_self"]["weight"]
            ),
        }
    )

depth_self_input_df = pd.DataFrame(depth_self_inputs).sort_values(
    "weighted_contribution",
    ascending=False,
)

# ------------------------------------------------------------
# Individuation balance
# ------------------------------------------------------------

results_df["adaptive_surface_index"] = results_df[
    ["ego", "persona"]
].mean(axis=1)

results_df["depth_integration_index"] = results_df[
    [
        "shadow",
        "symbolic_center",
        "reflective_capacity",
        "body_awareness",
        "ethical_accountability",
        "relational_life",
        "dream_function",
        "depth_self",
    ]
].mean(axis=1)

results_df["complex_pressure_index"] = results_df[
    ["complexes"]
].mean(axis=1)

results_df["depth_minus_surface"] = (
    results_df["depth_integration_index"] -
    results_df["adaptive_surface_index"]
)

balance_df = results_df[
    [
        "step",
        "adaptive_surface_index",
        "depth_integration_index",
        "complex_pressure_index",
        "depth_minus_surface",
        "ego",
        "persona",
        "shadow",
        "complexes",
        "symbolic_center",
        "reflective_capacity",
        "ethical_accountability",
        "depth_self",
    ]
]

results_df.to_csv(OUT_HISTORY, index=False)
centrality_df.to_csv(OUT_CENTRALITY, index=False)
depth_self_input_df.to_csv(OUT_DEPTH_INPUTS, index=False)
balance_df.to_csv(OUT_BALANCE, index=False)

print("Activation history")
print(results_df)
print("\nNetwork centrality")
print(centrality_df)
print("\nInputs to depth self")
print(depth_self_input_df)
print("\nIndividuation balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved depth-self inputs to: {OUT_DEPTH_INPUTS}")
print(f"Saved individuation balance to: {OUT_BALANCE}")
