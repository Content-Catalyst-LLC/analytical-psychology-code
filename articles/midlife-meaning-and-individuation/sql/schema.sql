-- ============================================================
-- Midlife, Meaning, and Individuation
-- SQL schema for synthetic midlife-transition process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS midlife_transition_cases (
    case_id INTEGER PRIMARY KEY,
    midlife_pattern TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    adaptation_strength REAL NOT NULL,
    persona_identification REAL NOT NULL,
    symbolic_activation REAL NOT NULL,
    unlived_life_pressure REAL NOT NULL,
    finitude_awareness REAL NOT NULL,
    outward_inward_discrepancy REAL NOT NULL,
    individuation_pressure REAL NOT NULL,
    shadow_integration REAL NOT NULL,
    reflective_capacity REAL NOT NULL,
    meaning_coherence REAL NOT NULL,
    second_half_orientation REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, life prediction, clinical decision-making, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS midlife_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS midlife_transition_scores AS
SELECT
    case_id,
    midlife_pattern,
    time_period,
    (
        0.72 * outward_inward_discrepancy +
        0.58 * unlived_life_pressure +
        0.52 * finitude_awareness +
        0.46 * individuation_pressure -
        0.30 * reflective_capacity
    ) AS transition_intensity,
    (
        0.40 * adaptation_strength +
        0.58 * symbolic_activation +
        0.62 * individuation_pressure +
        0.42 * shadow_integration +
        0.36 * reflective_capacity -
        0.72 * outward_inward_discrepancy
    ) AS meaning_coherence_model,
    (
        0.56 * symbolic_activation +
        0.54 * shadow_integration +
        0.48 * reflective_capacity +
        0.42 * finitude_awareness -
        0.42 * persona_identification -
        0.25 * outward_inward_discrepancy
    ) AS second_half_orientation_model,
    (
        adaptation_strength + persona_identification
    ) / 2.0 AS first_half_index,
    (
        symbolic_activation + individuation_pressure + shadow_integration + reflective_capacity + finitude_awareness
    ) / 5.0 AS second_half_index
FROM midlife_transition_cases;
