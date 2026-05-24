/*
Trauma, Dissociation, and the Fragmented Psyche
C example: simple synthetic integration potential score

Synthetic educational demonstration only.
Not for diagnosis, therapy, crisis assessment, risk prediction,
screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double integration_potential(
    double ego_integration,
    double symbolic_capacity,
    double relational_safety,
    double bodily_regulation,
    double memory_continuity,
    double symbolic_recovery,
    double witnessing_capacity,
    double dissociation,
    double nightmare_intrusion
) {
    return 0.60 * ego_integration
         + 0.55 * symbolic_capacity
         + 0.62 * relational_safety
         + 0.48 * bodily_regulation
         + 0.44 * memory_continuity
         + 0.40 * symbolic_recovery
         + 0.32 * witnessing_capacity
         - 0.68 * dissociation
         - 0.34 * nightmare_intrusion;
}

int main(void) {
    double score = integration_potential(0.82, 0.80, 0.84, 0.80, 0.78, 0.76, 0.78, 0.24, 0.28);
    printf("Synthetic trauma integration potential: %.3f\n", score);
    return 0;
}
