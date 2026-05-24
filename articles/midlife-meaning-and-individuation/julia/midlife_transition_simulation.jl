# Midlife, Meaning, and Individuation
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/midlife-meaning-and-individuation"
input_path = joinpath(article_dir, "data/raw/synthetic_midlife_transition.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_midlife_pattern_summary.csv")

df = CSV.read(input_path, DataFrame)

df.transition_intensity =
    0.72 .* df.outward_inward_discrepancy .+
    0.58 .* df.unlived_life_pressure .+
    0.52 .* df.finitude_awareness .+
    0.46 .* df.individuation_pressure .-
    0.30 .* df.reflective_capacity

df.meaning_coherence_model =
    0.40 .* df.adaptation_strength .+
    0.58 .* df.symbolic_activation .+
    0.62 .* df.individuation_pressure .+
    0.42 .* df.shadow_integration .+
    0.36 .* df.reflective_capacity .-
    0.72 .* df.outward_inward_discrepancy

df.second_half_orientation_model =
    0.56 .* df.symbolic_activation .+
    0.54 .* df.shadow_integration .+
    0.48 .* df.reflective_capacity .+
    0.42 .* df.finitude_awareness .-
    0.42 .* df.persona_identification .-
    0.25 .* df.outward_inward_discrepancy

summary = combine(
    groupby(df, :midlife_pattern),
    :meaning_coherence_model => mean => :mean_meaning_coherence_model,
    :second_half_orientation_model => mean => :mean_second_half_orientation_model,
    :transition_intensity => mean => :mean_transition_intensity,
    :symbolic_activation => mean => :mean_symbolic_activation,
    :shadow_integration => mean => :mean_shadow_integration,
    :persona_identification => mean => :mean_persona_identification
)

CSV.write(output_path, summary)
println(summary)
