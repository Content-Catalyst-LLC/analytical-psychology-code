-- Example queries for the synthetic active imagination schema.

SELECT
    dialogue_mode,
    AVG(ego_mediation) AS mean_ego_mediation,
    AVG(imaginal_activation) AS mean_imaginal_activation,
    AVG(reflective_response) AS mean_reflective_response,
    AVG(symbolic_relation) AS mean_symbolic_relation,
    AVG(ethical_containment) AS mean_ethical_containment,
    AVG(destabilization_risk_model) AS mean_destabilization_risk_model,
    AVG(dialogue_quality_model) AS mean_dialogue_quality_model,
    AVG(integration_score_model) AS mean_integration_score_model
FROM active_imagination_dialogue_scores
GROUP BY dialogue_mode
ORDER BY mean_integration_score_model DESC;

SELECT
    time_period,
    AVG(ego_mediation) AS mean_ego_mediation,
    AVG(imaginal_activation) AS mean_imaginal_activation,
    AVG(ethical_containment) AS mean_ethical_containment,
    AVG(destabilization_risk_model) AS mean_destabilization_risk_model,
    AVG(dialogue_quality_model) AS mean_dialogue_quality_model,
    AVG(integration_score_model) AS mean_integration_score_model,
    AVG(integration_minus_risk) AS mean_integration_minus_risk
FROM active_imagination_dialogue_scores
GROUP BY time_period
ORDER BY time_period;
