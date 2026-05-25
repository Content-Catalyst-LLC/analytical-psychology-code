# The Collective Unconscious: Meaning, Scope, and Controversy
# Julia conceptual simulation: symbolic recurrence across corpora

using CSV
using DataFrames
using Statistics

article_dir = "articles/the-collective-unconscious-meaning-scope-and-controversy"
corpus_path = joinpath(article_dir, "data/raw/symbolic_corpora.csv")
motif_path = joinpath(article_dir, "data/raw/motif_dictionary.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_symbolic_recurrence_summary.csv")

texts = CSV.read(corpus_path, DataFrame)
motifs = CSV.read(motif_path, DataFrame)

function count_motif(text, motif)
    tokens = split(lowercase(replace(text, r"[^A-Za-z ]" => "")))
    return count(==(lowercase(motif)), tokens)
end

rows = DataFrame(
    doc_id = String[],
    source_type = String[],
    culture_group = String[],
    motif = String[],
    cluster = String[],
    count = Int[]
)

for row in eachrow(texts)
    for motif_row in eachrow(motifs)
        n = count_motif(row.text, motif_row.motif)
        if n > 0
            push!(rows, (
                row.doc_id,
                row.source_type,
                row.culture_group,
                motif_row.motif,
                motif_row.cluster,
                n
            ))
        end
    end
end

summary = combine(
    groupby(rows, [:source_type, :culture_group, :cluster]),
    :count => sum => :total_count
)

motif_summary = combine(
    groupby(rows, [:motif, :cluster]),
    :count => sum => :total_count,
    :doc_id => length => :document_mentions
)

CSV.write(output_path, summary)
CSV.write(joinpath(article_dir, "outputs/tables/julia_motif_summary.csv"), motif_summary)

println(summary)
println(motif_summary)
