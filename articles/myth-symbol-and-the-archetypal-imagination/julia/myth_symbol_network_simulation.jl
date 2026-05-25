# Myth, Symbol, and the Archetypal Imagination
# Julia conceptual simulation: motif recurrence and context dependence

using CSV
using DataFrames
using Statistics

article_dir = "articles/myth-symbol-and-the-archetypal-imagination"
motif_counts_path = joinpath(article_dir, "outputs/tables/motif_document_counts.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_motif_context_summary.csv")

if !isfile(motif_counts_path)
    println("Run the R or Python workflow first to generate motif_document_counts.csv")
else
    df = CSV.read(motif_counts_path, DataFrame)

    summary = combine(
        groupby(df, [:source_type, :culture_group, :motif, :cluster]),
        :count => sum => :total_count,
        :count => mean => :mean_count
    )

    motif_totals = combine(
        groupby(summary, [:motif, :cluster]),
        :total_count => sum => :motif_total,
        :total_count => var => :between_context_variance
    )

    joined = leftjoin(summary, motif_totals, on = [:motif, :cluster])
    joined.context_share = joined.total_count ./ joined.motif_total

    CSV.write(output_path, joined)
    println(joined)
end
