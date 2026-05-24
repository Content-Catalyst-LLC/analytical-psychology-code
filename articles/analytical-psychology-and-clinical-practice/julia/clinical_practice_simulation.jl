# Analytical Psychology and Clinical Practice
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/analytical-psychology-and-clinical-practice"
input_path = joinpath(article_dir, "data/raw/synthetic_clinical_practice.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_clinical_practice_summary.csv")

df = CSV.read(input_path, DataFrame)

df.compensatory_pressure =
    0.62 .* df.conscious_onesidedness .+
    0.58 .* df.complex_activation .+
    0.34 .* df.trauma_fragmentation .-
    0.52 .* df.ego_integration .-
    0.26 .* df.shadow_awareness

df.symbolic_growth =
    0.44 .* df.relational_safety .+
    0.38 .* df.affect_regulation .+
    0.34 .* df.ego_integration .+
    0.28 .* df.dream_richness .-
    0.32 .* df.trauma_fragmentation .-
    0.24 .* df.shame_load

df.clinical_functioning =
    -0.70 .* df.symptom_burden .+
    0.60 .* df.ego_integration .+
    0.52 .* df.symbolic_capacity .+
    0.64 .* df.relational_safety .-
    0.42 .* df.compensatory_pressure .+
    0.28 .* df.affect_regulation .+
    0.24 .* df.shadow_awareness

summary = combine(
    groupby(df, :clinical_presentation),
    :clinical_functioning => mean => :mean_clinical_functioning,
    :symbolic_growth => mean => :mean_symbolic_growth,
    :compensatory_pressure => mean => :mean_compensatory_pressure,
    :symptom_burden => mean => :mean_symptom_burden,
    :symbolic_capacity => mean => :mean_symbolic_capacity,
    :relational_safety => mean => :mean_relational_safety
)

CSV.write(output_path, summary)
println(summary)
