"""
Analytical Psychology and Clinical Practice
Python Workflow: Dynamic analytical treatment network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, treatment recommendation,
therapist-evaluation, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/analytical-psychology-and-clinical-practice")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "analytical_treatment_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "analytical_treatment_centrality.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "clinical_integration_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "clinical_symbolic_balance.csv"

# ------------------------------------------------------------
# Build a simplified analytical treatment network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "therapeutic_alliance": {"activation": 0.72, "node_type": "clinical_vessel"},
    "ego_function": {"activation": 0.58, "node_type": "ego_capacity"},
    "symbolization": {"activation": 0.46, "node_type": "symbolic_capacity"},
    "dream_richness": {"activation": 0.34, "node_type": "symbolic_capacity"},
    "reflective_capacity": {"activation": 0.46, "node_type": "ego_capacity"},
    "affect_regulation": {"activation": 0.42, "node_type": "regulation"},
    "symptom_burden": {"activation": 0.76, "node_type": "risk"},
    "complex_pressure": {"activation": 0.66, "node_type": "risk"},
    "conscious_onesidedness": {"activation": 0.62, "node_type": "risk"},
    "trauma_fragmentation": {"activation": 0.54, "node_type": "risk"},
    "shadow_awareness": {"activation": 0.32, "node_type": "integration_capacity"},
    "integration": {"activation": 0.34, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("therapeutic_alliance", "ego_function", 0.42),
    ("therapeutic_alliance", "symbolization", 0.46),
    ("therapeutic_alliance", "affect_regulation", 0.42),
    ("therapeutic_alliance", "reflective_capacity", 0.36),

    ("ego_function", "reflective_capacity", 0.42),
    ("ego_function", "integration", 0.34),
    ("affect_regulation", "symbolization", 0.34),
    ("affect_regulation", "symptom_burden", -0.30),
    ("affect_regulation", "trauma_fragmentation", -0.24),

    ("symbolization", "dream_richness", 0.42),
    ("symbolization", "integration", 0.48),
    ("dream_richness", "reflective_capacity", 0.22),
    ("reflective_capacity", "integration", 0.44),
    ("shadow_awareness", "integration", 0.36),

    ("complex_pressure", "symptom_burden", 0.48),
    ("conscious_onesidedness", "complex_pressure", 0.34),
    ("conscious_onesidedness", "symptom_burden", 0.22),
    ("trauma_fragmentation", "symptom_burden", 0.36),
    ("trauma_fragmentation", "symbolization", -0.30),
    ("trauma_fragmentation", "ego_function", -0.28),

    ("integration", "symptom_burden", -0.48),
    ("integration", "complex_pressure", -0.30),
    ("integration", "ego_function", 0.24),
    ("integration", "shadow_awareness", 0.20),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over treatment time
# ------------------------------------------------------------

history = []

for step in range(24):
    treatment_pressure = np.random.normal(0.60, 0.18)
    stress_pressure = np.random.normal(0.35, 0.12)
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
            "clinical_vessel",
            "ego_capacity",
            "symbolic_capacity",
            "regulation",
            "integration_capacity",
            "outcome",
        }:
            updated = base + 0.08 * treatment_pressure + 0.10 * incoming
        else:
            updated = base + 0.06 * stress_pressure + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Gradual strengthening of the clinical vessel.
    new_activations["therapeutic_alliance"] = min(
        new_activations["therapeutic_alliance"] + 0.02,
        3.0,
    )

    # Symptoms and complex pressure decline slightly as integration rises.
    new_activations["symptom_burden"] *= 0.97
    new_activations["complex_pressure"] *= 0.985

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
# Clinical-symbolic balance metrics
# ------------------------------------------------------------

results_df["capacity_index"] = results_df[
    [
        "therapeutic_alliance",
        "ego_function",
        "symbolization",
        "reflective_capacity",
        "affect_regulation",
        "shadow_awareness",
    ]
].mean(axis=1)

results_df["risk_index"] = results_df[
    [
        "symptom_burden",
        "complex_pressure",
        "conscious_onesidedness",
        "trauma_fragmentation",
    ]
].mean(axis=1)

results_df["symbolic_index"] = results_df[
    ["symbolization", "dream_richness", "shadow_awareness"]
].mean(axis=1)

results_df["integration_minus_risk"] = (
    results_df["integration"] - results_df["risk_index"]
)

balance_df = results_df[
    [
        "step",
        "capacity_index",
        "symbolic_index",
        "risk_index",
        "therapeutic_alliance",
        "symptom_burden",
        "complex_pressure",
        "symbolization",
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
print("\nClinical-symbolic balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved clinical integration inputs to: {OUT_INTEGRATION_INPUTS}")
print(f"Saved clinical-symbolic balance table to: {OUT_BALANCE}")
