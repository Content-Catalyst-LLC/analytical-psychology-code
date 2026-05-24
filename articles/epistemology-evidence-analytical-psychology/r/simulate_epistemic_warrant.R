# ============================================================
# Epistemology and Evidence in Analytical Psychology
# R Workflow: Synthetic epistemic-warrant simulation
# ============================================================

library(dplyr)
library(ggplot2)

input_path <- "articles/epistemology-evidence-analytical-psychology/data/raw/synthetic_epistemic_warrant.csv"
output_table <- "articles/epistemology-evidence-analytical-psychology/outputs/tables/epistemic_warrant_scores.csv"
credibility_figure <- "articles/epistemology-evidence-analytical-psychology/outputs/figures/credibility_by_claim_type.png"
risk_figure <- "articles/epistemology-evidence-analytical-psychology/outputs/figures/overreach_risk_by_claim_type.png"

df <- read.csv(input_path)

df <- df |>
  mutate(
    credibility_score =
      0.52 * empirical_support +
      0.58 * hermeneutic_coherence +
      0.62 * clinical_utility +
      0.56 * phenomenological_adequacy +
      0.44 * contextual_specificity +
      0.60 * methodological_explicitness -
      0.72 * ambiguity_inflation,
    overreach_risk =
      0.64 * universalizing_force +
      0.70 * ambiguity_inflation +
      0.58 * selective_evidence -
      0.66 * methodological_explicitness -
      0.32 * contextual_specificity
  )

summary_table <- df |>
  group_by(claim_type) |>
  summarize(
    mean_credibility = mean(credibility_score),
    mean_overreach_risk = mean(overreach_risk),
    mean_empirical_support = mean(empirical_support),
    mean_hermeneutic_coherence = mean(hermeneutic_coherence),
    mean_methodological_explicitness = mean(methodological_explicitness),
    .groups = "drop"
  ) |>
  arrange(desc(mean_credibility))

write.csv(summary_table, output_table, row.names = FALSE)

credibility_plot <- ggplot(summary_table, aes(x = reorder(claim_type, mean_credibility), y = mean_credibility)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Credibility Across Jungian Claim Types",
    subtitle = "Illustrative model of empirical, hermeneutic, clinical, phenomenological, and methodological warrant",
    x = "Claim type",
    y = "Mean credibility score"
  ) +
  theme_minimal()

risk_plot <- ggplot(summary_table, aes(x = reorder(claim_type, mean_overreach_risk), y = mean_overreach_risk)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Overreach Risk Across Jungian Claim Types",
    subtitle = "Risk rises when ambiguity, universalizing force, and selective evidence exceed methodological clarity",
    x = "Claim type",
    y = "Mean overreach risk"
  ) +
  theme_minimal()

ggsave(credibility_figure, credibility_plot, width = 9, height = 5, dpi = 300)
ggsave(risk_figure, risk_plot, width = 9, height = 5, dpi = 300)

print(summary_table)
