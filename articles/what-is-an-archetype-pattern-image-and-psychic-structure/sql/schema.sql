-- SQL schema for synthetic archetypal motif analysis.

CREATE TABLE IF NOT EXISTS archetypal_documents (
    doc_id TEXT PRIMARY KEY,
    source_type TEXT NOT NULL,
    culture_group TEXT NOT NULL,
    text TEXT NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational text only; not for diagnosis, therapy, private dream interpretation, religious reductionism, cultural extraction, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS motif_dictionary (
    motif TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    description TEXT NOT NULL,
    interpretive_caution TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS motif_counts (
    doc_id TEXT NOT NULL,
    motif TEXT NOT NULL,
    count INTEGER NOT NULL,
    FOREIGN KEY (doc_id) REFERENCES archetypal_documents(doc_id),
    FOREIGN KEY (motif) REFERENCES motif_dictionary(motif)
);

CREATE TABLE IF NOT EXISTS motif_cooccurrence_edges (
    source_motif TEXT NOT NULL,
    target_motif TEXT NOT NULL,
    weight REAL NOT NULL,
    FOREIGN KEY (source_motif) REFERENCES motif_dictionary(motif),
    FOREIGN KEY (target_motif) REFERENCES motif_dictionary(motif)
);

CREATE VIEW IF NOT EXISTS motif_prevalence_by_context AS
SELECT
    d.source_type,
    d.culture_group,
    c.motif,
    SUM(c.count) AS total_count
FROM motif_counts c
JOIN archetypal_documents d ON c.doc_id = d.doc_id
GROUP BY d.source_type, d.culture_group, c.motif;

CREATE VIEW IF NOT EXISTS motif_cluster_prevalence AS
SELECT
    d.source_type,
    d.culture_group,
    m.cluster,
    SUM(c.count) AS total_count
FROM motif_counts c
JOIN archetypal_documents d ON c.doc_id = d.doc_id
JOIN motif_dictionary m ON c.motif = m.motif
GROUP BY d.source_type, d.culture_group, m.cluster;
