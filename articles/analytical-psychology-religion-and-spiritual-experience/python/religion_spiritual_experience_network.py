"""
Analytical Psychology, Religion, and Spiritual Experience
Python Workflow: Dynamic religion and spiritual experience network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, spiritual-direction, theological,
religious-authority, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/analytical-psychology-religion-and-spiritual-experience")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "religion_network_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "religion_network_centrality.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "religion_integration_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "religion_symbolic_balance.csv"

# ------------------------------------------------------------
# Build a simplified religion and spirituality network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "numinous_experience": {"activation": 0.70, "node_type": "sacred_intensity"},
    "ritual_containment": {"activation": 0.60, "node_type": "containment"},
    "symbolic_imagination": {"activation": 0.60, "node_type": "symbolic_capacity"},
    "ego_stability": {"activation": 0.58, "node_type": "ego_capacity"},
    "shadow_awareness": {"activation": 0.42, "node_type": "discernment"},
    "humility": {"activation": 0.46, "node_type": "discernment"},
    "communal_memory": {"activation": 0.52, "node_type": "tradition"},
    "doctrine": {"activation": 0.48, "node_type": "tradition"},
    "living_symbol": {"activation": 0.50, "node_type": "symbolic_capacity"},
    "religious_trauma_pressure": {"activation": 0.30, "node_type": "risk"},
    "doctrinal_rigidity": {"activation": 0.32, "node_type": "risk"},
    "inflation_risk": {"activation": 0.30, "node_type": "risk"},
    "integration": {"activation": 0.40, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("numinous_experience", "symbolic_imagination", 0.50),
    ("numinous_experience", "inflation_risk", 0.50),
    ("numinous_experience", "living_symbol", 0.30),

    ("ritual_containment", "integration", 0.50),
    ("ritual_containment", "inflation_risk", -0.22),
    ("communal_memory", "ritual_containment", 0.34),
    ("communal_memory", "living_symbol", 0.26),
    ("doctrine", "ritual_containment", 0.20),
    ("doctrine", "doctrinal_rigidity", 0.18),

    ("symbolic_imagination", "integration", 0.40),
    ("living_symbol", "integration", 0.36),
    ("ego_stability", "integration", 0.42),
    ("shadow_awareness", "integration", 0.34),
    ("humility", "integration", 0.30),

    ("ego_stability", "inflation_risk", -0.40),
    ("shadow_awareness", "inflation_risk", -0.32),
    ("humility", "inflation_risk", -0.38),
    ("doctrinal_rigidity", "inflation_risk", 0.32),

    ("religious_trauma_pressure", "ego_stability", -0.28),
    ("religious_trauma_pressure", "living_symbol", -0.34),
    ("religious_trauma_pressure", "integration", -0.38),

    ("inflation_risk", "integration", -0.44),
    ("integration", "ego_stability", 0.20),
    ("integration", "shadow_awareness", 0.18),
    ("integration", "humility", 0.16),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(18):
    spiritual_pressure = np.random.normal(0.65, 0.20)
    institutional_pressure = np.random.normal(0.45, 0.16)
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

        if node_type in {"sacred_intensity", "symbolic_capacity"}:
            updated = base + 0.10 * spiritual_pressure + 0.10 * incoming
        elif node_type == "tradition":
            updated = base + 0.06 * institutional_pressure + 0.08 * incoming
        elif node_type == "risk":
            updated = base + 0.08 * spiritual_pressure + 0.10 * incoming
        elif node_type in {"containment", "discernment"}:
            updated = base + 0.08 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Mild stabilizing effect from ritual containment and integration.
    new_activations["inflation_risk"] *= 0.97
    new_activations["ritual_containment"] = min(
        new_activations["ritual_containment"] + 0.02,
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
# Symbolic balance metrics
# ------------------------------------------------------------

results_df["containment_index"] = results_df[
    ["ritual_containment", "ego_stability", "shadow_awareness", "humility"]
].mean(axis=1)

results_df["risk_index"] = results_df[
    ["inflation_risk", "religious_trauma_pressure", "doctrinal_rigidity"]
].mean(axis=1)

results_df["symbolic_vitality_index"] = results_df[
    ["symbolic_imagination", "living_symbol", "communal_memory"]
].mean(axis=1)

results_df["integration_minus_risk"] = (
    results_df["integration"] - results_df["risk_index"]
)

balance_df = results_df[
    [
        "step",
        "numinous_experience",
        "containment_index",
        "symbolic_vitality_index",
        "risk_index",
        "inflation_risk",
        "religious_trauma_pressure",
        "living_symbol",
        "integration",
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
print("\nInputs to integration")
print(integration_input_df)
print("\nSymbolic balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved integration inputs to: {OUT_INTEGRATION_INPUTS}")
print(f"Saved symbolic balance table to: {OUT_BALANCE}")
