fn integration_potential(
    ego_integration: f64,
    symbolic_capacity: f64,
    relational_safety: f64,
    bodily_regulation: f64,
    memory_continuity: f64,
    symbolic_recovery: f64,
    witnessing_capacity: f64,
    dissociation: f64,
    nightmare_intrusion: f64,
) -> f64 {
    0.60 * ego_integration
        + 0.55 * symbolic_capacity
        + 0.62 * relational_safety
        + 0.48 * bodily_regulation
        + 0.44 * memory_continuity
        + 0.40 * symbolic_recovery
        + 0.32 * witnessing_capacity
        - 0.68 * dissociation
        - 0.34 * nightmare_intrusion
}

fn main() {
    let score = integration_potential(0.82, 0.80, 0.84, 0.80, 0.78, 0.76, 0.78, 0.24, 0.28);
    println!("Synthetic trauma integration potential: {:.3}", score);
}
