# ============================================================
# Why Analytical Psychology Still Matters
# R Workflow: Synthetic relevance simulation
# ============================================================

library(dplyr)
library(ggplot2)

set.seed(2026)

input_path <- "articles/why-analytical-psychology-still-matters/data/raw/synthetic_symbolic_relevance.csv"
output_table <- "articles/why-analytical-psychology-still-matters/outputs/tables/relevance_scores.csv"
output_figure <- "articles/why-analytical-psychology-still-matters/outputs/figures/relevance_by_tradition.png"

df <- read.csv(input_path)

df <- df |>
  mutate(
    contemporary_relevance =
      0.62 * symbolic_depth +
      0.58 * meaning_coherence +
      0.54 * clinical_utility +
      0.48 * cultural_interpretive_power +
      0.60 * revision_capacity -
      0.70 * doctrinal_rigidity,
    depth_need =
      0.56 * symbolic_loss +
      0.52 * projection_intensity +
      0.64 * existential_dislocation +
      0.46 * institutional_mistrust
  )

summary_table <- df |>
  group_by(tradition_type) |>
  summarize(
    mean_relevance = mean(contemporary_relevance),
    mean_depth_need = mean(depth_need),
    mean_revision_capacity = mean(revision_capacity),
    mean_doctrinal_rigidity = mean(doctrinal_rigidity),
    .groups = "drop"
  )

write.csv(summary_table, output_table, row.names = FALSE)

plot <- ggplot(summary_table, aes(x = tradition_type, y = mean_relevance)) +
  geom_col() +
  labs(
    title = "Synthetic Contemporary Relevance by Tradition Type",
    subtitle = "Illustrative model of symbolic depth, meaning coherence, clinical utility, cultural interpretation, and revision",
    x = "Tradition type",
    y = "Mean synthetic relevance"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 25, hjust = 1))

ggsave(output_figure, plot, width = 9, height = 5, dpi = 300)

print(summary_table)
