# ============================================================
# Persona and Social Adaptation in Analytical Psychology
# R Workflow: Persona strength, role demands, and psychic strain
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

article_dir <- "articles/persona-and-social-adaptation-in-analytical-psychology"
input_path <- file.path(article_dir, "data/raw/synthetic_persona_role_panel.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

panel <- read_csv(input_path, show_col_types = FALSE)

panel <- panel |>
  mutate(
    developmental_time = time / max(time),

    persona_strength_model =
      0.64 * role_demand +
      0.48 * audience_reward +
      0.36 * institutional_reward -
      0.30 * inward_complexity +
      0.42 * reflective_flexibility,

    persona_rigidity_model =
      0.52 * persona_strength +
      0.42 * status_dependence +
      0.34 * institutional_reward -
      0.46 * reflective_flexibility,

    psychic_strain_model =
      0.50 * persona_strength +
      0.62 * persona_inward_gap^2 +
      0.42 * persona_rigidity +
      0.36 * shadow_pressure -
      0.52 * reflective_flexibility,

    burnout_risk_model =
      0.46 * psychic_strain +
      0.36 * role_demand +
      0.30 * persona_rigidity -
      0.42 * reflective_flexibility,

    individuation_readiness_model =
      0.48 * reflective_flexibility +
      0.34 * inward_complexity -
      0.28 * persona_rigidity -
      0.24 * psychic_strain +
      0.18 * developmental_time,

    persona_shadow_pressure_gap = persona_strength + shadow_pressure - reflective_flexibility,
    role_reward_pressure = role_demand + audience_reward + institutional_reward
  )

pattern_summary <- panel |>
  group_by(persona_pattern) |>
  summarize(
    mean_role_demand = mean(role_demand),
    mean_audience_reward = mean(audience_reward),
    mean_institutional_reward = mean(institutional_reward),
    mean_inward_complexity = mean(inward_complexity),
    mean_reflective_flexibility = mean(reflective_flexibility),
    mean_shadow_pressure = mean(shadow_pressure),
    mean_status_dependence = mean(status_dependence),
    mean_persona_strength = mean(persona_strength),
    mean_persona_rigidity = mean(persona_rigidity),
    mean_persona_inward_gap = mean(persona_inward_gap),
    mean_psychic_strain = mean(psychic_strain),
    mean_burnout_risk = mean(burnout_risk),
    mean_individuation_readiness = mean(individuation_readiness),
    .groups = "drop"
  ) |>
  arrange(desc(mean_psychic_strain))

trajectory <- panel |>
  group_by(time) |>
  summarize(
    mean_persona_strength = mean(persona_strength),
    mean_persona_rigidity = mean(persona_rigidity),
    mean_reflective_flexibility = mean(reflective_flexibility),
    mean_shadow_pressure = mean(shadow_pressure),
    mean_psychic_strain = mean(psychic_strain),
    mean_burnout_risk = mean(burnout_risk),
    mean_individuation_readiness = mean(individuation_readiness),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_persona_strength,
      mean_persona_rigidity,
      mean_reflective_flexibility,
      mean_shadow_pressure,
      mean_psychic_strain,
      mean_burnout_risk,
      mean_individuation_readiness
    ),
    names_to = "measure",
    values_to = "value"
  )

write_csv(panel, file.path(output_dir, "persona_role_strain_panel.csv"))
write_csv(pattern_summary, file.path(output_dir, "persona_pattern_summary.csv"))
write_csv(trajectory, file.path(output_dir, "persona_strain_trajectory.csv"))

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Persona-Related Psychic Strain",
    subtitle = "Strain rises when persona strength and role reward exceed inward complexity and reflective flexibility",
    x = "Developmental time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

pattern_long <- pattern_summary |>
  pivot_longer(
    cols = c(
      mean_role_demand,
      mean_audience_reward,
      mean_institutional_reward,
      mean_reflective_flexibility,
      mean_shadow_pressure,
      mean_persona_strength,
      mean_persona_rigidity,
      mean_psychic_strain,
      mean_burnout_risk,
      mean_individuation_readiness
    ),
    names_to = "measure",
    values_to = "value"
  )

pattern_plot <- ggplot(
  pattern_long,
  aes(x = reorder(persona_pattern, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Persona Pattern Profiles",
    subtitle = "Different persona formations show different balances of reward, rigidity, strain, and individuation readiness",
    x = "Persona pattern",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "persona_strain_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "persona_pattern_profiles.png"), pattern_plot, width = 11, height = 7, dpi = 300)

print(pattern_summary)
print(trajectory)
