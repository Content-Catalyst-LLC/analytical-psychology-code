# ============================================================
# Analytical Psychology and Literary Interpretation
# R Workflow: Symbolic Density and Archetypal Clustering
# ============================================================

library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(stringr)
library(purrr)

article_dir <- "articles/analytical-psychology-and-literary-interpretation"
corpus_path <- file.path(article_dir, "data/raw/literary_symbol_corpus.csv")
dictionary_path <- file.path(article_dir, "data/raw/motif_dictionary.csv")

output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

texts <- read_csv(corpus_path, show_col_types = FALSE)
motif_dictionary <- read_csv(dictionary_path, show_col_types = FALSE)

motif_terms <- motif_dictionary$motif

tokens <- texts |>
  mutate(text_clean = str_to_lower(text)) |>
  mutate(text_clean = str_replace_all(text_clean, "[^a-z\\s]", " ")) |>
  mutate(tokens = str_split(text_clean, "\\s+")) |>
  select(doc_id, genre, period, author, title, tokens) |>
  unnest(tokens) |>
  filter(tokens != "")

motif_counts <- tokens |>
  filter(tokens %in% motif_terms) |>
  count(doc_id, genre, period, author, title, tokens, name = "count") |>
  rename(motif = tokens) |>
  left_join(motif_dictionary, by = "motif")

doc_lengths <- tokens |>
  count(doc_id, name = "total_tokens")

symbolic_density <- motif_counts |>
  group_by(doc_id, genre, period, author, title) |>
  summarize(total_motifs = sum(count), .groups = "drop") |>
  left_join(doc_lengths, by = "doc_id") |>
  mutate(symbolic_density = total_motifs / total_tokens) |>
  arrange(desc(symbolic_density))

cluster_summary <- motif_counts |>
  group_by(period, genre, cluster) |>
  summarize(total = sum(count), .groups = "drop") |>
  arrange(desc(total))

motif_summary <- motif_counts |>
  group_by(period, genre, motif, cluster) |>
  summarize(total = sum(count), .groups = "drop") |>
  arrange(desc(total))

# Build document-level co-occurrence pairs.
doc_motifs <- motif_counts |>
  group_by(doc_id) |>
  summarize(motifs = list(sort(unique(motif))), .groups = "drop")

cooc_edges <- doc_motifs |>
  mutate(pairs = map(motifs, ~ {
    if (length(.x) < 2) {
      tibble(source = character(), target = character())
    } else {
      as_tibble(t(combn(.x, 2)), .name_repair = "minimal") |>
        setNames(c("source", "target"))
    }
  })) |>
  select(doc_id, pairs) |>
  unnest(pairs) |>
  count(source, target, name = "weight") |>
  arrange(desc(weight))

# Simple interpretive proxy metrics.
interpretive_scores <- symbolic_density |>
  mutate(
    formal_centrality_proxy = pmin(symbolic_density * 1.8, 1),
    affective_charge_proxy = pmin(total_motifs / max(total_motifs), 1),
    historical_specificity_proxy = case_when(
      period %in% c("traditional", "ancient", "medieval") ~ 0.80,
      period %in% c("nineteenth_century", "early_modern") ~ 0.75,
      TRUE ~ 0.70
    ),
    reductive_overgeneralization_proxy = 0.25,
    interpretive_depth_proxy =
      0.35 * symbolic_density +
      0.25 * formal_centrality_proxy +
      0.20 * affective_charge_proxy +
      0.20 * historical_specificity_proxy -
      0.30 * reductive_overgeneralization_proxy
  ) |>
  arrange(desc(interpretive_depth_proxy))

write_csv(motif_summary, file.path(output_dir, "motif_summary_by_period_genre.csv"))
write_csv(cluster_summary, file.path(output_dir, "cluster_summary_by_period_genre.csv"))
write_csv(symbolic_density, file.path(output_dir, "symbolic_density_by_document.csv"))
write_csv(cooc_edges, file.path(output_dir, "motif_cooccurrence_edges.csv"))
write_csv(interpretive_scores, file.path(output_dir, "interpretive_depth_proxy_scores.csv"))

density_plot <- ggplot(
  symbolic_density,
  aes(x = reorder(title, symbolic_density), y = symbolic_density)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Symbolic Density by Literary Text",
    subtitle = "Motif density is a prompt for close reading, not an interpretation by itself",
    x = "Synthetic text",
    y = "Symbolic density"
  ) +
  theme_minimal()

cluster_plot <- ggplot(
  cluster_summary,
  aes(x = reorder(cluster, total), y = total)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Archetypal-Motif Cluster Frequency",
    subtitle = "Cluster counts identify possible symbolic neighborhoods for interpretation",
    x = "Motif cluster",
    y = "Total motif count"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "symbolic_density_by_document.png"), density_plot, width = 9, height = 5, dpi = 300)
ggsave(file.path(figure_dir, "motif_cluster_frequency.png"), cluster_plot, width = 9, height = 5, dpi = 300)

print(symbolic_density)
print(cluster_summary)
print(cooc_edges)
print(interpretive_scores)
