-- Example queries for the synthetic analytical psychology symbolic-corpus schema.

SELECT
    cluster,
    unique_symbols,
    total_symbol_mentions
FROM symbol_cluster_counts
ORDER BY total_symbol_mentions DESC;

SELECT
    source_type,
    cluster,
    symbol,
    total_mentions
FROM source_symbol_summary
ORDER BY source_type, total_mentions DESC;

SELECT
    source,
    target,
    weight
FROM symbol_cooccurrence_edges
ORDER BY weight DESC, source, target;

SELECT
    domain,
    concept_count
FROM concept_domain_counts
ORDER BY concept_count DESC;

SELECT
    concept,
    domain,
    definition,
    responsible_use_note
FROM analytical_psychology_concepts
ORDER BY domain, concept;
