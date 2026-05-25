# ============================================================
# Complexes, Affect, and Repetition in Analytical Psychology
# R Workflow: Repeated complex activation across time
# ============================================================
#
# Synthetic-data demonstration only.
# Not for diagnosis, therapy, psychological assessment,
# treatment recommendation, employee evaluation, or individual prediction.

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

set.seed(2026)

article_dir <- "articles/complexes-affect-and-repetition-in-analytical-psychology"
input_path <- file.path(article_dir, "data/raw/synthetic_complex_activation_panel.csv")
output_tables <- file.path(article_dir, "outputs/tables")
output_figures <- file.path(article_dir, "outputs/figures")

dir.create(output_tables, recursive = TRUE, showWarnings = FALSE)
dir.create(output_figures, recursive = TRUE, showWarnings = FALSE)

panel <- read_csv(input_path, show_col_types = FALSE)

panel <- panel |>
  group_by(person_id) |>
  arrange(time, .by_group = TRUE) |>
  mutate(
    lag_affect = lag(affect_intensity, default = first(affect_intensity) * 0.5),
    lag_activation = lag(complex_activation, default = first(complex_activation) * 0.5),
    developmental_time = time / max(time),

    modeled_affect_intensity =
      0.48 * lag_affect +
      0.54 * trigger_intensity +
      0.34 * relational_threat +
      0.30 * evaluation_pressure +
      0.28 * shame_cue -
      0.36 * regulation_capacity -
      0.24 * relational_buffer,

    modeled_complex_activation =
      0.58 * lag_activation +
      0.70 * affect_intensity +
      0.34 * trigger_intensity +
      0.26 * relational_threat -
      0.42 * regulation_capacity -
      0.30 * relational_buffer,

    modeled_repetition_probability =
      1 / (
        1 + exp(-(
          -0.15 +
          0.62 * complex_activation +
          0.38 * lag_activation +
          0.30 * affect_intensity +
          0.24 * projection_pressure +
          0.24 * transference_pressure -
          0.42 * regulation_capacity -
          0.28 * relational_buffer
        ))
      ),

    recurrence_pressure =
      complex_activation +
      affect_intensity +
      projection_pressure +
      transference_pressure -
      regulation_capacity -
      relational_buffer,

    recovery_potential =
      regulation_capacity +
      relational_buffer -
      affect_intensity -
      0.40 * complex_activation
  ) |>
  ungroup()

complex_summary <- panel |>
  group_by(complex_type) |>
  summarize(
    mean_trigger_intensity = mean(trigger_intensity),
    mean_relational_threat = mean(relational_threat),
    mean_evaluation_pressure = mean(evaluation_pressure),
    mean_shame_cue = mean(shame_cue),
    mean_affect_intensity = mean(affect_intensity),
    mean_complex_activation = mean(complex_activation),
    mean_repetition_probability = mean(repetition_probability),
    mean_projection_pressure = mean(projection_pressure),
    mean_transference_pressure = mean(transference_pressure),
    mean_regulation_capacity = mean(regulation_capacity),
    mean_relational_buffer = mean(relational_buffer),
    mean_recurrence_pressure = mean(recurrence_pressure),
    mean_recovery_potential = mean(recovery_potential),
    .groups = "drop"
  ) |>
  arrange(desc(mean_recurrence_pressure))

trajectory <- panel |>
  group_by(time) |>
  summarize(
    mean_affect_intensity = mean(affect_intensity),
    mean_complex_activation = mean(complex_activation),
    mean_repetition_probability = mean(repetition_probability),
    mean_regulation_capacity = mean(regulation_capacity),
    mean_relational_buffer = mean(relational_buffer),
    mean_recurrence_pressure = mean(recurrence_pressure),
    mean_recovery_potential = mean(recovery_potential),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_affect_intensity,
      mean_complex_activation,
      mean_repetition_probability,
      mean_regulation_capacity,
      mean_relational_buffer,
      mean_recurrence_pressure,
      mean_recovery_potential
    ),
    names_to = "measure",
    values_to = "value"
  )

symbolic_summary <- panel |>
  count(complex_type, symbolic_repetition, sort = TRUE)

write_csv(panel, file.path(output_tables, "complex_activation_panel_modeled.csv"))
write_csv(complex_summary, file.path(output_tables, "complex_type_summary.csv"))
write_csv(trajectory, file.path(output_tables, "complex_activation_trajectory.csv"))
write_csv(symbolic_summary, file.path(output_tables, "symbolic_repetition_summary.csv"))

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Repetition in Complex Activation",
    subtitle = "Affect and prior activation increase recurrence; regulation and relational buffering reduce it",
    x = "Time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

complex_plot <- complex_summary |>
  select(
    complex_type,
    mean_affect_intensity,
    mean_complex_activation,
    mean_repetition_probability,
    mean_recurrence_pressure,
    mean_recovery_potential
  ) |>
  pivot_longer(-complex_type, names_to = "measure", values_to = "value") |>
  ggplot(aes(x = reorder(complex_type, value), y = value, fill = measure)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Complex-Type Profiles",
    subtitle = "Different complexes show different balances of activation, recurrence, and recovery potential",
    x = "Complex type",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(output_figures, "complex_activation_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(output_figures, "complex_type_profiles.png"), complex_plot, width = 11, height = 7, dpi = 300)

print(complex_summary)
print(trajectory)
print(symbolic_summary)

cat("\nResponsible-use guardrails:\n")
cat("- Synthetic demonstration only.\n")
cat("- Model outputs are not diagnostic or predictive.\n")
cat("- Strong affect may be appropriate to real harm.\n")
cat("- Repetition may be social, structural, relational, or material rather than intrapsychic.\n")
