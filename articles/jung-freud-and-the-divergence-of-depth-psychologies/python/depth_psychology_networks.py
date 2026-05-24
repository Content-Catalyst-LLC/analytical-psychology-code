"""
Jung, Freud, and the Divergence of Depth Psychologies
Python Workflow: Freudian and Jungian concept networks

This script is a conceptual network demonstration.
It is not a clinical, diagnostic, or empirical validation tool.
"""

from pathlib import Path
import networkx as nx
import pandas as pd

ARTICLE_DIR = Path("articles/jung-freud-and-the-divergence-of-depth-psychologies")
OUT_CENTRALITY = ARTICLE_DIR / "outputs" / "tables" / "framework_centrality_comparison.csv"
OUT_BRIDGE = ARTICLE_DIR / "outputs" / "tables" / "bridge_network_centrality.csv"
OUT_EDGES = ARTICLE_DIR / "outputs" / "tables" / "conceptual_edges.csv"

# ------------------------------------------------------------
# Build Freudian network
# ------------------------------------------------------------

F = nx.DiGraph()

freud_nodes = {
    "repression": "conflict",
    "sexuality": "drive",
    "infantile_history": "development",
    "defense": "conflict",
    "wish": "drive",
    "symptom": "clinical",
    "transference": "clinical",
    "dream_disguise": "dream",
    "latent_content": "dream",
    "resistance": "clinical",
    "working_through": "therapy",
}

for node, node_type in freud_nodes.items():
    F.add_node(node, node_type=node_type, framework="Freud")

freud_edges = [
    ("sexuality", "repression", 0.64),
    ("infantile_history", "symptom", 0.70),
    ("repression", "dream_disguise", 0.62),
    ("wish", "dream_disguise", 0.56),
    ("dream_disguise", "latent_content", 0.52),
    ("defense", "symptom", 0.58),
    ("resistance", "working_through", 0.50),
    ("transference", "working_through", 0.54),
    ("transference", "symptom", 0.44),
    ("repression", "resistance", 0.48),
]

for source, target, weight in freud_edges:
    F.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Build Jungian network
# ------------------------------------------------------------

J = nx.DiGraph()

jung_nodes = {
    "compensation": "dream",
    "archetype": "symbol",
    "myth": "symbol",
    "symbol": "symbol",
    "collective_unconscious": "unconscious",
    "individuation": "development",
    "dream_image": "dream",
    "self": "development",
    "shadow": "clinical",
    "persona": "clinical",
    "active_imagination": "therapy",
    "amplification": "method",
}

for node, node_type in jung_nodes.items():
    J.add_node(node, node_type=node_type, framework="Jung")

jung_edges = [
    ("collective_unconscious", "archetype", 0.62),
    ("archetype", "symbol", 0.64),
    ("myth", "symbol", 0.54),
    ("dream_image", "compensation", 0.58),
    ("symbol", "individuation", 0.56),
    ("self", "individuation", 0.66),
    ("shadow", "individuation", 0.48),
    ("persona", "shadow", 0.42),
    ("active_imagination", "individuation", 0.44),
    ("amplification", "symbol", 0.52),
    ("dream_image", "amplification", 0.50),
]

for source, target, weight in jung_edges:
    J.add_edge(source, target, weight=weight)

# ------------------------------------------------------------
# Summaries
# ------------------------------------------------------------

def summarize_graph(graph, label):
    degree = nx.degree_centrality(graph)
    in_degree = nx.in_degree_centrality(graph)
    out_degree = nx.out_degree_centrality(graph)
    betweenness = nx.betweenness_centrality(graph, weight="weight")

    return pd.DataFrame(
        {
            "framework": label,
            "node": list(graph.nodes()),
            "node_type": [graph.nodes[n]["node_type"] for n in graph.nodes()],
            "degree_centrality": [degree[n] for n in graph.nodes()],
            "in_degree_centrality": [in_degree[n] for n in graph.nodes()],
            "out_degree_centrality": [out_degree[n] for n in graph.nodes()],
            "betweenness_centrality": [betweenness[n] for n in graph.nodes()],
        }
    )

centrality_df = pd.concat(
    [
        summarize_graph(F, "Freud"),
        summarize_graph(J, "Jung"),
    ],
    ignore_index=True,
).sort_values(
    ["framework", "betweenness_centrality", "degree_centrality"],
    ascending=[True, False, False],
)

# ------------------------------------------------------------
# Bridge network
# ------------------------------------------------------------

B = nx.DiGraph()
B.add_nodes_from(F.nodes(data=True))
B.add_nodes_from(J.nodes(data=True))
B.add_edges_from(F.edges(data=True))
B.add_edges_from(J.edges(data=True))

bridge_edges = [
    ("dream_disguise", "dream_image", 0.30),
    ("latent_content", "symbol", 0.24),
    ("transference", "active_imagination", 0.18),
    ("symptom", "shadow", 0.28),
    ("working_through", "individuation", 0.22),
    ("infantile_history", "persona", 0.20),
    ("repression", "compensation", 0.26),
]

for source, target, weight in bridge_edges:
    B.add_edge(source, target, weight=weight, relation="bridge")

bridge_degree = nx.degree_centrality(B)
bridge_betweenness = nx.betweenness_centrality(B, weight="weight")

bridge_df = pd.DataFrame(
    {
        "node": list(B.nodes()),
        "framework": [B.nodes[n].get("framework", "bridge") for n in B.nodes()],
        "node_type": [B.nodes[n].get("node_type", "unknown") for n in B.nodes()],
        "degree_centrality": [bridge_degree[n] for n in B.nodes()],
        "betweenness_centrality": [bridge_betweenness[n] for n in B.nodes()],
    }
).sort_values(["betweenness_centrality", "degree_centrality"], ascending=False)

def edge_table(graph, label):
    rows = []
    for source, target, data in graph.edges(data=True):
        rows.append(
            {
                "framework": label,
                "source": source,
                "target": target,
                "weight": data["weight"],
            }
        )
    return pd.DataFrame(rows)

edges_df = pd.concat(
    [
        edge_table(F, "Freud"),
        edge_table(J, "Jung"),
        pd.DataFrame(
            [
                {
                    "framework": "Bridge",
                    "source": source,
                    "target": target,
                    "weight": weight,
                }
                for source, target, weight in bridge_edges
            ]
        ),
    ],
    ignore_index=True,
).sort_values(["framework", "weight"], ascending=[True, False])

OUT_CENTRALITY.parent.mkdir(parents=True, exist_ok=True)
centrality_df.to_csv(OUT_CENTRALITY, index=False)
bridge_df.to_csv(OUT_BRIDGE, index=False)
edges_df.to_csv(OUT_EDGES, index=False)

print("Framework centrality comparison")
print(centrality_df)
print("\nBridge network centrality")
print(bridge_df)
print("\nConceptual edges")
print(edges_df)
print(f"\nSaved framework centrality to: {OUT_CENTRALITY}")
print(f"Saved bridge centrality to: {OUT_BRIDGE}")
print(f"Saved conceptual edges to: {OUT_EDGES}")
