fn concept_transition_score(
    early_weight: f64,
    middle_weight: f64,
    late_weight: f64,
    post_jungian_revision_weight: f64,
) -> f64 {
    -0.20 * early_weight
        + 0.35 * middle_weight
        + 0.40 * late_weight
        + 0.45 * post_jungian_revision_weight
}

fn main() {
    let score = concept_transition_score(0.30, 0.88, 0.80, 0.74);
    println!("Synthetic concept-transition score: {:.3}", score);
}
