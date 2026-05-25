-- ============================================================
-- The Personal Unconscious and the Theory of Complexes
-- SQL schema for synthetic complex-activation analysis
-- ============================================================

CREATE TABLE IF NOT EXISTS personal_unconscious_complex_activation_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    complex_type TEXT NOT NULL,
    trigger_intensity REAL NOT NULL,
    relational_threat REAL NOT NULL,
    evaluation_pressure REAL NOT NULL,
    shame_cue REAL NOT NULL,
    guilt_cue REAL NOT NULL,
    unresolved_affect REAL NOT NULL,
    affect_intensity REAL NOT NULL,
    complex_activation REAL NOT NULL,
    regulation_capacity REAL NOT NULL,
    contextual_support REAL NOT NULL,
    repetition_probability REAL NOT NULL,
    projection_pressure REAL NOT NULL,
    transference_pressure REAL NOT NULL,
    symbolic_repetition TEXT NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, clinical decision-making, employment screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS associative_complex_nodes (
    node TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    affect_weight REAL NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS associative_complex_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (source) REFERENCES associative_complex_nodes(node),
    FOREIGN KEY (target) REFERENCES associative_complex_nodes(node)
);

CREATE VIEW IF NOT EXISTS complex_activation_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    complex_type,
    (
        0.50 * affect_intensity +
        0.58 * trigger_intensity +
        0.34 * relational_threat +
        0.32 * evaluation_pressure +
        0.30 * shame_cue +
        0.26 * guilt_cue +
        0.58 * unresolved_affect -
        0.38 * regulation_capacity -
        0.28 * contextual_support
    ) AS modeled_affect_intensity,
    (
        0.58 * complex_activation +
        0.70 * affect_intensity +
        0.34 * trigger_intensity +
        0.26 * relational_threat +
        0.22 * evaluation_pressure -
        0.42 * regulation_capacity -
        0.32 * contextual_support
    ) AS modeled_complex_activation,
    (
        complex_activation +
        affect_intensity +
        unresolved_affect +
        projection_pressure +
        transference_pressure -
        regulation_capacity -
        contextual_support
    ) AS complex_pressure,
    (
        regulation_capacity +
        contextual_support -
        affect_intensity -
        0.40 * complex_activation
    ) AS integration_potential
FROM personal_unconscious_complex_activation_panel;

CREATE VIEW IF NOT EXISTS complex_type_summary AS
SELECT
    complex_type,
    AVG(trigger_intensity) AS mean_trigger_intensity,
    AVG(relational_threat) AS mean_relational_threat,
    AVG(evaluation_pressure) AS mean_evaluation_pressure,
    AVG(shame_cue) AS mean_shame_cue,
    AVG(guilt_cue) AS mean_guilt_cue,
    AVG(unresolved_affect) AS mean_unresolved_affect,
    AVG(affect_intensity) AS mean_affect_intensity,
    AVG(complex_activation) AS mean_complex_activation,
    AVG(repetition_probability) AS mean_repetition_probability,
    AVG(projection_pressure) AS mean_projection_pressure,
    AVG(transference_pressure) AS mean_transference_pressure,
    AVG(regulation_capacity) AS mean_regulation_capacity,
    AVG(contextual_support) AS mean_contextual_support
FROM personal_unconscious_complex_activation_panel
GROUP BY complex_type;
