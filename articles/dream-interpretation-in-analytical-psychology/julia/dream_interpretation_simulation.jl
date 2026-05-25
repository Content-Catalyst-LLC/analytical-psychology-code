# Dream Interpretation in Analytical Psychology
# Julia conceptual simulation: compensation and symbolic recurrence

using CSV
using DataFrames
using Statistics

article_dir = "articles/dream-interpretation-in-analytical-psychology"
input_path = joinpath(article_dir, "data/raw/synthetic_dream_compensation_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_dream_interpretation_summary.csv")

df = CSV.read(input_path, DataFrame)

df.one_sidedness_gap = df.unconscious_pressure .- df.conscious_onesidedness

df.compensatory_signal_model =
    0.72 .* df.one_sidedness_gap .+
    0.42 .* df.affective_intensity .-
    0.20 .* df.reflective_capacity

df.symbolic_recurrence_model =
    0.44 .* df.previous_dream_output .+
    0.36 .* df.symbolic_repertoire .+
    0.24 .* df.latent_development

df.dream_output_model =
    0.52 .* df.compensatory_signal .+
    0.48 .* df.symbolic_recurrence .+
    0.38 .* df.affective_intensity .+
    0.32 .* df.latent_development

df.integration_signal_model =
    0.42 .* df.reflective_capacity .+
    0.38 .* df.latent_development .+
    0.30 .* df.symbolic_repertoire .-
    0.24 .* abs.(df.compensatory_signal)

summary = combine(
    groupby(df, :dream_series_type),
    :conscious_onesidedness => mean => :mean_conscious_onesidedness,
    :unconscious_pressure => mean => :mean_unconscious_pressure,
    :compensatory_signal_model => mean => :mean_compensatory_signal_model,
    :symbolic_recurrence_model => mean => :mean_symbolic_recurrence_model,
    :dream_output_model => mean => :mean_dream_output_model,
    :integration_signal_model => mean => :mean_integration_signal_model
)

CSV.write(output_path, summary)
println(summary)
