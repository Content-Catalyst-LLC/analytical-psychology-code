# ============================================================
# The Collective Unconscious: Meaning, Scope, and Controversy
# R Workflow: Symbolic recurrence across textual corpora
# ============================================================
#
# Responsible-use note:
# This workflow is for synthetic-data demonstration and symbolic-pattern
# research methods. It does not prove the collective unconscious, diagnose
# people, interpret private dreams, or replace cultural, historical, clinical,
# or religious scholarship.

library(tidyverse)
library(tidytext)
library(igraph)
library(ggraph)

set.seed(2026)

article_dir <- "articles/the-collective-unconscious-meaning-scope-and-controversy"
corpus_path <- file.path(article_dir, "data/raw/symbolic_corpora.csv")
motif_path <- file.path(article_dir, "data/raw/motif_dictionary.csv")
output_tables <- file.path(article_dir, "outputs/tables")
output_figures <- file.path(article_dir, "outputs/figures")

dir.create(output_tables, recursive = TRUE, showWarnings = FALSE)
dir.create(output_figures, recursive = TRUE, showWarnings = FALSE)

texts <- read_csv(corpus_path, show_col_types = FALSE)
motif_dictionary <- read_csv(motif_path, show_col_types = FALSE)
motif_terms <- motif_dictionary$motif

tokens_clean <- texts |>
  unnest_tokens(word, text) |>
  anti_join(stop_words, by = "word")

motif_counts <- tokens_clean |>
  filter(word %in% motif_terms) |>
  count(doc_id, source_type, culture_group, word, name = "count")

motif_summary <- motif_counts |>
  group_by(source_type, culture_group, word) |>
  summarize(total = sum(count), .groups = "drop") |>
  arrange(desc(total), source_type, culture_group)

doc_motifs <- motif_counts |>
  group_by(doc_id) |>
  summarize(motifs = list(unique(word)), .groups = "drop")

cooc_edges <- doc_motifs |>
  mutate(pairs = map(motifs, ~ {
    if (length(.x) < 2) {
      tibble(from = character(), to = character())
    } else {
      as_tibble(t(combn(sort(.x), 2)), .name_repair = "minimal") |>
        rename(from = V1, to = V2)
    }
  })) |>
  select(doc_id, pairs) |>
  unnest(pairs) |>
  count(from, to, name = "weight") |>
  filter(weight >= 1)

nodes <- tibble(name = unique(c(cooc_edges$from, cooc_edges$to)))

motif_graph <- graph_from_data_frame(
  d = cooc_edges,
  vertices = nodes,
  directed = FALSE
)

metrics <- tibble(
  motif = V(motif_graph)$name,
  degree = degree(motif_graph),
  strength = strength(motif_graph, weights = E(motif_graph)$weight),
  betweenness = betweenness(motif_graph, weights = 1 / E(motif_graph)$weight)
) |>
  left_join(motif_dictionary, by = c("motif" = "motif")) |>
  arrange(desc(betweenness), desc(strength))

communities <- cluster_louvain(motif_graph, weights = E(motif_graph)$weight)

cluster_table <- tibble(
  motif = V(motif_graph)$name,
  cluster_id = membership(communities)
) |>
  left_join(motif_dictionary, by = c("motif" = "motif")) |>
  arrange(cluster_id, motif)

cluster_summary <- metrics |>
  group_by(cluster) |>
  summarize(
    motif_count = n(),
    mean_degree = mean(degree),
    mean_strength = mean(strength),
    mean_betweenness = mean(betweenness),
    motifs = paste(sort(motif), collapse = ", "),
    .groups = "drop"
  ) |>
  arrange(desc(mean_strength))

source_matrix <- motif_counts |>
  group_by(word, source_type) |>
  summarize(total = sum(count), .groups = "drop") |>
  pivot_wider(names_from = source_type, values_from = total, values_fill = 0) |>
  arrange(word)

plot_obj <- ggraph(motif_graph, layout = "fr") +
  geom_edge_link(aes(width = weight), alpha = 0.25) +
  geom_node_point(size = 4) +
  geom_node_text(aes(label = name), repel = TRUE, size = 3) +
  scale_edge_width(range = c(0.3, 2.5)) +
  labs(
    title = "Synthetic Symbolic Motif Co-Occurrence Network",
    subtitle = "Recurring symbolic motifs can be mapped, but recurrence requires contextual interpretation"
  ) +
  theme_void()

ggsave(
  filename = file.path(output_figures, "collective_unconscious_motif_network.png"),
  plot = plot_obj,
  width = 10,
  height = 7,
  dpi = 300
)

write_csv(motif_summary, file.path(output_tables, "motif_summary_by_context.csv"))
write_csv(metrics, file.path(output_tables, "motif_network_metrics.csv"))
write_csv(cluster_table, file.path(output_tables, "motif_clusters.csv"))
write_csv(cluster_summary, file.path(output_tables, "motif_cluster_summary.csv"))
write_csv(cooc_edges, file.path(output_tables, "motif_cooccurrence_edges.csv"))
write_csv(source_matrix, file.path(output_tables, "motif_by_source_matrix.csv"))

print(motif_summary)
print(metrics)
print(cluster_table)
print(cluster_summary)

cat("\nInterpretive guardrails:\n")
cat("- Co-occurrence is not proof of the collective unconscious.\n")
cat("- Motif recurrence must be compared against genre, transmission, culture, and context.\n")
cat("- Network clusters support interpretation; they do not replace it.\n")
cat("- Similar motifs may perform different symbolic functions in different traditions.\n")
