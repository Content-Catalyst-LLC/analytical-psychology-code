# ============================================================
# Childhood Development in Jungian and Post-Jungian Thought
# R Workflow: Synthetic early development, complex formation,
# symbolic capacity, and developmental coherence
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/childhood-development-in-jungian-and-post-jungian-thought"
input_path <- file.path(article_dir, "data/raw/synthetic_childhood_development.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    developmental_strain =
      (ego_differentiation - relational_security)^2 +
      (symbolic_capacity - relational_security)^2 +
      complex_activation^2,
    symbolic_capacity_model =
      0.48 * symbolic_play +
      0.36 * caregiver_mirroring +
      0.30 * bodily_regulation +
      0.26 * relational_security -
      0.30 * family_tension,
    developmental_coherence_model =
      0.55 * ego_differentiation +
      0.70 * relational_security +
      0.60 * symbolic_capacity +
      0.48 * affect_regulation +
      0.34 * symbolic_play -
      0.50 * complex_activation -
      0.24 * developmental_strain,
    relational_symbolic_index =
      (relational_security + caregiver_mirroring + symbolic_play + symbolic_capacity) / 4,
    ego_regulation_index =
      (ego_differentiation + affect_regulation + bodily_regulation) / 3,
    risk_index =
      (complex_activation + family_tension) / 2,
    coherence_minus_risk =
      developmental_coherence - risk_index
  )

context_summary <- df |>
  group_by(developmental_context) |>
  summarize(
    mean_relational_security = mean(relational_security),
    mean_caregiver_mirroring = mean(caregiver_mirroring),
    mean_symbolic_play = mean(symbolic_play),
    mean_symbolic_capacity = mean(symbolic_capacity),
    mean_complex_activation = mean(complex_activation),
    mean_affect_regulation = mean(affect_regulation),
    mean_developmental_coherence = mean(developmental_coherence),
    .groups = "drop"
  ) |>
  arrange(desc(mean_developmental_coherence))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_ego_differentiation = mean(ego_differentiation),
    mean_relational_security = mean(relational_security),
    mean_symbolic_capacity = mean(symbolic_capacity),
    mean_affect_regulation = mean(affect_regulation),
    mean_complex_activation = mean(complex_activation),
    mean_developmental_coherence = mean(developmental_coherence),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_ego_differentiation,
      mean_relational_security,
      mean_symbolic_capacity,
      mean_affect_regulation,
      mean_complex_activation,
      mean_developmental_coherence
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "childhood_development_scores.csv"), row.names = FALSE)
write.csv(context_summary, file.path(output_dir, "developmental_context_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "childhood_development_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Childhood Developmental Coherence",
    subtitle = "Coherence rises as ego differentiation, relational security, affect regulation, and symbolic capacity strengthen",
    x = "Developmental time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

context_long <- context_summary |>
  pivot_longer(
    cols = c(
      mean_relational_security,
      mean_symbolic_play,
      mean_symbolic_capacity,
      mean_complex_activation,
      mean_affect_regulation,
      mean_developmental_coherence
    ),
    names_to = "measure",
    values_to = "value"
  )

context_plot <- ggplot(
  context_long,
  aes(x = reorder(developmental_context, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Developmental Contexts in Jungian and Post-Jungian Thought",
    subtitle = "Different relational fields show different balances of play, symbolization, affect regulation, complexes, and coherence",
    x = "Developmental context",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "childhood_development_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "developmental_context_comparison.png"), context_plot, width = 10, height = 6, dpi = 300)

print(context_summary)
print(trajectory)
