-- Example queries for the synthetic depth-psychology comparison schema.

SELECT
    case_type,
    AVG(freudian_score) AS mean_freudian,
    AVG(jungian_score) AS mean_jungian,
    AVG(integrative_depth_score) AS mean_integrative_depth
FROM depth_psychology_scores
GROUP BY case_type
ORDER BY mean_integrative_depth DESC;

SELECT
    case_type,
    freudian_score,
    jungian_score,
    integrative_depth_score,
    jungian_score - freudian_score AS jungian_minus_freudian
FROM depth_psychology_scores
ORDER BY ABS(jungian_score - freudian_score) DESC;
