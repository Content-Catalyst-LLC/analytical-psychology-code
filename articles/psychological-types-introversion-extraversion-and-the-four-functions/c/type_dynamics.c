/*
Psychological Types: Introversion, Extraversion, and the Four Functions
C example: simple synthetic type-dynamics score

Synthetic educational demonstration only.
Not for diagnosis, therapy, personality assessment, typological labeling,
hiring, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double compensation_strain(
    double dominant_strength,
    double inferior_strength,
    double function_variance,
    double unconscious_pressure,
    double reflective_capacity
) {
    double gap = dominant_strength - inferior_strength;
    return 0.70 * gap
         + 0.55 * function_variance
         + 0.45 * unconscious_pressure
         - 0.28 * reflective_capacity;
}

double developmental_integration(
    double inferior_strength,
    double symbolic_relation,
    double reflective_capacity,
    double function_variance,
    double strain
) {
    return 0.42 * inferior_strength
         + 0.38 * symbolic_relation
         + 0.36 * reflective_capacity
         - 0.32 * function_variance
         - 0.26 * strain;
}

int main(void) {
    double strain = compensation_strain(0.92, 0.78, 0.004, 0.20, 0.86);
    double integration = developmental_integration(0.78, 0.84, 0.86, 0.004, strain);

    printf("Synthetic compensation strain: %.3f\n", strain);
    printf("Synthetic developmental integration score: %.3f\n", integration);
    return 0;
}
