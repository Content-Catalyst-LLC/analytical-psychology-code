# Synthetic analytical psychology analysis.
# Run after the Python script creates data/processed/synthetic_symbolic_observations.csv.
# Educational only. Not clinical or diagnostic.

# install.packages(c("tidyverse", "broom", "scales"))
library(tidyverse)
library(broom)
library(scales)

data_path <- file.path("data", "processed", "synthetic_symbolic_observations.csv")

if (!file.exists(data_path)) {
  stop("Run: python3 python/analytical_psychology_simulation.py")
}

jung_data <- read.csv(data_path)

summary_table <- aggregate(
  cbind(
    psyche_score,
    symbolic_access,
    ego_differentiation,
    affective_containment,
    relational_depth,
    transformative_processing,
    fragmentation_pressure,
    high_psychic_integration
  ) ~ period,
  data = jung_data,
  FUN = mean
)

dir.create("outputs", showWarnings = FALSE, recursive = TRUE)
write.csv(summary_table, file.path("outputs", "psychic_integration_period_summary.csv"), row.names = FALSE)

lm_fit <- lm(
  psyche_score ~ symbolic_access + ego_differentiation +
    affective_containment + relational_depth +
    transformative_processing + cultural_mediation +
    fragmentation_pressure,
  data = jung_data
)

print(summary(lm_fit))
print(tidy(lm_fit, conf.int = TRUE))

logit_fit <- glm(
  high_psychic_integration ~ symbolic_access + ego_differentiation +
    relational_depth + transformative_processing +
    fragmentation_pressure,
  family = binomial(link = "logit"),
  data = jung_data
)

print(summary(logit_fit))
print(tidy(logit_fit, conf.int = TRUE, exponentiate = TRUE))

print(summary_table)
