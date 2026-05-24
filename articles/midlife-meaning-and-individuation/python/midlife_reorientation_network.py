"""
Midlife, Meaning, and Individuation
Python Workflow: Dynamic midlife reorientation network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, life-advice, or prediction tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/midlife-meaning-and-individuation")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "midlife_reorientation_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "midlife_reorientation_centrality.csv"
OUT_INDIVIDUATION_INPUTS = OUTPUT_TABLES / "individuation_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "midlife_reorientation_balance.csv"

# ------------------------------------------------------------
# Build a simplified midlife reorientation network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "persona": {"activation": 0.90, "node_type": "first_half_structure"},
    "achievement": {"activation": 0.88, "node_type": "first_half_structure"},
    "ego_identity": {"activation": 0.82, "node_type": "ego_structure"},
    "social_recognition": {"activation": 0.78, "node_type": "first_half_structure"},
    "shadow": {"activation": 0.38, "node_type": "depth_pressure"},
    "unlived_life": {"activation": 0.42, "node_type": "depth_pressure"},
    "symbolic_center": {"activation": 0.40, "node_type": "self_symbol"},
    "reflective_meaning": {"activation": 0.48, "node_type": "meaning_capacity"},
    "finitude_awareness": {"activation": 0.44, "node_type": "limit_pressure"},
    "grief": {"activation": 0.38, "node_type": "limit_pressure"},
    "creative_vocation": {"activation": 0.34, "node_type": "renewal_capacity"},
    "individuation": {"activation": 0.32, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("persona", "ego_identity", 0.52),
    ("achievement", "ego_identity", 0.50),
    ("social_recognition", "persona", 0.34),
    ("social_recognition", "achievement", 0.28),

    ("persona", "shadow", 0.24),
    ("achievement", "unlived_life", 0.26),
    ("ego_identity", "shadow", 0.22),
    ("finitude_awareness", "grief", 0.44),
    ("finitude_awareness", "reflective_meaning", 0.46),

    ("shadow", "reflective_meaning", 0.40),
    ("shadow", "individuation", 0.30),
    ("unlived_life", "creative_vocation", 0.44),
    ("unlived_life", "reflective_meaning", 0.34),
    ("grief", "reflective_meaning", 0.36),

    ("symbolic_center", "individuation", 0.58),
    ("symbolic_center", "reflective_meaning", 0.42),
    ("reflective_meaning", "individuation", 0.50),
    ("creative_vocation", "individuation", 0.34),

    ("individuation", "ego_identity", 0.28),
    ("individuation", "persona", -0.20),
    ("individuation", "achievement", -0.16),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(18):
    midlife_pressure = np.random.normal(0.70, 0.20)
    reflective_support = np.random.normal(0.48, 0.16)
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
            "depth_pressure",
            "self_symbol",
            "meaning_capacity",
            "limit_pressure",
            "renewal_capacity",
            "outcome",
        }:
            updated = base + 0.10 * midlife_pressure + 0.10 * incoming
        elif node_type in {"ego_structure"}:
            updated = base + 0.04 * reflective_support + 0.08 * incoming
        else:
            updated = base + 0.06 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Gradual reduction of first-half dominance.
    new_activations["persona"] *= 0.965
    new_activations["achievement"] *= 0.965
    new_activations["social_recognition"] *= 0.975

    # Stabilization when reflective meaning and symbolic center strengthen.
    new_activations["reflective_meaning"] = min(
        new_activations["reflective_meaning"] + 0.02,
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
# Inputs to individuation
# ------------------------------------------------------------

individuation_inputs = []

for predecessor in G.predecessors("individuation"):
    individuation_inputs.append(
        {
            "source": predecessor,
            "source_type": G.nodes[predecessor]["node_type"],
            "weight": G[predecessor]["individuation"]["weight"],
            "final_activation": G.nodes[predecessor]["activation"],
            "weighted_contribution": (
                G.nodes[predecessor]["activation"]
                * G[predecessor]["individuation"]["weight"]
            ),
        }
    )

individuation_input_df = pd.DataFrame(individuation_inputs).sort_values(
    "weighted_contribution",
    ascending=False,
)

# ------------------------------------------------------------
# Midlife reorientation balance
# ------------------------------------------------------------

results_df["first_half_index"] = results_df[
    ["persona", "achievement", "social_recognition", "ego_identity"]
].mean(axis=1)

results_df["second_half_index"] = results_df[
    [
        "shadow",
        "unlived_life",
        "symbolic_center",
        "reflective_meaning",
        "finitude_awareness",
        "grief",
        "creative_vocation",
        "individuation",
    ]
].mean(axis=1)

results_df["reorientation_gap"] = (
    results_df["second_half_index"] - results_df["first_half_index"]
)

balance_df = results_df[
    [
        "step",
        "first_half_index",
        "second_half_index",
        "reorientation_gap",
        "persona",
        "achievement",
        "shadow",
        "unlived_life",
        "symbolic_center",
        "reflective_meaning",
        "finitude_awareness",
        "individuation",
    ]
]

results_df.to_csv(OUT_HISTORY, index=False)
centrality_df.to_csv(OUT_CENTRALITY, index=False)
individuation_input_df.to_csv(OUT_INDIVIDUATION_INPUTS, index=False)
balance_df.to_csv(OUT_BALANCE, index=False)

print("Activation history")
print(results_df)
print("\nNetwork centrality")
print(centrality_df)
print("\nInputs to individuation")
print(individuation_input_df)
print("\nMidlife reorientation balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved individuation inputs to: {OUT_INDIVIDUATION_INPUTS}")
print(f"Saved midlife reorientation balance to: {OUT_BALANCE}")
