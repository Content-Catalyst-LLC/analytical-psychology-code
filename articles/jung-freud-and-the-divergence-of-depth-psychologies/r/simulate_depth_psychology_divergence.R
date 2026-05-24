# ============================================================
# Jung, Freud, and the Divergence of Depth Psychologies
# R Workflow: Synthetic divergent depth-psychology simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

input_path <- "articles/jung-freud-and-the-divergence-of-depth-psychologies/data/raw/synthetic_depth_psychology_cases.csv"
output_table <- "articles/jung-freud-and-the-divergence-of-depth-psychologies/outputs/tables/depth_psychology_scores.csv"
trajectory_figure <- "articles/jung-freud-and-the-divergence-of-depth-psychologies/outputs/figures/model_trajectory.png"
case_figure <- "articles/jung-freud-and-the-divergence-of-depth-psychologies/outputs/figures/model_scores_by_case_type.png"

df <- read.csv(input_path)

df <- df |>
  mutate(
    freudian_score =
      0.66 * repression +
      0.70 * sexuality_conflict +
      0.62 * infantile_history +
      0.58 * defense_intensity +
      0.50 * transference_pressure -
      0.30 * mythic_amplification,
    jungian_score =
      0.58 * compensation +
      0.70 * archetypal_density +
      0.62 * prospective_development +
      0.64 * mythic_amplification +
      0.60 * symbolic_coherence +
      0.56 * individuation_pressure -
      0.24 * repression,
    integrative_depth_score =
      0.48 * repression +
      0.46 * defense_intensity +
      0.44 * transference_pressure +
      0.48 * compensation +
      0.46 * symbolic_coherence +
      0.44 * prospective_development
  )

case_summary <- df |>
  group_by(case_type) |>
  summarize(
    mean_freudian = mean(freudian_score),
    mean_jungian = mean(jungian_score),
    mean_integrative_depth = mean(integrative_depth_score),
    .groups = "drop"
  )

write.csv(case_summary, output_table, row.names = FALSE)

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_freudian = mean(freudian_score),
    mean_jungian = mean(jungian_score),
    mean_integrative_depth = mean(integrative_depth_score),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(mean_freudian, mean_jungian, mean_integrative_depth),
    names_to = "model",
    values_to = "score"
  )

trajectory_plot <- ggplot(trajectory, aes(x = time, y = score, linetype = model)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Synthetic Divergence of Freudian and Jungian Explanatory Models",
    subtitle = "Comparison of repression-conflict and symbol-development orientations",
    x = "Time period",
    y = "Mean explanatory score"
  ) +
  theme_minimal()

case_long <- case_summary |>
  pivot_longer(
    cols = c(mean_freudian, mean_jungian, mean_integrative_depth),
    names_to = "model",
    values_to = "mean_score"
  )

case_plot <- ggplot(case_long, aes(x = reorder(case_type, mean_score), y = mean_score, fill = model)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Model Emphasis by Case Type",
    subtitle = "Different presentations may invite different depth-psychology emphases",
    x = "Case type",
    y = "Mean explanatory score"
  ) +
  theme_minimal()

ggsave(trajectory_figure, trajectory_plot, width = 9, height = 5, dpi = 300)
ggsave(case_figure, case_plot, width = 9, height = 5, dpi = 300)

print(case_summary)
