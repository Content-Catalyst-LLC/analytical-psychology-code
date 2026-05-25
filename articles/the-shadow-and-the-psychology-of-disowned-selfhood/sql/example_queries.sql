-- Example queries for the synthetic shadow-projection schema.

SELECT
    shadow_configuration,
    mean_shadow_discrepancy,
    mean_affective_charge,
    mean_persona_rigidity,
    mean_reflective_capacity,
    mean_shadow_activation,
    mean_projection_intensity,
    mean_shame_response,
    mean_integration_capacity,
    mean_responsibility_index
FROM shadow_configuration_summary
ORDER BY mean_projection_intensity DESC;

SELECT
    time_period,
    AVG(shadow_activation_model) AS mean_shadow_activation_model,
    AVG(projection_intensity_model) AS mean_projection_intensity_model,
    AVG(shame_response_model) AS mean_shame_response_model,
    AVG(integration_capacity_model) AS mean_integration_capacity_model,
    AVG(false_innocence_pressure) AS mean_false_innocence_pressure
FROM shadow_projection_scores
GROUP BY time_period
ORDER BY time_period;

SELECT
    source,
    target,
    weight,
    notes
FROM shadow_network_edges
ORDER BY ABS(weight) DESC;

SELECT
    cluster,
    AVG(activation) AS mean_activation,
    COUNT(*) AS node_count
FROM shadow_network_nodes
GROUP BY cluster
ORDER BY mean_activation DESC;
