/*
Why Analytical Psychology Still Matters
C++ example: simple conceptual relevance score
*/

#include <iostream>
#include <iomanip>

double relevance_score(
    double symbolic_depth,
    double meaning_coherence,
    double clinical_utility,
    double cultural_interpretive_power,
    double revision_capacity,
    double doctrinal_rigidity
) {
    return 0.62 * symbolic_depth
         + 0.58 * meaning_coherence
         + 0.54 * clinical_utility
         + 0.48 * cultural_interpretive_power
         + 0.60 * revision_capacity
         - 0.70 * doctrinal_rigidity;
}

int main() {
    double score = relevance_score(0.82, 0.74, 0.58, 0.77, 0.69, 0.21);
    std::cout << "Synthetic relevance score: "
              << std::fixed << std::setprecision(3) << score << std::endl;
    return 0;
}
