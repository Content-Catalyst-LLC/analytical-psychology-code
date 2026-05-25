fn compensation_strain(
    dominant_strength: f64,
    inferior_strength: f64,
    function_variance: f64,
    unconscious_pressure: f64,
    reflective_capacity: f64,
) -> f64 {
    let gap = dominant_strength - inferior_strength;
    0.70 * gap
        + 0.55 * function_variance
        + 0.45 * unconscious_pressure
        - 0.28 * reflective_capacity
}

fn developmental_integration(
    inferior_strength: f64,
    symbolic_relation: f64,
    reflective_capacity: f64,
    function_variance: f64,
    strain: f64,
) -> f64 {
    0.42 * inferior_strength
        + 0.38 * symbolic_relation
        + 0.36 * reflective_capacity
        - 0.32 * function_variance
        - 0.26 * strain
}

fn main() {
    let strain = compensation_strain(0.92, 0.78, 0.004, 0.20, 0.86);
    let integration = developmental_integration(0.78, 0.84, 0.86, 0.004, strain);

    println!("Synthetic compensation strain: {:.3}", strain);
    println!("Synthetic developmental integration score: {:.3}", integration);
}
