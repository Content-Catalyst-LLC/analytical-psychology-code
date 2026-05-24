-- ============================================================
-- Jung, Freud, and the Divergence of Depth Psychologies
-- SQL schema for synthetic depth-psychology comparison
-- ============================================================

CREATE TABLE IF NOT EXISTS depth_psychology_cases (
    case_id INTEGER PRIMARY KEY,
    case_type TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    repression REAL NOT NULL,
    sexuality_conflict REAL NOT NULL,
    infantile_history REAL NOT NULL,
    defense_intensity REAL NOT NULL,
    transference_pressure REAL NOT NULL,
    mythic_amplification REAL NOT NULL,
    compensation REAL NOT NULL,
    archetypal_density REAL NOT NULL,
    prospective_development REAL NOT NULL,
    symbolic_coherence REAL NOT NULL,
    individuation_pressure REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, assessment, screening, surveillance, or individual evaluation.'
);

CREATE VIEW IF NOT EXISTS depth_psychology_scores AS
SELECT
    case_id,
    case_type,
    time_period,
    (
        0.66 * repression +
        0.70 * sexuality_conflict +
        0.62 * infantile_history +
        0.58 * defense_intensity +
        0.50 * transference_pressure -
        0.30 * mythic_amplification
    ) AS freudian_score,
    (
        0.58 * compensation +
        0.70 * archetypal_density +
        0.62 * prospective_development +
        0.64 * mythic_amplification +
        0.60 * symbolic_coherence +
        0.56 * individuation_pressure -
        0.24 * repression
    ) AS jungian_score,
    (
        0.48 * repression +
        0.46 * defense_intensity +
        0.44 * transference_pressure +
        0.48 * compensation +
        0.46 * symbolic_coherence +
        0.44 * prospective_development
    ) AS integrative_depth_score
FROM depth_psychology_cases;
