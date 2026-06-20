# RAREEARTH-FREE permanent-magnet PRODUCTION-readiness scoreboard (P1–P6 hard gate)

> Generated 2026-06-20. Intrinsic Ms/Ku/Tc/Hc reused from `state/rareearth-free/magnet_escape_quant.py`.
> Gate semantics (d_production_grade): ALL six P-gates must PASS for "production-ready".
> Any FAIL/UNVERIFIED blocks → verdict = "blocked at P{first-fail}".
> Honest scoring (d6): almost everything FAILs somewhere — that is the correct result.

## The 6 production gates

| Gate | Hard threshold |
|---|---|
| **P1 PERFORMANCE PARITY** | (BH)max ≥ incumbent class **OR** Hc holds ≥ target at **180 °C service temp** (defense/EV). Vague "promising" = not PASS. |
| **P2 STABILITY/SAFETY** | phase stable at service T · non-toxic · environmentally OK. **Metastable phase (MnAl-τ, Fe16N2-α″, 1:12 needing Ti/V) = FAIL.** |
| **P3 MANUFACTURING SCALABILITY** | bulk / continuous / yield proven. **thin-film · powder-only · single-batch = FAIL.** |
| **P4 COST** | $/unit ≤ incumbent **or** quantified value premium. **precious-metal dependence (Pt) = FAIL.** |
| **P5 CERTIFICATION/MARKET** | qual / customer-cert / regulatory path + entry-barrier assessment. |
| **P6 SUPPLY-CHAIN RESILIENCE** | substitution must NOT create a new single-source / China-dependent critical-element dependence. **★new dependence = auto-FAIL.** Co (DRC ~76% mine / China ~70% refine) and Sm (China ~99% sep) themselves carry risk. |

---

## SCOREBOARD TABLE

| # | Candidate | RE status | P1 perf | P2 stab | P3 mfg | P4 cost | P5 cert | P6 supply | Bottleneck | Verdict |
|---|---|---|---|---|---|---|---|---|---|---|
| 0 | **Nd2Fe14B** (benchmark) | RE (Nd+Dy/Tb) | PASS | PASS | PASS | PASS | PASS | **FAIL** | P6 | the incumbent — fails ONLY P6 (the entire reason the campaign exists) |
| 1 | **Sm(Fe,Co)12** (1:12 ThMn12) | heavy-RE-free, **uses Sm+Co** | UNVERIFIED | **FAIL** | **FAIL** | UNVER | UNVER | **FAIL** | P2 | blocked at P2 (phase needs Ti/V, dilutes Ms; bulk = R&D) |
| 2 | **SmCo5 / Sm2Co17** | heavy-RE-free, **uses Sm+Co** | PASS | PASS | PASS | UNVERIFIED | PASS | **FAIL** | P6 | blocked at P6 (Sm + Co = TWO China/DRC choke points) |
| 3 | **L1₀-FeNi** (tetrataenite) | fully RE-free | **FAIL** | PASS | **FAIL** | PASS | UNVER | PASS | P1 | blocked at P1 (ordering wall; bulk not demonstrated, 2022 claim retracted) |
| 4 | **Fe16N2** (α″) | fully RE-free | **FAIL** | **FAIL** | **FAIL** | PASS | UNVER | PASS | P1 | blocked at P1 (Hc ~0.1–0.2 T) — also P2 metastable, P3 powder-only |
| 5 | **MnBi** (LTP) | RE-free (**Bi**) | **FAIL** | **FAIL** | UNVER | UNVER | UNVER | UNVER | P1 | blocked at P1 ((BH)max ~8 MGOe bulk); P2 peritectic 355 °C |
| 6 | **MnAl-C** (τ) | fully RE-free | **FAIL** | **FAIL** | **FAIL** | PASS | UNVER | PASS | P1 | blocked at P1 ((BH)max ~7–14 kJ/m³); τ metastable |
| 7 | **L1₀-FePt** | RE-free (**Pt**) | PASS | PASS | **FAIL** | **FAIL** | UNVER | **FAIL** | P3 | blocked at P3 (thin-film/HDD only); P4 Pt ~$55/g; P6 SA Pt |
| 8 | **Alnico** (shape) | RE-free, **Co-heavy** | **FAIL** | PASS | PASS | UNVER | PASS | **FAIL** | P1 | blocked at P1 (Hc <1 kOe, soft); P6 Co 24–38% |
| 9 | **Ferrite** (SrFe12O19) | fully RE-free, abundant | **FAIL** | PASS | PASS | PASS | PASS | PASS | P1 | blocked at P1 ((BH)max ~28–40 kJ/m³ = ~10× below NdFeB) |
| 10 | **Exchange-spring** nanocomposite | depends on phases | **FAIL** | UNVER | **FAIL** | UNVER | UNVER | UNVER | P1 | blocked at P1 (bulk ~18–24 MGOe, never beats aligned NdFeB) + P3 3D nanostructuring wall |

---

## FURTHEST candidate

**Ferrite (SrFe12O19)** — the ONLY fully-RE-free candidate that passes P2/P3/P4/P5/P6 (5 of 6). Single remaining blocker: **P1 performance parity** — (BH)max ~28–40 kJ/m³ vs NdFeB ~400 kJ/m³ (~10×). It is the low-cost performance FLOOR, not a parity replacement. Already the world's #1 magnet by volume; the gap is intrinsic (low Ms 0.38 MA/m, modest Ku 0.35 MJ/m³ → BHmax_theory cap ~45 kJ/m³).

Runner-up by fewest hard FAILs among **high-performance** options: **SmCo5/Sm2Co17** (passes P1/P2/P3/P5, even exceeds 180 °C to 350–550 °C) — but it is heavy-RE-free, NOT RE-free, and stacks two supply choke points (Sm China ~99% sep + Co DRC/China), so it FAILS P6 and is also a commercial incumbent, not a novel escape.

---

## Is ANY candidate production-ready today?

**NO. Zero of eleven pass all six gates.**

**The universal bottleneck = the coercivity/parity-vs-supply TRILEMMA, concentrated at P1 (and P6).**

- Everything **fully RE-free + abundant + bulk-manufacturable** (ferrite, Alnico) **FAILS P1** — intrinsic Ms/Hc too low (ferrite ~10× gap; Alnico Hc <1 kOe).
- Everything with **parity-class physics** either FAILS **P6** by re-introducing a critical element (SmCo→Sm+Co; FePt→Pt-SA) or FAILS **P2/P3** because the high-anisotropy phase is **metastable / non-bulk** (MnAl-τ, Fe16N2-α″, L1₀-FeNi ordering wall, exchange-spring 3D nanostructuring wall).
- The incumbent NdFeB itself fails ONLY P6 — confirming the campaign premise: the open problem is finding ANY candidate that holds **180 °C coercivity at bulk scale from abundant non-China-locked elements simultaneously**. The escape corner is empty (consistent with the prior G1–G6 quantitative finding).

**No overclaim: the gate worked.** Mark candidates 1, 5, 7, 8, 10 with UNVERIFIED gates honestly rather than guessing PASS — but every one already has a confirmed hard FAIL upstream of those, so none is rescued by the unverified gates.
