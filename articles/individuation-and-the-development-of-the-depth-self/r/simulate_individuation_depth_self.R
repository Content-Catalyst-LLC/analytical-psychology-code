# ============================================================
# Individuation and the Development of the Depth Self
# R Workflow: Synthetic individuation under tension
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/individuation-and-the-development-of-the-depth-self"
input_path <- file.path(article_dir, "data/raw/synthetic_individuation_depth_self.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    onesidedness_model =
      (ego_coherence - shadow_acknowledgment)^2 +
      (symbolic_relation - complex_activation)^2 +
      (persona_identification - reflective_capacity)^2,
    compensation_pressure_model =
      0.44 * onesidedness_model +
      0.36 * abs(complex_activation) -
      0.28 * reflective_capacity,
    depth_self_integration_model =
      0.54 * ego_coherence +
      0.62 * shadow_acknowledgment +
      0.66 * symbolic_relation +
      0.52 * reflective_capacity +
      0.34 * body_awareness +
      0.36 * ethical_accountability +
      0.30 * relational_life -
      0.42 * abs(complex_activation) -
      0.28 * onesidedness_model,
    individuation_score_model =
      0.58 * depth_self_integration_model +
      0.42 * symbolic_relation +
      0.38 * shadow_acknowledgment +
      0.34 * reflective_capacity +
      0.28 * ethical_accountability -
      0.32 * persona_identification -
      0.30 * abs(complex_activation),
    adaptive_surface_index =
      (ego_coherence + persona_identification) / 2,
    depth_integration_index =
      (shadow_acknowledgment + symbolic_relation + reflective_capacity + body_awareness + ethical_accountability + relational_life + dream_function + depth_self_integration) / 8,
    complex_pressure_index =
      complex_activation,
    depth_minus_surface =
      depth_integration_index - adaptive_surface_index
  )

pathway_summary <- df |>
  group_by(individuation_pathway) |>
  summarize(
    mean_ego_coherence = mean(ego_coherence),
    mean_persona_identification = mean(persona_identification),
    mean_shadow_acknowledgment = mean(shadow_acknowledgment),
    mean_symbolic_relation = mean(symbolic_relation),
    mean_complex_activation = mean(complex_activation),
    mean_reflective_capacity = mean(reflective_capacity),
    mean_ethical_accountability = mean(ethical_accountability),
    mean_onesidedness = mean(onesidedness),
    mean_depth_self_integration = mean(depth_self_integration),
    mean_individuation_score = mean(individuation_score),
    .groups = "drop"
  ) |>
  arrange(desc(mean_individuation_score))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_ego_coherence = mean(ego_coherence),
    mean_persona_identification = mean(persona_identification),
    mean_shadow_acknowledgment = mean(shadow_acknowledgment),
    mean_symbolic_relation = mean(symbolic_relation),
    mean_complex_activation = mean(complex_activation),
    mean_depth_self_integration = mean(depth_self_integration),
    mean_individuation_score = mean(individuation_score),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_ego_coherence,
      mean_persona_identification,
      mean_shadow_acknowledgment,
      mean_symbolic_relation,
      mean_complex_activation,
      mean_depth_self_integration,
      mean_individuation_score
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "individuation_depth_self_scores.csv"), row.names = FALSE)
write.csv(pathway_summary, file.path(output_dir, "individuation_pathway_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "individuation_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Individuation Under Psychic Tension",
    subtitle = "Depth-self integration rises as symbolic relation, shadow acknowledgment, and reflective capacity strengthen",
    x = "Developmental time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

pathway_long <- pathway_summary |>
  pivot_longer(
    cols = c(
      mean_persona_identification,
      mean_shadow_acknowledgment,
      mean_symbolic_relation,
      mean_complex_activation,
      mean_onesidedness,
      mean_depth_self_integration,
      mean_individuation_score
    ),
    names_to = "measure",
    values_to = "value"
  )

pathway_plot <- ggplot(
  pathway_long,
  aes(x = reorder(individuation_pathway, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Individuation Pathways",
    subtitle = "Different pathways show different balances of persona, shadow, symbol, complexes, one-sidedness, and depth-self integration",
    x = "Individuation pathway",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "individuation_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "individuation_pathway_comparison.png"), pathway_plot, width = 10, height = 6, dpi = 300)

print(pathway_summary)
print(trajectory)
