# Complexes, Affect, and Repetition in Analytical Psychology
# Julia conceptual simulation: recurrence pressure and recovery potential

using CSV
using DataFrames
using Statistics

article_dir = "articles/complexes-affect-and-repetition-in-analytical-psychology"
input_path = joinpath(article_dir, "data/raw/synthetic_complex_activation_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_complex_type_summary.csv")

df = CSV.read(input_path, DataFrame)

df.modeled_affect_intensity =
    0.48 .* df.affect_intensity .+
    0.54 .* df.trigger_intensity .+
    0.34 .* df.relational_threat .+
    0.30 .* df.evaluation_pressure .+
    0.28 .* df.shame_cue .-
    0.36 .* df.regulation_capacity .-
    0.24 .* df.relational_buffer

df.modeled_complex_activation =
    0.58 .* df.complex_activation .+
    0.70 .* df.affect_intensity .+
    0.34 .* df.trigger_intensity .+
    0.26 .* df.relational_threat .-
    0.42 .* df.regulation_capacity .-
    0.30 .* df.relational_buffer

df.recurrence_pressure =
    df.complex_activation .+
    df.affect_intensity .+
    df.projection_pressure .+
    df.transference_pressure .-
    df.regulation_capacity .-
    df.relational_buffer

df.recovery_potential =
    df.regulation_capacity .+
    df.relational_buffer .-
    df.affect_intensity .-
    0.40 .* df.complex_activation

summary = combine(
    groupby(df, :complex_type),
    :trigger_intensity => mean => :mean_trigger_intensity,
    :affect_intensity => mean => :mean_affect_intensity,
    :complex_activation => mean => :mean_complex_activation,
    :repetition_probability => mean => :mean_repetition_probability,
    :recurrence_pressure => mean => :mean_recurrence_pressure,
    :recovery_potential => mean => :mean_recovery_potential
)

CSV.write(output_path, summary)
println(summary)
