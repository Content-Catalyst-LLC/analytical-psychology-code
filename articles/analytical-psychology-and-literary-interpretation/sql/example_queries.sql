-- Example queries for the synthetic literary-symbol schema.

SELECT
    genre,
    period_label,
    AVG(symbolic_density) AS mean_symbolic_density,
    SUM(total_motifs) AS total_motif_count
FROM document_symbolic_density
GROUP BY genre, period_label
ORDER BY mean_symbolic_density DESC;

SELECT
    cluster,
    total_count,
    document_count
FROM motif_cluster_summary
ORDER BY total_count DESC;

SELECT
    source_motif,
    target_motif,
    weight
FROM motif_cooccurrence_edges
ORDER BY weight DESC, source_motif, target_motif;
