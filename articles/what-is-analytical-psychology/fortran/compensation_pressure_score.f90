! What Is Analytical Psychology?
! Fortran example: simple synthetic compensation-pressure score

program compensation_pressure_score_demo
  implicit none

  real :: score

  score = 0.82 + 0.74 + 0.68 - 0.36

  print *, "Synthetic compensation pressure:", score
end program compensation_pressure_score_demo
