fn compensation_pressure(
    conscious_one_sidedness: f64,
    unconscious_activation: f64,
    symbolic_intensity: f64,
    regulatory_capacity: f64,
) -> f64 {
    conscious_one_sidedness
        + unconscious_activation
        + symbolic_intensity
        - regulatory_capacity
}

fn main() {
    let score = compensation_pressure(0.82, 0.74, 0.68, 0.36);
    println!("Synthetic compensation pressure: {:.3}", score);
}
