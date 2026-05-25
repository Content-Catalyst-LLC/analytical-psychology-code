-- ============================================================
-- Individuation and the Development of the Depth Self
-- SQL schema for synthetic individuation process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS individuation_depth_self_cases (
    case_id INTEGER PRIMARY KEY,
    individuation_pathway TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    ego_coherence REAL NOT NULL,
    persona_identification REAL NOT NULL,
    shadow_acknowledgment REAL NOT NULL,
    symbolic_relation REAL NOT NULL,
    complex_activation REAL NOT NULL,
    reflective_capacity REAL NOT NULL,
    body_awareness REAL NOT NULL,
    ethical_accountability REAL NOT NULL,
    relational_life REAL NOT NULL,
    dream_function REAL NOT NULL,
    onesidedness REAL NOT NULL,
    compensation_pressure REAL NOT NULL,
    depth_self_integration REAL NOT NULL,
    individuation_score REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, psychological assessment, life prediction, clinical decision-making, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS individuation_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS individuation_depth_self_scores AS
SELECT
    case_id,
    individuation_pathway,
    time_period,
    (
        (ego_coherence - shadow_acknowledgment) * (ego_coherence - shadow_acknowledgment) +
        (symbolic_relation - complex_activation) * (symbolic_relation - complex_activation) +
        (persona_identification - reflective_capacity) * (persona_identification - reflective_capacity)
    ) AS onesidedness_model,
    (
        0.44 * (
            (ego_coherence - shadow_acknowledgment) * (ego_coherence - shadow_acknowledgment) +
            (symbolic_relation - complex_activation) * (symbolic_relation - complex_activation) +
            (persona_identification - reflective_capacity) * (persona_identification - reflective_capacity)
        ) +
        0.36 * ABS(complex_activation) -
        0.28 * reflective_capacity
    ) AS compensation_pressure_model,
    (
        0.54 * ego_coherence +
        0.62 * shadow_acknowledgment +
        0.66 * symbolic_relation +
        0.52 * reflective_capacity +
        0.34 * body_awareness +
        0.36 * ethical_accountability +
        0.30 * relational_life -
        0.42 * ABS(complex_activation) -
        0.28 * (
            (ego_coherence - shadow_acknowledgment) * (ego_coherence - shadow_acknowledgment) +
            (symbolic_relation - complex_activation) * (symbolic_relation - complex_activation) +
            (persona_identification - reflective_capacity) * (persona_identification - reflective_capacity)
        )
    ) AS depth_self_integration_model,
    (
        ego_coherence + persona_identification
    ) / 2.0 AS adaptive_surface_index,
    (
        shadow_acknowledgment + symbolic_relation + reflective_capacity + body_awareness + ethical_accountability + relational_life + dream_function + depth_self_integration
    ) / 8.0 AS depth_integration_index
FROM individuation_depth_self_cases;
