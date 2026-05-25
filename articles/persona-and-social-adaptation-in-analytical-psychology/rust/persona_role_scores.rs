fn persona_strength(
    role_demand: f64,
    audience_reward: f64,
    institutional_reward: f64,
    inward_complexity: f64,
    reflective_flexibility: f64,
) -> f64 {
    0.64 * role_demand
        + 0.48 * audience_reward
        + 0.36 * institutional_reward
        - 0.30 * inward_complexity
        + 0.42 * reflective_flexibility
}

fn persona_rigidity(
    persona_strength_value: f64,
    status_dependence: f64,
    institutional_reward: f64,
    reflective_flexibility: f64,
) -> f64 {
    0.52 * persona_strength_value
        + 0.42 * status_dependence
        + 0.34 * institutional_reward
        - 0.46 * reflective_flexibility
}

fn psychic_strain(
    persona_strength_value: f64,
    persona_inward_gap: f64,
    persona_rigidity_value: f64,
    shadow_pressure: f64,
    reflective_flexibility: f64,
) -> f64 {
    0.50 * persona_strength_value
        + 0.62 * persona_inward_gap * persona_inward_gap
        + 0.42 * persona_rigidity_value
        + 0.36 * shadow_pressure
        - 0.52 * reflective_flexibility
}

fn main() {
    let strength = persona_strength(0.66, 0.50, 0.60, 0.70, 0.76);
    let rigidity = persona_rigidity(strength, 0.34, 0.60, 0.76);
    let strain = psychic_strain(strength, 0.08, rigidity, 0.32, 0.76);

    println!("Synthetic persona strength: {:.3}", strength);
    println!("Synthetic persona rigidity: {:.3}", rigidity);
    println!("Synthetic psychic strain: {:.3}", strain);
}
