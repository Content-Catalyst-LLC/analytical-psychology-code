/*
Dreams, Compensation, and the Prospective Function
C example: simple synthetic dream-dynamics score

Synthetic educational demonstration only.
Not for diagnosis, therapy, dream interpretation, mental-health evaluation,
crisis intervention, prediction, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>
#include <math.h>

double compensatory_intensity(
    double conscious_onesidedness,
    double unconscious_pressure,
    double affective_intensity,
    double reflective_capacity
) {
    return 0.72 * (unconscious_pressure - conscious_onesidedness)
         + 0.36 * affective_intensity
         - 0.22 * reflective_capacity;
}

double prospective_intensity(
    double latent_growth,
    double symbolic_literacy,
    double reflective_capacity,
    double previous_dream_output
) {
    return 0.64 * latent_growth
         + 0.28 * symbolic_literacy
         + 0.22 * reflective_capacity
         + 0.18 * previous_dream_output;
}

int main(void) {
    double comp = compensatory_intensity(0.52, 0.66, 0.48, 0.60);
    double prosp = prospective_intensity(0.72, 0.56, 0.60, 0.72);
    double dream_output = 0.55 * comp + 0.52 * prosp + 0.40 * 0.48 + 0.32 * 0.72;
    double integration = 0.44 * prosp + 0.36 * 0.60 + 0.30 * 0.56 - 0.24 * fabs(comp);

    printf("Synthetic compensatory intensity: %.3f\n", comp);
    printf("Synthetic prospective intensity: %.3f\n", prosp);
    printf("Synthetic dream output: %.3f\n", dream_output);
    printf("Synthetic integration signal: %.3f\n", integration);
    return 0;
}
