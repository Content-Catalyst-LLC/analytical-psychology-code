# Data Dictionary

The files in `data/raw/` are synthetic and illustrative. They do not represent real people, therapy records, clinical notes, mental-health records, employment records, relationship records, or empirical findings.

## `synthetic_complex_activation_panel.csv`

| Field | Description |
|---|---|
| `case_id` | Synthetic case-period identifier |
| `person_id` | Synthetic person identifier |
| `time` | Ordered synthetic time period |
| `complex_type` | Synthetic complex pattern |
| `trigger_intensity` | Stylized intensity of a present cue |
| `relational_threat` | Stylized relational distance, ambiguity, or danger |
| `evaluation_pressure` | Stylized pressure from judgment, assessment, or authority |
| `shame_cue` | Stylized exposure, comparison, or humiliation cue |
| `affect_intensity` | Synthetic affective charge |
| `complex_activation` | Synthetic activation of the complex |
| `regulation_capacity` | Synthetic capacity for reflective pause and self-regulation |
| `relational_buffer` | Synthetic support, safety, or corrective relational buffering |
| `repetition_probability` | Synthetic probability that the pattern will recur |
| `projection_pressure` | Synthetic pressure to locate unresolved content in another person |
| `transference_pressure` | Synthetic pressure to repeat older relational form in a new bond |
| `symbolic_repetition` | Synthetic dream/fantasy image associated with the repeated pattern |

## `complex_network_nodes.csv`

| Field | Description |
|---|---|
| `node` | Node in the affective complex network |
| `cluster` | Broad cluster such as trigger, affect, cognition, memory, expectation, response, regulation, or symbolic output |
| `affect_weight` | Synthetic affective charge or activation sensitivity |
| `notes` | Interpretive note |

## `complex_network_edges.csv`

| Field | Description |
|---|---|
| `source` | Source node |
| `target` | Target node |
| `weight` | Synthetic edge weight; negative values represent regulatory inhibition |
| `notes` | Interpretive note |

## Responsible-use note

These variables are conceptual demonstrations. They are not validated psychological, clinical, therapeutic, diagnostic, predictive, employment, personality, mental-health, or assessment measures.
