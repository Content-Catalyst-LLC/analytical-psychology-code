# Data Dictionary

The files in `data/raw/` are synthetic and illustrative. They do not represent real dreams, therapy records, clinical material, mental-health assessments, private journals, psychological assessments, employment records, or empirical findings.

## `synthetic_dream_series.csv`

| Field | Description |
|---|---|
| `dream_id` | Synthetic dream identifier |
| `person_id` | Synthetic person identifier |
| `time` | Ordered dream-series time step |
| `phase` | Early, middle, or late dream-series phase |
| `dream_series_type` | Synthetic series pattern, such as persona correction or developmental transition |
| `text` | Synthetic dream text for motif extraction |

## `dream_motif_dictionary.csv`

| Field | Description |
|---|---|
| `motif` | Curated symbolic motif category |
| `term` | Search term associated with the motif |
| `motif_family` | Broad family: prospective or compensatory |
| `notes` | Interpretive note and caution |

## `synthetic_dream_dynamics_panel.csv`

| Field | Description |
|---|---|
| `conscious_onesidedness` | Stylized measure of conscious rigidity or imbalance |
| `unconscious_pressure` | Stylized measure of compensatory unconscious activation |
| `affective_intensity` | Stylized affective intensity |
| `latent_growth` | Stylized latent developmental tendency |
| `reflective_capacity` | Stylized capacity for reflection and containment |
| `symbolic_literacy` | Stylized capacity to relate to symbolic material |
| `previous_dream_output` | Prior synthetic dream-output signal |
| `compensatory_intensity` | Synthetic compensation signal |
| `prospective_intensity` | Synthetic prospective signal |
| `dream_output` | Synthetic dream-output score |
| `integration_signal` | Synthetic symbolic-integration signal |

## Responsible-use note

These variables are conceptual demonstrations. They are not validated psychological, clinical, therapeutic, diagnostic, predictive, dream-interpretive, or assessment measures.
