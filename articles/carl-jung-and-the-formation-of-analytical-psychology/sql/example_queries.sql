-- Example queries for the synthetic Jung concept-history schema.

SELECT
    domain,
    period,
    concept_count
FROM domain_concept_counts
ORDER BY domain, period;

SELECT
    source,
    target,
    weight,
    phase,
    relation_strength_label,
    notes
FROM concept_edge_strength
ORDER BY weight DESC, source, target;

SELECT
    phase,
    edge_count,
    mean_edge_weight,
    max_edge_weight
FROM phase_edge_summary
ORDER BY phase;

SELECT
    concept,
    period,
    domain,
    description,
    interpretive_caution
FROM jung_concepts
ORDER BY period, domain, concept;

SELECT
    phase,
    clinical,
    experimental,
    symbolic,
    developmental,
    comparative,
    religion,
    method,
    critical_revision
FROM jung_period_weights
ORDER BY phase;
