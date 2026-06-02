# LESSONS — hexa-matter v1.0.0 → v1.1.0 construction journal

> **Created**: 2026-05-13 (Phase A elevation, post-silicon close)
> **Scope**: lessons learned during the v1.0.0 import + Wave M LIMIT_BREAKTHROUGH
> audit + microplastics absorption + silicon authoring → v1.1.0 17-verb close.
> **Spirit**: hexa-bio's LESSONS.md style — what worked, what surprised, what
> anti-patterns we avoided.

---

## §1 What worked — the wins to preserve

### §1.1 Minimal verify scoreboard + SPEC_FIRST verdict

The 4-script aggregator (`verify/run_all.hexa`) was the right shape:
- `spec_presence` — every claimed verb has a file at the declared path
- `lattice_arithmetic` — n=6 self-consistency as **auxiliary** (per LATTICE_POLICY §1.3)
- `real_limits_anchor` — NIST/CRC/Hales/Frenkel anchors *load-bearing*
- `closure_consistency` — CLI · `hexa.toml` · README · AGENTS.md row-by-row consistency

Why this worked: each script is a *deterministic predicate*. No human judgment, no rater rubric. The whole substrate goes green (4/4) or it doesn't.

The `SPEC_FIRST` verdict in `hexa.toml [closure].verdict` was honest about what shipped: 17 verbs ship as *peer-citable markdown specs* with CLI dispatcher headlines. We did NOT claim wired numerical sandboxes at v1.0.0 — that gates Phase B and beyond. This avoided the common anti-pattern of conflating spec presence with verified implementation.

### §1.2 Canon-import provenance discipline

Every imported spec doc (16 of the 17) carries a `@canonical: canon/domains/materials/...` provenance header injected by `tools/inject_provenance.hexa`. The drift checker `tools/check_drift.hexa` flags any spec doc that has been edited without bumping the provenance pointer.

This worked because **canon@47c70cbf was a frozen SHA**. The imported docs are immutable artifacts at that SHA; any local edit is by definition a *fork*, not a sync. The provenance header preserves the lineage.

The 17th verb — silicon — was authored in-repo on 2026-05-13 (commit `a239611`) and carries NO `@canonical:` header (because there is no upstream canon source). The provenance is explicit:

```
@authored: 2026-05-13
@author: 박민우 <nerve011235@gmail.com>
```

This honesty preserves the audit trail: we know exactly which 16 verbs are canon-import lineage and which 1 verb is in-repo authored.


The hardest discipline lesson came from authoring `silicon/silicon.md`. The temptation to write "Wacker produces N kt/yr poly-Si and the n=6 lattice predicts 12·N..." was real and was rejected. The rule (from `AGENTS.md`):

> claims about external entities (companies, fabs, accelerators, life systems) must NOT include lattice-fit assertions. Use that entity's *own* invariants.

The result: `silicon/silicon.md §3` table lists vendor-published tonnage figures (GCL, Wacker, Hemlock, OCI, REC, Tongwei) with the explicit caveat "this spec **does not project these onto n=6 nor claim n=6 is implicated**". This preserved honesty.

The same discipline scales to ALL Phase F (research bridge) work — MatWeb, NIST SRD, ASTM, SEMI numbers all flow in as vendor/standards-body data, not as lattice predictions.

### §1.4 Sister-substrate aggregator pattern

`verify/run_all.hexa` is a structural sibling of `hexa-rtsc/verify/run_all.hexa`, `hexa-ufo/verify/run_all.hexa`, `hexa-cern/verify/run_all.hexa`, `hexa-fusion/verify/run_all.hexa`. The same shape (4 scripts + aggregator + scoreboard sync) made it easy to:

- Sanity-check that we hadn't invented a new pattern when an old one would do
- Cross-port the closure-consistency.hexa pattern from hexa-rtsc by adaptation
- Map the 4-script aggregator onto the spec-first scope (1 spec-presence + 1 lattice-aux + 1 real-limits + 1 scoreboard) cleanly

The hexa-bio aggregator is more complex (5-axis × multi-gate); hexa-matter's 4-script aggregator is the *minimum viable* sister and worked perfectly.

### §1.5 LATTICE_POLICY adoption (Wave K)

The dancinlab-wide LATTICE_POLICY.md deployment on 2026-05-12 was a force multiplier. By committing to "the project's ceiling is set by REAL math/physics/engineering limits, never by the n=6 invariant lattice", the entire downstream audit (`LIMIT_BREAKTHROUGH.md` Wave M) was clean — NIST WebBook + CRC Handbook + ASM Handbook + Ashby + Hales + Frenkel + Stefan-Boltzmann as anchors, no lattice-fit anywhere.

The Wave K policy made the silicon addition (Wave M follow-up) *easy*: when authoring `silicon/silicon.md`, the LATTICE_POLICY §1.2 was already in place and the Si-L1..Si-L12 limits table just plugged in without any boundary disputes.

---

## §2 What surprised — the unexpected discoveries

### §2.1 Silicon gap discovered post-v1.0.0

When v1.0.0 shipped (2026-05-09) with 16 verbs, **silicon was missing**. The assumption was that silicon = semiconductor = `hexa-chip` territory. This assumption was wrong.

The audit that surfaced the gap: Wave M's `LIMIT_BREAKTHROUGH.md` enumeration of material limits. We had L1..L12 for steel/aramid/concrete/glass/diamond/Os/etc., but no row for poly-Si purity, mono-Si wafer dimensions, SiC bandgap, or Si₃N₄ flexural strength. The Wave M audit was the right shape but had a Si-shaped hole.

The fix took one day (2026-05-13):
- Author `silicon/silicon.md` (~300 lines) with Si-L1..Si-L12 limits table
- Add `silicon = "silicon/silicon.md"` to the `[verbs]` table in `hexa.toml`
- Update `cli/hexa-matter.hexa` dispatcher to include `silicon`
- Update `README.md` Run table + Verify list + scoreboard
- Run `verify/run_all.hexa` → 4/4 PASS

The lesson: **gap detection works**. The `LIMIT_BREAKTHROUGH.md` audit was not just a documentation artifact — it was a *gap detector* for the verb taxonomy. Wave M's L1..L12 row enumeration revealed the missing Si row, which revealed the missing silicon verb.

### §2.2 LATTICE_POLICY pivot — n=6 as tool, not constraint

Before Wave K (2026-05-12), the implicit understanding was that the n=6 lattice *constrained* the verb count and group structure. Many earlier drafts of `MATERIAL-SYNTHESIS.md` and `HEXA-RECYCLE.md` had σ(6)=12 / τ(6)=4 / J₂=24 references that were *load-bearing*.

User directive (2026-05-12, Wave K): "n=6 격자를 강제할 필요 없어, 제한없이" → "don't force the n=6 lattice, no constraints."

The pivot:
- LATTICE_POLICY.md §1.2: n=6 is a *tool* (use where it naturally fits), not a *constraint* (don't force it onto external domains)
- LATTICE_POLICY.md §1.3: lattice-arithmetic identities (σ·φ=24) are AUXILIARY self-consistency checks; they do NOT constitute verification

After the pivot, every spec doc was audited for lattice-fit on external entities (Wacker, GCL, Wolfspeed, DuPont, BASF) and cleaned. The substrate is now honest about what the lattice is (an internal arithmetic invariant for n=6) and what it is not (a predictor of vendor tonnage, fab capacity, or material parameter).

This pivot was painful but right. The post-pivot state is the one we ship.

### §2.3 Sister-substrate aggregator pattern was reusable

We expected to write a bespoke aggregator for the spec-first scope. Instead, the hexa-rtsc / hexa-ufo / hexa-cern aggregator pattern fit *unchanged* (modulo the 4-script vs 5-script count). This was a happy surprise:

- The "exit 0 = all PASS" contract is universal
- The OLDPWD root-resolution trick (from hexa-rtsc) is universal
- The scoreboard sync (`closure_consistency.hexa`) was directly portable

The lesson: when sister substrates exist, *copy the aggregator pattern*. Don't invent.

### §2.4 Microplastics absorption from hexa-medic was clean

When hexa-medic was decomposed (per `hexa-bio/DECOMPOSITION_PLAN.md §1`), `microplastics` was moved to hexa-matter on 2026-05-12 (commit `7bf9b61`). This was a worry — would the hexa-medic verb fit hexa-matter's group taxonomy?

It fit cleanly into GROUP_POL because:
- microplastics ARE polymers (PE, PP, PS, PET, PVC, PA fragments)
- The environmental-fate axis is a *downstream* application of polymer chemistry, not a fundamentally new chemistry
- The existing POL verbs (aramid, epoxy, nylon, pet_film) have the same bond chemistry; microplastics just adds the partition / leaching / biofilm aspect

The lesson: **cross-repo absorption works when the chemistry/physics match the target group**. If we had tried to absorb (say) `cancer-therapy` from hexa-medic, it would NOT have fit any hexa-matter group. The microplastics move was successful because the chemistry matched.

---

## §3 Anti-patterns avoided

### §3.1 Claiming MEASURED for SPEC content

We resisted the temptation to label spec-doc content as "measured" or "verified" when it was only "cited from canon source". The actual verdict is `SPEC_FIRST` in `hexa.toml [closure].verdict`. The 17 verb spec docs are *peer-citable markdown* (you can cite them, you can read them, you can use them as starting points), but they are NOT verified implementations.

The `verify/run_all.hexa` 4-script PASS means:
- ✅ Spec docs are present at declared paths
- ✅ Arithmetic on n=6 is internally consistent
- ✅ Real-limits anchor cites are present
- ✅ Scoreboard rows match across CLI/toml/README/AGENTS

It does **NOT** mean:
- ❌ Vendor numbers have been independently re-measured
- ❌ NIST/CRC values have been re-derived from first principles
- ❌ Implementation code has been unit-tested for correctness

The honesty here is in `hexa.toml [scope]`:
```
honest_scope = "17-verb 통합 substrate (7 그룹). spec-first markdown only at
v1.0.0 — 작동 .hexa CLI는 spec headline dispatcher."
```

### §3.2 Lattice-fit on vendor specs

The biggest anti-pattern in materials science (broadly) is the temptation to claim that a vendor's published tonnage / yield / purity figure "matches" some theoretical structure. We resisted this for all external entities:

- Wacker Polysilicon 80 kt/yr → **vendor figure**, not lattice prediction
- GCL Tech 480 kt/yr → **vendor figure**
- Wolfspeed SiC wafer fabrication capacity → **vendor figure**
- DuPont Kevlar 49 σ 3.6 GPa → **published material spec**, not lattice prediction
- Element Six lab-grown diamond CVD output → **vendor figure**

In every case, the spec doc cites the source (annual report, datasheet, NIST SRM, ASM Handbook) and explicitly disclaims lattice anchoring. The `silicon/silicon.md §3 vendor` table sets the pattern.

### §3.3 Forcing 12 / 24 / 36 verb counts

When Phase D candidates were being enumerated (compound-semi, perovskite, 2d-materials, elastomer, adhesive, etc.), the temptation was to land exactly 7 new verbs to hit 24 total (σ-aligned) or 7 more to hit 30. We did NOT do this. The Phase D target is **12+** (engineering-driven, not arithmetic-driven).

If the actual landing is 11 verbs, fine. If it's 14, also fine. The number is whatever the engineering taxonomy demands; the lattice does not get a vote.

### §3.4 Bayesian σ-match audits on material verbs

hexa-bio uses Bayesian σ(6)=12 audits on its 5 axes (n=30/n=60 corpus, log_BF decisive). This is *not* applicable to hexa-matter because material parameters are *measured*, not derived from theory.

We resisted the temptation to write a "Bayesian audit of σ-match across 7 groups" because (a) the σ(6)=12 claim has no load-bearing meaning for material verbs, (b) the deterministic NIST/CRC anchoring is *stronger* than a Bayesian audit, and (c) inventing a fake σ-audit would muddy the water about what the verify scripts actually mean.

The verify scripts do *real* work (spec presence, real-limits anchoring, scoreboard consistency). They do not do Bayesian σ-audit theater.

### §3.5 Inventing measurements / extrapolating from theory

When authoring `silicon/silicon.md`, we did not invent measurements. Every Si-L1..Si-L12 row in the limits table cites a real source:
- Si-L1 (9N purity) — SEMI M1 + Wacker / Hemlock vendor specs
- Si-L5 (T_m = 1687 K) — NIST WebBook
- Si-L6 (ρ = 2.329 g/cm³) — CRC Handbook 105th ed.
- Si-L7 (bandgap = 1.12 eV) — NIST / Sze SM Physics
- Si-L11 (SiC bandgap = 3.26 eV) — Saddow & Agarwal 2004
- Si-L12 (Si₃N₄ flexural 600-1200 MPa) — ASM Handbook vol. 21

No row is a theoretical extrapolation labeled as a measurement. If a row is theoretical (e.g., "Frenkel σ_th ≈ E/10"), it is labeled HARD wall with the Frenkel 1926 citation, not as a measured value.

---

## §4 Methodology lessons — agent-assisted authoring

These are process notes specific to AI-agent-assisted spec construction.

### §4.1 Spec doc length sweet spot ≈ 300-700 lines

`silicon/silicon.md` came out at ~300 lines. `CERAMICS.md` is ~37 kB (~1000 lines). `PAPER.md` is ~2.6 MB (~80k lines, the largest single file — absorbed from canon mk1).

The sweet spot for *new* spec docs (Phase D candidates) is **300-700 lines**:
- Long enough to cover the chemistry + processing + real-limits + cross-link
- Short enough to read end-to-end in a sitting
- Aligns with the hexa-bio per-domain UPPERCASE.md style

The 80k-line PAPER.md is an outlier from the canon mk1 absorption and is treated as a *reference dump*, not a target shape.

### §4.2 Author / extract distinction is load-bearing

For each spec doc, exactly one of these is true:
- **Authored in-repo** (e.g., `silicon/silicon.md`) — no `@canonical:` header, has `@authored:` + `@author:` instead
- **Extracted from canon** (e.g., `ceramics/ceramics.md`, `aramid/aramid.md`) — has `@canonical: canon/domains/materials/<verb>/ @ <SHA>` header

Mixing these is a provenance bug. The drift checker `tools/check_drift.hexa` flags this. We caught one such bug during v1.0.0 → v1.1.0 transition and fixed it cleanly.

### §4.3 Verify scoreboard sync is mandatory after every verb add/remove

After adding silicon:
1. Update `hexa.toml [verbs].ceramic_inorganic` to include "silicon"
2. Update `hexa.toml [closure].verbs_total = 17` (was 16)
3. Update `cli/hexa-matter.hexa` to dispatch `silicon`
4. Update `README.md` Run table
5. Update `README.md` badge counts
6. Update `verify/spec_presence.hexa` to add the silicon path check
7. Update `verify/closure_consistency.hexa` to expect 17 not 16
8. Update `AGENTS.md` if any AGENTS-visible policy change

Missing ANY of these breaks `verify/closure_consistency.hexa`. The verify scoreboard catches it deterministically. We caught one such miss (the closure_consistency.hexa count was off by 1 for ~30 minutes) and fixed it before commit.

### §4.4 Commit message hygiene matters

The commit `a239611 feat(silicon): add silicon material spec — 17/17 verbs (Si wafer, polysilicon, mono-Si, SiO₂ cross-link)` follows the project conventions:
- type(scope): one-line summary
- explicit verb count delta (17/17)
- explicit cross-link callout (SiO₂)
- no claim of measurements that weren't done

This compresses well into release notes (see `RELEASE_NOTES_v1.1.0.md`).

---

## §5 What's queued for v1.2.0 (and beyond)

These are NOT done in Phase A but are written here to set expectations.

| Phase | Scope | Expected duration |
|-------|-------|-------------------|
| **B** | Per-verb selftest gates (B-CER-1..B-FAS-2 parity gates from `CLOSURE_RESIDUAL_BACKLOG.md §B`) | weeks |
| **C** | Per-group depth dirs (superalloy/, 2d-materials/, etc.) | weeks |
| **D** | 12+ new verbs (compound-semi, perovskite, 2d-materials, ..., MOF, liquid-crystal) | months |
| **E** | Python bridge `_python_bridge/module/` (Hales packing calc, Frenkel σ_th calc) | weeks-months |
| **F** | Research bridge to MatWeb / NIST SRD / ASTM / SEMI | months |
| **G** | AlphaFold-class absorption (CALPHAD, MatBench, Materials Project) | long horizon |

The Phase D verb count (12+) is *engineering-driven*. We will NOT force-fit to 24 or 36 or any other arithmetic-aesthetic count.

---

## §5.HX hexa-native Stage-1 migration — lessons (2026-05-18)

1. **Lossless `.py`→`.hexa` port = `grep -E` ERE as the literal
   equivalent of Python `re`** (`\d`→`[0-9]`, `\s`→`[[:space:]]`,
   `(?:..)`→`(..)`, `\b` kept), hexa doing only orchestration. Stage-1
   substring approximation of a digit-shape / word-boundary regex is a
   *verification-power regression* (g3) — it was explicitly never used.
   For the one faithful gap (Python `\s` bridging a ±window newline-join
   in `hardwall_provenance` / `vendor_citation`) only the precompute-
   misses get a precise ±window-join re-grep → exact byte-parity.
2. **Verify byte-parity vs the `.py` before adopting**; wire the
   aggregator as a hexa-first **union** (`.hexa` else `.py`/`.sh`) so
   migration is per-gate incremental-safe, not all-or-nothing. Keep the
   `.py` as fallback + re-parity reference.
3. **A doc/SSOT format change must sweep every consumer regex.** The
   README badge moved to shields.io `verbs-36-informational` in
   `20a919d`; `selftest/registry_consistency_audit` was widened but its
   verify-layer twin `verify/closure_consistency.hexa` was not — so
   `verify/run_all.hexa` had silently regressed to **3/4** and stayed
   there until the HX sweep found it. Format pivots need a grep for all
   matchers, not just the nearest one.
4. **hexa `.substr`/`.len` are byte-indexed.** Multibyte glyphs (`§`,
   `σ`, `τ`, `φ`, `χ²`, `Å`) break char-slice parsers — drive structure
   detection from `grep -nE` line numbers / shell instead, and reserve
   hexa for ASCII-only scanning.

## §6 One-line summary

> Wave K (LATTICE_POLICY pivot — n=6 as tool not constraint) + Wave M
> (LIMIT_BREAKTHROUGH NIST/CRC/Hales/Frenkel audit) + silicon close
> (the missing 17th verb surfaced by Wave M gap detection) = hexa-matter
> v1.x reached **17/17 verbs · 4/4 verify PASS · CLOSED** on 2026-05-13,

---

## §7 References

- `LATTICE_POLICY.md` — universal real-limits standard (Wave K, 2026-05-12)
- `LIMIT_BREAKTHROUGH.md` — hexa-matter real-limits audit (Wave M, 2026-05-12)
- `silicon/silicon.md` — silicon verb authored 2026-05-13
- `hexa.toml` — verb manifest + verify scoreboard
- `hexa-bio/LESSONS.md` — sister-substrate lessons (cycle-30 cohort)
- `hexa-bio/AXIS_CLOSURE_PLAN.md` §0 — residual category (a)/(b)/(c) legend

---

*Document authored 2026-05-13 by 박민우 <nerve011235@gmail.com> as Phase A elevation. Format adapted from `hexa-bio/LESSONS.md` (v7.1 phase γ pocket VQE loop, 2026-05-11..12) with materials-science substitutions.*
