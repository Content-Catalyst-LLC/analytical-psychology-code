-- ============================================================
-- Epistemology and Evidence in Analytical Psychology
-- SQL schema for synthetic epistemic-warrant modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS epistemic_claim_cases (
    claim_id INTEGER PRIMARY KEY,
    claim_type TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    empirical_support REAL NOT NULL,
    hermeneutic_coherence REAL NOT NULL,
    clinical_utility REAL NOT NULL,
    phenomenological_adequacy REAL NOT NULL,
    contextual_specificity REAL NOT NULL,
    methodological_explicitness REAL NOT NULL,
    ambiguity_inflation REAL NOT NULL,
    universalizing_force REAL NOT NULL,
    selective_evidence REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, assessment, screening, surveillance, or individual evaluation.'
);

CREATE VIEW IF NOT EXISTS epistemic_warrant_scores AS
SELECT
    claim_id,
    claim_type,
    time_period,
    (
        0.52 * empirical_support +
        0.58 * hermeneutic_coherence +
        0.62 * clinical_utility +
        0.56 * phenomenological_adequacy +
        0.44 * contextual_specificity +
        0.60 * methodological_explicitness -
        0.72 * ambiguity_inflation
    ) AS credibility_score,
    (
        0.64 * universalizing_force +
        0.70 * ambiguity_inflation +
        0.58 * selective_evidence -
        0.66 * methodological_explicitness -
        0.32 * contextual_specificity
    ) AS overreach_risk
FROM epistemic_claim_cases;
