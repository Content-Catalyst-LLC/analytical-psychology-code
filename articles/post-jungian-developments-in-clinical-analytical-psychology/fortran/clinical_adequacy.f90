! Post-Jungian Developments in Clinical Analytical Psychology
! Fortran example: simple synthetic clinical-adequacy score

program clinical_adequacy_demo
  implicit none

  real :: score

  score = 0.50 * 0.84 + 0.62 * 0.86 + 0.58 * 0.82 + &
          0.66 * 0.86 + 0.52 * 0.82 + 0.46 * 0.78 - &
          0.60 * 0.24

  print *, "Synthetic clinical-adequacy score:", score
end program clinical_adequacy_demo
