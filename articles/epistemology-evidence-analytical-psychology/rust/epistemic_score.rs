fn credibility_score(
    empirical_support: f64,
    hermeneutic_coherence: f64,
    clinical_utility: f64,
    phenomenological_adequacy: f64,
    contextual_specificity: f64,
    methodological_explicitness: f64,
    ambiguity_inflation: f64,
) -> f64 {
    0.52 * empirical_support
        + 0.58 * hermeneutic_coherence
        + 0.62 * clinical_utility
        + 0.56 * phenomenological_adequacy
        + 0.44 * contextual_specificity
        + 0.60 * methodological_explicitness
        - 0.72 * ambiguity_inflation
}

fn main() {
    let score = credibility_score(0.42, 0.84, 0.78, 0.81, 0.68, 0.72, 0.28);
    println!("Synthetic credibility score: {:.3}", score);
}
