/*
Carl Jung and the Formation of Analytical Psychology
C++ example: simple synthetic concept-transition score
*/

#include <iomanip>
#include <iostream>

double concept_transition_score(
    double early_weight,
    double middle_weight,
    double late_weight,
    double post_jungian_revision_weight
) {
    return -0.20 * early_weight
         + 0.35 * middle_weight
         + 0.40 * late_weight
         + 0.45 * post_jungian_revision_weight;
}

int main() {
    double score = concept_transition_score(0.30, 0.88, 0.80, 0.74);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic concept-transition score: " << score << std::endl;
    return 0;
}
