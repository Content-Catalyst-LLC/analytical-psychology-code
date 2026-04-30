-- Root schema for analytical psychology, symbolic process,
-- dream coding, psychic integration, and interpretive workflow data.
-- Educational only. Not a clinical, diagnostic, or therapeutic tool.

CREATE TABLE IF NOT EXISTS analytic_units (
    unit_id TEXT PRIMARY KEY,
    unit_type TEXT,
    context_label TEXT,
    cultural_context TEXT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS symbolic_observations (
    observation_id INTEGER PRIMARY KEY,
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    symbolic_access REAL,
    ego_differentiation REAL,
    affective_containment REAL,
    relational_depth REAL,
    transformative_processing REAL,
    cultural_mediation REAL,
    fragmentation_pressure REAL,
    psychic_integration REAL,
    high_transformation INTEGER,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dream_symbol_codes (
    code_id INTEGER PRIMARY KEY,
    unit_id TEXT NOT NULL,
    dream_id TEXT,
    symbol_label TEXT,
    affective_charge REAL,
    recurrence_count INTEGER,
    interpretive_openness REAL,
    cultural_mediation_note TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS interpretive_notes (
    note_id INTEGER PRIMARY KEY,
    unit_id TEXT NOT NULL,
    note_type TEXT,
    symbolic_theme TEXT,
    evidence_level TEXT,
    interpretation_text TEXT,
    caution_text TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
