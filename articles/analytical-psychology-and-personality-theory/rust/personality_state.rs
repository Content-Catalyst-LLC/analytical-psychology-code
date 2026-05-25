fn one_sidedness(
    conscious_orientation: f64,
    shadow_acknowledgment: f64,
    persona_identification: f64,
    typological_flexibility: f64,
    complex_activation: f64,
    symbolic_relation: f64,
) -> f64 {
    let a = conscious_orientation - shadow_acknowledgment;
    let b = persona_identification - typological_flexibility;
    let c = complex_activation - symbolic_relation;
    a * a + b * b + c * c
}

fn personality_state(
    conscious_orientation: f64,
    persona_identification: f64,
    symbolic_relation: f64,
    shadow_acknowledgment: f64,
    developmental_integration: f64,
    complex_activation: f64,
    unconscious_compensation: f64,
) -> f64 {
    0.44 * conscious_orientation
        + 0.36 * persona_identification
        + 0.42 * symbolic_relation
        + 0.32 * shadow_acknowledgment
        + 0.54 * developmental_integration
        - 0.34 * complex_activation.abs()
        + 0.20 * unconscious_compensation
}

fn main() {
    let w = one_sidedness(0.88, 0.86, 0.28, 0.90, 0.18, 0.96);
    let score = personality_state(0.88, 0.28, 0.96, 0.86, 0.98, 0.18, 0.18);

    println!("Synthetic one-sidedness: {:.3}", w);
    println!("Synthetic Jungian personality-state score: {:.3}", score);
}
