fn freudian_score(
    repression: f64,
    sexuality_conflict: f64,
    infantile_history: f64,
    defense_intensity: f64,
    transference_pressure: f64,
    mythic_amplification: f64,
) -> f64 {
    0.66 * repression
        + 0.70 * sexuality_conflict
        + 0.62 * infantile_history
        + 0.58 * defense_intensity
        + 0.50 * transference_pressure
        - 0.30 * mythic_amplification
}

fn jungian_score(
    compensation: f64,
    archetypal_density: f64,
    prospective_development: f64,
    mythic_amplification: f64,
    symbolic_coherence: f64,
    individuation_pressure: f64,
    repression: f64,
) -> f64 {
    0.58 * compensation
        + 0.70 * archetypal_density
        + 0.62 * prospective_development
        + 0.64 * mythic_amplification
        + 0.60 * symbolic_coherence
        + 0.56 * individuation_pressure
        - 0.24 * repression
}

fn main() {
    let f = freudian_score(0.84, 0.78, 0.82, 0.76, 0.69, 0.28);
    let j = jungian_score(0.36, 0.30, 0.34, 0.28, 0.38, 0.32, 0.84);

    println!("Synthetic Freudian score: {:.3}", f);
    println!("Synthetic Jungian score: {:.3}", j);
}
