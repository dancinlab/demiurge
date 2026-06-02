# USER_ACTION_REQUIRED — active asks for the user

> **Created**: 2026-05-13 (Phase A elevation) · **Status**: live (active asks)
> **Companion**: `V1_2_0_HANDOFF.md` (roadmap context for these decisions)
>
> This document collects decisions that require user input before Phase B/C/D
> can land. Each ask is *concrete* (decision, with stated default if no input).
> Resolved asks get moved to `LESSONS.md` §1/§2 as appropriate.

---

## §1 Confirm — external entity discipline (already done, documenting explicitly)

**Decision**: Confirm that the following discipline is in place and should remain:

> External entities (Wacker, GCL, Hemlock, OCI, REC Silicon, Tongwei, DuPont,
> BASF, Toray, Element Six, Wolfspeed, PCC, Howmet, Lafarge-Holcim, Sibelco,
> etc.) are cited using their **own published numbers** (annual report,
> datasheet, vendor spec, NIST SRM, ASTM standard). The n=6 invariant lattice
> is **not** applied as a predictor or constraint for any vendor / external

**Current state**: ✅ in place — see `silicon/silicon.md §3 vendor` table for the canonical example. All vendor tonnage figures are cited with explicit "this spec does not project these onto n=6 nor claim n=6 is implicated."

**User confirmation status**: ✅ implicitly confirmed by adopting LATTICE_POLICY (Wave K) and authoring `silicon/silicon.md` under that policy. This document makes the confirmation explicit.

**Action requested**: NONE — already done. Documented here so future agents see the discipline as user-approved.

---

## §2 Decide — Phase D verb priority

**Decision**: Which **3-5 new verbs** should land first in Phase D (v2.0.0)? Phase D has 12+ candidates (per `DECOMPOSITION_PLAN.md §3`):

### Candidates (with industrial relevance ranking)

| # | Verb | Group | Industrial relevance | Why this priority |
|---|------|-------|----------------------|-------------------|
| 1 | **superalloy** | MET | ⭐⭐⭐⭐⭐ | Aerospace / energy turbine; clean fit existing MET |
| 2 | **compound-semi** | CER | ⭐⭐⭐⭐⭐ | Power electronics + RF (GaN, SiC) + LED (GaN, InGaN); cross-link silicon/ |
| 3 | **2d-materials** | new GROUP_2D | ⭐⭐⭐⭐ | Future-facing (graphene, h-BN, MoS₂); FET / quantum / battery |
| 4 | **perovskite** | CER | ⭐⭐⭐⭐ | Solar (MAPbI₃) + memory (HfO₂-stabilized) + LK-99 disambiguation |
| 5 | **elastomer** | POL | ⭐⭐⭐⭐ | Tire + medical + sealant; large global market |
| 6 | **printing** | PRC | ⭐⭐⭐⭐ | Additive manufacturing; cross-cuts all groups |
| 7 | **magnetic-materials** | CER/MET | ⭐⭐⭐ | NdFeB rare-earth + motor + storage |
| 8 | **adhesive** | POL | ⭐⭐⭐ | Aerospace + electronics assembly |
| 9 | **MOF** | CER/POL | ⭐⭐⭐ | Gas storage + catalysis (research frontier) |
| 10 | **liquid-crystal** | POL | ⭐⭐ | Display tech (mature; less frontier) |
| 11 | **biodegradable-plastics** | POL | ⭐⭐⭐ | Cross-domain hexa-bio fermentation overlap |
| 12 | **wood-cellulose** | FIB | ⭐⭐ | Sustainable materials; cross-domain hexa-farm overlap |

### Recommended default (if user does not respond)

**Top 5**: superalloy + compound-semi + 2d-materials + perovskite + elastomer.

Rationale:
- All 5 have direct industrial relevance (aerospace, semiconductors, future displays/quantum, solar, mobility)
- Mix of group expansion: MET (superalloy), CER (compound-semi, perovskite), POL (elastomer), new GROUP_2D (2d-materials)
- Each is a >300-line chapter candidate; comparable scope to existing CERAMICS.md / METALLURGY.md

### Alternative priorities user might prefer

- **Cross-domain priority**: biodegradable-plastics + wood-cellulose + MOF (better hexa-bio / hexa-farm / hexa-earth bridging)
- **Pure-physics priority**: 2d-materials + perovskite + compound-semi + magnetic-materials (denser real-limits coverage)
- **Manufacturing-process priority**: printing + adhesive + superalloy + elastomer (closer to industrial supply chain)

**Action requested**: USER to pick a priority cluster, or accept the recommended default.

**If no response by next phase milestone**: proceed with recommended default (superalloy, compound-semi, 2d-materials, perovskite, elastomer).

---

## §3 Decide — does hexa-matter need a separate `hexa-craft` for lutherie?

**Background**: `lutherie/lutherie.md` (instrument craft) currently lives in GROUP_MET because the *sound-bearing components* (string alloys, bell brass, gong bronze) are alloy-engineering. But lutherie has a strong **culture / craft** identity that is not metallurgical.

This is parallel to the hexa-bio decomposition where `hair-regeneration`, `cosmetic-surgery`, `perfumery` were moved to a separate `Floréa` brand (per `hexa-bio/DECOMPOSITION_PLAN.md §3`) because they had a distinct cosmetic / aesthetic identity beyond medical scope.

### Options

| Option | Description | Effort | When |
|--------|-------------|--------|------|
| **(A) keep lutherie in hexa-matter** | Status quo; lutherie stays in GROUP_MET | 0 | — |
| **(B) move lutherie to hexa-craft (new repo)** | Separate culture-craft repo for lutherie + (future) ceramics-as-craft + textile-craft + wood-craft | ~1 day to create repo + migrate | v1.2.x window |
| **(C) move lutherie to hexa-arts** | Existing repo at `~/core/hexa-arts/`; if it has the right scope, absorb | ~hours | v1.2.x window |

### Recommended default (if user does not respond)

**Option A** — keep lutherie in hexa-matter for now. The metallurgical content is real (alloy phase diagrams for bell bronze, valve materials, string alloys). The culture/craft aspect can be cross-linked from a future `hexa-craft` or `hexa-arts` repo via a sister-substrate pattern.

### What the user would tell us

- Pick option A / B / C
- If B, confirm "hexa-craft" as the repo name
- If C, confirm hexa-arts is the right destination

**Action requested**: USER decision. Default = (A) status quo.

---

## §4 Decide — Phase B parity gate format

**Background**: Phase B parity gates (B-CER-1..B-FAS-2, per `CLOSURE_RESIDUAL_BACKLOG.md §B`) need a deterministic format. There are 2 candidate styles:

### Option (i) — pure-Python stdlib parity scripts

Mirror hexa-bio's `selftest/` pattern: each parity gate is a stdlib-only Python script with:
- A `__SENTINEL_NAME__ PASS` sentinel on success
- Hard-coded expected values from NIST/CRC/ASM citations
- Numerical-tolerance comparison against the cited value
- Wired into `verify/run_all.hexa` as a `.hexa` shim that calls the Python script

Example:
```python
# tests/cer_b2_si_density_parity.py
SI_DENSITY_CRC_105 = 2.329  # g/cm³ at 293 K, CRC Handbook 105th ed.
SI_DENSITY_SPEC = 2.329     # claimed in silicon/silicon.md Si-L6

assert abs(SI_DENSITY_CRC_105 - SI_DENSITY_SPEC) < 1e-6
print("__CER_B2_SI_DENSITY_PARITY__ PASS")
```

### Option (ii) — pure .hexa parity scripts

Mirror existing `verify/*.hexa` style: write each parity gate in `.hexa` directly, leveraging the existing aggregator pattern.

Example:
```hexa
// verify/cer_b2_si_density_parity.hexa
let SI_DENSITY_CRC = 2.329    // CRC Handbook 105th ed.
let SI_DENSITY_SPEC = 2.329   // silicon/silicon.md Si-L6
if (SI_DENSITY_CRC == SI_DENSITY_SPEC) {
  print("__CER_B2_SI_DENSITY_PARITY__ PASS")
} else {
  fail("density parity FAIL")
}
```

### Recommended default

**Option (ii)** — pure .hexa, no Python deps. Aligns with the existing `verify/*.hexa` aggregator and avoids Python venv coupling.

Use **Option (i) Python** only for gates that require complex numerical work (e.g., Hales packing simulation, Frenkel σ_th calculation across material classes). These are minority.

**Action requested**: USER confirmation of recommended default.

**If no response**: proceed with Option (ii) for simple parity gates, Option (i) for compute-heavy gates.

---

## §5 Decide — Phase C depth-dir authoring order

**Background**: Phase C lands ~11 new depth dirs (per `V1_2_0_HANDOFF.md §2`). What order should they land?

### Recommended order (if user does not respond)

Top-down by Phase D priority:
1. `superalloy/` (highest priority Phase D verb)
2. `compound-semi/`
3. `2d-materials/`
4. `perovskite/`
5. `elastomer/`
6. `printing/`
7. `adhesive/`
8. `magnetic-materials/`
9. `mof/`
10. `liquid-crystal/`
11. `biodegradable-plastics/`
12. `wood-cellulose/`

This matches the recommended Phase D top-5 picks (§2), so Phase C → Phase D pipeline is in sequence.

### Alternative orders

- **By group balance**: ensure each group gets 1-2 new depth dirs first before any group gets 3+ (avoids GROUP_POL becoming 80% of new content)
- **By cross-domain priority**: biodegradable-plastics + wood-cellulose first if cross-domain bridging is a strategic goal

**Action requested**: USER decision. Default = top-down by Phase D priority.

---

## §6 Decide — sister-repo discipline for shared chemistry

**Background**: Some material verbs have natural overlap with sister repos:
- `silicon/` ↔ `hexa-chip/` (device + fab)
- `biodegradable-plastics/` (Phase D candidate) ↔ `hexa-bio/` fermentation chapter
- `wood-cellulose/` (Phase D candidate) ↔ `hexa-farm/` agriculture
- `magnetic-materials/` (Phase D candidate) ↔ `hexa-energy/` motor + storage
- `microplastics/` ↔ `hexa-earth/` planetary fate

**The hexa-bio approach** (per `AGENTS.md` "Sister repositories — live dependencies"): **CLI integration over Python wrappers**. Don't reimplement sister-repo logic in-tree; call the sister CLI directly. This is the pattern used by `selftest/qmirror_chemistry_vqe_gate.sh` in hexa-bio.

### Action requested

Confirm that hexa-matter adopts the same "CLI integration over Python wrappers" discipline for cross-domain interactions:

- ✅ hexa-matter `silicon/` covers material aspect; calls `hexa-chip materials` for device/fab
- 🟡 hexa-matter Phase D `biodegradable-plastics/` should call `hexa-bio fermentation` for the bio side (no in-tree fermentation reimplementation)
- 🟡 hexa-matter Phase D `wood-cellulose/` should call `hexa-farm wood` (when that exists)
- 🟡 hexa-matter Phase D `magnetic-materials/` should call `hexa-energy motor` (when that exists)
- 🟡 hexa-matter `microplastics/` should cross-link to `hexa-earth` (when that exists)

**Recommended default**: adopt the discipline (matches hexa-bio sister-repo policy). Update `AGENTS.md` to document it.

**Action requested**: USER confirmation. Default = adopt.

---

## §7 Resolved asks (moved here when closed)

(none yet)

---

## §8 Honest C3

- This document is a *plan*, not a verification artifact. The user-confirmation rows are explicit about default behavior if no response.
- Recommended defaults are listed for every ask so the substrate can continue progressing even without user input on every question.
- No n=6 lattice anchoring of any user-decision recommendation (per LATTICE_POLICY §1.2).

---

## §9 References

- `V1_2_0_HANDOFF.md` — Phase B-G roadmap context
- `AXIS_CLOSURE_PLAN.md` — per-group (a)/(b)/(c) closure
- `CLOSURE_RESIDUAL_BACKLOG.md` — per-row deferral ledger
- `DECOMPOSITION_PLAN.md` — Phase D candidate enumeration
- `LATTICE_POLICY.md` — universal real-limits standard
- `hexa-bio/USER_ACTION_REQUIRED.md` — sister-substrate style reference

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation. Active asks documented in the hexa-bio USER_ACTION_REQUIRED style.*
