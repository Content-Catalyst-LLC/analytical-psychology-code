fn crisis_risk(
    numinous_intensity: f64,
    trauma_vulnerability: f64,
    practice_intensity: f64,
    sleep_disruption: f64,
    symbolic_containment: f64,
    ego_stability: f64,
    shadow_awareness: f64,
    relational_support: f64,
) -> f64 {
    0.75 * numinous_intensity
        + 0.45 * trauma_vulnerability
        + 0.35 * practice_intensity
        + 0.30 * sleep_disruption
        - 0.55 * symbolic_containment
        - 0.60 * ego_stability
        - 0.40 * shadow_awareness
        - 0.35 * relational_support
}

fn main() {
    let score = crisis_risk(0.88, 0.60, 0.78, 0.66, 0.42, 0.48, 0.42, 0.34);
    println!("Synthetic numinous crisis-risk score: {:.3}", score);
}
