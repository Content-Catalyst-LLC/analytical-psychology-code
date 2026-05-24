-- ============================================================
-- Non-Western Symbol Systems and the Limits of Jungian Universality
-- SQL schema for synthetic symbolic-comparison modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS symbolic_comparison_cases (
    symbol_id INTEGER PRIMARY KEY,
    tradition_layer TEXT NOT NULL,
    time_period INTEGER NOT NULL,
    recurrence REAL NOT NULL,
    specificity REAL NOT NULL,
    linguistic_depth REAL NOT NULL,
    ritual_context REAL NOT NULL,
    dialogical_accountability REAL NOT NULL,
    universalizing_force REAL NOT NULL,
    abstraction_pressure REAL NOT NULL,
    contextual_divergence REAL NOT NULL,
    functional_convergence REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for cultural ranking, religious evaluation, diagnosis, assessment, screening, surveillance, or individual evaluation.'
);

CREATE VIEW IF NOT EXISTS symbolic_comparison_scores AS
SELECT
    symbol_id,
    tradition_layer,
    time_period,
    (
        0.52 * recurrence +
        0.68 * specificity +
        0.58 * linguistic_depth +
        0.54 * ritual_context +
        0.62 * dialogical_accountability -
        0.66 * universalizing_force -
        0.42 * abstraction_pressure
    ) AS comparative_quality,
    (
        0.70 * universalizing_force +
        0.64 * abstraction_pressure -
        0.58 * specificity -
        0.54 * dialogical_accountability -
        0.38 * linguistic_depth
    ) AS flattening_risk,
    (
        0.44 * recurrence +
        0.54 * functional_convergence -
        0.62 * contextual_divergence
    ) AS equivalence_claim_strength
FROM symbolic_comparison_cases;
