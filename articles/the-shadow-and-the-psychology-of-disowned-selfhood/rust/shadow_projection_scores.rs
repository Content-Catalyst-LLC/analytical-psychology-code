fn shadow_activation(
    latent_disowned: f64,
    cue_intensity: f64,
    shadow_discrepancy: f64,
    affective_charge: f64,
    reflective_capacity: f64,
) -> f64 {
    0.72 * latent_disowned * cue_intensity
        + 0.56 * shadow_discrepancy
        + 0.42 * affective_charge
        - 0.48 * reflective_capacity
}

fn projection_intensity(
    shadow_activation_value: f64,
    affective_charge: f64,
    persona_rigidity: f64,
    reflective_capacity: f64,
) -> f64 {
    0.76 * shadow_activation_value
        + 0.44 * affective_charge
        + 0.32 * persona_rigidity
        - 0.56 * reflective_capacity
}

fn integration_capacity(
    reflective_capacity: f64,
    projection_intensity_value: f64,
    shame_response: f64,
    developmental_time: f64,
) -> f64 {
    0.50 * reflective_capacity
        - 0.34 * projection_intensity_value.abs()
        - 0.26 * shame_response
        + 0.28 * developmental_time
}

fn main() {
    let shadow = shadow_activation(0.58, 0.46, 0.02, 0.48, 0.74);
    let projection = projection_intensity(shadow, 0.48, 0.52, 0.74);
    let integration = integration_capacity(0.74, projection, 0.24, 1.0);

    println!("Synthetic shadow activation: {:.3}", shadow);
    println!("Synthetic projection intensity: {:.3}", projection);
    println!("Synthetic integration capacity: {:.3}", integration);
}
