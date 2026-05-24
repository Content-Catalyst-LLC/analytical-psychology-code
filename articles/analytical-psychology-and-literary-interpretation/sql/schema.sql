-- ============================================================
-- Analytical Psychology and Literary Interpretation
-- SQL schema for synthetic literary-symbol corpus modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS literary_texts (
    doc_id TEXT PRIMARY KEY,
    genre TEXT NOT NULL,
    period_label TEXT NOT NULL,
    author TEXT NOT NULL,
    title TEXT NOT NULL,
    text_excerpt TEXT NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for author diagnosis, automated interpretation, student evaluation, canon ranking, cultural ranking, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS motif_dictionary (
    motif TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS document_motif_counts (
    doc_id TEXT NOT NULL,
    motif TEXT NOT NULL,
    count INTEGER NOT NULL,
    total_tokens INTEGER NOT NULL,
    PRIMARY KEY (doc_id, motif),
    FOREIGN KEY (doc_id) REFERENCES literary_texts(doc_id),
    FOREIGN KEY (motif) REFERENCES motif_dictionary(motif)
);

CREATE TABLE IF NOT EXISTS motif_cooccurrence_edges (
    source_motif TEXT NOT NULL,
    target_motif TEXT NOT NULL,
    weight INTEGER NOT NULL,
    PRIMARY KEY (source_motif, target_motif),
    FOREIGN KEY (source_motif) REFERENCES motif_dictionary(motif),
    FOREIGN KEY (target_motif) REFERENCES motif_dictionary(motif)
);

CREATE VIEW IF NOT EXISTS document_symbolic_density AS
SELECT
    l.doc_id,
    l.title,
    l.author,
    l.genre,
    l.period_label,
    SUM(d.count) AS total_motifs,
    MAX(d.total_tokens) AS total_tokens,
    CAST(SUM(d.count) AS REAL) / NULLIF(MAX(d.total_tokens), 0) AS symbolic_density
FROM literary_texts l
JOIN document_motif_counts d
    ON l.doc_id = d.doc_id
GROUP BY
    l.doc_id,
    l.title,
    l.author,
    l.genre,
    l.period_label;

CREATE VIEW IF NOT EXISTS motif_cluster_summary AS
SELECT
    m.cluster,
    SUM(d.count) AS total_count,
    COUNT(DISTINCT d.doc_id) AS document_count
FROM document_motif_counts d
JOIN motif_dictionary m
    ON d.motif = m.motif
GROUP BY m.cluster;
