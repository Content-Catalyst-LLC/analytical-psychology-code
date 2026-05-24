fn integration_score(
    numinous_intensity: f64,
    symbolic_containment: f64,
    ego_stability: f64,
    shadow_awareness: f64,
    ritual_support: f64,
    religious_trauma_pressure: f64,
) -> f64 {
    let containment_gap = numinous_intensity - symbolic_containment;
    0.60 * symbolic_containment
        + 0.55 * ego_stability
        + 0.48 * shadow_awareness
        + 0.42 * ritual_support
        + 0.36 * numinous_intensity
        - 0.65 * containment_gap * containment_gap
        - 0.30 * religious_trauma_pressure
}

fn main() {
    let score = integration_score(0.78, 0.82, 0.74, 0.66, 0.84, 0.22);
    println!("Synthetic religion/spiritual-experience integration score: {:.3}", score);
}
