/*
The Self in Jungian Thought
C++ example: simple synthetic Self-integration score
*/

#include <algorithm>
#include <iomanip>
#include <iostream>

double positive_part(double x) {
    return std::max(x, 0.0);
}

double totality_score(
    double ego_coherence,
    double unconscious_activation,
    double symbolic_center_strength,
    double relational_coordination,
    double disjunction,
    double inflation_risk
) {
    return 0.48 * ego_coherence
         + 0.36 * unconscious_activation
         + 0.58 * symbolic_center_strength
         + 0.54 * relational_coordination
         - 0.46 * disjunction
         - 0.30 * positive_part(inflation_risk);
}

double self_relation_index(
    double totality,
    double differentiation,
    double symbolic_center_strength,
    double inflation_risk
) {
    return 0.40 * totality
         + 0.34 * differentiation
         + 0.28 * symbolic_center_strength
         - 0.30 * positive_part(inflation_risk);
}

int main() {
    double totality = totality_score(0.74, 0.66, 0.82, 0.76, 0.28, 0.18);
    double self_relation = self_relation_index(totality, 0.80, 0.82, 0.18);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic totality score: " << totality << std::endl;
    std::cout << "Synthetic Self-relation index: " << self_relation << std::endl;

    return 0;
}
