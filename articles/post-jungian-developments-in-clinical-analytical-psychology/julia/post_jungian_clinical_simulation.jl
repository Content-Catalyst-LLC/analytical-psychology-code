# Post-Jungian Developments in Clinical Analytical Psychology
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/post-jungian-developments-in-clinical-analytical-psychology"
input_path = joinpath(article_dir, "data/raw/synthetic_post_jungian_clinical_models.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_post_jungian_clinical_summary.csv")

df = CSV.read(input_path, DataFrame)

df.clinical_adequacy =
    0.50 .* df.symbolic_depth .+
    0.62 .* df.relational_sophistication .+
    0.58 .* df.developmental_precision .+
    0.66 .* df.trauma_sensitivity .+
    0.52 .* df.embodied_regulation .+
    0.46 .* df.cultural_responsiveness .-
    0.60 .* df.doctrinal_rigidity

df.symbolic_readiness =
    0.56 .* df.affect_tolerance .+
    0.62 .* df.relational_holding .+
    0.52 .* df.grounding_capacity .-
    0.64 .* df.fragmentation_load

df.clinical_refinement_mean =
    (
        df.relational_sophistication .+
        df.developmental_precision .+
        df.trauma_sensitivity .+
        df.embodied_regulation .+
        df.cultural_responsiveness
    ) ./ 5.0

df.balance_index =
    0.60 .* df.symbolic_depth .-
    0.50 .* abs.(df.symbolic_depth .- df.clinical_refinement_mean)

summary = combine(
    groupby(df, :school_tendency),
    :clinical_adequacy => mean => :mean_clinical_adequacy,
    :symbolic_readiness => mean => :mean_symbolic_readiness,
    :balance_index => mean => :mean_balance_index,
    :symbolic_depth => mean => :mean_symbolic_depth,
    :clinical_refinement_mean => mean => :mean_clinical_refinement
)

CSV.write(output_path, summary)
println(summary)
