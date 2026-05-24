-- ============================================================
-- Archetypal Psychology After Jung
-- SQL schema for synthetic archetypal-depth modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS archetypal_depth_cases (
    case_id INTEGER PRIMARY KEY,
    presentation_type TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    psychic_plurality REAL NOT NULL,
    imaginal_density REAL NOT NULL,
    metaphorical_richness REAL NOT NULL,
    symptom_image_intensity REAL NOT NULL,
    integrative_pressure REAL NOT NULL,
    literalizing_force REAL NOT NULL,
    diagnostic_dominance REAL NOT NULL,
    clinical_containment REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, assessment, screening, surveillance, or individual evaluation.'
);

CREATE VIEW IF NOT EXISTS archetypal_depth_scores AS
SELECT
    case_id,
    presentation_type,
    time_period,
    (
        0.65 * psychic_plurality +
        0.70 * imaginal_density +
        0.58 * metaphorical_richness +
        0.46 * symptom_image_intensity -
        0.55 * integrative_pressure
    ) AS archetypal_depth,
    (
        0.62 * imaginal_density +
        0.54 * psychic_plurality +
        0.60 * metaphorical_richness -
        0.38 * literalizing_force
    ) AS aesthetic_richness,
    (
        0.58 * integrative_pressure +
        0.62 * literalizing_force +
        0.56 * diagnostic_dominance -
        0.48 * imaginal_density -
        0.34 * clinical_containment
    ) AS flattening_risk
FROM archetypal_depth_cases;
