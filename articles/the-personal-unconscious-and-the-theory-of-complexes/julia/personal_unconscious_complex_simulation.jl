# The Personal Unconscious and the Theory of Complexes
# Julia conceptual simulation: complex pressure and integration potential

using CSV
using DataFrames
using Statistics

article_dir = "articles/the-personal-unconscious-and-the-theory-of-complexes"
input_path = joinpath(article_dir, "data/raw/personal_unconscious_complex_activation_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_complex_type_summary.csv")

df = CSV.read(input_path, DataFrame)

df.modeled_affect_intensity =
    0.50 .* df.affect_intensity .+
    0.58 .* df.trigger_intensity .+
    0.34 .* df.relational_threat .+
    0.32 .* df.evaluation_pressure .+
    0.30 .* df.shame_cue .+
    0.26 .* df.guilt_cue .+
    0.58 .* df.unresolved_affect .-
    0.38 .* df.regulation_capacity .-
    0.28 .* df.contextual_support

df.modeled_complex_activation =
    0.58 .* df.complex_activation .+
    0.70 .* df.affect_intensity .+
    0.34 .* df.trigger_intensity .+
    0.26 .* df.relational_threat .+
    0.22 .* df.evaluation_pressure .-
    0.42 .* df.regulation_capacity .-
    0.32 .* df.contextual_support

df.complex_pressure =
    df.complex_activation .+
    df.affect_intensity .+
    df.unresolved_affect .+
    df.projection_pressure .+
    df.transference_pressure .-
    df.regulation_capacity .-
    df.contextual_support

df.integration_potential =
    df.regulation_capacity .+
    df.contextual_support .-
    df.affect_intensity .-
    0.40 .* df.complex_activation

summary = combine(
    groupby(df, :complex_type),
    :trigger_intensity => mean => :mean_trigger_intensity,
    :affect_intensity => mean => :mean_affect_intensity,
    :complex_activation => mean => :mean_complex_activation,
    :repetition_probability => mean => :mean_repetition_probability,
    :complex_pressure => mean => :mean_complex_pressure,
    :integration_potential => mean => :mean_integration_potential
)

CSV.write(output_path, summary)
println(summary)
