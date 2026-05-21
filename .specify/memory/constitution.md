<!--
Sync Impact Report — Constitution amendment 1.3.0 → 1.4.0 (MINOR)
- Date: 2026-05-21
- Bump type: MINOR (new R-row: R4 RTSC absorbed=true twin-error invariant)
- Modified principles: none (Core Principles I-VI unchanged)
- Added sections: R4 (RTSC absorbed=true twin-error invariant) in Governance Rows
- Removed sections: none
- Templates requiring updates:
  - ⚠ pending: .specify/templates/plan-template.md — Constitution Check 시 RTSC absorbed=true claim 발생하면 R4 5-gate 검증 의무 명시
  - ⚠ pending: .specify/templates/spec-template.md — scope 에 SC material absorbed=true 가 포함되면 RTSC.md §8.9 5-gate cross-reference 의무
  - ⚠ pending: .specify/templates/tasks-template.md — RTSC material attestation task 에 "5-gate evaluation record" 산출 category 추가
  - ✅ aligned: RTSC.md §8.9 (5-criteria gate) + §8.10 (Nb honest correction) — R4 가 직접 참조
- Follow-up TODOs:
  - TODO(stage-1-enforcement): Swift Codable `MaterialAttestationRecord` 에 `rtsc_5_gate_evaluation: RTSC5GateEvaluation?` 필드 추가 (현재 doctrinal-only)
  - TODO(stage-2-paper-hook): PAPERS/ compile-time hook — abstract 의 "RTSC absorbed=true" 문구 발견 시 동반 attestation record 의 5-gate state 검증
- Suggested commit: docs: amend constitution to v1.4.0 (R4 RTSC absorbed=true twin-error invariant)
-->

# demiurge Constitution

## Core Principles

### I. hexa-lang Pointer (NON-NEGOTIABLE)
demiurge is a typed-interface CONSUMER of hexa-lang stdlib, `hexa-matter` (materials), `hexa-bio` (molecules), and `comb` (n=6 lattice fabric). It does NOT fork, vendor, or absorb these. `domains/matter/` is a pointer into hexa-lang's absorbed material primitives — not a copy. Gaps file upstream via `~/core/hexa-lang/inbox/patches/`. hexa-lang's constitution governs stdlib / atlas / grammar / lattice; demiurge adheres on those subjects.

### II. 7-Verb Universal Pipeline
The spine is domain-neutral: SPECIFY → ARCHITECT → DESIGN → ANALYZE ⟲ → SYNTHESIZE → VERIFY → HANDOFF. Domain plugins (chip, component, cern, antimatter, rtsc, space, energy, brain, fusion, mobility, bot, grid, aura, sscb, scope) attach to this spine; they do not duplicate it or carry a private pipeline. Cited foundation: `design.md` Decision 5.

### III. Meta-Conductor Chain
Materials → chip → component are sequential passes. Each pass's HANDOFF feeds the next pass's SPECIFY via a typed seam contract (`rfc_007` materials→chip, `rfc_008` chip→component). Out-of-order or unchained execution violates this principle.

### IV. Public-Surface Clean-Room
Research draws from public sources only: OSS code/specs, arxiv, patents (as public disclosure), standards, datasheets, and public documentation of proprietary tools — for capability/gap mapping + clean-room re-derivation. CLOSED-BINARY DECOMPILATION, LICENSE/DRM CIRCUMVENTION, AND TRADE-SECRET EXTRACTION ARE OUT OF SCOPE.

### V. No Over-Claim (g3) — Measured Before Claimed
"absorbed", "parity", "resolved", "complete" require a recorded measurement before they appear in code, docs, or surface. No claim without evidence; missing measurement is recorded as missing. Aligns with hexa-lang `LATTICE_POLICY.md` (lattice-as-tool, anti-over-claim).

### VI. Step-by-Step Decision Gate (NON-NEGOTIABLE)
One user-confirmation per decision, never batched. Each lands in `design.md` as `### Decision N — <picked>` with explicit **picked** + 3+ rationale bullets. `design.md` is the decision audit-trail SSOT.

## Repository Layout

```
demiurge/
├── CHARTER.md     # scope & governance (authoritative)
├── ARCH.md        # narrative architecture SSOT
├── PLAN.md        # append-only progress log (κ-N phase entries)
├── design.md      # decision audit trail (SSOT)
├── GOAL.md        # one-sentence north-star
├── HANDOFF.md     # self-contained pickup brief
├── domains/       # pluggable domain modules (chip lead, cohort + 13 shallow)
├── proposals/     # rfc_NNN_*.md (typed-seam contracts)
├── cockpit/       # macOS Swift workbench (/Applications/demiurge.app)
├── exports/       # outbound seam payloads
├── inbox/         # inbound external material (clean-room queue)
├── state/         # runtime state for the cockpit
└── .specify/      # Spec Kit pipeline artifacts (this constitution lives here)
```

## Development Workflow

1. **Decision first.** Every direction lands in `design.md` as a Decision entry before code moves. One decision per gate (Principle VI).
2. **Spec next.** Feature work flows through Spec Kit: `/speckit-specify → /speckit-plan → /speckit-tasks → /speckit-implement`.
3. **Domain via plugin, never via spine fork.** New engineering domains attach as plugins under `domains/`; they do not re-implement the 7-verb spine.
4. **Upstream gaps, not local hacks.** When `hexa-lang` / `hexa-matter` / `hexa-bio` / `comb` lacks a primitive, the patch is filed at `~/core/hexa-lang/inbox/patches/<name>.md`. Local workarounds in demiurge are blocked when an upstream fix is feasible.
5. **Measure before claim.** Any merge that asserts absorbed/parity/resolved/complete must point at the recorded measurement (test, bench, citation).

## Governance

- This constitution governs demiurge-local concerns (7-verb spine, meta-conductor chain, clean-room boundary, decision discipline, honest reporting). On stdlib / atlas / grammar / lattice / materials / molecules subjects, the `hexa-lang` constitution wins.
- Amendments land via a PR that updates this file, adds a `design.md` decision entry, and bumps semver: MAJOR = principle removal/redefinition · MINOR = new principle/section · PATCH = wording.
- Complexity must be justified in the corresponding `design.md` entry. Default = simpler.

## Governance Rows

Narrative anchors for typed enforcement invariants. Each row points at the load-bearing test/code that actually enforces; the row itself is the human-readable governance pointer (not the enforcement). Add rows by appending — never edit existing rows in-place except for PATCH-level wording.

### R1. Measured-Oracle Invariant — `absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=true`

A cell-record's stored `absorbed: Bool` flips legitimately only when an attached `MeasuredOracleRef` records `isMeasuredOraclePASS=true` against its PASS criterion. Conflation of the measured-oracle axis with substrate-parity (D95 computed projection · `isHexaNativeAbsorbed`) is forbidden — D103 dimension-separation enforces two orthogonal axes (`absorbed` = measurement axis · `hexa_native_parity` = substrate-port axis).

- **Carve-outs**:
  - **D106 illustrative-physics cells**: `.illustrativePhysics` `GateType` cells (RFC 013 §6.12) are exempt — no `MeasuredOracleRef` can be attached; `absorbed` flips by illustrative gate criteria, not measured-oracle PASS. Anti-conflation cyan tone in cockpit.
  - **D95 computed projection (substrate-parity)**: A DIFFERENT axis (D103). `isHexaNativeAbsorbed` computed projection PASS is NOT sufficient to flip `absorbed`. Separate stored field carries the substrate-parity record (`HexaNativeParityRef`).
- **First land (κ-68 G29 · D110 · 2026-05-21)**: Energy/solar cell · oracle = NREL MIDC SRRL pyranometer GHI · 480 clear-sky samples (2024-06-15) · `mean_rel_err = 0.04967` ≤ 0.05 threshold · marginal PASS · commit `80a1664`.
- **Load-bearing enforcement** — *Stage 1 (typed)*: `cockpit/Tests/DemiurgeCoreTests/AbsorbedNeedsMeasuredOracleTests.swift` (commit `fee34cc` · 3 test methods covering invariant + D95 conflation + D106 exempt branch · 63/63 PASS · 0 regression). The XCTest invariant is the real enforcement vehicle; this row is the narrative pointer.
- **Cross-links**: ARCH §11.4 G30 (Stage 1 LANDED) · ARCH §11.4 G34 (Stage 2 = 본 row LANDED) · design.md D109 (cell+oracle pick) · D110 (first flip record) · D103 (dimension-separation) · D106 (illustrative carve-out) · RFC 013 §6.11 (LANDED · κ-68 closure) · §6.12 (illustrative anti-conflation).

### R2. Generic Verb-Cell Dispatch — `cellrun.hexa` + per-domain `.demi` manifest

Verb-cell dispatch (the 18-domain × 7-verb = 126-cell grid) flows through a **hexa-native generic dispatcher** (`~/core/hexa-lang/stdlib/cockpit/cellrun.hexa`) that reads a per-domain `.demi` manifest (`domains/<id>.demi` with `[cell.<verb>]` sections). New domains and new cells wire by editing the manifest — **never by adding new Swift code**. The 46 `cockpit/Sources/DemiurgeCore/Loaders/*Producer.swift` classes + 40+ hardcoded `(.verb, "domain")` switch cases in `ActionDispatch.swift` are **transitional bridges** (Principle I 'hexa-lang Pointer' + D14 / D18 / ARCH §0 hexa-only ultimate form 의 후속 적용 axis).

- **Manifest format** (8 keys per `[cell.<verb>]` section):
  - Required: `substrate` (python3 | hexa | curl | ngspice | bash | scan_only) · `script` (path under hexa-lang) · `record_kind` (Swift symbol pointer — typed-record schema reference) · `output_dir` (relative `exports/<domain>/<verb>/`)
  - Optional: `required_deps` · `gate_default` (OPEN | CLOSED) · `absorbed_default` (false | true) · `scope_caveats[]` · `fallback` (variant chain) · `unwired = true` (honest-skip with scaffold-pending message)
- **Carve-outs**:
  - **`record_kind` Swift-side anchor**: typed-record construction stays in Swift (compile-time safety on consumer side). Manifest declares the schema name; cellrun.hexa emits the JSON envelope; cockpit Swift decodes via the named Codable struct. The generic dispatcher does NOT absorb per-domain Codable schemas.
  - **`substrate = scan_only`**: 5 witness producers (Aura/Bio/Brain/Chem/Grid verify · foreign-drop scans) need a distinct code path with no spawn — cellrun.hexa handles via dedicated branch.
  - **Unwired cells**: manifest section absence (or `unwired = true`) → automatic g3 honest-skip · typed-by-config · no ad-hoc text fallthrough.
- **First land (Phase A · 2026-05-21)**: `~/core/hexa-lang-cellrun` isolated worktree · branch `cellrun-generic-dispatcher-scaffold` commit `cc1ad85` · 684-line `cellrun.hexa` + 192-line selftest (15/15 PASS) + end-to-end smoke (manifest-missing rc=2 honest-skip verified). Phase B (`domains/sscb.demi` PoC + sscb cells migrate · 1-2 session) pending review-then-merge of cellrun PR.
- **Load-bearing enforcement** — *Phase A scaffold*: `~/core/hexa-lang-cellrun/stdlib/cockpit/cellrun_test.hexa` (15-subtest invariants covering manifest-missing rc=2 · deps-missing rc=3 · success rc=0 · envelope shape `{record_kind, record_id, produced_at_utc, payload{substrate, provenance{measurement_gate, absorbed, scope_caveats}}}`). The hexa selftest is the real enforcement vehicle; this row is the narrative pointer.
- **Migration cost** (honest correction 2026-05-21 저녁 · per Phase B step 3 observed data on branch `d111-phaseb-sscb-migration` · PR #267 OPEN · commit `deffc92` — supersedes original 6-8 focused sessions desk estimate from morning ratification): **15-20 focused sessions** for full 46-producer migration. Phase B step 3 observed cost = **20 min/cell** (3× original 12 min/producer estimate · 3 sscb cells = 6.5% of 46 consumed ~1 hour focused work). Overhead sources: format-mismatch fixup · Verb Korean→English mapping · Python version debug · payload-flattening decisions. Phase A bug fixes in flight (cellrun.hexa `_split_csv` quoted-comma · Verb.canonical Korean drift · python candidate list · concurrent agent) reduce future per-cell cost — but 20 min figure already absorbs some recovery overhead, so envelope stays honest at 15-20 session. sscb.demi PoC 121 line covering 7/7 verbs (3 wired + 4 honest-skip with `unwired = true`) remains the Phase B reference artifact. Original audit cite: `inbox/notes/2026-05-21-generic-cellrun-migration-design.md` (412 line · untracked · morning desk estimate).
- **Axis distinction**: R2 is dispatch-mechanism axis (plumbing) · cell `absorbed` 자체 무관 (R1 measurement axis · D103 dimension separation 보존). D74 ProducerRegistry alternatives 패턴 자연 흡수 (`[cell.<verb>.<variant>]` 섹션 multiple).
- **Cross-links**: ARCH §4.5 (target shape diagram + cost reduction table + migration path) · design.md D111 (parent decision · full rationale + rejected alternatives + Phase A..E exit criterion + axis distinction) · **D112** (Verb canonical Korean → English wire-form rename · bug #2 fix · naming convention A picked) · **D113** (payload flattening · sibling `.meta.json::measurements` roll-up into `payload.measurements` · downstream consumer compat) · D14 / D18 / D74 / D80 / D83 (`.demi` precedent) · Principles I (hexa-lang pointer) · II (7-verb spine) · ARCH §0 first principle.

### R3. stdlib SSOT = hexa-lang only — demiurge `cockpit/Sources/` algorithm-shaped code 금지

All **stdlib code** (substrate algorithms · physics · math · validation logic · domain-specific kernels) lives in **`~/core/hexa-lang/stdlib/<domain>/` ONLY**. Sibling repos (`~/core/hexa-rtsc/` · `~/core/hexa-matter/` · `~/core/hexa-bio/` · `~/core/hexa-chem/`) are **docs only** — markdown narrative · domain spec · physics derivation notes · citation indexes · NO code (per D116 amendment of D14/D17/D77 precedent). demiurge `cockpit/Sources/` carries **only**: (a) typed record schemas (Codable wire models · compile-time safety for consumer) · (b) UI views (SwiftUI · cockpit chrome) · (c) thin dispatch wrappers (`CellrunDispatch.swift` · `*Producer.swift` transitional bridges per D111 Phase C deprecation track) · (d) CLI presentation (DemiurgeCLI args parse + output formatting). **Algorithm-shaped code in `cockpit/Sources/` is an anti-pattern requiring migration to hexa-lang stdlib.**

- **Boundary table** (cockpit/Sources/ 에 OK vs NO · per D114 § enforcement boundary):
  | code shape | demiurge cockpit/ 위치? | reason |
  |---|---|---|
  | typed record models (`*Record.swift` Codable) | ✅ OK | consumer-side wire-format compile-time safety |
  | UI views (SwiftUI · cockpit chrome) | ✅ OK | macOS-native presentation · Tier-2 hexa-lang UI is separate axis |
  | thin dispatch wrappers | ✅ OK (transitional · D111 Phase C track) | spawn glue |
  | CLI presentation (DemiurgeCLI) | ✅ OK | Swift binary entrypoint |
  | domain manifests (`.demi`) | ✅ OK | pointers (D111 § rationale "co-located 2 file") |
  | **algorithm code** (math · physics · validation rules · domain logic) | 🔴 **NO** | migrate to hexa-lang stdlib |
  | Python scripts under `cockpit/scripts/` | 🔴 **NO** (D61 violator) | migrate to `hexa-lang/stdlib/<domain>/` |
- **Carve-outs**:
  - **Transitional bridges** (`*Producer.swift` 46 잔존 · `*Dispatch.swift` spawn glue): allowed UNTIL D111 Phase C migration retires them (estimated 15-20 session). Each transitional bridge must cite the cellrun.hexa target script path in a header docstring + the Phase C migration ETA in commit body when modified.
  - **macOS-native UI** (SwiftUI · RealityKit · etc.): allowed since hexa-lang lacks macOS UI substrate. Tier-2 future axis (wilson harness with native UI) may shift this; until then, cockpit Swift UI is canonical.
- **Anti-pattern enforcement**:
  - New `*Dispatch.swift` · `*Producer.swift` containing >100 LOC of non-dispatch logic = R3 violation · refactor to hexa-lang stdlib (D111 cellrun route) or split into thin dispatch + hexa-lang substrate.
  - Python scripts under `cockpit/scripts/` (currently 1 D61 violator `bipv_freecad.py`) = R3 violation · migrate to `~/core/hexa-lang/stdlib/<domain>/`.
- **First land (2026-05-21 · D114 ratification)**: doctrine ratified before any migration · Phase A = R3 governance row (this row) · Phase B = `MaterialFalsifierDispatch.swift` 438-line audit · Phase C = `bipv_freecad.py` migration · Phase D = automated static-analysis hook (Tier-2 deferred).
- **Load-bearing enforcement** — *Phase D (planned · Tier-2)*: automated static-analysis hook on `cockpit/Sources/` that fails `swift build` when new files exceed dispatch-wrapper LOC threshold OR contain algorithm-shaped patterns (AST analysis). Until Phase D lands, **PR review** is the enforcement vehicle; new PRs touching `cockpit/Sources/Loaders/` must cite R3 + verify the dispatch-wrapper shape.
- **Cross-links**: design.md **D114** (full rationale + boundary table + Phase A..D exit + axis distinction) · D111 (dispatch-mechanism sibling axis · `cellrun.hexa` + `.demi` manifest) · D14 / D18 (hexa-lang substrate doctrine) · D17 / D77 (sibling repos precedent) · D61 (D61 violator pattern · `bipv_freecad.py` is the 1 remaining) · D80 (endpoint rule · ultimate-form proof) · ARCH §0 (first principle) · §4.5 (cellrun architecture) · Principle I (NON-NEGOTIABLE · this row enforces) · Wilson Principles 1+2+4+5.

### R4. RTSC absorbed=true twin-error invariant — namespace exploit + goal abandonment 모두 금지

User-level goal "RTSC 물질 absorbed=true" (room-temperature SuperConductor 의 측정-검증 absorbed) 의 만족 여부는 **RTSC.md §8.9 의 5-criteria gate** 가 SOLE 정의이다. 다음 두 anti-pattern 은 모두 절대 금지:

**Pattern 1 — namespace exploit (FORBIDDEN)**: RTSC.md §1 의 naming-collision (도메인 id `rtsc` 가 device/magnet engineering 영역 namespace 인 한편 RTSC literal 정의는 room-temperature material 인 모순) 을 이용해, LTS 또는 HTS attestation 에 `domain: "rtsc"` 를 박은 후 *RTSC material absorbed=true* 라는 사용자-수준 목표를 만족했다고 주장하는 행위.

**Pattern 2 — goal abandonment (FORBIDDEN)**: RTSC absorbed=true 가 현재 물리학으로 만족 불가능하다는 이유로 user-level goal 을 *폐기* / *불가능 declaration* / *비추적 영구 무효화* 하는 행위. 5-gate 는 미래 후보 등장 시 평가 통과 가능 — gate 가 OPEN 상태로 candidate matrix 와 함께 유지.

- **5-criteria gate (SOLE 정의)**: RTSC.md §8.9 의 (a)+(b)+(c)+(d)+(e) — 합성 가능성 (`replicated_by_independent_labs ≥ 3`) · Tc ≥ 270 K (R(T) · Meissner · AC susc 셋 다) · ambient pressure (≤ 1 atm) · ≥ 3 독립 lab 재현 · 측정-오라클 parity (`rel_err < 5%`) **모두 AND**. 하나라도 SKIP/FAIL 이면 RTSC absorbed=true 자격 없음 (코드-레벨 invariant).
- **Pattern 1 방지 (namespace separation)**:
  - (i) `domain: "rtsc"` namespace 의 *non-RTSC material* (LTS Nb · HTS REBCO 등) 의 absorbed=true 는 **ALLOWED**. 단 5-gate evaluation record (`rtsc_5_gate_evaluation` field) 가 attestation JSON 에 박혀야 하며, 5/5 가 아닌 경우 "RTSC material absorbed=true" 라는 인간-가독 요약 / paper-abstract 표현 **금지**. 대신 명시적 family label ("LTS attestation" · "HTS attestation") 사용.
  - (ii) *RTSC material* (Tc ≥ 270 K + ambient) absorbed=true 는 **5-gate 통과 record 셋 동시 존재** 시에만 emit 가능. 위반 record 는 reject.
- **Pattern 2 방지 (goal preservation)**: 5-gate candidate matrix (RTSC.md §8.9 의 family × gate 표) 는 **append-only · update-only · never-delete**. 어떤 후보도 5/5 통과 안 한다는 *현재 상태* 는 honest 정보 — *goal 자체* 가 사라지지 않음. 새 후보 등장 시 matrix 에 row 추가 + 5-gate 평가 시도 의무.
- **Load-bearing enforcement** — *Stage 1 (record schema · planned)*: `MaterialAttestationRecord` Swift Codable 에 `rtsc_5_gate_evaluation: RTSC5GateEvaluation?` 필드 추가 (Optional · default null). null = "5-gate 평가 없음" → "RTSC material absorbed=true" claim 금지 (paper/CLI 자동 caveat). 5/5 PASS 시에만 RTSC absorbed=true 표현 허용. *Stage 2 (paper-time gate · planned)*: paper compile-time hook 이 attestation record cross-reference 시 5-gate state 검증; fail 시 abstract 의 "RTSC absorbed=true" 문구 자동 reject 또는 caveat 강제 삽입.
- **First triggered (κ-?? · 2026-05-21)**: Pattern 1 발생 — `lts_nb_bcs_universal_gap_ratio_attestation` record (`exports/material_attestation/nb_bcs_v1/`) 가 `domain: "rtsc"` 로 박힘 + `PAPERS/sample-nb-bcs-absorbed/main.tex` abstract 가 "first RTSC-domain absorbed=true" 표현 사용. 사용자 catch: "Nb 는 LTS 잖아 · 상온 초전도체 아니잖아". 정정 행위: RTSC.md §8.9 신설 (5-gate 형식 정의) + §8.10 신설 (Nb attestation honest 정정 narrative). 본 R4 ratification 은 두 anti-pattern 동시 재발 영구 방지 doctrinal lock.
- **Cross-links**: RTSC.md **§8.9** (5-criteria gate · SOLE 정의 · candidate matrix · 7 유의사항) · **§8.10** (Nb attestation honest 정정 · *RTSC 가 아닌* LTS validation 으로 재포지셔닝) · **§8.8** (g3 honest stance 의 invariant 강화) · **§1** (domain naming-collision 진단 — Pattern 1 의 historical root) · **R1** (Measured-Oracle Invariant · `absorbed=true ⇔ measuredOracle.isMeasuredOraclePASS=true` · R4 는 R1 의 RTSC-specific 강화) · `design.md` D110 (첫 absorbed=true · solar pyranometer precedent · 5-gate 의 (e) parity 원형) · **Principle V** (No Over-Claim g3 · R4 는 그 RTSC-specific 가드).

**Version**: 1.4.0 | **Ratified**: 2026-05-21 | **Last Amended**: 2026-05-21

**Amendment history**:
- 1.4.0 (2026-05-21 후반 · MINOR) — R4 RTSC absorbed=true twin-error invariant 추가. user-level goal "RTSC 물질 absorbed=true" 의 만족 여부는 RTSC.md §8.9 5-criteria gate 가 SOLE 정의 — Pattern 1 (namespace exploit · LTS Nb 에 `domain: "rtsc"` 박고 RTSC 검증으로 주장) 과 Pattern 2 (goal abandonment · "현재 물리학으로 불가능" 이유로 영구 폐기) 모두 금지. 본 세션의 Nb attestation Pattern 1 발생 + 사용자 catch 가 ratification 의 직접 동기. RTSC.md §8.9 5-gate 형식 정의 + §8.10 Nb honest 정정 narrative 도 같은 세션 신설. MINOR (new R-row + 5-gate formal 정의 + candidate matrix append-only invariant · no Core Principle 변경).
- 1.3.0 (2026-05-21 저녁 후반 · MINOR) — R3 stdlib SSOT row added (D114 ratification). cockpit/Sources/ 의 code-shape enforcement boundary 명문화 (typed records · UI · thin dispatch · CLI = OK · algorithm-shaped code = NO). 사용자 직접 지시 "모두 hexa-lang 보관 / SSOT 말이야 / stdlib 말이야" 가 본 row 의 doctrinal motivation. MINOR (new R-row + R3 enforcement boundary table · no principle change).
- 1.2.2 (2026-05-21 저녁 후반 · PATCH) — R2 Cross-links 확장: D112 (Verb canonical Korean → English wire-form rename · bug #2 closure · naming convention A picked) + D113 (payload flattening · sibling `.meta.json::measurements` roll-up · downstream consumer compat) cross-link 추가. Phase A bug triage 완료 narrative anchor — bug #1 `_split_csv` quoted-comma fix · #2 design ratified D112 · #3 `python_candidates` manifest key fix 모두 PR #267 또는 D-block 으로 closure 경로 확보. PATCH (no new principle/section · cross-link expansion only).
- 1.2.1 (2026-05-21 저녁 · PATCH) — R2 Migration cost wording correction: **6-8 → 15-20 focused sessions** per Phase B step 3 observed cost (20 min/cell · 3× original 12 min/cell desk estimate · 3 sscb cells consumed ~1 hour focused work on branch `d111-phaseb-sscb-migration` · PR #267 OPEN). 3-SSOT synchronized correction (design.md D111 · ARCH §4.5 + Log entry · this row). PATCH (no new principle/section · wording-only).
- 1.2.0 (2026-05-21 morning) — R2 Generic Verb-Cell Dispatch row added (D111 ratification · `cellrun.hexa` + `.demi` manifest target shape · Phase A scaffold landed).
