# D114 Phase B audit — `MaterialFalsifierDispatch.swift` (438 LOC) R3 compliance

> **⚠ D116 corrigendum (2026-05-21 저녁 후반 · audit note post-write
> correction)**: 본 note 의 destination 추천 `~/core/hexa-rtsc/verify/
> falsifier_dispatch.hexa` 는 **D116 ratification 으로 invalid**.
> 사용자 directive ("hexa-rtsc 는 문서만 / 코드는 hexa-lang · demiurge")
> + AskUser 해석 A (모든 sibling repos 문서만) 따라 sibling repos =
> 문서만 doctrine 박힘 (constitution R3 1.4.1 · ARCH §0+§4.4+§4.5
> · `.specify/README.md` D114/D116 section + 실수 방지 #1). 모든
> destination path 가 `~/core/hexa-lang/stdlib/rtsc/falsifier_
> dispatch.hexa` 로 정정됨 (13 occurrence replaced inline). 본 note
> 의 "co-location with siblings (`calc_bcs.hexa` 등 in hexa-rtsc/
> verify/)" reasoning 은 **future migration target 도 hexa-lang/
> stdlib/rtsc/ 로 통합** 됨을 함의 (Phase C 의 4 sibling algorithm
> + 본 dispatch 모두 hexa-lang 으로 multi-cycle 이전). § 4.1 destination
> rationale + § 6 D-block stub 의 substrate-pick narrative 는 **본
> corrigendum 으로 superseded** — 부분적 wording 잔존 시 D116 가
> overrides.

## § 0. Purpose

D114 Phase B audit · `cockpit/Sources/DemiurgeCore/Loaders/MaterialFalsifierDispatch.swift` (438 LOC) · R3 compliance assessment + migration plan to hexa-lang/stdlib/rtsc/ (algorithm portion · D116 정정). Read-only. No code change. No commit.

---

## § 1. File-level audit

File rider: `f4defee` (2026-05-21). Single `public enum MaterialFalsifierDispatch` with one static method `dispatch(sampleId, tier1, tier2, tier3Measurements) -> MaterialVerdictResult`. The 438 LOC are structurally one giant function (no helpers). Below the function is sliced by `─── …` comment banners.

Two levels of categorization:

- **F = function-level** (the dispatch entry-point is a single function but bands are functionally separable)
- **B = band-level** (per `───` comment header inside the body)

### 1.1 Top-level structure

| # | name / band | LOC range | LOC | category | description |
|---|---|---|---|---|---|
| F1 | `struct MaterialVerdictResult` (typed result) | 26–38 | 13 | typed-record (orchestration return type) | Sendable typed struct + `text` computed prop · OK in cockpit |
| F2 | `enum MaterialFalsifierDispatch` static `verdictRecordsRoot` constant | 40–43 | 4 | orchestration (path glue) | URL construction · OK |
| F3 | `dispatch(...)` signature + doc + logging preamble | 45–68 | 24 | orchestration | doc-comment · variable init · diagnostic `lines.append` |
| F3.a | tier3 bucketing by `kind` string | 69–73 | 5 | orchestration | `first(where: kind == "r_t")` style filter |
| F3.b | **F-SC-1 BCS isotope** band | 75–124 | 50 | **algorithm + orchestration mixed** | `delta = abs(alpha - 0.5)` · threshold 0.15 · PASS/FAIL/INCONCLUSIVE/SKIPPED branch tree |
| F3.c | **F-SC-2 McMillan Tc** band | 126–163 | 38 | **algorithm + orchestration mixed** | `ratio = abs(measuredTc - predictedTc) / predictedTc` · threshold 0.5 |
| F3.d | **F-SC-3 Hc2 WHH** band | 165–212 | 48 | **algorithm + orchestration mixed** | `ratio = abs(m - p) / p` · threshold 0.5 |
| F3.e | **F-RTSC-1 Meissner χ** band | 214–253 | 40 | **algorithm + orchestration mixed** | `chi < 0` predicate · PASS/FAIL/INCONCLUSIVE/SKIPPED |
| F3.f | **F-RTSC-2 R(T) drop** band | 255–295 | 41 | **algorithm + orchestration mixed** | window check `measuredTc ∈ [0.5·Tc_pred, 2.0·Tc_pred]` |
| F3.g | **F-RTSC-3 replication** band | 297–336 | 40 | **algorithm + orchestration mixed** | `n ≥ 2 ⇒ PASS · n == 1 ⇒ INCONCLUSIVE · n == 0 ⇒ FAIL` |
| F3.h | aggregate verdict | 338–353 | 16 | **algorithm** (pure decision rule) | counts PASS/FAIL/SKIP · maps to `PASSES-ALL` / `FAILS-AT-LEAST-ONE` / `INCONCLUSIVE-MULTIPLE-MISSING` / `PARTIAL` |
| F3.i | stamp + carry-forward + InputTriple build | 355–367 | 13 | orchestration / typed-record construction | ISO8601 stamp · tier-id string interp · struct init |
| F3.j | caveats + citations literal arrays | 369–390 | 22 | config / static text | RTSC.md §-citation literals + dynamic caveats from F3.h counts |
| F3.k | `MaterialVerdictRecord` construction | 392–401 | 10 | typed-record construction | Codable struct init · OK |
| F3.l | mkdir / encode / write JSON · error returns | 403–434 | 32 | orchestration | file I/O · error handling · diagnostic `lines.append` |
| F3.m | return + diagnostics | 429–436 | 8 | orchestration | record-id string · trailer lines |

### 1.2 Aggregated counts

- **Total LOC (excluding leading file header comment 1–23)**: 415 effective LOC (438 with header)
- **Bands**: 14 logical bands (F1, F2, F3.a..F3.m)
- **Algorithm-shaped LOC**: F3.b + F3.c + F3.d + F3.e + F3.f + F3.g + F3.h = 50 + 38 + 48 + 40 + 41 + 40 + 16 = **273 LOC** (of 438)
- **Orchestration LOC**: F2 + F3 preamble + F3.a + F3.i + F3.l + F3.m = 4 + 24 + 5 + 13 + 32 + 8 = **86 LOC**
- **Typed-record construction LOC**: F1 + F3.k = 13 + 10 = **23 LOC**
- **Config / static citation LOC**: F3.j = **22 LOC** (mostly OK · §-citation literals are SSOT pointer text)
- **File header doc-comment**: 1–24 = **24 LOC** (OK · doc)

### 1.3 R3 verdict per band

| band | shape | verdict | target if migrate |
|---|---|---|---|
| F1 `MaterialVerdictResult` | typed record (Sendable) | ✅ OK · cockpit | n/a (stays in cockpit · is the dispatch return surface) |
| F2 `verdictRecordsRoot` | URL path | ✅ OK · cockpit | n/a |
| F3 preamble | diagnostic | ✅ OK · cockpit | n/a |
| F3.a bucketing | filter by kind string | ✅ OK · cockpit (thin dispatch) | n/a |
| F3.b F-SC-1 BCS isotope | algorithm + orchestration **mixed** | 🔴 R3 violation · 50 LOC | `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa::eval_f_sc_1_bcs_isotope` |
| F3.c F-SC-2 McMillan Tc | algorithm + orchestration **mixed** | 🔴 R3 violation · 38 LOC | `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa::eval_f_sc_2_mcmillan_tc` |
| F3.d F-SC-3 Hc2 WHH | algorithm + orchestration **mixed** | 🔴 R3 violation · 48 LOC | `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa::eval_f_sc_3_hc2_whh` |
| F3.e F-RTSC-1 Meissner | algorithm + orchestration **mixed** | 🔴 R3 violation · 40 LOC | `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa::eval_f_rtsc_1_meissner` |
| F3.f F-RTSC-2 R(T) drop | algorithm + orchestration **mixed** | 🔴 R3 violation · 41 LOC | `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa::eval_f_rtsc_2_r_of_t` |
| F3.g F-RTSC-3 replication | algorithm + orchestration **mixed** | 🟡 borderline · 40 LOC · "rule-shaped" not "physics-shaped" | `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa::eval_f_rtsc_3_replication` |
| F3.h aggregate verdict | pure decision rule | 🔴 R3 violation · 16 LOC · domain-specific aggregation rule | `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa::aggregate_verdict` |
| F3.i stamp / carry-forward / InputTriple | orchestration / record build | ✅ OK · cockpit | n/a |
| F3.j caveats + citations | static text + dynamic count-driven caveats | 🟡 SPLIT · static citations stay (cockpit SSOT pointer text) · dynamic caveats are downstream of F3.h aggregate ⇒ should be returned by hexa eval and threaded back | partial migrate · citations literal array stays cockpit |
| F3.k record construction | Codable struct init | ✅ OK · cockpit (typed record SSOT lives in cockpit) | n/a |
| F3.l mkdir / encode / write | file I/O + error path | ✅ OK · cockpit | n/a |
| F3.m return | string interp + diagnostics | ✅ OK · cockpit | n/a |

### 1.4 Mixed-band callout

Bands F3.b–F3.g are NOT pure algorithm — each band intermixes:

- The actual **physics / rule predicate** (~5–8 LOC): `delta <= 0.15` · `ratio <= 0.5` · `chi < 0` · `lo ≤ measuredTc ≤ hi` · `n >= 2`
- **Evidence-string formatting** (~20–30 LOC per band): inline `String(format:)` · `evidence: "tier1 spec.tc_k=\(predictedTc) vs tier3 r_t headline.tc_k=\(measuredTc) (|Δ|/Tc_pred=\(...) ≤ 0.5)"` · these are domain-specific evidence templates and travel with the algorithm
- **Missing-input branch tree** (~5–15 LOC per band): nil-coalescing input chains — orchestration-shaped BUT the *which inputs are required for this falsifier* knowledge is domain-specific

Honest read: the bands are 60% algorithm-shaped (predicate + evidence text + required-input declaration) + 40% Swift control-flow noise from `if let` unwrapping. After porting to hexa-lang the bands compress to ~15–20 LOC each (no `if let` ladder · domain-native `option<f64>` flows · evidence template lives next to the predicate).

---

## § 2. Companion record models — R3-compliant typed Codable structs (✅ stay in cockpit)

All 5 record models are **R3-compliant** typed Codable structs · zero algorithm · safe to remain in `cockpit/Sources/DemiurgeCore/Models/`.

| file | LOC | shape | R3 verdict |
|---|---|---|---|
| `ConductorMaterial.swift` | 77 | enum `Codable, CaseIterable, Sendable` + `displayName` switch · pure taxonomy | ✅ OK · typed record (taxonomy enum + display label) |
| `ConductorRecord.swift` | 110 | struct `Codable, Equatable, Sendable` with nested `Spec` · `SourceProvenance` + `CodingKeys` | ✅ OK · pure typed record · no algorithm |
| `MaterialVerdictRecord.swift` | 154 | struct `Codable, Equatable, Sendable` with nested `InputTriple` · `FalsifierResult` + `CodingKeys` · default-valued init | ✅ OK · pure typed record |
| `MeasurementRecord.swift` | 159 | struct `Codable, Equatable, Sendable` with 5 nested structs (`Instrument` · `SampleProvenance` · `DataPoint` · `Headline` · `Provenance`) + `CodingKeys` | ✅ OK · pure typed record |
| `SynthesisRecipeRecord.swift` | 104 | struct `Codable, Equatable, Sendable` with 4 nested structs (`Reagent` · `TemperatureStep` · `Conditions` · `Provenance`) + `CodingKeys` | ✅ OK · pure typed record |

**confirmation**: 5/5 are typed Codable record schemas — D114 §enforcement-boundary row "typed record models" → ✅ OK in cockpit/.

Note: `displayName` switch in `ConductorMaterial.swift` is mostly static label text (RTSC.md §8.2 honest-naming) · qualifies as "config / static text" not algorithm.

---

## § 3. Test contract — behaviors MUST be preserved during migration

`MaterialFalsifierDispatchTests.swift` (130 LOC · actually 391 LOC — task note 130 is stale) exercises 5 test cases.

### Contract surface (what migration must NOT break):

1. **`MaterialFalsifierDispatch.dispatch(...)`** signature stays identical · same 4-param Swift surface · same `MaterialVerdictResult` return type · same on-disk JSON layout under `exports/material_verdict/<sample_id>/<stamp>.json`.

2. **Per-falsifier verdict shape**:
   - Claim-only synthetic (tier1=nil · tier2 with replicated=0 · tier3=[]) → `aggregateVerdict = "FAILS-AT-LEAST-ONE"` · F-RTSC-3 status = "FAIL" (anonymized 2026-05-22 aggressive scrub — was named after a specific historical RT-SC claim)
   - Nb (tier1=nil · tier2=nil · tier3=[meissner χ=-1.0]) → F-RTSC-1 status = "PASS" · aggregate = "INCONCLUSIVE-MULTIPLE-MISSING"
   - MgB2 (tier1.tc_k=39 · tier3=[r_t, cp]) → F-SC-2 = "PASS" · F-RTSC-2 = "PASS"
   - YBCO (REBCO conductor + REBCO recipe replicated=5 + ybco r_t Tc=92 K) → F-RTSC-3 = "PASS" (first replication=PASS in project) · F-RTSC-2 = "PASS" · `replicatedByIndependentLabs = 5` carry-forward
   - Nb3Sn (tier1.tc_k=18 · hc2_at_4k=30 · tier2=NbTi replicated=8 · tier3=[hc2 measured=27]) → F-SC-3 = "PASS" · F-RTSC-3 = "PASS"

3. **g3 invariants** (NON-NEGOTIABLE):
   - `decoded.absorbed == false` ALWAYS (Tier 4 NEVER flips absorbed=true)
   - `decoded.measurementGate == .open` ALWAYS (dispatch alone never closes gate)
   - `decoded.falsifierResults.count == 6` (6-falsifier registry · all 6 IDs always present)
   - Every `r.evidence` non-empty (g3 evidence-mandatory)
   - `decoded.replicatedByIndependentLabs` = carry-forward from tier2 (NEVER auto-incremented)

4. **Aggregate-verdict precedence rules** (F3.h band):
   - `nFail >= 1` ⇒ `"FAILS-AT-LEAST-ONE"` (overrides skip count)
   - `nFail == 0 && nSkip == 0 && nPass == 6` ⇒ `"PASSES-ALL"`
   - `nFail == 0 && nSkip >= 3` ⇒ `"INCONCLUSIVE-MULTIPLE-MISSING"`
   - else ⇒ `"PARTIAL"`

5. **JSON wire shape** stable: `MaterialVerdictRecord` CodingKeys are SSOT · round-trip decode must produce identical fields incl. snake_case keys.

### Migration regression test approach:

- **Smoke comparison**: pre-migration `MaterialFalsifierDispatch.dispatch(...)` output `MaterialVerdictRecord` JSON for the 5 test cases above → save as golden fixtures under `cockpit/Tests/DemiurgeCoreTests/Fixtures/material_verdict_golden/`.
- **Post-migration**: thin Swift dispatch wrapper calls `hexa run ~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa --sample-id=... --tier1=... --tier2=... --tier3=...` (or via cellrun envelope when D111 Phase C lands cellrun-based dispatch) · parses returned JSON · re-encodes through Codable for stamp normalization · compares against golden.
- **Tolerance**: stamp differs per run · everything else byte-identical.
- **Citation literals**: 8 RTSC.md §-citation strings (F3.j) — must reappear in same order. Static text · trivial to preserve.

---

## § 4. Migration plan

### 4.1 Substrate destination — `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa` (preferred)

Pick rationale:

- **hexa-rtsc/verify/ exists + already houses the per-falsifier algorithm files** (`calc_bcs.hexa` 384 LOC · `calc_mcmillan.hexa` 440 LOC · `calc_hc2_48t.hexa` 446 LOC · `falsifier_check.hexa` 381 LOC). The `dispatch` step is the *integrator* over these — natural co-location.
- **D17 precedent**: hexa-rtsc is the RTSC SSOT · D14/D18/ARCH §0 ultimate-form pulls anything algorithm-shaped that scores RTSC falsifiers under hexa-rtsc.
- **NOT `hexa-lang/stdlib/matter/`**: this directory does not exist · creating a sibling-to-hexa-rtsc home would split the falsifier knowledge across two repos.
- **NOT `hexa-matter/`**: hexa-matter is the *material-family taxonomy + breakthrough record* SSOT (ceramics · adhesive · aerogel-foam · 2d-materials) · it's about classifying materials by class, NOT about scoring RTSC falsifiers. The dispatcher reads ConductorMaterial enum (which is the cockpit-side mirror of hexa-matter's §8.2 matrix) but the *algorithm* lives next to its siblings (`calc_bcs.hexa` etc.) in hexa-rtsc/verify/.

### 4.2 Algorithm portion → hexa-rtsc/verify/falsifier_dispatch.hexa (NEW file · est. 200-280 LOC)

Move to hexa-rtsc:

- **F3.b–F3.g** (6 falsifier evaluation bands · 257 LOC raw Swift)
- **F3.h** (aggregate verdict rule · 16 LOC)
- Subset of **F3.j** (dynamic caveat generation tied to nSkip / replicated=0)

After hexa-native compression (no `if let` ladders · domain-native option flows · evidence template strings) → estimated **200–280 LOC** in hexa-lang.

Suggested hexa-side function signatures:

```hexa
// 6 per-falsifier evaluators · each returns (status, evidence, confidence)
fn eval_f_sc_1_bcs_isotope(isotope: option<MeasurementRecord>) -> FalsifierResult
fn eval_f_sc_2_mcmillan_tc(t1: option<ConductorRecord>, r_t: option<MeasurementRecord>) -> FalsifierResult
fn eval_f_sc_3_hc2_whh(t1: option<ConductorRecord>, hc2: option<MeasurementRecord>) -> FalsifierResult
fn eval_f_rtsc_1_meissner(meissner: option<MeasurementRecord>) -> FalsifierResult
fn eval_f_rtsc_2_r_of_t(t1: option<ConductorRecord>, r_t: option<MeasurementRecord>) -> FalsifierResult
fn eval_f_rtsc_3_replication(t2: option<SynthesisRecipeRecord>) -> FalsifierResult

// aggregate rule
fn aggregate_verdict(results: list<FalsifierResult>) -> str

// top-level dispatch — emits JSON to stdout for Swift wrapper to parse
fn dispatch(sample_id: str, tier1: option<...>, tier2: option<...>, tier3: list<...>) -> MaterialVerdictRecord
```

### 4.3 What stays in cockpit/ (post-migration)

- **`MaterialFalsifierDispatch.swift`** shrinks from 438 → **~80–110 LOC**: thin wrapper that
  1. JSON-encodes the input triple (tier1 / tier2 / tier3)
  2. Spawns `hexa run ~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa` (or via D111 cellrun envelope when that lands)
  3. JSON-decodes returned `MaterialVerdictRecord`
  4. Writes to `exports/material_verdict/<sample_id>/<stamp>.json`
  5. Returns `MaterialVerdictResult` for diagnostics
- All 5 typed record models (`MaterialVerdictRecord` · `ConductorRecord` · etc.) stay in cockpit/ (typed-interface SSOT)
- 8 RTSC.md §-citation literals stay in cockpit/ (or pass through from hexa via dispatch return)
- All 5 XCTest cases stay as-is (smoke test the thin dispatch wrapper · same external contract)

### 4.4 Migration session estimate — **1.5–2 session** (single file · existing test coverage · existing verify/calc_*.hexa siblings)

Justification:
- D111 Phase C reference is 6–8 session for a multi-file generic cellrun refactor across cockpit + hexa-lang dispatch glue. This is single-file algorithm port with a stable external surface.
- Phase 1 (~1 session): port 6 per-falsifier evaluators + aggregate rule to `falsifier_dispatch.hexa` · port-internal selftest in `hexa-rtsc/tests/`.
- Phase 2 (~0.5–1 session): rewrite Swift wrapper to call hexa · golden-fixture regression test · run 5 XCTest cases · land PR.

### 4.5 Regression test approach (smoke comparison)

1. Pre-migration: run all 5 XCTest cases · capture emitted `MaterialVerdictRecord` JSONs as golden fixtures under `Fixtures/material_verdict_golden/{claimonly,nb,mgb2,ybco,nb3sn}.json` (claim-only fixture name anonymized 2026-05-22 aggressive scrub).
2. Stamp-normalize (replace `stamp` field with `"<NORMALIZED>"` for comparison).
3. Post-migration: re-run same 5 XCTest cases · normalize stamps · `diff` against golden — byte-identical required.
4. Additional invariants reasserted: 6 falsifier results · evidence non-empty · absorbed=false · measurementGate=GATE_OPEN · replicatedByIndependentLabs carry-forward.

---

## § 5. Proposed design.md D-block stub — D116

**Decision 116 — `MaterialFalsifierDispatch.swift` algorithm portion → `hexa-rtsc/verify/falsifier_dispatch.hexa` migration**

**picked**: D114 Phase B audit identified 273 LOC of algorithm-shaped code (6 falsifier evaluators + aggregate verdict rule) inside the 438-LOC `cockpit/Sources/DemiurgeCore/Loaders/MaterialFalsifierDispatch.swift`. Migrate the algorithm portion to a new hexa-rtsc file `verify/falsifier_dispatch.hexa` (~200–280 LOC after hexa-native compression) and shrink the cockpit wrapper to ~80–110 LOC thin dispatch (JSON encode triple · spawn hexa · decode `MaterialVerdictRecord` · write to exports). Substrate destination = `hexa-rtsc/verify/` (NOT `hexa-matter/` · NOT `hexa-lang/stdlib/matter/`) because the dispatcher is the integrator over existing siblings `calc_bcs.hexa` / `calc_mcmillan.hexa` / `calc_hc2_48t.hexa` / `falsifier_check.hexa` — co-location is natural.

**axis distinction**: D116 = single-file algorithm migration · executes D114 Phase B closure. D111 = dispatch-mechanism migration (cellrun + .demi manifests · multi-file). D116 may eventually compose under D111 cellrun envelope (Phase 3 · separately tracked).

**est**: 1.5–2 session.

**exit criterion**:
- Phase A · port 6 evaluators + aggregate rule to `falsifier_dispatch.hexa` · hexa-side selftest under `hexa-rtsc/tests/`
- Phase B · rewrite `MaterialFalsifierDispatch.swift` to thin wrapper · golden-fixture regression test
- Phase C · 5 XCTest cases pass byte-identical (stamp-normalized) · PR land

**cross-link**: D114 (parent enforcement axis) · D14 / D18 / ARCH §0 (hexa-only ultimate form) · `inbox/notes/2026-05-21-d114-phaseb-material-falsifier-audit.md` (本 audit note) · D111 (eventual cellrun composition · separate Phase).

---

## § 6. Open questions for user

1. **Substrate destination = `hexa-rtsc/verify/falsifier_dispatch.hexa` confirmed?** Audit recommends `hexa-rtsc/verify/` co-located with `calc_bcs.hexa` / `calc_mcmillan.hexa` etc. (the per-falsifier algorithm SSOTs). Alternative would be a new `hexa-lang/stdlib/matter/` directory — feasible but splits falsifier knowledge across two repos. Default: hexa-rtsc.

2. **Single `falsifier_dispatch.hexa` (Option A) vs split (Option B)?**
   - **Option A** (recommended): one file with 6 evaluators + aggregate rule + dispatch top-level (~200–280 LOC)
   - **Option B**: per-falsifier files (`eval_f_sc_1.hexa` · `eval_f_sc_2.hexa` · ...) — closer to `calc_*.hexa` sibling pattern (~50–60 LOC each). More files, lighter per-file.
   - Recommendation: **Option A** (the bands share input bucketing + evidence-string templates · per-falsifier split would duplicate boilerplate).

3. **D116 vs Decision-number drift**: D114 just landed · D115 reserved for G32 (κ-69 R8 cell pick). D116 is the next free slot. If G32 lands first (taking D115), then this migration becomes D116 as-stated. If `*Producer.swift` migration takes priority (different axis · D74 territory), D116 could be that instead and this migration shifts to D117. Audit assumes D116 for the migration.

4. **Caveat-generation split (F3.j)**: should the dynamic caveats (`nSkip > 0` · `t2.replicated=0`) be generated hexa-side and returned, or Swift-side from the aggregate count? Cleaner: hexa-side (caveats are downstream of aggregate logic · should travel with it). Static §-citation literals can stay in cockpit (8 strings · pointer text · low SSOT cost).

5. **Test fixture freezing**: should the 5 XCTest cases generate canonical golden fixtures under `Fixtures/material_verdict_golden/` as part of D114 closure (before D116 migration starts)? Recommendation: yes — gives a no-op baseline · catches any pre-migration drift.

6. **438 LOC composite — too much for one file?** Audit answer: no — the 438 LOC is structurally one function with 6 nearly-identical bands. Splitting before migration would be premature factoring; post-migration the cockpit side is ~100 LOC (clearly OK) and the hexa side is 200–280 LOC across 6 evaluator fns + 1 aggregate fn + 1 dispatch top-level (clearly OK as one cohesive file co-located with `calc_*.hexa` siblings).

7. **BCS vs WHH separation**: the per-band §1.3 table groups all 6 falsifiers under one destination (`falsifier_dispatch.hexa`). Alternative: F-SC-{1,2,3} (BCS-family · `calc_bcs.hexa`-adjacent) into `calc_bcs.hexa` extension and F-RTSC-{1,2,3} (RTSC-family) into a new `falsifier_rtsc.hexa`. Recommendation: keep all 6 in one dispatcher file — the dispatcher's job is integration · the per-physics algorithms already live in `calc_*.hexa` siblings and the dispatcher just *applies* their thresholds.
