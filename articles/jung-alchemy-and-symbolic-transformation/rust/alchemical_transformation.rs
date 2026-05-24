fn transformation_score(
    nigredo_pressure: f64,
    albedo_clarity: f64,
    rubedo_vitality: f64,
    vessel_strength: f64,
    onesidedness: f64,
    mercurial_volatility: f64,
) -> f64 {
    0.42 * nigredo_pressure
        + 0.55 * albedo_clarity
        + 0.66 * rubedo_vitality
        + 0.58 * vessel_strength
        - 0.60 * onesidedness
        - 0.30 * mercurial_volatility.abs()
}

fn main() {
    let score = transformation_score(0.70, 0.52, 0.44, 0.58, 0.62, 0.84);
    println!("Synthetic alchemical transformation score: {:.3}", score);
}
