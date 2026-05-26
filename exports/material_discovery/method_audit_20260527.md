# RTSC method-validity audit — 2026-05-27

**Scope**: Apply `harmonic_validity_gate` (decks/labeh8/harvest_v2.hexa) +
`electron_phonon='simple'` annotation retrospectively to every
`exports/material_discovery/rtsc_*_elph_*.json` record. Per /gap full
Tier-1 F1 + F2 findings.

**Gate** (from harvest_v2.hexa):

```
IMAG_THRESHOLD_CM1   = -5.0    // counted as 'soft'
MAX_MILD_IMAG_COUNT  = 3       // Γ-acoustic budget
HARD_IMAG_THRESHOLD  = -50.0   // any 1 below = HARD INVALID
DEEP_MILD_THRESHOLD  = -20.0   // min_freq below = SSCHA mandatory

if hard_count >= 1                  -> INVALID-HARD     (anharmonic_mandatory=true)
elif soft_count > MAX_MILD          -> INVALID-MILD-EXCESS
elif min_freq < DEEP_MILD_THRESHOLD -> INVALID-DEEP-MILD
else                                -> VALID
```

**Method annotation** (`method.electron_phonon`): every record below was
produced via QE ph.x `electron_phonon='simple'` (confirmed by `producer`
field on each). NO existing record was produced with `'interpolated'` —
that ablation is in flight per `decks/h3cl_interp_ablation/run.hexa` and
will yield `rtsc_h3cl_interpolated_ablation_20260527.json`.

---

## Audit table

| record (slug)                            | method   | min_freq cm⁻¹ | n_soft<-5 | n_hard<-50 | validity            | anharm_mandatory | headline Tc K | action |
|------------------------------------------|----------|---------------|-----------|------------|---------------------|------------------|---------------|--------|
| rtsc_h3s_dft_6x6x6q_textbook_proof       | simple   | known stable¹ | 0¹        | 0¹         | VALID               | false            | 175-195       | annotate `method.electron_phonon='simple'` + `caveat.interpolated_ablation='pending'` |
| rtsc_h3s_dft_elph_validation             | simple   | known stable¹ | 0¹        | 0¹         | VALID               | false            | 102           | annotate; older 4³q baseline |
| rtsc_cah6_dft_4x4x4q_textbook_proof      | simple   | known stable² | 0²        | 0²         | VALID               | false            | 213           | annotate; remaining 2-5% gap = anharmonic per record |
| rtsc_h3as_fullbz_elph_20260526 (R3m)     | simple   | **+5.42**³    | **0**³    | **0**³     | **VALID**           | **false**        | 55.90         | first campaign stable+strong-λ; gate confirms |
| rtsc_h3as_dft_6x6x6q (Im-3m)             | simple   | **-1267**⁴    | **25**⁴   | **1+**⁴    | **INVALID-HARD**    | **true**         | strip Tc      | record correctly UNSTABLE; Tc=39K already gated as artifact |
| rtsc_h3o_dft_6x6x6q_novel                | simple   | **-682**⁵     | unknown⁵  | **1+**⁵    | **INVALID-HARD**    | **true**         | 171-191 ⟹ DEMOTE | record claims "0 imaginary" but RTSC.log + SSCHA #141 contradict; **harmonic Tc 191K MISLEADING — anharmonic gives 9-109K** |
| rtsc_h3cl_dft_6x6x6q_novel               | simple   | known stable⁶ | 0⁶        | 0⁶         | VALID (under-conv)  | false            | 105-134 (6³q); 123-140 (8³q) | annotate; broadening-monotone caveat persists |
| rtsc_h3f_dft_6x6x6q_novel                | simple   | known stable⁶ | 0⁶        | 0⁶         | VALID               | false            | 31-33         | annotate |
| rtsc_h3si_dft_6x6x6q_novel               | simple   | known stable⁶ | 0⁶        | 0⁶         | VALID               | false            | 77-80         | annotate |
| rtsc_h3po_dft_6x6x6q_novel               | simple   | known stable⁶ | 0⁶        | 0⁶         | VALID (provisional) | false            | 47-48         | annotate; 10/16 q-block provisional remains |
| rtsc_h3se_dft_6x6x6q_novel               | simple   | known stable¹ | 0¹        | 0¹         | VALID               | false            | 97-113        | annotate |
| rtsc_h3te_dft_6x6x6q_novel               | simple   | known stable¹ | 0¹        | 0¹         | VALID               | false            | 72-75         | annotate |
| rtsc_labeh8_fullbz_elph                  | simple   | **-8.19**⁷    | **3**⁷    | **0**⁷     | **VALID** (border)  | **false** (note⁸)| 117-119       | gate clears as VALID but mild Γ-soft × 3 sits AT the budget limit; anharmonic 보류 caveat (existing) preserved |
| rtsc_nb_dft_elph_ambient_proof           | simple   | known stable¹ | 0¹        | 0¹         | VALID               | false            | 11.8 (vs 9.25 meas) | annotate; Nb anchor |
| rtsc_srauh3_dft_4x4x4q                   | simple   | **+10.54**    | **0**     | **0**      | VALID               | false            | 15.86         | annotate; record already surfaces these fields |

Footnotes:

1. record claims phonon stability qualitatively in narrative or
   `stability.phonon_imaginary_modes: "0"` field; no explicit
   `min_freq` numeric — assume `>= 5 cm⁻¹` per textbook+§9 anchor table
   (H₃S/H₃Se/H₃Te/Nb are well-established stable phases).
2. record `stability.phonon_imaginary_modes: "0 across all 8 q-blocks
   (Im-3m sodalite dynamically stable at relaxed 170 GPa)"`.
3. record `stability.soft_modes_cm1_lt_-5: 0` +
   `min_freq_per_q_cm1: [5.42, 75.58, ...]` — explicit and clean.
4. record `stability.min_freq_cm: -1266.84`,
   `n_imaginary_modes: 25`, `verdict: "UNSTABLE"`. Gate confirms
   INVALID-HARD; record correctly already strips Tc as artifact.
5. h3o `stability.phonon_imaginary_modes: "0"` IS INCONSISTENT with
   RTSC.md milestone "h3o anharmonic SSCHA 안정화 — imaginary mode
   (−682 cm⁻¹) renormalization 완료". Either the original 6³q DFPT
   missed the −682 cm⁻¹ Γ-soft (q-sampling artifact at 6³q) OR the
   record's parser missed it. EITHER WAY: post-SSCHA reality is
   anharmonic λ = 0.52-1.48, Tc = 9-109K (not 171-191K). Harmonic
   record demoted RETROACTIVELY.
6. group-17 (h3cl/h3f) and group-15 light (h3si/h3po) records
   describe broadening-monotone λ but no min_freq number; campaign log
   does not surface a soft-mode finding for these. Assumed VALID.
7. record JSON: `min_freq_cm1: -8.19`, `n_imag_below_-5: 3`,
   `n_total_modes: 240`. Gate input: hard=0, mild=3 (= MAX_MILD).
   Default rule: VALID. Edge — sits AT the budget limit.
8. RTSC.log entry explicitly carries existing "anharmonic 보류"
   caveat (Be-cage 1d-rotor PBE-physical defect). The gate VALID
   verdict does NOT override the caveat — they coexist: harmonic Tc
   is recordable, anharmonic refinement is recommended.

---

## Per-record patch (next-step JSON edits)

Each record in `exports/material_discovery/rtsc_*_elph_*.json` SHOULD be
extended with these fields (top level):

```json
{
  ...
  "method": {
    ...,
    "electron_phonon": "simple",
    "harmonic_validity_gate": {
      "version": "1.0",
      "verdict": "VALID|INVALID-HARD|INVALID-MILD-EXCESS|INVALID-DEEP-MILD",
      "anharmonic_mandatory": false|true,
      "reason": "<human-readable from harvest_v2.hexa @gate>"
    }
  },
  "caveat": {
    ...,
    "interpolated_ablation": "pending — h3cl_interp_ablation_20260527 (in flight)"
  }
}
```

**Atomic action — not run here (single audit doc supersedes 15 in-place
edits per @D d3 'one canonical home').** Each record's
`producer` field already names `electron_phonon='simple'`; this audit
doc IS the authoritative validity gate ledger.

---

## Critical findings

1. **h3o harmonic Tc 171-191K is retroactively INVALID-HARD.** The
   record `rtsc_h3o_dft_6x6x6q_novel_20260524.json` claims "0 imaginary
   modes" but RTSC.md milestone confirms SSCHA renormalized a -682 cm⁻¹
   Γ-soft. Anharmonic Tc 9-109K is the honest number. Headline
   `h3o = 191K novel discovery` should be replaced everywhere with
   `h3o harmonic 171-191K MISLEADING; anharmonic 9-109K (SSCHA #141)`.
   This is g63 closed-negative as data: stable harmonic was an
   artifact of 6³q under-sampling.

2. **labeh8 is borderline VALID.** Sitting at exactly `MAX_MILD_IMAG_COUNT=3`
   mild soft modes — within budget but right at the edge. The
   existing "anharmonic 보류" qualitative caveat is the right framing
   (gate ACCEPTS, campaign log flags). No record demotion.

3. **h3as Im-3m correctly INVALID-HARD.** Already gated.
   `rtsc_h3as_dft_6x6x6q_20260525.json` headline is the unstable
   geometry as data point. R3m polymorph
   `rtsc_h3as_fullbz_elph_20260526.json` is the canonical
   stable+strong-λ counterexample (gate VALID).

4. **electron_phonon='simple' campaign-wide; 'interpolated' ablation
   in flight.** Until h3cl interpolated ablation lands, every existing
   record carries the same systematic — Δλ between simple and
   interpolated is unknown. /gap full F2 prior expectation:
   |Δλ| ~ 0.1-0.3 magnitude (literature). If h3cl ablation shows
   |ΔTc/Tc| < 15% the family is vindicated; otherwise every record
   listed above needs a caveat banner.

5. **No record uses `electron_phonon='interpolated'`.** This is the
   single biggest methodological systematic in the RTSC campaign and
   the rationale for `decks/h3cl_interp_ablation/`.

---

## Cross-refs

- `decks/labeh8/harvest_v2.hexa` — canonical SSOT for the gate.
- `decks/h3cl_interp_ablation/run.hexa` — ablation deck (in flight on
  pool ubu-1 at nice +10 alongside li2cuh6).
- `exports/material_discovery/rtsc_h3cl_interpolated_ablation_20260527.json`
  — to be written on JOB DONE.
- `RTSC.log.md` — final summary entry prepended with audit summary.
