-- Example queries for the symbolic corpus schema.

SELECT
    source_type,
    culture_group,
    motif,
    cluster,
    SUM(total_count) AS motif_total
FROM motif_context_summary
GROUP BY source_type, culture_group, motif, cluster
ORDER BY source_type, motif_total DESC;

SELECT
    motif,
    cluster,
    SUM(total_count) AS total_count
FROM motif_context_summary
GROUP BY motif, cluster
ORDER BY total_count DESC;

SELECT
    motif,
    cluster,
    political_count
FROM political_myth_summary;

SELECT
    motif_a,
    motif_b,
    weight
FROM motif_cooccurrence_edges
ORDER BY weight DESC;
