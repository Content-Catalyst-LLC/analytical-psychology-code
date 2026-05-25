# ============================================================
# Analytical Psychology and Personality Theory
# R Workflow: Synthetic personality structure, compensation,
# typological flexibility, and development
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)

article_dir <- "articles/analytical-psychology-and-personality-theory"
input_path <- file.path(article_dir, "data/raw/synthetic_jungian_personality.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

df <- read.csv(input_path)

df <- df |>
  mutate(
    onesidedness_model =
      (conscious_orientation - shadow_acknowledgment)^2 +
      (persona_identification - typological_flexibility)^2 +
      (complex_activation - symbolic_relation)^2,
    unconscious_compensation_model =
      0.48 * onesidedness_model +
      0.40 * abs(complex_activation) -
      0.28 * reflective_capacity,
    developmental_integration_model =
      0.54 * typological_flexibility +
      0.56 * shadow_acknowledgment +
      0.62 * symbolic_relation +
      0.48 * reflective_capacity -
      0.38 * abs(complex_activation) -
      0.22 * onesidedness_model,
    personality_state_model =
      0.44 * conscious_orientation +
      0.36 * persona_identification +
      0.42 * symbolic_relation +
      0.32 * shadow_acknowledgment +
      0.54 * developmental_integration -
      0.34 * abs(complex_activation) +
      0.20 * unconscious_compensation,
    conscious_adaptation_index =
      (conscious_orientation + persona_identification) / 2,
    symbolic_integration_index =
      (shadow_acknowledgment + symbolic_relation + typological_flexibility + reflective_capacity + developmental_integration) / 5,
    compensation_risk_index =
      (complex_activation + unconscious_compensation + onesidedness) / 3,
    integration_minus_risk =
      symbolic_integration_index - compensation_risk_index
  )

function_summary <- df |>
  group_by(dominant_function, dominant_attitude) |>
  summarize(
    mean_conscious_orientation = mean(conscious_orientation),
    mean_persona_identification = mean(persona_identification),
    mean_symbolic_relation = mean(symbolic_relation),
    mean_shadow_acknowledgment = mean(shadow_acknowledgment),
    mean_typological_flexibility = mean(typological_flexibility),
    mean_complex_activation = mean(complex_activation),
    mean_unconscious_compensation = mean(unconscious_compensation),
    mean_developmental_integration = mean(developmental_integration),
    mean_personality_state = mean(personality_state),
    .groups = "drop"
  ) |>
  arrange(desc(mean_developmental_integration))

trajectory <- df |>
  group_by(time) |>
  summarize(
    mean_persona_identification = mean(persona_identification),
    mean_symbolic_relation = mean(symbolic_relation),
    mean_shadow_acknowledgment = mean(shadow_acknowledgment),
    mean_typological_flexibility = mean(typological_flexibility),
    mean_complex_activation = mean(complex_activation),
    mean_unconscious_compensation = mean(unconscious_compensation),
    mean_developmental_integration = mean(developmental_integration),
    mean_personality_state = mean(personality_state),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_persona_identification,
      mean_symbolic_relation,
      mean_shadow_acknowledgment,
      mean_typological_flexibility,
      mean_complex_activation,
      mean_unconscious_compensation,
      mean_developmental_integration,
      mean_personality_state
    ),
    names_to = "measure",
    values_to = "value"
  )

write.csv(df, file.path(output_dir, "jungian_personality_scores.csv"), row.names = FALSE)
write.csv(function_summary, file.path(output_dir, "typological_function_summary.csv"), row.names = FALSE)
write.csv(trajectory, file.path(output_dir, "jungian_personality_trajectory.csv"), row.names = FALSE)

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Personality as Structure, Compensation, and Development",
    subtitle = "Developmental integration rises as symbolic relation, shadow acknowledgment, and typological flexibility strengthen",
    x = "Time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

function_long <- function_summary |>
  pivot_longer(
    cols = c(
      mean_persona_identification,
      mean_symbolic_relation,
      mean_shadow_acknowledgment,
      mean_typological_flexibility,
      mean_complex_activation,
      mean_developmental_integration,
      mean_personality_state
    ),
    names_to = "measure",
    values_to = "value"
  )

function_plot <- ggplot(
  function_long,
  aes(x = dominant_function, y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  facet_wrap(~ dominant_attitude) +
  labs(
    title = "Synthetic Jungian Personality Patterns by Function and Attitude",
    subtitle = "Typological style is modeled alongside shadow, symbol, complexes, and developmental integration",
    x = "Dominant function",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "jungian_personality_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "typological_function_comparison.png"), function_plot, width = 10, height = 6, dpi = 300)

print(function_summary)
print(trajectory)
