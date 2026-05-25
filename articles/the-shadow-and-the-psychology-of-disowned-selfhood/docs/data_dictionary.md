# Data Dictionary

The files in `data/raw/` are synthetic and illustrative. They do not represent real people, therapy records, clinical material, dream records, moral evaluations, mental-health assessments, employment records, or empirical findings.

## `synthetic_shadow_projection_panel.csv`

| Field | Description |
|---|---|
| `case_id` | Synthetic case-period identifier |
| `person_id` | Synthetic person identifier |
| `time` | Ordered synthetic developmental time step |
| `shadow_configuration` | Synthetic configuration such as moral purity shadow, strength-need shadow, rational-affect shadow, care-resentment shadow, success-fragility shadow, or balanced reflection |
| `latent_disowned` | Stylized disowned psychic material |
| `ego_identity` | Stylized conscious self-image or ego-endorsed identity |
| `cue_intensity` | Stylized trigger intensity |
| `affective_charge` | Stylized emotional force |
| `persona_rigidity` | Stylized rigidity of public or moral identity |
| `reflective_capacity` | Stylized ability to reflect under pressure |
| `shadow_discrepancy` | Stylized discrepancy between latent disowned material and conscious identity |
| `shadow_activation` | Synthetic shadow activation score |
| `projection_intensity` | Synthetic projection intensity score |
| `shame_response` | Synthetic shame-collapse or self-condemnation score |
| `integration_capacity` | Synthetic capacity to recognize and integrate shadow material |
| `responsibility_index` | Synthetic responsibility and repair-oriented score |

## `shadow_network_nodes.csv`

| Field | Description |
|---|---|
| `node` | Psychic-domain node in a conceptual network |
| `cluster` | Broad cluster such as persona, shadow, reflection, response, or integration |
| `activation` | Synthetic activation value |
| `notes` | Interpretive note |

## `shadow_network_edges.csv`

| Field | Description |
|---|---|
| `source` | Source node |
| `target` | Target node |
| `weight` | Synthetic relationship weight |
| `notes` | Interpretive note |

## Responsible-use note

These variables are conceptual demonstrations. They are not validated psychological, clinical, therapeutic, diagnostic, predictive, moral-ranking, dream-interpretive, or assessment measures.
