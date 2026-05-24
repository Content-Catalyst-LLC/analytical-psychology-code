! Jung, Freud, and the Divergence of Depth Psychologies
! Fortran example: simple synthetic depth-psychology comparison score

program depth_score_demo
  implicit none

  real :: f, j

  f = 0.66 * 0.84 + 0.70 * 0.78 + 0.62 * 0.82 + &
      0.58 * 0.76 + 0.50 * 0.69 - 0.30 * 0.28

  j = 0.58 * 0.36 + 0.70 * 0.30 + 0.62 * 0.34 + &
      0.64 * 0.28 + 0.60 * 0.38 + 0.56 * 0.32 - 0.24 * 0.84

  print *, "Synthetic Freudian score:", f
  print *, "Synthetic Jungian score:", j
end program depth_score_demo
