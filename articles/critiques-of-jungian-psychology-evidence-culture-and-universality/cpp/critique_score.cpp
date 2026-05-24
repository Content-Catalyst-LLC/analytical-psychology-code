/*
Critiques of Jungian Psychology: Evidence, Culture, and Universality
C++ example: simple synthetic credibility score
*/

#include <iostream>
#include <iomanip>

double credibility_score(
    double interpretive_breadth,
    double empirical_support,
    double cultural_specificity,
    double gender_critical_revision,
    double methodological_explicitness,
    double clinical_utility,
    double universalization
) {
    return 0.48 * interpretive_breadth
         + 0.56 * empirical_support
         + 0.62 * cultural_specificity
         + 0.50 * gender_critical_revision
         + 0.58 * methodological_explicitness
         + 0.46 * clinical_utility
         - 0.72 * universalization;
}

int main() {
    double score = credibility_score(0.76, 0.50, 0.70, 0.64, 0.78, 0.85, 0.32);
    std::cout << "Synthetic credibility score: "
              << std::fixed << std::setprecision(3) << score << std::endl;
    return 0;
}
