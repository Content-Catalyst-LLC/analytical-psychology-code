-- Example queries for the synthetic epistemic-warrant schema.

SELECT
    claim_type,
    AVG(credibility_score) AS mean_credibility,
    AVG(overreach_risk) AS mean_overreach_risk
FROM epistemic_warrant_scores
GROUP BY claim_type
ORDER BY mean_credibility DESC;

SELECT
    claim_type,
    credibility_score,
    overreach_risk
FROM epistemic_warrant_scores
WHERE overreach_risk > credibility_score
ORDER BY overreach_risk DESC;
