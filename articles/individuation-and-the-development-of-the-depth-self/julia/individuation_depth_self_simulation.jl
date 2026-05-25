# Individuation and the Development of the Depth Self
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/individuation-and-the-development-of-the-depth-self"
input_path = joinpath(article_dir, "data/raw/synthetic_individuation_depth_self.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_individuation_pathway_summary.csv")

df = CSV.read(input_path, DataFrame)

df.onesidedness_model =
    (df.ego_coherence .- df.shadow_acknowledgment).^2 .+
    (df.symbolic_relation .- df.complex_activation).^2 .+
    (df.persona_identification .- df.reflective_capacity).^2

df.compensation_pressure_model =
    0.44 .* df.onesidedness_model .+
    0.36 .* abs.(df.complex_activation) .-
    0.28 .* df.reflective_capacity

df.depth_self_integration_model =
    0.54 .* df.ego_coherence .+
    0.62 .* df.shadow_acknowledgment .+
    0.66 .* df.symbolic_relation .+
    0.52 .* df.reflective_capacity .+
    0.34 .* df.body_awareness .+
    0.36 .* df.ethical_accountability .+
    0.30 .* df.relational_life .-
    0.42 .* abs.(df.complex_activation) .-
    0.28 .* df.onesidedness_model

summary = combine(
    groupby(df, :individuation_pathway),
    :depth_self_integration_model => mean => :mean_depth_self_integration_model,
    :compensation_pressure_model => mean => :mean_compensation_pressure_model,
    :onesidedness_model => mean => :mean_onesidedness_model,
    :symbolic_relation => mean => :mean_symbolic_relation,
    :shadow_acknowledgment => mean => :mean_shadow_acknowledgment,
    :persona_identification => mean => :mean_persona_identification
)

CSV.write(output_path, summary)
println(summary)
