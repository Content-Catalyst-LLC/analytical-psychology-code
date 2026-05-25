fn destabilization_risk(
    imaginal_activation: f64,
    ego_mediation: f64,
    reflective_response: f64,
) -> f64 {
    0.54 * imaginal_activation
        - 0.38 * ego_mediation
        - 0.34 * reflective_response
}

fn symbolic_integration(
    ego_mediation: f64,
    imaginal_activation: f64,
    reflective_response: f64,
    symbolic_relation: f64,
    ethical_containment: f64,
    destabilization: f64,
) -> f64 {
    let imbalance = ego_mediation - imaginal_activation;
    let positive_destabilization = destabilization.max(0.0);

    0.56 * ego_mediation
        + 0.52 * imaginal_activation
        + 0.48 * reflective_response
        + 0.44 * symbolic_relation
        + 0.34 * ethical_containment
        - 0.70 * imbalance * imbalance
        - 0.28 * positive_destabilization
}

fn main() {
    let risk = destabilization_risk(0.56, 0.88, 0.88);
    let score = symbolic_integration(0.88, 0.56, 0.88, 0.90, 0.86, risk);

    println!("Synthetic destabilization risk: {:.3}", risk);
    println!("Synthetic symbolic integration score: {:.3}", score);
}
