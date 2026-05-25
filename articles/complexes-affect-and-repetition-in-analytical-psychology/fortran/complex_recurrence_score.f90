! Complexes, Affect, and Repetition in Analytical Psychology
! Fortran example: simple synthetic recurrence-pressure score

program complex_recurrence_score_demo
  implicit none

  real :: score

  score = 0.86 + 0.82 + 0.44 + 0.50 - 0.36 - 0.30

  print *, "Synthetic recurrence pressure:", score
end program complex_recurrence_score_demo
