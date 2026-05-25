-- Example queries for the synthetic Self-integration schema.

SELECT
    individuation_pattern,
    mean_ego_coherence,
    mean_symbolic_center_strength,
    mean_shadow_pressure,
    mean_relational_coordination,
    mean_disjunction,
    mean_inflation_risk,
    mean_totality_score,
    mean_self_relation_index
FROM individuation_pattern_summary
ORDER BY mean_self_relation_index DESC;

SELECT
    time_period,
    AVG(totality_score_model) AS mean_totality_score_model,
    AVG(differentiation_score_model) AS mean_differentiation_score_model,
    AVG(self_relation_index_model) AS mean_self_relation_index_model,
    AVG(integration_minus_inflation) AS mean_integration_minus_inflation
FROM self_integration_scores
GROUP BY time_period
ORDER BY time_period;

SELECT
    source,
    target,
    weight,
    notes
FROM psychic_network_edges
ORDER BY ABS(weight) DESC;

SELECT
    cluster,
    AVG(activation) AS mean_activation,
    COUNT(*) AS node_count
FROM psychic_network_nodes
GROUP BY cluster
ORDER BY mean_activation DESC;
