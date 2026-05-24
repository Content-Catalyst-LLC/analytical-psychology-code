-- Example queries for the synthetic Jungian critique schema.

SELECT
    concept_family,
    AVG(credibility_score) AS mean_credibility,
    AVG(overgeneralization_risk) AS mean_overgeneralization_risk,
    AVG(retained_value_after_critique) AS mean_retained_value
FROM jungian_critique_scores
GROUP BY concept_family
ORDER BY mean_retained_value DESC;

SELECT
    concept_family,
    credibility_score,
    overgeneralization_risk,
    retained_value_after_critique
FROM jungian_critique_scores
WHERE overgeneralization_risk > credibility_score
ORDER BY overgeneralization_risk DESC;
