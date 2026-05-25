/*
The Personal Unconscious and the Theory of Complexes
C++ example: simple synthetic complex-pressure score
*/

#include <iomanip>
#include <iostream>

double complex_pressure(
    double complex_activation,
    double affect_intensity,
    double unresolved_affect,
    double projection_pressure,
    double transference_pressure,
    double regulation_capacity,
    double contextual_support
) {
    return complex_activation
         + affect_intensity
         + unresolved_affect
         + projection_pressure
         + transference_pressure
         - regulation_capacity
         - contextual_support;
}

int main() {
    double score = complex_pressure(0.86, 0.82, 0.72, 0.44, 0.50, 0.36, 0.30);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic complex pressure: " << score << std::endl;
    return 0;
}
