/*
Complexes, Affect, and Repetition in Analytical Psychology
C++ example: simple synthetic recurrence-pressure score
*/

#include <iomanip>
#include <iostream>

double recurrence_pressure(
    double complex_activation,
    double affect_intensity,
    double projection_pressure,
    double transference_pressure,
    double regulation_capacity,
    double relational_buffer
) {
    return complex_activation
         + affect_intensity
         + projection_pressure
         + transference_pressure
         - regulation_capacity
         - relational_buffer;
}

int main() {
    double score = recurrence_pressure(0.86, 0.82, 0.44, 0.50, 0.36, 0.30);

    std::cout << std::fixed << std::setprecision(3);
    std::cout << "Synthetic recurrence pressure: " << score << std::endl;
    return 0;
}
