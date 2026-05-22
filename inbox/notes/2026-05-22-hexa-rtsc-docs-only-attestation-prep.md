# hexa-rtsc docs-only attestation PREP — D116 Phase C rtsc closure

> **Status**: PREP / research artifact only. **No deletion performed.** Attestation execution (git rm of migrated substrate from hexa-rtsc) = a **separate cycle** (see § 5). This note inventories what's safe to delete vs keep so the attestation PR can be drafted mechanically.

## § 0. Purpose

D116 doctrine: sibling repos (`~/core/hexa-rtsc/` · `hexa-matter/` · `hexa-bio/` · `hexa-chem/`) = **docs only**. All substrate code SSOT = `~/core/hexa-lang/stdlib/<domain>/`. This note readies the hexa-rtsc → docs-only attestation now that the rtsc substrate migration has largely landed via PR #281 (verify/ 4) + PR #285 (verify-additional/ 29) + PR #286 (falsifier_dispatch) + a prior cli/firmware/origins/rtsc-tabletop migration. Companion consolidation PR #293 folds verify-additional/ → verify/ on the hexa-lang side.

Read-only audit of `~/core/hexa-rtsc/` (126 tracked files excl. `build/` · 57 tracked `.hexa` · 27 md). No code change in hexa-rtsc. No commit to hexa-rtsc.

---

## § 1. Migrated substrate inventory (now in `hexa-lang/stdlib/rtsc/`)

`hexa-lang` origin/main `stdlib/rtsc/` holds **42 `.hexa`** (33 verify + 4 firmware/sim + 1 cli + 2 origins/sc-dse + 1 rtsc/tabletop + 1 falsifier_dispatch). Post-#293 the 29 `verify-additional/` files fold into `verify/` → single canonical `verify/` of 33.

| source path (hexa-rtsc) | hexa-lang dest | PR | files | LOC | status |
|---|---|---|---|---|---|
| `verify/{calc_bcs,calc_hc2_48t,calc_mcmillan,falsifier_check}.hexa` | `stdlib/rtsc/verify/` | #281 | 4 | — | MERGED |
| `verify/` (remaining 29: calc_csh · cross_doc_audit · empirical_*×6 · lattice_check · lint_numerics · numerics_*×16 · run_all · saturation_check) | `stdlib/rtsc/verify-additional/` → `verify/` (#293) | #285 | 29 | — | MERGED (#293 consolidates) |
| `verify/` total | `stdlib/rtsc/verify/` | #281+#285+#293 | **33** | 9,322 | migrated |
| `firmware/sim/{synthesis_ctrl,quench_logic,calorimetry_ctrl,squid_daq}.hexa` | `stdlib/rtsc/firmware/sim/` | (prior) | 4 | — | migrated |
| `cli/hexa-rtsc.hexa` | `stdlib/rtsc/cli/` | (prior) | 1 | — | migrated |
| `origins/sc-dse/{cross_fusion,main}.hexa` | `stdlib/rtsc/origins/sc-dse/` | (prior) | 2 | — | migrated |
| `rtsc/tabletop-fusion-verify.hexa` | `stdlib/rtsc/rtsc/` | (prior) | 1 | — | migrated |
| *(new, no hexa-rtsc source)* `falsifier_dispatch.hexa` | `stdlib/rtsc/` | #286 | 1 | — | cockpit-migrated (D116) |

**Migration completeness: 41 of 57 hexa-rtsc source `.hexa` migrated.** 16 stragglers remain (see § 2). `falsifier_dispatch.hexa` was born directly in hexa-lang from the cockpit `MaterialFalsifierDispatch.swift` migration (D116) — it has no hexa-rtsc source counterpart.

---

## § 2. hexa-rtsc source side — DELETE (duplicated substrate) vs KEEP (genuine docs)

### 2a. SAFE TO DELETE (now-duplicated substrate · SSOT lives in hexa-lang)

| path | files | note |
|---|---|---|
| `verify/*.hexa` | 33 | byte-for-byte migrated → `stdlib/rtsc/verify/` (#281+#285+#293). DELETE. |
| `firmware/sim/*.hexa` | 4 | migrated → `stdlib/rtsc/firmware/sim/`. DELETE. |
| `cli/hexa-rtsc.hexa` | 1 | migrated → `stdlib/rtsc/cli/`. DELETE. |
| `origins/sc-dse/*.hexa` | 2 | migrated → `stdlib/rtsc/origins/sc-dse/`. DELETE. |
| `rtsc/tabletop-fusion-verify.hexa` | 1 | migrated → `stdlib/rtsc/rtsc/`. DELETE. |
| **subtotal migrated substrate** | **41** | confirmed in hexa-lang origin/main. |

### 2b. STRAGGLERS — substrate NOT yet migrated (block full attestation until ported)

| path | files | LOC | note |
|---|---|---|---|
| `install.hexa` | 1 | — | repo installer — may be repo-local tooling, not domain substrate; classify before delete. |
| `rtsc/{agi-architecture,helium-free-mri,lossless-power-grid,rt-ev-motor,rt-maglev-transport,rt-quantum-computer,rt-smes,space-colonization,superconducting-cpu}-verify.hexa` | 9 | — | **application-tier verifiers** — only `tabletop-fusion-verify.hexa` (1 of 10) migrated. The other 9 are NOT in hexa-lang. **Migrate before attestation** (else docs-only claim is false). |
| `tests/{test_calculators,test_falsifier,test_lattice,test_saturation,test_selftest,test_verify}.hexa` | 6 | — | port-internal selftests — migrate alongside their targets (likely → `stdlib/rtsc/tests/` or fold into selftest). |
| **subtotal stragglers** | **16** | 548 | **must migrate before hexa-rtsc reaches `.hexa`-count ≈ 0.** |

### 2c. ADDITIONAL non-`.hexa` substrate (out of verify/ migration scope — flag for classification)

| path | files | LOC | note |
|---|---|---|---|
| `firmware/hdl/*.v` | 3 | — | Verilog quench_detect / calorimetry_daq / testbench — Stage-D HDL skeletons referenced by sim/. Substrate-shaped; decide hexa-lang dest vs keep-as-reference-artifact. |
| `firmware/mcu/*.rs` + `Cargo.toml` | 4 | — | Rust MCU drivers (chamber/calorimetry/lib) — Stage-D firmware. Substrate-shaped. |
| `firmware/eda/build_kicad.py` | 1 | — | Python EDA build script. Substrate-shaped. |
| **subtotal non-hexa substrate** | **8** | 1,545 | NOT covered by the verify/ migration. Attestation must decide: port to hexa-lang firmware tree OR explicitly carve out as physical-firmware-reference artifacts. |

### 2d. KEEP (genuine docs · D116 compliant · stays in hexa-rtsc)

`breakthroughs/` (1) · `doc/` (4) · `docs/` (2) · `papers/` (2) · `memory/` (1) · `sc/superconductor.md` (the cited source doc for calc_*.hexa) · `verify/fixtures/*.xml` (6 — empirical validation data, NOT code) · `README.md` · `README.ai.md` · `CHANGELOG.md` · `CITATION.cff` · `LICENSE` · `LATTICE_POLICY.md` · `LIMIT_BREAKTHROUGH.md` · `TAPE-AUDIT.md` · `RELEASE_NOTES_v1.{0,1}.0.md` · `IMPORTED_FROM_CANON.{md,tape}` · `AGENTS.tape` · `CLAUDE.md` · `hexa.toml` · `state/` (logs/markers — runtime artifact, likely gitignore-worthy).

---

## § 3. Attestation checklist (hexa-rtsc = docs-only verification)

1. **Migrate § 2b stragglers** (9 application verifiers + 6 tests + classify install.hexa) → hexa-lang. Until done, `find . -name '*.hexa'` ≠ 0.
2. **Resolve § 2c** non-hexa substrate (firmware HDL/MCU/EDA) — port or formally carve out as physical-reference.
3. `git rm` § 2a migrated substrate (41 `.hexa`) + migrated stragglers.
4. **Post-cleanup gate**: `cd ~/core/hexa-rtsc && find . -name '*.hexa' -not -path './build/*' | wc -l` → should be **0** (or ≈0 with documented carve-outs).
5. `find . \( -name '*.py' -o -name '*.rs' -o -name '*.v' \) -not -path './build/*'` → 0 or documented firmware carve-out only.
6. Add docs-only attestation marker (e.g. `DOCS_ONLY.md` or a `@D` row in `AGENTS.tape` per D116) declaring substrate SSOT = `hexa-lang/stdlib/rtsc/`.
7. Sanity: every deleted file's content matches its hexa-lang counterpart (diff before rm).

---

## § 4. Risk — downstream consumers importing hexa-rtsc paths

**hexa-lang side**: `git grep "hexa-rtsc"` on origin/main → only doc/spec narrative (SPEC.md, SPEC.yaml, LATTICE_POLICY.md, compiler/main.hexa comment, dist/atlas.hxc data rows). **No runtime `.hexa` `use`/`import` of a `hexa-rtsc/` path.** `git grep "verify-additional"` → 0 internal refs (consolidation #293 safe). Substrate `.hexa` files use `use "stdlib/..."` and `use "self/runtime/..."` (runtime imports), and `run_all.hexa` references sibling scripts via CWD-relative `verify/...` / `firmware/sim/...` paths — all self-contained within `stdlib/rtsc/`. **No cross-repo path import risk.**

**demiurge side**: `git grep "hexa-rtsc/"` → all hits are design-doc narrative + one source comment:
- `ARCH.md`, `design.md`, `RTSC.md` — narrative / migration-plan prose (will need a post-attestation prose update noting substrate is now hexa-lang-only).
- `cockpit/Sources/DemiurgeCore/Models/MaterialVerdictRecord.swift:9` — **comment only** (`// hexa-rtsc/verify/{calc_*,falsifier_check}.hexa.`), no code dependency. Update comment to `hexa-lang/stdlib/rtsc/verify/` during attestation.
- `domains/INDEX.demi:59` `substrate_ssot = "~/core/hexa-rtsc/"` and `domains/SUBSTRATE_LINKS.demi:48` `sibling_path = "~/core/hexa-rtsc/"` — **pointer manifests** that should be re-pointed to `hexa-lang/stdlib/rtsc/` (or annotated docs-only) in the attestation cycle.
- `inbox/notes/2026-05-21-d114-phaseb-material-falsifier-audit.md` — superseded audit note (its hexa-rtsc destination recommendation was already corrected to hexa-lang by D116; informational only).

**No executable downstream consumer imports from hexa-rtsc paths.** Risk = stale prose/pointers only, addressed in § 5.

---

## § 5. Recommended attestation cycle (separate PR)

1. **Pre-req PR (hexa-lang)**: migrate the 16 § 2b stragglers (9 app verifiers + 6 tests + install) and resolve § 2c firmware substrate. Land before any hexa-rtsc deletion.
2. **Attestation PR (hexa-rtsc)** — separate cycle, NOT this one:
   - `git rm` § 2a (41 migrated `.hexa`) + newly-migrated stragglers (diff-verify each against hexa-lang counterpart first).
   - Decide firmware (§ 2c): port to `stdlib/rtsc/firmware/{hdl,mcu,eda}/` OR keep with an explicit `FIRMWARE_REFERENCE.md` carve-out note.
   - Add docs-only attestation marker + `find . -name '*.hexa'` ≈ 0 gate evidence in PR body.
3. **Pointer-update PR (demiurge)**: re-point `domains/INDEX.demi` + `domains/SUBSTRATE_LINKS.demi` to hexa-lang; fix the `MaterialVerdictRecord.swift:9` comment; reconcile ARCH.md/design.md/RTSC.md prose.
4. Sequence: migrate stragglers → attest (rm) → re-point pointers. Do **not** rm before stragglers land (would orphan the 9 app verifiers + 6 tests).

---

### Appendix — counts at a glance
- hexa-rtsc tracked files (excl `build/`): **126** · `.hexa`: **57** · md docs: **27**
- migrated substrate: **41 `.hexa`** (9,322 LOC verify/ alone) → hexa-lang
- stragglers (block attestation): **16 `.hexa`** (548 LOC) + **8 non-hexa** (1,545 LOC firmware)
- consolidation (#293): 29 verify-additional → verify, 0 name collisions, falsifier selftest 5/5 PASS
