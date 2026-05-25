# ============================================================
# Carl Jung and the Formation of Analytical Psychology
# R Workflow: Mapping Jung's conceptual development
# ============================================================
#
# Synthetic-data demonstration only.
# This workflow does not prove historical influence or interpretive priority.
# It provides a reproducible scaffold for conceptual network analysis.

library(tidyverse)
library(tidygraph)
library(ggraph)
library(igraph)

set.seed(2026)

article_dir <- "articles/carl-jung-and-the-formation-of-analytical-psychology"
concept_path <- file.path(article_dir, "data/raw/jung_concepts.csv")
edge_path <- file.path(article_dir, "data/raw/jung_concept_edges.csv")
weights_path <- file.path(article_dir, "data/raw/jung_period_weights.csv")
output_tables <- file.path(article_dir, "outputs/tables")
output_figures <- file.path(article_dir, "outputs/figures")

dir.create(output_tables, recursive = TRUE, showWarnings = FALSE)
dir.create(output_figures, recursive = TRUE, showWarnings = FALSE)

jung_concepts <- read_csv(concept_path, show_col_types = FALSE)
jung_edges <- read_csv(edge_path, show_col_types = FALSE)
period_weights <- read_csv(weights_path, show_col_types = FALSE)

# Add auxiliary nodes from edges that are not already listed.
all_nodes <- tibble(concept = unique(c(jung_edges$source, jung_edges$target)))

nodes <- all_nodes |>
  left_join(jung_concepts, by = "concept") |>
  mutate(
    period = replace_na(period, "auxiliary"),
    domain = replace_na(domain, "auxiliary"),
    description = replace_na(description, "Auxiliary concept used to connect the synthetic network."),
    interpretive_caution = replace_na(interpretive_caution, "Interpret auxiliary nodes cautiously.")
  )

jung_graph <- tbl_graph(
  nodes = nodes,
  edges = jung_edges |>
    rename(from = source, to = target),
  directed = FALSE
)

jung_graph <- jung_graph |>
  activate(nodes) |>
  mutate(
    degree = centrality_degree(),
    betweenness = centrality_betweenness(),
    eigen = centrality_eigen(),
    page_rank = centrality_pagerank()
  )

node_metrics <- jung_graph |>
  activate(nodes) |>
  as_tibble() |>
  arrange(desc(betweenness), desc(degree))

edge_metrics <- jung_graph |>
  activate(edges) |>
  as_tibble() |>
  arrange(desc(weight))

domain_summary <- node_metrics |>
  group_by(domain) |>
  summarize(
    concept_count = n(),
    mean_degree = mean(degree, na.rm = TRUE),
    mean_betweenness = mean(betweenness, na.rm = TRUE),
    mean_eigen = mean(eigen, na.rm = TRUE),
    mean_page_rank = mean(page_rank, na.rm = TRUE),
    .groups = "drop"
  ) |>
  arrange(desc(mean_betweenness))

# Create simple phase activation scores using domain weights.
activation_rows <- crossing(
  phase = period_weights$phase,
  node_metrics |>
    select(concept = name, domain, degree, betweenness, page_rank)
) |>
  left_join(period_weights, by = "phase") |>
  rowwise() |>
  mutate(
    domain_weight = case_when(
      domain == "clinical" ~ clinical,
      domain == "experimental" ~ experimental,
      domain == "symbolic" ~ symbolic,
      domain == "developmental" ~ developmental,
      domain == "comparative" ~ comparative,
      domain == "religion" ~ religion,
      domain == "method" ~ method,
      domain == "critical_revision" ~ critical_revision,
      TRUE ~ 0.30
    ),
    activation = domain_weight + 0.40 * degree + 0.20 * page_rank
  ) |>
  ungroup() |>
  select(phase, concept, domain, domain_weight, degree, betweenness, page_rank, activation)

phase_summary <- activation_rows |>
  group_by(phase, domain) |>
  summarize(
    concept_count = n(),
    mean_activation = mean(activation),
    max_activation = max(activation),
    .groups = "drop"
  ) |>
  arrange(phase, desc(mean_activation))

network_plot <- ggraph(jung_graph, layout = "fr") +
  geom_edge_link(aes(width = weight), alpha = 0.25) +
  geom_node_point(aes(size = degree)) +
  geom_node_text(aes(label = name), repel = TRUE, size = 3) +
  scale_edge_width(range = c(0.4, 2.5)) +
  labs(
    title = "Conceptual Network in the Formation of Analytical Psychology",
    subtitle = "Synthetic mapping of major Jungian concepts and relations"
  ) +
  theme_void()

print(node_metrics)
print(edge_metrics)
print(domain_summary)
print(phase_summary)
print(network_plot)

write_csv(node_metrics, file.path(output_tables, "jung_concept_node_metrics.csv"))
write_csv(edge_metrics, file.path(output_tables, "jung_concept_edge_metrics.csv"))
write_csv(domain_summary, file.path(output_tables, "jung_concept_domain_summary.csv"))
write_csv(activation_rows, file.path(output_tables, "jung_concept_phase_activation.csv"))
write_csv(phase_summary, file.path(output_tables, "jung_concept_phase_summary.csv"))

ggsave(
  filename = file.path(output_figures, "jung_conceptual_network.png"),
  plot = network_plot,
  width = 11,
  height = 8,
  dpi = 300
)

cat("\nInterpretive guardrails:\n")
cat("- Concept centrality is not proof of historical importance.\n")
cat("- Synthetic networks clarify assumptions; they do not replace close reading.\n")
cat("- Historical formation requires textual, institutional, biographical, and cultural evidence.\n")
cat("- Jungian concepts should be studied with attention to revision, critique, and context.\n")
