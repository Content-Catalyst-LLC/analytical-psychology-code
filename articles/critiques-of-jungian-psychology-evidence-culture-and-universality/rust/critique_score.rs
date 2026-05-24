fn credibility_score(
    interpretive_breadth: f64,
    empirical_support: f64,
    cultural_specificity: f64,
    gender_critical_revision: f64,
    methodological_explicitness: f64,
    clinical_utility: f64,
    universalization: f64,
) -> f64 {
    0.48 * interpretive_breadth
        + 0.56 * empirical_support
        + 0.62 * cultural_specificity
        + 0.50 * gender_critical_revision
        + 0.58 * methodological_explicitness
        + 0.46 * clinical_utility
        - 0.72 * universalization
}

fn main() {
    let score = credibility_score(0.76, 0.50, 0.70, 0.64, 0.78, 0.85, 0.32);
    println!("Synthetic credibility score: {:.3}", score);
}
