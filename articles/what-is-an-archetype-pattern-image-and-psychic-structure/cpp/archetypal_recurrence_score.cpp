#include <iomanip>
#include <iostream>

double recurrence_strength(double cluster_stability, double weighted_cooccurrence, double cross_context_recurrence, double cultural_flattening_risk) {
    return 0.34 * cluster_stability + 0.30 * weighted_cooccurrence + 0.28 * cross_context_recurrence - 0.42 * cultural_flattening_risk;
}

int main() {
    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic recurrence strength: " << recurrence_strength(0.72, 0.66, 0.58, 0.30) << std::endl;
    return 0;
}
