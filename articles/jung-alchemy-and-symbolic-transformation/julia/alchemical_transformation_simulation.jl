# Jung, Alchemy, and Symbolic Transformation
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/jung-alchemy-and-symbolic-transformation"
input_path = joinpath(article_dir, "data/raw/synthetic_alchemical_transformation_stages.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_alchemical_stage_summary.csv")

df = CSV.read(input_path, DataFrame)

df.transformation_score =
    0.42 .* df.nigredo_pressure .+
    0.55 .* df.albedo_clarity .+
    0.66 .* df.rubedo_vitality .+
    0.58 .* df.vessel_strength .-
    0.60 .* df.onesidedness .-
    0.30 .* abs.(df.mercurial_volatility)

df.coniunctio_index =
    0.55 .* (df.pole_x .* df.pole_y) .-
    0.40 .* abs.(df.pole_x .- df.pole_y) .+
    0.35 .* df.vessel_strength

df.vessel_failure_risk =
    max.(0, df.affective_heat .+ df.shadow_intensity .- df.vessel_strength)

df.integration_readiness =
    df.transformation_score .+ df.coniunctio_index .- df.vessel_failure_risk

summary = combine(
    groupby(df, :symbolic_stage),
    :transformation_score => mean => :mean_transformation,
    :coniunctio_index => mean => :mean_coniunctio,
    :vessel_failure_risk => mean => :mean_vessel_failure_risk,
    :integration_readiness => mean => :mean_integration_readiness
)

CSV.write(output_path, summary)
println(summary)
