"""
Active Imagination and the Practice of Symbolic Dialogue
Python Workflow: Dynamic symbolic-dialogue network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, treatment recommendation,
mental-health assessment, crisis intervention, or prediction tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/active-imagination-and-the-practice-of-symbolic-dialogue")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "active_imagination_network_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "active_imagination_network_centrality.csv"
OUT_BALANCE = OUTPUT_TABLES / "active_imagination_dialogue_balance.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "active_imagination_integration_inputs.csv"

# ------------------------------------------------------------
# Build a simplified dialogue network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "ego_presence": {"activation": 1.00, "node_type": "conscious_mediation"},
    "reflective_response": {"activation": 0.80, "node_type": "conscious_mediation"},
    "ethical_judgment": {"activation": 0.62, "node_type": "containment"},
    "shadow_figure": {"activation": 0.50, "node_type": "imaginal_figure"},
    "guide_figure": {"activation": 0.40, "node_type": "imaginal_figure"},
    "child_figure": {"activation": 0.40, "node_type": "imaginal_figure"},
    "trickster_figure": {"activation": 0.34, "node_type": "imaginal_figure"},
    "symbolic_scene": {"activation": 0.60, "node_type": "symbolic_field"},
    "bodily_affect": {"activation": 0.46, "node_type": "embodied_signal"},
    "inflation_risk": {"activation": 0.22, "node_type": "risk"},
    "integration_state": {"activation": 0.30, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("shadow_figure", "symbolic_scene", 0.60),
    ("guide_figure", "symbolic_scene", 0.50),
    ("child_figure", "symbolic_scene", 0.48),
    ("trickster_figure", "symbolic_scene", 0.42),

    ("symbolic_scene", "reflective_response", 0.40),
    ("symbolic_scene", "integration_state", 0.36),
    ("symbolic_scene", "inflation_risk", 0.18),

    ("bodily_affect", "reflective_response", 0.24),
    ("bodily_affect", "integration_state", 0.20),

    ("ego_presence", "reflective_response", 0.50),
    ("ego_presence", "ethical_judgment", 0.46),
    ("ego_presence", "integration_state", 0.30),
    ("ego_presence", "inflation_risk", -0.24),

    ("reflective_response", "integration_state", 0.60),
    ("reflective_response", "inflation_risk", -0.20),

    ("ethical_judgment", "integration_state", 0.34),
    ("ethical_judgment", "inflation_risk", -0.30),

    ("inflation_risk", "integration_state", -0.38),
    ("integration_state", "ego_presence", 0.18),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate symbolic dialogue over time
# ------------------------------------------------------------

history = []

for step in range(16):
    imaginal_pressure = np.random.normal(0.70, 0.20)
    conscious_support = np.random.normal(0.48, 0.14)
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

        if node_type in {"imaginal_figure", "symbolic_field", "embodied_signal"}:
            updated = base + 0.12 * imaginal_pressure + 0.10 * incoming
        elif node_type in {"conscious_mediation", "containment", "outcome"}:
            updated = base + 0.08 * conscious_support + 0.10 * incoming
        elif node_type == "risk":
            updated = base + 0.08 * imaginal_pressure + 0.10 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Repeated dialogue gradually strengthens reflection and ethical containment.
    new_activations["reflective_response"] = min(
        new_activations["reflective_response"] + 0.014,
        3.0,
    )
    new_activations["ethical_judgment"] = min(
        new_activations["ethical_judgment"] + 0.012,
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
# Dialogue balance indices
# ------------------------------------------------------------

results_df["imaginal_activation_index"] = results_df[
    [
        "shadow_figure",
        "guide_figure",
        "child_figure",
        "trickster_figure",
        "symbolic_scene",
        "bodily_affect",
    ]
].mean(axis=1)

results_df["conscious_mediation_index"] = results_df[
    [
        "ego_presence",
        "reflective_response",
        "ethical_judgment",
    ]
].mean(axis=1)

results_df["dialogue_balance"] = (
    results_df["conscious_mediation_index"]
    - results_df["imaginal_activation_index"]
).abs()

results_df["integration_minus_risk"] = (
    results_df["integration_state"]
    - results_df["inflation_risk"]
)

balance_df = results_df[
    [
        "step",
        "imaginal_activation_index",
        "conscious_mediation_index",
        "dialogue_balance",
        "inflation_risk",
        "integration_state",
        "integration_minus_risk",
    ]
]

# ------------------------------------------------------------
# Inputs to integration
# ------------------------------------------------------------

integration_inputs = []

for predecessor in G.predecessors("integration_state"):
    integration_inputs.append(
        {
            "source": predecessor,
            "source_type": G.nodes[predecessor]["node_type"],
            "weight": G[predecessor]["integration_state"]["weight"],
            "final_activation": G.nodes[predecessor]["activation"],
            "weighted_contribution": (
                G.nodes[predecessor]["activation"]
                * G[predecessor]["integration_state"]["weight"]
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
print("\nDialogue balance")
print(balance_df)
print("\nInputs to integration")
print(integration_input_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved dialogue balance to: {OUT_BALANCE}")
print(f"Saved integration inputs to: {OUT_INTEGRATION_INPUTS}")
