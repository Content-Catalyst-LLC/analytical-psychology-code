"""
The Personal Unconscious and the Theory of Complexes
Python Workflow: Simulating associative complex networks

Synthetic-data demonstration only.
Not for diagnosis, therapy, psychological assessment, treatment recommendation,
employment screening, workplace surveillance, or individual prediction.
"""

from pathlib import Path
import numpy as np
import pandas as pd
import networkx as nx

np.random.seed(2026)

ARTICLE_DIR = Path("articles/the-personal-unconscious-and-the-theory-of-complexes")
DATA_DIR = ARTICLE_DIR / "data/raw"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

nodes_df = pd.read_csv(DATA_DIR / "associative_complex_nodes.csv")
edges_df = pd.read_csv(DATA_DIR / "associative_complex_edges.csv")

# ------------------------------------------------------------
# 1. Build affect-weighted associative complex network
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
# 2. Activation-spread function
# ------------------------------------------------------------

def spread_activation(graph, activation_state, external_inputs, decay=0.22, threshold=0.06):
    """Propagate activation through an affect-weighted directed network."""
    new_state = {node: 0.0 for node in graph.nodes()}

    for node in graph.nodes():
        incoming = external_inputs.get(node, 0.0)

        for predecessor in graph.predecessors(node):
            edge_weight = graph[predecessor][node]["weight"]
            affect_weight = graph.nodes[node]["affect_weight"]
            incoming += activation_state[predecessor] * edge_weight * affect_weight

        updated = max(0.0, incoming - decay)

        if updated < threshold:
            updated = 0.0

        new_state[node] = min(updated, 3.0)

    return new_state

# ------------------------------------------------------------
# 3. Simulate repeated trigger events
# ------------------------------------------------------------

activation = {node: 0.0 for node in G.nodes()}
history = []

for step in range(18):
    external_inputs = {
        "authority_cue": 1.00 if step in [0, 7, 13] else 0.00,
        "criticism_cue": 0.90 if step in [2, 8, 14] else 0.00,
        "relational_distance": 0.85 if step in [4, 10, 16] else 0.00,
        "reflective_awareness": 0.75 if step in [5, 6, 11, 12, 17] else 0.00,
        "contextual_support": 0.65 if step in [6, 12, 17] else 0.00,
    }

    total_affect = sum(
        activation[node]
        for node, attrs in G.nodes(data=True)
        if attrs["cluster"] == "affect"
    )

    total_memory = sum(
        activation[node]
        for node, attrs in G.nodes(data=True)
        if attrs["cluster"] == "memory"
    )

    total_response = sum(
        activation[node]
        for node, attrs in G.nodes(data=True)
        if attrs["cluster"] == "response"
    )

    total_regulation = sum(
        activation[node]
        for node, attrs in G.nodes(data=True)
        if attrs["cluster"] == "regulation"
    )

    complex_pressure = total_affect + total_memory + total_response - total_regulation

    history.append(
        {
            "step": step,
            "total_affect": total_affect,
            "total_memory": total_memory,
            "total_response": total_response,
            "total_regulation": total_regulation,
            "complex_pressure": complex_pressure,
            **activation,
        }
    )

    activation = spread_activation(G, activation, external_inputs)

history_df = pd.DataFrame(history)

# ------------------------------------------------------------
# 4. Network diagnostics
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
    if col not in {
        "step",
        "total_affect",
        "total_memory",
        "total_response",
        "total_regulation",
        "complex_pressure",
    }
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
# 5. Export outputs
# ------------------------------------------------------------

history_df.to_csv(OUTPUT_DIR / "associative_complex_activation_history.csv", index=False)
centrality_df.to_csv(OUTPUT_DIR / "associative_complex_network_centrality.csv", index=False)
cluster_summary.to_csv(OUTPUT_DIR / "associative_complex_cluster_summary.csv", index=False)
recurrence_summary.to_csv(OUTPUT_DIR / "associative_complex_recurrence_summary.csv", index=False)
nx.to_pandas_edgelist(G).to_csv(OUTPUT_DIR / "associative_complex_edges.csv", index=False)

print("\nActivation history")
print(history_df)

print("\nNetwork centrality")
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
