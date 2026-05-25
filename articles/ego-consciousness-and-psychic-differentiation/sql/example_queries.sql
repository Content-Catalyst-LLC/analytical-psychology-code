-- Example queries for the synthetic ego-differentiation schema.

SELECT
    dominant_pattern,
    mean_differentiation,
    mean_function_balance,
    mean_reflective_flexibility,
    mean_unconscious_pressure,
    mean_one_sidedness,
    mean_ego_coherence,
    mean_ego_rigidity,
    mean_ego_inflation,
    mean_psychic_strain,
    mean_individuation_readiness
FROM dominant_pattern_summary
ORDER BY mean_individuation_readiness DESC;

SELECT
    time_period,
    AVG(ego_coherence_model) AS mean_ego_coherence_model,
    AVG(ego_rigidity_model) AS mean_ego_rigidity_model,
    AVG(ego_inflation_model) AS mean_ego_inflation_model,
    AVG(psychic_strain_model) AS mean_psychic_strain_model,
    AVG(individuation_readiness_model) AS mean_individuation_readiness_model
FROM ego_differentiation_scores
GROUP BY time_period
ORDER BY time_period;

SELECT
    source,
    target,
    weight,
    notes
FROM ego_network_edges
ORDER BY ABS(weight) DESC;

SELECT
    cluster,
    AVG(activation) AS mean_activation,
    COUNT(*) AS node_count
FROM ego_network_nodes
GROUP BY cluster
ORDER BY mean_activation DESC;
