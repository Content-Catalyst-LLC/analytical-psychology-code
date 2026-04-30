"""Synthetic analytical psychology simulation.

This script creates toy symbolic-process data for article examples.
It is educational only and not a clinical, diagnostic, therapeutic,
or automated dream-interpretation tool.
"""

from pathlib import Path
import csv
import random

random.seed(2424)

n_people = 230
n_periods = 20

people = []

for person_index in range(1, n_people + 1):
    people.append({
        "person_id": f"P{person_index:03d}",
        "symbolic_access": random.uniform(0.20, 0.90),
        "ego_differentiation": random.uniform(0.20, 0.90),
        "affective_containment": random.uniform(0.20, 0.90),
        "relational_depth": random.uniform(0.20, 0.90),
        "transformative_processing": random.uniform(0.20, 0.90),
        "fragmentation_pressure": random.uniform(0.10, 0.90),
    })

records = []
dream_codes = []
observation_id = 1
code_id = 1

symbols = [
    "threshold",
    "shadow_figure",
    "water",
    "tower",
    "animal",
    "child",
    "descent",
    "fire",
    "mirror",
    "journey",
]

for period in range(1, n_periods + 1):
    cultural_mediation = random.uniform(0.15, 0.95)

    for person in people:
        psyche_score = (
            0.15 * person["symbolic_access"] +
            0.14 * person["ego_differentiation"] +
            0.13 * person["affective_containment"] +
            0.13 * person["relational_depth"] +
            0.14 * person["transformative_processing"] +
            0.10 * cultural_mediation -
            0.17 * person["fragmentation_pressure"] +
            random.gauss(0.0, 0.03)
        )

        psyche_score = max(0.0, min(1.0, psyche_score))
        high_integration = int(psyche_score >= 0.65)

        records.append({
            "observation_id": observation_id,
            "person_id": person["person_id"],
            "period": period,
            "cultural_mediation": round(cultural_mediation, 3),
            "psyche_score": round(psyche_score, 3),
            "symbolic_access": round(person["symbolic_access"], 3),
            "ego_differentiation": round(person["ego_differentiation"], 3),
            "affective_containment": round(person["affective_containment"], 3),
            "relational_depth": round(person["relational_depth"], 3),
            "transformative_processing": round(person["transformative_processing"], 3),
            "fragmentation_pressure": round(person["fragmentation_pressure"], 3),
            "high_psychic_integration": high_integration,
        })

        for symbol in random.sample(symbols, k=2):
            dream_codes.append({
                "code_id": code_id,
                "person_id": person["person_id"],
                "period": period,
                "symbol_label": symbol,
                "affective_charge": round(random.uniform(0.10, 0.95), 3),
                "recurrence_count": random.randint(1, 5),
                "interpretive_openness": round(random.uniform(0.10, 0.95), 3),
            })
            code_id += 1

        person["ego_differentiation"] = max(
            0.0,
            min(1.0, person["ego_differentiation"] + 0.02 * (psyche_score - 0.4))
        )
        person["affective_containment"] = max(
            0.0,
            min(1.0, person["affective_containment"] + 0.02 * (psyche_score - 0.4))
        )
        person["transformative_processing"] = max(
            0.0,
            min(1.0, person["transformative_processing"] + 0.02 * (psyche_score - 0.4))
        )
        person["fragmentation_pressure"] = max(
            0.0,
            min(1.0, person["fragmentation_pressure"] - 0.01 * psyche_score)
        )

        observation_id += 1

processed = Path(__file__).resolve().parents[1] / "data" / "processed"
processed.mkdir(parents=True, exist_ok=True)

observations_path = processed / "synthetic_symbolic_observations.csv"
codes_path = processed / "synthetic_dream_symbol_codes.csv"

for path, rows in [
    (observations_path, records),
    (codes_path, dream_codes),
]:
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)

print(f"Wrote {len(records)} symbolic observations to {observations_path}")
print(f"Wrote {len(dream_codes)} dream-symbol codes to {codes_path}")
