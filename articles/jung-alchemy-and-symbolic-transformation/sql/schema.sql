-- ============================================================
-- Jung, Alchemy, and Symbolic Transformation
-- SQL schema for synthetic alchemical-stage modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS alchemical_transformation_cases (
    case_id INTEGER PRIMARY KEY,
    symbolic_stage TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    nigredo_pressure REAL NOT NULL,
    albedo_clarity REAL NOT NULL,
    rubedo_vitality REAL NOT NULL,
    vessel_strength REAL NOT NULL,
    onesidedness REAL NOT NULL,
    mercurial_volatility REAL NOT NULL,
    shadow_intensity REAL NOT NULL,
    affective_heat REAL NOT NULL,
    pole_x REAL NOT NULL,
    pole_y REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, spiritual direction, assessment, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS alchemical_symbol_dictionary (
    symbol TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS alchemical_transformation_scores AS
SELECT
    case_id,
    symbolic_stage,
    time_period,
    (
        0.42 * nigredo_pressure +
        0.55 * albedo_clarity +
        0.66 * rubedo_vitality +
        0.58 * vessel_strength -
        0.60 * onesidedness -
        0.30 * ABS(mercurial_volatility)
    ) AS transformation_score,
    (
        0.55 * (pole_x * pole_y) -
        0.40 * ABS(pole_x - pole_y) +
        0.35 * vessel_strength
    ) AS coniunctio_index,
    CASE
        WHEN affective_heat + shadow_intensity - vessel_strength > 0
        THEN affective_heat + shadow_intensity - vessel_strength
        ELSE 0
    END AS vessel_failure_risk,
    vessel_strength - affective_heat AS containment_minus_heat
FROM alchemical_transformation_cases;
