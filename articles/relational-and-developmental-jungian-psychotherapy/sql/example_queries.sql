-- Example queries for the synthetic relational Jungian therapy schema.

SELECT
    clinical_presentation,
    AVG(developmental_integration) AS mean_developmental_integration,
    AVG(symbolic_growth) AS mean_symbolic_growth,
    AVG(rupture_risk) AS mean_rupture_risk,
    AVG(relational_capacity_index) AS mean_relational_capacity,
    AVG(symbolic_capacity_index) AS mean_symbolic_capacity,
    AVG(risk_index) AS mean_risk
FROM relational_jungian_therapy_scores
GROUP BY clinical_presentation
ORDER BY mean_developmental_integration DESC;

SELECT
    session_number,
    AVG(developmental_integration) AS mean_developmental_integration,
    AVG(symbolic_growth) AS mean_symbolic_growth,
    AVG(rupture_risk) AS mean_rupture_risk,
    AVG(risk_index) AS mean_risk
FROM relational_jungian_therapy_scores
GROUP BY session_number
ORDER BY session_number;
