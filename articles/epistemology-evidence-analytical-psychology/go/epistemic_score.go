package main

import "fmt"

func credibilityScore(empiricalSupport, hermeneuticCoherence, clinicalUtility, phenomenologicalAdequacy, contextualSpecificity, methodologicalExplicitness, ambiguityInflation float64) float64 {
	return 0.52*empiricalSupport +
		0.58*hermeneuticCoherence +
		0.62*clinicalUtility +
		0.56*phenomenologicalAdequacy +
		0.44*contextualSpecificity +
		0.60*methodologicalExplicitness -
		0.72*ambiguityInflation
}

func main() {
	score := credibilityScore(0.42, 0.84, 0.78, 0.81, 0.68, 0.72, 0.28)
	fmt.Printf("Synthetic credibility score: %.3f\n", score)
}
