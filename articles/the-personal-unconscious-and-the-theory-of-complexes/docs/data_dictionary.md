# Data Dictionary

The files in `data/raw/` are synthetic and illustrative. They do not represent real people, therapy records, clinical notes, mental-health records, employment records, relationship records, private dreams, or empirical findings.

## `personal_unconscious_complex_activation_panel.csv`

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
| `guilt_cue` | Stylized guilt, responsibility, accusation, or moral burden cue |
| `unresolved_affect` | Synthetic unresolved affective charge from personal history |
| `affect_intensity` | Synthetic current affective charge |
| `complex_activation` | Synthetic activation of the complex |
| `regulation_capacity` | Synthetic reflective regulation capacity |
| `contextual_support` | Synthetic support, safety, or contextual buffering |
| `repetition_probability` | Synthetic probability that the pattern will recur |
| `projection_pressure` | Synthetic pressure to locate unresolved material in another person |
| `transference_pressure` | Synthetic pressure to repeat older relational form in a new bond |
| `symbolic_repetition` | Synthetic dream/fantasy image associated with the repeated pattern |

## `associative_complex_nodes.csv`

| Field | Description |
|---|---|
| `node` | Node in the associative complex network |
| `cluster` | Broad cluster such as trigger, affect, cognition, memory, expectation, body, response, regulation, or symbolic output |
| `affect_weight` | Synthetic affective charge or activation sensitivity |
| `notes` | Interpretive note |

## `associative_complex_edges.csv`

| Field | Description |
|---|---|
| `source` | Source node |
| `target` | Target node |
| `weight` | Synthetic edge weight; negative values represent regulatory inhibition |
| `notes` | Interpretive note |

## Responsible-use note

These variables are conceptual demonstrations. They are not validated psychological, clinical, therapeutic, diagnostic, predictive, employment, personality, mental-health, or assessment measures.
