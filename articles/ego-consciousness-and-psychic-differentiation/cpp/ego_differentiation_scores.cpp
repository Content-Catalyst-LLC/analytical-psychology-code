/*
Ego, Consciousness, and Psychic Differentiation
C++ example: simple synthetic ego-differentiation score
*/

#include <iomanip>
#include <iostream>

double ego_coherence(
    double differentiation,
    double unconscious_pressure,
    double reflective_flexibility,
    double one_sidedness
) {
    return 0.72 * differentiation
         - 0.48 * unconscious_pressure
         + 0.60 * reflective_flexibility
         - 0.22 * one_sidedness;
}

double psychic_strain(
    double one_sidedness,
    double unconscious_pressure,
    double shadow_activation,
    double ego_rigidity,
    double reflective_flexibility
) {
    return 0.40 * one_sidedness
         + 0.46 * unconscious_pressure
         + 0.42 * shadow_activation
         + 0.34 * ego_rigidity
         - 0.44 * reflective_flexibility;
}

int main() {
    double coherence = ego_coherence(0.80, 0.54, 0.72, 0.08);
    double strain = psychic_strain(0.08, 0.54, 0.54, 0.20, 0.72);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic ego coherence: " << coherence << std::endl;
    std::cout << "Synthetic psychic strain: " << strain << std::endl;

    return 0;
}
