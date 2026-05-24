# RTSC §9.9.1 Phase 2 ext follow-on — JARVIS-OPTIMADE adapter LANDED · 20-cell rerun

> Anchor: `RTSC.md §9.9.1 Phase progress table` (Phase 2 ext follow-on row · DECIDED → LANDED)
> Date: 2026-05-22
> Inputs: hexa-lang `phase2-jarvis-adapter-2026-05-22` branch (commit `d3a3f8e8`), 4 producers under `~/core/hexa-lang/stdlib/material/{csp,beenet,askcos,cross_code_dft}_adapter.py`
> Outputs: `/tmp/phase2-jarvis-rerun/<producer>/<baseline>/*.json` (20 new records)
> Antecedents: `inbox/notes/2026-05-22-rtsc-9-phase2-ext-20cell.md` (18/20 baseline), `inbox/notes/2026-05-22-rtsc-9-phase2-multicorpus-decision.md` (JARVIS pick)

---

## 1. Adapter land summary

**File**: `~/core/hexa-lang/stdlib/material/cross_code_dft.py` (single-file edit, ADDITIVE).
**Branch**: `phase2-jarvis-adapter-2026-05-22` (isolated worktree at `~/core/hexa-lang-jarvis/`, hexa-lang concurrent-agent discipline observed).
**Commit**: `d3a3f8e8` ("feat(stdlib/material): add JARVIS-OPTIMADE as 3rd DFT corpus (_poll_jarvis)").
**LOC delta**: +143 / -4 in cross_code_dft.py.

### Implementation pieces (per decision-note spec)

- **`_hill_formula(composition)`** helper (~30 LOC incl. docstring): tokenize element+count via regex, alphabetize element symbols, emit element-count pairs (e.g. `YBa2Cu3O7` → `Ba2Cu3O7Y`, `MgB2` → `B2Mg`, `H3S` → `H3S`, `LaH10` → `H10La`).
- **`_poll_jarvis(composition, prop)`** (~85 LOC incl. docstring): anonymous OPTIMADE GET to `https://jarvis.nist.gov/optimade/jarvisdft/v1/structures/?filter=chemical_formula_reduced="<Hill>"&response_fields=...`, sentinel `-99999` filter, min for `formation_energy` / mean for `band_gap`, returns dict matching `_poll_oqmd` shape (adds `hill_formula_queried` for audit).
- **Registered** in `sources_polled` (between oqmd and hexa_rtsc), poll loop, citations list, header comment.
- **New scope_caveat (s5)**: "JARVIS-DFT uses OptB88vdW functional (NOT PBE) — not orthogonal functional family vs MP/AFLOW/OQMD (all PBE-dominated); same s2 systematic-error correlation. JARVIS values may systematically differ from PBE for some compositions (e.g., metal-hydride binding energies). Do NOT conflate JARVIS into 'PBE consensus'."

### Empirical observation on Hill-formula tolerance

Live probe shows JARVIS-OPTIMADE accepts both `MgB2` AND `B2Mg` (same 7 entries) — `chemical_formula_reduced` index appears tolerant to ordering for binary compositions. The Hill normalizer is still kept for correctness (canonical form) and for less-common multi-element compositions where the index may be order-sensitive (per the decision-note's YBCO probe which used `Ba2Cu3O7Y`).

---

## 2. 5×4 matrix — 20-cell rerun (JARVIS adapter active)

| producer            | Nb                                | MgB₂                              | YBa₂Cu₃O₇                              | claim-only-RT-SC (anonymized 2026-05-22) | H₃S                                    |
|---------------------|-----------------------------------|-----------------------------------|----------------------------------------|------------------------------------------|----------------------------------------|
| csp_adapter.py      | PASS · install-gated              | PASS · install-gated              | PASS · install-gated                   | PASS · install-gated                     | PASS · install-gated                   |
| beenet_adapter.py   | PASS · install-gated              | PASS · install-gated              | PASS · install-gated                   | PASS · install-gated                     | PASS · install-gated                   |
| askcos_adapter.py   | PASS · domain-mismatch            | PASS · domain-mismatch            | PASS · domain-mismatch                 | PASS · install-gated¹                    | PASS · domain-mismatch                 |
| cross_code_dft.py   | PASS · simulation-only-prediction (n=3) | PASS · simulation-only-prediction (n=3) | **PASS · simulation-only-prediction (n=3)**² | PASS · insufficient-sources (n=0)³ | **PASS · simulation-only-prediction (n=3)**² |

**Totals: 20/20 PASS · 0 DEVIATION · 0 FAIL · 0 crash.**

Footnotes:
1. **askcos × claim-only-RT-SC**: routes through `install-gated` (not `domain-mismatch`) because the anonymized literal `"claim-only-RT-SC"` is NOT in askcos's `_INORGANIC_SC_HINTS` allow-list nor regex-classifiable as inorganic SC — askcos classifies it as `organic_molecular` by default → tries to import askcos library → install-gated honest skip. Different gate path than the other 4 cells; still a PASS (honest skip with absorbed=false). No producer modification needed.
2. **YBCO + H₃S DEVIATION → PASS uplift**: both previously gated at `insufficient-sources` (n=1, mp_cache only — AFLOW+OQMD both empty) in Phase 2 ext baseline. After JARVIS adapter land, both now compute consensus with mp_cache + oqmd + jarvis (n=3 each). The OQMD entries also became reachable in this rerun — this is consistent with OQMD's intermittent endpoint behavior (the Phase 2 ext baseline noted OQMD silently absented on YBCO/H₃S; this rerun caught it responsive). Even with OQMD timing-out, JARVIS alone closes the gap to n=2 ≥ threshold.
3. **claim-only-RT-SC unchanged honest skip**: JARVIS returns 0 entries for the hypothetical composition (Hill-formula normalizes `claim-only-RT-SC` to junk since it isn't a real chemical formula string — `_hill_formula` returns the input unchanged when regex finds no element tokens, and JARVIS-OPTIMADE returns empty data). Net: cross_code_dft routes through `insufficient-sources` (n=0). This is the **honest** verdict per the R4 invariant — adapter does NOT manufacture a value for a composition no public DFT corpus has computed.

### Per-cell consensus values (cross_code_dft row only)

| baseline               | sources_returned          | consensus (eV/atom)              | n_src | rel_err_max |
|------------------------|---------------------------|----------------------------------|-------|-------------|
| Nb                     | mp_cache + oqmd + jarvis  |  0.000000 ± 0.086193             | 3     |   0.000%    |
| MgB₂                   | mp_cache + oqmd + jarvis  | −0.175965 ± 0.049758             | 3     |  27.873%    |
| YBa₂Cu₃O₇              | mp_cache + oqmd + jarvis  | **−2.084900 ± 0.028868**         | 3     |   6.376%    |
| claim-only-RT-SC       | (none)                    | —                                | 0     | —           |
| H₃S                    | mp_cache + oqmd + jarvis  | **+0.022075 ± 0.177473**         | 3     | 191.685%    |

H₃S rel_err_max = 191.685% reflects the legitimate functional-spread between OptB88vdW (JARVIS, +0.108) and PBE (mp_cache/OQMD, near 0 to slightly negative for the most-stable polymorph) for a metastable high-pressure hydride — informative DEVIATION-shaped consensus, NOT a bug. The s5 caveat directly addresses this case.

---

## 3. R4 invariant audit (20-cell rerun)

```
absorbed_true_count:   0
absorbed_false_count:  20
critical_violations:   0
```

**0 / 20 records carry `absorbed=true`.** R4 invariant holds across the entire 20-cell matrix. JARVIS adapter introduces NO `absorbed=true` paths — `cross_code_dft.py` continues to emit `absorbed=false` unconditionally regardless of how many sources returned values.

---

## 4. Before/after delta (uplift quantification)

| metric                                  | Phase 2 ext baseline (18/20) | Phase 2 jarvis-rerun (20/20) | delta     |
|-----------------------------------------|------------------------------|------------------------------|-----------|
| total PASS                              | 18                           | 20                           | +2        |
| DEVIATION                               | 2 (YBCO + H₃S)               | 0                            | −2        |
| cross_code_dft consensus cells (n ≥ 2)  | 2 / 5 (Nb, MgB₂)             | 4 / 5 (+YBCO, +H₃S)          | +2        |
| cross_code_dft honest skip (n = 0)      | 1 / 5 (claim-only-RT-SC)     | 1 / 5 (claim-only-RT-SC)     | unchanged |
| R4 violations                           | 0                            | 0                            | unchanged |

**Net uplift: 18/20 → 20/20 PASS** — both DEVIATION cells flipped via the 3rd DFT corpus addition. The 4th baseline (claim-only-RT-SC, anonymized 2026-05-22) is unchanged honest skip (n=0) — JARVIS does NOT manufacture coverage for hypothetical compositions, exactly as designed.

---

## 5. Honest caveats (per RTSC §9.9.1 invariants)

- **(c1) OptB88vdW vs PBE functional mismatch**: JARVIS-DFT primarily uses OptB88vdW; mp_cache + AFLOW + OQMD are PBE-dominated. The inverse-variance consensus is now **2 PBE + 1 OptB88vdW** — sigma narrows but the s2 systematic-error correlation is unchanged. The new scope_caveat (s5) flags this explicitly. Future: if a need for PBE-only consensus arises, filter `consensus_sources` by functional family at the consensus layer.
- **(c2) H₃S rel_err_max = 191%**: this is the worst pairwise spread in the matrix and reflects legitimate functional disagreement at a metastable composition. The consensus value (+0.022 eV/at) is the inverse-variance weighted mean, NOT a "we ignored the disagreement" smoothing. Downstream consumers should treat H₃S as a candidate funnel signal with **wide DEVIATION**, not a tight prediction. R4 invariant means absorbed=false regardless.
- **(c3) Anonymous-read load**: JARVIS-OPTIMADE has no published rate limit but NIST OPTIMADE federation conventionally throttles at ~1 req/s. The 20-cell rerun ran in < 1 min total (4 JARVIS calls in cross_code_dft row only). Light load; no rate-limit hit observed. If future bulk runs (e.g., N=1000 candidate funnels) emerge, add `time.sleep(0.2)` between calls and surface honest rate-limit caveat.
- **(c4) No NOMAD revisit**: NOMAD remains honestly rejected for this blocker (formation_energy NOT indexed as doc-quantity). If/when non-formation-energy gaps emerge (phonon band structure for Allen-Dynes, electron-phonon λ for BETE-NET cross-check, etc.), NOMAD archive-level access becomes worth the ~150-200 LOC. Out of scope here.

---

## 6. Record paths (audit trail)

```
/tmp/phase2-jarvis-rerun/cross_code_dft/Nb/material_verify_20260521T180258Z.json                 (sim-only-pred, n=3)
/tmp/phase2-jarvis-rerun/cross_code_dft/MgB2/material_verify_20260521T180303Z.json               (sim-only-pred, n=3)
/tmp/phase2-jarvis-rerun/cross_code_dft/YBa2Cu3O7/material_verify_20260521T180311Z.json          (sim-only-pred, n=3 · DEVIATION flipped)
/tmp/phase2-jarvis-rerun/cross_code_dft/claim-only-RT-SC/material_verify_20260521T180328Z.json   (insufficient-sources, n=0 · honest)
/tmp/phase2-jarvis-rerun/cross_code_dft/H3S/material_verify_20260521T180333Z.json                (sim-only-pred, n=3 · DEVIATION flipped)
+ 15 cells for csp / beenet / askcos producers — all honest skip with absorbed=false (see /tmp/phase2-jarvis-rerun/{csp,beenet,askcos}/*/)
```

All exit codes = 0 (honest-skip producers exit 0 even on skip, per Phase 1 contract).

---

## 7. Phase progress row update

`RTSC.md §9.9.1 Phase progress table` row "Phase 2 ext follow-on (3rd DFT corpus decision)":

- **Before**: ⏳ **DECIDED** · JARVIS picked · adapter PENDING separate session
- **After**:  ✅ **LANDED** · adapter at hexa-lang `phase2-jarvis-adapter-2026-05-22` commit `d3a3f8e8` (`_poll_jarvis` + `_hill_formula` · 143 LOC delta · OptB88vdW s5 caveat) · 20-cell rerun confirms **20/20 PASS** (uplift +2 from YBCO + H₃S DEVIATION flip) · R4 invariant intact · claim-only-RT-SC honest skip unchanged

---

## 8. Closure

JARVIS-OPTIMADE adapter LANDED at hexa-lang `d3a3f8e8` (single file, ADDITIVE, B-path wrap-as-is). 20-cell Phase 2 ext rerun confirms **20/20 PASS** — uplift +2 from the YBCO and H₃S DEVIATION cells flipping via mp_cache + oqmd + jarvis n=3 consensus. R4 invariant intact (0/20 `absorbed=true`). The claim-only-RT-SC 4th baseline remains honest `insufficient-sources` (n=0) — JARVIS does not manufacture coverage for hypothetical compositions.

Phase 2 ext blocker #1 (AFLOW + OQMD multi-corpus dropout on YBCO + H₃S) is **CLOSED**. The wider RTSC §9.9.1 Phase progress can advance — Phase 2 ext + follow-on both ✅ LANDED, microkernel layer (Phase 3 + Phase 4 #1) untouched, no new D-block needed (D-max stays 116).

Anchor commit (this session): demiurge audit note + RTSC row flip lands alongside hexa-lang `d3a3f8e8`.
