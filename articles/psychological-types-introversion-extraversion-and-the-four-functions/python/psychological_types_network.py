"""
Psychological Types: Introversion, Extraversion, and the Four Functions
Python Workflow: Functional type differentiation network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, personality assessment,
hiring, screening, treatment recommendation, or prediction tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/psychological-types-introversion-extraversion-and-the-four-functions")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "type_network_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "type_network_centrality.csv"
OUT_BALANCE = OUTPUT_TABLES / "type_network_balance.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "type_network_integration_inputs.csv"

# ------------------------------------------------------------
# Build a simplified type network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "ego": {"activation": 1.00, "node_type": "conscious_center"},
    "thinking": {"activation": 0.90, "node_type": "judging_function"},
    "feeling": {"activation": 0.40, "node_type": "judging_function"},
    "sensation": {"activation": 0.62, "node_type": "perceiving_function"},
    "intuition": {"activation": 0.52, "node_type": "perceiving_function"},
    "introversion": {"activation": 0.70, "node_type": "attitude"},
    "extraversion": {"activation": 0.30, "node_type": "attitude"},
    "inferior_activation": {"activation": 0.20, "node_type": "unconscious_pressure"},
    "reflective_capacity": {"activation": 0.44, "node_type": "integration_capacity"},
    "symbolic_relation": {"activation": 0.38, "node_type": "symbolic_capacity"},
    "developmental_integration": {"activation": 0.30, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("ego", "thinking", 0.50),
    ("ego", "sensation", 0.30),
    ("ego", "intuition", 0.22),
    ("ego", "feeling", 0.18),

    ("introversion", "ego", 0.40),
    ("extraversion", "ego", 0.16),

    ("thinking", "ego", 0.30),
    ("thinking", "developmental_integration", 0.20),

    ("feeling", "inferior_activation", 0.70),
    ("feeling", "developmental_integration", 0.30),

    ("intuition", "inferior_activation", 0.40),
    ("intuition", "symbolic_relation", 0.34),

    ("sensation", "inferior_activation", 0.30),
    ("sensation", "developmental_integration", 0.22),

    ("inferior_activation", "ego", -0.24),
    ("inferior_activation", "symbolic_relation", 0.42),

    ("symbolic_relation", "reflective_capacity", 0.34),
    ("symbolic_relation", "developmental_integration", 0.42),

    ("reflective_capacity", "inferior_activation", -0.28),
    ("reflective_capacity", "developmental_integration", 0.48),

    ("developmental_integration", "ego", 0.28),
    ("developmental_integration", "inferior_activation", -0.18),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over developmental time
# ------------------------------------------------------------

history = []

for step in range(16):
    unconscious_pressure = np.random.normal(0.70, 0.20)
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

        if node_type == "unconscious_pressure":
            updated = base + 0.18 * unconscious_pressure + 0.10 * incoming
        elif node_type in {"integration_capacity", "symbolic_capacity", "outcome"}:
            updated = base + 0.08 * integration_support + 0.10 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Development gradually strengthens reflective capacity and symbolic relation.
    new_activations["reflective_capacity"] = min(
        new_activations["reflective_capacity"] + 0.015,
        3.0,
    )
    new_activations["symbolic_relation"] = min(
        new_activations["symbolic_relation"] + 0.012,
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
# Function balance indices
# ------------------------------------------------------------

results_df["dominant_function_index"] = results_df[
    ["thinking"]
].mean(axis=1)

results_df["less_developed_function_index"] = results_df[
    ["feeling", "sensation", "intuition"]
].mean(axis=1)

results_df["attitude_index"] = results_df["introversion"] - results_df["extraversion"]

results_df["function_gap"] = (
    results_df["dominant_function_index"]
    - results_df["less_developed_function_index"]
)

results_df["integration_minus_inferior_pressure"] = (
    results_df["developmental_integration"]
    - results_df["inferior_activation"]
)

balance_df = results_df[
    [
        "step",
        "dominant_function_index",
        "less_developed_function_index",
        "function_gap",
        "attitude_index",
        "inferior_activation",
        "reflective_capacity",
        "symbolic_relation",
        "developmental_integration",
        "integration_minus_inferior_pressure",
    ]
]

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

results_df.to_csv(OUT_HISTORY, index=False)
centrality_df.to_csv(OUT_CENTRALITY, index=False)
balance_df.to_csv(OUT_BALANCE, index=False)
integration_input_df.to_csv(OUT_INTEGRATION_INPUTS, index=False)

print("Activation history")
print(results_df)
print("\nNetwork centrality")
print(centrality_df)
print("\nType balance")
print(balance_df)
print("\nInputs to developmental integration")
print(integration_input_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved type balance to: {OUT_BALANCE}")
print(f"Saved integration inputs to: {OUT_INTEGRATION_INPUTS}")
