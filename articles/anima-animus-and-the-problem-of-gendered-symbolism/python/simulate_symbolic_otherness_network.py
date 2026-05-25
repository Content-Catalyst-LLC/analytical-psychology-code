"""
Anima, Animus, and the Problem of Gendered Symbolism
Python Workflow: Symbolic otherness and relational projection

Conceptual network demonstration only. Not for diagnosis, therapy,
gender assessment, sexuality assessment, treatment recommendation, or
proof of Jungian theory.
"""

from pathlib import Path
import numpy as np
import pandas as pd
import networkx as nx

np.random.seed(2026)

ARTICLE_DIR = Path("articles/anima-animus-and-the-problem-of-gendered-symbolism")
NODES_PATH = ARTICLE_DIR / "data/raw/symbolic_otherness_nodes.csv"
EDGES_PATH = ARTICLE_DIR / "data/raw/symbolic_otherness_edges.csv"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

nodes_df = pd.read_csv(NODES_PATH)
edges_df = pd.read_csv(EDGES_PATH)

G = nx.DiGraph()

for _, row in nodes_df.iterrows():
    G.add_node(row["node"], cluster=row["cluster"], activation=float(row["activation"]), notes=row["notes"])

for _, row in edges_df.iterrows():
    G.add_edge(row["source"], row["target"], weight=float(row["weight"]), notes=row["notes"])

history = []

for step in range(14):
    relational_cue = np.random.normal(0.80, 0.25)
    affective_charge = np.random.normal(0.65, 0.22)
    social_script_pressure = np.random.normal(0.50, 0.18)
    new_activations = {}

    for node in G.nodes():
        incoming = sum(
            G.nodes[p]["activation"] * G[p][node]["weight"]
            for p in G.predecessors(node)
        )

        base = G.nodes[node]["activation"]
        cluster = G.nodes[node]["cluster"]

        if node == "symbolic_other_figure":
            updated = base + 0.20 * relational_cue + 0.24 * affective_charge + 0.16 * social_script_pressure + 0.10 * incoming
        elif cluster == "social_coding":
            updated = base + 0.12 * social_script_pressure + 0.05 * incoming
        elif cluster == "reflection":
            updated = base + 0.06 * incoming - 0.05 * affective_charge
        elif cluster == "relationship":
            updated = base + 0.12 * relational_cue + 0.06 * incoming
        else:
            updated = base + 0.08 * incoming

        new_activations[node] = max(0.0, min(updated, 3.0))

    for node in G.nodes():
        G.nodes[node]["activation"] = new_activations[node]

    capacity_values = np.array([
        new_activations["relational_receptivity"],
        new_activations["judgment_authority"],
        new_activations["erotic_imagination"],
        new_activations["vulnerability"],
        new_activations["voice_and_assertion"],
        new_activations["care_and_tenderness"],
    ])

    symbolic_discrepancy = float(capacity_values.var())
    symbolic_other_activation = new_activations["symbolic_other_figure"]
    reflective_mediation = new_activations["reflective_mediation"]
    actual_other_activation = new_activations["actual_other_person"]
    gender_script_activation = new_activations["cultural_gender_script"]

    projection_intensity = (
        0.42 * symbolic_other_activation
        + 0.28 * affective_charge
        + 0.22 * relational_cue
        + 0.18 * gender_script_activation
        + 0.16 * symbolic_discrepancy
        - 0.36 * reflective_mediation
    )

    differentiation_index = (
        0.34 * reflective_mediation
        + 0.26 * actual_other_activation
        - 0.30 * symbolic_other_activation
        - 0.18 * gender_script_activation
    )

    history.append({
        "step": step,
        "relational_cue": relational_cue,
        "affective_charge": affective_charge,
        "social_script_pressure": social_script_pressure,
        "symbolic_discrepancy": symbolic_discrepancy,
        "projection_intensity": projection_intensity,
        "differentiation_index": differentiation_index,
        **new_activations,
    })

activation_df = pd.DataFrame(history)

centrality_df = pd.DataFrame({
    "node": list(G.nodes()),
    "cluster": [G.nodes[n]["cluster"] for n in G.nodes()],
    "betweenness": list(nx.betweenness_centrality(G, weight="weight").values()),
    "in_degree": [G.in_degree(n) for n in G.nodes()],
    "out_degree": [G.out_degree(n) for n in G.nodes()],
    "weighted_in_degree": [G.in_degree(n, weight="weight") for n in G.nodes()],
    "weighted_out_degree": [G.out_degree(n, weight="weight") for n in G.nodes()],
    "final_activation": [G.nodes[n]["activation"] for n in G.nodes()],
}).sort_values("betweenness", ascending=False)

cluster_rows = []
for cluster in sorted(set(nx.get_node_attributes(G, "cluster").values())):
    cluster_nodes = [n for n, attrs in G.nodes(data=True) if attrs["cluster"] == cluster]
    cluster_rows.append({
        "cluster": cluster,
        "node_count": len(cluster_nodes),
        "mean_final_activation": np.mean([G.nodes[n]["activation"] for n in cluster_nodes]),
        "nodes": ", ".join(cluster_nodes),
    })

cluster_df = pd.DataFrame(cluster_rows).sort_values("mean_final_activation", ascending=False)

projection_summary = activation_df[
    ["step", "projection_intensity", "differentiation_index", "symbolic_other_figure",
     "reflective_mediation", "actual_other_person", "cultural_gender_script",
     "symbolic_discrepancy"]
].copy()
projection_summary["projection_minus_differentiation"] = (
    projection_summary["projection_intensity"] - projection_summary["differentiation_index"]
)

activation_df.to_csv(OUTPUT_DIR / "symbolic_otherness_activation_history.csv", index=False)
centrality_df.to_csv(OUTPUT_DIR / "symbolic_otherness_network_centrality.csv", index=False)
cluster_df.to_csv(OUTPUT_DIR / "symbolic_otherness_cluster_summary.csv", index=False)
projection_summary.to_csv(OUTPUT_DIR / "projection_differentiation_summary.csv", index=False)
nx.to_pandas_edgelist(G).to_csv(OUTPUT_DIR / "symbolic_otherness_network_edges.csv", index=False)

print("Activation history")
print(activation_df)
print("\nCentrality")
print(centrality_df)
print("\nCluster summary")
print(cluster_df)
print("\nProjection summary")
print(projection_summary)
