SELECT
    symbolic_pattern,
    mean_unrealized_capacity,
    mean_affective_charge,
    mean_reflective_mediation,
    mean_gender_code_rigidity,
    mean_symbolic_flexibility,
    mean_projection_intensity,
    mean_projection_rigidity,
    mean_symbolic_integration
FROM symbolic_pattern_summary
ORDER BY mean_symbolic_integration DESC;

SELECT
    time_period,
    AVG(projection_intensity_model) AS mean_projection_intensity_model,
    AVG(projection_rigidity_model) AS mean_projection_rigidity_model,
    AVG(symbolic_integration_model) AS mean_symbolic_integration_model,
    AVG(coding_flexibility_gap) AS mean_coding_flexibility_gap
FROM symbolic_otherness_scores
GROUP BY time_period
ORDER BY time_period;

SELECT source, target, weight, notes
FROM symbolic_otherness_edges
ORDER BY ABS(weight) DESC;
