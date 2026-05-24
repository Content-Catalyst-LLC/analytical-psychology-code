-- Example queries for the synthetic analytical psychology clinical-practice schema.

SELECT
    clinical_presentation,
    AVG(clinical_functioning) AS mean_clinical_functioning,
    AVG(symbolic_growth) AS mean_symbolic_growth,
    AVG(compensatory_pressure) AS mean_compensatory_pressure,
    AVG(capacity_index) AS mean_capacity,
    AVG(risk_index) AS mean_risk,
    AVG(symbolic_index) AS mean_symbolic_index
FROM clinical_practice_scores
GROUP BY clinical_presentation
ORDER BY mean_clinical_functioning DESC;

SELECT
    session_number,
    AVG(clinical_functioning) AS mean_clinical_functioning,
    AVG(symbolic_growth) AS mean_symbolic_growth,
    AVG(compensatory_pressure) AS mean_compensatory_pressure,
    AVG(risk_index) AS mean_risk
FROM clinical_practice_scores
GROUP BY session_number
ORDER BY session_number;
