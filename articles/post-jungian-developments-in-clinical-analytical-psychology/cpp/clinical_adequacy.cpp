/*
Post-Jungian Developments in Clinical Analytical Psychology
C++ example: simple synthetic clinical-adequacy score
*/

#include <iostream>
#include <iomanip>

double clinical_adequacy(
    double symbolic_depth,
    double relational_sophistication,
    double developmental_precision,
    double trauma_sensitivity,
    double embodied_regulation,
    double cultural_responsiveness,
    double doctrinal_rigidity
) {
    return 0.50 * symbolic_depth
         + 0.62 * relational_sophistication
         + 0.58 * developmental_precision
         + 0.66 * trauma_sensitivity
         + 0.52 * embodied_regulation
         + 0.46 * cultural_responsiveness
         - 0.60 * doctrinal_rigidity;
}

int main() {
    double score = clinical_adequacy(0.84, 0.86, 0.82, 0.86, 0.82, 0.78, 0.24);
    std::cout << "Synthetic clinical-adequacy score: "
              << std::fixed << std::setprecision(3) << score << std::endl;
    return 0;
}
