-- ============================================================
-- Complexes, Affect, and Repetition in Analytical Psychology
-- SQL schema for synthetic complex-activation analysis
-- ============================================================

CREATE TABLE IF NOT EXISTS complex_activation_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    complex_type TEXT NOT NULL,
    trigger_intensity REAL NOT NULL,
    relational_threat REAL NOT NULL,
    evaluation_pressure REAL NOT NULL,
    shame_cue REAL NOT NULL,
    affect_intensity REAL NOT NULL,
    complex_activation REAL NOT NULL,
    regulation_capacity REAL NOT NULL,
    relational_buffer REAL NOT NULL,
    repetition_probability REAL NOT NULL,
    projection_pressure REAL NOT NULL,
    transference_pressure REAL NOT NULL,
    symbolic_repetition TEXT NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, clinical decision-making, employment screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS complex_network_nodes (
    node TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    affect_weight REAL NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS complex_network_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (source) REFERENCES complex_network_nodes(node),
    FOREIGN KEY (target) REFERENCES complex_network_nodes(node)
);

CREATE VIEW IF NOT EXISTS complex_activation_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    complex_type,
    (
        0.48 * affect_intensity +
        0.54 * trigger_intensity +
        0.34 * relational_threat +
        0.30 * evaluation_pressure +
        0.28 * shame_cue -
        0.36 * regulation_capacity -
        0.24 * relational_buffer
    ) AS modeled_affect_intensity,
    (
        0.58 * complex_activation +
        0.70 * affect_intensity +
        0.34 * trigger_intensity +
        0.26 * relational_threat -
        0.42 * regulation_capacity -
        0.30 * relational_buffer
    ) AS modeled_complex_activation,
    (
        complex_activation +
        affect_intensity +
        projection_pressure +
        transference_pressure -
        regulation_capacity -
        relational_buffer
    ) AS recurrence_pressure,
    (
        regulation_capacity +
        relational_buffer -
        affect_intensity -
        0.40 * complex_activation
    ) AS recovery_potential
FROM complex_activation_panel;

CREATE VIEW IF NOT EXISTS complex_type_summary AS
SELECT
    complex_type,
    AVG(trigger_intensity) AS mean_trigger_intensity,
    AVG(relational_threat) AS mean_relational_threat,
    AVG(evaluation_pressure) AS mean_evaluation_pressure,
    AVG(shame_cue) AS mean_shame_cue,
    AVG(affect_intensity) AS mean_affect_intensity,
    AVG(complex_activation) AS mean_complex_activation,
    AVG(repetition_probability) AS mean_repetition_probability,
    AVG(projection_pressure) AS mean_projection_pressure,
    AVG(transference_pressure) AS mean_transference_pressure,
    AVG(regulation_capacity) AS mean_regulation_capacity,
    AVG(relational_buffer) AS mean_relational_buffer
FROM complex_activation_panel
GROUP BY complex_type;
