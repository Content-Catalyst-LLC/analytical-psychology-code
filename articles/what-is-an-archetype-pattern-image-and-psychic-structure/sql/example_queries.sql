SELECT source_type, culture_group, motif, total_count
FROM motif_prevalence_by_context
ORDER BY total_count DESC, source_type, culture_group, motif;

SELECT source_type, culture_group, cluster, total_count
FROM motif_cluster_prevalence
ORDER BY total_count DESC, source_type, culture_group, cluster;

SELECT motif, cluster, description, interpretive_caution
FROM motif_dictionary
ORDER BY cluster, motif;
