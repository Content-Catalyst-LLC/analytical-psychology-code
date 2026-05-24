# Trauma, Dissociation, and the Fragmented Psyche
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/trauma-dissociation-and-the-fragmented-psyche"
input_path = joinpath(article_dir, "data/raw/synthetic_trauma_dissociation.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_trauma_pattern_summary.csv")

df = CSV.read(input_path, DataFrame)

df.dissociation_model =
    0.72 .* df.affect_intensity .+
    0.45 .* df.developmental_trauma_load .+
    0.34 .* df.nightmare_intrusion .-
    0.55 .* df.ego_integration .-
    0.48 .* df.symbolic_capacity .-
    0.42 .* df.relational_safety .-
    0.30 .* df.bodily_regulation

df.symbolic_recovery_model =
    0.50 .* df.symbolic_capacity .+
    0.42 .* df.memory_continuity .+
    0.36 .* df.relational_safety .+
    0.32 .* df.bodily_regulation .+
    0.28 .* df.witnessing_capacity .-
    0.34 .* df.nightmare_intrusion .-
    0.30 .* df.dissociation

df.integration_potential =
    0.60 .* df.ego_integration .+
    0.55 .* df.symbolic_capacity .+
    0.62 .* df.relational_safety .+
    0.48 .* df.bodily_regulation .+
    0.44 .* df.memory_continuity .+
    0.40 .* df.symbolic_recovery .+
    0.32 .* df.witnessing_capacity .-
    0.68 .* df.dissociation .-
    0.34 .* df.nightmare_intrusion

summary = combine(
    groupby(df, :trauma_pattern),
    :integration_potential => mean => :mean_integration_potential,
    :dissociation_model => mean => :mean_dissociation_model,
    :symbolic_recovery_model => mean => :mean_symbolic_recovery_model,
    :symbolic_capacity => mean => :mean_symbolic_capacity,
    :bodily_regulation => mean => :mean_bodily_regulation,
    :memory_continuity => mean => :mean_memory_continuity
)

CSV.write(output_path, summary)
println(summary)
