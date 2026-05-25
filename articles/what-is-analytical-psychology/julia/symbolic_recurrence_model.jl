# What Is Analytical Psychology?
# Julia conceptual simulation: symbolic recurrence and compensation pressure

using CSV
using DataFrames
using Statistics

article_dir = "articles/what-is-analytical-psychology"
corpus_path = joinpath(article_dir, "data/raw/symbolic_corpus.csv")
dictionary_path = joinpath(article_dir, "data/raw/symbol_dictionary.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_symbolic_recurrence_summary.csv")

corpus = CSV.read(corpus_path, DataFrame)
dictionary = CSV.read(dictionary_path, DataFrame)

rows = DataFrame(
    document_id = String[],
    source_type = String[],
    phase = String[],
    symbol = String[],
    cluster = String[]
)

for doc in eachrow(corpus)
    lower_text = lowercase(doc.text)
    for sym in eachrow(dictionary)
        pattern = lowercase(sym.symbol)
        if occursin(pattern, lower_text)
            push!(rows, (doc.document_id, doc.source_type, doc.phase, sym.symbol, sym.cluster))
        end
    end
end

summary = combine(
    groupby(rows, [:phase, :cluster]),
    :symbol => length => :symbol_mentions,
    :symbol => x -> length(unique(x)) => :unique_symbols
)

CSV.write(output_path, summary)
println(summary)
