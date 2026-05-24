package main

import "fmt"

func credibilityScore(interpretiveBreadth, empiricalSupport, culturalSpecificity, genderCriticalRevision, methodologicalExplicitness, clinicalUtility, universalization float64) float64 {
	return 0.48*interpretiveBreadth +
		0.56*empiricalSupport +
		0.62*culturalSpecificity +
		0.50*genderCriticalRevision +
		0.58*methodologicalExplicitness +
		0.46*clinicalUtility -
		0.72*universalization
}

func main() {
	score := credibilityScore(0.76, 0.50, 0.70, 0.64, 0.78, 0.85, 0.32)
	fmt.Printf("Synthetic credibility score: %.3f\n", score)
}
