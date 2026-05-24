# Non-Western Symbol Systems and the Limits of Jungian Universality
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/non-western-symbol-systems-limits-jungian-universality"
input_path = joinpath(article_dir, "data/raw/synthetic_symbolic_comparison.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_symbolic_comparison_summary.csv")

df = CSV.read(input_path, DataFrame)

df.comparative_quality =
    0.52 .* df.recurrence .+
    0.68 .* df.specificity .+
    0.58 .* df.linguistic_depth .+
    0.54 .* df.ritual_context .+
    0.62 .* df.dialogical_accountability .-
    0.66 .* df.universalizing_force .-
    0.42 .* df.abstraction_pressure

df.flattening_risk =
    0.70 .* df.universalizing_force .+
    0.64 .* df.abstraction_pressure .-
    0.58 .* df.specificity .-
    0.54 .* df.dialogical_accountability .-
    0.38 .* df.linguistic_depth

df.equivalence_claim_strength =
    0.44 .* df.recurrence .+
    0.54 .* df.functional_convergence .-
    0.62 .* df.contextual_divergence

summary = combine(
    groupby(df, :tradition_layer),
    :comparative_quality => mean => :mean_comparative_quality,
    :flattening_risk => mean => :mean_flattening_risk,
    :equivalence_claim_strength => mean => :mean_equivalence_claim_strength
)

CSV.write(output_path, summary)
println(summary)
