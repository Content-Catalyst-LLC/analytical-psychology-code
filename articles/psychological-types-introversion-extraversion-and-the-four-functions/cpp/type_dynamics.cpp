/*
Psychological Types: Introversion, Extraversion, and the Four Functions
C++ example: simple synthetic type-dynamics score
*/

#include <iomanip>
#include <iostream>

double compensation_strain(
    double dominant_strength,
    double inferior_strength,
    double function_variance,
    double unconscious_pressure,
    double reflective_capacity
) {
    double gap = dominant_strength - inferior_strength;
    return 0.70 * gap
         + 0.55 * function_variance
         + 0.45 * unconscious_pressure
         - 0.28 * reflective_capacity;
}

double developmental_integration(
    double inferior_strength,
    double symbolic_relation,
    double reflective_capacity,
    double function_variance,
    double strain
) {
    return 0.42 * inferior_strength
         + 0.38 * symbolic_relation
         + 0.36 * reflective_capacity
         - 0.32 * function_variance
         - 0.26 * strain;
}

int main() {
    double strain = compensation_strain(0.92, 0.78, 0.004, 0.20, 0.86);
    double integration = developmental_integration(0.78, 0.84, 0.86, 0.004, strain);

    std::cout << "Synthetic compensation strain: "
              << std::fixed << std::setprecision(3)
              << strain << std::endl;

    std::cout << "Synthetic developmental integration score: "
              << std::fixed << std::setprecision(3)
              << integration << std::endl;
    return 0;
}
