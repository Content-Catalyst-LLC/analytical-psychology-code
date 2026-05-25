-- ============================================================
-- Psychological Types: Introversion, Extraversion,
-- and the Four Functions
-- SQL schema for synthetic typology process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS psychological_type_cases (
    case_id INTEGER PRIMARY KEY,
    dominant_function TEXT NOT NULL,
    inferior_function TEXT NOT NULL,
    dominant_attitude TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    thinking REAL NOT NULL,
    feeling REAL NOT NULL,
    sensation REAL NOT NULL,
    intuition REAL NOT NULL,
    attitude_score REAL NOT NULL,
    dominant_strength REAL NOT NULL,
    inferior_strength REAL NOT NULL,
    function_variance REAL NOT NULL,
    unconscious_pressure REAL NOT NULL,
    compensation_strain REAL NOT NULL,
    reflective_capacity REAL NOT NULL,
    symbolic_relation REAL NOT NULL,
    conscious_coherence REAL NOT NULL,
    developmental_integration REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, personality assessment, typological labeling, hiring, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS type_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS psychological_type_scores AS
SELECT
    case_id,
    dominant_function,
    inferior_function,
    dominant_attitude,
    time_period,
    (
        dominant_strength - inferior_strength
    ) AS dominant_inferior_gap,
    (
        0.70 * (dominant_strength - inferior_strength) +
        0.55 * function_variance +
        0.45 * unconscious_pressure -
        0.28 * reflective_capacity
    ) AS compensation_strain_model,
    (
        0.52 * dominant_strength +
        0.20 * attitude_score -
        0.30 * function_variance +
        0.26 * reflective_capacity
    ) AS conscious_coherence_model,
    (
        0.42 * inferior_strength +
        0.38 * symbolic_relation +
        0.36 * reflective_capacity -
        0.32 * function_variance -
        0.26 * compensation_strain
    ) AS developmental_integration_model,
    (
        thinking + feeling + sensation + intuition
    ) / 4.0 AS function_balance_index,
    (
        developmental_integration - compensation_strain
    ) AS integration_minus_strain
FROM psychological_type_cases;
