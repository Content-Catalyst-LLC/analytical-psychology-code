"""
Non-Western Symbol Systems and the Limits of Jungian Universality
Python Workflow: Layered cross-cultural symbol network

This script is a conceptual network demonstration.
It is not a tool for ranking traditions, measuring cultures,
validating archetypes, or interpreting sacred materials without context.
"""

from pathlib import Path
import networkx as nx
import pandas as pd

ARTICLE_DIR = Path("articles/non-western-symbol-systems-limits-jungian-universality")
OUT_METRICS = ARTICLE_DIR / "outputs" / "tables" / "layered_symbol_network_metrics.csv"
OUT_BRIDGES = ARTICLE_DIR / "outputs" / "tables" / "bridge_motifs.csv"
OUT_FLATTENING = ARTICLE_DIR / "outputs" / "tables" / "flattening_simulation.csv"

G = nx.Graph()

symbol_layers = {
    "south_asian": [
        "mandala",
        "lotus",
        "chakra",
        "sacred_mountain",
        "mantra",
        "river",
    ],
    "east_asian": [
        "dao",
        "yin_yang",
        "mirror",
        "immortal",
        "hexagram",
        "ancestor_tablet",
    ],
    "islamic": [
        "light",
        "garden",
        "heart",
        "calligraphy",
        "geometric_pattern",
        "journey",
    ],
    "indigenous": [
        "ancestor_presence",
        "animal_relation",
        "sacred_land",
        "ceremony",
        "story_cycle",
        "seasonal_protocol",
    ],
    "african": [
        "mask",
        "ancestor_king",
        "trickster",
        "initiation",
        "drum",
        "cosmogram",
    ],
    "diasporic": [
        "crossroads",
        "coded_song",
        "ritual_circle",
        "protective_sign",
        "memory_object",
        "spirit_house",
    ],
}

for layer, symbols in symbol_layers.items():
    for symbol in symbols:
        G.add_node(symbol, layer=layer)

local_edges = [
    ("mandala", "lotus"), ("lotus", "chakra"), ("chakra", "sacred_mountain"),
    ("mantra", "mandala"), ("river", "sacred_mountain"),

    ("dao", "yin_yang"), ("yin_yang", "hexagram"), ("hexagram", "mirror"),
    ("mirror", "immortal"), ("ancestor_tablet", "dao"),

    ("light", "heart"), ("heart", "garden"), ("garden", "calligraphy"),
    ("calligraphy", "geometric_pattern"), ("journey", "heart"),

    ("ancestor_presence", "animal_relation"), ("animal_relation", "sacred_land"),
    ("sacred_land", "ceremony"), ("ceremony", "story_cycle"),
    ("story_cycle", "seasonal_protocol"),

    ("mask", "ancestor_king"), ("ancestor_king", "trickster"),
    ("trickster", "initiation"), ("initiation", "drum"),
    ("drum", "cosmogram"),

    ("crossroads", "coded_song"), ("coded_song", "ritual_circle"),
    ("ritual_circle", "protective_sign"), ("protective_sign", "memory_object"),
    ("memory_object", "spirit_house"),
]

for source, target in local_edges:
    G.add_edge(source, target, relation="local", weight=1.0)

bridge_edges = [
    ("mandala", "geometric_pattern"),
    ("mandala", "ritual_circle"),
    ("sacred_mountain", "sacred_land"),
    ("heart", "ancestor_presence"),
    ("trickster", "crossroads"),
    ("trickster", "animal_relation"),
    ("light", "lotus"),
    ("journey", "sacred_mountain"),
    ("cosmogram", "geometric_pattern"),
    ("drum", "coded_song"),
    ("ancestor_tablet", "ancestor_presence"),
    ("mirror", "heart"),
]

for source, target in bridge_edges:
    G.add_edge(source, target, relation="bridge", weight=0.35)

degree = nx.degree_centrality(G)
betweenness = nx.betweenness_centrality(G, weight="weight")
clustering = nx.clustering(G, weight="weight")

metrics = pd.DataFrame(
    {
        "symbol": list(G.nodes()),
        "layer": [G.nodes[n]["layer"] for n in G.nodes()],
        "degree_centrality": [degree[n] for n in G.nodes()],
        "betweenness_centrality": [betweenness[n] for n in G.nodes()],
        "local_clustering": [clustering[n] for n in G.nodes()],
    }
).sort_values(["betweenness_centrality", "degree_centrality"], ascending=False)

edge_summary = pd.DataFrame(
    [
        {
            "source": source,
            "target": target,
            "relation": data["relation"],
            "weight": data["weight"],
            "source_layer": G.nodes[source]["layer"],
            "target_layer": G.nodes[target]["layer"],
        }
        for source, target, data in G.edges(data=True)
    ]
)

bridge_summary = edge_summary[edge_summary["relation"] == "bridge"].sort_values(
    ["source_layer", "target_layer", "source", "target"]
)

G_flattened = G.copy()

for source, target, data in G_flattened.edges(data=True):
    if data["relation"] == "bridge":
        data["weight"] = 1.0

flattened_betweenness = nx.betweenness_centrality(G_flattened, weight="weight")

flattening_metrics = pd.DataFrame(
    {
        "symbol": list(G_flattened.nodes()),
        "layer": [G_flattened.nodes[n]["layer"] for n in G_flattened.nodes()],
        "original_betweenness": [betweenness[n] for n in G_flattened.nodes()],
        "flattened_betweenness": [flattened_betweenness[n] for n in G_flattened.nodes()],
    }
)

flattening_metrics["betweenness_change"] = (
    flattening_metrics["flattened_betweenness"] -
    flattening_metrics["original_betweenness"]
)

OUT_METRICS.parent.mkdir(parents=True, exist_ok=True)
metrics.to_csv(OUT_METRICS, index=False)
bridge_summary.to_csv(OUT_BRIDGES, index=False)
flattening_metrics.sort_values("betweenness_change", ascending=False).to_csv(
    OUT_FLATTENING,
    index=False,
)

print("Layered symbol network metrics")
print(metrics)
print("\nBridge motifs")
print(bridge_summary)
print("\nFlattening simulation")
print(flattening_metrics.sort_values("betweenness_change", ascending=False))
print(f"\nSaved metrics to: {OUT_METRICS}")
print(f"Saved bridge summary to: {OUT_BRIDGES}")
print(f"Saved flattening simulation to: {OUT_FLATTENING}")
