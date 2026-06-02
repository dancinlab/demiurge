# RFP — LVAD ② vWF-A2 stabilizer wet-lab pilot (aVWS)

**STATUS**: draft-ready, deferred for user send
**Template version**: 0.1.0 (2026-05-16)
**Scenario**: `LVAD/A2_STABILIZER.tape` (QUANTUM axis · Tier A · white-space)

> Per [AGENTS.md](../../AGENTS.md) "External-contact deferral policy" + AGENTS.tape
> `g9`: this is a DRAFT. The user owns send/sign/pay/meet. Tracking index:
> [`USER_ACTION_REQUIRED.md`](../../USER_ACTION_REQUIRED.md) · not a "next step"
> proposal (`g10`/`f4`).

---

## In-silico scope honesty (read first — g8 / f2)

The hexa-bio in-silico phase for ② established **only** simulator+metadata
internal consistency:

- §3 real-limits #1 (ADAMTS13 cleavage-limited regime), #2 (A2 unfolding
  ΔG 7-10 kcal/mol), #3 (A2 cleavage shear threshold ≈30 dyn/cm²) are
  **mutually consistent**, and LVAD shear (70-150 dyn/cm²) is supra-threshold
  — i.e. the **aVWS disease mechanism premise** holds in-silico
  (`_python_bridge/module/a2_shear_unfolding_anchor.py`,
  `__A2_SHEAR_UNFOLDING_ANCHOR__ PASS`).
- This is **NOT** a therapeutic, efficacy, or druggability claim. No A2
  stabilizer is known to exist (white-space: **0 approved**). The candidate
  list (`LVAD/a2_candidates.smi`) is mostly mechanism-reference negative
  controls, not validated binders.

This pilot is the **first wet-lab test of whether the A2 white-space target
is druggable at all** — it does not assume it is.

## Subject

`Pilot wet-lab RFP — vWF A2-domain thermal-stability + ADAMTS13-cleavage assay (aVWS stabilizer feasibility)`

## Body

Dear [CRO / academic-lab contact],

We are evaluating whether the von Willebrand factor **A2 domain** can be
kinetically stabilized against shear-driven ADAMTS13 cleavage — the
mechanistic root of **acquired von Willebrand syndrome (aVWS)** in LVAD
recipients (>75% prevalence; **no approved therapy**). In-silico force-balance
analysis confirms the mechanism premise; we now seek a low-cost in-vitro
pilot to test stabilizer feasibility before any lead-optimization commitment.

### Pilot scope (Phase 1, ~3-4 months)

| Item | Detail |
|---|---|
| Reagents | Recombinant human vWF A2 domain (residues ~1495-1672, UniProt P04275 numbering); recombinant ADAMTS13; FRETS-VWF73 (or VWF73) fluorogenic substrate (commercial) |
| Assay 1 | **nanoDSF / DSF thermal-stability shift**: A2 ± candidate compounds → ΔTm (apparent unfolding midpoint shift). n ≥ 3 replicates; DMSO + buffer controls |
| Assay 2 | **ADAMTS13 cleavage kinetics**: FRETS-VWF73 + ADAMTS13 ± candidate → initial-rate k_cat/Km; does candidate slow cleavage? Michaelis-Menten fit |
| Assay 3 (opt) | **SPR / BLI binding**: A2-immobilized; candidate titration → K_d (validates any in-silico binding ranking) |
| Compound set | ≤12 compounds from `LVAD/a2_candidates.smi` (incl. declared negative controls — aspirin, NAC, tranexamic acid, thalidomide) + DMSO vehicle |
| Required precision | ΔTm resolution ≤ 0.3 °C; cleavage-rate CV ≤ 15%; K_d dynamic range 1 nM-1 mM |
| Deliverables | Raw thermograms + cleavage progress curves + (opt) sensorgrams + fitted parameters + summary report (anonymized → `wetlab/data/`, gitignored) |
| Timeline | M1: reagent QC + assay setup; M2: nanoDSF screen; M3: ADAMTS13 kinetics; M4 (opt): SPR + report |
| Budget cap | **$XX K** (placeholder — fill before send) |

### Read-out priorities

1. **Any compound shifting A2 ΔTm by ≥ +2 °C** (stabilization signal vs vehicle) — a hit definition; expected: negative controls do NOT (assay validity check).
2. **Cleavage-rate reduction**: any candidate reducing ADAMTS13 k_cat/Km by ≥ 30% at ≤ 100 µM (the §3 #1 anchor predicts cleavage is the rate-limiting step once A2 is unfolded — a stabilizer should slow it).
3. **Binding confirmation** (Assay 3): K_d consistent with the cleavage/ΔTm effect (mechanistic coherence, not potency).
4. **Honest negative is informative**: if all candidates (incl. the in-silico scaffold set) fail, that bounds the white-space and is a publishable methods/negative result — the pilot is designed to be informative either way.

### What we ask in your reply

- [ ] Recombinant vWF-A2 + ADAMTS13 expression/QC experience (last 5 years)
- [ ] nanoDSF (e.g. Prometheus) or DSF (qPCR-based) platform access
- [ ] FRETS-VWF73 cleavage-assay experience; ADAMTS13 activity QC method
- [ ] SPR/BLI capability (optional Assay 3) + lead time
- [ ] Estimated timeline + budget for the Phase 1 pilot above
- [ ] NDA + MTA terms (compound list confidential pre-publication; see [`../mta/ubmta-template.md`](../mta/ubmta-template.md))
- [ ] References to similar protein-stability / protease-kinetics small-molecule screens

### Cross-references

- In-silico anchor source: https://github.com/dancinlab/hexa-bio — `LVAD/A2_STABILIZER.tape` §8, `_python_bridge/module/a2_shear_unfolding_anchor.py`
- Candidate scaffold list: `LVAD/a2_candidates.smi`
- Assay protocol detail: [`../sop/a2-stability-cleavage-assay-sop.md`](../sop/a2-stability-cleavage-assay-sop.md)
- Deferral policy: [`USER_ACTION_REQUIRED.md`](../../USER_ACTION_REQUIRED.md) · [`CLOSURE_RESIDUAL_BACKLOG.md`](../../CLOSURE_RESIDUAL_BACKLOG.md) §C

[user signature]
