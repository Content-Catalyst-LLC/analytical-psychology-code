-- ============================================================
-- Childhood Development in Jungian and Post-Jungian Thought
-- SQL schema for synthetic childhood-development process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS childhood_development_cases (
    case_id INTEGER PRIMARY KEY,
    developmental_context TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    ego_differentiation REAL NOT NULL,
    relational_security REAL NOT NULL,
    caregiver_mirroring REAL NOT NULL,
    bodily_regulation REAL NOT NULL,
    symbolic_play REAL NOT NULL,
    affect_regulation REAL NOT NULL,
    complex_activation REAL NOT NULL,
    family_tension REAL NOT NULL,
    symbolic_capacity REAL NOT NULL,
    developmental_coherence REAL NOT NULL,
    future_personality REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, child assessment, educational evaluation, clinical decision-making, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS childhood_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS childhood_development_scores AS
SELECT
    case_id,
    developmental_context,
    time_period,
    (
        (ego_differentiation - relational_security) * (ego_differentiation - relational_security) +
        (symbolic_capacity - relational_security) * (symbolic_capacity - relational_security) +
        complex_activation * complex_activation
    ) AS developmental_strain,
    (
        0.48 * symbolic_play +
        0.36 * caregiver_mirroring +
        0.30 * bodily_regulation +
        0.26 * relational_security -
        0.30 * family_tension
    ) AS symbolic_capacity_model,
    (
        0.55 * ego_differentiation +
        0.70 * relational_security +
        0.60 * symbolic_capacity +
        0.48 * affect_regulation +
        0.34 * symbolic_play -
        0.50 * complex_activation -
        0.24 * (
            (ego_differentiation - relational_security) * (ego_differentiation - relational_security) +
            (symbolic_capacity - relational_security) * (symbolic_capacity - relational_security) +
            complex_activation * complex_activation
        )
    ) AS developmental_coherence_model,
    (
        relational_security + caregiver_mirroring + symbolic_play + symbolic_capacity
    ) / 4.0 AS relational_symbolic_index,
    (
        ego_differentiation + affect_regulation + bodily_regulation
    ) / 3.0 AS ego_regulation_index,
    (
        complex_activation + family_tension
    ) / 2.0 AS risk_index
FROM childhood_development_cases;
