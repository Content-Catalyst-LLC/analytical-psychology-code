# Jung, Freud, and the Divergence of Depth Psychologies
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/jung-freud-and-the-divergence-of-depth-psychologies"
input_path = joinpath(article_dir, "data/raw/synthetic_depth_psychology_cases.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_depth_psychology_summary.csv")

df = CSV.read(input_path, DataFrame)

df.freudian_score =
    0.66 .* df.repression .+
    0.70 .* df.sexuality_conflict .+
    0.62 .* df.infantile_history .+
    0.58 .* df.defense_intensity .+
    0.50 .* df.transference_pressure .-
    0.30 .* df.mythic_amplification

df.jungian_score =
    0.58 .* df.compensation .+
    0.70 .* df.archetypal_density .+
    0.62 .* df.prospective_development .+
    0.64 .* df.mythic_amplification .+
    0.60 .* df.symbolic_coherence .+
    0.56 .* df.individuation_pressure .-
    0.24 .* df.repression

df.integrative_depth_score =
    0.48 .* df.repression .+
    0.46 .* df.defense_intensity .+
    0.44 .* df.transference_pressure .+
    0.48 .* df.compensation .+
    0.46 .* df.symbolic_coherence .+
    0.44 .* df.prospective_development

summary = combine(
    groupby(df, :case_type),
    :freudian_score => mean => :mean_freudian,
    :jungian_score => mean => :mean_jungian,
    :integrative_depth_score => mean => :mean_integrative_depth
)

CSV.write(output_path, summary)
println(summary)
