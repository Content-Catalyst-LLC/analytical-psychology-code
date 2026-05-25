"""
Complexes, Affect, and Repetition in Analytical Psychology
Python Workflow: Affective recurrence in complex networks

Synthetic-data demonstration only.
Not for diagnosis, therapy, psychological assessment, treatment recommendation,
employment screening, workplace surveillance, or individual prediction.
"""

from pathlib import Path
import numpy as np
import pandas as pd
import networkx as nx

np.random.seed(2026)

ARTICLE_DIR = Path("articles/complexes-affect-and-repetition-in-analytical-psychology")
DATA_DIR = ARTICLE_DIR / "data/raw"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

nodes_df = pd.read_csv(DATA_DIR / "complex_network_nodes.csv")
edges_df = pd.read_csv(DATA_DIR / "complex_network_edges.csv")

# ------------------------------------------------------------
# 1. Build affect-weighted complex network
# ------------------------------------------------------------

G = nx.DiGraph()

for _, row in nodes_df.iterrows():
    G.add_node(
        row["node"],
        cluster=row["cluster"],
        affect_weight=float(row["affect_weight"]),
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
# 2. Simulate activation over time
# ------------------------------------------------------------

def update_activation(graph, state, external_inputs, decay=0.22, threshold=0.05):
    """Propagate activation through an affect-weighted complex network."""
    new_state = {node: 0.0 for node in graph.nodes()}

    for node in graph.nodes():
        incoming = external_inputs.get(node, 0.0)

        for predecessor in graph.predecessors(node):
            edge_weight = graph[predecessor][node]["weight"]
            affect_weight = graph.nodes[node]["affect_weight"]
            incoming += state[predecessor] * edge_weight * affect_weight

        updated = max(0.0, incoming - decay)

        if updated < threshold:
            updated = 0.0

        new_state[node] = min(updated, 3.0)

    return new_state

activation = {node: 0.0 for node in G.nodes()}
history = []

for step in range(18):
    external_inputs = {
        "criticism_trigger": 1.00 if step in [0, 6, 12] else 0.00,
        "relational_distance": 0.90 if step in [3, 9, 14] else 0.00,
        "authority_signal": 0.80 if step in [5, 11, 16] else 0.00,
        "reflective_pause": 0.70 if step in [7, 8, 13, 15, 17] else 0.00,
        "relational_buffer": 0.60 if step in [4, 10, 15, 17] else 0.00,
    }

    total_affect = sum(
        activation[node]
        for node, attrs in G.nodes(data=True)
        if attrs["cluster"] == "affect"
    )

    total_trigger = sum(
        activation[node]
        for node, attrs in G.nodes(data=True)
        if attrs["cluster"] == "trigger"
    )

    total_regulation = sum(
        activation[node]
        for node, attrs in G.nodes(data=True)
        if attrs["cluster"] == "regulation"
    )

    recurrence_pressure = total_affect + total_trigger - total_regulation

    history.append(
        {
            "step": step,
            "total_affect": total_affect,
            "total_trigger": total_trigger,
            "total_regulation": total_regulation,
            "recurrence_pressure": recurrence_pressure,
            **activation,
        }
    )

    activation = update_activation(G, activation, external_inputs)

history_df = pd.DataFrame(history)

# ------------------------------------------------------------
# 3. Network diagnostics
# ------------------------------------------------------------

centrality_df = pd.DataFrame(
    {
        "node": list(G.nodes()),
        "cluster": [G.nodes[n]["cluster"] for n in G.nodes()],
        "affect_weight": [G.nodes[n]["affect_weight"] for n in G.nodes()],
        "in_degree": [G.in_degree(n) for n in G.nodes()],
        "out_degree": [G.out_degree(n) for n in G.nodes()],
        "weighted_in_degree": [G.in_degree(n, weight="weight") for n in G.nodes()],
        "weighted_out_degree": [G.out_degree(n, weight="weight") for n in G.nodes()],
        "betweenness": list(nx.betweenness_centrality(G, weight="weight").values()),
    }
).sort_values("betweenness", ascending=False)

cluster_summary = (
    centrality_df.groupby("cluster", as_index=False)
    .agg(
        node_count=("node", "count"),
        mean_affect_weight=("affect_weight", "mean"),
        mean_betweenness=("betweenness", "mean"),
        mean_weighted_in_degree=("weighted_in_degree", "mean"),
        mean_weighted_out_degree=("weighted_out_degree", "mean"),
    )
    .sort_values("mean_affect_weight", ascending=False)
)

activation_columns = [
    col for col in history_df.columns
    if col not in {"step", "total_affect", "total_trigger", "total_regulation", "recurrence_pressure"}
]

recurrence_summary = pd.DataFrame(
    {
        "node": activation_columns,
        "cluster": [G.nodes[node]["cluster"] for node in activation_columns],
        "mean_activation": [history_df[col].mean() for col in activation_columns],
        "max_activation": [history_df[col].max() for col in activation_columns],
        "active_periods": [(history_df[col] > 0).sum() for col in activation_columns],
        "recurrence_ratio": [(history_df[col] > 0).mean() for col in activation_columns],
    }
).sort_values(["recurrence_ratio", "max_activation"], ascending=False)

# ------------------------------------------------------------
# 4. Export outputs
# ------------------------------------------------------------

history_df.to_csv(OUTPUT_DIR / "complex_network_activation_history.csv", index=False)
centrality_df.to_csv(OUTPUT_DIR / "complex_network_centrality.csv", index=False)
cluster_summary.to_csv(OUTPUT_DIR / "complex_network_cluster_summary.csv", index=False)
recurrence_summary.to_csv(OUTPUT_DIR / "complex_network_recurrence_summary.csv", index=False)
nx.to_pandas_edgelist(G).to_csv(OUTPUT_DIR / "complex_network_edges.csv", index=False)

print("Activation history")
print(history_df)

print("\nCentrality")
print(centrality_df)

print("\nCluster summary")
print(cluster_summary)

print("\nRecurrence summary")
print(recurrence_summary)

print("\nResponsible-use guardrails:")
print("- Synthetic demonstration only.")
print("- Model outputs are not diagnostic or predictive.")
print("- Complex theory should not erase structural harm or real relational context.")
print("- Trauma-linked repetition requires stabilization and care before interpretation.")
