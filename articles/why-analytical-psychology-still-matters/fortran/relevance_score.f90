! Why Analytical Psychology Still Matters
! Fortran example: simple conceptual relevance score

program relevance_score_demo
  implicit none

  real :: symbolic_depth, meaning_coherence, clinical_utility
  real :: cultural_interpretive_power, revision_capacity, doctrinal_rigidity
  real :: score

  symbolic_depth = 0.82
  meaning_coherence = 0.74
  clinical_utility = 0.58
  cultural_interpretive_power = 0.77
  revision_capacity = 0.69
  doctrinal_rigidity = 0.21

  score = 0.62 * symbolic_depth + 0.58 * meaning_coherence + &
          0.54 * clinical_utility + 0.48 * cultural_interpretive_power + &
          0.60 * revision_capacity - 0.70 * doctrinal_rigidity

  print *, "Synthetic relevance score:", score
end program relevance_score_demo
