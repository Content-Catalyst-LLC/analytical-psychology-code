package main

import "fmt"

func integrationScore(numinousIntensity, symbolicContainment, egoStability, shadowAwareness, ritualSupport, religiousTraumaPressure float64) float64 {
	containmentGap := numinousIntensity - symbolicContainment
	return 0.60*symbolicContainment +
		0.55*egoStability +
		0.48*shadowAwareness +
		0.42*ritualSupport +
		0.36*numinousIntensity -
		0.65*containmentGap*containmentGap -
		0.30*religiousTraumaPressure
}

func main() {
	score := integrationScore(0.78, 0.82, 0.74, 0.66, 0.84, 0.22)
	fmt.Printf("Synthetic religion/spiritual-experience integration score: %.3f\n", score)
}
