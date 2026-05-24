# ============================================================
# Archetypal Psychology After Jung
# R Workflow: Synthetic archetypal-depth simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

input_path <- "articles/archetypal-psychology-after-jung/data/raw/synthetic_archetypal_depth.csv"
output_table <- "articles/archetypal-psychology-after-jung/outputs/tables/archetypal_depth_scores.csv"
depth_figure <- "articles/archetypal-psychology-after-jung/outputs/figures/archetypal_depth_by_presentation_type.png"
risk_figure <- "articles/archetypal-psychology-after-jung/outputs/figures/flattening_risk_by_presentation_type.png"
trajectory_figure <- "articles/archetypal-psychology-after-jung/outputs/figures/integrative_pressure_trajectory.png"

df <- read.csv(input_path)

df <- df |>
  mutate(
    archetypal_depth =
      0.65 * psychic_plurality +
      0.70 * imaginal_density +
      0.58 * metaphorical_richness +
      0.46 * symptom_image_intensity -
      0.55 * integrative_pressure,
    aesthetic_richness =
      0.62 * imaginal_density +
      0.54 * psychic_plurality +
      0.60 * metaphorical_richness -
      0.38 * literalizing_force,
    flattening_risk =
      0.58 * integrative_pressure +
      0.62 * literalizing_force +
      0.56 * diagnostic_dominance -
      0.48 * imaginal_density -
      0.34 * clinical_containment
  )

presentation_summary <- df |>
  group_by(presentation_type) |>
  summarize(
    mean_archetypal_depth = mean(archetypal_depth),
    mean_aesthetic_richness = mean(aesthetic_richness),
    mean_flattening_risk = mean(flattening_risk),
    mean_imaginal_density = mean(imaginal_density),
    mean_integrative_pressure = mean(integrative_pressure),
    .groups = "drop"
  ) |>
  arrange(desc(mean_archetypal_depth))

write.csv(presentation_summary, output_table, row.names = FALSE)

depth_plot <- ggplot(
  presentation_summary,
  aes(x = reorder(presentation_type, mean_archetypal_depth),
      y = mean_archetypal_depth)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Archetypal Depth by Presentation Type",
    subtitle = "Depth rises when plurality, image density, metaphor, and symptom imagery remain active",
    x = "Presentation type",
    y = "Mean archetypal depth"
  ) +
  theme_minimal()

risk_plot <- ggplot(
  presentation_summary,
  aes(x = reorder(presentation_type, mean_flattening_risk),
      y = mean_flattening_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Flattening Risk Under Literalizing and Integrative Pressure",
    subtitle = "Risk rises when diagnosis, literalism, and premature synthesis dominate imaginal attention",
    x = "Presentation type",
    y = "Mean flattening risk"
  ) +
  theme_minimal()

pressure_comparison <- df |>
  mutate(
    pressure_group = if_else(
      integrative_pressure > median(integrative_pressure),
      "Higher integrative pressure",
      "Lower integrative pressure"
    )
  ) |>
  group_by(pressure_group, time) |>
  summarize(
    mean_archetypal_depth = mean(archetypal_depth),
    mean_aesthetic_richness = mean(aesthetic_richness),
    mean_flattening_risk = mean(flattening_risk),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(mean_archetypal_depth, mean_aesthetic_richness, mean_flattening_risk),
    names_to = "measure",
    values_to = "value"
  )

trajectory_plot <- ggplot(pressure_comparison, aes(x = time, y = value, linetype = pressure_group)) +
  geom_line(linewidth = 1) +
  facet_wrap(~ measure, scales = "free_y") +
  labs(
    title = "Integrative Pressure and Imaginal Measures Over Time",
    x = "Time period",
    y = "Synthetic measure"
  ) +
  theme_minimal()

ggsave(depth_figure, depth_plot, width = 9, height = 5, dpi = 300)
ggsave(risk_figure, risk_plot, width = 9, height = 5, dpi = 300)
ggsave(trajectory_figure, trajectory_plot, width = 10, height = 6, dpi = 300)

print(presentation_summary)
