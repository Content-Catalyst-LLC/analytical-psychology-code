! Epistemology and Evidence in Analytical Psychology
! Fortran example: simple synthetic credibility score

program epistemic_score_demo
  implicit none

  real :: empirical_support, hermeneutic_coherence, clinical_utility
  real :: phenomenological_adequacy, contextual_specificity
  real :: methodological_explicitness, ambiguity_inflation
  real :: score

  empirical_support = 0.42
  hermeneutic_coherence = 0.84
  clinical_utility = 0.78
  phenomenological_adequacy = 0.81
  contextual_specificity = 0.68
  methodological_explicitness = 0.72
  ambiguity_inflation = 0.28

  score = 0.52 * empirical_support + 0.58 * hermeneutic_coherence + &
          0.62 * clinical_utility + 0.56 * phenomenological_adequacy + &
          0.44 * contextual_specificity + 0.60 * methodological_explicitness - &
          0.72 * ambiguity_inflation

  print *, "Synthetic credibility score:", score
end program epistemic_score_demo
