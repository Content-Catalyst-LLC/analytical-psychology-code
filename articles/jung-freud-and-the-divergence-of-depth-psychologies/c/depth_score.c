/*
Jung, Freud, and the Divergence of Depth Psychologies
C example: simple synthetic depth-psychology comparison score

Synthetic educational demonstration only.
Not for diagnosis, assessment, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double freudian_score(
    double repression,
    double sexuality_conflict,
    double infantile_history,
    double defense_intensity,
    double transference_pressure,
    double mythic_amplification
) {
    return 0.66 * repression
         + 0.70 * sexuality_conflict
         + 0.62 * infantile_history
         + 0.58 * defense_intensity
         + 0.50 * transference_pressure
         - 0.30 * mythic_amplification;
}

double jungian_score(
    double compensation,
    double archetypal_density,
    double prospective_development,
    double mythic_amplification,
    double symbolic_coherence,
    double individuation_pressure,
    double repression
) {
    return 0.58 * compensation
         + 0.70 * archetypal_density
         + 0.62 * prospective_development
         + 0.64 * mythic_amplification
         + 0.60 * symbolic_coherence
         + 0.56 * individuation_pressure
         - 0.24 * repression;
}

int main(void) {
    double f = freudian_score(0.84, 0.78, 0.82, 0.76, 0.69, 0.28);
    double j = jungian_score(0.36, 0.30, 0.34, 0.28, 0.38, 0.32, 0.84);

    printf("Synthetic Freudian score: %.3f\n", f);
    printf("Synthetic Jungian score: %.3f\n", j);
    return 0;
}
