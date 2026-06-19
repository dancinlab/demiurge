# window-ceiling lane r1 — VERDICT 🔵 single-target ceiling (theorem) · 🟠 global (tech-limit)

## CEILING RELATION
f_clear(T) ≤ p_dep(T) · F_b(D_tox)
   p_dep(T) = senescent fraction whose survival-critical SCAP = T
   F_b = CDF of survival buffer at max safe dose D_tox = TW·EC50_sen, TW = EC50_healthy/EC50_sen
HARD ceiling (heterogeneity): f_clear ≤ p_dep(T) — other-SCAP cells refractory at ANY dose.
WINDOW-CLOSURE (the wall): EC50_healthy(T) ≤ EC50_sen,tail(T)  [canonical: navitoclax/BCL-xL ↔ platelets].

## THEOREM vs TECH-LIMIT (d6)
THEOREM (binds): SenePy/SenNet — "no gene present in every signature" ⇒ p_dep(T)<1 for every single T ⇒ f_clear(single-agent)<1 NECESSARILY.
TECH-LIMIT (does NOT bind): union over k orthogonal targets f_clear ≤ 1−∏(1−p_dep·F_b) → 1. Heterogeneity = COVERING problem, escapable — IFF toxicity tissues are orthogonal.

## NUMBERS (numpy mixture)
single-target: p_dep 35/55/75% → f_clear caps ≤35/55/75% (TW 3→10× moves only ~3-6pts: dose can't cross refractory fraction).
combo (orthogonal, p_dep .5, capture .85, tox 12%/target): k=1 net +30.5% · k=3 +49.1% · k=5 +46.5%.
ADVERSARIAL (shared tox tissue 35%/target): net +7.5%→+5.3% — window never opens. Escape conditional on TOXICITY-orthogonality.

## CITATIONS
SenePy 10.1038/s41467-025-57047-7 · SenMayo 10.1038/s41467-022-32552-1 · SenNet · navitoclax platelet PROTAC 10.1038/s41467-020-15838-0 · window<1 order Aging Cell PMC7617571 · MCL-1 senolytic PMC9023465.

## CAVEATS (d6)
Hard ceiling theorem-grade ONLY for single-agent monotherapy; the true global wall lives one level down = toxicity-orthogonality of the target set. p_dep not yet measured at population resolution (needs functional BH3 dependency atlas).
