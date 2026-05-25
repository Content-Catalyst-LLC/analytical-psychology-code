-- ============================================================
-- The Shadow and the Psychology of Disowned Selfhood
-- SQL schema for synthetic shadow-projection and network modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS shadow_projection_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    shadow_configuration TEXT NOT NULL,
    latent_disowned REAL NOT NULL,
    ego_identity REAL NOT NULL,
    cue_intensity REAL NOT NULL,
    affective_charge REAL NOT NULL,
    persona_rigidity REAL NOT NULL,
    reflective_capacity REAL NOT NULL,
    shadow_discrepancy REAL NOT NULL,
    shadow_activation REAL NOT NULL,
    projection_intensity REAL NOT NULL,
    shame_response REAL NOT NULL,
    integration_capacity REAL NOT NULL,
    responsibility_index REAL NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, moral ranking, mental-health evaluation, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS shadow_network_nodes (
    node TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    activation REAL NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS shadow_network_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight REAL NOT NULL,
    notes TEXT,
    FOREIGN KEY (source) REFERENCES shadow_network_nodes(node),
    FOREIGN KEY (target) REFERENCES shadow_network_nodes(node)
);

CREATE VIEW IF NOT EXISTS shadow_projection_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    shadow_configuration,
    (
        0.72 * latent_disowned * cue_intensity +
        0.56 * shadow_discrepancy +
        0.42 * affective_charge -
        0.48 * reflective_capacity
    ) AS shadow_activation_model,
    (
        0.76 * shadow_activation +
        0.44 * affective_charge +
        0.32 * persona_rigidity -
        0.56 * reflective_capacity
    ) AS projection_intensity_model,
    (
        0.42 * shadow_activation +
        0.34 * persona_rigidity -
        0.30 * reflective_capacity
    ) AS shame_response_model,
    (
        0.50 * reflective_capacity -
        0.34 * ABS(projection_intensity) -
        0.26 * shame_response +
        0.28 * time_period
    ) AS integration_capacity_model,
    projection_intensity - integration_capacity AS projection_minus_integration,
    persona_rigidity + projection_intensity - reflective_capacity AS false_innocence_pressure
FROM shadow_projection_panel;

CREATE VIEW IF NOT EXISTS shadow_configuration_summary AS
SELECT
    shadow_configuration,
    AVG(latent_disowned) AS mean_latent_disowned,
    AVG(ego_identity) AS mean_ego_identity,
    AVG(shadow_discrepancy) AS mean_shadow_discrepancy,
    AVG(cue_intensity) AS mean_cue_intensity,
    AVG(affective_charge) AS mean_affective_charge,
    AVG(persona_rigidity) AS mean_persona_rigidity,
    AVG(reflective_capacity) AS mean_reflective_capacity,
    AVG(shadow_activation) AS mean_shadow_activation,
    AVG(projection_intensity) AS mean_projection_intensity,
    AVG(shame_response) AS mean_shame_response,
    AVG(integration_capacity) AS mean_integration_capacity,
    AVG(responsibility_index) AS mean_responsibility_index
FROM shadow_projection_panel
GROUP BY shadow_configuration;
