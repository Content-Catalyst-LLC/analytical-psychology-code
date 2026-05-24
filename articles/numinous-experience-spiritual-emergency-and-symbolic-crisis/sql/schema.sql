-- ============================================================
-- Numinous Experience, Spiritual Emergency, and Symbolic Crisis
-- SQL schema for synthetic numinous-crisis modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS numinous_crisis_cases (
    case_id INTEGER PRIMARY KEY,
    symbolic_environment TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    numinous_intensity REAL NOT NULL,
    symbolic_containment REAL NOT NULL,
    ego_stability REAL NOT NULL,
    trauma_vulnerability REAL NOT NULL,
    shadow_awareness REAL NOT NULL,
    relational_support REAL NOT NULL,
    ritual_containment REAL NOT NULL,
    sleep_disruption REAL NOT NULL,
    practice_intensity REAL NOT NULL,
    perceived_mission REAL NOT NULL,
    humility_limit_awareness REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, spiritual direction, crisis intervention, assessment, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS numinous_symbol_dictionary (
    symbol TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS numinous_crisis_scores AS
SELECT
    case_id,
    symbolic_environment,
    time_period,
    (
        0.75 * numinous_intensity +
        0.45 * trauma_vulnerability +
        0.35 * practice_intensity +
        0.30 * sleep_disruption -
        0.55 * symbolic_containment -
        0.60 * ego_stability -
        0.40 * shadow_awareness -
        0.35 * relational_support
    ) AS crisis_risk,
    (
        0.58 * numinous_intensity +
        0.62 * perceived_mission -
        0.48 * shadow_awareness -
        0.52 * humility_limit_awareness -
        0.30 * relational_support
    ) AS inflation_risk,
    (
        0.60 * symbolic_containment +
        0.55 * ego_stability +
        0.45 * shadow_awareness +
        0.50 * relational_support +
        0.35 * humility_limit_awareness -
        0.70 * (
            0.75 * numinous_intensity +
            0.45 * trauma_vulnerability +
            0.35 * practice_intensity +
            0.30 * sleep_disruption -
            0.55 * symbolic_containment -
            0.60 * ego_stability -
            0.40 * shadow_awareness -
            0.35 * relational_support
        ) -
        0.38 * (
            0.58 * numinous_intensity +
            0.62 * perceived_mission -
            0.48 * shadow_awareness -
            0.52 * humility_limit_awareness -
            0.30 * relational_support
        )
    ) AS integration_potential,
    (
        symbolic_containment + ritual_containment + relational_support
    ) / 3.0 AS containment_index,
    (
        trauma_vulnerability + sleep_disruption + practice_intensity
    ) / 3.0 AS vulnerability_index
FROM numinous_crisis_cases;
