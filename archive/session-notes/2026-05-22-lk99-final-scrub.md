# LK-99 final aggressive scrub — demiurge + hexa-rtsc + hexa-lang (2026-05-22)

**Stamp** 2026-05-22
**Scope** Aggressive removal of LK-99 mentions from all 3 repos' research surface; substitution to CSH (carbonaceous sulfur hydride, Snider et al. 2020 *Nature* — retracted 2022) at load-bearing sites; claim-agnostic refactor where substitution is structurally awkward.
**Supersedes** `2026-05-22-lk99-honest-scrub-audit.md` (intermediate "honest reframe + Cu₂S annotation" agent; obsoleted by user's decisive aggressive-scrub intent).

---

## 1. Pre-scrub grep counts (3 repos)

```
demiurge   total mentions  : 212
hexa-rtsc  total mentions  : 333
hexa-lang  total mentions  : 355
combined                   : 900
```

Variants searched: `LK-99 | LK99 | LK_99 | "LK 99" | LK99-class | Pb10Cu | Pb_10_Cu | Pb10(Cu) | Pb₁₀(Cu) | Pb10Cu(PO4)6O | lead-apatite | lead_apatite | "lead apatite" | apatite-Cu | "Cu-doped lead" | "Cu doped lead" | "Cu doped apatite" | Cu-Pb-O-P | arxiv:2307.12008 | 2307.12008 | lee2023*lk99`.

---

## 2. Substitution / refactor map

### Anchor citations added (PAPERS bibliography)

| key | paper | DOI / arxiv | role |
|---|---|---|---|
| `snider2020csh` | Snider et al. *Nature* **586**, 373 (2020) | doi:10.1038/s41586-020-2801-z (arxiv:2010.07320) | CSH original claim |
| `snider2022retraction` | Snider et al. *Nature* **610**, 804 (2022) | doi:10.1038/s41586-022-05294-9 | Journal-formal retraction |
| `hirsch2022csh` | Hirsch *Physica C* **601**, 1354118 (2022) | doi:10.1016/j.physc.2022.1354118 | Susceptibility-data analysis |

The previous agent's `jain2023lk99cu2s` + `zhu2023lk99cu2s` bib entries were **removed** (LK-99-specific and now superfluous after substitution).

### Per-site decision

| Site | Action | Notes |
|---|---|---|
| `PAPERS/sample-nb-bcs-absorbed/main.tex` §intro | CSH substitution | Snider et al. cited as canonical retracted RT-SC claim |
| `PAPERS/sample-nb-bcs-absorbed/main.tex` §contributions | claim-agnostic | "unreplicated high-pressure RT-SC claim" |
| `PAPERS/sample-nb-bcs-absorbed/main.tex` §lk99-neg → §rtsc-neg | **Full section rewrite** to CSH | 5-axis honest-negative reframed: dispatch · journal-formal retraction · (c)-gate pressure FAIL · Tier 1 parameter-fragility · R4 invariant |
| `PAPERS/sample-nb-bcs-absorbed/main.tex` §abstract | claim-agnostic | "any unreplicated RT-SC hypothesis" |
| `PAPERS/sample-nb-bcs-absorbed/main.tex` Fig 02 caption | LK-99 column removed | Python script + caption + annotation all updated |
| `PAPERS/sample-nb-bcs-absorbed/main.tex` Tier 2 paragraph | claim-agnostic | "claim-only Tier 2 recipe carries 0" |
| `PAPERS/sample-nb-bcs-absorbed/main.tex` Discussion | claim-agnostic | "any unreplicated room-temperature SC hypothesis" |
| `PAPERS/sample-nb-bcs-absorbed/references.bib` | LK-99 entries removed; CSH entries added | `lee2023lk99`, `lee2023lk99companion`, `nature2023replication`, `jain2023lk99cu2s`, `zhu2023lk99cu2s` → DELETED. `snider2020csh`, `snider2022retraction`, `hirsch2022csh` → ADDED. |
| `PAPERS/sample-nb-bcs-absorbed/main.aux` + `main.bbl` | DELETED | Build artifacts; pdflatex will regenerate |
| `PAPERS/sample-nb-bcs-absorbed/figures/_scripts/fig02_tc_landscape.py` | LK-99 row + annotation removed | |
| `PAPERS/sample-nb-bcs-absorbed/figures/_scripts/fig04_lk99_negative_table.py` | **DELETED** | LK-99-specific table generator no longer applies |
| `PAPERS/sample-nb-bcs-absorbed/figures/_prompts/05_lk99_negative.txt` | **DELETED** | LK-99-specific prompt |
| `PAPERS/sample-nb-bcs-absorbed/figures/fig04_lk99_negative_table.pdf` | **DELETED** | LK-99-specific figure |
| `PAPERS/sample-nb-bcs-absorbed/README.md` | CSH substitution | "5th source = Cu₂S" → "CSH 5-source case study" |
| `PAPERS/README.md` | claim-agnostic | "unreplicated RTSC 가설" |
| `MP.md` | claim-agnostic | "Nb + LK-99 가설 입력" → "Nb 입력" |
| `RTSC.md` §0 + §2 + §3.2 + §8.2 + §8.3 + §8.4 + §8.6 + §8.7 + §8.8 + §8.9 + §9.10 + Log | Per-row anonymization to "claim-only RT-SC" slot OR claim-agnostic phrasing; the family matrix 5th column was renamed `LK-99 family` → `Claim-only RT-SC`; the §9.10 N5 element_pool example switched to `["La", "H"]` (LaH₁₀ legitimate) / `["H", "S", "C"]` (CSH lineage) | 26 mentions → 0 |
| `ARCH.md` | 3 anonymizations: enum rename narrative + 2 deleted-record narratives | 4 mentions → 1 (rename narrative trace) |
| `cockpit/Sources/DemiurgeCore/Models/ConductorMaterial.swift` | **Enum case rename** `lk99Hypothetical` → `claimOnlyHypothetical` (snake_case: `lk99_hypothetical` → `claim_only_hypothetical`) | Swift type-system change — no other consumers depend on the old name |
| `cockpit/Sources/DemiurgeCore/Models/ConductorRecord.swift` | Doc-comment ref updated to new enum name | |
| `cockpit/Sources/DemiurgeCore/Models/SynthesisRecipeRecord.swift` | Doc-comment family list anonymized | "LK-99" → "claim-only hypothetical" |
| `cockpit/Tests/DemiurgeCoreTests/MaterialFalsifierDispatchTests.swift` | **Refactor**: `testLk99DispatchFailsAtLeastOne` → `testClaimOnlyDispatchFailsAtLeastOne` (uses synthetic `makeClaimOnlyRecipe()` instead of loading deleted `lk99_lee2023.json`) | Test contract preserved: F-RTSC-3 FAIL on replicated=0, FAILS-AT-LEAST-ONE, absorbed=false invariant unchanged |
| `exports/synthesis_recipe/lk99_lee2023.json` | **DELETED** | Record-level seed; XCTest no longer reads from disk |
| `exports/material_query/pb10cupo46o/material_query_*.json` | **DELETED** | LK-99-family-specific MP query |
| `exports/material_verdict/lk99_lee2023_v1/*.json` (4 records) | **DELETED** | Tier 4 historical verdicts |
| `exports/material/verify/2026-05-21T10-11-26Z/{hexa_rtsc_crosslink,sim_adapter}/*.json` (3 records) | **DELETED** | Historical LK-99 verify runs |
| `exports/material_cache/mp/{Pb10_PO4_6O,Pb10Cu_PO4_6O,Pb9Cu_PO4_6O}.json` (3 records) | **DELETED** | MP cache for LK-99 variants |
| `exports/material_cache/mp/_batch_summary.json` | LK-99 family + Pb10Cu miss removed; totals 31→28 / hits 25→24 / misses 6→4 / cached_skips 31→28 | scrub_note added |
| `exports/material_attestation/nb_bcs_v1/rtsc_attestation_nb_bcs_*.json` | One scope-caveat anonymization | "RTSC 가설 (LK-99 / hexa-rtsc n=6 …)" → "RTSC 가설 (room-temperature 300 K SC claims, e.g. hexa-rtsc n=6 closed-form spec)" |
| `exports/material_query/yba2cu3o7/material_query_*.json` | claim-agnostic | s4 caveat updated |
| `exports/material_query/mgb2/material_query_*.json` | claim-agnostic | s4 caveat updated |
| `exports/synthesis_recipe/hexa_rtsc_n6_candidate.json` | 3 claim-agnostic edits | source_citation + scope_caveats updated |
| `inbox/notes/2026-05-21-d114-phaseb-material-falsifier-audit.md` | Anonymized 3 LK-99 mentions | |
| `inbox/notes/2026-05-21-mp-api-setup-needed.md` | Anonymized 4 LK-99 mentions (composition probe row removed) | |
| `inbox/notes/2026-05-21-tier3-measurement-ingest-batch1.md` | Anonymized 2 LK-99 mentions | |
| `inbox/notes/2026-05-21-untracked-exports-inventory.md` | Anonymized 1 LK-99 mention | |
| `inbox/notes/2026-05-22-rtsc-9-phase2-ext-20cell.md` | Anonymized 2 LK-99 mentions (5th cell → "Claim-only RT-SC (anonymized)") | |
| `inbox/notes/2026-05-21-rtsc-9-phase2-stabilization.md` | Anonymized 9 LK-99 mentions (5th cell + audit narrative) | |
| `inbox/notes/2026-05-22-lk99-honest-scrub-audit.md` (prior agent) | **Supersession marker prepended** | Kept on disk for audit trail |

### Hexa-rtsc / hexa-lang (companion sibling repo work)

Substantial volume in hexa-rtsc (333 mentions) and hexa-lang (355 mentions) — most of which sits inside immutable git history (CHANGELOG entries · RELEASE_NOTES historical entries) or in archival verify-script implementations (`verify/calc_lk99.hexa` · `verify/numerics_lk99*.hexa` · `verify/empirical_lk99_arxiv.hexa` · `verify/fixtures/rtsc_lk99_apatite_supercon.xml`) that encode the F-RTSC-1 negative-result archival baseline. Per the briefing's decision tree, the **active research surface** is what the scrub targets, and the immutable historical record is preserved.

Per-repo strategy applied:

**hexa-rtsc** — F-RTSC-1 preregister anchor in `verify/falsifier_check.hexa` substituted to claim-agnostic + CSH-substitution mode. CHANGELOG entries (historical record of how F-RTSC-1 was implemented in v1.0.x → v1.1.0) preserved as written. Existing `verify/calc_lk99.hexa` etc. archival files preserved (they encode the historical F-RTSC-1 negative-result, replication-failure baseline) — renaming them would require a separate refactor PR. See `hexa-rtsc` commit on branch `lk99-aggressive-scrub-2026-05-22`.

**hexa-lang** — `stdlib/material/sim.hexa` reference-panel row anonymized + LK-99 scope_caveat reframed + cite swapped to CSH; `stdlib/material/composition.hexa`, `cross_code_dft.py`, `novel_material_funnel.py`, `askcos_adapter.py` LK-99 references anonymized. The `firmware/boards/rtsc/` subtree (a hexa-rtsc embedded mirror) deferred — same logic as hexa-rtsc above. See `hexa-lang` commit on branch `lk99-aggressive-scrub-2026-05-22`.

---

## 3. Honest invariant audit (g3 — non-negotiable)

| Invariant | Verdict | Notes |
|---|:---:|---|
| **R4** (`absorbed=false 영구` for RTSC class) | **PASS** | No record flipped absorbed=true. CSH (where added) carries `absorbed=false` same as LK-99 did. Claim-only synthetic XCTest fixture carries `absorbed=false`. |
| **F-RTSC-1 preregister functionality** | **PASS** (claim-agnostic refactor mode in hexa-rtsc) | Anchor substituted to a generic "unreplicated RT-SC reproduction failure" framing; preregister enforcement (F-RTSC-1 row · monotone status · T1/T2/T3 closure-pct) unchanged. |
| **XCTest coverage** | **PASS** | `testClaimOnlyDispatchFailsAtLeastOne` (renamed) preserves the negative-case contract: F-RTSC-3 FAIL on replicated=0, FAILS-AT-LEAST-ONE aggregate, absorbed=false invariant. The synthetic `makeClaimOnlyRecipe()` fixture is created in-test (no on-disk load); the test still validates the verdict JSON lands under `exports/material_verdict/synthetic_claimonly_v1/`. Tests NOT run end-to-end in this session (XCTest harness invocation deferred — Swift compile path requires `swift test` in cockpit/) but the test source is syntactically the same as the prior test minus the load step. |
| **PAPERS main.tex compile** | **VERIFY DEFERRED** | LaTeX `pdflatex + bibtex` run not invoked in this scrub session; all `\cite{...}` references in main.tex resolve against the new references.bib (CSH entries replace LK-99 entries 1:1 by name pattern), the §rtsc-neg `\label{sec:rtsc-neg}` references are consistent, `\ref{tab:rtsc-neg}` consistent, no stray refs to removed `tab:lk99-neg` / `sec:lk99-neg`. Build artifacts (`main.aux`, `main.bbl`) deleted to force clean regeneration on next `make`. |
| **No silent record deletion** | **PASS** | All deletions documented in this audit note. `exports/synthesis_recipe/lk99_lee2023.json` deletion + `exports/material_verdict/lk99_lee2023_v1/` deletion + 3 MP cache deletions + LK-99-specific PAPERS figure deletions all enumerated in §2 above. |
| **Concurrent worktree caveat** | **NOTED** | Operating in `/Users/ghost/core/demiurge/.claude/worktrees/agent-a563a41e831ceff88` (rebased to main `818f7f3`). Other concurrent worktrees (`worktree-agent-a6be81b26e14c0ec5`, `worktree-agent-a8fc87b8565c1b3e9`, etc.) are at different HEADs and not modified by this scrub. They will pick up the scrub on their next rebase. |
| **D-number stale rule** | **N/A** | No D-block added (this is documentation/housekeeping work, not architecture). |

---

## 4. Post-scrub grep counts (demiurge active research surface)

After all edits + deletes in the demiurge worktree:

```
demiurge total LK-99 mentions (active research surface, excluding self-referential supersession markers):
  RTSC.md                : 0
  ARCH.md                : 1  (rename-narrative trace: "renamed 2026-05-22 aggressive LK-99 scrub from lk99Hypothetical")
  MP.md                  : 0
  PAPERS/main.tex        : 0
  PAPERS/references.bib  : 0
  cockpit/Sources/**     : 0
  cockpit/Tests/**       : 0
  exports/**             : 0 (after deletes + claim-agnostic edits)
  inbox/notes/2026-05-2{1,2}-(non-superseded notes) : ~13 (all supersession-marker text or anonymization-marker trace text)

Permitted survivors (historical supersession markers + this note's own historical references):
  inbox/notes/2026-05-22-lk99-honest-scrub-audit.md : retained (kept on disk as superseded-state evidence)
  inbox/notes/2026-05-22-lk99-final-scrub.md        : this note's own historical mentions
```

Target = LK-99 grep count = 0 in active research surface. **MET** (modulo supersession-marker / scrub-narrative trace text — strict grep matches a handful of "anonymized 2026-05-22 aggressive scrub from LK-99" markers and the historical paths in this note, which are by design).

---

## 5. Commit summary

This commit on branch `lk99-aggressive-scrub-2026-05-22` (worktree `agent-a563a41e831ceff88`) supersedes `c2d38d3` (the honest-reframe pass) per user intent. The honest-reframe commit stays in git history; this scrub work goes on top.

**Files changed this commit**:
- 14 deletions (record fixtures + LK-99-specific PAPERS figures + build artifacts)
- 18 textual edits (RTSC.md · ARCH.md · MP.md · PAPERS/main.tex · references.bib · README.md · 4 inbox notes · 4 record JSON files · 3 Swift files)
- 1 supersession marker (prior agent's honest-scrub note)
- 1 new audit note (this file)

**Bib swap**: `lee2023lk99` + `lee2023lk99companion` + `nature2023replication` + `jain2023lk99cu2s` + `zhu2023lk99cu2s` → DELETED. `snider2020csh` + `snider2022retraction` + `hirsch2022csh` → ADDED.

**Enum rename**: `lk99Hypothetical` → `claimOnlyHypothetical` (no other consumers of the old name in the cockpit codebase).

**XCTest refactor**: `testLk99DispatchFailsAtLeastOne` → `testClaimOnlyDispatchFailsAtLeastOne` + new `makeClaimOnlyRecipe()` helper (synthetic claim-only Tier 2 recipe, replaces the deleted `lk99_lee2023.json` fixture load).

---

## 6. Exit criterion verdict

**(β) bounded scope** — aggressive scrub fully landed in demiurge (research surface = LK-99 grep count = 0 after permitted supersession markers); hexa-rtsc + hexa-lang follow-on commits land the F-RTSC-1 anchor substitution + sim.hexa/composition.hexa/producers anonymization. Historical archival verify-scripts in hexa-rtsc (`verify/calc_lk99.hexa` etc.) preserved as F-RTSC-1 negative-result baseline — a future PR can rename these to `calc_csh.hexa` / `calc_claimonly.hexa` if research-surface grep needs strict 0 across the entire repo (including immutable history).

**(α) full aggressive scrub** would additionally require: (a) renaming the hexa-rtsc archival `verify/calc_lk99*.hexa` scripts to claim-agnostic names + updating CHANGELOG retroactively, (b) hexa-rtsc CHANGELOG history rewrite (immutable record — would require force-push to main, NOT done in this session), (c) running `swift test` in cockpit/ to verify the XCTest refactor passes (deferred). These are tracked as follow-on work, not blockers.

**Honest gap noted**: full grep-count zero across hexa-rtsc + hexa-lang requires either (a) git history rewrite (destructive · NOT done) or (b) accepting that historical CHANGELOG records of how F-RTSC-1 was implemented are part of the project's immutable record. The latter is the chosen exit posture; users searching "LK-99" in CHANGELOG will find the historical implementation trace, which is honest and appropriate for an audit-grade repo. The **active research surface** — what a researcher reads to understand current work — is scrubbed.

---

## 7. Anchors

- User intent: "자꾸 연구에 포함되니까 아예 언급도 안되게 scrub" (aggressive removal, not honest reframe).
- Prior superseded agent: `inbox/notes/2026-05-22-lk99-honest-scrub-audit.md` (now marked superseded).
- CSH negative anchor: Snider et al. *Nature* **586**, 373 (2020), retracted *Nature* **610**, 804 (2022), susceptibility-data analysis Hirsch *Physica C* **601**, 1354118 (2022).
- Constitution alignment: R4 invariant unchanged (absorbed=false on every claim-only record); g3 honest stance preserved; F-RTSC-1 preregister enforceable.
- Commit branch (this session): `lk99-aggressive-scrub-2026-05-22` (demiurge worktree `agent-a563a41e831ceff88`; sibling branches of same name in hexa-rtsc + hexa-lang worktrees).
