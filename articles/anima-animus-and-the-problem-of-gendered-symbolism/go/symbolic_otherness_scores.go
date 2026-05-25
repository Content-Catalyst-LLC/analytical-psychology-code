package main

import (
	"fmt"
	"math"
)

func projectionIntensity(u, a, r, d, g, m float64) float64 {
	return 0.70*u + 0.65*a + 0.50*r + 0.34*d + 0.22*g - 0.55*m
}

func symbolicIntegration(m, f, pr, pi float64) float64 {
	return 0.46*m + 0.42*f - 0.30*pr - 0.24*math.Abs(pi)
}

func main() {
	projection := projectionIntensity(0.66, 0.58, 0.42, 0.34, 0.34, 0.72)
	integration := symbolicIntegration(0.72, 0.72, 0.28, projection)
	fmt.Printf("Synthetic projection intensity: %.3f\n", projection)
	fmt.Printf("Synthetic symbolic integration: %.3f\n", integration)
}
