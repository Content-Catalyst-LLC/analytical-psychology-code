fn relevance_score(
    symbolic_depth: f64,
    meaning_coherence: f64,
    clinical_utility: f64,
    cultural_interpretive_power: f64,
    revision_capacity: f64,
    doctrinal_rigidity: f64,
) -> f64 {
    0.62 * symbolic_depth
        + 0.58 * meaning_coherence
        + 0.54 * clinical_utility
        + 0.48 * cultural_interpretive_power
        + 0.60 * revision_capacity
        - 0.70 * doctrinal_rigidity
}

fn main() {
    let score = relevance_score(0.82, 0.74, 0.58, 0.77, 0.69, 0.21);
    println!("Synthetic relevance score: {:.3}", score);
}
