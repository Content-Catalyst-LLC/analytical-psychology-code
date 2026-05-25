# The Collective Unconscious: Meaning, Scope, and Controversy

This companion scaffold supports the article **“The Collective Unconscious: Meaning, Scope, and Controversy”** in the Analytical Psychology, Symbolism & the Depth Mind knowledge series.

The repository materials translate the article’s argument into reproducible, synthetic-data workflows. The goal is not to prove Jung’s theory, diagnose people, interpret private dreams, reduce religion to psychology, extract symbols from living traditions, or treat symbolic recurrence as automatic proof of universal psychic inheritance. The goal is to demonstrate how symbolic recurrence, motif co-occurrence, symbolic clusters, latent structural hypotheses, alternative explanations, and responsible interpretive guardrails can be represented transparently in conceptual modeling.

## Repository purpose

This article argues that the collective unconscious is one of Jung’s most ambitious and controversial proposals: a hypothesis that symbolic life may be shaped by recurrent structural tendencies deeper than individual biography alone.

The code examples extend that argument through:

- synthetic symbolic-corpus data;
- motif-frequency analysis;
- symbolic recurrence modeling;
- semantic co-occurrence networks;
- cross-source motif comparison;
- recurrence-strength scoring;
- rival-explanation documentation;
- SQL schemas for structured motif analysis;
- multi-language computational scaffolding;
- documented responsible-use limits.

## Folder structure

```text
articles/the-collective-unconscious-meaning-scope-and-controversy/
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

These materials are for synthetic-data research, methods demonstration, conceptual modeling, symbolic-process analysis, corpus exploration, institutional learning, and reproducible workflows. They are not intended for diagnosis, therapy, psychological assessment, private dream interpretation, religious reductionism, cultural extraction, employment screening, workplace surveillance, individual performance management, or individual evaluation.

## Suggested workflow

1. Review `article-metadata.yml` for article context.
2. Inspect `data/raw/symbolic_corpora.csv`.
3. Inspect `data/raw/motif_dictionary.csv`.
4. Run the R workflow in `r/model_symbolic_recurrence_across_corpora.R`.
5. Run the Python workflow in `python/map_archetypal_patterning_network.py`.
6. Use `sql/schema.sql` to inspect the symbolic-recurrence schema.
7. Treat all outputs as illustrative and synthetic, not proof of the collective unconscious.

## Article link block

The WordPress embed block is available in:

- `github-embed-wordpress.html`
- `docs/github-embed-wordpress.html`
