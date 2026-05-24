-- ============================================================
-- Critiques of Jungian Psychology: Evidence, Culture, and Universality
-- SQL schema for synthetic critique modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS jungian_critique_cases (
    concept_id INTEGER PRIMARY KEY,
    concept_family TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    interpretive_breadth REAL NOT NULL,
    empirical_support REAL NOT NULL,
    cultural_specificity REAL NOT NULL,
    gender_critical_revision REAL NOT NULL,
    methodological_explicitness REAL NOT NULL,
    clinical_utility REAL NOT NULL,
    symbolic_usefulness REAL NOT NULL,
    universalization REAL NOT NULL,
    problematic_inherited_assumptions REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, assessment, cultural ranking, religious evaluation, screening, surveillance, or individual evaluation.'
);

CREATE VIEW IF NOT EXISTS jungian_critique_scores AS
SELECT
    concept_id,
    concept_family,
    time_period,
    (
        0.48 * interpretive_breadth +
        0.56 * empirical_support +
        0.62 * cultural_specificity +
        0.50 * gender_critical_revision +
        0.58 * methodological_explicitness +
        0.46 * clinical_utility -
        0.72 * universalization
    ) AS credibility_score,
    (
        0.62 * interpretive_breadth +
        0.70 * universalization -
        0.56 * cultural_specificity -
        0.44 * empirical_support -
        0.52 * methodological_explicitness
    ) AS overgeneralization_risk,
    (
        0.62 * symbolic_usefulness +
        0.58 * clinical_utility +
        0.54 * methodological_explicitness +
        0.48 * gender_critical_revision -
        0.66 * problematic_inherited_assumptions
    ) AS retained_value_after_critique
FROM jungian_critique_cases;
