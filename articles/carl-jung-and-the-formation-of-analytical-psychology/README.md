# Carl Jung and the Formation of Analytical Psychology

This companion scaffold supports the article **“Carl Jung and the Formation of Analytical Psychology”** in the Analytical Psychology, Symbolism & the Depth Mind knowledge series.

The repository materials translate the article’s argument into reproducible, synthetic-data workflows. The goal is not to diagnose people, interpret private clinical material, assign psychological authority to historical figures, or convert intellectual history into a simplistic network score. The goal is to demonstrate how analytical psychology can be studied as a historically developing conceptual system shaped by clinical work, psychiatric research, Freudian conflict, comparative symbolic inquiry, inner exploration, institutional formation, and post-Jungian revision.

## Repository purpose

This article argues that analytical psychology did not emerge as a finished doctrine. It formed through psychiatry, word-association research, the theory of complexes, engagement with Freud, the break from psychoanalysis, Jung’s confrontation with the unconscious, symbolic psychology, comparative studies of myth and religion, and later post-Jungian development.

The code examples extend that argument through:

- synthetic concept-history data;
- conceptual-network analysis;
- temporal concept-diffusion modeling;
- early/middle/late phase activation analysis;
- SQL schemas for structured intellectual-history modeling;
- multi-language computational scaffolding;
- responsible-use documentation.

## Folder structure

```text
articles/carl-jung-and-the-formation-of-analytical-psychology/
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

These materials are for synthetic-data research, methods demonstration, intellectual-history modeling, conceptual-network analysis, institutional learning, and reproducible workflows. They are not intended for diagnosis, therapy, psychological assessment, clinical decision-making, mental-health evaluation, employment screening, workplace surveillance, individual performance management, or individual evaluation.

## Suggested workflow

1. Review `article-metadata.yml` for article context.
2. Inspect `data/raw/jung_concepts.csv`.
3. Inspect `data/raw/jung_concept_edges.csv`.
4. Inspect `data/raw/jung_period_weights.csv`.
5. Run the R workflow in `r/map_jung_conceptual_development.R`.
6. Run the Python workflow in `python/model_jung_concept_diffusion.py`.
7. Use `sql/schema.sql` to inspect the concept-history schema.
8. Treat all outputs as illustrative and synthetic, not definitive historical findings.

## Article link block

The WordPress embed block is available in:

- `github-embed-wordpress.html`
- `docs/github-embed-wordpress.html`
