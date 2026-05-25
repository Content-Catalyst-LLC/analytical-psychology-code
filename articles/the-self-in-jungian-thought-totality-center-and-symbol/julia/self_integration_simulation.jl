# The Self in Jungian Thought
# Julia conceptual simulation: Self-relation and symbolic center strength

using CSV
using DataFrames
using Statistics

article_dir = "articles/the-self-in-jungian-thought-totality-center-and-symbol"
input_path = joinpath(article_dir, "data/raw/synthetic_self_integration_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_self_integration_summary.csv")

df = CSV.read(input_path, DataFrame)

df.totality_score_model =
    0.48 .* df.ego_coherence .+
    0.36 .* df.unconscious_activation .+
    0.58 .* df.symbolic_center_strength .+
    0.54 .* df.relational_coordination .-
    0.46 .* df.disjunction .-
    0.30 .* max.(df.inflation_risk, 0)

df.differentiation_score_model =
    0.42 .* df.ego_coherence .+
    0.38 .* df.symbolic_center_strength .+
    0.36 .* df.relational_coordination .-
    0.32 .* abs.(df.shadow_pressure)

df.self_relation_index_model =
    0.40 .* df.totality_score .+
    0.34 .* df.differentiation_score .+
    0.28 .* df.symbolic_center_strength .-
    0.30 .* max.(df.inflation_risk, 0)

df.integration_minus_inflation = df.self_relation_index .- df.inflation_risk

summary = combine(
    groupby(df, :individuation_pattern),
    :ego_coherence => mean => :mean_ego_coherence,
    :symbolic_center_strength => mean => :mean_symbolic_center_strength,
    :shadow_pressure => mean => :mean_shadow_pressure,
    :relational_coordination => mean => :mean_relational_coordination,
    :disjunction => mean => :mean_disjunction,
    :inflation_risk => mean => :mean_inflation_risk,
    :totality_score_model => mean => :mean_totality_score_model,
    :self_relation_index_model => mean => :mean_self_relation_index_model,
    :integration_minus_inflation => mean => :mean_integration_minus_inflation
)

CSV.write(output_path, summary)
println(summary)
