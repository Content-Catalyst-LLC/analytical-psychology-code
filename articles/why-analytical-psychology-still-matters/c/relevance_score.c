/*
Why Analytical Psychology Still Matters
C example: simple conceptual relevance score

Synthetic educational demonstration only.
Not for diagnosis, assessment, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

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

int main(void) {
    double score = relevance_score(0.82, 0.74, 0.58, 0.77, 0.69, 0.21);
    printf("Synthetic relevance score: %.3f\n", score);
    return 0;
}
