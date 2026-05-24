fn archetypal_depth(
    psychic_plurality: f64,
    imaginal_density: f64,
    metaphorical_richness: f64,
    symptom_image_intensity: f64,
    integrative_pressure: f64,
) -> f64 {
    0.65 * psychic_plurality
        + 0.70 * imaginal_density
        + 0.58 * metaphorical_richness
        + 0.46 * symptom_image_intensity
        - 0.55 * integrative_pressure
}

fn main() {
    let score = archetypal_depth(0.86, 0.91, 0.83, 0.64, 0.31);
    println!("Synthetic archetypal-depth score: {:.3}", score);
}
