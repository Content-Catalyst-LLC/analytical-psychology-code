"""
Persona and Social Adaptation in Analytical Psychology
Python Workflow: Persona rigidity and shadow compensation

This script is a conceptual network demonstration.
It is not a clinical tool, diagnostic instrument, psychological assessment,
employment assessment, reputation scoring system, social scoring system,
treatment recommendation system, or proof of Jungian theory.
"""

from pathlib import Path
import numpy as np
import pandas as pd
import networkx as nx

np.random.seed(2026)

ARTICLE_DIR = Path("articles/persona-and-social-adaptation-in-analytical-psychology")
NODES_PATH = ARTICLE_DIR / "data/raw/persona_network_nodes.csv"
EDGES_PATH = ARTICLE_DIR / "data/raw/persona_network_edges.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

nodes_df = pd.read_csv(NODES_PATH)
edges_df = pd.read_csv(EDGES_PATH)

# ------------------------------------------------------------
# Build conceptual persona-shadow network
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

persona_nodes = {
    n for n, attrs in G.nodes(data=True)
    if attrs["cluster"] == "persona"
}

shadow_nodes = {
    n for n, attrs in G.nodes(data=True)
    if attrs["cluster"] == "shadow"
}

response_nodes = {
    n for n, attrs in G.nodes(data=True)
    if attrs["cluster"] == "response"
}

# ------------------------------------------------------------
# Simulate persona reinforcement and shadow compensation
# ------------------------------------------------------------

history = []

for step in range(16):
    social_reward = np.random.normal(0.66, 0.18)
    role_pressure = np.random.normal(0.72, 0.22)
    reflective_event = np.random.normal(0.34, 0.16)

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

        if node in persona_nodes:
            updated = base + 0.10 * social_reward + 0.12 * role_pressure + 0.06 * incoming
        elif node in shadow_nodes:
            updated = base - 0.04 * social_reward + 0.08 * incoming
        elif cluster == "reflection":
            updated = base + 0.14 * reflective_event - 0.04 * role_pressure + 0.06 * incoming
        elif cluster == "integration":
            updated = base + 0.12 * G.nodes["authentic_reflection"]["activation"] + 0.08 * incoming
        elif cluster == "context":
            updated = base + 0.06 * social_reward + 0.06 * role_pressure + 0.05 * incoming
        else:
            updated = base + 0.10 * incoming

        new_activations[node] = max(0.0, min(updated, 3.2))

    # Shadow compensation after prolonged persona asymmetry.
    if step >= 8:
        for node in shadow_nodes:
            new_activations[node] = min(new_activations[node] + 0.16, 3.2)

    for node in G.nodes():
        G.nodes[node]["activation"] = new_activations[node]

    persona_activation = sum(new_activations[n] for n in persona_nodes)
    shadow_activation = sum(new_activations[n] for n in shadow_nodes)
    response_activation = sum(new_activations[n] for n in response_nodes)

    persona_shadow_gap = abs(persona_activation - shadow_activation)
    reflection = new_activations["authentic_reflection"]
    integration = new_activations["integration_capacity"]

    persona_rigidity_index = (
        0.34 * persona_activation
        + 0.28 * new_activations["role_demand"]
        + 0.24 * new_activations["audience_reward"]
        + 0.22 * new_activations["institutional_reward"]
        - 0.36 * reflection
    )

    psychic_strain_index = (
        0.30 * persona_shadow_gap
        + 0.26 * response_activation
        + 0.24 * persona_rigidity_index
        - 0.34 * reflection
        - 0.26 * integration
    )

    individuation_readiness_index = (
        0.42 * reflection
        + 0.36 * integration
        - 0.22 * persona_rigidity_index
        - 0.18 * response_activation
    )

    history.append(
        {
            "step": step,
            "social_reward": social_reward,
            "role_pressure": role_pressure,
            "reflective_event": reflective_event,
            "persona_activation": persona_activation,
            "shadow_activation": shadow_activation,
            "response_activation": response_activation,
            "persona_shadow_gap": persona_shadow_gap,
            "persona_rigidity_index": persona_rigidity_index,
            "psychic_strain_index": psychic_strain_index,
            "individuation_readiness_index": individuation_readiness_index,
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

activation_df.to_csv(OUTPUT_DIR / "persona_network_activation_history.csv", index=False)
centrality_df.to_csv(OUTPUT_DIR / "persona_network_centrality.csv", index=False)
cluster_df.to_csv(OUTPUT_DIR / "persona_network_cluster_summary.csv", index=False)

edge_df = nx.to_pandas_edgelist(G)
edge_df.to_csv(OUTPUT_DIR / "persona_network_edges.csv", index=False)

print("Activation history")
print(activation_df)

print("\nCentrality")
print(centrality_df)

print("\nCluster summary")
print(cluster_df)
