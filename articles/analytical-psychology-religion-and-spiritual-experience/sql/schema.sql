-- ============================================================
-- Analytical Psychology, Religion, and Spiritual Experience
-- SQL schema for synthetic religion-and-spiritual-experience modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS religion_spiritual_experience_cases (
    case_id INTEGER PRIMARY KEY,
    religious_environment TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    numinous_intensity REAL NOT NULL,
    symbolic_containment REAL NOT NULL,
    ego_stability REAL NOT NULL,
    shadow_awareness REAL NOT NULL,
    ritual_support REAL NOT NULL,
    humility_limit_awareness REAL NOT NULL,
    perceived_mission REAL NOT NULL,
    doctrinal_rigidity REAL NOT NULL,
    symbolic_vitality REAL NOT NULL,
    religious_trauma_pressure REAL NOT NULL,
    communal_memory REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, spiritual direction, religious authority, assessment, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS religion_symbol_dictionary (
    symbol TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS religion_spiritual_experience_scores AS
SELECT
    case_id,
    religious_environment,
    time_period,
    numinous_intensity - symbolic_containment AS containment_gap,
    (
        0.60 * symbolic_containment +
        0.55 * ego_stability +
        0.48 * shadow_awareness +
        0.42 * ritual_support +
        0.36 * numinous_intensity -
        0.65 * ((numinous_intensity - symbolic_containment) * (numinous_intensity - symbolic_containment)) -
        0.30 * religious_trauma_pressure
    ) AS integration,
    (
        0.70 * numinous_intensity +
        0.58 * perceived_mission +
        0.35 * doctrinal_rigidity -
        0.55 * ego_stability -
        0.45 * shadow_awareness -
        0.42 * humility_limit_awareness -
        0.30 * ritual_support
    ) AS inflation_risk,
    (
        0.50 * symbolic_vitality +
        0.40 * ritual_support +
        0.35 * shadow_awareness +
        0.28 * communal_memory -
        0.45 * doctrinal_rigidity -
        0.25 * religious_trauma_pressure
    ) AS living_symbol_score,
    (
        symbolic_containment + ritual_support + ego_stability + humility_limit_awareness
    ) / 4.0 AS containment_index,
    (
        doctrinal_rigidity + religious_trauma_pressure + perceived_mission
    ) / 3.0 AS symbolic_risk_index
FROM religion_spiritual_experience_cases;
