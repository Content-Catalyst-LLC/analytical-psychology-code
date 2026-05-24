fn symbolic_density(motif_count: u32, total_tokens: u32) -> f64 {
    if total_tokens == 0 {
        return 0.0;
    }
    motif_count as f64 / total_tokens as f64
}

fn main() {
    let score = symbolic_density(8, 120);
    println!("Synthetic symbolic-density score: {:.4}", score);
}
