# Childhood Development in Jungian and Post-Jungian Thought
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/childhood-development-in-jungian-and-post-jungian-thought"
input_path = joinpath(article_dir, "data/raw/synthetic_childhood_development.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_developmental_context_summary.csv")

df = CSV.read(input_path, DataFrame)

df.developmental_strain =
    (df.ego_differentiation .- df.relational_security).^2 .+
    (df.symbolic_capacity .- df.relational_security).^2 .+
    df.complex_activation.^2

df.symbolic_capacity_model =
    0.48 .* df.symbolic_play .+
    0.36 .* df.caregiver_mirroring .+
    0.30 .* df.bodily_regulation .+
    0.26 .* df.relational_security .-
    0.30 .* df.family_tension

df.developmental_coherence_model =
    0.55 .* df.ego_differentiation .+
    0.70 .* df.relational_security .+
    0.60 .* df.symbolic_capacity .+
    0.48 .* df.affect_regulation .+
    0.34 .* df.symbolic_play .-
    0.50 .* df.complex_activation .-
    0.24 .* df.developmental_strain

summary = combine(
    groupby(df, :developmental_context),
    :developmental_coherence_model => mean => :mean_developmental_coherence_model,
    :symbolic_capacity_model => mean => :mean_symbolic_capacity_model,
    :relational_security => mean => :mean_relational_security,
    :symbolic_play => mean => :mean_symbolic_play,
    :complex_activation => mean => :mean_complex_activation,
    :affect_regulation => mean => :mean_affect_regulation
)

CSV.write(output_path, summary)
println(summary)
