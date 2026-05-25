# Analytical Psychology and Personality Theory

This companion scaffold supports the article **“Analytical Psychology and Personality Theory”** in the Analytical Psychology, Symbolism & the Depth Mind knowledge series.

The repository materials translate the article’s argument into reproducible, synthetic-data workflows. The goal is not to diagnose people, classify personalities, screen employees, evaluate individuals, recommend therapy, or reduce Jungian personality theory to a psychometric instrument. The goal is to demonstrate how conscious orientation, persona identification, shadow acknowledgment, complex activation, unconscious compensation, typological flexibility, symbolic relation, reflective capacity, developmental integration, one-sidedness, and personality-state dynamics can be represented transparently in conceptual modeling.

## Repository purpose

This article argues that analytical psychology belongs to personality theory because it treats the person as a divided, developing, symbolic, and meaning-bearing whole. Personality is not only trait regularity, behavioral consistency, or self-report. It is the living organization of ego, persona, shadow, complexes, typological functions, symbolic life, cultural adaptation, developmental pressure, and the movement toward individuation.

The code examples extend that argument through:

- synthetic Jungian personality data;
- personality-state and one-sidedness simulation;
- typological-function and attitude workflows;
- persona, shadow, complex, and compensation-pressure modeling;
- dynamic Jungian personality network scripts;
- reproducible tables and figures;
- multi-language computational scaffolding;
- documented responsible-use limits.

## Folder structure

```text
articles/analytical-psychology-and-personality-theory/
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

These materials are for synthetic-data research, methods demonstration, conceptual modeling, symbolic-process analysis, institutional learning, and reproducible workflows. They are not intended for diagnosis, therapy, psychological assessment, personality assessment, clinical decision-making, hiring, employment screening, workplace surveillance, individual performance management, or individual evaluation.

## Suggested workflow

1. Review `article-metadata.yml` for article context.
2. Inspect the synthetic data in `data/raw/synthetic_jungian_personality.csv`.
3. Run the R workflow in `r/simulate_jungian_personality.R`.
4. Run the Python workflow in `python/jungian_personality_network.py`.
5. Use `sql/schema.sql` to inspect the Jungian personality schema.
6. Treat all outputs as illustrative and synthetic, not empirical findings, personality scores, hiring signals, assessment scores, or clinical claims.

## Article link block

The WordPress embed block is available in:

- `github-embed-wordpress.html`
- `docs/github-embed-wordpress.html`
