-- Example queries for the synthetic dream-interpretation schema.

SELECT
    dream_series_type,
    AVG(conscious_onesidedness) AS mean_conscious_onesidedness,
    AVG(unconscious_pressure) AS mean_unconscious_pressure,
    AVG(compensatory_signal_model) AS mean_compensatory_signal_model,
    AVG(symbolic_recurrence_model) AS mean_symbolic_recurrence_model,
    AVG(dream_output_model) AS mean_dream_output_model,
    AVG(integration_signal_model) AS mean_integration_signal_model
FROM dream_compensation_scores
GROUP BY dream_series_type
ORDER BY mean_integration_signal_model DESC;

SELECT
    time_period,
    AVG(compensatory_signal_model) AS mean_compensatory_signal_model,
    AVG(symbolic_recurrence_model) AS mean_symbolic_recurrence_model,
    AVG(integration_signal_model) AS mean_integration_signal_model
FROM dream_compensation_scores
GROUP BY time_period
ORDER BY time_period;

SELECT
    phase,
    dream_series_type,
    motif_family,
    total_count
FROM dream_motif_family_summary
ORDER BY dream_series_type, phase, motif_family;

SELECT
    motif_a,
    motif_b,
    weight
FROM dream_symbol_network_edges
ORDER BY weight DESC;
