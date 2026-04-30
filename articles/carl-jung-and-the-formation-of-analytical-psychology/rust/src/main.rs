fn psychic_integration(
    symbolic_access: f64,
    ego_differentiation: f64,
    containment: f64,
    relational_depth: f64,
    transformation: f64,
    culture: f64,
    fragmentation: f64,
) -> f64 {
    0.14 * symbolic_access +
    0.14 * ego_differentiation +
    0.13 * containment +
    0.13 * relational_depth +
    0.14 * transformation +
    0.10 * culture -
    0.16 * fragmentation
}

fn main() {
    let score = psychic_integration(0.72, 0.66, 0.64, 0.70, 0.68, 0.55, 0.30);
    println!("Psychic integration score: {:.3}", score);
}
