# ============================================================
# Dreams, Compensation, and the Prospective Function
# R Workflow: Compensatory and prospective dream dynamics
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

article_dir <- "articles/dreams-compensation-and-the-prospective-function"
input_path <- file.path(article_dir, "data/raw/synthetic_dream_dynamics_panel.csv")
output_dir <- file.path(article_dir, "outputs/tables")
figure_dir <- file.path(article_dir, "outputs/figures")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

panel <- read_csv(input_path, show_col_types = FALSE)

panel <- panel |>
  mutate(
    compensatory_intensity_model =
      0.72 * (unconscious_pressure - conscious_onesidedness) +
      0.36 * affective_intensity -
      0.22 * reflective_capacity,

    prospective_intensity_model =
      0.64 * latent_growth +
      0.28 * symbolic_literacy +
      0.22 * reflective_capacity +
      0.18 * previous_dream_output,

    dream_output_model =
      0.55 * compensatory_intensity +
      0.52 * prospective_intensity +
      0.40 * affective_intensity +
      0.32 * previous_dream_output,

    integration_signal_model =
      0.44 * prospective_intensity +
      0.36 * reflective_capacity +
      0.30 * symbolic_literacy -
      0.24 * abs(compensatory_intensity),

    one_sidedness_gap = unconscious_pressure - conscious_onesidedness,
    prospective_minus_compensatory = prospective_intensity - compensatory_intensity
  )

series_summary <- panel |>
  group_by(dream_series_type) |>
  summarize(
    mean_conscious_onesidedness = mean(conscious_onesidedness),
    mean_unconscious_pressure = mean(unconscious_pressure),
    mean_affective_intensity = mean(affective_intensity),
    mean_latent_growth = mean(latent_growth),
    mean_compensatory_intensity = mean(compensatory_intensity),
    mean_prospective_intensity = mean(prospective_intensity),
    mean_integration_signal = mean(integration_signal),
    mean_dream_output = mean(dream_output),
    .groups = "drop"
  ) |>
  arrange(desc(mean_integration_signal))

trajectory <- panel |>
  group_by(time) |>
  summarize(
    mean_conscious_onesidedness = mean(conscious_onesidedness),
    mean_unconscious_pressure = mean(unconscious_pressure),
    mean_compensatory_intensity = mean(compensatory_intensity),
    mean_prospective_intensity = mean(prospective_intensity),
    mean_integration_signal = mean(integration_signal),
    mean_dream_output = mean(dream_output),
    .groups = "drop"
  ) |>
  pivot_longer(
    cols = c(
      mean_conscious_onesidedness,
      mean_unconscious_pressure,
      mean_compensatory_intensity,
      mean_prospective_intensity,
      mean_integration_signal,
      mean_dream_output
    ),
    names_to = "measure",
    values_to = "value"
  )

write_csv(panel, file.path(output_dir, "compensatory_prospective_dream_panel.csv"))
write_csv(series_summary, file.path(output_dir, "dream_series_type_summary.csv"))
write_csv(trajectory, file.path(output_dir, "dream_developmental_trajectory.csv"))

trajectory_plot <- ggplot(trajectory, aes(x = time, y = value, linetype = measure)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Simulated Compensatory and Prospective Dream Dynamics",
    subtitle = "Dream output reflects present imbalance, latent growth, affective intensity, and prior dream material",
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
      mean_latent_growth,
      mean_compensatory_intensity,
      mean_prospective_intensity,
      mean_integration_signal,
      mean_dream_output
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
    subtitle = "Different series types show different balances of compensation, prospection, and integration",
    x = "Dream-series type",
    y = "Mean synthetic score"
  ) +
  theme_minimal()

ggsave(file.path(figure_dir, "compensatory_prospective_dream_trajectory.png"), trajectory_plot, width = 10, height = 6, dpi = 300)
ggsave(file.path(figure_dir, "dream_series_type_profiles.png"), series_plot, width = 11, height = 7, dpi = 300)

print(series_summary)
print(trajectory)
