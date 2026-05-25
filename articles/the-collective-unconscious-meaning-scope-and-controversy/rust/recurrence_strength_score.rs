fn recurrence_strength(
    cluster_stability: f64,
    weighted_cooccurrence: f64,
    cross_context_recurrence: f64,
    alternative_explanation_strength: f64,
) -> f64 {
    0.34 * cluster_stability
        + 0.30 * weighted_cooccurrence
        + 0.28 * cross_context_recurrence
        - 0.42 * alternative_explanation_strength
}

fn main() {
    let score = recurrence_strength(0.72, 0.66, 0.58, 0.44);
    println!("Synthetic recurrence strength after alternatives: {:.3}", score);
}
