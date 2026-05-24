/*
Relational and Developmental Jungian Psychotherapy
C example: simple synthetic developmental integration score

Synthetic educational demonstration only.
Not for diagnosis, therapy, clinical decision-making, therapist evaluation,
screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double developmental_integration(
    double relational_safety,
    double attachment_security,
    double affect_regulation,
    double repair_capacity,
    double embodied_safety,
    double symbolic_capacity,
    double reflective_self,
    double fragmentation,
    double shame_load,
    double rupture_intensity
) {
    return 0.62 * relational_safety
         + 0.42 * attachment_security
         + 0.55 * affect_regulation
         + 0.46 * repair_capacity
         + 0.36 * embodied_safety
         + 0.58 * symbolic_capacity
         + 0.44 * reflective_self
         - 0.58 * fragmentation
         - 0.38 * shame_load
         - 0.28 * rupture_intensity;
}

int main(void) {
    double score = developmental_integration(
        0.82, 0.74, 0.74, 0.78, 0.74, 0.76, 0.78, 0.32, 0.42, 0.26
    );

    printf("Synthetic developmental integration score: %.3f\n", score);
    return 0;
}
