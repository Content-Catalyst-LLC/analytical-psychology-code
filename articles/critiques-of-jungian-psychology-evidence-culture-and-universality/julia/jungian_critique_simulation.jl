# Critiques of Jungian Psychology: Evidence, Culture, and Universality
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/critiques-of-jungian-psychology-evidence-culture-and-universality"
input_path = joinpath(article_dir, "data/raw/synthetic_jungian_critique.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_jungian_critique_summary.csv")

df = CSV.read(input_path, DataFrame)

df.credibility_score =
    0.48 .* df.interpretive_breadth .+
    0.56 .* df.empirical_support .+
    0.62 .* df.cultural_specificity .+
    0.50 .* df.gender_critical_revision .+
    0.58 .* df.methodological_explicitness .+
    0.46 .* df.clinical_utility .-
    0.72 .* df.universalization

df.overgeneralization_risk =
    0.62 .* df.interpretive_breadth .+
    0.70 .* df.universalization .-
    0.56 .* df.cultural_specificity .-
    0.44 .* df.empirical_support .-
    0.52 .* df.methodological_explicitness

df.retained_value_after_critique =
    0.62 .* df.symbolic_usefulness .+
    0.58 .* df.clinical_utility .+
    0.54 .* df.methodological_explicitness .+
    0.48 .* df.gender_critical_revision .-
    0.66 .* df.problematic_inherited_assumptions

summary = combine(
    groupby(df, :concept_family),
    :credibility_score => mean => :mean_credibility,
    :overgeneralization_risk => mean => :mean_overgeneralization_risk,
    :retained_value_after_critique => mean => :mean_retained_value
)

CSV.write(output_path, summary)
println(summary)
