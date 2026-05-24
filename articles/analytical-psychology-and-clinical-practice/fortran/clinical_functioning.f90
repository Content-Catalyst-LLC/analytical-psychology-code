! Analytical Psychology and Clinical Practice
! Fortran example: simple synthetic clinical-functioning score

program clinical_functioning_demo
  implicit none

  real :: pressure
  real :: score

  pressure = 0.62 * 0.36 + 0.58 * 0.42 + 0.34 * 0.24 - &
             0.52 * 0.80 - 0.26 * 0.80

  score = -0.70 * 0.38 + 0.60 * 0.80 + 0.52 * 0.76 + &
          0.64 * 0.82 - 0.42 * pressure + 0.28 * 0.78 + &
          0.24 * 0.80

  print *, "Synthetic compensatory pressure:", pressure
  print *, "Synthetic clinical-functioning score:", score
end program clinical_functioning_demo
