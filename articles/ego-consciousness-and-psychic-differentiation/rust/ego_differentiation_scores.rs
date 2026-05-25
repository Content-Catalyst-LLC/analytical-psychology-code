fn ego_coherence(
    differentiation: f64,
    unconscious_pressure: f64,
    reflective_flexibility: f64,
    one_sidedness: f64,
) -> f64 {
    0.72 * differentiation
        - 0.48 * unconscious_pressure
        + 0.60 * reflective_flexibility
        - 0.22 * one_sidedness
}

fn psychic_strain(
    one_sidedness: f64,
    unconscious_pressure: f64,
    shadow_activation: f64,
    ego_rigidity: f64,
    reflective_flexibility: f64,
) -> f64 {
    0.40 * one_sidedness
        + 0.46 * unconscious_pressure
        + 0.42 * shadow_activation
        + 0.34 * ego_rigidity
        - 0.44 * reflective_flexibility
}

fn main() {
    let coherence = ego_coherence(0.80, 0.54, 0.72, 0.08);
    let strain = psychic_strain(0.08, 0.54, 0.54, 0.20, 0.72);

    println!("Synthetic ego coherence: {:.3}", coherence);
    println!("Synthetic psychic strain: {:.3}", strain);
}
