-- Example queries for the synthetic symbolic-comparison schema.

SELECT
    tradition_layer,
    AVG(comparative_quality) AS mean_comparative_quality,
    AVG(flattening_risk) AS mean_flattening_risk,
    AVG(equivalence_claim_strength) AS mean_equivalence_claim_strength
FROM symbolic_comparison_scores
GROUP BY tradition_layer
ORDER BY mean_comparative_quality DESC;

SELECT
    tradition_layer,
    comparative_quality,
    flattening_risk,
    equivalence_claim_strength
FROM symbolic_comparison_scores
WHERE flattening_risk > comparative_quality
ORDER BY flattening_risk DESC;
