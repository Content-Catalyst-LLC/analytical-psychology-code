# ============================================================
# Non-Western Symbol Systems and the Limits of Jungian Universality
# R Workflow: Synthetic symbolic-comparison simulation
# ============================================================

library(dplyr)
library(ggplot2)

input_path <- "articles/non-western-symbol-systems-limits-jungian-universality/data/raw/synthetic_symbolic_comparison.csv"
output_table <- "articles/non-western-symbol-systems-limits-jungian-universality/outputs/tables/symbolic_comparison_scores.csv"
quality_figure <- "articles/non-western-symbol-systems-limits-jungian-universality/outputs/figures/comparative_quality_by_layer.png"
risk_figure <- "articles/non-western-symbol-systems-limits-jungian-universality/outputs/figures/flattening_risk_by_layer.png"

df <- read.csv(input_path)

df <- df |>
  mutate(
    comparative_quality =
      0.52 * recurrence +
      0.68 * specificity +
      0.58 * linguistic_depth +
      0.54 * ritual_context +
      0.62 * dialogical_accountability -
      0.66 * universalizing_force -
      0.42 * abstraction_pressure,
    flattening_risk =
      0.70 * universalizing_force +
      0.64 * abstraction_pressure -
      0.58 * specificity -
      0.54 * dialogical_accountability -
      0.38 * linguistic_depth,
    equivalence_claim_strength =
      0.44 * recurrence +
      0.54 * functional_convergence -
      0.62 * contextual_divergence
  )

summary_table <- df |>
  group_by(tradition_layer) |>
  summarize(
    mean_comparative_quality = mean(comparative_quality),
    mean_flattening_risk = mean(flattening_risk),
    mean_equivalence_claim_strength = mean(equivalence_claim_strength),
    mean_specificity = mean(specificity),
    mean_dialogical_accountability = mean(dialogical_accountability),
    .groups = "drop"
  ) |>
  arrange(desc(mean_comparative_quality))

write.csv(summary_table, output_table, row.names = FALSE)

quality_plot <- ggplot(summary_table, aes(x = reorder(tradition_layer, mean_comparative_quality), y = mean_comparative_quality)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Cross-Cultural Comparative Quality",
    subtitle = "Quality rises when recurrence is balanced with specificity, language depth, ritual context, and accountability",
    x = "Tradition layer",
    y = "Mean comparative quality"
  ) +
  theme_minimal()

risk_plot <- ggplot(summary_table, aes(x = reorder(tradition_layer, mean_flattening_risk), y = mean_flattening_risk)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Flattening Risk in Comparative Symbolic Interpretation",
    subtitle = "Risk rises when universalizing force and abstraction pressure exceed contextual grounding",
    x = "Tradition layer",
    y = "Mean flattening risk"
  ) +
  theme_minimal()

ggsave(quality_figure, quality_plot, width = 9, height = 5, dpi = 300)
ggsave(risk_figure, risk_plot, width = 9, height = 5, dpi = 300)

print(summary_table)
