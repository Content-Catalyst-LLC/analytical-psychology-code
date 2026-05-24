# Why Analytical Psychology Still Matters
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/why-analytical-psychology-still-matters"
input_path = joinpath(article_dir, "data/raw/synthetic_symbolic_relevance.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_relevance_summary.csv")

df = CSV.read(input_path, DataFrame)

df.contemporary_relevance =
    0.62 .* df.symbolic_depth .+
    0.58 .* df.meaning_coherence .+
    0.54 .* df.clinical_utility .+
    0.48 .* df.cultural_interpretive_power .+
    0.60 .* df.revision_capacity .-
    0.70 .* df.doctrinal_rigidity

summary = combine(
    groupby(df, :tradition_type),
    :contemporary_relevance => mean => :mean_relevance,
    :revision_capacity => mean => :mean_revision_capacity,
    :doctrinal_rigidity => mean => :mean_doctrinal_rigidity
)

CSV.write(output_path, summary)
println(summary)
