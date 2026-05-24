# Numinous Experience, Spiritual Emergency, and Symbolic Crisis
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/numinous-experience-spiritual-emergency-and-symbolic-crisis"
input_path = joinpath(article_dir, "data/raw/synthetic_numinous_crisis.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_numinous_environment_summary.csv")

df = CSV.read(input_path, DataFrame)

df.crisis_risk =
    0.75 .* df.numinous_intensity .+
    0.45 .* df.trauma_vulnerability .+
    0.35 .* df.practice_intensity .+
    0.30 .* df.sleep_disruption .-
    0.55 .* df.symbolic_containment .-
    0.60 .* df.ego_stability .-
    0.40 .* df.shadow_awareness .-
    0.35 .* df.relational_support

df.inflation_risk =
    0.58 .* df.numinous_intensity .+
    0.62 .* df.perceived_mission .-
    0.48 .* df.shadow_awareness .-
    0.52 .* df.humility_limit_awareness .-
    0.30 .* df.relational_support

df.integration_potential =
    0.60 .* df.symbolic_containment .+
    0.55 .* df.ego_stability .+
    0.45 .* df.shadow_awareness .+
    0.50 .* df.relational_support .+
    0.35 .* df.humility_limit_awareness .-
    0.70 .* df.crisis_risk .-
    0.38 .* df.inflation_risk

df.containment_index =
    (df.symbolic_containment .+ df.ritual_containment .+ df.relational_support) ./ 3.0

df.vulnerability_index =
    (df.trauma_vulnerability .+ df.sleep_disruption .+ df.practice_intensity) ./ 3.0

summary = combine(
    groupby(df, :symbolic_environment),
    :crisis_risk => mean => :mean_crisis_risk,
    :inflation_risk => mean => :mean_inflation_risk,
    :integration_potential => mean => :mean_integration_potential,
    :containment_index => mean => :mean_containment_index,
    :vulnerability_index => mean => :mean_vulnerability_index
)

CSV.write(output_path, summary)
println(summary)
