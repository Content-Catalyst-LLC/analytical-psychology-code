-- ============================================================
-- Carl Jung and the Formation of Analytical Psychology
-- SQL schema for synthetic concept-history analysis
-- ============================================================

CREATE TABLE IF NOT EXISTS jung_concepts (
    concept TEXT PRIMARY KEY,
    period TEXT NOT NULL,
    domain TEXT NOT NULL,
    description TEXT NOT NULL,
    interpretive_caution TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS jung_concept_edges (
    source TEXT NOT NULL,
    target TEXT NOT NULL,
    weight REAL NOT NULL,
    phase TEXT NOT NULL,
    notes TEXT,
    FOREIGN KEY (source) REFERENCES jung_concepts(concept),
    FOREIGN KEY (target) REFERENCES jung_concepts(concept)
);

CREATE TABLE IF NOT EXISTS jung_period_weights (
    phase TEXT PRIMARY KEY,
    clinical REAL NOT NULL,
    experimental REAL NOT NULL,
    symbolic REAL NOT NULL,
    developmental REAL NOT NULL,
    comparative REAL NOT NULL,
    religion REAL NOT NULL,
    method REAL NOT NULL,
    critical_revision REAL NOT NULL
);

CREATE TABLE IF NOT EXISTS jung_publication_periods (
    period TEXT PRIMARY KEY,
    approx_year_range TEXT NOT NULL,
    orientation TEXT NOT NULL,
    representative_materials TEXT NOT NULL,
    notes TEXT
);

CREATE VIEW IF NOT EXISTS concept_edge_strength AS
SELECT
    source,
    target,
    weight,
    phase,
    notes,
    CASE
        WHEN weight >= 5 THEN 'very strong synthetic relation'
        WHEN weight = 4 THEN 'strong synthetic relation'
        WHEN weight = 3 THEN 'moderate synthetic relation'
        ELSE 'low synthetic relation'
    END AS relation_strength_label
FROM jung_concept_edges;

CREATE VIEW IF NOT EXISTS domain_concept_counts AS
SELECT
    domain,
    period,
    COUNT(*) AS concept_count
FROM jung_concepts
GROUP BY domain, period;

CREATE VIEW IF NOT EXISTS phase_edge_summary AS
SELECT
    phase,
    COUNT(*) AS edge_count,
    AVG(weight) AS mean_edge_weight,
    MAX(weight) AS max_edge_weight
FROM jung_concept_edges
GROUP BY phase;
