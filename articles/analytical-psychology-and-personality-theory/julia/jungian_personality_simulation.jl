# Analytical Psychology and Personality Theory
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/analytical-psychology-and-personality-theory"
input_path = joinpath(article_dir, "data/raw/synthetic_jungian_personality.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_typological_function_summary.csv")

df = CSV.read(input_path, DataFrame)

df.onesidedness_model =
    (df.conscious_orientation .- df.shadow_acknowledgment).^2 .+
    (df.persona_identification .- df.typological_flexibility).^2 .+
    (df.complex_activation .- df.symbolic_relation).^2

df.unconscious_compensation_model =
    0.48 .* df.onesidedness_model .+
    0.40 .* abs.(df.complex_activation) .-
    0.28 .* df.reflective_capacity

df.developmental_integration_model =
    0.54 .* df.typological_flexibility .+
    0.56 .* df.shadow_acknowledgment .+
    0.62 .* df.symbolic_relation .+
    0.48 .* df.reflective_capacity .-
    0.38 .* abs.(df.complex_activation) .-
    0.22 .* df.onesidedness_model

summary = combine(
    groupby(df, [:dominant_function, :dominant_attitude]),
    :developmental_integration_model => mean => :mean_developmental_integration_model,
    :unconscious_compensation_model => mean => :mean_unconscious_compensation_model,
    :onesidedness_model => mean => :mean_onesidedness_model,
    :symbolic_relation => mean => :mean_symbolic_relation,
    :shadow_acknowledgment => mean => :mean_shadow_acknowledgment,
    :persona_identification => mean => :mean_persona_identification
)

CSV.write(output_path, summary)
println(summary)
