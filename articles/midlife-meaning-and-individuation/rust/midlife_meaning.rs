fn meaning_coherence(
    adaptation_strength: f64,
    symbolic_activation: f64,
    individuation_pressure: f64,
    shadow_integration: f64,
    reflective_capacity: f64,
    outward_inward_discrepancy: f64,
) -> f64 {
    0.40 * adaptation_strength
        + 0.58 * symbolic_activation
        + 0.62 * individuation_pressure
        + 0.42 * shadow_integration
        + 0.36 * reflective_capacity
        - 0.72 * outward_inward_discrepancy
}

fn main() {
    let score = meaning_coherence(0.54, 0.90, 0.88, 0.86, 0.86, 0.28);
    println!("Synthetic midlife meaning coherence score: {:.3}", score);
}
