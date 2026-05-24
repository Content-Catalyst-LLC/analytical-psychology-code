/*
Non-Western Symbol Systems and the Limits of Jungian Universality
C++ example: simple synthetic comparative-quality score
*/

#include <iostream>
#include <iomanip>

double comparative_quality(
    double recurrence,
    double specificity,
    double linguistic_depth,
    double ritual_context,
    double dialogical_accountability,
    double universalizing_force,
    double abstraction_pressure
) {
    return 0.52 * recurrence
         + 0.68 * specificity
         + 0.58 * linguistic_depth
         + 0.54 * ritual_context
         + 0.62 * dialogical_accountability
         - 0.66 * universalizing_force
         - 0.42 * abstraction_pressure;
}

int main() {
    double score = comparative_quality(0.76, 0.84, 0.79, 0.87, 0.77, 0.27, 0.30);
    std::cout << "Synthetic comparative-quality score: "
              << std::fixed << std::setprecision(3) << score << std::endl;
    return 0;
}
