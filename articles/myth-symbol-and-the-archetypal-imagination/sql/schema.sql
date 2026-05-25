-- ============================================================
-- Myth, Symbol, and the Archetypal Imagination
-- SQL schema for symbolic-corpus and motif-network modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS symbolic_corpus_documents (
    doc_id INTEGER PRIMARY KEY,
    source_type TEXT NOT NULL,
    culture_group TEXT NOT NULL,
    time_period TEXT NOT NULL,
    title TEXT NOT NULL,
    text TEXT NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic or public-domain demonstration data only; not for proving archetypes, interpreting private dreams, classifying religions, ranking cultures, or replacing historical and cultural expertise.'
);

CREATE TABLE IF NOT EXISTS motif_dictionary (
    motif TEXT NOT NULL,
    term TEXT NOT NULL,
    cluster TEXT NOT NULL,
    notes TEXT,
    PRIMARY KEY (motif, term)
);

CREATE TABLE IF NOT EXISTS motif_document_counts (
    doc_id INTEGER NOT NULL,
    motif TEXT NOT NULL,
    cluster TEXT NOT NULL,
    count INTEGER NOT NULL,
    FOREIGN KEY (doc_id) REFERENCES symbolic_corpus_documents(doc_id)
);

CREATE TABLE IF NOT EXISTS motif_cooccurrence_edges (
    motif_a TEXT NOT NULL,
    motif_b TEXT NOT NULL,
    weight INTEGER NOT NULL,
    interpretation_note TEXT DEFAULT 'Edge weights indicate motif co-occurrence in this demonstration corpus; they do not prove shared meaning or archetypal equivalence.'
);

CREATE VIEW IF NOT EXISTS motif_context_summary AS
SELECT
    d.source_type,
    d.culture_group,
    d.time_period,
    m.motif,
    m.cluster,
    SUM(m.count) AS total_count
FROM motif_document_counts m
JOIN symbolic_corpus_documents d
    ON m.doc_id = d.doc_id
GROUP BY
    d.source_type,
    d.culture_group,
    d.time_period,
    m.motif,
    m.cluster;

CREATE VIEW IF NOT EXISTS political_myth_summary AS
SELECT
    m.motif,
    m.cluster,
    SUM(m.count) AS political_count
FROM motif_document_counts m
JOIN symbolic_corpus_documents d
    ON m.doc_id = d.doc_id
WHERE d.source_type LIKE '%political%'
GROUP BY m.motif, m.cluster
ORDER BY political_count DESC;
