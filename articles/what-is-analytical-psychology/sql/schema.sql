-- ============================================================
-- What Is Analytical Psychology?
-- SQL schema for synthetic symbolic-corpus analysis
-- ============================================================

CREATE TABLE IF NOT EXISTS symbolic_documents (
    document_id TEXT PRIMARY KEY,
    source_type TEXT NOT NULL,
    phase TEXT NOT NULL,
    text TEXT NOT NULL,
    interpretive_note TEXT,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, private dream interpretation, employment screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS symbol_dictionary (
    symbol TEXT PRIMARY KEY,
    cluster TEXT NOT NULL,
    description TEXT NOT NULL,
    interpretive_caution TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS analytical_psychology_concepts (
    concept TEXT PRIMARY KEY,
    domain TEXT NOT NULL,
    definition TEXT NOT NULL,
    responsible_use_note TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS symbol_document_membership (
    document_id TEXT NOT NULL,
    symbol TEXT NOT NULL,
    count INTEGER DEFAULT 1,
    FOREIGN KEY (document_id) REFERENCES symbolic_documents(document_id),
    FOREIGN KEY (symbol) REFERENCES symbol_dictionary(symbol)
);

CREATE TABLE IF NOT EXISTS symbol_cooccurrence_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight INTEGER NOT NULL,
    FOREIGN KEY (source) REFERENCES symbol_dictionary(symbol),
    FOREIGN KEY (target) REFERENCES symbol_dictionary(symbol)
);

CREATE VIEW IF NOT EXISTS symbol_cluster_counts AS
SELECT
    sd.cluster,
    COUNT(DISTINCT sdm.symbol) AS unique_symbols,
    SUM(sdm.count) AS total_symbol_mentions
FROM symbol_document_membership sdm
JOIN symbol_dictionary sd
    ON sdm.symbol = sd.symbol
GROUP BY sd.cluster;

CREATE VIEW IF NOT EXISTS source_symbol_summary AS
SELECT
    d.source_type,
    sd.cluster,
    sdm.symbol,
    SUM(sdm.count) AS total_mentions
FROM symbol_document_membership sdm
JOIN symbolic_documents d
    ON sdm.document_id = d.document_id
JOIN symbol_dictionary sd
    ON sdm.symbol = sd.symbol
GROUP BY d.source_type, sd.cluster, sdm.symbol;

CREATE VIEW IF NOT EXISTS concept_domain_counts AS
SELECT
    domain,
    COUNT(*) AS concept_count
FROM analytical_psychology_concepts
GROUP BY domain;
