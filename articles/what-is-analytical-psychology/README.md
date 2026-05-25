# What Is Analytical Psychology?

This companion scaffold supports the article **“What Is Analytical Psychology?”** in the Analytical Psychology, Symbolism & the Depth Mind knowledge series.

The repository materials translate the article’s argument into reproducible, synthetic-data workflows. The goal is not to diagnose people, interpret private dreams, automate symbolic interpretation, reduce religion to psychology, or turn Jungian concepts into deterministic scoring tools. The goal is to demonstrate how symbolic patterning, dream and narrative motifs, complexes, compensation, persona, shadow, archetype, individuation, and depth-psychology concepts can be explored transparently through reproducible conceptual modeling.

## Repository purpose

This article introduces analytical psychology as a depth-oriented framework for studying psyche, symbol, dream, myth, complex, persona, shadow, archetype, Self, and individuation. The companion code extends that argument through:

- synthetic symbolic-corpus data;
- symbolic motif dictionaries;
- R workflows for symbolic co-occurrence and network analysis;
- Python workflows for semantic clustering and symbolic networks;
- SQL schemas for structured symbolic-corpus research;
- multi-language computational examples for symbolic recurrence and compensation scoring;
- responsible-use documentation.

## Folder structure

```text
articles/what-is-analytical-psychology/
├── c/
├── cpp/
├── data/
│   ├── raw/
│   └── processed/
├── docs/
├── fortran/
├── go/
├── julia/
├── notebooks/
├── outputs/
│   ├── figures/
│   └── tables/
├── python/
├── r/
├── rust/
├── sql/
├── README.md
├── article-metadata.yml
└── github-embed-wordpress.html
```

## Responsible-use statement

These materials are for synthetic-data research, methods demonstration, symbolic-process analysis, institutional learning, and reproducible workflows. They are not intended for diagnosis, therapy, psychological assessment, clinical decision-making, private dream interpretation, religious reductionism, employment screening, workplace surveillance, individual performance management, or individual evaluation.

## Suggested workflow

1. Review `article-metadata.yml` for article context.
2. Inspect `data/raw/symbolic_corpus.csv`.
3. Inspect `data/raw/symbol_dictionary.csv`.
4. Inspect `data/raw/analytical_psychology_concepts.csv`.
5. Run the R workflow in `r/symbolic_patterning_workflow.R`.
6. Run the Python workflow in `python/semantic_clustering_symbolic_network.py`.
7. Use `sql/schema.sql` to inspect the symbolic-corpus schema.
8. Treat all outputs as illustrative and synthetic, not clinical or interpretive findings.

## Article link block

The WordPress embed block is available in:

- `github-embed-wordpress.html`
- `docs/github-embed-wordpress.html`
