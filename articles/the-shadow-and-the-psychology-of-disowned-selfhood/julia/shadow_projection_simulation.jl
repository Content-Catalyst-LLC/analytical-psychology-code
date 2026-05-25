# The Shadow and the Psychology of Disowned Selfhood
# Julia conceptual simulation: shadow activation and projection

using CSV
using DataFrames
using Statistics

article_dir = "articles/the-shadow-and-the-psychology-of-disowned-selfhood"
input_path = joinpath(article_dir, "data/raw/synthetic_shadow_projection_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_shadow_projection_summary.csv")

df = CSV.read(input_path, DataFrame)

df.shadow_activation_model =
    0.72 .* df.latent_disowned .* df.cue_intensity .+
    0.56 .* df.shadow_discrepancy .+
    0.42 .* df.affective_charge .-
    0.48 .* df.reflective_capacity

df.projection_intensity_model =
    0.76 .* df.shadow_activation .+
    0.44 .* df.affective_charge .+
    0.32 .* df.persona_rigidity .-
    0.56 .* df.reflective_capacity

df.shame_response_model =
    0.42 .* df.shadow_activation .+
    0.34 .* df.persona_rigidity .-
    0.30 .* df.reflective_capacity

df.integration_capacity_model =
    0.50 .* df.reflective_capacity .-
    0.34 .* abs.(df.projection_intensity) .-
    0.26 .* df.shame_response .+
    0.28 .* df.time ./ maximum(df.time)

df.false_innocence_pressure =
    df.persona_rigidity .+
    df.projection_intensity .-
    df.reflective_capacity

summary = combine(
    groupby(df, :shadow_configuration),
    :shadow_discrepancy => mean => :mean_shadow_discrepancy,
    :affective_charge => mean => :mean_affective_charge,
    :persona_rigidity => mean => :mean_persona_rigidity,
    :reflective_capacity => mean => :mean_reflective_capacity,
    :shadow_activation_model => mean => :mean_shadow_activation_model,
    :projection_intensity_model => mean => :mean_projection_intensity_model,
    :shame_response_model => mean => :mean_shame_response_model,
    :integration_capacity_model => mean => :mean_integration_capacity_model,
    :false_innocence_pressure => mean => :mean_false_innocence_pressure
)

CSV.write(output_path, summary)
println(summary)
