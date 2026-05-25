-- ============================================================
-- Anima, Animus, and the Problem of Gendered Symbolism
-- SQL schema for synthetic symbolic-otherness modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS symbolic_otherness_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    symbolic_pattern TEXT NOT NULL,
    unrealized_capacity REAL NOT NULL,
    affective_charge REAL NOT NULL,
    relational_trigger REAL NOT NULL,
    reflective_mediation REAL NOT NULL,
    gender_code_rigidity REAL NOT NULL,
    symbolic_flexibility REAL NOT NULL,
    symbolic_discrepancy REAL NOT NULL,
    projection_intensity REAL NOT NULL,
    projection_rigidity REAL NOT NULL,
    symbolic_integration REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, gender assessment, sexuality assessment, mental-health evaluation, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS symbolic_otherness_nodes (
    node TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    activation REAL NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS symbolic_otherness_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (source) REFERENCES symbolic_otherness_nodes(node),
    FOREIGN KEY (target) REFERENCES symbolic_otherness_nodes(node)
);

CREATE VIEW IF NOT EXISTS symbolic_otherness_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    symbolic_pattern,
    (
        0.70 * unrealized_capacity +
        0.65 * affective_charge +
        0.50 * relational_trigger +
        0.34 * symbolic_discrepancy +
        0.22 * gender_code_rigidity -
        0.55 * reflective_mediation
    ) AS projection_intensity_model,
    (
        0.48 * projection_intensity +
        0.42 * gender_code_rigidity -
        0.36 * symbolic_flexibility -
        0.32 * reflective_mediation
    ) AS projection_rigidity_model,
    (
        0.46 * reflective_mediation +
        0.42 * symbolic_flexibility -
        0.30 * projection_rigidity -
        0.24 * ABS(projection_intensity)
    ) AS symbolic_integration_model,
    projection_intensity - symbolic_integration AS projection_minus_integration,
    symbolic_flexibility - gender_code_rigidity AS coding_flexibility_gap
FROM symbolic_otherness_panel;

CREATE VIEW IF NOT EXISTS symbolic_pattern_summary AS
SELECT
    symbolic_pattern,
    AVG(unrealized_capacity) AS mean_unrealized_capacity,
    AVG(affective_charge) AS mean_affective_charge,
    AVG(relational_trigger) AS mean_relational_trigger,
    AVG(reflective_mediation) AS mean_reflective_mediation,
    AVG(gender_code_rigidity) AS mean_gender_code_rigidity,
    AVG(symbolic_flexibility) AS mean_symbolic_flexibility,
    AVG(symbolic_discrepancy) AS mean_symbolic_discrepancy,
    AVG(projection_intensity) AS mean_projection_intensity,
    AVG(projection_rigidity) AS mean_projection_rigidity,
    AVG(symbolic_integration) AS mean_symbolic_integration
FROM symbolic_otherness_panel
GROUP BY symbolic_pattern;
