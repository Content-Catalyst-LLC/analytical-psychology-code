-- Example queries for the synthetic persona-role schema.

SELECT
    persona_pattern,
    mean_role_demand,
    mean_audience_reward,
    mean_institutional_reward,
    mean_reflective_flexibility,
    mean_shadow_pressure,
    mean_persona_strength,
    mean_persona_rigidity,
    mean_psychic_strain,
    mean_burnout_risk,
    mean_individuation_readiness
FROM persona_pattern_summary
ORDER BY mean_psychic_strain DESC;

SELECT
    time_period,
    AVG(persona_strength_model) AS mean_persona_strength_model,
    AVG(persona_rigidity_model) AS mean_persona_rigidity_model,
    AVG(psychic_strain_model) AS mean_psychic_strain_model,
    AVG(burnout_risk_model) AS mean_burnout_risk_model,
    AVG(individuation_readiness_model) AS mean_individuation_readiness_model
FROM persona_role_scores
GROUP BY time_period
ORDER BY time_period;

SELECT
    source,
    target,
    weight,
    notes
FROM persona_network_edges
ORDER BY ABS(weight) DESC;

SELECT
    cluster,
    AVG(activation) AS mean_activation,
    COUNT(*) AS node_count
FROM persona_network_nodes
GROUP BY cluster
ORDER BY mean_activation DESC;
