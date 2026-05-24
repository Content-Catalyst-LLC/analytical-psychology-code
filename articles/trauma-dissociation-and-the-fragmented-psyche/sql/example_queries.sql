-- Example queries for the synthetic trauma-and-dissociation schema.

SELECT
    trauma_pattern,
    AVG(integration_potential) AS mean_integration_potential,
    AVG(dissociation_model) AS mean_dissociation_model,
    AVG(symbolic_recovery_model) AS mean_symbolic_recovery_model,
    AVG(fragmentation_index) AS mean_fragmentation,
    AVG(recovery_capacity_index) AS mean_recovery_capacity
FROM trauma_dissociation_scores
GROUP BY trauma_pattern
ORDER BY mean_integration_potential DESC;

SELECT
    time_period,
    AVG(integration_potential) AS mean_integration_potential,
    AVG(dissociation_model) AS mean_dissociation_model,
    AVG(symbolic_recovery_model) AS mean_symbolic_recovery_model,
    AVG(fragmentation_index) AS mean_fragmentation,
    AVG(recovery_capacity_index) AS mean_recovery_capacity
FROM trauma_dissociation_scores
GROUP BY time_period
ORDER BY time_period;
