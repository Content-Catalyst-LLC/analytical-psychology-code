-- Example queries for the synthetic childhood-development schema.

SELECT
    developmental_context,
    AVG(developmental_coherence_model) AS mean_developmental_coherence_model,
    AVG(symbolic_capacity_model) AS mean_symbolic_capacity_model,
    AVG(relational_symbolic_index) AS mean_relational_symbolic_index,
    AVG(ego_regulation_index) AS mean_ego_regulation_index,
    AVG(risk_index) AS mean_risk_index
FROM childhood_development_scores
GROUP BY developmental_context
ORDER BY mean_developmental_coherence_model DESC;

SELECT
    time_period,
    AVG(developmental_coherence_model) AS mean_developmental_coherence_model,
    AVG(symbolic_capacity_model) AS mean_symbolic_capacity_model,
    AVG(relational_symbolic_index) AS mean_relational_symbolic_index,
    AVG(ego_regulation_index) AS mean_ego_regulation_index,
    AVG(risk_index) AS mean_risk_index
FROM childhood_development_scores
GROUP BY time_period
ORDER BY time_period;
