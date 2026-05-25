# Active Imagination and the Practice of Symbolic Dialogue
# Julia conceptual simulation

using CSV
using DataFrames
using Statistics

article_dir = "articles/active-imagination-and-the-practice-of-symbolic-dialogue"
input_path = joinpath(article_dir, "data/raw/synthetic_active_imagination_dialogue.csv")
output_path = joinpath(article_dir, "outputs/tables/julia_dialogue_mode_summary.csv")

df = CSV.read(input_path, DataFrame)

df.ego_imaginal_balance =
    -1 .* (df.ego_mediation .- df.imaginal_activation).^2

df.destabilization_risk_model =
    0.54 .* df.imaginal_activation .-
    0.38 .* df.ego_mediation .-
    0.34 .* df.reflective_response

df.ethical_containment_model =
    0.42 .* df.ego_mediation .+
    0.36 .* df.reflective_response .+
    0.28 .* df.symbolic_relation .-
    0.24 .* abs.(df.imaginal_activation)

df.integration_score_model =
    0.56 .* df.ego_mediation .+
    0.52 .* df.imaginal_activation .+
    0.48 .* df.reflective_response .+
    0.44 .* df.symbolic_relation .+
    0.34 .* df.ethical_containment .-
    0.70 .* (df.ego_mediation .- df.imaginal_activation).^2 .-
    0.28 .* max.(df.destabilization_risk, 0)

summary = combine(
    groupby(df, :dialogue_mode),
    :ego_mediation => mean => :mean_ego_mediation,
    :imaginal_activation => mean => :mean_imaginal_activation,
    :reflective_response => mean => :mean_reflective_response,
    :symbolic_relation => mean => :mean_symbolic_relation,
    :ethical_containment => mean => :mean_ethical_containment,
    :destabilization_risk_model => mean => :mean_destabilization_risk_model,
    :integration_score_model => mean => :mean_integration_score_model
)

CSV.write(output_path, summary)
println(summary)
