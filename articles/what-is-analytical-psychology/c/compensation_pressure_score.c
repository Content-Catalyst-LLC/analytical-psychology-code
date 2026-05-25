/*
What Is Analytical Psychology?
C example: simple synthetic compensation-pressure score

Synthetic educational demonstration only.
Not for diagnosis, therapy, private dream interpretation, employment screening,
surveillance, or individual evaluation.
*/

#include <stdio.h>

double compensation_pressure(
    double conscious_one_sidedness,
    double unconscious_activation,
    double symbolic_intensity,
    double regulatory_capacity
) {
    return conscious_one_sidedness
         + unconscious_activation
         + symbolic_intensity
         - regulatory_capacity;
}

int main(void) {
    double score = compensation_pressure(0.82, 0.74, 0.68, 0.36);
    printf("Synthetic compensation pressure: %.3f\n", score);
    return 0;
}
