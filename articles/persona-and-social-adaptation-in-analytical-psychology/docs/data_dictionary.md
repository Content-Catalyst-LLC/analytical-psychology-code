# Data Dictionary

The files in `data/raw/` are synthetic and illustrative. They do not represent real people, therapy records, clinical material, employment records, social-media records, reputation records, personality assessments, workplace assessments, or empirical findings.

## `synthetic_persona_role_panel.csv`

| Field | Description |
|---|---|
| `case_id` | Synthetic case-period identifier |
| `person_id` | Synthetic person identifier |
| `time` | Ordered synthetic developmental time step |
| `persona_pattern` | Synthetic persona formation, such as flexible adaptation, professional overidentification, moral persona, helper persona, public brand persona, or institutional authority persona |
| `role_demand` | Stylized external pressure to perform a role |
| `audience_reward` | Stylized approval, recognition, visibility, status, or platform reward |
| `institutional_reward` | Stylized promotion, legitimacy, belonging, or institutional recognition |
| `inward_complexity` | Stylized inner life not fully represented by the persona |
| `reflective_flexibility` | Stylized ability to reflect on role identity without becoming identical to it |
| `shadow_pressure` | Stylized pressure from qualities excluded by persona |
| `status_dependence` | Stylized dependence on recognition, rank, reputation, or public approval |
| `persona_strength` | Synthetic strength of persona presentation |
| `persona_rigidity` | Synthetic rigidity or overidentification with persona |
| `persona_inward_gap` | Synthetic gap between outward role and inward complexity |
| `psychic_strain` | Synthetic strain score |
| `burnout_risk` | Synthetic burnout-risk score |
| `individuation_readiness` | Synthetic readiness for a less persona-bound relation to selfhood |

## `persona_network_nodes.csv`

| Field | Description |
|---|---|
| `node` | Psychic-domain node in a conceptual network |
| `cluster` | Broad cluster such as persona, shadow, reflection, context, response, or integration |
| `activation` | Synthetic activation value |
| `notes` | Interpretive note |

## `persona_network_edges.csv`

| Field | Description |
|---|---|
| `source` | Source node |
| `target` | Target node |
| `weight` | Synthetic relationship weight |
| `notes` | Interpretive note |

## Responsible-use note

These variables are conceptual demonstrations. They are not validated psychological, clinical, therapeutic, diagnostic, employment, reputation, social-scoring, personality, or assessment measures.
