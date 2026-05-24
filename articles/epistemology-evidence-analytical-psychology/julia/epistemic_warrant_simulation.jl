# Epistemology and Evidence in Analytical Psychology
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/epistemology-evidence-analytical-psychology"
input_path = joinpath(article_dir, "data/raw/synthetic_epistemic_warrant.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_epistemic_warrant_summary.csv")

df = CSV.read(input_path, DataFrame)

df.credibility_score =
    0.52 .* df.empirical_support .+
    0.58 .* df.hermeneutic_coherence .+
    0.62 .* df.clinical_utility .+
    0.56 .* df.phenomenological_adequacy .+
    0.44 .* df.contextual_specificity .+
    0.60 .* df.methodological_explicitness .-
    0.72 .* df.ambiguity_inflation

df.overreach_risk =
    0.64 .* df.universalizing_force .+
    0.70 .* df.ambiguity_inflation .+
    0.58 .* df.selective_evidence .-
    0.66 .* df.methodological_explicitness .-
    0.32 .* df.contextual_specificity

summary = combine(
    groupby(df, :claim_type),
    :credibility_score => mean => :mean_credibility,
    :overreach_risk => mean => :mean_overreach_risk,
    :methodological_explicitness => mean => :mean_methodological_explicitness
)

CSV.write(output_path, summary)
println(summary)
