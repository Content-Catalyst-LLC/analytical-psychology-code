-- Example queries for the synthetic collective-unconscious motif schema.

SELECT
    source_type,
    culture_group,
    motif,
    total_count
FROM motif_prevalence_by_context
ORDER BY total_count DESC, source_type, culture_group, motif;

SELECT
    source_type,
    culture_group,
    cluster,
    total_count
FROM motif_cluster_prevalence
ORDER BY total_count DESC, source_type, culture_group, cluster;

SELECT
    source_motif,
    target_motif,
    weight,
    recurrence_label
FROM motif_edge_strength
ORDER BY weight DESC, source_motif, target_motif;

SELECT
    motif,
    cluster,
    description,
    interpretive_caution
FROM motif_dictionary
ORDER BY cluster, motif;

SELECT
    hypothesis,
    description,
    evidence_needed,
    caution
FROM rival_explanations
ORDER BY hypothesis;
