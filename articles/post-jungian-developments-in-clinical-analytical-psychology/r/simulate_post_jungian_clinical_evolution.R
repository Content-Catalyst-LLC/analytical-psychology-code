# ============================================================
# Post-Jungian Developments in Clinical Analytical Psychology
# R Workflow: Synthetic clinical-evolution simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

input_path <- "articles/post-jungian-developments-in-clinical-analytical-psychology/data/raw/synthetic_post_jungian_clinical_models.csv"
output_table <- "articles/post-jungian-developments-in-clinical-analytical-psychology/outputs/tables/post_jungian_clinical_scores.csv"
adequacy_figure <- "articles/post-jungian-developments-in-clinical-analytical-psychology/outputs/figures/clinical_adequacy_by_school_tendency.png"
balance_figure <- "articles/post-jungian-developments-in-clinical-analytical-psychology/outputs/figures/balance_index_by_school_tendency.png"
trajectory_figure <- "articles/post-jungian-developments-in-clinical-analytical-psychology/outputs/figures/post_jungian_clinical_evolution_trajectory.png"

df <- read.csv(input_path)

df <- df |>
  mutate(
    clinical_adequacy =
      0.50 * symbolic_depth +
      0.62 * relational_sophistication +
      0.58 * developmental_precision +
      0.66 * trauma_sensitivity +
      0.52 * embodied_regulation +
      0.46 * cultural_responsiveness -
      0.60 * doctrinal_rigidity,
    symbolic_readiness =
      0.56 * affect_tolerance +
      0.62 * relational_holding +
      0.52 * grounding_capacity -
      0.64 * fragmentation_load,
    clinical_refinement_mean =
      (
        relational_sophistication +
        developmental_precision +
        trauma_sensitivity +
        embodied_regulation +
        cultural_responsiveness
      ) / 5,
    balance_index =
      0.60 * symbolic_depth -
      0.50 * abs(symbolic_depth - clinical_refinement_mean)
  )

school_summary <- df |>
  group_by(school_tendency) |>
  summarize(
    mean_clinical_adequacy = mean(clinical_adequacy),
    mean_symbolic_readiness = mean(symbolic_readiness),
    mean_balance_index = mean(balance_index),
    mean_symbolic_depth = mean(symbolic_depth),
    mean_clinical_refinement = mean(clinical_refinement_mean),
    mean_doctrinal_rigidity = mean(doctrinal_rigidity),
    .groups = "drop"
  ) |>
  arrange(desc(mean_clinical_adequacy))

write.csv(school_summary, output_table, row.names = FALSE)

adequacy_plot <- ggplot(
  school_summary,
  aes(x = reorder(school_tendency, mean_clinical_adequacy),
      y = mean_clinical_adequacy)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Post-Jungian Clinical Adequacy",
    subtitle = "Adequacy rises when symbolic depth is joined to relational, developmental, trauma-informed, embodied, and cultural refinement",
    x = "School tendency",
    y = "Mean clinical adequacy"
  ) +
  theme_minimal()

balance_plot <- ggplot(
  school_summary,
  aes(x = reorder(school_tendency, mean_balance_index),
      y = mean_balance_index)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Balance Between Symbolic Depth and Clinical Refinement",
    subtitle = "Balance weakens when symbolic depth greatly exceeds or collapses beneath clinical refinement",
    x = "School tendency",
    y = "Mean balance index"
  ) +
  theme_minimal()

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_adequacy = mean(clinical_adequacy),
    mean_symbolic_readiness = mean(symbolic_readiness),
    mean_balance = mean(balance_index),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(mean_adequacy, mean_symbolic_readiness, mean_balance),
    names_to = "measure",
    values_to = "value"
  )

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Post-Jungian Clinical Evolution",
    x = "Time period",
    y = "Synthetic measure"
  ) +
  theme_minimal()

ggsave(adequacy_figure, adequacy_plot, width = 9, height = 5, dpi = 300)
ggsave(balance_figure, balance_plot, width = 9, height = 5, dpi = 300)
ggsave(trajectory_figure, trajectory_plot, width = 9, height = 5, dpi = 300)

print(school_summary)
