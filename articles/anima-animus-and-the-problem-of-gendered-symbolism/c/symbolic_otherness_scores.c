#include <stdio.h>
#include <math.h>

double projection_intensity(double u, double a, double r, double d, double g, double m) {
    return 0.70*u + 0.65*a + 0.50*r + 0.34*d + 0.22*g - 0.55*m;
}

double symbolic_integration(double m, double f, double pr, double pi) {
    return 0.46*m + 0.42*f - 0.30*pr - 0.24*fabs(pi);
}

int main(void) {
    double projection = projection_intensity(0.66, 0.58, 0.42, 0.34, 0.34, 0.72);
    double integration = symbolic_integration(0.72, 0.72, 0.28, projection);
    printf("Synthetic projection intensity: %.3f\n", projection);
    printf("Synthetic symbolic integration: %.3f\n", integration);
    return 0;
}
