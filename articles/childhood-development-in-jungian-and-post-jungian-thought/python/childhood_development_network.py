"""
Childhood Development in Jungian and Post-Jungian Thought
Python Workflow: Dynamic childhood development network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, educational-evaluation,
treatment recommendation, child-assessment, or prediction tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/childhood-development-in-jungian-and-post-jungian-thought")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "childhood_development_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "childhood_development_centrality.csv"
OUT_COHERENCE_INPUTS = OUTPUT_TABLES / "developmental_coherence_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "childhood_development_balance.csv"

# ------------------------------------------------------------
# Build a simplified child development network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "relational_security": {"activation": 0.78, "node_type": "relational_field"},
    "caregiver_mirroring": {"activation": 0.66, "node_type": "relational_field"},
    "bodily_regulation": {"activation": 0.52, "node_type": "regulation"},
    "symbolic_play": {"activation": 0.54, "node_type": "symbolic_capacity"},
    "ego_emergence": {"activation": 0.42, "node_type": "ego_capacity"},
    "affect_regulation": {"activation": 0.44, "node_type": "regulation"},
    "complex_formation": {"activation": 0.38, "node_type": "risk"},
    "family_tension": {"activation": 0.40, "node_type": "risk"},
    "shadow_seed": {"activation": 0.30, "node_type": "depth_potential"},
    "creative_imagination": {"activation": 0.36, "node_type": "symbolic_capacity"},
    "developmental_coherence": {"activation": 0.34, "node_type": "outcome"},
    "future_personality": {"activation": 0.32, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("relational_security", "ego_emergence", 0.46),
    ("relational_security", "affect_regulation", 0.56),
    ("relational_security", "bodily_regulation", 0.44),
    ("relational_security", "complex_formation", -0.30),

    ("caregiver_mirroring", "symbolic_play", 0.42),
    ("caregiver_mirroring", "ego_emergence", 0.34),
    ("caregiver_mirroring", "affect_regulation", 0.36),

    ("bodily_regulation", "symbolic_play", 0.32),
    ("bodily_regulation", "affect_regulation", 0.42),
    ("bodily_regulation", "developmental_coherence", 0.28),

    ("symbolic_play", "ego_emergence", 0.36),
    ("symbolic_play", "creative_imagination", 0.48),
    ("symbolic_play", "developmental_coherence", 0.40),

    ("ego_emergence", "developmental_coherence", 0.42),
    ("ego_emergence", "future_personality", 0.36),

    ("affect_regulation", "complex_formation", -0.28),
    ("affect_regulation", "developmental_coherence", 0.38),

    ("family_tension", "complex_formation", 0.46),
    ("family_tension", "affect_regulation", -0.24),
    ("family_tension", "symbolic_play", -0.20),

    ("complex_formation", "future_personality", 0.40),
    ("complex_formation", "developmental_coherence", -0.42),

    ("shadow_seed", "future_personality", 0.24),
    ("creative_imagination", "future_personality", 0.34),
    ("developmental_coherence", "future_personality", 0.52),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over developmental time
# ------------------------------------------------------------

history = []

for step in range(18):
    developmental_support = np.random.normal(0.66, 0.18)
    environmental_stress = np.random.normal(0.34, 0.12)
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
            "relational_field",
            "regulation",
            "symbolic_capacity",
            "ego_capacity",
            "depth_potential",
            "outcome",
        }:
            updated = base + 0.08 * developmental_support + 0.10 * incoming
        else:
            updated = base + 0.07 * environmental_stress + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Developmental strengthening of symbolic play and ego emergence.
    new_activations["symbolic_play"] = min(new_activations["symbolic_play"] + 0.018, 3.0)
    new_activations["ego_emergence"] = min(new_activations["ego_emergence"] + 0.020, 3.0)

    # Complex pressure softens when developmental coherence rises.
    new_activations["complex_formation"] *= 0.985

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
# Inputs to developmental coherence
# ------------------------------------------------------------

coherence_inputs = []

for predecessor in G.predecessors("developmental_coherence"):
    coherence_inputs.append(
        {
            "source": predecessor,
            "source_type": G.nodes[predecessor]["node_type"],
            "weight": G[predecessor]["developmental_coherence"]["weight"],
            "final_activation": G.nodes[predecessor]["activation"],
            "weighted_contribution": (
                G.nodes[predecessor]["activation"]
                * G[predecessor]["developmental_coherence"]["weight"]
            ),
        }
    )

coherence_input_df = pd.DataFrame(coherence_inputs).sort_values(
    "weighted_contribution",
    ascending=False,
)

# ------------------------------------------------------------
# Developmental balance
# ------------------------------------------------------------

results_df["relational_symbolic_index"] = results_df[
    [
        "relational_security",
        "caregiver_mirroring",
        "symbolic_play",
        "creative_imagination",
    ]
].mean(axis=1)

results_df["ego_regulation_index"] = results_df[
    [
        "ego_emergence",
        "affect_regulation",
        "bodily_regulation",
    ]
].mean(axis=1)

results_df["risk_index"] = results_df[
    [
        "complex_formation",
        "family_tension",
    ]
].mean(axis=1)

results_df["coherence_minus_risk"] = (
    results_df["developmental_coherence"] - results_df["risk_index"]
)

balance_df = results_df[
    [
        "step",
        "relational_symbolic_index",
        "ego_regulation_index",
        "risk_index",
        "relational_security",
        "symbolic_play",
        "ego_emergence",
        "affect_regulation",
        "complex_formation",
        "developmental_coherence",
        "future_personality",
        "coherence_minus_risk",
    ]
]

results_df.to_csv(OUT_HISTORY, index=False)
centrality_df.to_csv(OUT_CENTRALITY, index=False)
coherence_input_df.to_csv(OUT_COHERENCE_INPUTS, index=False)
balance_df.to_csv(OUT_BALANCE, index=False)

print("Activation history")
print(results_df)
print("\nNetwork centrality")
print(centrality_df)
print("\nInputs to developmental coherence")
print(coherence_input_df)
print("\nDevelopmental balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved developmental coherence inputs to: {OUT_COHERENCE_INPUTS}")
print(f"Saved developmental balance to: {OUT_BALANCE}")
