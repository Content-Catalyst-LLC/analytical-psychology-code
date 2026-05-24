# ============================================================
# Analytical Psychology, Religion, and Spiritual Experience
# R Workflow: Synthetic religion and spiritual experience simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/analytical-psychology-religion-and-spiritual-experience"
input_path <- file.path(article_dir, "data/raw/synthetic_religion_spiritual_experience.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    containment_gap = numinous_intensity - symbolic_containment,
    integration =
      0.60 * symbolic_containment +
      0.55 * ego_stability +
      0.48 * shadow_awareness +
      0.42 * ritual_support +
      0.36 * numinous_intensity -
      0.65 * containment_gap^2 -
      0.30 * religious_trauma_pressure,
    inflation_risk =
      0.70 * numinous_intensity +
      0.58 * perceived_mission +
      0.35 * doctrinal_rigidity -
      0.55 * ego_stability -
      0.45 * shadow_awareness -
      0.42 * humility_limit_awareness -
      0.30 * ritual_support,
    living_symbol_score =
      0.50 * symbolic_vitality +
      0.40 * ritual_support +
      0.35 * shadow_awareness +
      0.28 * communal_memory -
      0.45 * doctrinal_rigidity -
      0.25 * religious_trauma_pressure,
    containment_index =
      (symbolic_containment + ritual_support + ego_stability + humility_limit_awareness) / 4,
    symbolic_risk_index =
      (inflation_risk + doctrinal_rigidity + religious_trauma_pressure) / 3
  )

environment_summary <- df |>
  group_by(religious_environment) |>
  summarize(
    mean_integration = mean(integration),
    mean_inflation_risk = mean(inflation_risk),
    mean_living_symbol_score = mean(living_symbol_score),
    mean_symbolic_containment = mean(symbolic_containment),
    mean_ritual_support = mean(ritual_support),
    mean_religious_trauma_pressure = mean(religious_trauma_pressure),
    mean_containment_index = mean(containment_index),
    mean_symbolic_risk_index = mean(symbolic_risk_index),
    .groups = "drop"
  ) |>
  arrange(desc(mean_integration))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_integration = mean(integration),
    mean_inflation_risk = mean(inflation_risk),
    mean_living_symbol_score = mean(living_symbol_score),
    mean_containment_index = mean(containment_index),
    mean_symbolic_risk_index = mean(symbolic_risk_index),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_integration,
      mean_inflation_risk,
      mean_living_symbol_score,
      mean_containment_index,
      mean_symbolic_risk_index
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "religion_spiritual_experience_scores.csv"), row.names = FALSE)
write.csv(environment_summary, file.path(output_dir, "religious_environment_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "religion_spiritual_experience_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Religion, Numinous Experience, and Integration",
    subtitle = "Integration depends on symbolic containment, ego stability, shadow awareness, ritual support, and reduced inflation risk",
    x = "Time period",
    y = "Synthetic measure"
  ) +
  theme_minimal()

environment_long <- environment_summary |>
  pivot_longer(
    cols = c(mean_integration, mean_inflation_risk, mean_living_symbol_score),
    names_to = "measure",
    values_to = "value"
  )

environment_plot <- ggplot(
  environment_long,
  aes(x = reorder(religious_environment, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Religious Environments and Symbolic Outcomes",
    subtitle = "Symbolic environments support or weaken integration depending on containment, shadow awareness, and trauma pressure",
    x = "Religious / symbolic environment",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "religion_spiritual_experience_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "religious_environment_comparison.png"), environment_plot, width = 10, height = 6, dpi = 300)

print(environment_summary)
print(trajectory)
