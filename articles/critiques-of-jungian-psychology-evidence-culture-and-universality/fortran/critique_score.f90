! Critiques of Jungian Psychology: Evidence, Culture, and Universality
! Fortran example: simple synthetic credibility score

program critique_score_demo
  implicit none

  real :: interpretive_breadth, empirical_support, cultural_specificity
  real :: gender_critical_revision, methodological_explicitness
  real :: clinical_utility, universalization
  real :: score

  interpretive_breadth = 0.76
  empirical_support = 0.50
  cultural_specificity = 0.70
  gender_critical_revision = 0.64
  methodological_explicitness = 0.78
  clinical_utility = 0.85
  universalization = 0.32

  score = 0.48 * interpretive_breadth + 0.56 * empirical_support + &
          0.62 * cultural_specificity + 0.50 * gender_critical_revision + &
          0.58 * methodological_explicitness + 0.46 * clinical_utility - &
          0.72 * universalization

  print *, "Synthetic credibility score:", score
end program critique_score_demo
