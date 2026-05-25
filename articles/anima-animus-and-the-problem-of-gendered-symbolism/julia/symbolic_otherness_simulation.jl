# Anima, Animus, and the Problem of Gendered Symbolism
# Julia conceptual simulation: symbolic otherness and projection

using CSV
using DataFrames
using Statistics

article_dir = "articles/anima-animus-and-the-problem-of-gendered-symbolism"
input_path = joinpath(article_dir, "data/raw/synthetic_symbolic_otherness_panel.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_symbolic_otherness_summary.csv")

df = CSV.read(input_path, DataFrame)

df.projection_intensity_model =
    0.70 .* df.unrealized_capacity .+
    0.65 .* df.affective_charge .+
    0.50 .* df.relational_trigger .+
    0.34 .* df.symbolic_discrepancy .+
    0.22 .* df.gender_code_rigidity .-
    0.55 .* df.reflective_mediation

df.symbolic_integration_model =
    0.46 .* df.reflective_mediation .+
    0.42 .* df.symbolic_flexibility .-
    0.30 .* df.projection_rigidity .-
    0.24 .* abs.(df.projection_intensity)

df.coding_flexibility_gap = df.symbolic_flexibility .- df.gender_code_rigidity

summary = combine(
    groupby(df, :symbolic_pattern),
    :unrealized_capacity => mean => :mean_unrealized_capacity,
    :affective_charge => mean => :mean_affective_charge,
    :reflective_mediation => mean => :mean_reflective_mediation,
    :gender_code_rigidity => mean => :mean_gender_code_rigidity,
    :symbolic_flexibility => mean => :mean_symbolic_flexibility,
    :projection_intensity_model => mean => :mean_projection_intensity_model,
    :symbolic_integration_model => mean => :mean_symbolic_integration_model,
    :coding_flexibility_gap => mean => :mean_coding_flexibility_gap
)

CSV.write(output_path, summary)
println(summary)
