# Psychological Types: Introversion, Extraversion, and the Four Functions
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/psychological-types-introversion-extraversion-and-the-four-functions"
input_path = joinpath(article_dir, "data/raw/synthetic_psychological_types.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_type_summary.csv")

df = CSV.read(input_path, DataFrame)

df.dominant_inferior_gap = df.dominant_strength .- df.inferior_strength

df.compensation_strain_model =
    0.70 .* df.dominant_inferior_gap .+
    0.55 .* df.function_variance .+
    0.45 .* df.unconscious_pressure .-
    0.28 .* df.reflective_capacity

df.conscious_coherence_model =
    0.52 .* df.dominant_strength .+
    0.20 .* df.attitude_score .-
    0.30 .* df.function_variance .+
    0.26 .* df.reflective_capacity

df.developmental_integration_model =
    0.42 .* df.inferior_strength .+
    0.38 .* df.symbolic_relation .+
    0.36 .* df.reflective_capacity .-
    0.32 .* df.function_variance .-
    0.26 .* df.compensation_strain

summary = combine(
    groupby(df, [:dominant_function, :inferior_function, :dominant_attitude]),
    :dominant_inferior_gap => mean => :mean_gap,
    :compensation_strain_model => mean => :mean_compensation_strain_model,
    :conscious_coherence_model => mean => :mean_conscious_coherence_model,
    :developmental_integration_model => mean => :mean_developmental_integration_model,
    :symbolic_relation => mean => :mean_symbolic_relation,
    :reflective_capacity => mean => :mean_reflective_capacity
)

CSV.write(output_path, summary)
println(summary)
