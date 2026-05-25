/*
The Collective Unconscious: Meaning, Scope, and Controversy
C++ example: simple synthetic recurrence-strength score
*/

#include <iomanip>
#include <iostream>

double recurrence_strength(
    double cluster_stability,
    double weighted_cooccurrence,
    double cross_context_recurrence,
    double alternative_explanation_strength
) {
    return 0.34 * cluster_stability
         + 0.30 * weighted_cooccurrence
         + 0.28 * cross_context_recurrence
         - 0.42 * alternative_explanation_strength;
}

int main() {
    double score = recurrence_strength(0.72, 0.66, 0.58, 0.44);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic recurrence strength after alternatives: " << score << std::endl;
    return 0;
}
