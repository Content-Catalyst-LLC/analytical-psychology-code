/*
Jung, Alchemy, and Symbolic Transformation
C example: simple synthetic alchemical transformation score

Synthetic educational demonstration only.
Not for diagnosis, therapy, spiritual direction, assessment, screening,
surveillance, or individual evaluation.
*/

#include <stdio.h>
#include <math.h>

double transformation_score(
    double nigredo_pressure,
    double albedo_clarity,
    double rubedo_vitality,
    double vessel_strength,
    double onesidedness,
    double mercurial_volatility
) {
    return 0.42 * nigredo_pressure
         + 0.55 * albedo_clarity
         + 0.66 * rubedo_vitality
         + 0.58 * vessel_strength
         - 0.60 * onesidedness
         - 0.30 * fabs(mercurial_volatility);
}

int main(void) {
    double score = transformation_score(0.70, 0.52, 0.44, 0.58, 0.62, 0.84);
    printf("Synthetic alchemical transformation score: %.3f\n", score);
    return 0;
}
