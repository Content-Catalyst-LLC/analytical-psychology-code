fn developmental_integration(
    relational_safety: f64,
    attachment_security: f64,
    affect_regulation: f64,
    repair_capacity: f64,
    embodied_safety: f64,
    symbolic_capacity: f64,
    reflective_self: f64,
    fragmentation: f64,
    shame_load: f64,
    rupture_intensity: f64,
) -> f64 {
    0.62 * relational_safety
        + 0.42 * attachment_security
        + 0.55 * affect_regulation
        + 0.46 * repair_capacity
        + 0.36 * embodied_safety
        + 0.58 * symbolic_capacity
        + 0.44 * reflective_self
        - 0.58 * fragmentation
        - 0.38 * shame_load
        - 0.28 * rupture_intensity
}

fn main() {
    let score = developmental_integration(
        0.82, 0.74, 0.74, 0.78, 0.74, 0.76, 0.78, 0.32, 0.42, 0.26,
    );
    println!("Synthetic developmental integration score: {:.3}", score);
}
