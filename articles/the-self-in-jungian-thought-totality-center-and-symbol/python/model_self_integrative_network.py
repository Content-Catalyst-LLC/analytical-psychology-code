"""
The Self in Jungian Thought
Python Workflow: Integrative network center

This script is a conceptual network demonstration.
It is not a clinical tool, diagnostic instrument, psychological assessment,
treatment recommendation system, spiritual authority system, or proof of
Jungian theory.
"""

from pathlib import Path
import numpy as np
import pandas as pd
import networkx as nx

np.random.seed(2026)

ARTICLE_DIR = Path("articles/the-self-in-jungian-thought-totality-center-and-symbol")
NODES_PATH = ARTICLE_DIR / "data/raw/psychic_network_nodes.csv"
EDGES_PATH = ARTICLE_DIR / "data/raw/psychic_network_edges.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

nodes_df = pd.read_csv(NODES_PATH)
edges_df = pd.read_csv(EDGES_PATH)

# ------------------------------------------------------------
# Build conceptual psychic network
# ------------------------------------------------------------

G = nx.Graph()

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
# Simulate integrative development over time
# ------------------------------------------------------------

history = []

for step in range(18):
    integration_pressure = np.random.normal(0.70, 0.18)
    disjunction_pressure = np.random.normal(0.24, 0.10)
    new_activations = {}

    for node in G.nodes():
        neighbor_input = 0.0

        for neighbor in G.neighbors(node):
            neighbor_input += (
                G.nodes[neighbor]["activation"]
                * G[node][neighbor]["weight"]
            )

        base = G.nodes[node]["activation"]
        cluster = G.nodes[node]["cluster"]

        if cluster == "self_symbol":
            updated = base + 0.10 * neighbor_input + 0.08 * integration_pressure
        elif cluster in {"unconscious", "symbolic", "embodied"}:
            updated = base + 0.08 * neighbor_input + 0.05 * integration_pressure
        elif cluster == "conscious_center":
            updated = base + 0.06 * neighbor_input + 0.04 * integration_pressure
        else:
            updated = base + 0.06 * neighbor_input + 0.03 * integration_pressure

        # Disjunction weakens over-reliance on persona without relation.
        if node == "persona":
            updated -= 0.04 * disjunction_pressure

        new_activations[node] = max(0.0, min(updated, 3.0))

    for node in G.nodes():
        G.nodes[node]["activation"] = new_activations[node]

    activations = np.array(list(new_activations.values()))
    mean_activation = float(activations.mean())
    activation_variance = float(activations.var())

    ego_dominance = new_activations["ego"] / max(mean_activation, 1e-6)
    center_relation = new_activations["center_symbol"]
    shadow_relation = new_activations["shadow"]
    persona_shadow_gap = abs(new_activations["persona"] - new_activations["shadow"])

    self_relation_index = (
        0.36 * mean_activation
        + 0.28 * center_relation
        + 0.18 * shadow_relation
        - 0.20 * activation_variance
        - 0.16 * persona_shadow_gap
        - 0.14 * max(ego_dominance - 1.8, 0)
    )

    history.append(
        {
            "step": step,
            "mean_activation": mean_activation,
            "activation_variance": activation_variance,
            "ego_dominance": ego_dominance,
            "center_relation": center_relation,
            "shadow_relation": shadow_relation,
            "persona_shadow_gap": persona_shadow_gap,
            "self_relation_index": self_relation_index,
            **new_activations,
        }
    )

results_df = pd.DataFrame(history)

# ------------------------------------------------------------
# Centrality metrics
# ------------------------------------------------------------

centrality_df = pd.DataFrame(
    {
        "node": list(G.nodes()),
        "cluster": [G.nodes[n]["cluster"] for n in G.nodes()],
        "betweenness": list(nx.betweenness_centrality(G, weight="weight").values()),
        "degree_centrality": list(nx.degree_centrality(G).values()),
        "weighted_degree": [G.degree(n, weight="weight") for n in G.nodes()],
        "final_activation": [G.nodes[n]["activation"] for n in G.nodes()],
    }
).sort_values(["betweenness", "weighted_degree"], ascending=False)

# ------------------------------------------------------------
# Cluster-level integration
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
# Inflation-risk indicators
# ------------------------------------------------------------

inflation_df = results_df[
    [
        "step",
        "ego_dominance",
        "center_relation",
        "shadow_relation",
        "persona_shadow_gap",
        "self_relation_index",
    ]
].copy()

inflation_df["inflation_warning_score"] = (
    0.45 * inflation_df["ego_dominance"]
    + 0.35 * inflation_df["center_relation"]
    - 0.40 * inflation_df["shadow_relation"]
    + 0.20 * inflation_df["persona_shadow_gap"]
)

# ------------------------------------------------------------
# Export outputs
# ------------------------------------------------------------

results_df.to_csv(OUTPUT_DIR / "self_network_activation_history.csv", index=False)
centrality_df.to_csv(OUTPUT_DIR / "self_network_centrality.csv", index=False)
cluster_df.to_csv(OUTPUT_DIR / "self_network_cluster_summary.csv", index=False)
inflation_df.to_csv(OUTPUT_DIR / "self_network_inflation_risk.csv", index=False)

edge_df = nx.to_pandas_edgelist(G)
edge_df.to_csv(OUTPUT_DIR / "self_network_edges.csv", index=False)

print("Activation history")
print(results_df)

print("\nCentrality")
print(centrality_df)

print("\nCluster summary")
print(cluster_df)

print("\nInflation-risk indicators")
print(inflation_df)
