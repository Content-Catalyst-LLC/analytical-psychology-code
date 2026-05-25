# ============================================================
# Psychological Types: Introversion, Extraversion,
# and the Four Functions
# R Workflow: Dominant and inferior function dynamics
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/psychological-types-introversion-extraversion-and-the-four-functions"
input_path <- file.path(article_dir, "data/raw/synthetic_psychological_types.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    dominant_inferior_gap = dominant_strength - inferior_strength,
    function_variance_model = apply(
      cbind(thinking, feeling, sensation, intuition),
      1,
      var
    ),
    compensation_strain_model =
      0.70 * dominant_inferior_gap +
      0.55 * function_variance +
      0.45 * unconscious_pressure -
      0.28 * reflective_capacity,
    conscious_coherence_model =
      0.52 * dominant_strength +
      0.20 * attitude_score -
      0.30 * function_variance +
      0.26 * reflective_capacity,
    developmental_integration_model =
      0.42 * inferior_strength +
      0.38 * symbolic_relation +
      0.36 * reflective_capacity -
      0.32 * function_variance -
      0.26 * compensation_strain,
    function_balance_index =
      (thinking + feeling + sensation + intuition) / 4,
    integration_minus_strain =
      developmental_integration - compensation_strain
  )

type_summary <- df |>
  group_by(dominant_function, inferior_function, dominant_attitude) |>
  summarize(
    mean_dominant_strength = mean(dominant_strength),
    mean_inferior_strength = mean(inferior_strength),
    mean_gap = mean(dominant_inferior_gap),
    mean_function_variance = mean(function_variance),
    mean_unconscious_pressure = mean(unconscious_pressure),
    mean_compensation_strain = mean(compensation_strain),
    mean_conscious_coherence = mean(conscious_coherence),
    mean_developmental_integration = mean(developmental_integration),
    .groups = "drop"
  ) |>
  arrange(desc(mean_developmental_integration))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_dominant_strength = mean(dominant_strength),
    mean_inferior_strength = mean(inferior_strength),
    mean_gap = mean(dominant_strength - inferior_strength),
    mean_function_variance = mean(function_variance),
    mean_unconscious_pressure = mean(unconscious_pressure),
    mean_compensation_strain = mean(compensation_strain),
    mean_conscious_coherence = mean(conscious_coherence),
    mean_developmental_integration = mean(developmental_integration),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_dominant_strength,
      mean_inferior_strength,
      mean_gap,
      mean_function_variance,
      mean_unconscious_pressure,
      mean_compensation_strain,
      mean_conscious_coherence,
      mean_developmental_integration
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "psychological_type_scores.csv"), row.names = FALSE)
write.csv(type_summary, file.path(output_dir, "dominant_inferior_type_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "type_developmental_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Jungian Type Dynamics",
    subtitle = "Inferior-function access and developmental integration rise as one-sidedness softens",
    x = "Developmental time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

type_long <- type_summary |>
  pivot_longer(
    cols = c(
      mean_gap,
      mean_function_variance,
      mean_unconscious_pressure,
      mean_compensation_strain,
      mean_conscious_coherence,
      mean_developmental_integration
    ),
    names_to = "measure",
    values_to = "value"
  ) |>
  mutate(
    function_pair = paste(dominant_function, "→", inferior_function),
    function_pair_attitude = paste(function_pair, dominant_attitude, sep = " / ")
  )

type_plot <- ggplot(
  type_long,
  aes(x = reorder(function_pair_attitude, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Dominant–Inferior Function Patterns",
    subtitle = "Different type configurations show different balances of coherence, strain, and integration",
    x = "Dominant → inferior function pair and attitude",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "type_developmental_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "dominant_inferior_type_comparison.png"), type_plot, width = 11, height = 7, dpi = 300)

print(type_summary)
print(trajectory)
