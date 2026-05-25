# ============================================================
# Dream Interpretation in Analytical Psychology
# R Workflow: Dream compensation and symbolic recurrence
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

article_dir <- "articles/dream-interpretation-in-analytical-psychology"
input_path <- file.path(article_dir, "data/raw/synthetic_dream_compensation_panel.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

panel <- read_csv(input_path, show_col_types = FALSE)

panel <- panel |>
  mutate(
    compensatory_signal_model =
      0.72 * (unconscious_pressure - conscious_onesidedness) +
      0.42 * affective_intensity -
      0.20 * reflective_capacity,

    symbolic_recurrence_model =
      0.44 * previous_dream_output +
      0.36 * symbolic_repertoire +
      0.24 * latent_development,

    dream_output_model =
      0.52 * compensatory_signal +
      0.48 * symbolic_recurrence +
      0.38 * affective_intensity +
      0.32 * latent_development,

    integration_signal_model =
      0.42 * reflective_capacity +
      0.38 * latent_development +
      0.30 * symbolic_repertoire -
      0.24 * abs(compensatory_signal),

    one_sidedness_gap = unconscious_pressure - conscious_onesidedness,
    recurrence_minus_compensation = symbolic_recurrence - compensatory_signal
  )

series_summary <- panel |>
  group_by(dream_series_type) |>
  summarize(
    mean_conscious_onesidedness = mean(conscious_onesidedness),
    mean_unconscious_pressure = mean(unconscious_pressure),
    mean_affective_intensity = mean(affective_intensity),
    mean_symbolic_repertoire = mean(symbolic_repertoire),
    mean_latent_development = mean(latent_development),
    mean_compensatory_signal = mean(compensatory_signal),
    mean_symbolic_recurrence = mean(symbolic_recurrence),
    mean_dream_output = mean(dream_output),
    mean_integration_signal = mean(integration_signal),
    .groups = "drop"
  ) |>
  arrange(desc(mean_integration_signal))

trajectory <- panel |>
  group_by(time) |>
  summarize(
    mean_compensatory_signal = mean(compensatory_signal),
    mean_symbolic_recurrence = mean(symbolic_recurrence),
    mean_dream_output = mean(dream_output),
    mean_integration_signal = mean(integration_signal),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_compensatory_signal,
      mean_symbolic_recurrence,
      mean_dream_output,
      mean_integration_signal
    ),
    names_to = "measure",
    values_to = "value"
  )

write_csv(panel, file.path(output_dir, "dream_compensation_panel.csv"))
write_csv(series_summary, file.path(output_dir, "dream_series_summary.csv"))
write_csv(trajectory, file.path(output_dir, "dream_series_trajectory.csv"))

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Dream Compensation Across a Series",
    subtitle = "Dream output reflects compensation, affective intensity, symbolic recurrence, and latent development",
    x = "Dream-series time",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

series_long <- series_summary |>
  pivot_longer(
    cols = c(
      mean_conscious_onesidedness,
      mean_unconscious_pressure,
      mean_affective_intensity,
      mean_symbolic_repertoire,
      mean_latent_development,
      mean_compensatory_signal,
      mean_symbolic_recurrence,
      mean_dream_output,
      mean_integration_signal
    ),
    names_to = "measure",
    values_to = "value"
  )

series_plot <- ggplot(
  series_long,
  aes(x = reorder(dream_series_type, value), y = value, fill = measure)
) +
  geom_col(position = "dodge") +
  coord_flip() +
  labs(
    title = "Synthetic Dream-Series Profiles",
    subtitle = "Different series types show different balances of compensation, symbolic recurrence, and integration",
    x = "Dream-series type",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "dream_compensation_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "dream_series_profiles.png"), series_plot, width = 11, height = 7, dpi = 300)

print(series_summary)
print(trajectory)
