# SOP draft — vWF-A2 stability + ADAMTS13-cleavage assay (LVAD ②)

**STATUS**: draft-ready, deferred for user send
**Type**: claude-drafted axis-specific SOP from in-silico parameters (per
[`README.md`](README.md) "user / claude can DRAFT axis-specific SOPs")
**Pairs with**: [`../cro/lvad-a2-stabilizer-rfp-template.md`](../cro/lvad-a2-stabilizer-rfp-template.md)

> g8/f2: parameters below are STARTING points derived from the in-silico
> mechanism anchor; the CRO's validated protocol supersedes on contract.
> This is NOT a clinical/efficacy protocol — it tests target druggability.

---

## 0. Scope & rationale

Tests whether any candidate kinetically stabilizes the vWF A2 domain
against shear-driven ADAMTS13 cleavage (aVWS root mechanism). In-silico
anchor (`_python_bridge/module/a2_shear_unfolding_anchor.py`) established:
A2 thermodynamic unfold force ≈ 0.75-1.39 pN (low-force regime);
cleavage is rate-limiting at k_cat ≈ 2.5/s once A2 is unfolded. A
stabilizer should (a) raise A2 apparent Tm and/or (b) lower ADAMTS13
turnover on the stabilized substrate.

## 1. Materials (reference; CRO QC supersedes)

| Reagent | Spec / source note |
|---|---|
| Recombinant human vWF A2 | residues ~1495-1672 (UniProt **P04275** numbering); His-tag OK; ≥ 90% purity (SEC) |
| Recombinant ADAMTS13 | full-length or MDTCS; activity-QC'd on FRETS-VWF73 |
| FRETS-VWF73 | commercial fluorogenic substrate (or VWF73 + Western read-out) |
| Candidate compounds | ≤12 from `LVAD/a2_candidates.smi` incl. negative controls (aspirin, NAC, tranexamic acid, thalidomide); ≥ 95% purity; 10 mM DMSO stocks |
| Buffers | assay buffer per ADAMTS13 vendor (typ. Tris/CaCl₂/Zn²⁺, pH 6.0); DMSO ≤ 1% v/v final |

## 2. Assay 1 — nanoDSF / DSF thermal stability

1. A2 at 0.2-1 mg/mL in assay buffer; candidate at 1×, 10×, 100× molar (or 1-100 µM); DMSO-matched vehicle control; n ≥ 3.
2. Ramp 20 → 95 °C at 1 °C/min (nanoDSF 330/350 nm ratio) or SYPRO-Orange DSF on qPCR.
3. Fit apparent Tm (first-derivative max). Report **ΔTm = Tm(compound) − Tm(vehicle)**.
4. **Hit definition**: ΔTm ≥ +2 °C, dose-ordered. Validity check: negative controls show |ΔTm| < 1 °C.

## 3. Assay 2 — ADAMTS13 cleavage kinetics

1. Pre-incubate A2/FRETS-VWF73 ± candidate (15 min, assay temp).
2. Start with ADAMTS13; record fluorescence kinetics (≥ 30 min, initial-rate window).
3. Substrate titration → Michaelis-Menten **k_cat, Km, k_cat/Km**; ± candidate.
4. **Read-out**: candidate reducing k_cat/Km ≥ 30% at ≤ 100 µM = cleavage-protection signal (consistent with §3 #1 cleavage-limited anchor).

## 4. Assay 3 (optional) — SPR / BLI binding

1. Immobilize A2 (amine or His-capture); candidate titration series.
2. Fit steady-state or kinetic **K_d**. Coherence check: K_d should rationalize the ΔTm / cleavage effect (mechanistic, not potency).

## 5. Acceptance & honest-negative clause

- Assay valid iff: ADAMTS13 active on FRETS-VWF73 (positive control cleaves); negative-control compounds inert in Assay 1.
- A fully-negative compound panel is a **valid, publishable bound on the white-space** — the design is informative either outcome (g1: no fit-to-hope).
- No result here implies clinical efficacy (g8/f2); a hit only licenses a lead-optimization decision (user-owned, deferred).

## 6. Cross-references

- In-silico anchor: `LVAD/A2_STABILIZER.tape` §8 · `_python_bridge/module/a2_shear_unfolding_anchor.py`
- Open-source starting points: bio-protocol.org ("ADAMTS13 activity FRETS-VWF73"); Kokame et al. 2005 Br J Haematol (FRETS-VWF73 assay, primary)
- Deferral index: [`USER_ACTION_REQUIRED.md`](../../USER_ACTION_REQUIRED.md)
