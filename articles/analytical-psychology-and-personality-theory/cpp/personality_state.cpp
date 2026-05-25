/*
Analytical Psychology and Personality Theory
C++ example: simple synthetic personality-state score
*/

#include <cmath>
#include <iomanip>
#include <iostream>

double onesidedness(
    double conscious_orientation,
    double shadow_acknowledgment,
    double persona_identification,
    double typological_flexibility,
    double complex_activation,
    double symbolic_relation
) {
    double a = conscious_orientation - shadow_acknowledgment;
    double b = persona_identification - typological_flexibility;
    double c = complex_activation - symbolic_relation;
    return a * a + b * b + c * c;
}

double personality_state(
    double conscious_orientation,
    double persona_identification,
    double symbolic_relation,
    double shadow_acknowledgment,
    double developmental_integration,
    double complex_activation,
    double unconscious_compensation
) {
    return 0.44 * conscious_orientation
         + 0.36 * persona_identification
         + 0.42 * symbolic_relation
         + 0.32 * shadow_acknowledgment
         + 0.54 * developmental_integration
         - 0.34 * std::abs(complex_activation)
         + 0.20 * unconscious_compensation;
}

int main() {
    double w = onesidedness(0.88, 0.86, 0.28, 0.90, 0.18, 0.96);
    double score = personality_state(0.88, 0.28, 0.96, 0.86, 0.98, 0.18, 0.18);

    std::cout << "Synthetic one-sidedness: "
              << std::fixed << std::setprecision(3)
              << w << std::endl;

    std::cout << "Synthetic Jungian personality-state score: "
              << std::fixed << std::setprecision(3)
              << score << std::endl;
    return 0;
}
