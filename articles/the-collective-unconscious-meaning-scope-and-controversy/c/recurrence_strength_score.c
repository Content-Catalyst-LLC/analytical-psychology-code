/*
The Collective Unconscious: Meaning, Scope, and Controversy
C example: simple synthetic recurrence-strength score

Synthetic educational demonstration only.
Not for diagnosis, therapy, private dream interpretation, religious reductionism,
cultural extraction, or individual evaluation.
*/

#include <stdio.h>

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

int main(void) {
    double score = recurrence_strength(0.72, 0.66, 0.58, 0.44);
    printf("Synthetic recurrence strength after alternatives: %.3f\n", score);
    return 0;
}
