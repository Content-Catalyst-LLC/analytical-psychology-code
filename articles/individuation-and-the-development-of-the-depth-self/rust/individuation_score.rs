fn one_sidedness(
    ego_coherence: f64,
    shadow_acknowledgment: f64,
    symbolic_relation: f64,
    complex_activation: f64,
    persona_identification: f64,
    reflective_capacity: f64,
) -> f64 {
    let a = ego_coherence - shadow_acknowledgment;
    let b = symbolic_relation - complex_activation;
    let c = persona_identification - reflective_capacity;
    a * a + b * b + c * c
}

fn depth_self_integration(
    ego_coherence: f64,
    shadow_acknowledgment: f64,
    symbolic_relation: f64,
    reflective_capacity: f64,
    body_awareness: f64,
    ethical_accountability: f64,
    relational_life: f64,
    complex_activation: f64,
    one_sidedness_value: f64,
) -> f64 {
    0.54 * ego_coherence
        + 0.62 * shadow_acknowledgment
        + 0.66 * symbolic_relation
        + 0.52 * reflective_capacity
        + 0.34 * body_awareness
        + 0.36 * ethical_accountability
        + 0.30 * relational_life
        - 0.42 * complex_activation.abs()
        - 0.28 * one_sidedness_value
}

fn main() {
    let w = one_sidedness(0.84, 0.86, 0.92, 0.28, 0.30, 0.90);
    let score = depth_self_integration(0.84, 0.86, 0.92, 0.90, 0.76, 0.82, 0.82, 0.28, w);

    println!("Synthetic one-sidedness: {:.3}", w);
    println!("Synthetic depth-self integration score: {:.3}", score);
}
