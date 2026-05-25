-- ============================================================
-- Persona and Social Adaptation in Analytical Psychology
-- SQL schema for synthetic persona-role and network modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS persona_role_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    persona_pattern TEXT NOT NULL,
    role_demand REAL NOT NULL,
    audience_reward REAL NOT NULL,
    institutional_reward REAL NOT NULL,
    inward_complexity REAL NOT NULL,
    reflective_flexibility REAL NOT NULL,
    shadow_pressure REAL NOT NULL,
    status_dependence REAL NOT NULL,
    persona_strength REAL NOT NULL,
    persona_rigidity REAL NOT NULL,
    persona_inward_gap REAL NOT NULL,
    psychic_strain REAL NOT NULL,
    burnout_risk REAL NOT NULL,
    individuation_readiness REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, employment screening, reputation scoring, social scoring, mental-health evaluation, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS persona_network_nodes (
    node TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    activation REAL NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS persona_network_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (source) REFERENCES persona_network_nodes(node),
    FOREIGN KEY (target) REFERENCES persona_network_nodes(node)
);

CREATE VIEW IF NOT EXISTS persona_role_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    persona_pattern,
    (
        0.64 * role_demand +
        0.48 * audience_reward +
        0.36 * institutional_reward -
        0.30 * inward_complexity +
        0.42 * reflective_flexibility
    ) AS persona_strength_model,
    (
        0.52 * persona_strength +
        0.42 * status_dependence +
        0.34 * institutional_reward -
        0.46 * reflective_flexibility
    ) AS persona_rigidity_model,
    (
        0.50 * persona_strength +
        0.62 * persona_inward_gap * persona_inward_gap +
        0.42 * persona_rigidity +
        0.36 * shadow_pressure -
        0.52 * reflective_flexibility
    ) AS psychic_strain_model,
    (
        0.46 * psychic_strain +
        0.36 * role_demand +
        0.30 * persona_rigidity -
        0.42 * reflective_flexibility
    ) AS burnout_risk_model,
    (
        0.48 * reflective_flexibility +
        0.34 * inward_complexity -
        0.28 * persona_rigidity -
        0.24 * psychic_strain +
        0.18 * time_period
    ) AS individuation_readiness_model,
    persona_strength + shadow_pressure - reflective_flexibility AS persona_shadow_pressure_gap,
    role_demand + audience_reward + institutional_reward AS role_reward_pressure
FROM persona_role_panel;

CREATE VIEW IF NOT EXISTS persona_pattern_summary AS
SELECT
    persona_pattern,
    AVG(role_demand) AS mean_role_demand,
    AVG(audience_reward) AS mean_audience_reward,
    AVG(institutional_reward) AS mean_institutional_reward,
    AVG(inward_complexity) AS mean_inward_complexity,
    AVG(reflective_flexibility) AS mean_reflective_flexibility,
    AVG(shadow_pressure) AS mean_shadow_pressure,
    AVG(status_dependence) AS mean_status_dependence,
    AVG(persona_strength) AS mean_persona_strength,
    AVG(persona_rigidity) AS mean_persona_rigidity,
    AVG(persona_inward_gap) AS mean_persona_inward_gap,
    AVG(psychic_strain) AS mean_psychic_strain,
    AVG(burnout_risk) AS mean_burnout_risk,
    AVG(individuation_readiness) AS mean_individuation_readiness
FROM persona_role_panel
GROUP BY persona_pattern;
