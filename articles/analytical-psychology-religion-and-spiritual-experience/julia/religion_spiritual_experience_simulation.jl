# Analytical Psychology, Religion, and Spiritual Experience
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/analytical-psychology-religion-and-spiritual-experience"
input_path = joinpath(article_dir, "data/raw/synthetic_religion_spiritual_experience.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_religious_environment_summary.csv")

df = CSV.read(input_path, DataFrame)

df.containment_gap = df.numinous_intensity .- df.symbolic_containment

df.integration =
    0.60 .* df.symbolic_containment .+
    0.55 .* df.ego_stability .+
    0.48 .* df.shadow_awareness .+
    0.42 .* df.ritual_support .+
    0.36 .* df.numinous_intensity .-
    0.65 .* (df.containment_gap .^ 2) .-
    0.30 .* df.religious_trauma_pressure

df.inflation_risk =
    0.70 .* df.numinous_intensity .+
    0.58 .* df.perceived_mission .+
    0.35 .* df.doctrinal_rigidity .-
    0.55 .* df.ego_stability .-
    0.45 .* df.shadow_awareness .-
    0.42 .* df.humility_limit_awareness .-
    0.30 .* df.ritual_support

df.living_symbol_score =
    0.50 .* df.symbolic_vitality .+
    0.40 .* df.ritual_support .+
    0.35 .* df.shadow_awareness .+
    0.28 .* df.communal_memory .-
    0.45 .* df.doctrinal_rigidity .-
    0.25 .* df.religious_trauma_pressure

summary = combine(
    groupby(df, :religious_environment),
    :integration => mean => :mean_integration,
    :inflation_risk => mean => :mean_inflation_risk,
    :living_symbol_score => mean => :mean_living_symbol_score,
    :symbolic_containment => mean => :mean_symbolic_containment,
    :ritual_support => mean => :mean_ritual_support,
    :religious_trauma_pressure => mean => :mean_religious_trauma_pressure
)

CSV.write(output_path, summary)
println(summary)
