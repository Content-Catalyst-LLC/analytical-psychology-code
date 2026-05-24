-- Example queries for the synthetic archetypal-depth schema.

SELECT
    presentation_type,
    AVG(archetypal_depth) AS mean_archetypal_depth,
    AVG(aesthetic_richness) AS mean_aesthetic_richness,
    AVG(flattening_risk) AS mean_flattening_risk
FROM archetypal_depth_scores
GROUP BY presentation_type
ORDER BY mean_archetypal_depth DESC;

SELECT
    presentation_type,
    archetypal_depth,
    aesthetic_richness,
    flattening_risk,
    archetypal_depth - flattening_risk AS depth_minus_risk
FROM archetypal_depth_scores
ORDER BY depth_minus_risk DESC;
