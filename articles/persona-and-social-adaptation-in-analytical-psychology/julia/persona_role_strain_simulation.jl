# Persona and Social Adaptation in Analytical Psychology
# Julia conceptual simulation: persona strength, rigidity, and strain

using CSV
using DataFrames
using Statistics

article_dir = "articles/persona-and-social-adaptation-in-analytical-psychology"
input_path = joinpath(article_dir, "data/raw/synthetic_persona_role_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_persona_role_summary.csv")

df = CSV.read(input_path, DataFrame)

df.developmental_time = df.time ./ maximum(df.time)

df.persona_strength_model =
    0.64 .* df.role_demand .+
    0.48 .* df.audience_reward .+
    0.36 .* df.institutional_reward .-
    0.30 .* df.inward_complexity .+
    0.42 .* df.reflective_flexibility

df.persona_rigidity_model =
    0.52 .* df.persona_strength .+
    0.42 .* df.status_dependence .+
    0.34 .* df.institutional_reward .-
    0.46 .* df.reflective_flexibility

df.psychic_strain_model =
    0.50 .* df.persona_strength .+
    0.62 .* (df.persona_inward_gap .^ 2) .+
    0.42 .* df.persona_rigidity .+
    0.36 .* df.shadow_pressure .-
    0.52 .* df.reflective_flexibility

df.burnout_risk_model =
    0.46 .* df.psychic_strain .+
    0.36 .* df.role_demand .+
    0.30 .* df.persona_rigidity .-
    0.42 .* df.reflective_flexibility

df.individuation_readiness_model =
    0.48 .* df.reflective_flexibility .+
    0.34 .* df.inward_complexity .-
    0.28 .* df.persona_rigidity .-
    0.24 .* df.psychic_strain .+
    0.18 .* df.developmental_time

summary = combine(
    groupby(df, :persona_pattern),
    :role_demand => mean => :mean_role_demand,
    :audience_reward => mean => :mean_audience_reward,
    :institutional_reward => mean => :mean_institutional_reward,
    :reflective_flexibility => mean => :mean_reflective_flexibility,
    :persona_strength_model => mean => :mean_persona_strength_model,
    :persona_rigidity_model => mean => :mean_persona_rigidity_model,
    :psychic_strain_model => mean => :mean_psychic_strain_model,
    :burnout_risk_model => mean => :mean_burnout_risk_model,
    :individuation_readiness_model => mean => :mean_individuation_readiness_model
)

CSV.write(output_path, summary)
println(summary)
