/*
Dreams, Compensation, and the Prospective Function
C++ example: simple synthetic dream-dynamics score
*/

#include <cmath>
#include <iomanip>
#include <iostream>

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

int main() {
    double comp = compensatory_intensity(0.52, 0.66, 0.48, 0.60);
    double prosp = prospective_intensity(0.72, 0.56, 0.60, 0.72);
    double dream_output = 0.55 * comp + 0.52 * prosp + 0.40 * 0.48 + 0.32 * 0.72;
    double integration = 0.44 * prosp + 0.36 * 0.60 + 0.30 * 0.56 - 0.24 * std::fabs(comp);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic compensatory intensity: " << comp << std::endl;
    std::cout << "Synthetic prospective intensity: " << prosp << std::endl;
    std::cout << "Synthetic dream output: " << dream_output << std::endl;
    std::cout << "Synthetic integration signal: " << integration << std::endl;

    return 0;
}
