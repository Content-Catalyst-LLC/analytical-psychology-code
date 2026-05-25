/*
Myth, Symbol, and the Archetypal Imagination
C example: simple motif co-occurrence weight

Synthetic educational demonstration only.
Not for proving archetypes, interpreting private dreams, classifying religions,
ranking cultures, or replacing cultural, historical, theological, literary,
political, or clinical expertise.
*/

#include <stdio.h>

int cooccurrence_weight(int motif_a_present, int motif_b_present) {
    return (motif_a_present && motif_b_present) ? 1 : 0;
}

double context_share(double context_count, double motif_total) {
    if (motif_total <= 0.0) {
        return 0.0;
    }
    return context_count / motif_total;
}

int main(void) {
    int weight = cooccurrence_weight(1, 1);
    double share = context_share(4.0, 10.0);

    printf("Synthetic motif co-occurrence weight: %d\n", weight);
    printf("Synthetic context share: %.3f\n", share);
    return 0;
}
