program symbolic_otherness_scores_demo
  implicit none
  real :: projection
  real :: integration

  projection = 0.70 * 0.66 + 0.65 * 0.58 + 0.50 * 0.42 + &
               0.34 * 0.34 + 0.22 * 0.34 - 0.55 * 0.72
  integration = 0.46 * 0.72 + 0.42 * 0.72 - 0.30 * 0.28 - &
                0.24 * abs(projection)

  print *, "Synthetic projection intensity:", projection
  print *, "Synthetic symbolic integration:", integration
end program symbolic_otherness_scores_demo
