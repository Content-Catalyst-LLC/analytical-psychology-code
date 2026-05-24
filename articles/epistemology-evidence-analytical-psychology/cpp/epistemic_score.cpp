/*
Epistemology and Evidence in Analytical Psychology
C++ example: simple synthetic credibility score
*/

#include <iostream>
#include <iomanip>

double credibility_score(
    double empirical_support,
    double hermeneutic_coherence,
    double clinical_utility,
    double phenomenological_adequacy,
    double contextual_specificity,
    double methodological_explicitness,
    double ambiguity_inflation
) {
    return 0.52 * empirical_support
         + 0.58 * hermeneutic_coherence
         + 0.62 * clinical_utility
         + 0.56 * phenomenological_adequacy
         + 0.44 * contextual_specificity
         + 0.60 * methodological_explicitness
         - 0.72 * ambiguity_inflation;
}

int main() {
    double score = credibility_score(0.42, 0.84, 0.78, 0.81, 0.68, 0.72, 0.28);
    std::cout << "Synthetic credibility score: "
              << std::fixed << std::setprecision(3) << score << std::endl;
    return 0;
}
