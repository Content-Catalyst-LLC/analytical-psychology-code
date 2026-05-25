fn projection_intensity(u: f64, a: f64, r: f64, d: f64, g: f64, m: f64) -> f64 {
    0.70*u + 0.65*a + 0.50*r + 0.34*d + 0.22*g - 0.55*m
}

fn symbolic_integration(m: f64, f: f64, pr: f64, pi: f64) -> f64 {
    0.46*m + 0.42*f - 0.30*pr - 0.24*pi.abs()
}

fn main() {
    let projection = projection_intensity(0.66, 0.58, 0.42, 0.34, 0.34, 0.72);
    let integration = symbolic_integration(0.72, 0.72, 0.28, projection);
    println!("Synthetic projection intensity: {:.3}", projection);
    println!("Synthetic symbolic integration: {:.3}", integration);
}
