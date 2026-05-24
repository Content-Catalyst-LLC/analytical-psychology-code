! Non-Western Symbol Systems and the Limits of Jungian Universality
! Fortran example: simple synthetic comparative-quality score

program comparative_quality_demo
  implicit none

  real :: recurrence, specificity, linguistic_depth, ritual_context
  real :: dialogical_accountability, universalizing_force, abstraction_pressure
  real :: score

  recurrence = 0.76
  specificity = 0.84
  linguistic_depth = 0.79
  ritual_context = 0.87
  dialogical_accountability = 0.77
  universalizing_force = 0.27
  abstraction_pressure = 0.30

  score = 0.52 * recurrence + 0.68 * specificity + &
          0.58 * linguistic_depth + 0.54 * ritual_context + &
          0.62 * dialogical_accountability - 0.66 * universalizing_force - &
          0.42 * abstraction_pressure

  print *, "Synthetic comparative-quality score:", score
end program comparative_quality_demo
