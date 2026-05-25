-- Example queries for the synthetic complex-activation schema.

SELECT
    complex_type,
    mean_trigger_intensity,
    mean_relational_threat,
    mean_evaluation_pressure,
    mean_shame_cue,
    mean_affect_intensity,
    mean_complex_activation,
    mean_repetition_probability,
    mean_projection_pressure,
    mean_transference_pressure,
    mean_regulation_capacity,
    mean_relational_buffer
FROM complex_type_summary
ORDER BY mean_repetition_probability DESC;

SELECT
    complex_type,
    symbolic_repetition,
    COUNT(*) AS symbolic_count
FROM complex_activation_panel
GROUP BY complex_type, symbolic_repetition
ORDER BY complex_type, symbolic_count DESC;

SELECT
    case_id,
    person_id,
    time_period,
    complex_type,
    recurrence_pressure,
    recovery_potential
FROM complex_activation_scores
ORDER BY recurrence_pressure DESC;

SELECT
    source,
    target,
    weight,
    notes
FROM complex_network_edges
ORDER BY ABS(weight) DESC;
