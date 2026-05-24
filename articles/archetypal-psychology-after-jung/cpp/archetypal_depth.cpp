/*
Archetypal Psychology After Jung
C++ example: simple synthetic archetypal-depth score
*/

#include <iostream>
#include <iomanip>

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

int main() {
    double score = archetypal_depth(0.86, 0.91, 0.83, 0.64, 0.31);
    std::cout << "Synthetic archetypal-depth score: "
              << std::fixed << std::setprecision(3) << score << std::endl;
    return 0;
}
