fn recurrence_pressure(
    complex_activation: f64,
    affect_intensity: f64,
    projection_pressure: f64,
    transference_pressure: f64,
    regulation_capacity: f64,
    relational_buffer: f64,
) -> f64 {
    complex_activation
        + affect_intensity
        + projection_pressure
        + transference_pressure
        - regulation_capacity
        - relational_buffer
}

fn main() {
    let score = recurrence_pressure(0.86, 0.82, 0.44, 0.50, 0.36, 0.30);
    println!("Synthetic recurrence pressure: {:.3}", score);
}
