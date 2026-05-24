-- Example queries for the synthetic numinous-crisis schema.

SELECT
    symbolic_environment,
    AVG(crisis_risk) AS mean_crisis_risk,
    AVG(inflation_risk) AS mean_inflation_risk,
    AVG(integration_potential) AS mean_integration_potential,
    AVG(containment_index) AS mean_containment_index,
    AVG(vulnerability_index) AS mean_vulnerability_index
FROM numinous_crisis_scores
GROUP BY symbolic_environment
ORDER BY mean_integration_potential DESC;

SELECT
    symbolic_environment,
    crisis_risk,
    inflation_risk,
    integration_potential,
    containment_index,
    vulnerability_index
FROM numinous_crisis_scores
ORDER BY crisis_risk DESC;
