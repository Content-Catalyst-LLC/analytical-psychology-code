# Jung, Freud, and the Divergence of Depth Psychologies

This companion scaffold supports the article **“Jung, Freud, and the Divergence of Depth Psychologies”** in the Analytical Psychology, Symbolism & the Depth Mind knowledge series.

The repository materials translate the article’s comparative argument into reproducible, synthetic-data workflows. The goal is not to diagnose people, validate Freudian or Jungian theory, score patients, or reduce clinical interpretation to a formula. The goal is to demonstrate how repression, sexuality conflict, infantile history, defense intensity, transference pressure, mythic amplification, compensation, archetypal density, prospective development, symbolic coherence, and individuation pressure can be represented transparently in conceptual comparison models.

## Repository purpose

This article argues that Freud and Jung founded divergent depth psychologies with different explanatory centers. Freud places greater emphasis on repression, sexuality, defense, symptom, transference, infantile history, and demystifying interpretation. Jung places greater emphasis on symbol, compensation, myth, archetype, the collective unconscious, individuation, and prospective development.

The code examples extend that argument through:

- synthetic Freudian/Jungian explanatory-score simulation;
- concept-network modeling for both frameworks;
- bridge-network comparison between the two lineages;
- reproducible tables and figures;
- multi-language computational scaffolding;
- documented responsible-use limits.

## Folder structure

```text
articles/jung-freud-and-the-divergence-of-depth-psychologies/
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

These materials are for synthetic-data research, methods demonstration, conceptual modeling, institutional learning, and reproducible workflows. They are not intended for diagnosis, therapy, psychological assessment, clinical decision-making, employment screening, workplace surveillance, individual performance management, or individual evaluation.

## Suggested workflow

1. Review `article-metadata.yml` for article context.
2. Run the R simulation in `r/simulate_depth_psychology_divergence.R`.
3. Run the Python concept-network workflow in `python/depth_psychology_networks.py`.
4. Use `sql/schema.sql` to inspect the synthetic comparison structure.
5. Treat all outputs as illustrative and synthetic, not empirical findings.

## Article link block

The WordPress embed block is available in:

- `github-embed-wordpress.html`
- `docs/github-embed-wordpress.html`
