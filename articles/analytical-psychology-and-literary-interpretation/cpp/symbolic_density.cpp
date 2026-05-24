/*
Analytical Psychology and Literary Interpretation
C++ example: simple symbolic-density score
*/

#include <iostream>
#include <iomanip>

double symbolic_density(int motif_count, int total_tokens) {
    if (total_tokens <= 0) {
        return 0.0;
    }
    return static_cast<double>(motif_count) / static_cast<double>(total_tokens);
}

int main() {
    int motif_count = 8;
    int total_tokens = 120;

    std::cout << "Synthetic symbolic-density score: "
              << std::fixed << std::setprecision(4)
              << symbolic_density(motif_count, total_tokens)
              << std::endl;
    return 0;
}
