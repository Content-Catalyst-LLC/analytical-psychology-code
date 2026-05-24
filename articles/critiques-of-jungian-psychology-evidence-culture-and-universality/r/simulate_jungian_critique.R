# ============================================================
# Critiques of Jungian Psychology: Evidence, Culture, and Universality
# R Workflow: Synthetic critique simulation
# ============================================================

library(dplyr)
library(ggplot2)

input_path <- "articles/critiques-of-jungian-psychology-evidence-culture-and-universality/data/raw/synthetic_jungian_critique.csv"
output_table <- "articles/critiques-of-jungian-psychology-evidence-culture-and-universality/outputs/tables/jungian_critique_scores.csv"
credibility_figure <- "articles/critiques-of-jungian-psychology-evidence-culture-and-universality/outputs/figures/credibility_by_concept_family.png"
risk_figure <- "articles/critiques-of-jungian-psychology-evidence-culture-and-universality/outputs/figures/overgeneralization_risk_by_concept_family.png"
value_figure <- "articles/critiques-of-jungian-psychology-evidence-culture-and-universality/outputs/figures/retained_value_by_concept_family.png"

df <- read.csv(input_path)

df <- df |>
  mutate(
    credibility_score =
      0.48 * interpretive_breadth +
      0.56 * empirical_support +
      0.62 * cultural_specificity +
      0.50 * gender_critical_revision +
      0.58 * methodological_explicitness +
      0.46 * clinical_utility -
      0.72 * universalization,
    overgeneralization_risk =
      0.62 * interpretive_breadth +
      0.70 * universalization -
      0.56 * cultural_specificity -
      0.44 * empirical_support -
      0.52 * methodological_explicitness,
    retained_value_after_critique =
      0.62 * symbolic_usefulness +
      0.58 * clinical_utility +
      0.54 * methodological_explicitness +
      0.48 * gender_critical_revision -
      0.66 * problematic_inherited_assumptions
  )

summary_table <- df |>
  group_by(concept_family) |>
  summarize(
    mean_credibility = mean(credibility_score),
    mean_overgeneralization_risk = mean(overgeneralization_risk),
    mean_retained_value = mean(retained_value_after_critique),
    mean_empirical_support = mean(empirical_support),
    mean_cultural_specificity = mean(cultural_specificity),
    mean_universalization = mean(universalization),
    .groups = "drop"
  ) |>
  arrange(desc(mean_retained_value))

write.csv(summary_table, output_table, row.names = FALSE)

credibility_plot <- ggplot(summary_table, aes(x = reorder(concept_family, mean_credibility), y = mean_credibility)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Credibility of Jungian Concepts Under Critique",
    subtitle = "Credibility rises when interpretive breadth is disciplined by evidence, specificity, and revision",
    x = "Concept family",
    y = "Mean credibility score"
  ) +
  theme_minimal()

risk_plot <- ggplot(summary_table, aes(x = reorder(concept_family, mean_overgeneralization_risk), y = mean_overgeneralization_risk)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Overgeneralization Risk Across Jungian Concept Families",
    subtitle = "Risk rises when universalization and interpretive breadth outrun evidence and cultural specificity",
    x = "Concept family",
    y = "Mean overgeneralization risk"
  ) +
  theme_minimal()

value_plot <- ggplot(summary_table, aes(x = reorder(concept_family, mean_retained_value), y = mean_retained_value)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Retained Value After Critique",
    subtitle = "Concepts retain value when symbolic and clinical usefulness survive revision",
    x = "Concept family",
    y = "Mean retained value"
  ) +
  theme_minimal()

ggsave(credibility_figure, credibility_plot, width = 9, height = 5, dpi = 300)
ggsave(risk_figure, risk_plot, width = 9, height = 5, dpi = 300)
ggsave(value_figure, value_plot, width = 9, height = 5, dpi = 300)

print(summary_table)
