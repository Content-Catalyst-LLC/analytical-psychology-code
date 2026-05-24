"""
Numinous Experience, Spiritual Emergency, and Symbolic Crisis
Python Workflow: Dynamic numinous crisis network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, treatment recommendation, spiritual-direction,
crisis-intervention, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/numinous-experience-spiritual-emergency-and-symbolic-crisis")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "numinous_network_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "numinous_network_centrality.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "numinous_integration_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "numinous_crisis_balance.csv"

# ------------------------------------------------------------
# Build a simplified spiritual crisis network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "numinous_intensity": {"activation": 0.70, "node_type": "sacred_intensity"},
    "ritual_containment": {"activation": 0.50, "node_type": "containment"},
    "symbolic_containment": {"activation": 0.52, "node_type": "containment"},
    "ego_stability": {"activation": 0.50, "node_type": "ego_capacity"},
    "shadow_awareness": {"activation": 0.40, "node_type": "discernment"},
    "relational_support": {"activation": 0.46, "node_type": "support"},
    "trauma_vulnerability": {"activation": 0.44, "node_type": "vulnerability"},
    "sleep_disruption": {"activation": 0.36, "node_type": "vulnerability"},
    "practice_intensity": {"activation": 0.42, "node_type": "vulnerability"},
    "perceived_mission": {"activation": 0.42, "node_type": "inflation_pathway"},
    "humility_limit_awareness": {"activation": 0.46, "node_type": "discernment"},
    "inflation_risk": {"activation": 0.30, "node_type": "risk"},
    "crisis_state": {"activation": 0.30, "node_type": "risk"},
    "integration": {"activation": 0.40, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("numinous_intensity", "crisis_state", 0.60),
    ("numinous_intensity", "inflation_risk", 0.50),
    ("numinous_intensity", "perceived_mission", 0.34),

    ("ritual_containment", "integration", 0.44),
    ("symbolic_containment", "integration", 0.50),
    ("relational_support", "integration", 0.42),
    ("ego_stability", "integration", 0.50),
    ("shadow_awareness", "integration", 0.38),
    ("humility_limit_awareness", "integration", 0.32),

    ("trauma_vulnerability", "crisis_state", 0.46),
    ("trauma_vulnerability", "ego_stability", -0.32),
    ("sleep_disruption", "ego_stability", -0.40),
    ("sleep_disruption", "crisis_state", 0.35),
    ("practice_intensity", "numinous_intensity", 0.25),
    ("practice_intensity", "crisis_state", 0.30),

    ("perceived_mission", "inflation_risk", 0.54),
    ("ego_stability", "inflation_risk", -0.40),
    ("shadow_awareness", "inflation_risk", -0.38),
    ("humility_limit_awareness", "inflation_risk", -0.42),
    ("relational_support", "inflation_risk", -0.25),

    ("crisis_state", "integration", -0.50),
    ("inflation_risk", "integration", -0.36),
    ("integration", "ego_stability", 0.22),
    ("integration", "symbolic_containment", 0.18),
    ("integration", "humility_limit_awareness", 0.18),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(18):
    sacred_pressure = np.random.normal(0.70, 0.25)
    stress_pressure = np.random.normal(0.45, 0.18)
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

        if node_type in {"sacred_intensity", "risk", "inflation_pathway"}:
            updated = base + 0.12 * sacred_pressure + 0.10 * incoming
        elif node_type == "vulnerability":
            updated = base + 0.08 * stress_pressure + 0.08 * incoming
        elif node_type in {"containment", "support", "discernment"}:
            updated = base + 0.08 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Gradual stabilizing effects if containment remains available.
    new_activations["ritual_containment"] = min(
        new_activations["ritual_containment"] + 0.03,
        3.0
    )
    new_activations["symbolic_containment"] = min(
        new_activations["symbolic_containment"] + 0.02,
        3.0
    )
    new_activations["relational_support"] = min(
        new_activations["relational_support"] + 0.02,
        3.0
    )

    # Crisis decays slightly when not continuously amplified.
    new_activations["crisis_state"] *= 0.97

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
# Inspect inputs to integration
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
# Track stabilization balance
# ------------------------------------------------------------

results_df["containment_index"] = results_df[
    ["ritual_containment", "symbolic_containment", "relational_support"]
].mean(axis=1)

results_df["risk_index"] = results_df[
    ["crisis_state", "inflation_risk", "trauma_vulnerability", "sleep_disruption", "practice_intensity"]
].mean(axis=1)

results_df["discernment_index"] = results_df[
    ["shadow_awareness", "humility_limit_awareness"]
].mean(axis=1)

results_df["integration_minus_risk"] = (
    results_df["integration"] - results_df["risk_index"]
)

balance_df = results_df[
    [
        "step",
        "numinous_intensity",
        "containment_index",
        "ego_stability",
        "discernment_index",
        "risk_index",
        "crisis_state",
        "inflation_risk",
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
print("\nSymbolic crisis balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved integration inputs to: {OUT_INTEGRATION_INPUTS}")
print(f"Saved balance table to: {OUT_BALANCE}")
