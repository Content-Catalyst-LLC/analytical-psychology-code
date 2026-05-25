/*
Persona and Social Adaptation in Analytical Psychology
C example: simple synthetic persona-role score

Synthetic educational demonstration only.
Not for diagnosis, therapy, employment screening, reputation scoring,
social scoring, surveillance, or individual evaluation.
*/

#include <stdio.h>
#include <math.h>

double persona_strength(
    double role_demand,
    double audience_reward,
    double institutional_reward,
    double inward_complexity,
    double reflective_flexibility
) {
    return 0.64 * role_demand
         + 0.48 * audience_reward
         + 0.36 * institutional_reward
         - 0.30 * inward_complexity
         + 0.42 * reflective_flexibility;
}

double persona_rigidity(
    double persona_strength_value,
    double status_dependence,
    double institutional_reward,
    double reflective_flexibility
) {
    return 0.52 * persona_strength_value
         + 0.42 * status_dependence
         + 0.34 * institutional_reward
         - 0.46 * reflective_flexibility;
}

double psychic_strain(
    double persona_strength_value,
    double persona_inward_gap,
    double persona_rigidity_value,
    double shadow_pressure,
    double reflective_flexibility
) {
    return 0.50 * persona_strength_value
         + 0.62 * persona_inward_gap * persona_inward_gap
         + 0.42 * persona_rigidity_value
         + 0.36 * shadow_pressure
         - 0.52 * reflective_flexibility;
}

int main(void) {
    double strength = persona_strength(0.66, 0.50, 0.60, 0.70, 0.76);
    double rigidity = persona_rigidity(strength, 0.34, 0.60, 0.76);
    double strain = psychic_strain(strength, 0.08, rigidity, 0.32, 0.76);

    printf("Synthetic persona strength: %.3f\n", strength);
    printf("Synthetic persona rigidity: %.3f\n", rigidity);
    printf("Synthetic psychic strain: %.3f\n", strain);
    return 0;
}
