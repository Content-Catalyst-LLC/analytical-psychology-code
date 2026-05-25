/*
Individuation and the Development of the Depth Self
C++ example: simple synthetic depth-self integration score
*/

#include <cmath>
#include <iomanip>
#include <iostream>

double onesidedness(
    double ego_coherence,
    double shadow_acknowledgment,
    double symbolic_relation,
    double complex_activation,
    double persona_identification,
    double reflective_capacity
) {
    double a = ego_coherence - shadow_acknowledgment;
    double b = symbolic_relation - complex_activation;
    double c = persona_identification - reflective_capacity;
    return a * a + b * b + c * c;
}

double depth_self_integration(
    double ego_coherence,
    double shadow_acknowledgment,
    double symbolic_relation,
    double reflective_capacity,
    double body_awareness,
    double ethical_accountability,
    double relational_life,
    double complex_activation,
    double one_sidedness
) {
    return 0.54 * ego_coherence
         + 0.62 * shadow_acknowledgment
         + 0.66 * symbolic_relation
         + 0.52 * reflective_capacity
         + 0.34 * body_awareness
         + 0.36 * ethical_accountability
         + 0.30 * relational_life
         - 0.42 * std::abs(complex_activation)
         - 0.28 * one_sidedness;
}

int main() {
    double w = onesidedness(0.84, 0.86, 0.92, 0.28, 0.30, 0.90);
    double score = depth_self_integration(0.84, 0.86, 0.92, 0.90, 0.76, 0.82, 0.82, 0.28, w);

    std::cout << "Synthetic one-sidedness: "
              << std::fixed << std::setprecision(3)
              << w << std::endl;

    std::cout << "Synthetic depth-self integration score: "
              << std::fixed << std::setprecision(3)
              << score << std::endl;
    return 0;
}
