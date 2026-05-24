-- ============================================================
-- Trauma, Dissociation, and the Fragmented Psyche
-- SQL schema for synthetic trauma-and-dissociation process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS trauma_dissociation_cases (
    case_id INTEGER PRIMARY KEY,
    trauma_pattern TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    affect_intensity REAL NOT NULL,
    ego_integration REAL NOT NULL,
    symbolic_capacity REAL NOT NULL,
    relational_safety REAL NOT NULL,
    bodily_regulation REAL NOT NULL,
    dissociation REAL NOT NULL,
    nightmare_intrusion REAL NOT NULL,
    memory_continuity REAL NOT NULL,
    symbolic_recovery REAL NOT NULL,
    developmental_trauma_load REAL NOT NULL,
    witnessing_capacity REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, crisis assessment, risk prediction, treatment recommendation, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS trauma_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS trauma_dissociation_scores AS
SELECT
    case_id,
    trauma_pattern,
    time_period,
    (
        0.72 * affect_intensity +
        0.45 * developmental_trauma_load +
        0.34 * nightmare_intrusion -
        0.55 * ego_integration -
        0.48 * symbolic_capacity -
        0.42 * relational_safety -
        0.30 * bodily_regulation
    ) AS dissociation_model,
    (
        0.50 * symbolic_capacity +
        0.42 * memory_continuity +
        0.36 * relational_safety +
        0.32 * bodily_regulation +
        0.28 * witnessing_capacity -
        0.34 * nightmare_intrusion -
        0.30 * dissociation
    ) AS symbolic_recovery_model,
    (
        0.60 * ego_integration +
        0.55 * symbolic_capacity +
        0.62 * relational_safety +
        0.48 * bodily_regulation +
        0.44 * memory_continuity +
        0.40 * symbolic_recovery +
        0.32 * witnessing_capacity -
        0.68 * dissociation -
        0.34 * nightmare_intrusion
    ) AS integration_potential,
    (
        affect_intensity + dissociation + nightmare_intrusion + developmental_trauma_load
    ) / 4.0 AS fragmentation_index,
    (
        ego_integration + symbolic_capacity + relational_safety + bodily_regulation + memory_continuity + witnessing_capacity
    ) / 6.0 AS recovery_capacity_index
FROM trauma_dissociation_cases;
