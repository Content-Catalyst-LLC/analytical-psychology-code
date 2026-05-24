# ============================================================
# Numinous Experience, Spiritual Emergency, and Symbolic Crisis
# R Workflow: Synthetic numinous crisis simulation
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/numinous-experience-spiritual-emergency-and-symbolic-crisis"
input_path <- file.path(article_dir, "data/raw/synthetic_numinous_crisis.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    crisis_risk =
      0.75 * numinous_intensity +
      0.45 * trauma_vulnerability +
      0.35 * practice_intensity +
      0.30 * sleep_disruption -
      0.55 * symbolic_containment -
      0.60 * ego_stability -
      0.40 * shadow_awareness -
      0.35 * relational_support,
    inflation_risk =
      0.58 * numinous_intensity +
      0.62 * perceived_mission -
      0.48 * shadow_awareness -
      0.52 * humility_limit_awareness -
      0.30 * relational_support,
    integration_potential =
      0.60 * symbolic_containment +
      0.55 * ego_stability +
      0.45 * shadow_awareness +
      0.50 * relational_support +
      0.35 * humility_limit_awareness -
      0.70 * crisis_risk -
      0.38 * inflation_risk,
    containment_index =
      (symbolic_containment + ritual_containment + relational_support) / 3,
    vulnerability_index =
      (trauma_vulnerability + sleep_disruption + practice_intensity) / 3
  )

environment_summary <- df |>
  group_by(symbolic_environment) |>
  summarize(
    mean_crisis_risk = mean(crisis_risk),
    mean_inflation_risk = mean(inflation_risk),
    mean_integration_potential = mean(integration_potential),
    mean_symbolic_containment = mean(symbolic_containment),
    mean_relational_support = mean(relational_support),
    mean_containment_index = mean(containment_index),
    mean_vulnerability_index = mean(vulnerability_index),
    .groups = "drop"
  ) |>
  arrange(desc(mean_integration_potential))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_crisis_risk = mean(crisis_risk),
    mean_inflation_risk = mean(inflation_risk),
    mean_integration_potential = mean(integration_potential),
    mean_containment_index = mean(containment_index),
    mean_vulnerability_index = mean(vulnerability_index),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_crisis_risk,
      mean_inflation_risk,
      mean_integration_potential,
      mean_containment_index,
      mean_vulnerability_index
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "numinous_crisis_scores.csv"), row.names = FALSE)
write.csv(environment_summary, file.path(output_dir, "numinous_environment_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "numinous_crisis_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Numinous Crisis and Integration Dynamics",
    subtitle = "Integration rises when containment, ego stability, shadow awareness, and support can hold numinous intensity",
    x = "Time period",
    y = "Synthetic measure"
  ) +
  theme_minimal()

environment_long <- environment_summary |>
  pivot_longer(
    cols = c(mean_crisis_risk, mean_inflation_risk, mean_integration_potential),
    names_to = "measure",
    values_to = "value"
  )

environment_plot <- ggplot(
  environment_long,
  aes(x = reorder(symbolic_environment, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Spiritual Crisis Risk by Symbolic Environment",
    subtitle = "Ritual and relational containers may reduce overload and support integration",
    x = "Symbolic environment",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "numinous_crisis_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "numinous_environment_comparison.png"), environment_plot, width = 10, height = 6, dpi = 300)

print(environment_summary)
print(trajectory)
