/*
Myth, Symbol, and the Archetypal Imagination
C++ example: simple motif co-occurrence weight
*/

#include <iomanip>
#include <iostream>

int cooccurrence_weight(bool motif_a_present, bool motif_b_present) {
    return (motif_a_present && motif_b_present) ? 1 : 0;
}

double context_share(double context_count, double motif_total) {
    if (motif_total <= 0.0) {
        return 0.0;
    }
    return context_count / motif_total;
}

int main() {
    int weight = cooccurrence_weight(true, true);
    double share = context_share(4.0, 10.0);

    std::cout << "Synthetic motif co-occurrence weight: "
              << weight << std::endl;

    std::cout << "Synthetic context share: "
              << std::fixed << std::setprecision(3)
              << share << std::endl;

    return 0;
}
