/*
The Personal Unconscious and the Theory of Complexes
C example: simple synthetic complex-pressure score

Synthetic educational demonstration only.
Not for diagnosis, therapy, employment screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double complex_pressure(
    double complex_activation,
    double affect_intensity,
    double unresolved_affect,
    double projection_pressure,
    double transference_pressure,
    double regulation_capacity,
    double contextual_support
) {
    return complex_activation
         + affect_intensity
         + unresolved_affect
         + projection_pressure
         + transference_pressure
         - regulation_capacity
         - contextual_support;
}

int main(void) {
    double score = complex_pressure(0.86, 0.82, 0.72, 0.44, 0.50, 0.36, 0.30);
    printf("Synthetic complex pressure: %.3f\n", score);
    return 0;
}
