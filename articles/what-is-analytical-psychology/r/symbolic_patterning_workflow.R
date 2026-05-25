# ============================================================
# What Is Analytical Psychology?
# R Workflow: Symbolic patterning across narrative and dream corpora
# ============================================================
#
# Synthetic-data demonstration only.
# This workflow does not prove archetypes, diagnose people, interpret
# private dreams, or replace close reading, clinical judgment, or cultural
# context. It provides a reproducible scaffold for symbolic-pattern analysis.

library(tidyverse)
library(tidytext)
library(tidygraph)
library(ggraph)
library(igraph)

set.seed(2026)

article_dir <- "articles/what-is-analytical-psychology"
corpus_path <- file.path(article_dir, "data/raw/symbolic_corpus.csv")
dictionary_path <- file.path(article_dir, "data/raw/symbol_dictionary.csv")
concept_path <- file.path(article_dir, "data/raw/analytical_psychology_concepts.csv")
output_tables <- file.path(article_dir, "outputs/tables")
output_figures <- file.path(article_dir, "outputs/figures")

dir.create(output_tables, recursive = TRUE, showWarnings = FALSE)
dir.create(output_figures, recursive = TRUE, showWarnings = FALSE)

texts <- read_csv(corpus_path, show_col_types = FALSE)
symbol_dictionary <- read_csv(dictionary_path, show_col_types = FALSE)
concepts <- read_csv(concept_path, show_col_types = FALSE)

# ------------------------------------------------------------
# 1. Tokenize and isolate symbolic terms
# ------------------------------------------------------------

tokens <- texts |>
  unnest_tokens(word, text)

symbol_counts <- tokens |>
  inner_join(symbol_dictionary, by = c("word" = "symbol")) |>
  count(document_id, source_type, phase, word, cluster, name = "count")

symbol_summary <- symbol_counts |>
  group_by(source_type, cluster, word) |>
  summarize(total = sum(count), .groups = "drop") |>
  arrange(desc(total), source_type, cluster)

phase_summary <- symbol_counts |>
  group_by(phase, cluster) |>
  summarize(total = sum(count), unique_symbols = n_distinct(word), .groups = "drop") |>
  arrange(phase, desc(total))

# ------------------------------------------------------------
# 2. Build symbolic co-occurrence network
# ------------------------------------------------------------

document_symbols <- symbol_counts |>
  group_by(document_id) |>
  summarize(symbols = list(unique(word)), .groups = "drop")

edges <- document_symbols |>
  mutate(pairs = map(symbols, function(x) {
    if (length(x) < 2) {
      tibble(from = character(), to = character())
    } else {
      as_tibble(t(combn(sort(x), 2)), .name_repair = "minimal") |>
        rename(from = V1, to = V2)
    }
  })) |>
  select(document_id, pairs) |>
  unnest(pairs) |>
  count(from, to, name = "weight")

nodes <- tibble(name = unique(c(edges$from, edges$to))) |>
  left_join(symbol_dictionary, by = c("name" = "symbol"))

symbol_graph <- tbl_graph(
  nodes = nodes,
  edges = edges,
  directed = FALSE
)

symbol_graph <- symbol_graph |>
  activate(nodes) |>
  mutate(
    degree = centrality_degree(),
    betweenness = centrality_betweenness(),
    eigen = centrality_eigen()
  )

node_metrics <- symbol_graph |>
  activate(nodes) |>
  as_tibble() |>
  arrange(desc(betweenness), desc(degree))

cluster_summary <- node_metrics |>
  group_by(cluster) |>
  summarize(
    symbol_count = n(),
    mean_degree = mean(degree, na.rm = TRUE),
    mean_betweenness = mean(betweenness, na.rm = TRUE),
    symbols = paste(sort(name), collapse = ", "),
    .groups = "drop"
  ) |>
  arrange(desc(mean_betweenness))

# ------------------------------------------------------------
# 3. Plot network
# ------------------------------------------------------------

network_plot <- ggraph(symbol_graph, layout = "fr") +
  geom_edge_link(aes(width = weight), alpha = 0.25) +
  geom_node_point(aes(size = degree)) +
  geom_node_text(aes(label = name), repel = TRUE, size = 3) +
  scale_edge_width(range = c(0.4, 2.5)) +
  labs(
    title = "Synthetic Symbolic Association Network",
    subtitle = "Co-occurrence patterns support interpretation; they do not prove archetypes"
  ) +
  theme_void()

# ------------------------------------------------------------
# 4. Export outputs
# ------------------------------------------------------------

write_csv(symbol_counts, file.path(output_tables, "symbol_document_counts.csv"))
write_csv(symbol_summary, file.path(output_tables, "symbol_summary_by_source.csv"))
write_csv(phase_summary, file.path(output_tables, "symbol_summary_by_phase.csv"))
write_csv(edges, file.path(output_tables, "symbol_cooccurrence_edges.csv"))
write_csv(node_metrics, file.path(output_tables, "symbol_network_node_metrics.csv"))
write_csv(cluster_summary, file.path(output_tables, "symbol_cluster_summary.csv"))
write_csv(concepts, file.path(output_tables, "analytical_psychology_concepts.csv"))

ggsave(
  filename = file.path(output_figures, "symbolic_association_network.png"),
  plot = network_plot,
  width = 11,
  height = 8,
  dpi = 300
)

print(symbol_summary)
print(phase_summary)
print(node_metrics)
print(cluster_summary)

cat("\nInterpretive guardrails:\n")
cat("- Symbol recurrence is not proof of archetypal universality.\n")
cat("- Personal association, cultural context, and historical specificity come first.\n")
cat("- Network analysis can support interpretation but cannot replace it.\n")
cat("- Do not interpret private or clinical material without consent and ethical review.\n")
