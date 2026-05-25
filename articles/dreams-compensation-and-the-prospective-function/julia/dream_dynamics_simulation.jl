# Dreams, Compensation, and the Prospective Function
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/dreams-compensation-and-the-prospective-function"
input_path = joinpath(article_dir, "data/raw/synthetic_dream_dynamics_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_dream_series_summary.csv")

df = CSV.read(input_path, DataFrame)

df.one_sidedness_gap = df.unconscious_pressure .- df.conscious_onesidedness

df.compensatory_intensity_model =
    0.72 .* df.one_sidedness_gap .+
    0.36 .* df.affective_intensity .-
    0.22 .* df.reflective_capacity

df.prospective_intensity_model =
    0.64 .* df.latent_growth .+
    0.28 .* df.symbolic_literacy .+
    0.22 .* df.reflective_capacity .+
    0.18 .* df.previous_dream_output

df.dream_output_model =
    0.55 .* df.compensatory_intensity .+
    0.52 .* df.prospective_intensity .+
    0.40 .* df.affective_intensity .+
    0.32 .* df.previous_dream_output

df.integration_signal_model =
    0.44 .* df.prospective_intensity .+
    0.36 .* df.reflective_capacity .+
    0.30 .* df.symbolic_literacy .-
    0.24 .* abs.(df.compensatory_intensity)

summary = combine(
    groupby(df, :dream_series_type),
    :conscious_onesidedness => mean => :mean_conscious_onesidedness,
    :unconscious_pressure => mean => :mean_unconscious_pressure,
    :compensatory_intensity_model => mean => :mean_compensatory_intensity_model,
    :prospective_intensity_model => mean => :mean_prospective_intensity_model,
    :dream_output_model => mean => :mean_dream_output_model,
    :integration_signal_model => mean => :mean_integration_signal_model
)

CSV.write(output_path, summary)
println(summary)
