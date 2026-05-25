# ============================================================
# Anima, Animus, and the Problem of Gendered Symbolism
# R Workflow: Projection and symbolic otherness
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

article_dir <- "articles/anima-animus-and-the-problem-of-gendered-symbolism"
input_path <- file.path(article_dir, "data/raw/synthetic_symbolic_otherness_panel.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

panel <- read_csv(input_path, show_col_types = FALSE)

panel <- panel |>
  mutate(
    projection_intensity_model =
      0.70 * unrealized_capacity +
      0.65 * affective_charge +
      0.50 * relational_trigger +
      0.34 * symbolic_discrepancy +
      0.22 * gender_code_rigidity -
      0.55 * reflective_mediation,

    projection_rigidity_model =
      0.48 * projection_intensity +
      0.42 * gender_code_rigidity -
      0.36 * symbolic_flexibility -
      0.32 * reflective_mediation,

    symbolic_integration_model =
      0.46 * reflective_mediation +
      0.42 * symbolic_flexibility -
      0.30 * projection_rigidity -
      0.24 * abs(projection_intensity),

    projection_minus_integration = projection_intensity - symbolic_integration,
    coding_flexibility_gap = symbolic_flexibility - gender_code_rigidity
  )

pattern_summary <- panel |>
  group_by(symbolic_pattern) |>
  summarize(
    mean_unrealized_capacity = mean(unrealized_capacity),
    mean_affective_charge = mean(affective_charge),
    mean_relational_trigger = mean(relational_trigger),
    mean_reflective_mediation = mean(reflective_mediation),
    mean_gender_code_rigidity = mean(gender_code_rigidity),
    mean_symbolic_flexibility = mean(symbolic_flexibility),
    mean_symbolic_discrepancy = mean(symbolic_discrepancy),
    mean_projection_intensity = mean(projection_intensity),
    mean_projection_rigidity = mean(projection_rigidity),
    mean_symbolic_integration = mean(symbolic_integration),
    .groups = "drop"
  ) |>
  arrange(desc(mean_symbolic_integration))

trajectory <- panel |>
  group_by(time) |>
  summarize(
    mean_projection_intensity = mean(projection_intensity),
    mean_projection_rigidity = mean(projection_rigidity),
    mean_reflective_mediation = mean(reflective_mediation),
    mean_symbolic_flexibility = mean(symbolic_flexibility),
    mean_symbolic_integration = mean(symbolic_integration),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_projection_intensity,
      mean_projection_rigidity,
      mean_reflective_mediation,
      mean_symbolic_flexibility,
      mean_symbolic_integration
    ),
    names_to = "measure",
    values_to = "value"
  )

write_csv(panel, file.path(output_dir, "anima_animus_projection_panel.csv"))
write_csv(pattern_summary, file.path(output_dir, "symbolic_otherness_pattern_summary.csv"))
write_csv(trajectory, file.path(output_dir, "projection_symbolic_integration_trajectory.csv"))

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Projection of Symbolic Otherness",
    subtitle = "Projection rises with unrealized capacity and affective charge; integration rises with reflection and symbolic flexibility",
    x = "Time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

pattern_long <- pattern_summary |>
  pivot_longer(
    cols = c(
      mean_unrealized_capacity,
      mean_affective_charge,
      mean_reflective_mediation,
      mean_gender_code_rigidity,
      mean_symbolic_flexibility,
      mean_projection_intensity,
      mean_projection_rigidity,
      mean_symbolic_integration
    ),
    names_to = "measure",
    values_to = "value"
  )

pattern_plot <- ggplot(
  pattern_long,
  aes(x = reorder(symbolic_pattern, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Symbolic-Otherness Pattern Profiles",
    subtitle = "Different patterns show different balances of projection, rigidity, reflection, and integration",
    x = "Symbolic pattern",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "projection_symbolic_integration_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "symbolic_otherness_pattern_profiles.png"), pattern_plot, width = 11, height = 7, dpi = 300)

print(pattern_summary)
print(trajectory)
