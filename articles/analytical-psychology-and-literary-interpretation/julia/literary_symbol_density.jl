# Analytical Psychology and Literary Interpretation
# Julia conceptual corpus workflow

using CSV
using DataFrames
using Statistics

article_dir = "articles/analytical-psychology-and-literary-interpretation"
corpus_path = joinpath(article_dir, "data/raw/literary_symbol_corpus.csv")
dictionary_path = joinpath(article_dir, "data/raw/motif_dictionary.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_symbolic_density_summary.csv")

texts = CSV.read(corpus_path, DataFrame)
motifs = CSV.read(dictionary_path, DataFrame)
motif_terms = Set(lowercase.(String.(motifs.motif)))

rows = DataFrame(
    doc_id = String[],
    genre = String[],
    period = String[],
    author = String[],
    title = String[],
    motif = String[],
    count = Int[],
    total_tokens = Int[]
)

for row in eachrow(texts)
    cleaned = lowercase(replace(String(row.text), r"[^A-Za-z\s]" => " "))
    tokens = split(cleaned)
    total_tokens = length(tokens)

    counts = Dict{String, Int}()

    for token in tokens
        if token in motif_terms
            counts[token] = get(counts, token, 0) + 1
        end
    end

    for (motif, count) in counts
        push!(
            rows,
            (
                String(row.doc_id),
                String(row.genre),
                String(row.period),
                String(row.author),
                String(row.title),
                motif,
                count,
                total_tokens
            )
        )
    end
end

summary = combine(
    groupby(rows, [:doc_id, :genre, :period, :author, :title]),
    :count => sum => :total_motifs,
    :total_tokens => first => :total_tokens
)

summary.symbolic_density = summary.total_motifs ./ summary.total_tokens

CSV.write(output_path, summary)
println(summary)
