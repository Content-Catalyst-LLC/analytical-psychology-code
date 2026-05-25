! The Personal Unconscious and the Theory of Complexes
! Fortran example: simple synthetic complex-pressure score

program complex_pressure_score_demo
  implicit none

  real :: score

  score = 0.86 + 0.82 + 0.72 + 0.44 + 0.50 - 0.36 - 0.30

  print *, "Synthetic complex pressure:", score
end program complex_pressure_score_demo
