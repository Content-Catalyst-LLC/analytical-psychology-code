fn totality_score(
    ego_coherence: f64,
    unconscious_activation: f64,
    symbolic_center_strength: f64,
    relational_coordination: f64,
    disjunction: f64,
    inflation_risk: f64,
) -> f64 {
    0.48 * ego_coherence
        + 0.36 * unconscious_activation
        + 0.58 * symbolic_center_strength
        + 0.54 * relational_coordination
        - 0.46 * disjunction
        - 0.30 * inflation_risk.max(0.0)
}

fn self_relation_index(
    totality: f64,
    differentiation: f64,
    symbolic_center_strength: f64,
    inflation_risk: f64,
) -> f64 {
    0.40 * totality
        + 0.34 * differentiation
        + 0.28 * symbolic_center_strength
        - 0.30 * inflation_risk.max(0.0)
}

fn main() {
    let totality = totality_score(0.74, 0.66, 0.82, 0.76, 0.28, 0.18);
    let self_relation = self_relation_index(totality, 0.80, 0.82, 0.18);

    println!("Synthetic totality score: {:.3}", totality);
    println!("Synthetic Self-relation index: {:.3}", self_relation);
}
