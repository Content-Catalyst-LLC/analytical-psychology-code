-- ============================================================
-- Relational and Developmental Jungian Psychotherapy
-- SQL schema for synthetic relational therapy process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS relational_jungian_therapy_sessions (
    case_id INTEGER PRIMARY KEY,
    clinical_presentation TEXT NOT NULL,
    session_number INTEGER NOT NULL,
    relational_safety REAL NOT NULL,
    attachment_security REAL NOT NULL,
    affect_regulation REAL NOT NULL,
    rupture_intensity REAL NOT NULL,
    repair_capacity REAL NOT NULL,
    shame_load REAL NOT NULL,
    fragmentation REAL NOT NULL,
    embodied_safety REAL NOT NULL,
    symbolic_capacity REAL NOT NULL,
    dream_richness REAL NOT NULL,
    reflective_self REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, clinical decision-making, therapist evaluation, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS relational_jungian_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS relational_jungian_therapy_scores AS
SELECT
    case_id,
    clinical_presentation,
    session_number,
    (
        0.62 * relational_safety +
        0.42 * attachment_security +
        0.55 * affect_regulation +
        0.46 * repair_capacity +
        0.36 * embodied_safety +
        0.58 * symbolic_capacity +
        0.44 * reflective_self -
        0.58 * fragmentation -
        0.38 * shame_load -
        0.28 * rupture_intensity
    ) AS developmental_integration,
    (
        0.55 * relational_safety +
        0.50 * affect_regulation +
        0.34 * repair_capacity +
        0.30 * embodied_safety -
        0.42 * shame_load -
        0.36 * fragmentation
    ) AS symbolic_growth,
    (
        0.48 * rupture_intensity +
        0.34 * shame_load +
        0.32 * fragmentation -
        0.36 * repair_capacity -
        0.30 * relational_safety -
        0.26 * reflective_self
    ) AS rupture_risk,
    (
        relational_safety + attachment_security + affect_regulation + repair_capacity + embodied_safety
    ) / 5.0 AS relational_capacity_index,
    (
        symbolic_capacity + dream_richness + reflective_self
    ) / 3.0 AS symbolic_capacity_index,
    (
        rupture_intensity + shame_load + fragmentation
    ) / 3.0 AS risk_index
FROM relational_jungian_therapy_sessions;
