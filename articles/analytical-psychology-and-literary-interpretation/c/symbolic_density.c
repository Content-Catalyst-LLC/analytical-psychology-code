/*
Analytical Psychology and Literary Interpretation
C example: simple symbolic-density score

Synthetic educational demonstration only.
Not for author diagnosis, automated interpretation, grading,
canon ranking, cultural ranking, screening, surveillance, or individual evaluation.
*/

#include <stdio.h>

double symbolic_density(int motif_count, int total_tokens) {
    if (total_tokens <= 0) {
        return 0.0;
    }
    return (double) motif_count / (double) total_tokens;
}

int main(void) {
    int motif_count = 8;
    int total_tokens = 120;
    printf("Synthetic symbolic-density score: %.4f\n", symbolic_density(motif_count, total_tokens));
    return 0;
}
