# Psychological Types: Introversion, Extraversion, and the Four Functions

This companion scaffold supports the article **“Psychological Types: Introversion, Extraversion, and the Four Functions”** in the Analytical Psychology, Symbolism & the Depth Mind knowledge series.

The repository materials translate the article’s argument into reproducible, synthetic-data workflows. The goal is not to diagnose people, assign type labels, support hiring decisions, screen employees, evaluate individuals, recommend therapy, or reduce Jungian typology to a psychometric instrument. The goal is to demonstrate how introversion, extraversion, thinking, feeling, sensation, intuition, dominant-function strength, inferior-function access, function variance, unconscious pressure, compensation strain, reflective capacity, symbolic relation, and developmental integration can be represented transparently in conceptual modeling.

## Repository purpose

This article argues that Jung’s theory of psychological types is not a system of fixed identity boxes. It is a theory of conscious orientation, psychic differentiation, one-sidedness, compensation, and development. Introversion and extraversion describe the direction of psychic orientation. Thinking, feeling, sensation, and intuition describe modes of judgment and perception. The theory becomes psychologically serious when the dominant function is understood together with the inferior function, shadow, symbolic life, and the developmental task of becoming less one-sided.

The code examples extend that argument through:

- synthetic typology and function-differentiation data;
- dominant-function and inferior-function simulation;
- introversion/extraversion and attitude modeling;
- function-variance and compensation-pressure workflows;
- dynamic functional type-network scripts;
- reproducible tables and figures;
- multi-language computational scaffolding;
- documented responsible-use limits.

## Folder structure

```text
articles/psychological-types-introversion-extraversion-and-the-four-functions/
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

These materials are for synthetic-data research, methods demonstration, conceptual modeling, symbolic-process analysis, institutional learning, and reproducible workflows. They are not intended for diagnosis, therapy, psychological assessment, personality assessment, typological labeling, clinical decision-making, hiring, employment screening, workplace surveillance, individual performance management, or individual evaluation.

## Suggested workflow

1. Review `article-metadata.yml` for article context.
2. Inspect the synthetic data in `data/raw/synthetic_psychological_types.csv`.
3. Run the R workflow in `r/simulate_psychological_types.R`.
4. Run the Python workflow in `python/psychological_types_network.py`.
5. Use `sql/schema.sql` to inspect the typology schema.
6. Treat all outputs as illustrative and synthetic, not empirical findings, personality-test scores, hiring signals, assessment scores, or clinical claims.

## Article link block

The WordPress embed block is available in:

- `github-embed-wordpress.html`
- `docs/github-embed-wordpress.html`
