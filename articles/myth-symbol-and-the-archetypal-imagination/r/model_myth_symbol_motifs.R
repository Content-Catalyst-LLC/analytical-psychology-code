# ============================================================
# Myth, Symbol, and the Archetypal Imagination
# R Workflow: Recurrent mythic motifs across symbolic corpora
# ============================================================

library(dplyr)
library(readr)
library(tidyr)
library(tidytext)
library(igraph)
library(ggraph)
library(widyr)
library(ggplot2)

article_dir <- "articles/myth-symbol-and-the-archetypal-imagination"
corpus_path <- file.path(article_dir, "data/raw/myth_symbol_corpus.csv")
dictionary_path <- file.path(article_dir, "data/raw/motif_dictionary.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

texts <- read_csv(corpus_path, show_col_types = FALSE)
motif_dictionary <- read_csv(dictionary_path, show_col_types = FALSE)

# ------------------------------------------------------------
# Tokenize and join terms to motifs
# ------------------------------------------------------------

tokens <- texts |>
  unnest_tokens(word, text) |>
  anti_join(stop_words, by = "word") |>
  inner_join(motif_dictionary, by = c("word" = "term"))

motif_counts <- tokens |>
  count(doc_id, source_type, culture_group, time_period, title, motif, cluster, name = "count")

# ------------------------------------------------------------
# Summarize motif prevalence by source and context
# ------------------------------------------------------------

motif_summary <- motif_counts |>
  group_by(source_type, culture_group, time_period, motif, cluster) |>
  summarize(total = sum(count), .groups = "drop") |>
  arrange(desc(total))

# ------------------------------------------------------------
# Build document-level motif co-occurrence
# ------------------------------------------------------------

motif_pairs <- motif_counts |>
  pairwise_count(
    item = motif,
    feature = doc_id,
    wt = count,
    sort = TRUE,
    upper = FALSE
  ) |>
  filter(n >= 1)

if (nrow(motif_pairs) > 0) {
  motif_graph <- graph_from_data_frame(
    motif_pairs,
    directed = FALSE
  )

  motif_metrics <- tibble(
    motif = names(degree(motif_graph)),
    degree = as.numeric(degree(motif_graph)),
    weighted_degree = as.numeric(strength(motif_graph, weights = E(motif_graph)$n)),
    betweenness = as.numeric(betweenness(motif_graph, weights = E(motif_graph)$n))
  ) |>
    arrange(desc(betweenness), desc(weighted_degree))

  cluster_membership <- cluster_louvain(motif_graph)

  cluster_table <- tibble(
    motif = names(membership(cluster_membership)),
    cluster_id = as.integer(membership(cluster_membership))
  )

  network_plot <- ggraph(motif_graph, layout = "fr") +
    geom_edge_link(aes(width = n), alpha = 0.25) +
    geom_node_point(size = 4) +
    geom_node_text(aes(label = name), repel = TRUE) +
    theme_void() +
    labs(
      title = "Symbolic Motif Co-occurrence Network",
      subtitle = "Motifs cluster through repeated co-occurrence across a defined symbolic corpus"
    )

  ggsave(
    file.path(figure_dir, "symbolic_motif_network.png"),
    network_plot,
    width = 10,
    height = 7,
    dpi = 300
  )
} else {
  motif_metrics <- tibble()
  cluster_table <- tibble()
}

# ------------------------------------------------------------
# Compare recurrence and context dependence
# ------------------------------------------------------------

context_dependence <- motif_counts |>
  group_by(motif, cluster, source_type, culture_group) |>
  summarize(total = sum(count), .groups = "drop") |>
  group_by(motif, cluster) |>
  mutate(
    motif_total = sum(total),
    context_share = total / motif_total
  ) |>
  arrange(motif, desc(context_share))

source_profile <- motif_counts |>
  group_by(source_type, motif, cluster) |>
  summarize(total = sum(count), .groups = "drop") |>
  group_by(source_type) |>
  mutate(source_share = total / sum(total)) |>
  arrange(source_type, desc(source_share))

political_myth_profile <- motif_counts |>
  filter(source_type == "political_speech_synthetic") |>
  group_by(motif, cluster) |>
  summarize(total = sum(count), .groups = "drop") |>
  arrange(desc(total))

# ------------------------------------------------------------
# Export outputs
# ------------------------------------------------------------

write_csv(motif_counts, file.path(output_dir, "motif_document_counts.csv"))
write_csv(motif_summary, file.path(output_dir, "motif_summary_by_context.csv"))
write_csv(motif_pairs, file.path(output_dir, "motif_cooccurrence_pairs.csv"))
write_csv(motif_metrics, file.path(output_dir, "motif_network_metrics.csv"))
write_csv(cluster_table, file.path(output_dir, "motif_cluster_table.csv"))
write_csv(context_dependence, file.path(output_dir, "motif_context_dependence.csv"))
write_csv(source_profile, file.path(output_dir, "motif_source_profile.csv"))
write_csv(political_myth_profile, file.path(output_dir, "political_myth_profile.csv"))

print(motif_summary)
print(motif_metrics)
print(context_dependence)
print(political_myth_profile)
