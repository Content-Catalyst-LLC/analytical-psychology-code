fn cooccurrence_weight(motif_a_present: bool, motif_b_present: bool) -> i32 {
    if motif_a_present && motif_b_present {
        1
    } else {
        0
    }
}

fn context_share(context_count: f64, motif_total: f64) -> f64 {
    if motif_total <= 0.0 {
        0.0
    } else {
        context_count / motif_total
    }
}

fn main() {
    let weight = cooccurrence_weight(true, true);
    let share = context_share(4.0, 10.0);

    println!("Synthetic motif co-occurrence weight: {}", weight);
    println!("Synthetic context share: {:.3}", share);
}
