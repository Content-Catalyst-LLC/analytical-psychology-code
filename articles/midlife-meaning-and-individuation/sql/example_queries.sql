-- Example queries for the synthetic midlife-transition schema.

SELECT
    midlife_pattern,
    AVG(meaning_coherence_model) AS mean_meaning_coherence_model,
    AVG(second_half_orientation_model) AS mean_second_half_orientation_model,
    AVG(transition_intensity) AS mean_transition_intensity,
    AVG(first_half_index) AS mean_first_half_index,
    AVG(second_half_index) AS mean_second_half_index
FROM midlife_transition_scores
GROUP BY midlife_pattern
ORDER BY mean_meaning_coherence_model DESC;

SELECT
    time_period,
    AVG(meaning_coherence_model) AS mean_meaning_coherence_model,
    AVG(second_half_orientation_model) AS mean_second_half_orientation_model,
    AVG(transition_intensity) AS mean_transition_intensity,
    AVG(first_half_index) AS mean_first_half_index,
    AVG(second_half_index) AS mean_second_half_index
FROM midlife_transition_scores
GROUP BY time_period
ORDER BY time_period;
