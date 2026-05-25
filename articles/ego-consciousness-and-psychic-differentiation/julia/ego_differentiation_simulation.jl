# Ego, Consciousness, and Psychic Differentiation
# Julia conceptual simulation: ego coherence and psychic strain

using CSV
using DataFrames
using Statistics

article_dir = "articles/ego-consciousness-and-psychic-differentiation"
input_path = joinpath(article_dir, "data/raw/synthetic_ego_differentiation_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_ego_differentiation_summary.csv")

df = CSV.read(input_path, DataFrame)

df.ego_coherence_model =
    0.72 .* df.differentiation .-
    0.48 .* df.unconscious_pressure .+
    0.60 .* df.reflective_flexibility .-
    0.22 .* df.one_sidedness

df.ego_rigidity_model =
    0.54 .* df.persona_identification .+
    0.42 .* df.one_sidedness .-
    0.36 .* df.reflective_flexibility

df.ego_inflation_model =
    0.46 .* df.ego_coherence .+
    0.50 .* df.persona_identification .+
    0.30 .* df.differentiation .-
    0.52 .* df.reflective_flexibility .-
    0.32 .* df.shadow_activation

df.psychic_strain_model =
    0.40 .* df.one_sidedness .+
    0.46 .* df.unconscious_pressure .+
    0.42 .* df.shadow_activation .+
    0.34 .* df.ego_rigidity .-
    0.44 .* df.reflective_flexibility

df.individuation_readiness_model =
    0.42 .* df.ego_coherence .+
    0.44 .* df.reflective_flexibility .+
    0.28 .* df.function_balance .-
    0.30 .* df.ego_inflation .-
    0.24 .* df.psychic_strain

summary = combine(
    groupby(df, :dominant_pattern),
    :differentiation => mean => :mean_differentiation,
    :function_balance => mean => :mean_function_balance,
    :reflective_flexibility => mean => :mean_reflective_flexibility,
    :unconscious_pressure => mean => :mean_unconscious_pressure,
    :ego_coherence_model => mean => :mean_ego_coherence_model,
    :ego_rigidity_model => mean => :mean_ego_rigidity_model,
    :ego_inflation_model => mean => :mean_ego_inflation_model,
    :psychic_strain_model => mean => :mean_psychic_strain_model,
    :individuation_readiness_model => mean => :mean_individuation_readiness_model
)

CSV.write(output_path, summary)
println(summary)
