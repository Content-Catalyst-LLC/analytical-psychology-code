fn compensatory_pressure(
    conscious_onesidedness: f64,
    complex_activation: f64,
    trauma_fragmentation: f64,
    ego_integration: f64,
    shadow_awareness: f64,
) -> f64 {
    0.62 * conscious_onesidedness
        + 0.58 * complex_activation
        + 0.34 * trauma_fragmentation
        - 0.52 * ego_integration
        - 0.26 * shadow_awareness
}

fn clinical_functioning(
    symptom_burden: f64,
    ego_integration: f64,
    symbolic_capacity: f64,
    relational_safety: f64,
    affect_regulation: f64,
    compensatory: f64,
    shadow_awareness: f64,
) -> f64 {
    -0.70 * symptom_burden
        + 0.60 * ego_integration
        + 0.52 * symbolic_capacity
        + 0.64 * relational_safety
        - 0.42 * compensatory
        + 0.28 * affect_regulation
        + 0.24 * shadow_awareness
}

fn main() {
    let pressure = compensatory_pressure(0.36, 0.42, 0.24, 0.80, 0.80);
    let score = clinical_functioning(0.38, 0.80, 0.76, 0.82, 0.78, pressure, 0.80);

    println!("Synthetic compensatory pressure: {:.3}", pressure);
    println!("Synthetic clinical-functioning score: {:.3}", score);
}
