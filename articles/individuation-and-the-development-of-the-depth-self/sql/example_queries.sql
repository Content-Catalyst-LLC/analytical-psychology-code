-- Example queries for the synthetic individuation schema.

SELECT
    individuation_pathway,
    AVG(depth_self_integration_model) AS mean_depth_self_integration_model,
    AVG(compensation_pressure_model) AS mean_compensation_pressure_model,
    AVG(onesidedness_model) AS mean_onesidedness_model,
    AVG(adaptive_surface_index) AS mean_adaptive_surface_index,
    AVG(depth_integration_index) AS mean_depth_integration_index
FROM individuation_depth_self_scores
GROUP BY individuation_pathway
ORDER BY mean_depth_self_integration_model DESC;

SELECT
    time_period,
    AVG(depth_self_integration_model) AS mean_depth_self_integration_model,
    AVG(compensation_pressure_model) AS mean_compensation_pressure_model,
    AVG(onesidedness_model) AS mean_onesidedness_model,
    AVG(adaptive_surface_index) AS mean_adaptive_surface_index,
    AVG(depth_integration_index) AS mean_depth_integration_index
FROM individuation_depth_self_scores
GROUP BY time_period
ORDER BY time_period;
