package main

import "fmt"

func destabilizationRisk(
	imaginalActivation,
	egoMediation,
	reflectiveResponse float64,
) float64 {
	return 0.54*imaginalActivation -
		0.38*egoMediation -
		0.34*reflectiveResponse
}

func symbolicIntegration(
	egoMediation,
	imaginalActivation,
	reflectiveResponse,
	symbolicRelation,
	ethicalContainment,
	destabilization float64,
) float64 {
	imbalance := egoMediation - imaginalActivation
	positiveDestabilization := destabilization
	if positiveDestabilization < 0 {
		positiveDestabilization = 0
	}

	return 0.56*egoMediation +
		0.52*imaginalActivation +
		0.48*reflectiveResponse +
		0.44*symbolicRelation +
		0.34*ethicalContainment -
		0.70*imbalance*imbalance -
		0.28*positiveDestabilization
}

func main() {
	risk := destabilizationRisk(0.56, 0.88, 0.88)
	score := symbolicIntegration(0.88, 0.56, 0.88, 0.90, 0.86, risk)

	fmt.Printf("Synthetic destabilization risk: %.3f\n", risk)
	fmt.Printf("Synthetic symbolic integration score: %.3f\n", score)
}
