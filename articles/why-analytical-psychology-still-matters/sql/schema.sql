-- ============================================================
-- Why Analytical Psychology Still Matters
-- SQL schema for synthetic conceptual modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS symbolic_relevance_cases (
    case_id INTEGER PRIMARY KEY,
    tradition_type TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    symbolic_depth REAL NOT NULL,
    meaning_coherence REAL NOT NULL,
    clinical_utility REAL NOT NULL,
    cultural_interpretive_power REAL NOT NULL,
    revision_capacity REAL NOT NULL,
    doctrinal_rigidity REAL NOT NULL,
    symbolic_loss REAL NOT NULL,
    projection_intensity REAL NOT NULL,
    existential_dislocation REAL NOT NULL,
    institutional_mistrust REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, assessment, screening, surveillance, or individual evaluation.'
);

CREATE VIEW IF NOT EXISTS symbolic_relevance_scores AS
SELECT
    case_id,
    tradition_type,
    time_period,
    (
        0.62 * symbolic_depth +
        0.58 * meaning_coherence +
        0.54 * clinical_utility +
        0.48 * cultural_interpretive_power +
        0.60 * revision_capacity -
        0.70 * doctrinal_rigidity
    ) AS contemporary_relevance,
    (
        0.56 * symbolic_loss +
        0.52 * projection_intensity +
        0.64 * existential_dislocation +
        0.46 * institutional_mistrust
    ) AS depth_psychological_need
FROM symbolic_relevance_cases;
