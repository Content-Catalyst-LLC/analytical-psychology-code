-- ============================================================
-- Dreams, Compensation, and the Prospective Function
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

CREATE TABLE IF NOT EXISTS dream_motif_dictionary (
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

CREATE TABLE IF NOT EXISTS dream_dynamics_panel (
    case_id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    time_period INTEGER NOT NULL,
    dream_series_type TEXT NOT NULL,
    conscious_onesidedness REAL NOT NULL,
    unconscious_pressure REAL NOT NULL,
    affective_intensity REAL NOT NULL,
    latent_growth REAL NOT NULL,
    reflective_capacity REAL NOT NULL,
    symbolic_literacy REAL NOT NULL,
    previous_dream_output REAL NOT NULL,
    compensatory_intensity REAL NOT NULL,
    prospective_intensity REAL NOT NULL,
    dream_output REAL NOT NULL,
    integration_signal REAL NOT NULL
);

CREATE VIEW IF NOT EXISTS dream_dynamics_scores AS
SELECT
    case_id,
    person_id,
    time_period,
    dream_series_type,
    unconscious_pressure - conscious_onesidedness AS one_sidedness_gap,
    (
        0.72 * (unconscious_pressure - conscious_onesidedness) +
        0.36 * affective_intensity -
        0.22 * reflective_capacity
    ) AS compensatory_intensity_model,
    (
        0.64 * latent_growth +
        0.28 * symbolic_literacy +
        0.22 * reflective_capacity +
        0.18 * previous_dream_output
    ) AS prospective_intensity_model,
    (
        0.55 * compensatory_intensity +
        0.52 * prospective_intensity +
        0.40 * affective_intensity +
        0.32 * previous_dream_output
    ) AS dream_output_model,
    (
        0.44 * prospective_intensity +
        0.36 * reflective_capacity +
        0.30 * symbolic_literacy -
        0.24 * ABS(compensatory_intensity)
    ) AS integration_signal_model,
    prospective_intensity - compensatory_intensity AS prospective_minus_compensatory
FROM dream_dynamics_panel;

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
