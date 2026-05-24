# ============================================================
# Analytical Psychology and Clinical Practice
# R Workflow: Synthetic clinical practice simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/analytical-psychology-and-clinical-practice"
input_path <- file.path(article_dir, "data/raw/synthetic_clinical_practice.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    compensatory_pressure =
      0.62 * conscious_onesidedness +
      0.58 * complex_activation +
      0.34 * trauma_fragmentation -
      0.52 * ego_integration -
      0.26 * shadow_awareness,
    symbolic_growth =
      0.44 * relational_safety +
      0.38 * affect_regulation +
      0.34 * ego_integration +
      0.28 * dream_richness -
      0.32 * trauma_fragmentation -
      0.24 * shame_load,
    clinical_functioning =
      -0.70 * symptom_burden +
      0.60 * ego_integration +
      0.52 * symbolic_capacity +
      0.64 * relational_safety -
      0.42 * compensatory_pressure +
      0.28 * affect_regulation +
      0.24 * shadow_awareness,
    capacity_index =
      (ego_integration + symbolic_capacity + relational_safety + affect_regulation + shadow_awareness) / 5,
    risk_index =
      (symptom_burden + complex_activation + conscious_onesidedness + trauma_fragmentation + shame_load) / 5,
    symbolic_index =
      (symbolic_capacity + dream_richness + shadow_awareness) / 3
  )

presentation_summary <- df |>
  group_by(clinical_presentation) |>
  summarize(
    mean_symptom_burden = mean(symptom_burden),
    mean_ego_integration = mean(ego_integration),
    mean_symbolic_capacity = mean(symbolic_capacity),
    mean_relational_safety = mean(relational_safety),
    mean_compensatory_pressure = mean(compensatory_pressure),
    mean_symbolic_growth = mean(symbolic_growth),
    mean_clinical_functioning = mean(clinical_functioning),
    .groups = "drop"
  ) |>
  arrange(desc(mean_clinical_functioning))

trajectory <- df |>
  group_by(session) |>
  summarize(
    mean_symptom_burden = mean(symptom_burden),
    mean_ego_integration = mean(ego_integration),
    mean_symbolic_capacity = mean(symbolic_capacity),
    mean_relational_safety = mean(relational_safety),
    mean_compensatory_pressure = mean(compensatory_pressure),
    mean_clinical_functioning = mean(clinical_functioning),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_symptom_burden,
      mean_ego_integration,
      mean_symbolic_capacity,
      mean_relational_safety,
      mean_compensatory_pressure,
      mean_clinical_functioning
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "clinical_practice_scores.csv"), row.names = FALSE)
write.csv(presentation_summary, file.path(output_dir, "clinical_presentation_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "clinical_practice_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = session, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Clinical Change in Jungian Treatment",
    subtitle = "Clinical functioning rises as symptoms and compensatory pressure fall while integration, symbolization, and relational safety strengthen",
    x = "Session",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

presentation_long <- presentation_summary |>
  pivot_longer(
    cols = c(
      mean_symptom_burden,
      mean_ego_integration,
      mean_symbolic_capacity,
      mean_relational_safety,
      mean_compensatory_pressure,
      mean_clinical_functioning
    ),
    names_to = "measure",
    values_to = "value"
  )

presentation_plot <- ggplot(
  presentation_long,
  aes(x = reorder(clinical_presentation, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Clinical Presentations in Jungian Practice",
    subtitle = "Different presentations show different balances of symptoms, complexes, symbolization, relational safety, and integration",
    x = "Clinical presentation",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "clinical_practice_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "clinical_presentation_comparison.png"), presentation_plot, width = 10, height = 6, dpi = 300)

print(presentation_summary)
print(trajectory)
