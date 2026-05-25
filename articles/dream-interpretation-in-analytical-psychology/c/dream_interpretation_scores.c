/*
Dream Interpretation in Analytical Psychology
C example: simple synthetic dream-compensation score

Synthetic educational demonstration only.
Not for diagnosis, therapy, dream interpretation, mental-health evaluation,
crisis intervention, prediction, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>
#include <math.h>

double compensatory_signal(
    double conscious_onesidedness,
    double unconscious_pressure,
    double affective_intensity,
    double reflective_capacity
) {
    return 0.72 * (unconscious_pressure - conscious_onesidedness)
         + 0.42 * affective_intensity
         - 0.20 * reflective_capacity;
}

double symbolic_recurrence(
    double previous_dream_output,
    double symbolic_repertoire,
    double latent_development
) {
    return 0.44 * previous_dream_output
         + 0.36 * symbolic_repertoire
         + 0.24 * latent_development;
}

int main(void) {
    double comp = compensatory_signal(0.52, 0.66, 0.48, 0.60);
    double recur = symbolic_recurrence(0.72, 0.56, 0.70);
    double dream_output = 0.52 * comp + 0.48 * recur + 0.38 * 0.48 + 0.32 * 0.70;
    double integration = 0.42 * 0.60 + 0.38 * 0.70 + 0.30 * 0.56 - 0.24 * fabs(comp);

    printf("Synthetic compensatory signal: %.3f\n", comp);
    printf("Synthetic symbolic recurrence: %.3f\n", recur);
    printf("Synthetic dream output: %.3f\n", dream_output);
    printf("Synthetic integration signal: %.3f\n", integration);
    return 0;
}
