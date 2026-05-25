package main

import "fmt"

func cooccurrenceWeight(motifAPresent bool, motifBPresent bool) int {
	if motifAPresent && motifBPresent {
		return 1
	}
	return 0
}

func contextShare(contextCount float64, motifTotal float64) float64 {
	if motifTotal <= 0 {
		return 0
	}
	return contextCount / motifTotal
}

func main() {
	weight := cooccurrenceWeight(true, true)
	share := contextShare(4.0, 10.0)

	fmt.Printf("Synthetic motif co-occurrence weight: %d\n", weight)
	fmt.Printf("Synthetic context share: %.3f\n", share)
}
