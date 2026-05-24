"""
Jung, Alchemy, and Symbolic Transformation
Python Workflow: Dynamic alchemical opus symbol network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, treatment recommendation, spiritual-direction,
or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/jung-alchemy-and-symbolic-transformation")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "alchemical_network_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "alchemical_network_centrality.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "integration_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "transformation_balance.csv"

# ------------------------------------------------------------
# Build a simplified alchemical transformation network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "nigredo": {"activation": 0.64, "node_type": "stage"},
    "albedo": {"activation": 0.42, "node_type": "stage"},
    "rubedo": {"activation": 0.34, "node_type": "stage"},
    "mercurius": {"activation": 0.58, "node_type": "mediator"},
    "opposition_x": {"activation": 0.66, "node_type": "opposition"},
    "opposition_y": {"activation": 0.62, "node_type": "opposition"},
    "vessel": {"activation": 0.52, "node_type": "containment"},
    "shadow_material": {"activation": 0.70, "node_type": "prima_materia"},
    "coniunctio": {"activation": 0.30, "node_type": "relation"},
    "integration": {"activation": 0.28, "node_type": "outcome"},
    "vessel_failure": {"activation": 0.20, "node_type": "risk"},
    "philosophers_stone": {"activation": 0.18, "node_type": "totality_symbol"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("shadow_material", "nigredo", 0.50),
    ("nigredo", "albedo", 0.40),
    ("albedo", "rubedo", 0.50),
    ("rubedo", "integration", 0.62),
    ("opposition_x", "coniunctio", -0.20),
    ("opposition_y", "coniunctio", -0.20),
    ("mercurius", "coniunctio", 0.38),
    ("mercurius", "vessel_failure", 0.30),
    ("vessel", "albedo", 0.36),
    ("vessel", "coniunctio", 0.44),
    ("vessel", "integration", 0.48),
    ("vessel", "vessel_failure", -0.52),
    ("coniunctio", "integration", 0.54),
    ("albedo", "integration", 0.28),
    ("nigredo", "vessel_failure", 0.24),
    ("shadow_material", "vessel_failure", 0.26),
    ("integration", "philosophers_stone", 0.46),
    ("rubedo", "philosophers_stone", 0.34),
    ("vessel", "philosophers_stone", 0.22),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(18):
    opus_pressure = np.random.normal(0.65, 0.20)
    heat = np.random.normal(0.50, 0.15)
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

        if node_type == "stage":
            updated = base + 0.10 * opus_pressure + 0.10 * incoming
        elif node_type == "mediator":
            updated = base + 0.08 * opus_pressure + 0.08 * incoming
        elif node_type == "containment":
            updated = base + 0.04 * opus_pressure + 0.08 * incoming
        elif node_type == "risk":
            updated = base + 0.08 * heat + 0.10 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Containment gradually strengthens if it does not fail.
    new_activations["vessel"] = min(new_activations["vessel"] + 0.03, 3.0)

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
# Inputs to integration
# ------------------------------------------------------------

integration_inputs = []

for predecessor in G.predecessors("integration"):
    integration_inputs.append(
        {
            "source": predecessor,
            "source_type": G.nodes[predecessor]["node_type"],
            "weight": G[predecessor]["integration"]["weight"],
            "final_activation": G.nodes[predecessor]["activation"],
            "weighted_contribution": (
                G.nodes[predecessor]["activation"]
                * G[predecessor]["integration"]["weight"]
            ),
        }
    )

integration_input_df = pd.DataFrame(integration_inputs).sort_values(
    "weighted_contribution",
    ascending=False,
)

# ------------------------------------------------------------
# Transformation balance
# ------------------------------------------------------------

results_df["stage_activation"] = results_df[["nigredo", "albedo", "rubedo"]].mean(axis=1)
results_df["opposition_pressure"] = results_df[["opposition_x", "opposition_y"]].mean(axis=1)
results_df["containment_minus_failure"] = results_df["vessel"] - results_df["vessel_failure"]
results_df["integration_minus_opposition"] = results_df["integration"] - results_df["opposition_pressure"]

balance_df = results_df[
    [
        "step",
        "stage_activation",
        "opposition_pressure",
        "vessel",
        "vessel_failure",
        "containment_minus_failure",
        "coniunctio",
        "integration",
        "philosophers_stone",
        "integration_minus_opposition",
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
print("\nInputs to integration")
print(integration_input_df)
print("\nTransformation balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved integration inputs to: {OUT_INTEGRATION_INPUTS}")
print(f"Saved balance table to: {OUT_BALANCE}")
