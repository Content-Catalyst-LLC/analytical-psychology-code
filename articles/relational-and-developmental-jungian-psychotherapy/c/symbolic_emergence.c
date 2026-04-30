#include <stdio.h>

// Toy symbolic emergence score.
// Educational only.
// Compile with: cc c/symbolic_emergence.c -o outputs/symbolic_emergence

double symbolic_emergence_score(double dream_intensity, double affective_charge, double openness, double salience, double resistance) {
    return 0.22 * dream_intensity + 0.22 * affective_charge + 0.20 * openness + 0.20 * salience - 0.24 * resistance;
}

int main(void) {
    double score = symbolic_emergence_score(0.75, 0.80, 0.65, 0.70, 0.30);
    printf("Symbolic emergence score: %.3f\n", score);
    return 0;
}
