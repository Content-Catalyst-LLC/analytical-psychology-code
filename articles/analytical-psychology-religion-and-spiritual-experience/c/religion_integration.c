/*
Analytical Psychology, Religion, and Spiritual Experience
C example: simple synthetic integration score

Synthetic educational demonstration only.
Not for diagnosis, therapy, spiritual direction, religious authority,
assessment, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double integration_score(
    double numinous_intensity,
    double symbolic_containment,
    double ego_stability,
    double shadow_awareness,
    double ritual_support,
    double religious_trauma_pressure
) {
    double containment_gap = numinous_intensity - symbolic_containment;
    return 0.60 * symbolic_containment
         + 0.55 * ego_stability
         + 0.48 * shadow_awareness
         + 0.42 * ritual_support
         + 0.36 * numinous_intensity
         - 0.65 * containment_gap * containment_gap
         - 0.30 * religious_trauma_pressure;
}

int main(void) {
    double score = integration_score(0.78, 0.82, 0.74, 0.66, 0.84, 0.22);
    printf("Synthetic religion/spiritual-experience integration score: %.3f\n", score);
    return 0;
}
