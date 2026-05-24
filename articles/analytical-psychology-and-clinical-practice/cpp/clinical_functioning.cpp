/*
Analytical Psychology and Clinical Practice
C++ example: simple synthetic clinical-functioning score
*/

#include <iostream>
#include <iomanip>

double compensatory_pressure(
    double conscious_onesidedness,
    double complex_activation,
    double trauma_fragmentation,
    double ego_integration,
    double shadow_awareness
) {
    return 0.62 * conscious_onesidedness
         + 0.58 * complex_activation
         + 0.34 * trauma_fragmentation
         - 0.52 * ego_integration
         - 0.26 * shadow_awareness;
}

double clinical_functioning(
    double symptom_burden,
    double ego_integration,
    double symbolic_capacity,
    double relational_safety,
    double affect_regulation,
    double compensatory,
    double shadow_awareness
) {
    return -0.70 * symptom_burden
         + 0.60 * ego_integration
         + 0.52 * symbolic_capacity
         + 0.64 * relational_safety
         - 0.42 * compensatory
         + 0.28 * affect_regulation
         + 0.24 * shadow_awareness;
}

int main() {
    double pressure = compensatory_pressure(0.36, 0.42, 0.24, 0.80, 0.80);
    double score = clinical_functioning(0.38, 0.80, 0.76, 0.82, 0.78, pressure, 0.80);

    std::cout << "Synthetic compensatory pressure: "
              << std::fixed << std::setprecision(3)
              << pressure << std::endl;

    std::cout << "Synthetic clinical-functioning score: "
              << std::fixed << std::setprecision(3)
              << score << std::endl;
    return 0;
}
