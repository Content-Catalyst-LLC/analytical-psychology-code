/*
Archetypal Psychology After Jung
C example: simple synthetic archetypal-depth score

Synthetic educational demonstration only.
Not for diagnosis, assessment, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double archetypal_depth(
    double psychic_plurality,
    double imaginal_density,
    double metaphorical_richness,
    double symptom_image_intensity,
    double integrative_pressure
) {
    return 0.65 * psychic_plurality
         + 0.70 * imaginal_density
         + 0.58 * metaphorical_richness
         + 0.46 * symptom_image_intensity
         - 0.55 * integrative_pressure;
}

int main(void) {
    double score = archetypal_depth(0.86, 0.91, 0.83, 0.64, 0.31);
    printf("Synthetic archetypal-depth score: %.3f\n", score);
    return 0;
}
