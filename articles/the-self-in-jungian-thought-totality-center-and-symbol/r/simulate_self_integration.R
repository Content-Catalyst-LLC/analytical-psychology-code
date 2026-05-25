# ============================================================
# The Self in Jungian Thought
# R Workflow: Psychic integration around a symbolic center
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

article_dir <- "articles/the-self-in-jungian-thought-totality-center-and-symbol"
input_path <- file.path(article_dir, "data/raw/synthetic_self_integration_panel.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

panel <- read_csv(input_path, show_col_types = FALSE)

panel <- panel |>
  mutate(
    totality_score_model =
      0.48 * ego_coherence +
      0.36 * unconscious_activation +
      0.58 * symbolic_center_strength +
      0.54 * relational_coordination -
      0.46 * disjunction -
      0.30 * pmax(inflation_risk, 0),

    differentiation_score_model =
      0.42 * ego_coherence +
      0.38 * symbolic_center_strength +
      0.36 * relational_coordination -
      0.32 * abs(shadow_pressure),

    self_relation_index_model =
      0.40 * totality_score +
      0.34 * differentiation_score +
      0.28 * symbolic_center_strength -
      0.30 * pmax(inflation_risk, 0),

    ego_center_gap = abs(ego_coherence - symbolic_center_strength),
    integration_minus_inflation = self_relation_index - inflation_risk
  )

pattern_summary <- panel |>
  group_by(individuation_pattern) |>
  summarize(
    mean_ego_coherence = mean(ego_coherence),
    mean_unconscious_activation = mean(unconscious_activation),
    mean_symbolic_center_strength = mean(symbolic_center_strength),
    mean_shadow_pressure = mean(shadow_pressure),
    mean_relational_coordination = mean(relational_coordination),
    mean_disjunction = mean(disjunction),
    mean_inflation_risk = mean(inflation_risk),
    mean_totality_score = mean(totality_score),
    mean_differentiation_score = mean(differentiation_score),
    mean_self_relation_index = mean(self_relation_index),
    .groups = "drop"
  ) |>
  arrange(desc(mean_self_relation_index))

trajectory <- panel |>
  group_by(time) |>
  summarize(
    mean_ego_coherence = mean(ego_coherence),
    mean_symbolic_center_strength = mean(symbolic_center_strength),
    mean_relational_coordination = mean(relational_coordination),
    mean_disjunction = mean(disjunction),
    mean_inflation_risk = mean(inflation_risk),
    mean_totality_score = mean(totality_score),
    mean_self_relation_index = mean(self_relation_index),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_ego_coherence,
      mean_symbolic_center_strength,
      mean_relational_coordination,
      mean_disjunction,
      mean_inflation_risk,
      mean_totality_score,
      mean_self_relation_index
    ),
    names_to = "measure",
    values_to = "value"
  )

write_csv(panel, file.path(output_dir, "self_integration_panel.csv"))
write_csv(pattern_summary, file.path(output_dir, "individuation_pattern_summary.csv"))
write_csv(trajectory, file.path(output_dir, "self_integration_trajectory.csv"))

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Psychic Integration Around a Symbolic Center",
    subtitle = "Self-relation rises when ego coherence, symbolic center strength, and relational coordination increase without inflation",
    x = "Developmental time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

pattern_long <- pattern_summary |>
  pivot_longer(
    cols = c(
      mean_ego_coherence,
      mean_unconscious_activation,
      mean_symbolic_center_strength,
      mean_shadow_pressure,
      mean_relational_coordination,
      mean_disjunction,
      mean_inflation_risk,
      mean_totality_score,
      mean_self_relation_index
    ),
    names_to = "measure",
    values_to = "value"
  )

pattern_plot <- ggplot(
  pattern_long,
  aes(x = reorder(individuation_pattern, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Individuation Pattern Profiles",
    subtitle = "Different paths show different balances of ego coherence, center-symbol strength, shadow pressure, and inflation risk",
    x = "Individuation pattern",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "self_integration_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "individuation_pattern_profiles.png"), pattern_plot, width = 11, height = 7, dpi = 300)

print(pattern_summary)
print(trajectory)
