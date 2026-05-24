-- Example queries for the synthetic religion-and-spiritual-experience schema.

SELECT
    religious_environment,
    AVG(integration) AS mean_integration,
    AVG(inflation_risk) AS mean_inflation_risk,
    AVG(living_symbol_score) AS mean_living_symbol_score,
    AVG(containment_index) AS mean_containment_index,
    AVG(symbolic_risk_index) AS mean_symbolic_risk_index
FROM religion_spiritual_experience_scores
GROUP BY religious_environment
ORDER BY mean_integration DESC;

SELECT
    religious_environment,
    integration,
    inflation_risk,
    living_symbol_score,
    containment_index,
    symbolic_risk_index
FROM religion_spiritual_experience_scores
ORDER BY inflation_risk DESC;
