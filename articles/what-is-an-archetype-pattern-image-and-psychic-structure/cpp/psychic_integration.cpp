#include <iostream>

// Toy psychic integration score.
// Educational only.
// Compile with: g++ cpp/psychic_integration.cpp -o outputs/psychic_integration

int main() {
    double symbolic_access = 0.72;
    double ego_differentiation = 0.66;
    double affective_containment = 0.64;
    double relational_depth = 0.70;
    double transformative_processing = 0.68;
    double cultural_mediation = 0.55;
    double fragmentation_pressure = 0.30;

    double integration =
        0.14 * symbolic_access +
        0.14 * ego_differentiation +
        0.13 * affective_containment +
        0.13 * relational_depth +
        0.14 * transformative_processing +
        0.10 * cultural_mediation -
        0.16 * fragmentation_pressure;

    std::cout << "Psychic integration score: " << integration << "\n";
    return 0;
}
