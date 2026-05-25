# Carl Jung and the Formation of Analytical Psychology
# Julia conceptual simulation: phase-weighted concept activation

using CSV
using DataFrames
using Statistics

article_dir = "articles/carl-jung-and-the-formation-of-analytical-psychology"
concept_path = joinpath(article_dir, "data/raw/jung_concepts.csv")
weights_path = joinpath(article_dir, "data/raw/jung_period_weights.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_jung_phase_activation.csv")

concepts = CSV.read(concept_path, DataFrame)
weights = CSV.read(weights_path, DataFrame)

function domain_weight(row, domain)
    if domain == "clinical"
        return row.clinical
    elseif domain == "experimental"
        return row.experimental
    elseif domain == "symbolic"
        return row.symbolic
    elseif domain == "developmental"
        return row.developmental
    elseif domain == "comparative"
        return row.comparative
    elseif domain == "religion"
        return row.religion
    elseif domain == "method"
        return row.method
    elseif domain == "critical_revision"
        return row.critical_revision
    else
        return 0.30
    end
end

rows = DataFrame(
    phase = String[],
    concept = String[],
    domain = String[],
    activation = Float64[]
)

for w in eachrow(weights)
    for c in eachrow(concepts)
        base = domain_weight(w, c.domain)
        synthetic_prominence = base + 0.05 * length(c.concept)
        push!(rows, (w.phase, c.concept, c.domain, synthetic_prominence))
    end
end

summary = combine(
    groupby(rows, [:phase, :domain]),
    :activation => mean => :mean_activation,
    :activation => maximum => :max_activation,
    :concept => length => :concept_count
)

CSV.write(output_path, rows)
CSV.write(joinpath(article_dir, "outputs/tables/julia_jung_phase_summary.csv"), summary)

println(summary)
