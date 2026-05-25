# ============================================================
# Ego, Consciousness, and Psychic Differentiation
# R Workflow: Ego strength, differentiation, and psychic strain
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

article_dir <- "articles/ego-consciousness-and-psychic-differentiation"
input_path <- file.path(article_dir, "data/raw/synthetic_ego_differentiation_panel.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

panel <- read_csv(input_path, show_col_types = FALSE)

panel <- panel |>
  mutate(
    ego_coherence_model =
      0.72 * differentiation -
      0.48 * unconscious_pressure +
      0.60 * reflective_flexibility -
      0.22 * one_sidedness,

    ego_rigidity_model =
      0.54 * persona_identification +
      0.42 * one_sidedness -
      0.36 * reflective_flexibility,

    ego_inflation_model =
      0.46 * ego_coherence +
      0.50 * persona_identification +
      0.30 * differentiation -
      0.52 * reflective_flexibility -
      0.32 * shadow_activation,

    psychic_strain_model =
      0.40 * one_sidedness +
      0.46 * unconscious_pressure +
      0.42 * shadow_activation +
      0.34 * ego_rigidity -
      0.44 * reflective_flexibility,

    individuation_readiness_model =
      0.42 * ego_coherence +
      0.44 * reflective_flexibility +
      0.28 * function_balance -
      0.30 * ego_inflation -
      0.24 * psychic_strain,

    ego_balance_gap = abs(differentiation - function_balance),
    coherence_minus_inflation = ego_coherence - ego_inflation
  )

pattern_summary <- panel |>
  group_by(dominant_pattern) |>
  summarize(
    mean_differentiation = mean(differentiation),
    mean_function_balance = mean(function_balance),
    mean_reflective_flexibility = mean(reflective_flexibility),
    mean_unconscious_pressure = mean(unconscious_pressure),
    mean_persona_identification = mean(persona_identification),
    mean_shadow_activation = mean(shadow_activation),
    mean_one_sidedness = mean(one_sidedness),
    mean_ego_coherence = mean(ego_coherence),
    mean_ego_rigidity = mean(ego_rigidity),
    mean_ego_inflation = mean(ego_inflation),
    mean_psychic_strain = mean(psychic_strain),
    mean_individuation_readiness = mean(individuation_readiness),
    .groups = "drop"
  ) |>
  arrange(desc(mean_individuation_readiness))

trajectory <- panel |>
  group_by(time) |>
  summarize(
    mean_ego_coherence = mean(ego_coherence),
    mean_reflective_flexibility = mean(reflective_flexibility),
    mean_one_sidedness = mean(one_sidedness),
    mean_ego_rigidity = mean(ego_rigidity),
    mean_ego_inflation = mean(ego_inflation),
    mean_psychic_strain = mean(psychic_strain),
    mean_individuation_readiness = mean(individuation_readiness),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_ego_coherence,
      mean_reflective_flexibility,
      mean_one_sidedness,
      mean_ego_rigidity,
      mean_ego_inflation,
      mean_psychic_strain,
      mean_individuation_readiness
    ),
    names_to = "measure",
    values_to = "value"
  )

write_csv(panel, file.path(output_dir, "ego_differentiation_panel.csv"))
write_csv(pattern_summary, file.path(output_dir, "ego_differentiation_pattern_summary.csv"))
write_csv(trajectory, file.path(output_dir, "ego_differentiation_trajectory.csv"))

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Ego Differentiation and Psychic Strain",
    subtitle = "Ego coherence improves with differentiation and reflection, but one-sidedness and unconscious pressure increase strain",
    x = "Developmental time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

pattern_long <- pattern_summary |>
  pivot_longer(
    cols = c(
      mean_differentiation,
      mean_function_balance,
      mean_reflective_flexibility,
      mean_unconscious_pressure,
      mean_one_sidedness,
      mean_ego_coherence,
      mean_ego_rigidity,
      mean_ego_inflation,
      mean_psychic_strain,
      mean_individuation_readiness
    ),
    names_to = "measure",
    values_to = "value"
  )

pattern_plot <- ggplot(
  pattern_long,
  aes(x = reorder(dominant_pattern, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Ego-Differentiation Pattern Profiles",
    subtitle = "Different conscious-development patterns show different balances of coherence, rigidity, inflation, and strain",
    x = "Dominant pattern",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "ego_differentiation_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "ego_differentiation_pattern_profiles.png"), pattern_plot, width = 11, height = 7, dpi = 300)

print(pattern_summary)
print(trajectory)
