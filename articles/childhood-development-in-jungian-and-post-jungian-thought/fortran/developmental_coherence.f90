! Childhood Development in Jungian and Post-Jungian Thought
! Fortran example: simple synthetic developmental coherence score

program developmental_coherence_demo
  implicit none

  real :: strain
  real :: score

  strain = (0.82 - 0.90)**2 + (0.90 - 0.90)**2 + 0.18**2

  score = 0.55 * 0.82 + 0.70 * 0.90 + 0.60 * 0.90 + &
          0.48 * 0.82 + 0.34 * 0.90 - 0.50 * 0.18 - &
          0.24 * strain

  print *, "Synthetic developmental strain:", strain
  print *, "Synthetic developmental coherence score:", score
end program developmental_coherence_demo
