# Toy analytical psychology integration update model.
# Educational only.

psychic_integration = 0.42
symbolic_access = 0.70
ego_differentiation = 0.58
affective_containment = 0.62
relational_depth = 0.66
transformative_processing = 0.55
fragmentation_pressure = 0.35
rate = 0.08

for t in 1:20
    psychic_integration = psychic_integration +
        rate * (
            0.18 * symbolic_access +
            0.17 * ego_differentiation +
            0.16 * affective_containment +
            0.16 * relational_depth +
            0.17 * transformative_processing -
            0.20 * fragmentation_pressure
        )

    psychic_integration = clamp(psychic_integration, 0.0, 1.0)
    println("Time ", t, ": psychic integration = ", round(psychic_integration, digits=3))
end
