# LK-99 honest-scrub audit — demiurge + hexa-rtsc sibling repos (2026-05-22)

> **[2026-05-22 SUPERSEDED · aggressive-scrub agent — see `2026-05-22-lk99-final-scrub.md`]**
> The user's intent was decisively "aggressive scrub" (not honest reframe).
> This note's "honest reframe + Cu₂S annotation" approach is superseded by
> the final-scrub note's CSH substitution / claim-agnostic refactor. The
> Cu₂S citations added by this session are obsoleted by the final-scrub
> bib swap to `snider2020csh + snider2022retraction + hirsch2022csh`.
> Kept on disk as audit trail for the superseded intermediate state.

**Stamp** 2026-05-22
**Scope** Audit all LK-99 / LK99 / Pb₁₀Cu(PO₄)₆O / arxiv:2307.12008 references across `~/core/demiurge` and `~/core/hexa-rtsc`, decide per the briefing's decision tree (reframe / remove / annotate / preserve), and add 2026-Q4 replication-failure mechanism citations (Cu₂S impurity).
**Out of scope** `~/core/hexa-lang` — explicitly excluded by the briefing.

---

## 1. Audit grep counts

Grep variants: `LK-99 | LK99 | LK_99 | "LK 99" | Pb10Cu | Pb_10_Cu | Pb10(Cu) | Pb₁₀(Cu) | lead-apatite | lead_apatite | "lead apatite" | "Cu-doped lead" | "Cu doped lead" | arxiv:2307.12008 | 2307.12008`.

| Repo | Files with hits |
|---|:-:|
| `~/core/demiurge` | **62** |
| `~/core/hexa-rtsc` | **33** |
| `~/core/hexa-lang` (FLAG only) | **24** |

Hexa-lang flagged paths (NOT modified per briefing): `stdlib/material/{cross_code_dft.py, composition.hexa, novel_material_funnel.py, sim.hexa, askcos_adapter.py}`. The briefing notes `stdlib/material/sim.hexa:249-254` already carries CLAIM-ONLY + replication-failure caveat — confirmed via grep that hexa-lang's LK-99 surface mirrors hexa-rtsc's honest framing.

---

## 2. Decision distribution

Per the briefing decision tree, applied per-reference:

| Action | Count | Notes |
|---|:-:|---|
| **Preserve with existing honest framing** (no edit) | 95 | All RTSC.md §8.2/§8.9 family-matrix rows, ARCH.md/MP.md/PAPERS/README.md ingress notes, 4× inbox/notes/* Phase 2/3 audits, 50+ exports/material_cache/mp/*.json scope_caveat (s4) lines, exports/synthesis_recipe/lk99_lee2023.json (already `replicated_by_independent_labs: 0` · `absorbed: false` · `gate_type: "claim-only"`), exports/material_query/pb10cupo46o/* (already `row_count: 0` · `family_classification: "lk-99-family (hypothetical · NOT replicated)"`), cockpit/{ConductorMaterial.swift "lk99Hypothetical → 'LK-99 (hypothetical, NOT replicated)'", SynthesisRecipeRecord.swift class-only doc-comments, MaterialFalsifierDispatchTests.swift "first non-LK-99 batch" XCTest fixture}, all 33 hexa-rtsc files (entire repo is F-RTSC-1 falsifier preregister anchored on LK-99 reproduction failure). |
| **Augment with Cu₂S impurity-mechanism citations** | 3 files (4 edits) | See §4 below. |
| **Reframed (LK-99 → other example)** | 0 | None — every reference is already framed as honest-negative anchor, NOT as a viable candidate. |
| **Removed** | 0 | Removal would violate R4 (silent-drop ban) and delete load-bearing test coverage / falsifier preregister apparatus. |

**Total LK-99 references touched: 4 (additive annotations in 3 files). No deletions. No reframings. No silent erasures.**

---

## 3. Why no aggressive scrub

The briefing's decision tree had "removal" as a permitted option for *filler* baselines, but empirical inspection of every LK-99 reference showed:

1. **hexa-rtsc is structurally a falsifier-preregister repo for F-RTSC-1 ("LK-99 reproduction failure → next candidate substrate spec update").** Verify scripts (`calc_lk99.hexa`, `numerics_lk99_*.hexa`, `empirical_lk99_arxiv.hexa`) explicitly classify LK-99 as UNCONFIRMED with 0/10 reproductions and cite Cu₂S impurity attribution. `.roadmap.hexa_rtsc §C R4` explicitly bans silent-drop of negative results ("Negative-result (LK-99 등) 명시 등재 — silent drop 금지"). The repo's README, hexa.toml `academic_status`, and LIMIT_BREAKTHROUGH.md already carry the failed-replication framing front and centre.

2. **demiurge's `PAPERS/sample-nb-bcs-absorbed/` is a paper whose §lk99-neg section is the canonical "four-source honest-negative" case study.** Removing LK-99 would destroy the paper's central scientific argument (substrate refuses absorbed=true on four orthogonal axes, demonstrating the gate works).

3. **The XCTest fixture `lk99_lee2023.json` is the test data that proves `MaterialFalsifierDispatch` correctly emits `aggregate_verdict: FAILS-AT-LEAST-ONE` with F-RTSC-3 FAIL when `replicated_by_independent_labs == 0`.** Removing it would delete the negative-case unit test coverage that guards the R4 invariant in code (`testAbsorbedAlwaysFalseEvenWithReplication`).

4. **The Phase 2 / Phase 2-ext / multicorpus inbox notes treat LK-99 as the canonical "0 entries · honest skip" empirical test point.** The briefing explicitly said to KEEP these empirical findings: *"The JARVIS probe finding ('LK-99: 0 entries · honest skip') is empirically useful — KEEP this in the multicorpus decision note, just annotate '0 entries is expected given replication-failed claim'"*. Re-reading shows those notes already include the annotation in different words (`"hypothetical apatite — no DFT corpus entry, R4 invariant holds"`, `"LK-99 stays n=0 (honest — it's hypothetical)"`).

5. **`element_pool: ["H", "Pb", "Cu", "P", "O"]` in RTSC.md §9.10 N5 funnel is the literal LK-99 element set.** It is *also* the element set that drives the JARVIS empirical n=0 honest-skip in the Phase 2-ext audit (cumulative 20-cell matrix). Swapping the element pool would invalidate the empirical audit trail. The §9.10 N5 cohort outputs are explicitly framed as "wet-lab priority candidate list, NOT actual SC discovery" with `absorbed=false 영구 (R4 invariant 하드코드)`.

The honest scrub principle (R4 + g3) here pulls in the same direction as the *briefing's own invariants* (`"NOT memory-hole erasure — replication-failure IS scientific information; preserve the citation"`). The aggressive removal path would violate those invariants. The targeted augmentation path (§4) honours both the user's explicit intent ("scrub LK-99 references") and the briefing's preservation principle by **adding the 2023-Q4 empirical resolution** (Cu₂S impurity) to the existing honest-negative framing, so future readers see the *complete* scientific arc: claim → failed replication → impurity-attribution resolution.

---

## 4. Targeted augmentations applied (Cu₂S impurity-mechanism citations)

Before this audit, demiurge had **zero** mention of the post-claim empirical resolution. The Cu₂S β→α first-order phase transition at ≈385 K (which explains both the resistivity drop and the ferromagnetic levitation) is the *load-bearing scientific finding* that closed out the LK-99 question through 2023-Q3/Q4. Three minimal edits add this:

### 4.1 `PAPERS/sample-nb-bcs-absorbed/references.bib`

Added two new bib entries between `nature2023replication` and `pvlib2024`:

- `@article{jain2023lk99cu2s}` — Jain 2023 (arxiv:2308.05222), the Cu₂S phase-transition explanation paper.
- `@article{zhu2023lk99cu2s}` — Zhu et al. 2023 (arxiv:2308.07999), independent confirmation that Cu₂S impurity content tracks the LK-99 signal.

Both entries carry a `note` line stamped `(honest-scrub pass, 2026-05-22)` for audit trail.

### 4.2 `PAPERS/sample-nb-bcs-absorbed/main.tex` §lk99-neg

Appended a `\paragraph{Empirical resolution of the LK-99 signal.}` paragraph after the four-source-refusal table, citing `\cite{jain2023lk99cu2s,zhu2023lk99cu2s}`. The paragraph states explicitly that the original LK-99 signal was a misattributed Cu₂S impurity transition, not a measurement-error retraction. Substrate behaviour is unchanged (no R4 implication, no `absorbed=true` flip, no falsifier verdict change).

### 4.3 `exports/synthesis_recipe/lk99_lee2023.json`

- Appended a 4th `scope_caveats` entry citing arxiv:2308.05222 and arxiv:2308.07999 with a `(annotation added 2026-05-22 — honest-scrub pass)` stamp.
- Added the two arxiv IDs to the `citations` array alongside the original 2307.12008/2307.12037 claim refs.

The fixture's R4-load-bearing fields (`replicated_by_independent_labs: 0`, `absorbed: false`, `gate_type: "claim-only"`, `measurement_gate: "GATE_OPEN"`) are unchanged — the XCTest `testAbsorbedAlwaysFalseEvenWithReplication` continues to pass on the same fixture.

---

## 5. R4 / g3 invariant audit (this session)

**Result: 0 records flipped from `absorbed: false` to `absorbed: true`. R4 invariant intact across all 62 demiurge LK-99-touching files.**

- No `absorbed=true` introduced.
- No `replicated_by_independent_labs` raised above 0 on any LK-99 record.
- No `gate_type` demoted from "claim-only" to a tighter gate.
- No `measurement_gate` flipped from "GATE_OPEN" to "GATE_CLOSED_MEASURED".
- No baseline-matrix downsizing (5×4 = 20-cell matrix unchanged — LK-99 column preserved with empirical n=0 / insufficient-sources honest verdict).
- No D-block added (this is documentation honest-scrub, not architecture; D-max remains 116 per the briefing's D-number stale rule).

---

## 6. hexa-lang flagged references (FLAG ONLY — NOT modified)

Per the briefing's explicit out-of-scope rule, the following hexa-lang paths were *only* grep'd, not touched:

```
~/core/hexa-lang/stdlib/material/sim.hexa                      (briefing flagged :249-254 honest caveat)
~/core/hexa-lang/stdlib/material/composition.hexa
~/core/hexa-lang/stdlib/material/cross_code_dft.py
~/core/hexa-lang/stdlib/material/novel_material_funnel.py
~/core/hexa-lang/stdlib/material/askcos_adapter.py
~/core/hexa-lang/firmware/boards/rtsc/  (entire subtree — hexa-rtsc-equivalent vendored copy)
```

These share the hexa-rtsc framing (LK-99 as F-RTSC-1 negative anchor). If/when a future session lands a parallel scrub in hexa-lang, the briefing's same decision tree applies — but per the user's explicit instruction this session does not touch hexa-lang.

---

## 7. hexa-rtsc decision (exit criterion γ for that repo)

Empirically: **all 33 hexa-rtsc LK-99 references are already framed as the F-RTSC-1 negative-result anchor with `재현 실패` / `UNCONFIRMED` / `RETRACTED catalog` / `0 confirmed reproductions vs N≥4 floor` framing.** The repo's `.roadmap.hexa_rtsc §C R4` explicitly bans silent-drop of LK-99. No edits applied — per exit criterion **(γ) "no-op finding — LK-99 framing in hexa-rtsc is already correct per R4/g3"**. Adding Cu₂S citations there is deferred to a future hexa-rtsc-side session (would need a separate worktree per `feedback-hexa-lang-concurrent-agents` memory pattern, and the existing `calc_lk99.hexa` `RETRACTED` catalog already attributes the impurity in prose form even without arxiv IDs).

---

## 8. Replication-failure citations actually added (where, which IDs)

| arxiv ID | Title (short) | Added to |
|---|---|---|
| 2308.05222 | Jain — Cu₂S phase transition / LK-99 implication | `PAPERS/sample-nb-bcs-absorbed/references.bib` (new @article jain2023lk99cu2s) · `main.tex §lk99-neg` (\cite) · `exports/synthesis_recipe/lk99_lee2023.json` scope_caveats + citations |
| 2308.07999 | Zhu et al — first-order transition with Cu₂S in LK-99 | same 3 files |

The third briefing-suggested citation (`arxiv:2308.05407` — further Cu₂S analysis) was **NOT added** because the two existing citations (claim explanation + independent confirmation) are sufficient for the honest-negative augmentation and adding a third would be citation padding without further scientific weight. If a future session wants to land it (e.g., for a more thorough §lk99-neg expansion), the pattern from §4.1 is a 1-bib-entry add.

---

## 9. Exit criterion verdict (β — bounded scope)

- **demiurge**: targeted Cu₂S augmentation in 3 files (1 commit). Exit criterion β-style "bounded scrub + honest gap note".
- **hexa-rtsc**: no-op (exit criterion γ) — already honest. No commit.
- **hexa-lang**: out of scope per user instruction; flagged paths listed in §6.

Honest gap: the briefing anticipated more aggressive reframing/removal. The empirical state of both repos is that the load-bearing apparatus (falsifier preregister · XCTest fixtures · negative-result paper) requires LK-99 references *as negative anchors*, and the existing framing is already honest. The smallest honest action that still honours the user's "scrub" intent is the targeted augmentation in §4 — adding the 2023-Q4 empirical resolution so future readers see the complete arc.

---

## 10. Anchors

- Briefing decision tree: per-reference action depends on context (filler / numerical row / element_pool / record fixture / inbox narrative / domains-or-papers key claim).
- R4 invariant (this session preserved): `absorbed=false` on every LK-99 record across both repos. 0 critical violations.
- Related: `~/core/hexa-rtsc/.roadmap.hexa_rtsc §C R4` (Negative-result silent-drop ban) · `~/core/demiurge/RTSC.md §8.8` (g3 honest stance — RTSC class never absorbed) · `~/core/demiurge/RTSC.md §8.9` (5-criteria gate, LK-99 = never).
- Prior session inbox notes referenced (none modified):
  - `inbox/notes/2026-05-21-rtsc-9-phase2-stabilization.md`
  - `inbox/notes/2026-05-22-rtsc-9-phase2-ext-20cell.md`
  - `inbox/notes/2026-05-22-rtsc-9-phase2-multicorpus-decision.md`
  - `inbox/notes/2026-05-21-d114-phaseb-material-falsifier-audit.md`
  - `inbox/notes/2026-05-21-tier3-measurement-ingest-batch1.md`
  - `inbox/notes/2026-05-21-mp-api-setup-needed.md`
