"""
Ego, Consciousness, and Psychic Differentiation
Python Workflow: Conscious differentiation in a psychic network

This script is a conceptual network demonstration.
It is not a clinical tool, diagnostic instrument, psychological assessment,
personality assessment, treatment recommendation system, or proof of
Jungian theory.
"""

from pathlib import Path
import numpy as np
import pandas as pd
import networkx as nx

np.random.seed(2026)

ARTICLE_DIR = Path("articles/ego-consciousness-and-psychic-differentiation")
NODES_PATH = ARTICLE_DIR / "data/raw/ego_network_nodes.csv"
EDGES_PATH = ARTICLE_DIR / "data/raw/ego_network_edges.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

nodes_df = pd.read_csv(NODES_PATH)
edges_df = pd.read_csv(EDGES_PATH)

# ------------------------------------------------------------
# Build conceptual psychic network
# ------------------------------------------------------------

G = nx.DiGraph()

for _, row in nodes_df.iterrows():
    G.add_node(
        row["node"],
        cluster=row["cluster"],
        activation=float(row["activation"]),
        notes=row["notes"],
    )

for _, row in edges_df.iterrows():
    G.add_edge(
        row["source"],
        row["target"],
        weight=float(row["weight"]),
        notes=row["notes"],
    )

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(16):
    unconscious_pressure = np.random.normal(0.70, 0.25)
    social_pressure = np.random.normal(0.50, 0.18)
    new_activations = {}

    for node in G.nodes():
        incoming = 0.0

        for predecessor in G.predecessors(node):
            incoming += (
                G.nodes[predecessor]["activation"]
                * G[predecessor][node]["weight"]
            )

        base = G.nodes[node]["activation"]
        cluster = G.nodes[node]["cluster"]

        if cluster == "unconscious":
            updated = base + 0.20 * unconscious_pressure + 0.08 * incoming
        elif cluster == "adaptation":
            updated = base + 0.16 * social_pressure + 0.08 * incoming
        elif cluster == "reflective":
            updated = base + 0.05 * incoming - 0.05 * unconscious_pressure
        elif cluster == "conscious_center":
            updated = base + 0.10 * incoming - 0.04 * unconscious_pressure
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    for node in G.nodes():
        G.nodes[node]["activation"] = new_activations[node]

    function_values = np.array([
        new_activations["thinking"],
        new_activations["feeling"],
        new_activations["sensation"],
        new_activations["intuition"],
    ])

    function_balance = 1.0 / (1.0 + function_values.var())
    ego_activation = new_activations["ego"]
    shadow_pressure = new_activations["shadow_cluster"] + new_activations["complex_cluster"]
    reflective_capacity = new_activations["reflective_flexibility"]
    persona_pressure = new_activations["persona"]

    ego_coherence_index = (
        0.36 * ego_activation
        + 0.26 * function_balance
        + 0.24 * reflective_capacity
        - 0.18 * shadow_pressure
        - 0.10 * persona_pressure
    )

    rigidity_index = (
        0.40 * persona_pressure
        + 0.24 * ego_activation
        - 0.36 * reflective_capacity
        + 0.18 * (1.0 - function_balance)
    )

    inflation_warning_score = (
        0.42 * ego_activation
        + 0.34 * persona_pressure
        + 0.22 * new_activations["symbolic_imagery"]
        - 0.38 * reflective_capacity
        - 0.26 * new_activations["shadow_cluster"]
    )

    history.append(
        {
            "step": step,
            "unconscious_pressure": unconscious_pressure,
            "social_pressure": social_pressure,
            "function_balance": function_balance,
            "shadow_pressure": shadow_pressure,
            "ego_coherence_index": ego_coherence_index,
            "rigidity_index": rigidity_index,
            "inflation_warning_score": inflation_warning_score,
            **new_activations,
        }
    )

activation_df = pd.DataFrame(history)

# ------------------------------------------------------------
# Centrality and structural diagnostics
# ------------------------------------------------------------

centrality_df = pd.DataFrame(
    {
        "node": list(G.nodes()),
        "cluster": [G.nodes[n]["cluster"] for n in G.nodes()],
        "betweenness": list(nx.betweenness_centrality(G, weight="weight").values()),
        "in_degree": [G.in_degree(n) for n in G.nodes()],
        "out_degree": [G.out_degree(n) for n in G.nodes()],
        "weighted_in_degree": [G.in_degree(n, weight="weight") for n in G.nodes()],
        "weighted_out_degree": [G.out_degree(n, weight="weight") for n in G.nodes()],
        "final_activation": [G.nodes[n]["activation"] for n in G.nodes()],
    }
).sort_values("betweenness", ascending=False)

# ------------------------------------------------------------
# Cluster-level summary
# ------------------------------------------------------------

cluster_rows = []

for cluster in sorted(set(nx.get_node_attributes(G, "cluster").values())):
    cluster_nodes = [
        n for n, attrs in G.nodes(data=True)
        if attrs["cluster"] == cluster
    ]

    cluster_rows.append(
        {
            "cluster": cluster,
            "node_count": len(cluster_nodes),
            "mean_final_activation": np.mean(
                [G.nodes[n]["activation"] for n in cluster_nodes]
            ),
            "nodes": ", ".join(cluster_nodes),
        }
    )

cluster_df = pd.DataFrame(cluster_rows).sort_values(
    "mean_final_activation",
    ascending=False,
)

# ------------------------------------------------------------
# Export outputs
# ------------------------------------------------------------

activation_df.to_csv(OUTPUT_DIR / "ego_network_activation_history.csv", index=False)
centrality_df.to_csv(OUTPUT_DIR / "ego_network_centrality.csv", index=False)
cluster_df.to_csv(OUTPUT_DIR / "ego_network_cluster_summary.csv", index=False)

edge_df = nx.to_pandas_edgelist(G)
edge_df.to_csv(OUTPUT_DIR / "ego_network_edges.csv", index=False)

print("Activation history")
print(activation_df)

print("\nCentrality")
print(centrality_df)

print("\nCluster summary")
print(cluster_df)
