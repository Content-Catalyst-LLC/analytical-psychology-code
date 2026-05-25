/*
Active Imagination and the Practice of Symbolic Dialogue
C++ example: simple synthetic symbolic-integration score
*/

#include <algorithm>
#include <iomanip>
#include <iostream>

double destabilization_risk(
    double imaginal_activation,
    double ego_mediation,
    double reflective_response
) {
    return 0.54 * imaginal_activation
         - 0.38 * ego_mediation
         - 0.34 * reflective_response;
}

double symbolic_integration(
    double ego_mediation,
    double imaginal_activation,
    double reflective_response,
    double symbolic_relation,
    double ethical_containment,
    double destabilization
) {
    double imbalance = ego_mediation - imaginal_activation;
    double positive_destabilization = std::max(destabilization, 0.0);

    return 0.56 * ego_mediation
         + 0.52 * imaginal_activation
         + 0.48 * reflective_response
         + 0.44 * symbolic_relation
         + 0.34 * ethical_containment
         - 0.70 * imbalance * imbalance
         - 0.28 * positive_destabilization;
}

int main() {
    double risk = destabilization_risk(0.56, 0.88, 0.88);
    double score = symbolic_integration(0.88, 0.56, 0.88, 0.90, 0.86, risk);

    std::cout << "Synthetic destabilization risk: "
              << std::fixed << std::setprecision(3)
              << risk << std::endl;

    std::cout << "Synthetic symbolic integration score: "
              << std::fixed << std::setprecision(3)
              << score << std::endl;
    return 0;
}
