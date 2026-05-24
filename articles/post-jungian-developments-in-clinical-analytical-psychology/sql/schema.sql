-- ============================================================
-- Post-Jungian Developments in Clinical Analytical Psychology
-- SQL schema for synthetic clinical-dimension modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS post_jungian_clinical_models (
    model_id INTEGER PRIMARY KEY,
    school_tendency TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    symbolic_depth REAL NOT NULL,
    relational_sophistication REAL NOT NULL,
    developmental_precision REAL NOT NULL,
    trauma_sensitivity REAL NOT NULL,
    embodied_regulation REAL NOT NULL,
    cultural_responsiveness REAL NOT NULL,
    doctrinal_rigidity REAL NOT NULL,
    fragmentation_load REAL NOT NULL,
    affect_tolerance REAL NOT NULL,
    relational_holding REAL NOT NULL,
    grounding_capacity REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, assessment, treatment assignment, screening, surveillance, or individual evaluation.'
);

CREATE VIEW IF NOT EXISTS post_jungian_clinical_scores AS
SELECT
    model_id,
    school_tendency,
    time_period,
    (
        0.50 * symbolic_depth +
        0.62 * relational_sophistication +
        0.58 * developmental_precision +
        0.66 * trauma_sensitivity +
        0.52 * embodied_regulation +
        0.46 * cultural_responsiveness -
        0.60 * doctrinal_rigidity
    ) AS clinical_adequacy,
    (
        0.56 * affect_tolerance +
        0.62 * relational_holding +
        0.52 * grounding_capacity -
        0.64 * fragmentation_load
    ) AS symbolic_readiness,
    (
        (
            relational_sophistication +
            developmental_precision +
            trauma_sensitivity +
            embodied_regulation +
            cultural_responsiveness
        ) / 5.0
    ) AS clinical_refinement_mean,
    (
        0.60 * symbolic_depth -
        0.50 * ABS(
            symbolic_depth -
            (
                relational_sophistication +
                developmental_precision +
                trauma_sensitivity +
                embodied_regulation +
                cultural_responsiveness
            ) / 5.0
        )
    ) AS balance_index
FROM post_jungian_clinical_models;
