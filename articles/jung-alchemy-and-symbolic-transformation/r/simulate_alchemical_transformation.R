# ============================================================
# Jung, Alchemy, and Symbolic Transformation
# R Workflow: Synthetic alchemical transformation simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/jung-alchemy-and-symbolic-transformation"
input_path <- file.path(article_dir, "data/raw/synthetic_alchemical_transformation_stages.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    transformation_score =
      0.42 * nigredo_pressure +
      0.55 * albedo_clarity +
      0.66 * rubedo_vitality +
      0.58 * vessel_strength -
      0.60 * onesidedness -
      0.30 * abs(mercurial_volatility),
    coniunctio_index =
      0.55 * (pole_x * pole_y) -
      0.40 * abs(pole_x - pole_y) +
      0.35 * vessel_strength,
    vessel_failure_risk =
      pmax(0, affective_heat + shadow_intensity - vessel_strength),
    containment_minus_heat =
      vessel_strength - affective_heat,
    integration_readiness =
      transformation_score + coniunctio_index - vessel_failure_risk
  )

stage_summary <- df |>
  group_by(symbolic_stage) |>
  summarize(
    mean_transformation = mean(transformation_score),
    mean_coniunctio = mean(coniunctio_index),
    mean_vessel_failure_risk = mean(vessel_failure_risk),
    mean_vessel_strength = mean(vessel_strength),
    mean_onesidedness = mean(onesidedness),
    mean_integration_readiness = mean(integration_readiness),
    .groups = "drop"
  ) |>
  arrange(desc(mean_transformation))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_transformation = mean(transformation_score),
    mean_coniunctio = mean(coniunctio_index),
    mean_vessel_failure_risk = mean(vessel_failure_risk),
    mean_integration_readiness = mean(integration_readiness),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(mean_transformation, mean_coniunctio, mean_vessel_failure_risk, mean_integration_readiness),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "alchemical_transformation_scores.csv"), row.names = FALSE)
write.csv(stage_summary, file.path(output_dir, "alchemical_stage_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "alchemical_transformation_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Alchemical Transformation Dynamics",
    subtitle = "Transformation depends on blackening, clarification, vitality, containment, and reduced one-sidedness",
    x = "Time period",
    y = "Synthetic measure"
  ) +
  theme_minimal()

stage_long <- stage_summary |>
  pivot_longer(
    cols = c(mean_transformation, mean_coniunctio, mean_vessel_failure_risk, mean_integration_readiness),
    names_to = "measure",
    values_to = "value"
  )

stage_plot <- ggplot(stage_long, aes(x = reorder(symbolic_stage, value), y = value, fill = measure)) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Alchemical Stage Comparison",
    subtitle = "Different stages emphasize transformation, conjunction, containment, and integration readiness differently",
    x = "Symbolic stage",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "alchemical_transformation_trajectory.png"), trajectory_plot, width = 9, height = 5, dpi = 300)
ggsave(file.path(figure_dir, "alchemical_stage_comparison.png"), stage_plot, width = 10, height = 6, dpi = 300)

print(stage_summary)
print(trajectory)
