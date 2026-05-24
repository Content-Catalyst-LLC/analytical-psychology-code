# Archetypal Psychology After Jung
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/archetypal-psychology-after-jung"
input_path = joinpath(article_dir, "data/raw/synthetic_archetypal_depth.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_archetypal_depth_summary.csv")

df = CSV.read(input_path, DataFrame)

df.archetypal_depth =
    0.65 .* df.psychic_plurality .+
    0.70 .* df.imaginal_density .+
    0.58 .* df.metaphorical_richness .+
    0.46 .* df.symptom_image_intensity .-
    0.55 .* df.integrative_pressure

df.aesthetic_richness =
    0.62 .* df.imaginal_density .+
    0.54 .* df.psychic_plurality .+
    0.60 .* df.metaphorical_richness .-
    0.38 .* df.literalizing_force

df.flattening_risk =
    0.58 .* df.integrative_pressure .+
    0.62 .* df.literalizing_force .+
    0.56 .* df.diagnostic_dominance .-
    0.48 .* df.imaginal_density .-
    0.34 .* df.clinical_containment

summary = combine(
    groupby(df, :presentation_type),
    :archetypal_depth => mean => :mean_archetypal_depth,
    :aesthetic_richness => mean => :mean_aesthetic_richness,
    :flattening_risk => mean => :mean_flattening_risk
)

CSV.write(output_path, summary)
println(summary)
