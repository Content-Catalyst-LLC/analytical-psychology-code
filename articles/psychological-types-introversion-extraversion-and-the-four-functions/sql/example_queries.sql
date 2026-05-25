-- Example queries for the synthetic psychological types schema.

SELECT
    dominant_function,
    inferior_function,
    dominant_attitude,
    AVG(dominant_inferior_gap) AS mean_dominant_inferior_gap,
    AVG(compensation_strain_model) AS mean_compensation_strain_model,
    AVG(conscious_coherence_model) AS mean_conscious_coherence_model,
    AVG(developmental_integration_model) AS mean_developmental_integration_model,
    AVG(function_balance_index) AS mean_function_balance_index
FROM psychological_type_scores
GROUP BY dominant_function, inferior_function, dominant_attitude
ORDER BY mean_developmental_integration_model DESC;

SELECT
    time_period,
    AVG(dominant_inferior_gap) AS mean_dominant_inferior_gap,
    AVG(compensation_strain_model) AS mean_compensation_strain_model,
    AVG(conscious_coherence_model) AS mean_conscious_coherence_model,
    AVG(developmental_integration_model) AS mean_developmental_integration_model,
    AVG(integration_minus_strain) AS mean_integration_minus_strain
FROM psychological_type_scores
GROUP BY time_period
ORDER BY time_period;
