! Jung, Alchemy, and Symbolic Transformation
! Fortran example: simple synthetic alchemical transformation score

program alchemical_transformation_demo
  implicit none

  real :: score

  score = 0.42 * 0.70 + 0.55 * 0.52 + 0.66 * 0.44 + &
          0.58 * 0.58 - 0.60 * 0.62 - 0.30 * abs(0.84)

  print *, "Synthetic alchemical transformation score:", score
end program alchemical_transformation_demo
