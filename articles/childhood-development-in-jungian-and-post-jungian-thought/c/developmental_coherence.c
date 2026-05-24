/*
Childhood Development in Jungian and Post-Jungian Thought
C example: simple synthetic developmental coherence score

Synthetic educational demonstration only.
Not for diagnosis, therapy, child assessment, educational evaluation,
screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double developmental_strain(
    double ego_differentiation,
    double relational_security,
    double symbolic_capacity,
    double complex_activation
) {
    double e_r = ego_differentiation - relational_security;
    double s_r = symbolic_capacity - relational_security;
    return e_r * e_r + s_r * s_r + complex_activation * complex_activation;
}

double developmental_coherence(
    double ego_differentiation,
    double relational_security,
    double symbolic_capacity,
    double affect_regulation,
    double symbolic_play,
    double complex_activation,
    double strain
) {
    return 0.55 * ego_differentiation
         + 0.70 * relational_security
         + 0.60 * symbolic_capacity
         + 0.48 * affect_regulation
         + 0.34 * symbolic_play
         - 0.50 * complex_activation
         - 0.24 * strain;
}

int main(void) {
    double strain = developmental_strain(0.82, 0.90, 0.90, 0.18);
    double score = developmental_coherence(0.82, 0.90, 0.90, 0.82, 0.90, 0.18, strain);

    printf("Synthetic developmental strain: %.3f\n", strain);
    printf("Synthetic developmental coherence score: %.3f\n", score);
    return 0;
}
