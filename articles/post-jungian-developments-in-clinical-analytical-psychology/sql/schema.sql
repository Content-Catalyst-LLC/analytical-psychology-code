-- Article-level synthetic analytical psychology schema.
-- Educational only. Not clinical, diagnostic, or therapeutic.

CREATE TABLE IF NOT EXISTS symbolic_observations (
    observation_id INTEGER PRIMARY KEY,
    person_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    cultural_mediation REAL,
    psyche_score REAL,
    symbolic_access REAL,
    ego_differentiation REAL,
    affective_containment REAL,
    relational_depth REAL,
    transformative_processing REAL,
    fragmentation_pressure REAL,
    high_psychic_integration INTEGER
);

CREATE TABLE IF NOT EXISTS dream_symbol_codes (
    code_id INTEGER PRIMARY KEY,
    person_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    symbol_label TEXT,
    affective_charge REAL,
    recurrence_count INTEGER,
    interpretive_openness REAL
);

CREATE INDEX IF NOT EXISTS idx_symbolic_obs_person
ON symbolic_observations(person_id);

CREATE INDEX IF NOT EXISTS idx_symbolic_obs_period
ON symbolic_observations(period);

CREATE INDEX IF NOT EXISTS idx_dream_codes_person
ON dream_symbol_codes(person_id);

CREATE INDEX IF NOT EXISTS idx_dream_codes_symbol
ON dream_symbol_codes(symbol_label);
