"""
Analytical Psychology and Personality Theory
Python Workflow: Dynamic Jungian personality network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, personality assessment,
hiring, screening, treatment recommendation, or prediction tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/analytical-psychology-and-personality-theory")
OUTPUT_TABLES = ARTICLE_DIR / "outputs" / "tables"
OUTPUT_TABLES.mkdir(parents=True, exist_ok=True)

OUT_HISTORY = OUTPUT_TABLES / "jungian_personality_activation_history.csv"
OUT_CENTRALITY = OUTPUT_TABLES / "jungian_personality_network_centrality.csv"
OUT_INTEGRATION_INPUTS = OUTPUT_TABLES / "developmental_integration_inputs.csv"
OUT_BALANCE = OUTPUT_TABLES / "jungian_personality_balance.csv"

# ------------------------------------------------------------
# Build a simplified Jungian personality network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "ego": {"activation": 0.86, "node_type": "conscious_center"},
    "persona": {"activation": 0.82, "node_type": "social_adaptation"},
    "shadow": {"activation": 0.38, "node_type": "unconscious_content"},
    "complexes": {"activation": 0.52, "node_type": "affective_pattern"},
    "thinking": {"activation": 0.72, "node_type": "function"},
    "feeling": {"activation": 0.54, "node_type": "function"},
    "sensation": {"activation": 0.62, "node_type": "function"},
    "intuition": {"activation": 0.58, "node_type": "function"},
    "symbolic_center": {"activation": 0.42, "node_type": "self_symbol"},
    "dream_function": {"activation": 0.46, "node_type": "symbolic_capacity"},
    "reflective_capacity": {"activation": 0.56, "node_type": "integration_capacity"},
    "developmental_integration": {"activation": 0.38, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("ego", "persona", 0.44),
    ("ego", "thinking", 0.36),
    ("ego", "feeling", 0.26),
    ("ego", "sensation", 0.30),
    ("ego", "intuition", 0.28),
    ("ego", "reflective_capacity", 0.34),

    ("persona", "shadow", 0.30),
    ("persona", "complexes", 0.24),

    ("shadow", "complexes", 0.42),
    ("shadow", "reflective_capacity", 0.32),
    ("shadow", "developmental_integration", 0.34),

    ("complexes", "ego", -0.18),
    ("complexes", "dream_function", 0.34),
    ("complexes", "developmental_integration", -0.26),

    ("thinking", "developmental_integration", 0.20),
    ("feeling", "developmental_integration", 0.22),
    ("sensation", "developmental_integration", 0.20),
    ("intuition", "developmental_integration", 0.22),

    ("dream_function", "shadow", 0.26),
    ("dream_function", "symbolic_center", 0.36),

    ("symbolic_center", "developmental_integration", 0.56),
    ("symbolic_center", "reflective_capacity", 0.34),

    ("reflective_capacity", "complexes", -0.24),
    ("reflective_capacity", "developmental_integration", 0.46),

    ("developmental_integration", "ego", 0.32),
    ("developmental_integration", "persona", -0.16),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(18):
    compensation_pressure = np.random.normal(0.70, 0.20)
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

        if node_type in {"unconscious_content", "affective_pattern", "symbolic_capacity", "self_symbol"}:
            updated = base + 0.10 * compensation_pressure + 0.10 * incoming
        elif node_type in {"conscious_center", "function", "integration_capacity", "outcome"}:
            updated = base + 0.08 * integration_support + 0.10 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    # Individuation gradually relativizes persona dominance.
    new_activations["persona"] *= 0.975

    # Reflective capacity slowly strengthens under repeated symbolic integration.
    new_activations["reflective_capacity"] = min(
        new_activations["reflective_capacity"] + 0.018,
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

# ------------------------------------------------------------
# Personality balance indices
# ------------------------------------------------------------

results_df["conscious_adaptation_index"] = results_df[
    ["ego", "persona", "thinking", "feeling", "sensation", "intuition"]
].mean(axis=1)

results_df["unconscious_pressure_index"] = results_df[
    ["shadow", "complexes", "dream_function"]
].mean(axis=1)

results_df["symbolic_integration_index"] = results_df[
    ["symbolic_center", "reflective_capacity", "developmental_integration"]
].mean(axis=1)

results_df["integration_minus_pressure"] = (
    results_df["symbolic_integration_index"]
    - results_df["unconscious_pressure_index"]
)

balance_df = results_df[
    [
        "step",
        "conscious_adaptation_index",
        "unconscious_pressure_index",
        "symbolic_integration_index",
        "integration_minus_pressure",
        "ego",
        "persona",
        "shadow",
        "complexes",
        "symbolic_center",
        "dream_function",
        "reflective_capacity",
        "developmental_integration",
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
print("\nInputs to developmental integration")
print(integration_input_df)
print("\nPersonality balance")
print(balance_df)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved developmental integration inputs to: {OUT_INTEGRATION_INPUTS}")
print(f"Saved Jungian personality balance to: {OUT_BALANCE}")
