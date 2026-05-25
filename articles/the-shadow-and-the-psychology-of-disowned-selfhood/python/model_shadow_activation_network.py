"""
The Shadow and the Psychology of Disowned Selfhood
Python Workflow: Shadow activation in a self-network

This script is a conceptual network demonstration.
It is not a clinical tool, diagnostic instrument, psychological assessment,
moral ranking system, treatment recommendation system, or proof of Jungian
theory.
"""

from pathlib import Path
import numpy as np
import pandas as pd
import networkx as nx

np.random.seed(2026)

ARTICLE_DIR = Path("articles/the-shadow-and-the-psychology-of-disowned-selfhood")
NODES_PATH = ARTICLE_DIR / "data/raw/shadow_network_nodes.csv"
EDGES_PATH = ARTICLE_DIR / "data/raw/shadow_network_edges.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

nodes_df = pd.read_csv(NODES_PATH)
edges_df = pd.read_csv(EDGES_PATH)

# ------------------------------------------------------------
# Build conceptual shadow network
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

shadow_nodes = {
    "aggression",
    "envy",
    "dependency",
    "grief",
    "vulnerability",
    "desire",
    "resentment",
}

persona_nodes = {
    "moral_self_image",
    "competence",
    "self_control",
    "care_identity",
}

# ------------------------------------------------------------
# Simulate activation over time
# ------------------------------------------------------------

history = []

for step in range(14):
    cue = np.random.normal(0.80, 0.30)
    social_pressure = np.random.normal(0.55, 0.20)
    reflection_event = np.random.normal(0.35, 0.15)

    new_activations = {}

    for node in G.nodes():
        incoming = 0.0

        for predecessor in G.predecessors(node):
            incoming += (
                G.nodes[predecessor]["activation"]
                * G[predecessor][node]["weight"]
            )

        base = G.nodes[node]["activation"]
        cluster = G.nodes[node].get("cluster", "other")

        if node in shadow_nodes:
            updated = base + 0.20 * cue + 0.08 * social_pressure + incoming
        elif cluster == "persona":
            updated = base + 0.10 * social_pressure + 0.06 * incoming
        elif cluster == "reflection":
            updated = base + 0.12 * reflection_event - 0.04 * cue + 0.06 * incoming
        elif cluster == "integration":
            updated = base + 0.16 * G.nodes["reflective_awareness"]["activation"] + 0.06 * incoming
        else:
            updated = base + 0.10 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    for node in G.nodes():
        G.nodes[node]["activation"] = new_activations[node]

    shadow_activation = sum(new_activations[n] for n in shadow_nodes if n in new_activations)
    persona_activation = sum(new_activations[n] for n in persona_nodes if n in new_activations)
    reflective_awareness = new_activations["reflective_awareness"]
    integration_capacity = new_activations["integration_capacity"]

    projection_pressure = new_activations["projection_to_other"]
    shame_pressure = new_activations["shame_response"]
    defensive_pressure = new_activations["defensiveness"]
    withdrawal_pressure = new_activations["withdrawal"]
    repair_behavior = new_activations["repair_behavior"]

    shadow_discrepancy_index = shadow_activation / max(persona_activation, 1e-6)

    responsibility_index = (
        0.42 * reflective_awareness
        + 0.38 * integration_capacity
        + 0.26 * repair_behavior
        - 0.24 * projection_pressure
        - 0.18 * shame_pressure
        - 0.16 * defensive_pressure
    )

    history.append(
        {
            "step": step,
            "cue": cue,
            "social_pressure": social_pressure,
            "reflection_event": reflection_event,
            "shadow_activation": shadow_activation,
            "persona_activation": persona_activation,
            "shadow_discrepancy_index": shadow_discrepancy_index,
            "projection_pressure": projection_pressure,
            "shame_pressure": shame_pressure,
            "defensive_pressure": defensive_pressure,
            "withdrawal_pressure": withdrawal_pressure,
            "repair_behavior": repair_behavior,
            "responsibility_index": responsibility_index,
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
        "cluster": [G.nodes[n].get("cluster", "other") for n in G.nodes()],
        "betweenness": list(nx.betweenness_centrality(G, weight="weight").values()),
        "in_degree": [G.in_degree(n) for n in G.nodes()],
        "out_degree": [G.out_degree(n) for n in G.nodes()],
        "weighted_in_degree": [G.in_degree(n, weight="weight") for n in G.nodes()],
        "weighted_out_degree": [G.out_degree(n, weight="weight") for n in G.nodes()],
        "final_activation": [G.nodes[n]["activation"] for n in G.nodes()],
    }
).sort_values("betweenness", ascending=False)

cluster_rows = []

for cluster in sorted(set(nx.get_node_attributes(G, "cluster").values())):
    cluster_nodes = [
        n for n, attrs in G.nodes(data=True)
        if attrs.get("cluster") == cluster
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

activation_df.to_csv(OUTPUT_DIR / "shadow_network_activation_history.csv", index=False)
centrality_df.to_csv(OUTPUT_DIR / "shadow_network_centrality.csv", index=False)
cluster_df.to_csv(OUTPUT_DIR / "shadow_network_cluster_summary.csv", index=False)

edge_df = nx.to_pandas_edgelist(G)
edge_df.to_csv(OUTPUT_DIR / "shadow_network_edges.csv", index=False)

print("Activation history")
print(activation_df)

print("\nCentrality")
print(centrality_df)

print("\nCluster summary")
print(cluster_df)
