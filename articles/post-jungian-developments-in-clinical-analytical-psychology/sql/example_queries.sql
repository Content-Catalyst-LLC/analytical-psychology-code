-- Example queries for the synthetic post-Jungian clinical schema.

SELECT
    school_tendency,
    AVG(clinical_adequacy) AS mean_clinical_adequacy,
    AVG(symbolic_readiness) AS mean_symbolic_readiness,
    AVG(balance_index) AS mean_balance_index,
    AVG(symbolic_depth) AS mean_symbolic_depth,
    AVG(clinical_refinement_mean) AS mean_clinical_refinement
FROM post_jungian_clinical_scores
GROUP BY school_tendency
ORDER BY mean_clinical_adequacy DESC;

SELECT
    school_tendency,
    clinical_adequacy,
    symbolic_readiness,
    balance_index,
    clinical_refinement_mean,
    symbolic_depth - clinical_refinement_mean AS symbolic_depth_minus_refinement
FROM post_jungian_clinical_scores
ORDER BY ABS(symbolic_depth - clinical_refinement_mean) DESC;
