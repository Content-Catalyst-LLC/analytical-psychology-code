fn clinical_adequacy(
    symbolic_depth: f64,
    relational_sophistication: f64,
    developmental_precision: f64,
    trauma_sensitivity: f64,
    embodied_regulation: f64,
    cultural_responsiveness: f64,
    doctrinal_rigidity: f64,
) -> f64 {
    0.50 * symbolic_depth
        + 0.62 * relational_sophistication
        + 0.58 * developmental_precision
        + 0.66 * trauma_sensitivity
        + 0.52 * embodied_regulation
        + 0.46 * cultural_responsiveness
        - 0.60 * doctrinal_rigidity
}

fn main() {
    let score = clinical_adequacy(0.84, 0.86, 0.82, 0.86, 0.82, 0.78, 0.24);
    println!("Synthetic clinical-adequacy score: {:.3}", score);
}
