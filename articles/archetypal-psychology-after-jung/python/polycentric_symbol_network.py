"""
Archetypal Psychology After Jung
Python Workflow: Polycentric symbol network

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd
import numpy as np

np.random.seed(2026)

ARTICLE_DIR = Path("articles/archetypal-psychology-after-jung")
OUT_HISTORY = ARTICLE_DIR / "outputs" / "tables" / "polycentric_activation_history.csv"
OUT_CENTRALITY = ARTICLE_DIR / "outputs" / "tables" / "polycentric_network_centrality.csv"
OUT_DEPTH_INPUTS = ARTICLE_DIR / "outputs" / "tables" / "archetypal_depth_inputs.csv"
OUT_PRESSURE = ARTICLE_DIR / "outputs" / "tables" / "polycentric_vs_pressure_summary.csv"

# ------------------------------------------------------------
# Build a simplified archetypal network
# ------------------------------------------------------------

G = nx.DiGraph()

nodes = {
    "lover": {"activation": 0.60, "node_type": "archetypal_style"},
    "warrior": {"activation": 0.50, "node_type": "archetypal_style"},
    "trickster": {"activation": 0.52, "node_type": "archetypal_style"},
    "mourner": {"activation": 0.44, "node_type": "archetypal_style"},
    "sage": {"activation": 0.50, "node_type": "archetypal_style"},
    "underworld": {"activation": 0.48, "node_type": "archetypal_style"},
    "dream_image": {"activation": 0.72, "node_type": "image"},
    "symptom_image": {"activation": 0.58, "node_type": "image"},
    "metaphor": {"activation": 0.64, "node_type": "method"},
    "integrative_pressure": {"activation": 0.50, "node_type": "pressure"},
    "literalizing_force": {"activation": 0.44, "node_type": "pressure"},
    "archetypal_depth": {"activation": 0.40, "node_type": "outcome"},
    "flattening_risk": {"activation": 0.32, "node_type": "outcome"},
}

for node, attrs in nodes.items():
    G.add_node(node, **attrs)

edges = [
    ("lover", "archetypal_depth", 0.30),
    ("warrior", "archetypal_depth", 0.30),
    ("trickster", "archetypal_depth", 0.34),
    ("mourner", "archetypal_depth", 0.36),
    ("sage", "archetypal_depth", 0.28),
    ("underworld", "archetypal_depth", 0.38),
    ("dream_image", "archetypal_depth", 0.50),
    ("symptom_image", "archetypal_depth", 0.42),
    ("metaphor", "archetypal_depth", 0.36),
    ("integrative_pressure", "archetypal_depth", -0.40),
    ("literalizing_force", "archetypal_depth", -0.34),
    ("integrative_pressure", "flattening_risk", 0.44),
    ("literalizing_force", "flattening_risk", 0.50),
    ("dream_image", "lover", 0.18),
    ("dream_image", "trickster", 0.22),
    ("dream_image", "mourner", 0.24),
    ("dream_image", "sage", 0.18),
    ("dream_image", "underworld", 0.26),
    ("symptom_image", "mourner", 0.24),
    ("symptom_image", "warrior", 0.18),
    ("symptom_image", "underworld", 0.30),
    ("metaphor", "dream_image", 0.20),
    ("metaphor", "symptom_image", 0.20),
]

for source, target, weight in edges:
    G.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(18):
    imaginal_pressure = np.random.normal(0.65, 0.20)
    literal_pressure = np.random.normal(0.35, 0.12)
    new_activations = {}

    for node in G.nodes():
        incoming = 0.0

        for predecessor in G.predecessors(node):
            incoming += (
                G.nodes[predecessor]["activation"] *
                G[predecessor][node]["weight"]
            )

        base = G.nodes[node]["activation"]
        node_type = G.nodes[node]["node_type"]

        if node_type in {"archetypal_style", "image", "method"}:
            updated = base + 0.10 * imaginal_pressure + 0.10 * incoming
        elif node_type == "pressure":
            updated = base + 0.04 * literal_pressure + 0.06 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    new_activations["integrative_pressure"] = min(
        new_activations["integrative_pressure"] + 0.02,
        3.0
    )

    for node in G.nodes():
        G.nodes[node]["activation"] = new_activations[node]

    history.append({"step": step, **new_activations})

results_df = pd.DataFrame(history)

# ------------------------------------------------------------
# Compute centrality and depth inputs
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

depth_inputs = []

for predecessor in G.predecessors("archetypal_depth"):
    depth_inputs.append(
        {
            "source": predecessor,
            "source_type": G.nodes[predecessor]["node_type"],
            "weight": G[predecessor]["archetypal_depth"]["weight"],
            "final_activation": G.nodes[predecessor]["activation"],
            "weighted_contribution": (
                G.nodes[predecessor]["activation"]
                * G[predecessor]["archetypal_depth"]["weight"]
            ),
        }
    )

depth_input_df = pd.DataFrame(depth_inputs).sort_values(
    "weighted_contribution",
    ascending=False,
)

polycentric_nodes = [
    "lover",
    "warrior",
    "trickster",
    "mourner",
    "sage",
    "underworld",
]

results_df["polycentric_activation"] = results_df[polycentric_nodes].mean(axis=1)
results_df["pressure_activation"] = results_df[
    ["integrative_pressure", "literalizing_force"]
].mean(axis=1)
results_df["polycentric_minus_pressure"] = (
    results_df["polycentric_activation"] -
    results_df["pressure_activation"]
)

pressure_summary = results_df[
    [
        "step",
        "polycentric_activation",
        "pressure_activation",
        "polycentric_minus_pressure",
        "archetypal_depth",
        "flattening_risk",
    ]
]

OUT_HISTORY.parent.mkdir(parents=True, exist_ok=True)
results_df.to_csv(OUT_HISTORY, index=False)
centrality_df.to_csv(OUT_CENTRALITY, index=False)
depth_input_df.to_csv(OUT_DEPTH_INPUTS, index=False)
pressure_summary.to_csv(OUT_PRESSURE, index=False)

print("Activation history")
print(results_df)
print("\nNetwork centrality")
print(centrality_df)
print("\nInputs to archetypal depth")
print(depth_input_df)
print("\nPolycentric vs pressure summary")
print(pressure_summary)
print(f"\nSaved activation history to: {OUT_HISTORY}")
print(f"Saved centrality to: {OUT_CENTRALITY}")
print(f"Saved archetypal depth inputs to: {OUT_DEPTH_INPUTS}")
print(f"Saved pressure summary to: {OUT_PRESSURE}")
