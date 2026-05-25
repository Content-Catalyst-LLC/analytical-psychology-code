-- ============================================================
-- The Self in Jungian Thought
-- SQL schema for synthetic Self-integration and network modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS self_integration_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    individuation_pattern TEXT NOT NULL,
    ego_coherence REAL NOT NULL,
    unconscious_activation REAL NOT NULL,
    symbolic_center_strength REAL NOT NULL,
    shadow_pressure REAL NOT NULL,
    relational_coordination REAL NOT NULL,
    disjunction REAL NOT NULL,
    inflation_risk REAL NOT NULL,
    totality_score REAL NOT NULL,
    differentiation_score REAL NOT NULL,
    self_relation_index REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, spiritual authority claims, mental-health evaluation, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS psychic_network_nodes (
    node TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    activation REAL NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS psychic_network_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (source) REFERENCES psychic_network_nodes(node),
    FOREIGN KEY (target) REFERENCES psychic_network_nodes(node)
);

CREATE VIEW IF NOT EXISTS self_integration_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    individuation_pattern,
    (
        0.48 * ego_coherence +
        0.36 * unconscious_activation +
        0.58 * symbolic_center_strength +
        0.54 * relational_coordination -
        0.46 * disjunction -
        0.30 * CASE WHEN inflation_risk > 0 THEN inflation_risk ELSE 0 END
    ) AS totality_score_model,
    (
        0.42 * ego_coherence +
        0.38 * symbolic_center_strength +
        0.36 * relational_coordination -
        0.32 * ABS(shadow_pressure)
    ) AS differentiation_score_model,
    (
        0.40 * totality_score +
        0.34 * differentiation_score +
        0.28 * symbolic_center_strength -
        0.30 * CASE WHEN inflation_risk > 0 THEN inflation_risk ELSE 0 END
    ) AS self_relation_index_model,
    ABS(ego_coherence - symbolic_center_strength) AS ego_center_gap,
    self_relation_index - inflation_risk AS integration_minus_inflation
FROM self_integration_panel;

CREATE VIEW IF NOT EXISTS individuation_pattern_summary AS
SELECT
    individuation_pattern,
    AVG(ego_coherence) AS mean_ego_coherence,
    AVG(unconscious_activation) AS mean_unconscious_activation,
    AVG(symbolic_center_strength) AS mean_symbolic_center_strength,
    AVG(shadow_pressure) AS mean_shadow_pressure,
    AVG(relational_coordination) AS mean_relational_coordination,
    AVG(disjunction) AS mean_disjunction,
    AVG(inflation_risk) AS mean_inflation_risk,
    AVG(totality_score) AS mean_totality_score,
    AVG(self_relation_index) AS mean_self_relation_index
FROM self_integration_panel
GROUP BY individuation_pattern;
