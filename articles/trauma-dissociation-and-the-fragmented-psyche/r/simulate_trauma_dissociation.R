# ============================================================
# Trauma, Dissociation, and the Fragmented Psyche
# R Workflow: Synthetic trauma, dissociation, and integration simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/trauma-dissociation-and-the-fragmented-psyche"
input_path <- file.path(article_dir, "data/raw/synthetic_trauma_dissociation.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    dissociation_model =
      0.72 * affect_intensity +
      0.45 * developmental_trauma_load +
      0.34 * nightmare_intrusion -
      0.55 * ego_integration -
      0.48 * symbolic_capacity -
      0.42 * relational_safety -
      0.30 * bodily_regulation,
    symbolic_recovery_model =
      0.50 * symbolic_capacity +
      0.42 * memory_continuity +
      0.36 * relational_safety +
      0.32 * bodily_regulation +
      0.28 * witnessing_capacity -
      0.34 * nightmare_intrusion -
      0.30 * dissociation,
    integration_potential =
      0.60 * ego_integration +
      0.55 * symbolic_capacity +
      0.62 * relational_safety +
      0.48 * bodily_regulation +
      0.44 * memory_continuity +
      0.40 * symbolic_recovery +
      0.32 * witnessing_capacity -
      0.68 * dissociation -
      0.34 * nightmare_intrusion,
    fragmentation_index =
      (affect_intensity + dissociation + nightmare_intrusion + developmental_trauma_load) / 4,
    recovery_capacity_index =
      (ego_integration + symbolic_capacity + relational_safety + bodily_regulation + memory_continuity + witnessing_capacity) / 6
  )

pattern_summary <- df |>
  group_by(trauma_pattern) |>
  summarize(
    mean_affect_intensity = mean(affect_intensity),
    mean_dissociation = mean(dissociation),
    mean_symbolic_capacity = mean(symbolic_capacity),
    mean_bodily_regulation = mean(bodily_regulation),
    mean_memory_continuity = mean(memory_continuity),
    mean_symbolic_recovery = mean(symbolic_recovery),
    mean_integration_potential = mean(integration_potential),
    .groups = "drop"
  ) |>
  arrange(desc(mean_integration_potential))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_affect_intensity = mean(affect_intensity),
    mean_dissociation = mean(dissociation),
    mean_symbolic_capacity = mean(symbolic_capacity),
    mean_bodily_regulation = mean(bodily_regulation),
    mean_memory_continuity = mean(memory_continuity),
    mean_integration_potential = mean(integration_potential),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_affect_intensity,
      mean_dissociation,
      mean_symbolic_capacity,
      mean_bodily_regulation,
      mean_memory_continuity,
      mean_integration_potential
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "trauma_dissociation_scores.csv"), row.names = FALSE)
write.csv(pattern_summary, file.path(output_dir, "trauma_pattern_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "trauma_dissociation_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Integration Potential Under Traumatic Pressure",
    subtitle = "Integration rises as dissociation and affect intensity decline while symbolic capacity, bodily regulation, and memory continuity strengthen",
    x = "Time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

pattern_long <- pattern_summary |>
  pivot_longer(
    cols = c(
      mean_dissociation,
      mean_symbolic_capacity,
      mean_bodily_regulation,
      mean_memory_continuity,
      mean_symbolic_recovery,
      mean_integration_potential
    ),
    names_to = "measure",
    values_to = "value"
  )

pattern_plot <- ggplot(
  pattern_long,
  aes(x = reorder(trauma_pattern, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Trauma Patterns and Integration Dynamics",
    subtitle = "Different trauma patterns show different balances of dissociation, symbolization, bodily regulation, and integration",
    x = "Trauma pattern",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "trauma_dissociation_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "trauma_pattern_comparison.png"), pattern_plot, width = 10, height = 6, dpi = 300)

print(pattern_summary)
print(trajectory)
