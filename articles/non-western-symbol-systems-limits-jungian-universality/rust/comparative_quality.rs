fn comparative_quality(
    recurrence: f64,
    specificity: f64,
    linguistic_depth: f64,
    ritual_context: f64,
    dialogical_accountability: f64,
    universalizing_force: f64,
    abstraction_pressure: f64,
) -> f64 {
    0.52 * recurrence
        + 0.68 * specificity
        + 0.58 * linguistic_depth
        + 0.54 * ritual_context
        + 0.62 * dialogical_accountability
        - 0.66 * universalizing_force
        - 0.42 * abstraction_pressure
}

fn main() {
    let score = comparative_quality(0.76, 0.84, 0.79, 0.87, 0.77, 0.27, 0.30);
    println!("Synthetic comparative-quality score: {:.3}", score);
}
