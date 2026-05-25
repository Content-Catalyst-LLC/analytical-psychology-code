# ============================================================
# Active Imagination and the Practice of Symbolic Dialogue
# R Workflow: Symbolic dialogue and ego-mediated integration
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/active-imagination-and-the-practice-of-symbolic-dialogue"
input_path <- file.path(article_dir, "data/raw/synthetic_active_imagination_dialogue.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    ego_imaginal_balance =
      -1 * (ego_mediation - imaginal_activation)^2,
    destabilization_risk_model =
      0.54 * imaginal_activation -
      0.38 * ego_mediation -
      0.34 * reflective_response,
    ethical_containment_model =
      0.42 * ego_mediation +
      0.36 * reflective_response +
      0.28 * symbolic_relation -
      0.24 * abs(imaginal_activation),
    integration_score_model =
      0.56 * ego_mediation +
      0.52 * imaginal_activation +
      0.48 * reflective_response +
      0.44 * symbolic_relation +
      0.34 * ethical_containment -
      0.70 * (ego_mediation - imaginal_activation)^2 -
      0.28 * pmax(destabilization_risk, 0),
    dialogue_quality_model =
      0.46 * symbolic_relation +
      0.42 * reflective_response +
      0.38 * ethical_containment -
      0.34 * abs(ego_mediation - imaginal_activation),
    conscious_mediation_index =
      (ego_mediation + reflective_response + ethical_containment) / 3,
    imaginal_field_index =
      imaginal_activation,
    integration_minus_risk =
      integration_score - destabilization_risk - inflation_risk
  )

mode_summary <- df |>
  group_by(dialogue_mode) |>
  summarize(
    mean_ego_mediation = mean(ego_mediation),
    mean_imaginal_activation = mean(imaginal_activation),
    mean_reflective_response = mean(reflective_response),
    mean_symbolic_relation = mean(symbolic_relation),
    mean_ethical_containment = mean(ethical_containment),
    mean_destabilization_risk = mean(destabilization_risk),
    mean_inflation_risk = mean(inflation_risk),
    mean_dialogue_quality = mean(dialogue_quality),
    mean_integration_score = mean(integration_score),
    .groups = "drop"
  ) |>
  arrange(desc(mean_integration_score))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_ego_mediation = mean(ego_mediation),
    mean_imaginal_activation = mean(imaginal_activation),
    mean_reflective_response = mean(reflective_response),
    mean_symbolic_relation = mean(symbolic_relation),
    mean_ethical_containment = mean(ethical_containment),
    mean_destabilization_risk = mean(destabilization_risk),
    mean_inflation_risk = mean(inflation_risk),
    mean_dialogue_quality = mean(dialogue_quality),
    mean_integration_score = mean(integration_score),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_ego_mediation,
      mean_imaginal_activation,
      mean_reflective_response,
      mean_symbolic_relation,
      mean_ethical_containment,
      mean_destabilization_risk,
      mean_inflation_risk,
      mean_dialogue_quality,
      mean_integration_score
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "active_imagination_dialogue_scores.csv"), row.names = FALSE)
write.csv(mode_summary, file.path(output_dir, "dialogue_mode_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "active_imagination_integration_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Integration Through Active Imagination",
    subtitle = "Integration rises when ego mediation, imaginal activation, reflective response, and symbolic relation remain in dialogue",
    x = "Developmental time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

mode_long <- mode_summary |>
  pivot_longer(
    cols = c(
      mean_ego_mediation,
      mean_imaginal_activation,
      mean_reflective_response,
      mean_symbolic_relation,
      mean_ethical_containment,
      mean_destabilization_risk,
      mean_inflation_risk,
      mean_dialogue_quality,
      mean_integration_score
    ),
    names_to = "measure",
    values_to = "value"
  )

mode_plot <- ggplot(
  mode_long,
  aes(x = reorder(dialogue_mode, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Active Imagination Dialogue Modes",
    subtitle = "Different modes show different balances of ego mediation, imaginal activation, containment, and integration",
    x = "Dialogue mode",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "active_imagination_integration_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "dialogue_mode_comparison.png"), mode_plot, width = 11, height = 7, dpi = 300)

print(mode_summary)
print(trajectory)
