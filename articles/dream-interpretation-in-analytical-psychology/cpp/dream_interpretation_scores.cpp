/*
Dream Interpretation in Analytical Psychology
C++ example: simple synthetic dream-compensation score
*/

#include <cmath>
#include <iomanip>
#include <iostream>

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

int main() {
    double comp = compensatory_signal(0.52, 0.66, 0.48, 0.60);
    double recur = symbolic_recurrence(0.72, 0.56, 0.70);
    double dream_output = 0.52 * comp + 0.48 * recur + 0.38 * 0.48 + 0.32 * 0.70;
    double integration = 0.42 * 0.60 + 0.38 * 0.70 + 0.30 * 0.56 - 0.24 * std::fabs(comp);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic compensatory signal: " << comp << std::endl;
    std::cout << "Synthetic symbolic recurrence: " << recur << std::endl;
    std::cout << "Synthetic dream output: " << dream_output << std::endl;
    std::cout << "Synthetic integration signal: " << integration << std::endl;

    return 0;
}
