-- ============================================================
-- Active Imagination and the Practice of Symbolic Dialogue
-- SQL schema for synthetic symbolic-dialogue process modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS active_imagination_dialogue_cases (
    case_id INTEGER PRIMARY KEY,
    dialogue_mode TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    ego_mediation REAL NOT NULL,
    imaginal_activation REAL NOT NULL,
    reflective_response REAL NOT NULL,
    symbolic_relation REAL NOT NULL,
    ethical_containment REAL NOT NULL,
    destabilization_risk REAL NOT NULL,
    inflation_risk REAL NOT NULL,
    dialogue_quality REAL NOT NULL,
    integration_score REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, treatment recommendation, mental-health evaluation, clinical decision-making, crisis intervention, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS symbolic_dialogue_construct_dictionary (
    construct TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS active_imagination_dialogue_scores AS
SELECT
    case_id,
    dialogue_mode,
    time_period,
    (
        -1.0 * (ego_mediation - imaginal_activation) * (ego_mediation - imaginal_activation)
    ) AS ego_imaginal_balance,
    (
        0.54 * imaginal_activation -
        0.38 * ego_mediation -
        0.34 * reflective_response
    ) AS destabilization_risk_model,
    (
        0.42 * ego_mediation +
        0.36 * reflective_response +
        0.28 * symbolic_relation -
        0.24 * ABS(imaginal_activation)
    ) AS ethical_containment_model,
    (
        0.56 * ego_mediation +
        0.52 * imaginal_activation +
        0.48 * reflective_response +
        0.44 * symbolic_relation +
        0.34 * ethical_containment -
        0.70 * (ego_mediation - imaginal_activation) * (ego_mediation - imaginal_activation) -
        0.28 * CASE WHEN destabilization_risk > 0 THEN destabilization_risk ELSE 0 END
    ) AS integration_score_model,
    (
        0.46 * symbolic_relation +
        0.42 * reflective_response +
        0.38 * ethical_containment -
        0.34 * ABS(ego_mediation - imaginal_activation)
    ) AS dialogue_quality_model,
    (
        integration_score - destabilization_risk - inflation_risk
    ) AS integration_minus_risk
FROM active_imagination_dialogue_cases;
