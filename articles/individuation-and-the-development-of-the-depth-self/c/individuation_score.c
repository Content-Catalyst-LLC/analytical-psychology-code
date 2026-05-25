/*
Individuation and the Development of the Depth Self
C example: simple synthetic depth-self integration score

Synthetic educational demonstration only.
Not for diagnosis, therapy, assessment, life prediction, screening,
surveillance, or individual evaluation.
*/

#include <stdio.h>
#include <math.h>

double onesidedness(
    double ego_coherence,
    double shadow_acknowledgment,
    double symbolic_relation,
    double complex_activation,
    double persona_identification,
    double reflective_capacity
) {
    double a = ego_coherence - shadow_acknowledgment;
    double b = symbolic_relation - complex_activation;
    double c = persona_identification - reflective_capacity;
    return a * a + b * b + c * c;
}

double depth_self_integration(
    double ego_coherence,
    double shadow_acknowledgment,
    double symbolic_relation,
    double reflective_capacity,
    double body_awareness,
    double ethical_accountability,
    double relational_life,
    double complex_activation,
    double one_sidedness
) {
    return 0.54 * ego_coherence
         + 0.62 * shadow_acknowledgment
         + 0.66 * symbolic_relation
         + 0.52 * reflective_capacity
         + 0.34 * body_awareness
         + 0.36 * ethical_accountability
         + 0.30 * relational_life
         - 0.42 * fabs(complex_activation)
         - 0.28 * one_sidedness;
}

int main(void) {
    double w = onesidedness(0.84, 0.86, 0.92, 0.28, 0.30, 0.90);
    double score = depth_self_integration(0.84, 0.86, 0.92, 0.90, 0.76, 0.82, 0.82, 0.28, w);

    printf("Synthetic one-sidedness: %.3f\n", w);
    printf("Synthetic depth-self integration score: %.3f\n", score);
    return 0;
}
