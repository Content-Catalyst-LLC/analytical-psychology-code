-- ============================================================
-- Analytical Psychology and Personality Theory
-- SQL schema for synthetic Jungian personality process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS jungian_personality_cases (
    case_id INTEGER PRIMARY KEY,
    dominant_function TEXT NOT NULL,
    dominant_attitude TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    conscious_orientation REAL NOT NULL,
    persona_identification REAL NOT NULL,
    shadow_acknowledgment REAL NOT NULL,
    symbolic_relation REAL NOT NULL,
    typological_flexibility REAL NOT NULL,
    complex_activation REAL NOT NULL,
    unconscious_compensation REAL NOT NULL,
    reflective_capacity REAL NOT NULL,
    developmental_integration REAL NOT NULL,
    onesidedness REAL NOT NULL,
    personality_state REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, personality assessment, hiring, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS personality_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS jungian_personality_scores AS
SELECT
    case_id,
    dominant_function,
    dominant_attitude,
    time_period,
    (
        (conscious_orientation - shadow_acknowledgment) * (conscious_orientation - shadow_acknowledgment) +
        (persona_identification - typological_flexibility) * (persona_identification - typological_flexibility) +
        (complex_activation - symbolic_relation) * (complex_activation - symbolic_relation)
    ) AS onesidedness_model,
    (
        0.48 * (
            (conscious_orientation - shadow_acknowledgment) * (conscious_orientation - shadow_acknowledgment) +
            (persona_identification - typological_flexibility) * (persona_identification - typological_flexibility) +
            (complex_activation - symbolic_relation) * (complex_activation - symbolic_relation)
        ) +
        0.40 * ABS(complex_activation) -
        0.28 * reflective_capacity
    ) AS unconscious_compensation_model,
    (
        0.54 * typological_flexibility +
        0.56 * shadow_acknowledgment +
        0.62 * symbolic_relation +
        0.48 * reflective_capacity -
        0.38 * ABS(complex_activation) -
        0.22 * (
            (conscious_orientation - shadow_acknowledgment) * (conscious_orientation - shadow_acknowledgment) +
            (persona_identification - typological_flexibility) * (persona_identification - typological_flexibility) +
            (complex_activation - symbolic_relation) * (complex_activation - symbolic_relation)
        )
    ) AS developmental_integration_model,
    (
        conscious_orientation + persona_identification
    ) / 2.0 AS conscious_adaptation_index,
    (
        shadow_acknowledgment + symbolic_relation + typological_flexibility + reflective_capacity + developmental_integration
    ) / 5.0 AS symbolic_integration_index
FROM jungian_personality_cases;
