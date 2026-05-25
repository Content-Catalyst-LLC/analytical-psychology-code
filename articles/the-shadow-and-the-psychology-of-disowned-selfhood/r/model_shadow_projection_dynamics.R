# ============================================================
# The Shadow and the Psychology of Disowned Selfhood
# R Workflow: Shadow suppression and projection dynamics
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

article_dir <- "articles/the-shadow-and-the-psychology-of-disowned-selfhood"
input_path <- file.path(article_dir, "data/raw/synthetic_shadow_projection_panel.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

panel <- read_csv(input_path, show_col_types = FALSE)

panel <- panel |>
  mutate(
    shadow_activation_model =
      0.72 * latent_disowned * cue_intensity +
      0.56 * shadow_discrepancy +
      0.42 * affective_charge -
      0.48 * reflective_capacity,

    projection_intensity_model =
      0.76 * shadow_activation +
      0.44 * affective_charge +
      0.32 * persona_rigidity -
      0.56 * reflective_capacity,

    shame_response_model =
      0.42 * shadow_activation +
      0.34 * persona_rigidity -
      0.30 * reflective_capacity,

    integration_capacity_model =
      0.50 * reflective_capacity -
      0.34 * abs(projection_intensity) -
      0.26 * shame_response +
      0.28 * time / max(time),

    responsibility_index_model =
      0.42 * reflective_capacity +
      0.38 * integration_capacity -
      0.24 * projection_intensity -
      0.18 * shame_response,

    projection_minus_integration = projection_intensity - integration_capacity,
    false_innocence_pressure = persona_rigidity + projection_intensity - reflective_capacity
  )

configuration_summary <- panel |>
  group_by(shadow_configuration) |>
  summarize(
    mean_latent_disowned = mean(latent_disowned),
    mean_ego_identity = mean(ego_identity),
    mean_shadow_discrepancy = mean(shadow_discrepancy),
    mean_cue_intensity = mean(cue_intensity),
    mean_affective_charge = mean(affective_charge),
    mean_persona_rigidity = mean(persona_rigidity),
    mean_reflective_capacity = mean(reflective_capacity),
    mean_shadow_activation = mean(shadow_activation),
    mean_projection_intensity = mean(projection_intensity),
    mean_shame_response = mean(shame_response),
    mean_integration_capacity = mean(integration_capacity),
    mean_responsibility_index = mean(responsibility_index),
    .groups = "drop"
  ) |>
  arrange(desc(mean_projection_intensity))

trajectory <- panel |>
  group_by(time) |>
  summarize(
    mean_shadow_activation = mean(shadow_activation),
    mean_projection_intensity = mean(projection_intensity),
    mean_reflective_capacity = mean(reflective_capacity),
    mean_persona_rigidity = mean(persona_rigidity),
    mean_integration_capacity = mean(integration_capacity),
    mean_responsibility_index = mean(responsibility_index),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_shadow_activation,
      mean_projection_intensity,
      mean_reflective_capacity,
      mean_persona_rigidity,
      mean_integration_capacity,
      mean_responsibility_index
    ),
    names_to = "measure",
    values_to = "value"
  )

write_csv(panel, file.path(output_dir, "shadow_projection_panel.csv"))
write_csv(configuration_summary, file.path(output_dir, "shadow_configuration_summary.csv"))
write_csv(trajectory, file.path(output_dir, "shadow_projection_trajectory.csv"))

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Shadow Projection Over Time",
    subtitle = "Projection rises with shadow activation and persona rigidity; integration rises with reflective capacity",
    x = "Developmental time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

configuration_long <- configuration_summary |>
  pivot_longer(
    cols = c(
      mean_shadow_discrepancy,
      mean_affective_charge,
      mean_persona_rigidity,
      mean_reflective_capacity,
      mean_shadow_activation,
      mean_projection_intensity,
      mean_shame_response,
      mean_integration_capacity,
      mean_responsibility_index
    ),
    names_to = "measure",
    values_to = "value"
  )

configuration_plot <- ggplot(
  configuration_long,
  aes(x = reorder(shadow_configuration, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Shadow Configuration Profiles",
    subtitle = "Different self-images produce different shadow, projection, shame, and integration patterns",
    x = "Shadow configuration",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "shadow_projection_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "shadow_configuration_profiles.png"), configuration_plot, width = 11, height = 7, dpi = 300)

print(configuration_summary)
print(trajectory)
