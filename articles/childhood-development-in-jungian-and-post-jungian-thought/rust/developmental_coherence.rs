fn developmental_strain(
    ego_differentiation: f64,
    relational_security: f64,
    symbolic_capacity: f64,
    complex_activation: f64,
) -> f64 {
    let e_r = ego_differentiation - relational_security;
    let s_r = symbolic_capacity - relational_security;
    e_r * e_r + s_r * s_r + complex_activation * complex_activation
}

fn developmental_coherence(
    ego_differentiation: f64,
    relational_security: f64,
    symbolic_capacity: f64,
    affect_regulation: f64,
    symbolic_play: f64,
    complex_activation: f64,
    strain: f64,
) -> f64 {
    0.55 * ego_differentiation
        + 0.70 * relational_security
        + 0.60 * symbolic_capacity
        + 0.48 * affect_regulation
        + 0.34 * symbolic_play
        - 0.50 * complex_activation
        - 0.24 * strain
}

fn main() {
    let strain = developmental_strain(0.82, 0.90, 0.90, 0.18);
    let score = developmental_coherence(0.82, 0.90, 0.90, 0.82, 0.90, 0.18, strain);

    println!("Synthetic developmental strain: {:.3}", strain);
    println!("Synthetic developmental coherence score: {:.3}", score);
}
