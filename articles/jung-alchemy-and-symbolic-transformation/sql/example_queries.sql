-- Example queries for the synthetic alchemical-stage schema.

SELECT
    symbolic_stage,
    AVG(transformation_score) AS mean_transformation,
    AVG(coniunctio_index) AS mean_coniunctio,
    AVG(vessel_failure_risk) AS mean_vessel_failure_risk,
    AVG(containment_minus_heat) AS mean_containment_minus_heat
FROM alchemical_transformation_scores
GROUP BY symbolic_stage
ORDER BY mean_transformation DESC;

SELECT
    symbolic_stage,
    transformation_score,
    coniunctio_index,
    vessel_failure_risk,
    transformation_score + coniunctio_index - vessel_failure_risk AS integration_readiness
FROM alchemical_transformation_scores
ORDER BY integration_readiness DESC;
