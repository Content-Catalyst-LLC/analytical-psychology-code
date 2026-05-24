# Relational and Developmental Jungian Psychotherapy
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/relational-and-developmental-jungian-psychotherapy"
input_path = joinpath(article_dir, "data/raw/synthetic_relational_jungian_therapy.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_relational_therapy_summary.csv")

df = CSV.read(input_path, DataFrame)

df.developmental_integration =
    0.62 .* df.relational_safety .+
    0.42 .* df.attachment_security .+
    0.55 .* df.affect_regulation .+
    0.46 .* df.repair_capacity .+
    0.36 .* df.embodied_safety .+
    0.58 .* df.symbolic_capacity .+
    0.44 .* df.reflective_self .-
    0.58 .* df.fragmentation .-
    0.38 .* df.shame_load .-
    0.28 .* df.rupture_intensity

df.symbolic_growth =
    0.55 .* df.relational_safety .+
    0.50 .* df.affect_regulation .+
    0.34 .* df.repair_capacity .+
    0.30 .* df.embodied_safety .-
    0.42 .* df.shame_load .-
    0.36 .* df.fragmentation

df.rupture_risk =
    0.48 .* df.rupture_intensity .+
    0.34 .* df.shame_load .+
    0.32 .* df.fragmentation .-
    0.36 .* df.repair_capacity .-
    0.30 .* df.relational_safety .-
    0.26 .* df.reflective_self

summary = combine(
    groupby(df, :clinical_presentation),
    :developmental_integration => mean => :mean_developmental_integration,
    :symbolic_growth => mean => :mean_symbolic_growth,
    :rupture_risk => mean => :mean_rupture_risk,
    :relational_safety => mean => :mean_relational_safety,
    :symbolic_capacity => mean => :mean_symbolic_capacity,
    :fragmentation => mean => :mean_fragmentation
)

CSV.write(output_path, summary)
println(summary)
