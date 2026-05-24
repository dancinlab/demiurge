# RTSC §9.9.1 Phase 2 ext (16→20 cell) — H₃S 5th baseline · AFLOW gap audit

> Anchor: `RTSC.md §9.9.1 Phase progress table` row "Phase 2 ext (16→20 cell)" + Phase 2 stabilization audit (`inbox/notes/2026-05-21-rtsc-9-phase2-stabilization.md`)
> Date: 2026-05-22
> Inputs (read-only, no source change): 4 producers under `/Users/ghost/core/hexa-lang/stdlib/material/{csp,beenet,askcos,cross_code_dft}_adapter.py`
> Outputs: `/tmp/phase2-ext-20cell/<producer>/H3S/*.json` (4 new records — 5th baseline)

---

## 1. 5×4 matrix update — H₃S row appended

| producer            | Nb                                | MgB₂                              | YBa₂Cu₃O₇                              | Claim-only RT-SC (anonymized 2026-05-22)             | **H₃S (NEW)**                          |
|---------------------|-----------------------------------|-----------------------------------|----------------------------------------|------------------------------------|----------------------------------------|
| csp_adapter.py      | PASS · install-gated              | PASS · install-gated              | PASS · install-gated                   | PASS · install-gated               | **PASS · install-gated**               |
| beenet_adapter.py   | PASS · install-gated              | PASS · install-gated              | PASS · install-gated                   | PASS · install-gated               | **PASS · install-gated**               |
| askcos_adapter.py   | PASS · domain-mismatch            | PASS · domain-mismatch            | PASS · domain-mismatch                 | PASS · domain-mismatch             | **PASS · domain-mismatch**¹            |
| cross_code_dft.py   | PASS · simulation-only-prediction | PASS · simulation-only-prediction | **DEVIATION** · insufficient-sources (n=1) | PASS · insufficient-sources (n=0) | **DEVIATION** · insufficient-sources (n=1)² |

Phase 2 ext totals (H₃S column only, 4 new cells): **3 PASS / 1 DEVIATION / 0 FAIL / 0 crash.**
Cumulative 20-cell totals: **18/20 PASS · 2 DEVIATION · 0 FAIL · 0 crash.**

Footnotes:
1. **H₃S on askcos**: H₃S is in the explicit `_INORGANIC_SC_HINTS` allow-list in `askcos_adapter.py` ("H3S" is one of the family literals), so the domain-mismatch routes via explicit-hit (rationale: "explicit hit on RTSC §8.2 SC family (H3S)"). Honest skip — same shape as Nb/MgB₂/YBCO/claim-only RT-SC slot. No surprise.
2. **H₃S on cross_code_dft**: only **`mp_cache` returned a value** (5 polymorph rows, mean = −0.1178 eV/atom, σ = 0.3395). **AFLOW returned empty data list, OQMD returned empty data list.** `poll_errors=[]` — both upstreams were reachable; they simply have no H₃S entry. Net gate: `insufficient-sources` (n=1, requires ≥ 2). This is the **second** DEVIATION in the 20-cell matrix from a *single-source DFT corpus*, with YBCO being the first.

---

## 2. AFLOW gap audit — **gap is broader than cuprates**

The Phase 2 blocker #1 hypothesis (cf. `2026-05-21-rtsc-9-phase2-stabilization.md` §4 item 1) was: *"AFLOW endpoint coverage gap may be cuprate-family specific (YBCO failed because cuprate compositions aren't in LIB1-LIB6 prototype library)."* H₃S was selected as the **control case** because:

- H₃S is **not** a cuprate (no Cu, no perovskite/layered-oxide motif).
- H₃S is a **canonical high-Tc hydride** (Drozdov 2015, Tc≈203 K at 155 GPa). It is the single most-cited hydride composition in DFT-Tc literature post-2015 — if AFLOW carries any hydride at all, it should carry this one.
- H₃S has solid Materials Project coverage (mp_cache returned **5 rows** with reasonable formation energy).

**Empirical result**: AFLOW returned **empty data list** for H₃S (same shape as YBCO — graceful skip, no `poll_errors`). OQMD also returned **empty** (different from YBCO, which had OQMD silently absent — and different from MgB₂/Nb where OQMD returned multiple polymorph rows).

**Verdict**: **AFLOW coverage gap is NOT cuprate-family-specific.** It is a broader phenomenon: AFLOW's public AFLUX endpoint silently absents itself for any composition outside its LIB1-LIB6 prototype-library training distribution, which includes (at minimum) cuprates AND high-pressure hydrides. The cuprate-specific hypothesis is **falsified by this control**.

**Secondary finding**: OQMD also has a coverage hole for H₃S. Phase 2 blocker #1 was framed as "AFLOW dropout"; the 20-cell matrix shows this is more accurately a **multi-corpus dropout pattern on uncommon compositions** (high-pressure hydrides, cuprate-family, hypothetical apatites all hit it). mp_cache survives as the single fallback for H₃S, which by itself is not enough for a 2-source consensus.

**Phase 3+ escalation candidate (upgraded from medium to medium-high severity)**: the existing recommendation to add a 3rd DFT source (NOMAD, JARVIS-DFT) is now **stronger** than the Phase 2 audit framed it. With AFLOW + OQMD both vulnerable to compositional dropout, a single MP-cache fallback yields `n=1 → insufficient-sources` in ≥ 2/5 baseline cells. **A 3rd corpus is the minimum-viable patch to harden the consensus path for the canonical SC test set.**

Anti-pattern guard (per RTSC.md §9.9.1): adding a 3rd corpus = wrap-as-is on a 3rd external endpoint, NOT porting the data. Stays B path; no microkernel impact.

---

## 3. R4 invariant audit (H₃S row)

**Result: 0 / 4 H₃S records have `absorbed=true`.** All 4 emitted records carry `absorbed: false`.

```
absorbed_true_count:   0
absorbed_false_count:  4
critical_violations:   0
```

Per-record check:
- `/tmp/phase2-ext-20cell/csp/H3S/material_verify_csp_20260521T154840Z.json` → `absorbed: false` · `gate_type: install-gated`
- `/tmp/phase2-ext-20cell/beenet/H3S/material_verify_beenet_20260521T154841Z.json` → `absorbed: false` · `gate_type: install-gated`
- `/tmp/phase2-ext-20cell/askcos/H3S/material_verify_20260521T154843Z.json` → `absorbed: false` · `gate_type: domain-mismatch`
- `/tmp/phase2-ext-20cell/cross_code_dft/H3S/material_verify_20260521T154843Z.json` → `absorbed: false` · `gate_type: insufficient-sources`

Cumulative 20-cell R4 audit: **0 / 20 records have `absorbed=true`.** R4 invariant holds across the entire extended matrix. No exceptions.

---

## 4. Verdict update for §9.9.1 Phase 2 ext

| Phase row | Before this session | After this session |
|---|---|---|
| Phase 2 ext (16→20 cell) | ⏳ PENDING · 5th baseline (H₃S / LaH₁₀) · AFLOW gap blocker 재현 audit | ✅ **LANDED** · 5th baseline = H₃S · 18/20 PASS · 2 DEVIATION (both = `insufficient-sources` via AFLOW+OQMD dropout) · **AFLOW gap NOT cuprate-specific (control case falsified hypothesis)** |

Anchor commit (this session): see `inbox/notes/2026-05-22-rtsc-9-phase2-ext-20cell.md` landed alongside RTSC.md row flip.

---

## 5. Per-cell record paths (H₃S column audit trail)

```
/tmp/phase2-ext-20cell/csp/H3S/material_verify_csp_20260521T154840Z.json        (install-gated)
/tmp/phase2-ext-20cell/beenet/H3S/material_verify_beenet_20260521T154841Z.json  (install-gated)
/tmp/phase2-ext-20cell/askcos/H3S/material_verify_20260521T154843Z.json         (domain-mismatch · explicit-hit on H3S allow-list)
/tmp/phase2-ext-20cell/cross_code_dft/H3S/material_verify_20260521T154843Z.json (insufficient-sources · n=1 · mp_cache only · AFLOW+OQMD both empty)
```

All exit codes = 0 (honest-skip producers exit 0 even on skip, per Phase 1 contract).

---

## 6. Closure

Phase 2 ext (16→20 cell) audit complete. **R4 invariant intact** across all 20 cells. **AFLOW gap hypothesis falsified** — the gap is NOT cuprate-family-specific; it is a broader multi-corpus coverage dropout on compositions outside the LIB1-LIB6 prototype training distribution (cuprates AND high-pressure hydrides confirmed, hypothetical apatites previously confirmed). **OQMD also exhibits the dropout** on H₃S, weakening the "AFLOW-only" framing of Phase 2 blocker #1.

**Net update to Phase 2 blocker #1**: severity ↑ from medium → medium-high. Patch direction unchanged (add 3rd DFT corpus, NOMAD or JARVIS-DFT, as B-path wrap-as-is), but priority and impact are higher than Phase 2 framed: the dropout affects ≥ 40% (2/5) of canonical baseline cells, not just 25% (1/4).

No producer source modified. No `absorbed=true` introduced. No retries on the cross_code_dft DEVIATION — `insufficient-sources` is the **honest** verdict and the deliverable.
