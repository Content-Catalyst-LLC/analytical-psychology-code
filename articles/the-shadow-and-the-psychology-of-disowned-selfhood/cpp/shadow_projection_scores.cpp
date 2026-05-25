/*
The Shadow and the Psychology of Disowned Selfhood
C++ example: simple synthetic shadow-projection score
*/

#include <cmath>
#include <iomanip>
#include <iostream>

double shadow_activation(
    double latent_disowned,
    double cue_intensity,
    double shadow_discrepancy,
    double affective_charge,
    double reflective_capacity
) {
    return 0.72 * latent_disowned * cue_intensity
         + 0.56 * shadow_discrepancy
         + 0.42 * affective_charge
         - 0.48 * reflective_capacity;
}

double projection_intensity(
    double shadow_activation_value,
    double affective_charge,
    double persona_rigidity,
    double reflective_capacity
) {
    return 0.76 * shadow_activation_value
         + 0.44 * affective_charge
         + 0.32 * persona_rigidity
         - 0.56 * reflective_capacity;
}

double integration_capacity(
    double reflective_capacity,
    double projection_intensity_value,
    double shame_response,
    double developmental_time
) {
    return 0.50 * reflective_capacity
         - 0.34 * std::fabs(projection_intensity_value)
         - 0.26 * shame_response
         + 0.28 * developmental_time;
}

int main() {
    double shadow = shadow_activation(0.58, 0.46, 0.02, 0.48, 0.74);
    double projection = projection_intensity(shadow, 0.48, 0.52, 0.74);
    double integration = integration_capacity(0.74, projection, 0.24, 1.0);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic shadow activation: " << shadow << std::endl;
    std::cout << "Synthetic projection intensity: " << projection << std::endl;
    std::cout << "Synthetic integration capacity: " << integration << std::endl;
    return 0;
}
