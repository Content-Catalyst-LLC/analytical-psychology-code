! The Collective Unconscious: Meaning, Scope, and Controversy
! Fortran example: simple synthetic recurrence-strength score

program recurrence_strength_score_demo
  implicit none

  real :: score

  score = 0.34 * 0.72 + 0.30 * 0.66 + 0.28 * 0.58 - 0.42 * 0.44

  print *, "Synthetic recurrence strength after alternatives:", score
end program recurrence_strength_score_demo
