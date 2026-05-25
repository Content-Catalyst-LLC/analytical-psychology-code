# Data Dictionary

The files in `data/raw/` are synthetic and illustrative. They do not represent a definitive map of Jung’s works, complete historical evidence, clinical data, or empirical proof of intellectual influence.

## `jung_concepts.csv`

| Field | Description |
|---|---|
| `concept` | Jungian or post-Jungian concept node |
| `period` | Synthetic prominence period: early, middle, late, or critical/post-Jungian |
| `domain` | Broad conceptual domain |
| `description` | Short conceptual description |
| `interpretive_caution` | Guardrail against overstatement or misuse |

## `jung_concept_edges.csv`

| Field | Description |
|---|---|
| `source` | Source concept |
| `target` | Target concept |
| `weight` | Synthetic conceptual relation strength |
| `phase` | Synthetic historical phase in which the relation is especially relevant |
| `notes` | Interpretive note |

## `jung_period_weights.csv`

| Field | Description |
|---|---|
| `phase` | Synthetic historical phase |
| domain columns | Relative synthetic weights for concept-domain activation in each phase |

## `jung_publication_periods.csv`

| Field | Description |
|---|---|
| `period` | Synthetic period label |
| `approx_year_range` | Approximate year range |
| `orientation` | Broad intellectual orientation |
| `representative_materials` | General examples of relevant work or development |
| `notes` | Modeling caveat |

## Responsible-use note

These variables are conceptual demonstrations. They are not validated historical measures, not evidence of direct causation, and not a substitute for close reading, archival research, clinical scholarship, cultural history, or intellectual-history methods.
