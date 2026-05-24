-- ============================================================
-- Analytical Psychology and Clinical Practice
-- SQL schema for synthetic clinical practice process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS clinical_practice_sessions (
    case_id INTEGER PRIMARY KEY,
    clinical_presentation TEXT NOT NULL,
    session_number INTEGER NOT NULL,
    symptom_burden REAL NOT NULL,
    ego_integration REAL NOT NULL,
    symbolic_capacity REAL NOT NULL,
    relational_safety REAL NOT NULL,
    affect_regulation REAL NOT NULL,
    complex_activation REAL NOT NULL,
    conscious_onesidedness REAL NOT NULL,
    trauma_fragmentation REAL NOT NULL,
    shame_load REAL NOT NULL,
    dream_richness REAL NOT NULL,
    shadow_awareness REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, clinical decision-making, therapist evaluation, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS clinical_practice_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS clinical_practice_scores AS
SELECT
    case_id,
    clinical_presentation,
    session_number,
    (
        0.62 * conscious_onesidedness +
        0.58 * complex_activation +
        0.34 * trauma_fragmentation -
        0.52 * ego_integration -
        0.26 * shadow_awareness
    ) AS compensatory_pressure,
    (
        0.44 * relational_safety +
        0.38 * affect_regulation +
        0.34 * ego_integration +
        0.28 * dream_richness -
        0.32 * trauma_fragmentation -
        0.24 * shame_load
    ) AS symbolic_growth,
    (
        -0.70 * symptom_burden +
        0.60 * ego_integration +
        0.52 * symbolic_capacity +
        0.64 * relational_safety -
        0.42 * (
            0.62 * conscious_onesidedness +
            0.58 * complex_activation +
            0.34 * trauma_fragmentation -
            0.52 * ego_integration -
            0.26 * shadow_awareness
        ) +
        0.28 * affect_regulation +
        0.24 * shadow_awareness
    ) AS clinical_functioning,
    (
        ego_integration + symbolic_capacity + relational_safety + affect_regulation + shadow_awareness
    ) / 5.0 AS capacity_index,
    (
        symptom_burden + complex_activation + conscious_onesidedness + trauma_fragmentation + shame_load
    ) / 5.0 AS risk_index,
    (
        symbolic_capacity + dream_richness + shadow_awareness
    ) / 3.0 AS symbolic_index
FROM clinical_practice_sessions;
