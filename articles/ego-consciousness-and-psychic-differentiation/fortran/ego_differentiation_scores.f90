! Ego, Consciousness, and Psychic Differentiation
! Fortran example: simple synthetic ego-differentiation score

program ego_differentiation_scores_demo
  implicit none

  real :: coherence
  real :: strain

  coherence = 0.72 * 0.80 - 0.48 * 0.54 + 0.60 * 0.72 - 0.22 * 0.08
  strain = 0.40 * 0.08 + 0.46 * 0.54 + 0.42 * 0.54 + 0.34 * 0.20 - 0.44 * 0.72

  print *, "Synthetic ego coherence:", coherence
  print *, "Synthetic psychic strain:", strain
end program ego_differentiation_scores_demo
