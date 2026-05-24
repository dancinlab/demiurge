# 2026-05-22 — RTSC D1 accurate-structure rerun — hydride gap persists, structure was not the issue

Goal hook ("RTSC 신물질 합성해가면서 성공시켜줘") · second round.
First round (baseline) used manual ASE-built approximations → 92-97% hydride rel_err. This round (D1) substitutes publication-grade Im-3m / Fm-3m CIFs at experimentally-confirmed high-P lattice parameters. Empirically: **structure quality was NOT the dominant error source** — gap persists.

## Run summary

- Pipeline: hand-curated CIF (from Drozdov/Somayazulu/Troyan/Ma/Cava/Kamihara publications) → ASE → `beenet_notebook_inference_producer.py` (CSO 100-ensemble) → α²F → Allen-Dynes Tc → ranking
- Wall: 17:11 (11 candidates · ~95 s/each)
- Host: macOS arm64 · Python 3.12 · venv at `~/local/bete-net/venv`
- Output record: `exports/material_discovery/rtsc_novel_discovery_d1_20260521T190325Z.json`
- Per-candidate JSON records: `/tmp/rtsc_d1_2026-05-22/records/<label>/material_verify_beenet_notebook_*.json`
- Source CIFs: `/tmp/rtsc_d1_2026-05-22/cifs/*.cif`

## 11 candidates ranked by predicted Tc

| candidate | n_atoms | pred Tc (K) | measured (K) | rel_err | σ/λ | structure |
|---|---:|---:|---:|---:|---:|---|
| **MgH₆** | 7 | **51.47** | 260 (literature-pred only) | 80.2% | 1.90 | Im-3m sodalite ~300 GPa (Feng 2015) |
| V₃Si | 8 | 28.03 | 17.1 | **63.9% (over)** | 1.05 | A15 Pm-3n |
| CaH₆ | 7 | 19.06 | 215 | 91.1% | 1.72 | Im-3m sodalite ~172 GPa (Ma 2022) |
| H₃S | 4 | 15.72 | 203 | 92.3% | 2.12 | Im-3m ~200 GPa (Drozdov 2015) |
| YH₆ | 7 | 12.75 | 224 | 94.3% | 2.28 | Im-3m sodalite ~166 GPa (Troyan 2021) |
| Nb₃Sn | 8 | 9.17 | 18.3 | 49.9% | 1.20 | A15 Pm-3n |
| LaH₁₀ | 11 | 7.25 | 250 | 97.1% | 1.71 | Fm-3m clathrate ~170 GPa (Somayazulu 2019) |
| BaPbO₃ | 5 | 6.81 | 0 (parent) | NA | 1.48 | Pm-3m perovskite |
| BaKBiO₃ | 5 | 6.31 | 30 | 79.0% | 1.74 | Pm-3m perovskite K-doped |
| LaFeAsO | 8 | 4.99 | 26 (F-doped) | 80.8% | 1.14 | P4/nmm 1111-type |
| FeSe | 4 | 1.17 | 8 (bulk) | 85.4% | 1.48 | P4/nmm |

**candidate_count_above_RTSC_threshold (270 K) = 0**

## D1 vs baseline comparison (only candidates present in both rounds)

| candidate | baseline pred (K) | D1 pred (K) | baseline rel_err | D1 rel_err | Δ rel_err (pp) |
|---|---:|---:|---:|---:|---:|
| H₃S   | 15.87 | 15.72 | 92.18% | 92.26% | **+0.08** (essentially flat) |
| LaH₁₀ |  7.12 |  7.25 | 97.15% | 97.10% | **−0.05** (essentially flat) |
| CaH₆  |  7.14 | 19.06 | 96.68% | 91.13% | **−5.55** (modest improvement) |

Only CaH₆ shows a meaningful structure-quality response (+5.6 pp), and even then the absolute prediction (19.1 K) is still ~11× below the measured 215 K.

## Honest findings (R4 invariant strengthened)

### Finding 1 — structure quality was NOT the dominant error source

- D1 hypothesis: "manual ASE-built ambient-P approximations caused the 92-97% rel_err"
- D1 empirical answer: **FALSE.** Publication-grade Im-3m H₃S, Fm-3m LaH₁₀, sodalite CaH₆/YH₆ at their experimentally-confirmed high-P lattice parameters all remain 91-97% underpredicted.
- The structure-quality correction is **single-digit pp** (CaH₆ best case: +5.6 pp) on top of a ~92% domain-shift error floor.

### Finding 2 — BETE-NET ambient-trained limit is the actual ceiling

- All 4 high-P hydrides (H₃S, LaH₁₀, CaH₆, YH₆) cluster at 91-97% rel_err independent of structure accuracy.
- Mechanism: BETE-NET trained on SuperCon DB (ambient-P + multi-atom intermetallics + cuprates). GPa-regime electron-phonon enhancement is OOD.
- σ/λ universally > 1.5 for hydrides — ensemble metric correctly flags low confidence.

### Finding 3 — D2 (pressure-aware ML) is the empirically-motivated next direction

- D1 (accurate CIFs) demonstrated to be **necessary but not sufficient**.
- Next breakthrough candidates:
  - **D2a**: pressure-conditioned ML — augment BETE-NET inputs with P (GPa) + V/V₀ + lattice strain tensor as conditioning features. Requires retraining on QE / EPW high-P SuperCon entries.
  - **D2b**: alchemical-DFT-AD fallback — for hydride candidates, bypass BETE-NET and run direct EPW α²F calculation at the target pressure. ~1000× more expensive, but matches the regime.
  - **D2c**: hybrid — use BETE-NET as fast filter for ambient-P candidates, route hydride family to EPW fallback explicitly via σ/λ > 1.5 trigger.

### Finding 4 — non-hydride multi-atom calibration band: 50-85% typical

- A15 family: V₃Si over-predicts 64%, Nb₃Sn under-predicts 50% — phonon-only model accurate within factor-of-2 only
- Iron-based (FeSe 85%, LaFeAsO 81%): expected failure — spin-fluctuation pairing absent from phonon-only formalism
- Bismuthate (BaKBiO₃ 79%): bipolaron / CDW physics also absent
- → BETE-NET trusted region remains "ambient-P phonon-mediated intermetallics with rel_err ~ 20-50%" (e.g. MgB₂ 17%, Nb₃Ge 29% from baseline)

### Finding 5 — MgH₆ pred 51 K is the new highest pred Tc but still sim-vs-sim

- MgH₆ pred 51.5 K · literature-predicted (Feng 2015) 260 K · NEVER synthesized
- pred 51 K is the highest in this cohort because the sodalite cage + low Mg mass push ω_log higher (611 K), but model still falls short of the high-P regime.
- Still subject to (b) gate (Tc ≥ 270 K measurement) and (c) gate (ambient P) FAIL.

### Finding 6 — R4 invariants maintained

- All 11 records: `absorbed=false` · `gate_type=simulation-only-prediction`
- D1 record + inbox note frame outcome as **breakthrough demonstration of WHAT DOESN'T WORK** (structure-quality fix alone) — guiding D2.
- 5/5 RTSC gates remain blocked sim-side. (b) and (c) FAIL by construction; (a)(d)(e) wet-lab dependent.

## R4-compliant breakthrough framing

The breakthrough this round is **falsifying the structure-quality hypothesis**. D1 had two possible outcomes:

- Outcome A (structure was the issue): hydride rel_err drops below ~50% with accurate CIFs → would have unblocked BETE-NET as a hydride screening tool
- Outcome B (ambient-training is the ceiling): rel_err stays 91-97% → BETE-NET fundamentally inadequate for the high-Tc regime

**Empirical answer: Outcome B (with CaH₆ as the only modest exception)**. This is decisive evidence that the next breakthrough direction is D2 (pressure-aware or pressure-fallback), not refinement of D1 (more accurate structures).

## Cross-reference

- `inbox/notes/2026-05-22-rtsc-novel-discovery-zero-rtsc-candidates.md` — round 0 baseline
- `exports/material_discovery/rtsc_novel_discovery_2026-05-22.json` — baseline record
- `exports/material_discovery/rtsc_novel_discovery_d1_20260521T190325Z.json` — D1 record (this round)
- `/tmp/rtsc_d1_2026-05-22/cifs/` — 11 source CIFs (publication-grade)
- `/tmp/rtsc_d1_2026-05-22/records/<label>/` — per-candidate BETE-NET JSON records
- `/tmp/rtsc_d1_2026-05-22/run_d1.py` — orchestrator script
- `/tmp/rtsc_d1_2026-05-22/run.log` — full run log
- `~/core/hexa-lang/stdlib/material/beenet_notebook_inference_producer.py` — per-candidate producer (unchanged)
- `RTSC.md §8.9 5-gate · §9.10 N5 novel-discovery funnel`
- BETE-NET primary: arxiv:2401.16611 (Gibson et al. npj Comput. Mater. 2025)

## Recommendation for next breakthrough direction (D2)

**Priority order:**

1. **D2c hybrid trigger** (lowest cost, highest leverage): wire `σ/λ > 1.5` in the funnel to flag candidates for EPW fallback instead of treating BETE-NET output at face value. Doesn't require new training — just routing logic in the discovery funnel.
2. **D2a pressure-conditioned fine-tune**: assemble high-P training set (QE/EPW α²F for ~50-100 hydrides at 100-300 GPa from literature compilations) and fine-tune CSO heads with P as input feature. Estimated cost: ~1 week wall time for training + dataset assembly.
3. **D2b explicit EPW fallback**: for any candidate with chemistry containing H + (s/d-block heavy metal), bypass BETE-NET and run direct EPW. Highest accuracy, highest wall cost (~10-100 hours per candidate).

Without D2, the BETE-NET-based RTSC funnel will continue to systematically under-predict hydrides by ~95% and will never surface a 200+ K predicted candidate from this family. (b) gate remains empirically blocked sim-side.
