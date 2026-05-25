"""
Carl Jung and the Formation of Analytical Psychology
Python Workflow: Concept diffusion in Jungian thought

Synthetic-data demonstration only.
This workflow does not prove historical influence, authorship priority,
or interpretive authority. It provides a scaffold for reproducible
conceptual-network analysis.
"""

from pathlib import Path
import pandas as pd
import networkx as nx

ARTICLE_DIR = Path("articles/carl-jung-and-the-formation-of-analytical-psychology")
DATA_DIR = ARTICLE_DIR / "data/raw"
OUTPUT_DIR = ARTICLE_DIR / "outputs/tables"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

concepts = pd.read_csv(DATA_DIR / "jung_concepts.csv")
edges = pd.read_csv(DATA_DIR / "jung_concept_edges.csv")
period_weights = pd.read_csv(DATA_DIR / "jung_period_weights.csv")

# ------------------------------------------------------------
# 1. Build graph
# ------------------------------------------------------------

G = nx.Graph()

for _, row in concepts.iterrows():
    G.add_node(
        row["concept"],
        period=row["period"],
        domain=row["domain"],
        description=row["description"],
        interpretive_caution=row["interpretive_caution"],
    )

for _, row in edges.iterrows():
    for node in [row["source"], row["target"]]:
        if node not in G:
            G.add_node(
                node,
                period="auxiliary",
                domain="auxiliary",
                description="Auxiliary concept used to connect the synthetic network.",
                interpretive_caution="Interpret auxiliary nodes cautiously.",
            )

    G.add_edge(
        row["source"],
        row["target"],
        weight=float(row["weight"]),
        phase=row["phase"],
        notes=row["notes"],
    )

# ------------------------------------------------------------
# 2. Compute centrality metrics
# ------------------------------------------------------------

degree_centrality = nx.degree_centrality(G)
betweenness_centrality = nx.betweenness_centrality(G, weight="weight")
eigenvector_centrality = nx.eigenvector_centrality_numpy(G, weight="weight")
pagerank = nx.pagerank(G, weight="weight")

metrics = pd.DataFrame(
    {
        "node": list(G.nodes()),
        "period": [G.nodes[n].get("period", "unknown") for n in G.nodes()],
        "domain": [G.nodes[n].get("domain", "unknown") for n in G.nodes()],
        "degree_centrality": [degree_centrality[n] for n in G.nodes()],
        "betweenness_centrality": [betweenness_centrality[n] for n in G.nodes()],
        "eigenvector_centrality": [eigenvector_centrality[n] for n in G.nodes()],
        "pagerank": [pagerank[n] for n in G.nodes()],
        "interpretive_caution": [G.nodes[n].get("interpretive_caution", "") for n in G.nodes()],
    }
).sort_values(["betweenness_centrality", "degree_centrality"], ascending=[False, False])

# ------------------------------------------------------------
# 3. Model phase-weighted concept activation
# ------------------------------------------------------------

activation_rows = []

weight_records = period_weights.to_dict(orient="records")

for weight_row in weight_records:
    phase = weight_row["phase"]

    for node in G.nodes():
        domain = G.nodes[node].get("domain", "auxiliary")
        base = float(weight_row.get(domain, 0.30)) if domain in weight_row else 0.30
        centrality_boost = 0.60 * degree_centrality[node] + 0.40 * pagerank[node]
        activation = base + centrality_boost

        activation_rows.append(
            {
                "phase": phase,
                "node": node,
                "domain": domain,
                "domain_weight": base,
                "activation": activation,
            }
        )

activation_df = pd.DataFrame(activation_rows)

phase_summary = (
    activation_df.groupby(["phase", "domain"], as_index=False)
    .agg(
        mean_activation=("activation", "mean"),
        max_activation=("activation", "max"),
        concept_count=("node", "count"),
    )
    .sort_values(["phase", "mean_activation"], ascending=[True, False])
)

# ------------------------------------------------------------
# 4. Edge and domain outputs
# ------------------------------------------------------------

edges_out = nx.to_pandas_edgelist(G)

domain_summary = (
    metrics.groupby("domain", as_index=False)
    .agg(
        node_count=("node", "count"),
        mean_degree_centrality=("degree_centrality", "mean"),
        mean_betweenness_centrality=("betweenness_centrality", "mean"),
        mean_eigenvector_centrality=("eigenvector_centrality", "mean"),
        mean_pagerank=("pagerank", "mean"),
    )
    .sort_values("mean_betweenness_centrality", ascending=False)
)

# ------------------------------------------------------------
# 5. Export outputs
# ------------------------------------------------------------

metrics.to_csv(OUTPUT_DIR / "jung_concept_network_metrics.csv", index=False)
edges_out.to_csv(OUTPUT_DIR / "jung_concept_network_edges.csv", index=False)
activation_df.to_csv(OUTPUT_DIR / "jung_concept_phase_activation.csv", index=False)
phase_summary.to_csv(OUTPUT_DIR / "jung_concept_phase_summary.csv", index=False)
domain_summary.to_csv(OUTPUT_DIR / "jung_concept_domain_summary.csv", index=False)

print("\nConcept network metrics")
print(metrics)

print("\nDomain summary")
print(domain_summary)

print("\nPhase activation summary")
print(phase_summary)

print("\nInterpretive guardrails:")
print("- Concept centrality is not proof of historical importance.")
print("- Synthetic networks clarify assumptions; they do not replace close reading.")
print("- Historical formation requires textual, institutional, biographical, and cultural evidence.")
print("- Jungian concepts should be studied with attention to revision, critique, and context.")
