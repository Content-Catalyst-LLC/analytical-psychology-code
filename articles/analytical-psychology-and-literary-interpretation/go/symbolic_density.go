package main

import "fmt"

func symbolicDensity(motifCount int, totalTokens int) float64 {
	if totalTokens <= 0 {
		return 0.0
	}
	return float64(motifCount) / float64(totalTokens)
}

func main() {
	score := symbolicDensity(8, 120)
	fmt.Printf("Synthetic symbolic-density score: %.4f\n", score)
}
