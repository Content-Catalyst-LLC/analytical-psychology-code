"""
Trauma, Dissociation, and the Fragmented Psyche
Python Workflow: Dynamic fragmented-psyche network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, crisis-assessment, risk-prediction,
treatment recommendation, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/trauma-dissociation-and-the-fragmented-psyche")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "fragmented_psyche_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "fragmented_psyche_centrality.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "integration_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "fragmentation_integration_balance.csv"

# ------------------------------------------------------------
# Build a simplified trauma and dissociation network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "ego_function": {"activation": 0.62, "node_type": "integration_capacity"},
    "affect": {"activation": 0.76, "node_type": "trauma_pressure"},
    "memory": {"activation": 0.58, "node_type": "fragmented_domain"},
    "body": {"activation": 0.70, "node_type": "fragmented_domain"},
    "symbolization": {"activation": 0.42, "node_type": "symbolic_capacity"},
    "relational_safety": {"activation": 0.54, "node_type": "clinical_vessel"},
    "dissociated_state": {"activation": 0.52, "node_type": "dissociation"},
    "nightmare_intrusion": {"activation": 0.50, "node_type": "intrusion"},
    "memory_continuity": {"activation": 0.36, "node_type": "integration_capacity"},
    "bodily_regulation": {"activation": 0.38, "node_type": "regulation"},
    "witnessing_capacity": {"activation": 0.34, "node_type": "clinical_vessel"},
    "integration": {"activation": 0.32, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("affect", "dissociated_state", 0.60),
    ("memory", "dissociated_state", 0.38),
    ("body", "dissociated_state", 0.48),
    ("nightmare_intrusion", "dissociated_state", 0.34),

    ("dissociated_state", "ego_function", -0.40),
    ("dissociated_state", "symbolization", -0.36),
    ("dissociated_state", "memory_continuity", -0.42),
    ("dissociated_state", "integration", -0.52),

    ("relational_safety", "ego_function", 0.42),
    ("relational_safety", "symbolization", 0.42),
    ("relational_safety", "bodily_regulation", 0.38),
    ("relational_safety", "witnessing_capacity", 0.40),

    ("bodily_regulation", "affect", -0.30),
    ("bodily_regulation", "body", 0.28),
    ("bodily_regulation", "integration", 0.34),

    ("witnessing_capacity", "memory_continuity", 0.34),
    ("witnessing_capacity", "integration", 0.28),
    ("ego_function", "symbolization", 0.34),
    ("ego_function", "memory_continuity", 0.32),

    ("symbolization", "memory_continuity", 0.36),
    ("symbolization", "integration", 0.44),
    ("memory_continuity", "integration", 0.42),
    ("integration", "dissociated_state", -0.30),
    ("integration", "nightmare_intrusion", -0.22),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(24):
    trauma_pressure = np.random.normal(0.65, 0.22)
    recovery_pressure = np.random.normal(0.45, 0.16)
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

        if node_type in {"trauma_pressure", "fragmented_domain", "dissociation", "intrusion"}:
            updated = base + 0.10 * trauma_pressure + 0.10 * incoming
        elif node_type in {"clinical_vessel", "regulation", "symbolic_capacity", "integration_capacity", "outcome"}:
            updated = base + 0.08 * recovery_pressure + 0.10 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Gradual recovery effect through relational safety and witnessing.
    new_activations["relational_safety"] = min(
        new_activations["relational_safety"] + 0.025,
        3.0,
    )
    new_activations["witnessing_capacity"] = min(
        new_activations["witnessing_capacity"] + 0.020,
        3.0,
    )

    # Dissociation and intrusion soften slightly when integration rises.
    new_activations["dissociated_state"] *= 0.975
    new_activations["nightmare_intrusion"] *= 0.985

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
# Fragmentation and integration balance
# ------------------------------------------------------------

results_df["fragmentation_index"] = results_df[
    ["affect", "memory", "body", "dissociated_state", "nightmare_intrusion"]
].mean(axis=1)

results_df["recovery_capacity_index"] = results_df[
    [
        "ego_function",
        "symbolization",
        "relational_safety",
        "memory_continuity",
        "bodily_regulation",
        "witnessing_capacity",
    ]
].mean(axis=1)

results_df["integration_minus_fragmentation"] = (
    results_df["integration"] - results_df["fragmentation_index"]
)

balance_df = results_df[
    [
        "step",
        "fragmentation_index",
        "recovery_capacity_index",
        "affect",
        "dissociated_state",
        "nightmare_intrusion",
        "symbolization",
        "memory_continuity",
        "bodily_regulation",
        "integration",
        "integration_minus_fragmentation",
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
print("\nFragmentation and integration balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved integration inputs to: {OUT_INTEGRATION_INPUTS}")
print(f"Saved fragmentation/integration balance to: {OUT_BALANCE}")
