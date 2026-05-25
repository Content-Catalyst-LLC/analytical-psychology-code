/*
Carl Jung and the Formation of Analytical Psychology
C example: simple synthetic concept-transition score

Synthetic educational demonstration only.
Not for diagnosis, therapy, historical proof, employment screening, or individual evaluation.
*/

#include <stdio.h>

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

int main(void) {
    double score = concept_transition_score(0.30, 0.88, 0.80, 0.74);
    printf("Synthetic concept-transition score: %.3f\n", score);
    return 0;
}
