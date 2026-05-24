# ============================================================
# Relational and Developmental Jungian Psychotherapy
# R Workflow: Synthetic relational therapy process simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/relational-and-developmental-jungian-psychotherapy"
input_path <- file.path(article_dir, "data/raw/synthetic_relational_jungian_therapy.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    developmental_integration =
      0.62 * relational_safety +
      0.42 * attachment_security +
      0.55 * affect_regulation +
      0.46 * repair_capacity +
      0.36 * embodied_safety +
      0.58 * symbolic_capacity +
      0.44 * reflective_self -
      0.58 * fragmentation -
      0.38 * shame_load -
      0.28 * rupture_intensity,
    symbolic_growth =
      0.55 * relational_safety +
      0.50 * affect_regulation +
      0.34 * repair_capacity +
      0.30 * embodied_safety -
      0.42 * shame_load -
      0.36 * fragmentation,
    rupture_risk =
      0.48 * rupture_intensity +
      0.34 * shame_load +
      0.32 * fragmentation -
      0.36 * repair_capacity -
      0.30 * relational_safety -
      0.26 * reflective_self,
    relational_capacity_index =
      (relational_safety + attachment_security + affect_regulation + repair_capacity + embodied_safety) / 5,
    symbolic_capacity_index =
      (symbolic_capacity + dream_richness + reflective_self) / 3,
    risk_index =
      (rupture_intensity + shame_load + fragmentation) / 3
  )

presentation_summary <- df |>
  group_by(clinical_presentation) |>
  summarize(
    mean_relational_safety = mean(relational_safety),
    mean_affect_regulation = mean(affect_regulation),
    mean_repair_capacity = mean(repair_capacity),
    mean_symbolic_capacity = mean(symbolic_capacity),
    mean_fragmentation = mean(fragmentation),
    mean_developmental_integration = mean(developmental_integration),
    mean_rupture_risk = mean(rupture_risk),
    .groups = "drop"
  ) |>
  arrange(desc(mean_developmental_integration))

trajectory <- df |>
  group_by(session) |>
  summarize(
    mean_relational_safety = mean(relational_safety),
    mean_repair_capacity = mean(repair_capacity),
    mean_symbolic_capacity = mean(symbolic_capacity),
    mean_fragmentation = mean(fragmentation),
    mean_developmental_integration = mean(developmental_integration),
    mean_rupture_risk = mean(rupture_risk),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_relational_safety,
      mean_repair_capacity,
      mean_symbolic_capacity,
      mean_fragmentation,
      mean_developmental_integration,
      mean_rupture_risk
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "relational_jungian_therapy_scores.csv"), row.names = FALSE)
write.csv(presentation_summary, file.path(output_dir, "clinical_presentation_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "relational_therapy_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = session, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Relational Jungian Therapy Dynamics",
    subtitle = "Integration rises as relational safety, repair, affect regulation, and symbolic capacity strengthen",
    x = "Session",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

presentation_long <- presentation_summary |>
  pivot_longer(
    cols = c(
      mean_relational_safety,
      mean_repair_capacity,
      mean_symbolic_capacity,
      mean_fragmentation,
      mean_developmental_integration,
      mean_rupture_risk
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
    title = "Synthetic Clinical Presentations in Relational Jungian Therapy",
    subtitle = "Different presentations show different balances of safety, symbolization, repair, fragmentation, and integration",
    x = "Clinical presentation",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "relational_therapy_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "clinical_presentation_comparison.png"), presentation_plot, width = 10, height = 6, dpi = 300)

print(presentation_summary)
print(trajectory)
