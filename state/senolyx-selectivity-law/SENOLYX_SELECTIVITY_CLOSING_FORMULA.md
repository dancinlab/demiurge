# SENOLYX 선택성 발견 — 종결식 (FINAL, 4-lens converged) · 2026-06-19

**Question closed:** can a selective senolytic with a usable therapeutic window be found, what is
the selectivity ceiling, and what is the breakthrough route? (the senolytics analog of the RTSC
material-discovery closing formula — affinity-axis depleted at the FF ceiling, pivoted to LAW hunt.)

## THE CLOSING FORMULA — selectivity is a DIFFERENTIAL-DEPENDENCY quantity, ceiling-bound, AND-gate-escapable

Three coupled relations (scap-law · window-ceiling · selectivity-escape, all corpus-confirmed):

  ┌ (1) SELECTIVITY LAW  — selectivity is ORTHOGONAL TO AFFINITY
  │     kill occupancy  x* = (B − A)/(f·B)   [A=activator BH3 stress, B=anti-apoptotic buffer,
  │                                           f=fraction of B on the DRUGGED protein, x=occupancy]
  │     selectivity exists ⟺ Δx* = (B_q−A_q)/(f_q·B_q) − (B_s−A_s)/(f_s·B_s) > 0
  │     dominant lever = f_s ≫ f_q.  ΔG_bind (affinity) is ABSENT from Δx*  ⇒ ABFE wall explained:
  │     selectivity is a differential-dependency quantity, not a binding-affinity quantity.
  │
  ├ (2) CEILING  — single-target monotherapy is theorem-bounded
  │     f_clear(T) ≤ p_dep(T) · F_b(D_tox)            [p_dep = senescent fraction depending on SCAP T]
  │     window closes (wall) when  EC50_healthy(T) ≤ EC50_sen,tail(T)   [navitoclax ↔ platelet BCL-xL]
  │     THEOREM (SenePy: "no gene in every signature" ⇒ p_dep<1 ⇒ f_clear(single-agent)<1) — binds
  │       any single-SCAP agent and any dose-escalation (refractory other-SCAP fraction invariant in TW).
  │
  └ (3) ESCAPE  — multiplicative AND-gate on ORTHOGONAL axes (the only mathematical escape)
        S_total = ∏ S_i   (independent markers)  — escapes the additive single-target cap
        valid ONLY if (a) axes orthogonal/independent (ρ→0)  AND  (b) ~zero systemic leak
          ρ=0.6 collapses 25×→9.5× ; 10% leak drags 80×→57× (Nav-Gal measured 35× ⇒ ~31% leak)
        toxicity must ALSO be orthogonal (shared-tox combo: net window +7.5%→+5.3%, never opens)
        + PAN-SENESCENT axis (GLS1) escapes the DIFFERENT (heterogeneity) wall; PROTAC decouples dose↔tox.

## THE DISCOVERY RECIPE (actionable payoff — what to build, what to STOP doing)
STOP optimizing absolute binding affinity (ABFE/RBFE — the depleted, mechanistically-wrong axis).
DESIGN OBJECTIVE = maximize the DIFFERENTIAL dependency f_s/f_q, screened by **selective-peptide BH3
profiling Δ (HRK/NOXA), not by Kd**. Then escape both walls at once:
  • build a MULTIPLICATIVE AND-gate on ORTHOGONAL axes — metabolic(GLS1) × surface(uPAR) × lysosomal(SA-β-gal)
  • on a PAN-SENESCENT backbone (covers the heterogeneity ceiling)
  • with EVENT-DRIVEN (PROTAC/glue) pharmacology to decouple dose from on-target healthy toxicity.
The unexplored NOVEL frontier (d_novel_only): an orthogonal AND-gate on a pan-senescent axis — no
primary paper yet quantifies a 2-marker senescence selectivity factor.

## VERDICT (honest, d6)
- The AFFINITY axis is CLOSED twice over: empirically (FF ceiling, R12 RBFE close-negative) AND
  mechanistically (selectivity is orthogonal to ΔG_bind — affinity is absent from Δx*). Our own R13
  ABFE proves it: BCLXL −29.28 (huge affinity) is the WORST selectivity target (navitoclax lesson).
- SINGLE-TARGET monotherapy is THEOREM-ceiling-bound (heterogeneity: p_dep<1). Not escapable by dose.
- An ESCAPE EXISTS (multiplicative AND-gate on orthogonal axes + pan-senescent backbone + PROTAC
  dose-decoupling) but is CONDITIONAL (independence + leak + toxicity-orthogonality) and, to date,
  CLINICALLY UNPROVEN — every clinical readout is a Ph2 miss (UBX0101, UBX1325 ASPIRE) or feasibility
  (D+Q, fisetin); there is NO approved senolytic. Room-window via single-target is CLOSED; a usable
  window remains OPEN only via the conditional orthogonal-AND-gate route.

## Provenance (4-lens fleet, all g5 PASS, 2026-06-19)
scap-law 🔵 (Δx* closed-form; Soto-Gamez Cell Death Differ 2024 10.1038/s41418-024-01431-1) ·
window-ceiling 🔵/🟠 (p_dep ceiling theorem; SenePy 10.1038/s41467-025-57047-7) ·
selectivity-escape 🟢 (S_total=∏S_i; GLS1 Science 2021 10.1126/science.abb5916; PROTAC 10.1038/s41467-020-15838-0) ·
senolytic-corpus 🟢/🟠 (affinity≠selectivity confirmed via navitoclax; UBX1325 NEJM Evid 2025 10.1056/EVIDoa2400009).
Lane detail: state/senolyx-selectivity-law/<lane>/FINDINGS.md.
