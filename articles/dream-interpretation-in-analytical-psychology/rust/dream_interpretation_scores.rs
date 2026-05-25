fn compensatory_signal(
    conscious_onesidedness: f64,
    unconscious_pressure: f64,
    affective_intensity: f64,
    reflective_capacity: f64,
) -> f64 {
    0.72 * (unconscious_pressure - conscious_onesidedness)
        + 0.42 * affective_intensity
        - 0.20 * reflective_capacity
}

fn symbolic_recurrence(
    previous_dream_output: f64,
    symbolic_repertoire: f64,
    latent_development: f64,
) -> f64 {
    0.44 * previous_dream_output
        + 0.36 * symbolic_repertoire
        + 0.24 * latent_development
}

fn main() {
    let comp = compensatory_signal(0.52, 0.66, 0.48, 0.60);
    let recur = symbolic_recurrence(0.72, 0.56, 0.70);
    let dream_output = 0.52 * comp + 0.48 * recur + 0.38 * 0.48 + 0.32 * 0.70;
    let integration = 0.42 * 0.60 + 0.38 * 0.70 + 0.30 * 0.56 - 0.24 * comp.abs();

    println!("Synthetic compensatory signal: {:.3}", comp);
    println!("Synthetic symbolic recurrence: {:.3}", recur);
    println!("Synthetic dream output: {:.3}", dream_output);
    println!("Synthetic integration signal: {:.3}", integration);
}
