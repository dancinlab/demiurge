# Release Notes — hexa-matter v1.0.0

**Release date**: 2026-05-09
**Status**: SPEC_FIRST · 16 verbs · 4/4 verify PASS · CLOSED (retroactively documented)
**Author**: 박민우 <nerve011235@gmail.com>
**Tag**: `v1.0.0` (initial release)

> These release notes are authored **retroactively** on 2026-05-13 as part
> of the Phase A architectural elevation. v1.0.0 originally shipped without
> a formal release-notes artifact; this document reconstructs the release
> contents from the git history and the surviving infra files.

---

## Summary

hexa-matter v1.0.0 is the **first ship** of the n=6 materials substrate as a standalone repo. Sixteen verbs were imported from the upstream `canon/domains/materials/` tree at SHA `47c70cbf` (2026-05-09) and wired into the standard sister-substrate aggregator pattern (`verify/run_all.hexa`, 4 scripts → all PASS).

This release is the materials member of the **HEXA family** alongside hexa-rtsc, hexa-ufo, hexa-cern, hexa-fusion, hexa-energy, hexa-chip, hexa-bio, etc. All sister repos share the same aggregator pattern, the same `hexa.toml` scoreboard discipline, and the same canon-import provenance convention.

---

## Verbs shipped (16)

Grouped by the 7-group taxonomy (see `AXIS.md`):

### GROUP_CER (ceramic / inorganic / silicate) — 4 verbs at v1.0.0

- `ceramics` → `ceramics/ceramics.md`
- `concrete` → `concrete/concrete.md`
- `concrete_tech` → `concrete_tech/concrete_tech.md`
- `glass` → `glass/glass.md`

*(silicon was NOT in v1.0.0; added in v1.1.0 — see `RELEASE_NOTES_v1.1.0.md`)*

### GROUP_POL (polymer) — 4 verbs at v1.0.0

- `aramid` → `aramid/aramid.md`
- `epoxy` → `epoxy/epoxy.md`
- `nylon` → `nylon/nylon.md`
- `pet_film` → `pet_film/pet_film.md`

*(microplastics + tire_cord arrived later: microplastics absorbed from hexa-medic 2026-05-12 commit `7bf9b61`; tire_cord part of canon import as a downstream verb)*

### GROUP_FIB (fiber + paper) — 2 verbs

- `fabric` → `fabric/fabric.md`
- `paper` → `paper/paper.md`

### GROUP_MET (metal) — 2 verbs

- `metallurgy` → `metallurgy/metallurgy.md`
- `lutherie` → `lutherie/lutherie.md`

### GROUP_GEM (gem / mineral) — 1 verb

- `gemology` → `gemology/gemology.md`

### GROUP_PRC (process) — 3 verbs

- `synthesis` → `synthesis/synthesis.md`
- `recycle_n6` → `recycle_n6/recycle_n6.md`
- `recycling` → `recycling/recycling.md`

### GROUP_FAS (fashion / textile) — 2 verbs

- `fashion-textile` → `fashion-textile/fashion-textile.md`
- `textile-dyeing` → `textile-dyeing/textile-dyeing.md`

### Plus `tire_cord` (downstream polymer-fiber product, counted under POL)

- `tire_cord` → `tire_cord/tire_cord.md`

**Verb count (v1.0.0)**: 16 spec-shipping verbs + tire_cord (downstream) — the scoreboard reports 16 at v1.0.0.

---

## Provenance — canon-import lineage

All 16 verbs at v1.0.0 are **extracted from canon**, not authored in-repo. Each verb's spec doc carries a `@canonical:` header:

```yaml
@canonical: canon/domains/materials/<verb>/<verb>.md @ 47c70cbf
```

The extraction was performed via the canon-minimization migration (per `IMPORTED_FROM_CANON.md`):

- Canon SHA: `47c70cbf` (snapshot date 2026-05-09)
- Migration commit: `3819abb feat: initial hexa-matter v1.0.0 — 16-verb 소재 substrate ⚛️`
- Followup imports:
  - `bae2426 feat(import): add 4 canon specs (MOVE migration)`
  - `fa27c0b feat(import): residue from canon@a86ca143 — 4 papers / 0 proofs / 2 origins tools`
  - `692257e feat(import): bt-1388 ionic-octahedral breakthrough — Wave 5`
  - `43a14dd docs: import 19 canon mk1 leaf docs as root UPPERCASE.md`

The root-level UPPERCASE.md files (`ARAMID.md`, `CERAMICS.md`, `CONCRETE.md`, `EPOXY.md`, `FASHION-TEXTILE.md`, `GEMOLOGY.md`, `HEXA-FABRIC.md`, `HEXA-GLASS.md`, `HEXA-RECYCLE.md`, `LUTHERIE.md`, `MATERIAL-SYNTHESIS.md`, `NYLON.md`, `PAPER.md`, `PET-FILM.md`, `RECYCLING.md`, `SWORDSMITHING.md`, `TEXTILE-DYEING.md`, `TIRE-CORD.md`, `CONCRETE-TECHNOLOGY.md`) are domain expansion docs in the hexa-bio style (long-form chapters that cross-link to the per-verb `<verb>/<verb>.md` chapter).

---

## Verify scoreboard — 4 scripts, all PASS

The `verify/run_all.hexa` aggregator runs 4 scripts and exits 0 iff all PASS:

| script                            | what it checks                                                                   |
| --------------------------------- | -------------------------------------------------------------------------------- |
| `verify/spec_presence.hexa`       | all 16 verb spec docs present at declared paths (at v1.0.0; 17 at v1.1.0)        |
| `verify/lattice_arithmetic.hexa`  | n=6 self-consistency (σ·φ = n·τ = 24) — *aux only* per `LATTICE_POLICY.md` §1.3  |
| `verify/real_limits_anchor.hexa`  | `LIMIT_BREAKTHROUGH.md` anchors (NIST WebBook · CRC Handbook · Hales · Frenkel)  |
| `verify/closure_consistency.hexa` | scoreboard cross-check (CLI · `hexa.toml` · README · `AGENTS.md`)                |

At v1.0.0 release date (2026-05-09), the scripts were not yet all green — `closure_consistency.hexa` was in development. The 4/4 PASS state was reached on **2026-05-13** with commit `91981d4 chore(closure): drive hexa-matter to 100% spec-first verify closure (4/4)`. v1.0.0 should therefore be understood as "16-verb spec import + work-in-progress verify aggregator" with 4/4 PASS achieved during the v1.0.0 → v1.1.0 transition.

---

## Verdict

```toml
[closure]
verbs_total = 16
groups_total = 7
verbs_wired = 0
verbs_spec = 16
verdict = "SPEC_FIRST"
extracted_from = "canon/domains/materials/ @ 47c70cbf"

[verify]
scripts_total = 4
scripts_passed = 4   # ← reached 2026-05-13, not 2026-05-09
verdict = "CLOSED"
```

The `verdict = "SPEC_FIRST"` is honest: 16/16 verbs ship as peer-citable markdown specs, with the `.hexa` CLI as a spec-headline dispatcher. No wired numerical sandbox at v1.0.0.

---


Per `hexa.toml [scope].honest_scope`:

> "17-verb 통합 substrate (7 그룹). spec-first markdown only at v1.0.0 — 작동 .hexa CLI는 spec headline dispatcher."

Per `[scope].not_scope`:
- semiconductor device + fab process → `hexa-chip` (NOT this repo at v1.0.0)
- lutherie / instrument-craft → culture domain (kept here at v1.0.0 with the understanding it may move)
- fashion-textile / textile-dyeing → industrial-textile, possibly its own bundle in future
- in-situ pilot batch validation → out of scope (Phase C+)

---

## Install & Run (v1.0.0)

```bash
# Install
hx install hexa-matter

# Run
hexa-matter ceramics            # ceramics spec doc
hexa-matter concrete            # concrete spec doc
hexa-matter glass               # hexa-glass spec doc
hexa-matter aramid              # aramid spec doc
hexa-matter epoxy               # epoxy spec doc
# ... (16 verb dispatchers + status + selftest + version + help)
```

---

## Cross-link policy (v1.0.0)

Per `hexa.toml [crosslink]`:

- `chip` → `dancinlab/hexa-chip` (semiconductor *device + fab process*; `silicon` material aspect joined hexa-matter in v1.1.0)

At v1.0.0, the implicit boundary was "silicon = chip territory entirely." This was later revised in v1.1.0 (silicon material layer joins hexa-matter; device + fab process stays in hexa-chip).

---

## Known gaps at v1.0.0

1. **Silicon missing** — the elemental Si + SiO₂/SiC/SiN material chapter was not yet authored. Surfaced by Wave M LIMIT_BREAKTHROUGH audit and closed in v1.1.0.
2. **LATTICE_POLICY not yet adopted** — Wave K policy deployment happened 2026-05-12 (commit `042232f docs(policy): adopt LATTICE_POLICY.md`). At v1.0.0 release date the policy was not yet repo-canonical.
3. **LIMIT_BREAKTHROUGH.md not yet authored** — Wave M audit happened 2026-05-12 (commit `3d2421a docs(limits): LIMIT_BREAKTHROUGH.md`).
4. **Microplastics not yet absorbed** — absorbed from hexa-medic 2026-05-12 (commit `7bf9b61`).
5. **Phase A infrastructure docs not yet authored** — AXIS.md, AXIS_CLOSURE_PLAN.md, CLOSURE_RESIDUAL_BACKLOG.md, DECOMPOSITION_PLAN.md, LESSONS.md, V1_2_0_HANDOFF.md, USER_ACTION_REQUIRED.md authored 2026-05-13 (this Phase A elevation).

---

## Commit graph

```
3819abb feat: initial hexa-matter v1.0.0 — 16-verb 소재 substrate ⚛️
bae2426 feat(import): add 4 canon specs (MOVE migration)
fa27c0b feat(import): residue from canon@a86ca143 — 4 papers / 0 proofs / 2 origins tools
692257e feat(import): bt-1388 ionic-octahedral breakthrough — Wave 5
43a14dd docs: import 19 canon mk1 leaf docs as root UPPERCASE.md
44bc625 docs: add Zenodo DOI badge + CITATION.cff identifiers
```

---

## Acknowledgments

- canon authors at `canon@47c70cbf` for the 16-verb materials catalog
- hexa-rtsc / hexa-ufo / hexa-cern / hexa-fusion / hexa-energy for the aggregator pattern that hexa-matter adopted

---

*Release notes retroactively authored 2026-05-13 by 박민우 <nerve011235@gmail.com>. The v1.0.0 release itself shipped 2026-05-09 without an explicit release-notes file; this document reconstructs the release contents for the v1.x release-notes archive.*
