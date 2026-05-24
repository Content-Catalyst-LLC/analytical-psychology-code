/*
Midlife, Meaning, and Individuation
C++ example: simple synthetic meaning coherence score
*/

#include <iostream>
#include <iomanip>

double meaning_coherence(
    double adaptation_strength,
    double symbolic_activation,
    double individuation_pressure,
    double shadow_integration,
    double reflective_capacity,
    double outward_inward_discrepancy
) {
    return 0.40 * adaptation_strength
         + 0.58 * symbolic_activation
         + 0.62 * individuation_pressure
         + 0.42 * shadow_integration
         + 0.36 * reflective_capacity
         - 0.72 * outward_inward_discrepancy;
}

int main() {
    double score = meaning_coherence(0.54, 0.90, 0.88, 0.86, 0.86, 0.28);

    std::cout << "Synthetic midlife meaning coherence score: "
              << std::fixed << std::setprecision(3)
              << score << std::endl;
    return 0;
}
