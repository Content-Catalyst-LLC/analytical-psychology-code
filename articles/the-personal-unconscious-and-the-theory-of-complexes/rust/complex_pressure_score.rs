fn complex_pressure(
    complex_activation: f64,
    affect_intensity: f64,
    unresolved_affect: f64,
    projection_pressure: f64,
    transference_pressure: f64,
    regulation_capacity: f64,
    contextual_support: f64,
) -> f64 {
    complex_activation
        + affect_intensity
        + unresolved_affect
        + projection_pressure
        + transference_pressure
        - regulation_capacity
        - contextual_support
}

fn main() {
    let score = complex_pressure(0.86, 0.82, 0.72, 0.44, 0.50, 0.36, 0.30);
    println!("Synthetic complex pressure: {:.3}", score);
}
