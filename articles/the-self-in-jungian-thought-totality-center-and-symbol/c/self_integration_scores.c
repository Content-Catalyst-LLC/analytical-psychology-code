/*
The Self in Jungian Thought
C example: simple synthetic Self-integration score

Synthetic educational demonstration only.
Not for diagnosis, therapy, spiritual authority claims, mental-health
evaluation, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>
#include <math.h>

double positive_part(double x) {
    return x > 0.0 ? x : 0.0;
}

double totality_score(
    double ego_coherence,
    double unconscious_activation,
    double symbolic_center_strength,
    double relational_coordination,
    double disjunction,
    double inflation_risk
) {
    return 0.48 * ego_coherence
         + 0.36 * unconscious_activation
         + 0.58 * symbolic_center_strength
         + 0.54 * relational_coordination
         - 0.46 * disjunction
         - 0.30 * positive_part(inflation_risk);
}

double self_relation_index(
    double totality,
    double differentiation,
    double symbolic_center_strength,
    double inflation_risk
) {
    return 0.40 * totality
         + 0.34 * differentiation
         + 0.28 * symbolic_center_strength
         - 0.30 * positive_part(inflation_risk);
}

int main(void) {
    double totality = totality_score(0.74, 0.66, 0.82, 0.76, 0.28, 0.18);
    double self_relation = self_relation_index(totality, 0.80, 0.82, 0.18);

    printf("Synthetic totality score: %.3f\n", totality);
    printf("Synthetic Self-relation index: %.3f\n", self_relation);
    return 0;
}
