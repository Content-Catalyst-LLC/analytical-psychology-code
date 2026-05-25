fn compensatory_intensity(
    conscious_onesidedness: f64,
    unconscious_pressure: f64,
    affective_intensity: f64,
    reflective_capacity: f64,
) -> f64 {
    0.72 * (unconscious_pressure - conscious_onesidedness)
        + 0.36 * affective_intensity
        - 0.22 * reflective_capacity
}

fn prospective_intensity(
    latent_growth: f64,
    symbolic_literacy: f64,
    reflective_capacity: f64,
    previous_dream_output: f64,
) -> f64 {
    0.64 * latent_growth
        + 0.28 * symbolic_literacy
        + 0.22 * reflective_capacity
        + 0.18 * previous_dream_output
}

fn main() {
    let comp = compensatory_intensity(0.52, 0.66, 0.48, 0.60);
    let prosp = prospective_intensity(0.72, 0.56, 0.60, 0.72);
    let dream_output = 0.55 * comp + 0.52 * prosp + 0.40 * 0.48 + 0.32 * 0.72;
    let integration = 0.44 * prosp + 0.36 * 0.60 + 0.30 * 0.56 - 0.24 * comp.abs();

    println!("Synthetic compensatory intensity: {:.3}", comp);
    println!("Synthetic prospective intensity: {:.3}", prosp);
    println!("Synthetic dream output: {:.3}", dream_output);
    println!("Synthetic integration signal: {:.3}", integration);
}
