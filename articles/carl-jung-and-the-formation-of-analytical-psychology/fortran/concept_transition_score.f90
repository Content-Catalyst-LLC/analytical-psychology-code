! Carl Jung and the Formation of Analytical Psychology
! Fortran example: simple synthetic concept-transition score

program concept_transition_score_demo
  implicit none

  real :: score

  score = -0.20 * 0.30 + 0.35 * 0.88 + 0.40 * 0.80 + 0.45 * 0.74

  print *, "Synthetic concept-transition score:", score
end program concept_transition_score_demo
