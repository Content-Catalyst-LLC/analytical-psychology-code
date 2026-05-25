-- ============================================================
-- Ego, Consciousness, and Psychic Differentiation
-- SQL schema for synthetic ego-differentiation and network modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS ego_differentiation_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    dominant_pattern TEXT NOT NULL,
    differentiation REAL NOT NULL,
    function_balance REAL NOT NULL,
    reflective_flexibility REAL NOT NULL,
    unconscious_pressure REAL NOT NULL,
    persona_identification REAL NOT NULL,
    shadow_activation REAL NOT NULL,
    one_sidedness REAL NOT NULL,
    ego_coherence REAL NOT NULL,
    ego_rigidity REAL NOT NULL,
    ego_inflation REAL NOT NULL,
    psychic_strain REAL NOT NULL,
    individuation_readiness REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, personality assessment, mental-health evaluation, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS ego_network_nodes (
    node TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    activation REAL NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS ego_network_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (source) REFERENCES ego_network_nodes(node),
    FOREIGN KEY (target) REFERENCES ego_network_nodes(node)
);

CREATE VIEW IF NOT EXISTS ego_differentiation_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    dominant_pattern,
    (
        0.72 * differentiation -
        0.48 * unconscious_pressure +
        0.60 * reflective_flexibility -
        0.22 * one_sidedness
    ) AS ego_coherence_model,
    (
        0.54 * persona_identification +
        0.42 * one_sidedness -
        0.36 * reflective_flexibility
    ) AS ego_rigidity_model,
    (
        0.46 * ego_coherence +
        0.50 * persona_identification +
        0.30 * differentiation -
        0.52 * reflective_flexibility -
        0.32 * shadow_activation
    ) AS ego_inflation_model,
    (
        0.40 * one_sidedness +
        0.46 * unconscious_pressure +
        0.42 * shadow_activation +
        0.34 * ego_rigidity -
        0.44 * reflective_flexibility
    ) AS psychic_strain_model,
    (
        0.42 * ego_coherence +
        0.44 * reflective_flexibility +
        0.28 * function_balance -
        0.30 * ego_inflation -
        0.24 * psychic_strain
    ) AS individuation_readiness_model,
    ABS(differentiation - function_balance) AS ego_balance_gap,
    ego_coherence - ego_inflation AS coherence_minus_inflation
FROM ego_differentiation_panel;

CREATE VIEW IF NOT EXISTS dominant_pattern_summary AS
SELECT
    dominant_pattern,
    AVG(differentiation) AS mean_differentiation,
    AVG(function_balance) AS mean_function_balance,
    AVG(reflective_flexibility) AS mean_reflective_flexibility,
    AVG(unconscious_pressure) AS mean_unconscious_pressure,
    AVG(persona_identification) AS mean_persona_identification,
    AVG(shadow_activation) AS mean_shadow_activation,
    AVG(one_sidedness) AS mean_one_sidedness,
    AVG(ego_coherence) AS mean_ego_coherence,
    AVG(ego_rigidity) AS mean_ego_rigidity,
    AVG(ego_inflation) AS mean_ego_inflation,
    AVG(psychic_strain) AS mean_psychic_strain,
    AVG(individuation_readiness) AS mean_individuation_readiness
FROM ego_differentiation_panel
GROUP BY dominant_pattern;
