package main

import "fmt"

func crisisRisk(numinousIntensity, traumaVulnerability, practiceIntensity, sleepDisruption, symbolicContainment, egoStability, shadowAwareness, relationalSupport float64) float64 {
	return 0.75*numinousIntensity +
		0.45*traumaVulnerability +
		0.35*practiceIntensity +
		0.30*sleepDisruption -
		0.55*symbolicContainment -
		0.60*egoStability -
		0.40*shadowAwareness -
		0.35*relationalSupport
}

func main() {
	score := crisisRisk(0.88, 0.60, 0.78, 0.66, 0.42, 0.48, 0.42, 0.34)
	fmt.Printf("Synthetic numinous crisis-risk score: %.3f\n", score)
}
