-- Example queries for the synthetic Jungian personality schema.

SELECT
    dominant_function,
    dominant_attitude,
    AVG(developmental_integration_model) AS mean_developmental_integration_model,
    AVG(unconscious_compensation_model) AS mean_unconscious_compensation_model,
    AVG(onesidedness_model) AS mean_onesidedness_model,
    AVG(conscious_adaptation_index) AS mean_conscious_adaptation_index,
    AVG(symbolic_integration_index) AS mean_symbolic_integration_index
FROM jungian_personality_scores
GROUP BY dominant_function, dominant_attitude
ORDER BY mean_developmental_integration_model DESC;

SELECT
    time_period,
    AVG(developmental_integration_model) AS mean_developmental_integration_model,
    AVG(unconscious_compensation_model) AS mean_unconscious_compensation_model,
    AVG(onesidedness_model) AS mean_onesidedness_model,
    AVG(conscious_adaptation_index) AS mean_conscious_adaptation_index,
    AVG(symbolic_integration_index) AS mean_symbolic_integration_index
FROM jungian_personality_scores
GROUP BY time_period
ORDER BY time_period;
