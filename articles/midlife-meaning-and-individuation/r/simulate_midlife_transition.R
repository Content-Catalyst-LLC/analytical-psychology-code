# ============================================================
# Midlife, Meaning, and Individuation
# R Workflow: Synthetic midlife transition simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/midlife-meaning-and-individuation"
input_path <- file.path(article_dir, "data/raw/synthetic_midlife_transition.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    transition_intensity =
      0.72 * outward_inward_discrepancy +
      0.58 * unlived_life_pressure +
      0.52 * finitude_awareness +
      0.46 * individuation_pressure -
      0.30 * reflective_capacity,
    meaning_coherence_model =
      0.40 * adaptation_strength +
      0.58 * symbolic_activation +
      0.62 * individuation_pressure +
      0.42 * shadow_integration +
      0.36 * reflective_capacity -
      0.72 * outward_inward_discrepancy,
    second_half_orientation_model =
      0.56 * symbolic_activation +
      0.54 * shadow_integration +
      0.48 * reflective_capacity +
      0.42 * finitude_awareness -
      0.42 * persona_identification -
      0.25 * outward_inward_discrepancy,
    first_half_index =
      (adaptation_strength + persona_identification) / 2,
    second_half_index =
      (symbolic_activation + individuation_pressure + shadow_integration + reflective_capacity + finitude_awareness) / 5,
    reorientation_gap =
      second_half_index - first_half_index
  )

pattern_summary <- df |>
  group_by(midlife_pattern) |>
  summarize(
    mean_adaptation_strength = mean(adaptation_strength),
    mean_persona_identification = mean(persona_identification),
    mean_symbolic_activation = mean(symbolic_activation),
    mean_unlived_life_pressure = mean(unlived_life_pressure),
    mean_finitude_awareness = mean(finitude_awareness),
    mean_individuation_pressure = mean(individuation_pressure),
    mean_shadow_integration = mean(shadow_integration),
    mean_meaning_coherence = mean(meaning_coherence),
    mean_second_half_orientation = mean(second_half_orientation),
    mean_transition_intensity = mean(transition_intensity),
    .groups = "drop"
  ) |>
  arrange(desc(mean_meaning_coherence))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_adaptation_strength = mean(adaptation_strength),
    mean_persona_identification = mean(persona_identification),
    mean_symbolic_activation = mean(symbolic_activation),
    mean_unlived_life_pressure = mean(unlived_life_pressure),
    mean_individuation_pressure = mean(individuation_pressure),
    mean_meaning_coherence = mean(meaning_coherence),
    mean_second_half_orientation = mean(second_half_orientation),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_adaptation_strength,
      mean_persona_identification,
      mean_symbolic_activation,
      mean_unlived_life_pressure,
      mean_individuation_pressure,
      mean_meaning_coherence,
      mean_second_half_orientation
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "midlife_transition_scores.csv"), row.names = FALSE)
write.csv(pattern_summary, file.path(output_dir, "midlife_pattern_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "midlife_transition_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Midlife Meaning Reorganization",
    subtitle = "Meaning shifts as persona dominance weakens and symbolic activation, shadow integration, and second-half orientation strengthen",
    x = "Time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

pattern_long <- pattern_summary |>
  pivot_longer(
    cols = c(
      mean_persona_identification,
      mean_symbolic_activation,
      mean_unlived_life_pressure,
      mean_finitude_awareness,
      mean_shadow_integration,
      mean_meaning_coherence,
      mean_second_half_orientation
    ),
    names_to = "measure",
    values_to = "value"
  )

pattern_plot <- ggplot(
  pattern_long,
  aes(x = reorder(midlife_pattern, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Midlife Patterns and Meaning Transition",
    subtitle = "Different midlife pathways show different balances of persona, shadow, finitude, symbolic life, and individuation pressure",
    x = "Midlife pattern",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "midlife_transition_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "midlife_pattern_comparison.png"), pattern_plot, width = 10, height = 6, dpi = 300)

print(pattern_summary)
print(trajectory)
