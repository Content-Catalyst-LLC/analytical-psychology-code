fn recurrence_strength(cluster_stability: f64, weighted_cooccurrence: f64, cross_context_recurrence: f64, cultural_flattening_risk: f64) -> f64 {
    0.34 * cluster_stability + 0.30 * weighted_cooccurrence + 0.28 * cross_context_recurrence - 0.42 * cultural_flattening_risk
}

fn main() {
    println!("Synthetic recurrence strength: {:.3}", recurrence_strength(0.72, 0.66, 0.58, 0.30));
}
