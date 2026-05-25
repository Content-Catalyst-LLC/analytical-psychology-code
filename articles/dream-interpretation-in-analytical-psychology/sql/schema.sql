-- ============================================================
-- Dream Interpretation in Analytical Psychology
-- SQL schema for synthetic dream-series and motif modeling
-- ============================================================

CREATE TABLE IF NOT EXISTS synthetic_dreams (
    dream_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    phase TEXT NOT NULL,
    dream_series_type TEXT NOT NULL,
    text TEXT NOT NULL,
    responsible_use_note TEXT DEFAULT 'Synthetic educational data only; not for diagnosis, therapy, real dream interpretation, mental-health evaluation, crisis intervention, prediction, screening, surveillance, or individual evaluation.'
);

CREATE TABLE IF NOT EXISTS dream_symbol_motif_dictionary (
    motif TEXT NOT NULL,
    term TEXT NOT NULL,
    motif_family TEXT NOT NULL,
    notes TEXT,
    PRIMARY KEY (motif, term)
);

CREATE TABLE IF NOT EXISTS dream_motif_counts (
    dream_id INTEGER NOT NULL,
    motif TEXT NOT NULL,
    motif_family TEXT NOT NULL,
    count INTEGER NOT NULL,
    FOREIGN KEY (dream_id) REFERENCES synthetic_dreams(dream_id)
);

CREATE TABLE IF NOT EXISTS dream_symbol_network_edges (
    motif_a TEXT NOT NULL,
    motif_b TEXT NOT NULL,
    weight INTEGER NOT NULL,
    interpretation_note TEXT DEFAULT 'Edge weights indicate motif co-occurrence in synthetic dream texts; they do not prove meaning, archetypal status, diagnosis, or interpretation.'
);

CREATE TABLE IF NOT EXISTS dream_compensation_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    dream_series_type TEXT NOT NULL,
    conscious_onesidedness REAL NOT NULL,
    unconscious_pressure REAL NOT NULL,
    affective_intensity REAL NOT NULL,
    symbolic_repertoire REAL NOT NULL,
    latent_development REAL NOT NULL,
    reflective_capacity REAL NOT NULL,
    previous_dream_output REAL NOT NULL,
    compensatory_signal REAL NOT NULL,
    symbolic_recurrence REAL NOT NULL,
    dream_output REAL NOT NULL,
    integration_signal REAL NOT NULL
);

CREATE VIEW IF NOT EXISTS dream_compensation_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    dream_series_type,
    unconscious_pressure - conscious_onesidedness AS one_sidedness_gap,
    (
        0.72 * (unconscious_pressure - conscious_onesidedness) +
        0.42 * affective_intensity -
        0.20 * reflective_capacity
    ) AS compensatory_signal_model,
    (
        0.44 * previous_dream_output +
        0.36 * symbolic_repertoire +
        0.24 * latent_development
    ) AS symbolic_recurrence_model,
    (
        0.52 * compensatory_signal +
        0.48 * symbolic_recurrence +
        0.38 * affective_intensity +
        0.32 * latent_development
    ) AS dream_output_model,
    (
        0.42 * reflective_capacity +
        0.38 * latent_development +
        0.30 * symbolic_repertoire -
        0.24 * ABS(compensatory_signal)
    ) AS integration_signal_model,
    symbolic_recurrence - compensatory_signal AS recurrence_minus_compensation
FROM dream_compensation_panel;

CREATE VIEW IF NOT EXISTS dream_motif_family_summary AS
SELECT
    d.phase,
    d.dream_series_type,
    m.motif_family,
    SUM(m.count) AS total_count
FROM dream_motif_counts m
JOIN synthetic_dreams d
    ON m.dream_id = d.dream_id
GROUP BY d.phase, d.dream_series_type, m.motif_family;
