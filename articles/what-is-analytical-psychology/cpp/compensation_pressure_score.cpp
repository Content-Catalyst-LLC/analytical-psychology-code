/*
What Is Analytical Psychology?
C++ example: simple synthetic compensation-pressure score
*/

#include <iomanip>
#include <iostream>

double compensation_pressure(
    double conscious_one_sidedness,
    double unconscious_activation,
    double symbolic_intensity,
    double regulatory_capacity
) {
    return conscious_one_sidedness
         + unconscious_activation
         + symbolic_intensity
         - regulatory_capacity;
}

int main() {
    double score = compensation_pressure(0.82, 0.74, 0.68, 0.36);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic compensation pressure: " << score << std::endl;
    return 0;
}
