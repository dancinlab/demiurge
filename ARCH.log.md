# ARCH — historical log

Spec at [`./ARCH.md`](./ARCH.md). Log entries below preserve session-by-session evolution; the spec file holds only the current confirmed state.

## Log

- 2026-05-22 — **🏁 D116 Phase C + D111 generic dispatch cycle CLOSURE**
  거대 multi-day cycle 의 종합 마감 narrative · @D d3+d4+d5 (project.tape
  governance) 본격 enforcement 달성:
  - **D116 Phase C — 4 sibling repos attested docs-only**:
    - hexa-bio (PR #1 · -155k LOC source · substrate 0)
    - hexa-rtsc (PR #7 · -14k · 1 straggler)
    - hexa-matter (PR #1 · -23.5k · 17.4K migration 100× estimate-off)
    - hexa-sscb (PR #1 · -2316 · 20/20 byte-matched)
    - 4 stdlib targets land: stdlib/bio (644 files) · stdlib/rtsc (142)
      · stdlib/matter (261) · stdlib/sscb (37+expansion)
    - **~155k LOC 사이드 substrate → hexa-lang 단일 canonical home**
      (@D d3 본격 enforcement · 첫 4 sibling 완성)
  - **D111 generic dispatch maturity**:
    - ActionDispatch.swift 1121 → 511 LOC (-610 · PR #11 default→cellrun
      + PR #13 6-domain + PR #15 chip+7 + PR #16 cleanup + PR #305 hook)
    - 18 도메인 .demi manifest · 25 .demi total (INDEX/PILOTS/등 포함)
    - matter+bio in-silico 4 verbs × 2 도메인 = 8 cells completed-form
      (rc=0 · PR #313 verb shims · D106 illustrative · absorbed=false g3)
    - 사용자 directive "특정 도메인 하드코딩 없어야" 90%+ 달성
  - **🚨 5 inadvertent wipes 모두 복구 (security crisis 통과)**:
    1. `88c00246` cellrun.hexa wipe → PR #272 restore
    2. `3a4282ec` structure.py wipe → PR #275
    3. `f221d2ba` 313-file clobber → merge restored
    4. `bf406f08` 307-file (ironic "wipe-guard keyword" commit) → PR #303
    5. `de1be840` **566-file + hook gut** (perf-scoreboard bundle) →
       PR #311 restore + hook activated (`core.hooksPath=.githooks`)
    - **PR #305 wipe-guard hook 3-tier hardening** (Tier 1 narrow ·
      Tier 2 tree-wide >50 files OR >5k lines · Tier 3 protected-subtree
      stdlib/<domain>/) · merge-commit skip · `restore`/`sunset`/
      `attestation` prefix escape
    - **C agent (sunset) STOP+report safety-constraint 가 wipe #5
      발견** · ground-truth verify pattern 작동 검증
    - **6 PRs safety-check round 가 5 BLOCKED + 1 CLOSED** (모두
      stale-base reverse-diff wipe trap · 325k-1.6M deletions 차단)
  - **session memory 저장 (cross-session 학습)**:
    - `project_hexa_lang_recurring_wipes` — attestation 전 ground-truth
      재확인 필수 · 5× 재발 패턴
    - `feedback_pointer_manifests_track_identity` — INDEX.demi /
      SUBSTRATE_LINKS.demi 는 identity 추적 · scripts 아님 · 재pointer
      금지 (Tier ② AGENTS.tape `@I` 위반)
  - **남은 owner territory follow-ups**:
    1. `de1be840` author 의도 audit (perf commit 안 substrate wipe 가
       accidental 인지)
    2. `.githooks/*` branch protection (같은 commit 에서 hook+content
       동시 변경 차단)
    3. CI-side mass-delete guard (server-enforced · local hook 우회
       차단)
    4. ~16 sibling repos attestation (codex 442 · brain 245 · cern 49
       · chip 153 · aura 45 · 등 · 각 multi-PR migration campaign 먼저)
    5. 5 BLOCKED PRs (#283 #264 #256 #249 #124) cherry-pick re-roll
       (commit SHA 보존됨)
    6. chip/cern/aura cellrun-wired domain 의 sibling substrate migration
       campaigns (multi-PR per domain)
    7. _python_bridge sunset retry (post-stable main · 3 LVAD port + 102
       file delete with `sunset` prefix · hook-safe)
    8. matter+bio shim → bio.demi manifest flip (substrate=python3
       activation · 별 cycle)
    9. chem in-silico shim (stdlib/chem 신설 + RDKit/Psi4 substrate ·
       hexa-chem empty)
    10. project.tape `@D` do/dont placeholder filling (cycle 시작 시
        identified · sample-row 들 채우기 · governance maturity)
  - **session 통계**:
    - 누적 PRs merged this session: ~30+ (SSCB walkthrough 10 + D116
      migrations + attestations + wipe restores + governance · 등)
    - LOC delta hexa-lang: +~180k migration · -~155k attestation =
      ~25k net positive (substrate consolidation)
    - LOC delta demiurge cockpit: -610 ActionDispatch + 4 typed records
      + 4 .demi manifests = net negative (D111 enforcement)
    - inbox/notes: 5 research artifacts (D114 audit · D116 inventory
      · attestation prep · wipe-governance proposal · 종합)

- 2026-05-22 — **κ-70 R9 G36 LANDED · D118 3rd cell pick (Ufo/plasma
  Stage-2) 5-fold lock-in · code 0 · R9 = 2/4 LANDED**. κ-69 G32 (D115)
  / κ-68 G27 (D109) 의 동형 mirror — pre-code decision gate. Research
  note `inbox/notes/2026-05-22-k70-horizon-candidate-research.md`
  (3 finalist · #1 ranked Ufo/plasma Stage-2 default 채택) 위 build:
  - **5-fold lock-in 박제**: cell = `UfoVerifyRecord` (1-field 확장 ·
    κ-69 G33 AuraVerifyRecord 1:1 mirror) + `domains/ufo.md` Stage-2
    sister-substrate fusion cross-link 경로 / external oracle =
    JET open-pulse archive mid-Ohmic single shot (n_e + T_e timeseries ·
    anonymous access) / bridge stack = (신설) `stdlib/fusion/jet_
    pulse_fetcher.py` → hexa-native `plasma_metrics_kernel.hexa`
    (`pilot-plasma_metrics` 41/41 PASS bit-exact substrate floor) /
    hexa-native scope = `plasma_metrics_kernel.hexa` · λ_D = sqrt(ε₀
    k_B T_e / (n_e e²)) axis (NRL Formulary p.34) / PASS criterion =
    `mean_rel_err ≤ 0.05` over N=50 JET pulse mid-Ohmic stationary
    timesteps (solar G29 / Aura G33 5% threshold mirror).
  - **Stage-4..7 D106 illustrative carve-out 명시 박제** — Ufo Stage-4
    (warp) / Stage-5 (wormhole) / Stage-6 (dim) / Stage-7 (use) 는
    D106 illustrative-physics gate 적용 · `MeasuredOracleRef` 적용
    불가 · 본 land 는 Stage-2 plasma diagnostic axis 만 · RFC 013
    §6.12 anti-conflation 유지. G37 시 `UfoVerifyRecord.scopeCaveats`
    array entry 박제 obligation (본 D118 의 cross-link gate).
  - **회피 후보 reject** (research note Candidate B/C 인용): Energy/
    wind = substrate kernel 신설 1-3 session cost (`power_curve_kernel.
    hexa` G31 mirror) + HSDS API token honesty floor weakness · Bio/
    ECG = `BioVerifyRecord.swift` 신설 ~40 line cost (lowest-friction
    principle 위반) + option (i)/(ii) bridge axis-match split 부담.
  - **prediction-shape honest disclosure** — 본 PASS = D117 (Aura
    G33) 의 *numeric-equivalence statement* shape (formula evaluation
    on real-measured inputs)와 동형 · D110 (solar G29) 의 *predict-
    vs-measure modeling-error-bounded statement* shape 아님. acceptable
    weakness — κ-69 closure entry 가 "κ-70+ prediction-axis elevate"
    path 를 follow-on horizon line 으로 cite.
  - **수정 파일 4개**: `design.md` (D118 entry 추가 · D117 직후 자연
    순서) · `ARCH.md` (§11.5 G36 row `[ ]` → `[x]` flip + D118 cite +
    research note cite · §11.3 head + §11.4 intro Round 9 G36 LANDED
    표면 갱신 · 본 Log entry) · `PLAN.md` (`## 진행 로그` κ-70 G36
    LANDED entry · D118 cite · R9 2/4 LANDED · next pickup = G37
    first-flip) · `NEXT_SESSIONS.md` (P-⑭ closure marker for G36 ·
    head refresh R9 1/4 → 2/4 LANDED).
  - **κ-70 R9 진척**: 4 G-item 중 G35 + G36 `[x]` (G35 = candidate-
    research note · G36 = D118 3rd cell pick). **G37 + G38 still
    `[ ]`** — G37 (3rd cell first-flip · `MeasuredOracleRef` field
    가 `UfoVerifyRecord` 에 land = third record-type instance · κ-68
    G29 / κ-69 G33 mirror · 1-3 session est) 이 다음 lowest-friction
    critical-path. G38 = R9 4/4 closure 박제.
  - g3 — G36 = doc-only land (code 0 · test 0 · 새 측정 0 · 새 stored
    field 0 · 새 `.demi` row 0 · 새 hexa-lang artifact 0) · 0.3
    session est_actual. Research note pre-existing (G35 LANDED same-
    cycle as horizon-opening) 가 본 cycle 의 decision rationale 의
    load-bearing audit trail — 본 D118 가 그 위 default 채택 path 의
    박제. RFC 013 §6.11 status `LANDED` 유지 (κ-68 closure 상태 ·
    κ-70 R9 는 same-invariant 의 third-instance generalization audit
    axis 라 RFC status 자체는 미flip).

- 2026-05-22 — **🎉🎉 κ-69 R8 4/4 CLOSURE + chip RTL + ActionDispatch
  generalization 동시 LAND** (3 axis same cycle):
  - **κ-69 R8 4/4 CLOSURE** (사용자 별 axis · `8402ed2`): G33 LANDED
    D117 2nd cell first-flip (Aura/EEG · PhysioNet Sleep-EDF ·
    `mean_rel_err 8.4e-07` vs threshold 0.05 · **7-orders-of-magnitude
    margin** · κ-68 G29 의 marginal 0.04967 보다 훨씬 honest).
    R8 grid (G31 G29-β + G32 + G33 + G34) 모두 4/4 wired · κ-69
    phase boundary 완전 마감.
  - **PR #10 LANDED** (`552060b6`): chip.demi 7-cell + 5 simple
    chip RTL (counter4 · pwm8 · uart_tx · crc8 · spi_master).
  - **PR #11 LANDED** (`9dacf30f`): ActionDispatch generic dispatch
    foundation · -73 LOC · default → cellrun route · 13 hardcoded
    cases 제거 (sscb 6 + firmware 7) · 3 dead statics 제거.
  - **남은 hardcoded**: 37 cases · 16+ legacy domains 잔존 · 각각
    per-domain D111 Phase C migration target (firmware 패턴 mirror).
  - **bio · chem 처리 방향 user 결정 territory** (3 옵션 brief):
    A 즉시 walkthrough · B D116 migration 선행 · **C hybrid (in-silico
    먼저 · wet-lab 후속 · recommended)**.

- 2026-05-22 — **🚨 D111 Phase C generalization directive 박제 ·
  "던지는 도메인마다 모든 과정에 특정 도메인에 맞춘 하드코딩이
  없어야 된다"** + firmware D111 Phase C reference closure (single
  PR · -380 LOC net · domains/firmware.demi 147 line · 7 ActionDispatch
  cases → cellrun route · 7 runFirmware*() removed · 7
  FirmwareDomainProducer.swift deleted · 7 Models/Firmware*Record
  preserved R3).
  - **target shape**: ActionDispatch.swift = **5-line generic
    dispatcher** · default → cellrun route · per-domain switch case
    0 · 모든 (verb, domain) 동일 path 통과 (`cellrun.hexa` +
    `<domain>.demi` manifest) · 도메인 추가 = manifest 1 file ·
    cockpit code 변경 0.
  - **firmware vs SSCB cost comparison** (D111 Phase C ideal proven):
    | metric | SSCB (from-scratch) | firmware (D111 Phase C) |
    |---|---|---|
    | PR count | 10 | **1** |
    | LOC delta | substantial + | **-380 net** |
    | session | multi-day cohort | **single** |
    | hexa-lang PRs | 6 (substrate scaffold) | **0** (already compat) |
    결론: 도메인이 substrate (`stdlib/<domain>/`) + typed records 이미
    가진 경우 D111 Phase C = single PR · single session · LOC net
    negative. SSCB-급 cost 는 from-scratch substrate 신설 시에만.
  - **next D111 Phase C candidates** (firmware audit recommendation):
    bot (3 producer) · scope (3) · energy (3 · G29 absorbed=true) ·
    chip (3 · κ-43 absorbed). 도메인 별 1 session × 16 도메인 =
    ~16 session 으로 D111 Phase C full closure 추정.
  - **generalization 본격 단계 (사용자 directive 의 핵심)**:
    1. ActionDispatch default → cellrun route 변경 (1-line · LLM
       placeholder 대신 CellrunDispatch.run · manifest 부재 시
       자동 honest-skip · 모든 도메인 즉시 cellrun route 통과)
    2. 22+ per-domain switch case 점진 제거 (manifest 있는 도메인
       부터 · legacy Producer.swift `git rm` 동시)
    3. runDomain*() static functions 제거
    4. ProducerRegistry alternatives → cellrun manifest 의
       `[cell.<verb>.<variant>]` section 흡수
    5. 결과: ActionDispatch = thin spawn wrapper (5 line) · 도메인
       별 hardcoded code 0
  - **5 simple chip walkthrough scaffold 동시 진행** (BG agent
    `a400949196e9eb016` · counter4 + pwm8 + uart_tx + crc8 +
    spi_master Verilog 5종 + chip.demi 7-cell manifest) — chip
    도메인 substrate 첫 land · D111 Phase C 대상.

- 2026-05-22 — **🎉 SSCB 7-verb walkthrough Step 4 LANDED · `(.handoff,
  "sscb")` cell wired · 7/7 wired · 0/7 unwired · 100% closure 달성 ·
  첫 도메인 cellrun 전체 wire** (specify + structure + design +
  analyze + synthesize + verify + handoff 모두 D111 generic dispatch
  route).
  - **hexa-lang PR #277** `79ccff44` MERGED — `stdlib/sscb/handoff.
    py` (**708 LOC**) · **7 artifacts**: `ul489i_checklist.md` (18
    items 4 sections) · `iec60947_2_typetest_dossier.md` (21 items
    6 §7.2.x sections) · `ieee_c37_x_xref.md` (7 items + 8-row
    table) · `tier2_fanout.md` (13 items · 5 cert-blocking) ·
    `bundle_manifest.md` (8 sections · sign-off blocks) ·
    `sscb_v1.meta.json` (D113 sibling 7-key measurements) ·
    `sscb_handoff_<stamp>.json` (record JSON).
  - **demiurge PR #8** `cb5de742` MERGED — `ActionDispatch.swift`
    `(.handoff, "sscb")` cellrun route + `Models/SscbHandoffRecord.
    swift` 124 LOC (Codable typed record · 7 measurement fields).
  - **end-to-end CLI verified**: `swift run DemiurgeCLI action
    handoff sscb` → gate=OPEN absorbed=false · payload.measurements
    7-key roll-up (ul489i_checklist_item_count=18 ·
    iec60947_2_checklist_item_count=21 · ieee_c37_x_reference_count
    =7 · tier2_fanout_item_count=13 · cert_blocking_count=5 ·
    bundle_artifact_count=5 · cert_bundle_ready=true).
  - **regression 0**: swift test 74/74 PASS.
  - **R3 compliance**: substrate (handoff.py 708 LOC algorithm +
    cert dossier template + standards cross-ref) = hexa-lang only
    · cockpit = typed record + 1 dispatch case · D114/D116 유지.
  - **🏆 milestone**: **SSCB = 첫 도메인 7/7 cellrun-wired closure**
    under D111/D114/D116 doctrine. 누적 walkthrough PRs **10**:
    - hexa-lang 6: #271 (specify) · #272 (cellrun restore) · #273
      (structure) · #274 (design) · #275 (structure 2차 restore
      · 2 inadvertent wipes 패턴) · #277 (handoff)
    - demiurge 4: #5 · #6 · #7 · #8 (cockpit dispatch cases)
  - **post-walkthrough next**:
    1. **ARCH §11 worked simulation `sscb-mk1` 추가** (§11.1 alien-
       disc-mk1 · §11.2 aura-clip-mk1 패턴 mirror) — 첫 7/7
       cellrun-wired domain 의 end-to-end script demonstration.
    2. **다른 도메인 동일 pattern 적용** (brain · aura 등 · 현재
       `.analyze` 만 wired in ActionDispatch · Step 1-4 mirror
       으로 점진 closure).
    3. **D111 Phase C: legacy SSCB*Producer.swift deprecation/
       removal** (cellrun route 와 dual-existence · roundtrip
       verify 후 legacy 제거).
  - **walkthrough 안 발견된 2 inadvertent wipes** (repo-wide audit
    필요): cellrun.hexa (`88c00246` RFC067 N74) + structure.py
    (`3a4282ec` runtime restore) · 둘 다 hexa-lang sibling-agent
    restore commits 의 silent mass-delete · 별 cycle 에 audit +
    commit-hook tighten ratify 권장.

- 2026-05-22 — **SSCB 7-verb walkthrough Step 3 LANDED · `(.design,
  "sscb")` cell wired · 6 wired / 1 unwired** (design 마감 · 다음
  Step 4 = handoff verb · LAST). 같은 cycle 안 2번째 inadvertent
  deletion 발견 + closure:
  - **hexa-lang PR #274** `1030bcaa` MERGED — `stdlib/sscb/design.
    py` (**592 LOC** · Python 3.10+ stdlib-only) · 5 artifacts
    emit:
    - `sscb_design_v1.cir` (ngspice transient netlist · `.title` +
      `.MODEL VDMOS_SIC` + `.TRAN 1n 5u` + `.END` · well-formed)
    - `sscb_design_v1.netlist.kicad_pcb_stub` (textual KiCad-like
      sketch · NOT loadable .kicad_pcb · Tier-2 future)
    - `sscb_design_v1.dossier.md` (10-section human narrative)
    - `sscb_v1.meta.json` (D113 sibling · `measurements{}` +
      `datasheet_bindings[]`)
    - `sscb_design_<stamp>.json` (top-level record · Codable mirror)
    Netlist metrics: **node_count=15** · **element_count=14** · 6
    datasheet placeholder bindings (Wolfspeed C3M0021120K · IXYS
    IXDD609SI · rule-of-thumb RC snubber + TVS · FEMMT 1.118µH
    coupled inductor · 0.05°C/W cold plate · 3mΩ/segment busbars).
    `simulation_ready=true`.
  - **demiurge PR #7** `3ae9b30` MERGED — `ActionDispatch.swift`
    `(.design, "sscb")` cellrun route 1 case (+9 line incl. comment)
    + `Models/SscbDesignRecord.swift` **118 LOC** (Codable +
    Equatable + Sendable · snake_case CodingKeys · 10 scalar +
    artifacts list fields).
  - **end-to-end CLI dispatch verified**: `swift run DemiurgeCLI
    action design sscb` → `[cellrun] record → exports/sscb/design/
    <TS>/sscb_design_record_<TS>.json · gate=OPEN absorbed=false ·
    caveats=2 · payload.measurements` 4 D113 keys 모두 (node_count
    =15 · element_count=14 · datasheet_bound_count=6 · placeholder_
    remaining_count=6).
  - **regression**: swift test **74/74 PASS** · 0 회귀.
  - **R3 compliance**: substrate = hexa-lang (`stdlib/sscb/design.
    py` 592 LOC algorithm + netlist templates + datasheet binding
    table) · cockpit = typed record (118 LOC) + thin dispatch
    (1 case) only. D114/D116 invariant 유지.
  - **⚠️ 2nd inadvertent wipe discovered + restored** (cellrun.hexa
    wipe via RFC067 N74 commit · 그 다음 structure.py wipe via
    runtime restore commit · 패턴 동일): hexa-lang commit
    `3a4282ec restore(stdlib/runtime): re-land cycles 93-96 wiped
    by c39afbbe deploy-regen` 이 `stdlib/sscb/structure.py` 도
    silent mass-delete. Step 2 LANDED 상태 였지만 hexa-lang main
    에서 사라짐. **PR #275** `034ec625` MERGED — `864a6aa3^..
    864a6aa3` 에서 verbatim restore (516 LOC · 단일 squash
    commit). 동일 wipe-and-restore pattern (PR #272 cellrun
    restore 와 같은 시그니처) · 별 audit 사이클에 repo-wide audit
    필요 (사이드 agent 의 runtime restore 가 unrelated files
    mass-delete · 의도 vs accidental).
  - **doctrinal 영향 없음**: design.md D-blocks · ARCH §0/§4.4/
    §4.5 · R3 narrative 모두 유지. cockpit + hexa-lang Step 2/3
    artifacts 모두 main 에 정착 (PR #271 specify · PR #273+#275
    structure · PR #274 design · PR #5/#6/#7 cockpit). 6 wired /
    1 unwired (handoff 만 남음).
  - **Step 4 readiness (handoff verb · LAST)**: 동일 pattern ·
    `stdlib/sscb/handoff.py` (cert-dossier bundle producer · UL
    489I lab-booking artefacts · IEC 60947-2 type-test checklist
    · IEEE C37.x cross-reference · Tier-2 fan-out list collected
    from Steps 1-3 record JSONs) + `SscbHandoffRecord.swift` +
    ActionDispatch `(.handoff, "sscb")` case. 7-verb 100% closure
    예상.
- 2026-05-22 — **SSCB 7-verb walkthrough Step 2 LANDED · `(.structure,
  "sscb")` cell wired · 5 wired / 2 unwired** (structure 마감 · 다음
  Step 3 = design verb). 2-PR pattern · cellrun route (PR #272 restore
  덕분에 main cellrun.hexa 정착 후 첫 clean step):
  - **hexa-lang PR #273** `864a6aa3` MERGED — `stdlib/sscb/structure.
    py` (**516 LOC** · networkx 3.2.1 DiGraph + dict-of-lists
    graceful fallback) · sscb.md §1+§2 ARCHITECT 의 BOM topology
    structural inventory · **9 nodes / 17 edges / 5 categories**
    (enclosure root → SiC switch stack + 3 busbars (power_path) +
    gate driver + snubber (control) + magnetic limiter (commutation)
    + cold plate (thermal)) · edge types (signal/power/thermal/
    mechanical) · 4 artifacts emit (`sscb_v1.meta.json` D113 roll-up
    호환 + `bom_graph.json` 전체 graph + `bom_dossier.md` human-
    readable + record JSON).
  - **demiurge PR #6** `d96f3e28` MERGED — `ActionDispatch.swift`
    `(.structure, "sscb")` cellrun route 1 case (CellrunDispatch
    호출) + `Models/SscbStructureRecord.swift` **91 LOC** (Codable
    + Equatable + Sendable · snake_case CodingKeys · 5 fields
    `bomNodeCount`/`bomEdgeCount`/`categories`/`placeholders`/`notes`
    + sibling pointer `bomGraphFile`).
  - **end-to-end CLI dispatch verified** (post-merge clean ·
    HEXA_CELLRUN_CELLRUN_PATH 환경변수 override 불필요 since
    cellrun.hexa back on hexa-lang main `56cd5c41`):
    `swift run DemiurgeCLI action structure sscb` → `[cellrun]
    record → exports/sscb/structure/<TS>/sscb_structure_record_
    <TS>.json · gate=OPEN absorbed=false · payload.measurements`
    roll-up correct (`bom_node_count=9` · `bom_edge_count=17` ·
    `categories_count=5` · `placeholders_count=9`).
  - **regression**: swift test **74/74 PASS** (Step 1 SscbSpecify
    Record + Step 2 SscbStructureRecord 추가 후 · 69 → 74 · +5
    test) · 0 회귀.
  - **R3 compliance**: substrate = hexa-lang only (`stdlib/sscb/
    structure.py` 516 LOC algorithm + BOM data) · cockpit = typed
    record (91 LOC Codable) + thin dispatch (1 line ActionDispatch
    case) only · algorithm-shaped code 0 in cockpit/. D114/D116
    invariant 유지.
  - **D113 payload flattening verify**: producer's sibling `sscb_
    v1.meta.json::measurements{}` block 이 cellrun envelope `payload.
    measurements` top-level 로 roll-up · downstream consumer
    (cockpit chat panel · RTSC view3D 등) 자동 read 가능 ·
    sibling .meta.json source-of-truth 보존 (g3 honest).
  - **Step 1 (specify) main merge 도 같은 cycle 안 paired** —
    PR #5 (cockpit ActionDispatch specify + SscbSpecifyRecord)
    `15f24d63` MERGED (Step 2 merge 와 같은 순간에 admin-squash).
    Step 1 narrative 의 "PR #5 already MERGED" claim 가 사실은
    Step 2 직전 시점까지 OPEN 이었음 — agent 가 정직 catch.
  - **Step 3 readiness (design verb)**: 동일 pattern · KiCad 정도
    PCB netlist + ngspice .net (sscb.md §2 DESIGN row 의 open-
    source col) · structure 의 `bom_graph.json` 이 input feed
    candidate (BOM placeholders 가 datasheet binding 으로 resolve
    되어 ngspice .net 으로) · est 1 session · ~200-350 LOC ·
    절제된 template netlist (absorbed=false g3 · 실 transient 은
    analyze/verify cell).
- 2026-05-22 — **SSCB 7-verb walkthrough Step 1 LANDED · `(.specify,
  "sscb")` cell wired via cellrun · 3 wired → 4 wired · 4 unwired
  → 3 unwired** (specify 마감 · structure/design/handoff 다음 Step
  2/3/4). 사용자 directive "프로젝트 생성 → 7-verb 단계별 / 하나하나
  진행" + Path A only (CLI simulate · hexa-lang substrate 신설 +
  demiurge ActionDispatch case 추가). 3-PR 동시 land:
  - **hexa-lang PR #272** `56cd5c41` MERGED — cellrun.hexa +
    cellrun_test.hexa restore (RFC067 N74 commit `88c00246` 가
    main 에서 inadvertent 삭제 · branch `cellrun-generic-dispatcher-
    scaffold@21d98d43` 에 보존되어 있던 4-commit chain (scaffold +
    bug#1 _split_csv + bug#3 python_candidates + D113 payload
    flattening) 단일 squash-restore · selftest 45/45 PASS).
  - **hexa-lang PR #271** `70a2ba83` MERGED — `stdlib/sscb/specify.
    py` (265 LOC · firmware-stub pattern · domains/sscb.md §1
    HEXA-SSCB mk1 spec source-of-truth 을 JSON record 로 emit ·
    `SSCB_SPECIFY_RESULT <json>` stderr marker · sibling
    `sscb_v1.meta.json` measurements{} block (D113 roll-up 호환) ·
    artifact 3종 (meta.json + spec_dossier.md + record JSON)).
  - **demiurge PR #5** MERGED — cockpit `ActionDispatch.swift`
    `(.specify, "sscb")` 새 case (CellrunDispatch.run("sscb",
    "specify") route) + `Models/SscbSpecifyRecord.swift` 신설
    (~90 LOC · Codable + Equatable + Sendable · snake_case
    CodingKeys · 10 SSCB spec fields).
  - **end-to-end CLI dispatch verified**: `swift run DemiurgeCLI
    action specify sscb` → `[cellrun] record → exports/sscb/
    specify/<TS>/sscb_specify_record_<TS>.json · gate=OPEN
    absorbed=false caveats=2 · 📸 new record ID(s): sscb_specify_
    record_20260521T145642Z`. cellrun + manifest + script + emit
    + record decode 전 chain 동작.
  - **regression**: swift test 69/69 PASS · 0 회귀. cockpit build
    16.42s clean.
  - **R3 compliance**: substrate script (`stdlib/sscb/specify.py`)
    = hexa-lang only · cockpit Swift = typed record (`SscbSpecify
    Record`) + thin dispatch (CellrunDispatch route 1 line) only ·
    algorithm-shaped code 0 in cockpit/. D114/D116 invariants 유지.
  - **doctrinal-side concurrent shift**: 같은 cycle 안 사용자 가
    `.specify/` (Spec Kit framework) + `.claude/skills/speckit-*`
    skills 전체 제거 + project.tape SSOT 도입 (`@V` tape v1.2 ·
    `@I` demiurge identity · `@D` governance placeholder do/dont
    ·CLAUDE.md → project.tape symlink for SessionStart auto-load).
    R1-R4 governance rows (constitution.md 안) 함께 archive — 다만
    design.md D-blocks 124개 (D114 R3 enforcement · D116 sibling-
    repos doc-only) 와 ARCH §0 / §4.4 / §4.5 narrative 그대로
    유지 (doctrinal authority 는 design.md + ARCH 가 carry).
    R-row doctrinal 내용 (typed-enforcement anchor) 은 향후
    project.tape `@D` events 으로 migrate 가능 · 또는 D-block
    가 단독 SSOT 로 유지 — 사용자 결정.
  - **Step 2 (structure verb) readiness**: 동일 pattern 으로 진행
    가능 (hexa-lang `stdlib/sscb/structure.py` + demiurge
    `(.structure, "sscb")` ActionDispatch case + `SscbStructureRecord
    .swift`). BOM content per sscb.demi: SiC switch · gate driver
    · snubber · busbar · enclosure · networkx component-graph
    candidate. est ~1 session.
- 2026-05-21 — **D116 ratified · sibling repos = 문서만 · D14/D17/D77
  amendment · 실수 방지 cascade across spec kit**. 사용자 직접 지시
  "hexa-rtsc 는 문서만 놔둘꺼야 / hexa-lang, demiurge 가 필요한거
  각각 나눠서 보관하면 되 코드 / spec kit 에도 반드시 기록 / 실수
  방지" + AskUser 해석 A (모든 sibling repos 문서만) — D116 ratify.
  6-file cascade 단일 commit:
  - **design.md D116** (80 line · sibling repos doc-only · D14/D17/
    D77 amendment · 4-repo enforcement boundary table · Phase A/B/C/D
    exit · rejected alternatives 명시)
  - **constitution R3** boundary table 3-column 확장 (`cockpit/Sources/`
    × `hexa-lang/stdlib/` × sibling repos) · sibling repos 컬럼 추가
    with NO/NO/OK domain narrative · semver **1.4.0 → 1.4.1 PATCH**
    (Amendment history block entry)
  - **`.specify/README.md`** D114/D116 section (3-column boundary
    table 도식 · 4 anti-pattern catalog "🛑 실수 방지" 명시 — hexa-
    rtsc/verify/ 추천 #1 · Producer.swift 신설 #2 · cockpit/scripts/
    Python #3 · Dispatch class 안 algorithm #4)
  - **`.specify/templates/spec-template.md`** Assumptions section
    D114/D116 prompt 추가 (per-spec auto-prompt · 신규 feature spec
    이 sibling repo 에 코드 추천하는 실수 방지)
  - **ARCH §0** first principle narrative refresh (sibling repos
    부분 "transitional pointers (bridges)" → "domain narrative only
    (markdown · physics derivation · spec · citation index) — no
    code per D116 amendment")
  - **ARCH §4.4** sibling repos section full refresh (D116 정착 ·
    `hexa-rtsc` 추가 · 4-repo doc-only role · Phase B/C migration
    scope · current 4 algorithm files in hexa-rtsc/verify/ → hexa-
    lang/stdlib/<domain>/ 이전 대상 명시)
  - **ARCH §4.5** cross-link D114 + D116 추가
  - **audit note correction** (inbox/notes/2026-05-21-d114-phaseb-
    material-falsifier-audit.md): MaterialFalsifier 273-LOC algorithm
    destination `~/core/hexa-rtsc/verify/falsifier_dispatch.hexa`
    → `~/core/hexa-lang/stdlib/rtsc/falsifier_dispatch.hexa` 정정
  - **trigger artifact**: Phase B MaterialFalsifier audit agent 가
    `~/core/hexa-rtsc/verify/` 를 destination 으로 추천 — D116
    명문화 이전이라 가능했던 실수. 본 cycle 의 doctrinal lock 이
    미래 동일 패턴 영구 방지.
  - **D-numbering 정리**: G32 = D115 (reserved stub 유지) · D116 =
    sibling repos amendment (이 cycle) · 향후 G32 land 시 D115 replace
    → G33 등은 D117 onwards.
  - **next cycle (Phase B/C)**: sibling repo 4-repo 의 현 substrate
    code inventory + hexa-lang stdlib/<domain>/ 이전 plan (multi-
    cycle · 6-12 session est).
- 2026-05-21 — **D114 stdlib SSOT enforcement ratified · constitution
  R3 (1.2.2 → 1.3.0 MINOR) 신설 · §11.4 G32 D-number shift D114 →
  D115**. 사용자 직접 지시 "모두 hexa-lang 보관 / SSOT 말이야 /
  stdlib 말이야" (post-D113 land) — Phase B PR #3 OPEN 후 발견된
  `MaterialFalsifierDispatch.swift` 438 line in cockpit/Sources/ 가
  trigger artifact. Constitution Principle I + D14/D18/D111/D80
  의 specific enforcement axis 명문화.
  - **D114 picked**: 모든 stdlib code (substrate algorithms · 커널
    · 수학 · validation logic · physics) SSOT = hexa-lang (또는
    sibling `hexa-matter`/`hexa-bio`/`hexa-chem`). demiurge
    `cockpit/Sources/` 에 typed records · UI · thin dispatch
    wrappers · CLI presentation 만 허용 · algorithm-shaped code =
    anti-pattern · hexa-lang 이전 의무.
  - **R3 governance row** (constitution 1.3.0 MINOR): code-shape
    boundary table (typed records OK · UI OK · thin dispatch OK
    transitional · CLI OK · domain manifests OK · algorithm NO ·
    Python scripts under cockpit/scripts/ NO). transitional bridge
    carve-out (`*Producer.swift` 46 잔존 · D111 Phase C 15-20
    session migration) · UI carve-out (macOS-native UI Tier-2
    별 axis · wilson harness 가 future).
  - **enforcement boundary** explicit (R3 + D114 §):
    - ✅ typed Codable records · SwiftUI views · thin dispatch
      wrappers · DemiurgeCLI · `.demi` manifests
    - 🔴 algorithm code in cockpit/Sources/ · Python scripts in
      cockpit/scripts/ (`bipv_freecad.py` D61 violator 1개 잔존)
  - **D115 stub (G32 reservation)**: D-numbering sequence shift
    (D111 morning → D112+D113 afternoon → D114 R3 → G32 = D115).
    G32 user decision territory · `inbox/notes/k69-g32-candidate-
    research-2026-05-21.md` (Aura/EEG #1) ready.
  - **Phase A 완료 (본 commit)**: D114 ratification + R3 row + ARCH
    update · doctrinal land 즉시.
  - **Phase B/C next-cycle**:
    - B: MaterialFalsifierDispatch.swift 438-line audit (algorithm
      vs orchestration ratio · 알고리즘 portion hexa-lang 이전
      D-block 으로 ratify · 다음 cycle audit inbox note)
    - C: `cockpit/scripts/bipv_freecad.py` migration
      (`~/core/hexa-lang/stdlib/component/` 으로 이전 · D61
      violator 1개 잔존 closure · 1-2 session est)
    - D (Tier-2 deferred): static-analysis hook 가 cockpit/Sources/
      에 algorithm-shaped code 진입 시 swift build 실패 트리거 ·
      typed-enforce 자동화 · 별 cycle
- 2026-05-21 — **D112 + D113 ratified · Phase B bug #2 (Verb canonical
  Korean → English wire) + payload flattening 결정 박제 · §11.4 G32
  D-number reference shift (D112 → D114)**. Phase B agent 의 design
  note (`inbox/notes/2026-05-21-d111-phaseb-bug2-verb-naming-options.
  md` 353 line · α 추천) + Phase B post-mortem 의 payload flattening
  open question 둘 다 doctrinal 로 명문화.
  - **D112 = bug #2 closure** (Verb.canonical 의미를 English wire form
    으로 변경 · `koreanLabel` 신규 computed property · naming convention
    A picked over B). Rationale: `.demi` manifests + hexa stdlib + Swift
    enum case names 모두 이미 English · `canonical = wire form` software
    idiom · Wilson Principle 1 ai-native. zero-implementation core
    (`String(describing:)` 가 이미 영어 case name 반환) · real work =
    13 display caller redirect. exit Phase A..E (Verb.swift refactor +
    new koreanLabel + 17 caller audit + CellrunDispatch.englishName()
    helper 제거 + swift test PASS). est 1 session 40 LOC.
  - **D113 = payload flattening** (cellrun envelope 가 sibling
    `<basename>.meta.json::measurements` block 을 `payload.measurements`
    top-level 로 roll up · sibling .meta.json 그대로 keep · g3 honest
    disclosure 유지 · `payload.measurements_source` field 가 provenance
    cite). Rationale: downstream consumer (cockpit chat panel · RTSC
    view3D 등) legacy producer 의 top-level measurements 패턴 가정 ·
    Phase C 의 46-cell migration 이 consumer regression 없이 진행 ·
    flattening scope = measurements only (full meta copy 아님). exit
    Phase A..D + selftest T10/T11. est 0.3-0.5 session.
  - **§11.4 G32 D-number shift**: G32 (다음 cell pick · κ-69 R8 user
    decision territory) 가 design.md D112 reserved 였음 · D111 시점에
    D112 로 이미 shift · 본 D112+D113 land 로 다시 **D114** 로 shift
    (2 ARCH §11.4 refs 정정 · §4.5 cross-link line 444 의 D112 는
    실수 sweep 흔적 · D111 cellrun 으로 정정).
  - **next exec step**: PR #267 (cellrun scaffold · bug #1 + #3 fix
    already in) 가 review-mergeable · D112 의 Phase A..E 와 D113 의
    cellrun.hexa payload roll-up impl 가 next cycle execution territory
    (별 commit cycle).
  - **provenance**: 사용자 "모두 완성도 기준진행" 지시 + Phase B
    agent 의 α 추천 + payload open question 둘 다 본 D-block 으로
    closure.
- 2026-05-21 — **D111 estimate honest correction · 10-17 → 15-20
  session per Phase B step 3 observed cost** (3-SSOT synchronized
  update · 본 entry = ARCH side anchor). D111 ratification 같은
  날 morning (commit `24e5179` design.md + ARCH §4.5 · `29227c3`
  constitution R2 1.2.0) 에서 10-17 session desk estimate 으로
  ratify 했으나, 같은 날 저녁 Phase B agent 의 실측 데이터로
  envelope 보정:
  - **observed cost (Phase B step 3 · branch `d111-phaseb-sscb-
    migration` · PR #267 OPEN · 직전 commit `deffc92`)**: 3 sscb
    cells (6.5% of 46 producer · sscb wired 3/7) ≈ 1시간 focused
    work · 환산 = **20 min/cell** (원본 12 min/cell estimate
    의 3×). 46-producer 풀 migration 외삽 = **15-20 시간 focused
    work**.
  - **overhead source**: format-mismatch fixup · Verb Korean→
    English mapping · Python version debug · payload-flattening
    결정 — manifest-driven dispatch invariant 들이 실측 시
    surface (desk estimate 가 missed).
  - **Phase A bug fixes in flight** (concurrent agent · hexa-
    lang 측): cellrun.hexa `_split_csv` quoted-comma · Verb.
    canonical Korean drift · python candidate list · PR #267
    update 진행 중. 이 fix 후 future per-cell cost 감소 예상
    이지만 **20 min figure 자체가 이미 일부 recovery overhead
    흡수** → 큰 추가 감소 기대 안 함 (정직한 envelope 유지).
  - **3-SSOT synchronized**:
    - design.md D111 `**est total**:` block — 10-17 session
      narrative 유지 + 직후 "honest correction" sub-block 추가
      (15-20 session 정직 envelope · observed cost provenance ·
      Phase A bug-fix 기대 효과 명시).
    - ARCH §4.5 Migration path block — `10-17 session est` →
      `15-20 session est` (Phase C `5-10` → `8-13` per 실측 외삽)
      · Phase B observed cost callout 추가.
    - `.specify/memory/constitution.md` R2 Migration cost row —
      `6-8 focused sessions` → `15-20 focused sessions` · semver
      **1.2.0 → 1.2.1** (PATCH · wording-only correction · no new
      principle/section) · Last Amended 2026-05-21 유지 (same-day
      correction).
    - 본 Log entry (ARCH side anchor) — 3-SSOT synchronization
      narrative + Log line 2026-05-21 D111 ratification entry
      안 `[superseded ...]` inline pointer.
  - **g3 honest disclosure 적용**: morning estimate 가 wrong 이었
    음을 동일 day 안에 정직히 record · NO retro-edit of original
    narrative (D111 ratification entry 본문 보존 · superseded
    pointer 만 inline 추가). principle V (no over-claim · measured
    before claimed) 의 cost-estimate axis 적용 first instance.
  - **provenance chain**: Phase B agent observed (deffc92) →
    user invoked 3-SSOT correction task → 본 commit (design.md
    + ARCH.md + constitution.md 3 file · explicit `git add`).
- 2026-05-21 — **`f4defee` surprise-rider audit · material-falsifier
  axis narrative bracket** (retrospective · 15-file rider on a
  2-file-intended commit · 1852 line ride-along · ARCH/§2 DAG &
  §11.4 G-items intentionally unchanged · this entry IS the
  narrative anchor the rider lacked at push time). The push-titled
  commit `f4defee` (`docs(inbox): yosys-stat measurement note →
  INDEX (37 entries ...)`) intended to commit two files
  (`inbox/INDEX.md` + the κ-69 substrate-axis yosys-stat note) but
  swept up **13 pre-staged files** from a prior session's work — a
  coherent **RTSC.md §8.7 Tier 4 material-falsifier** feature
  drop. Honest framing: the code was correct, the rider was a
  staging-hygiene miss, **NOT** a content miss. Files in the
  rider (axis identification):
  - **Loader (1 · Tier 4 dispatcher)**:
    `cockpit/Sources/DemiurgeCore/Loaders/MaterialFalsifierDispatch.swift`
    (438 line) — consumes (Tier 1 ConductorRecord · Tier 2
    SynthesisRecipeRecord · Tier 3 MeasurementRecord[]) triple,
    emits MaterialVerdictRecord scoring 6 falsifiers
    (F-RTSC-{1,2,3} + F-SC-{1,2,3}) per RTSC.md §8.4 9-test
    characterization matrix. g3 honest stance baked in:
    dispatching-succeeded ≠ falsifier-passed ·
    `absorbed=false` ALWAYS even on `aggregateVerdict=PASSES-ALL`
    · `replicatedByIndependentLabs` carried forward NEVER
    auto-incremented · missing input ⇒ `SKIPPED-MISSING-INPUT`
    NEVER fabricated PASS.
  - **Models (5 · 4-tier record schemas)**:
    `ConductorMaterial.swift` (77) ·
    `ConductorRecord.swift` (110 · Tier 1 material→device handoff
    · `claimOnlyHypothetical` family forced `absorbed=false` forever +
    `gate_type="empirically-unproven"`; renamed 2026-05-22 aggressive
    LK-99 scrub from `lk99Hypothetical`) ·
    `SynthesisRecipeRecord.swift` (104 · Tier 2 recipe) ·
    `MeasurementRecord.swift` (159 · Tier 3 measurement) ·
    `MaterialVerdictRecord.swift` (154 · Tier 4 verdict).
  - **Tests (1)**: `MaterialFalsifierDispatchTests.swift` (130
    line · DemiurgeCoreTests).
  - **Exports (5 · seed fixtures · live JSON)**:
    `exports/conductor/rebco_hts_baseline.json` (REBCO 2G HTS
    baseline · SuperPower-class Tc=92K · `absorbed=false` first
    ingest per §8.5) ·
    [historic seed recipe — deleted 2026-05-22 in aggressive scrub
    pass; see `inbox/notes/2026-05-22-lk99-final-scrub.md`] ·
    `exports/measurement/jc_b_theta/superpower_2g_baseline.json`
    (Jc(B,θ) baseline) ·
    `exports/measurement/2026-05-21T08-58-24Z.json` (stamped
    measurement instance) ·
    [historic Tier 4 dispatch verdict — deleted 2026-05-22 with the
    seed recipe above; XCTest now uses a synthetic claim-only fixture
    via `makeClaimOnlyRecipe()`].
  - **Inbox note (1 · detail SSOT)**:
    `inbox/notes/2026-05-21-pool-gate_v3-abc-diagnosis.md` (59
    line) — orthogonal `chip` axis · pool cross-platform
    re-execution diagnosed `/tmp/gate_v3` BLIF emitter bug
    (multi-output sky130 cell fanin + net-node fanin invariant)
    NOT a macOS abc issue. Not part of this material-falsifier
    drop; the file rode along under the same staging-hygiene
    miss. INDEX entry added in same commit as this audit (Phase
    C).
  **Axis identification**: The 14 feature files (loader + 5
  models + 1 test + 5 exports + 1 inbox note for pool-gate is
  separate) implement the **rtsc/material domain** verb cell
  `falsify` (= 7-verb spine §3 · "verify" verb specialized to
  material-side falsifier dispatch per RTSC.md §8.7 Tier 4).
  Domain placement per §2: **rtsc** (foundation level · sibling
  `hexa-rtsc` is the producer per the file's own header
  comments) with cross-edges to **matter** (conductor compound
  · `rebco_hts_baseline`) and **chem** (synthesis recipe ·
  historical claim-only seed recipe, deleted 2026-05-22). The §2 DAG
  is **unchanged** — these are
  verb-cell implementations, not new domain nodes/edges. The
  §7 records-gates-honesty contract is the load-bearing axis
  here: every new record obeys `absorbed=false` until
  cross-lab attestation · `measurement_gate` stays GATE_OPEN
  on Tier 4 dispatch alone · explicit `SKIPPED-MISSING-INPUT`
  rather than fabricated PASS. **§11.4 G-items unchanged**:
  this drop is NOT a κ-69 R8 G-item (G31..G34 are
  substrate-axis · chip §B); it's an independent records-axis
  cell-flip-prep drop with its own (not-yet-filed) D-block.
  **§12 unchanged**: §12 is substrate-axis (chip · yosys ·
  hexa-lang), this is records-axis (cockpit · RTSC §8). The
  prior commit's title remains correct for its 2 intended
  files; this entry brackets the other 13 files retroactively.
  Lesson re-anchored (echoing the (kk)/(ll) staging-hygiene
  thread): `git status --short` BEFORE `git add` · explicit
  paths only · `git add -A` and bare `git commit` are the
  rider-attractors. **No code modified in this entry — pure
  narrative anchor; the rider files have been on
  `origin/main` since `f4defee` push and remain there
  unchanged**. Detail SSOT for pool-gate axis (orthogonal):
  `inbox/notes/2026-05-21-pool-gate_v3-abc-diagnosis.md` (added
  to INDEX in same audit commit).

- 2026-05-21 — **§12.1 (b) `[~]` → `[x]` LANDED · PR #255 abc_map
  honesty MERGED `e4f79e26` post-Option-I rebase clean** (cross-repo
  bracket close · Tier-1 (b) own-scope CLOSED). hexa-lang PR #255
  (`rfc006-yosys-abc-map-honest` · base e149900f) had a single
  test-section conflict with Option I (`df4ff3f7`, MERGED earlier
  this session) — both edits added a `T8` test to `abc_map.hexa`'s
  selftest `main()`. Conflict resolution: keep BOTH test blocks ·
  PR #255's `T8` (stale `_out.blif` truncate guard) + `T9` (stdout
  `combinational loop` pattern source invariant) **renumbered to
  T9/T10** since Option I's T8 (multi-bit `.latch` expansion) is
  semantically the load-bearing Option-I assertion. abc_map function
  body untouched — PR #255's truncate-before-exec (L511) +
  `combinational loop` pattern (L569) and Option I's BLIF emit
  (L300+) + reader (L450+) are in different functions with zero
  semantic overlap. Post-merge selftest **10/10 PASS** (Option I T8
  + PR #255 T9/T10 + prior T0..T7f). Chain integration (gate_record)
  was killed by SIGKILL=9 (OS load avg 122 from concurrent agent
  worktrees · documented memory-shared-worktree pressure pattern) —
  NOT a regression in the merge; the abc_map selftest exercises the
  exact code paths PR #255 added and passes cleanly. Force-pushed
  merge commit `5a047010` to PR branch → CLEAN/MERGEABLE → squash-
  merged via `gh pr merge 255 --squash --delete-branch` (no `--admin`
  needed · CI not gating). §12.1 Tier-1 status: (0)..(a) ✓ · **(b) ✓**
  · (c) ✓ · (d) ✓ · (e) ✓ · (f)(g) `[~]` PARTIAL · (h)(i) `[ ]`.
  Worktree `/Users/ghost/core/hexa-lang-pr255` cleaned up post-merge.

- 2026-05-21 — **§12.1 (f) + (g) `[ ]` → `[~]` PARTIAL-LAND flip ·
  SSOT (kk) → (ll) honesty REDUX · Option F = Option I idempotent ·
  79 % substrate-axis gap closure verified by fresh chain rerun**
  (demiurge-side narrative-only commit · ARCH §12.1 (f)+(g)
  partial-land + SSOT detail handoff entry (ll) appended · NO
  hexa-lang code commit produced this cycle). post-(kk) Option F
  agent dispatched against `~/core/hexa-lang/stdlib/kernels/logic_
  synth/abc_map.hexa` L300-310 to implement multi-bit `.latch`
  emit-time expansion; agent discovered Option F is **IDEMPOTENT**
  with Option I — the 1:1 per-`.latch` reader expansion is already
  shipped in (ii) `df4ff3f7`'s `abc_parse_mapped_blif` half (L470-
  479). No new commit produced; the Option F worktree `~/core/hexa-
  lang-optf` (branch `rfc006-yosys-option-f-blif-latch-multibit-
  expansion` · local-only · never pushed) is to be removed in this
  same cycle (demiurge-side cleanup · safe per Option F agent's
  report · no force-push / no destructive remote op).
  - **measurement ping-pong reconciliation**: (ii)'s commit-body
    projection (1207→32829 / 1678→45937 µm²) was VINDICATED by
    fresh chain rerun. (kk)'s revert to 1207.41 / 1677.86 µm² was
    based on stale /tmp BLIFs that pre-dated Option I's reader-half
    caching — a measurement pipeline artifact, not a code
    regression. (kk) preserved as historical record; (ll)
    supersedes (kk)'s Tier-1 marker correction. yosys-stat
    measurement note `inbox/notes/k69-substrate-axis-yosys-stat-
    measurement-2026-05-21.md` (untracked · 276 lines) had a
    stale-cache reading at filing time; its algebraic projections
    (79 % sequential / 20 % combinational gap split · 99.3 %
    flop-count axis closure) remain useful audit material. NOT
    blamed · just recorded for audit-trail continuity.
  - **chain measurement** (`hexa run stdlib/yosys/gate_record.hexa`
    from clean worktree · 2026-05-21 KST · Option F agent
    authoritative):
    - router_d4 = **32,829 µm²** (oracle 61,762.99 · Δ **46.85 %**)
    - router_d6 = **45,936.6 µm²** (oracle 93,608.53 · Δ **50.93 %**)
    - BLIF `.latch` count: 1638 d4 · 2292 d6 (EXACT substrate flop
      count match · 99.6-99.7 % of projected 1645 / 2300 bits)
    - post-ABC `.gate` lines: 1653 d4 · 2313 d6 (per-bit dfxtp_1
      mapped)
    - ratio d6/d4 = 1.3995 vs oracle 1.5156 · 7.7 % off
    - chain selftest 8/8 PASS (dispatcher + 7 module · zero
      regression)
  - **Tier-1 closure 진척** (post-(ll) 2026-05-21):
    - (0) MERGED (cc) · (a) MERGED (dd) · (b) PENDING #255 (ee) ·
      (c) MERGED in #247 (dd) · (d) MERGED (ff) · (e) LANDED
      `c4b35b13` (gg)
    - **(f) `router_d4 area > 0 → ±5 %`** — `[ ]` → **`[~]`
      PARTIAL-LANDED** (32,829 µm² · 46.85 % gap · 79 % gap
      closure since (e)+(ii))
    - **(g) `router_d6 ±5 % parity`** — `[ ]` → **`[~]`
      PARTIAL-LANDED** (45,936.6 µm² · 50.93 % gap · same closure
      logic)
    - (h) ratio 1.3995 vs 1.5156 · 7.7 % off · STAYS `[ ]`
    - (i) measurement_gate STAYS `[ ]` (gate target window
      [58,675, 64,851] / [88,928, 98,289] µm² NOT yet met)
  - **residual gap framing** (post-(ll)): ~47-51 % absolute area
    gap remaining = (a) comb sharing (`share`/`freduce` parity ·
    ~20 % of gap · substrate `synth` macro's logic-sharing optims)
    + (b) DFFE-promotion (substrate uses `$_DFFE_PP_` @ 30.03 µm²
    vs hexa-native plain `$_DFF_P_` @ 20.02 µm² · ~30 % residual
    once `share`/`freduce` lands). Option E (DFFE-aware techmap +
    behavioural `$_DFFE_PP_` emit + share + freduce · ~4-8 session
    estimate) is the next substantive Tier-1 (f)+(g)+(h)→`[x]`
    cluster move. Tier-1 (h) ratio closes naturally as Option E
    lands (d6 uses proportionally more DFFE than d4 in substrate ·
    DFFE-promotion pulls d6 area up faster, restoring 1.5156×).
  - **§12.1 in-place 갱신**: (f) bullet `[ ]` → `[~]` · (g) bullet
    `[ ]` → `[~]` · (h) bullet body refreshed with measured 1.3995
    ratio · "current gate state" snapshot refreshed from 1207.41 /
    1677.86 µm² to 32,829 / 45,936.6 µm² · gate target window text
    appended with residual-gap framing pointing at Option E.
  - **SSOT detail entry (ll)** appended to
    `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md` (file head
    status block + cross-reference note also updated · (kk) NOT
    rewritten · append-only spirit preserved).
  - **worktree cleanup side-effect**: `~/core/hexa-lang-optf`
    removed via `git worktree remove` (branch local-only · never
    pushed · safe). `~/core/hexa-lang-g31` LEFT IN PLACE (server
    branch `g31beta-ineichen-clearsky-hexa-native` NOT deleted at
    `git ls-remote` check time · user may inspect).

- 2026-05-21 — **G31β Ineichen clearsky hexa-native port LANDED ·
  Energy/solar D80 endpoint NEAR-FULL closure · §11.4 G31 block
  G31β sub-bullet append + `bridge_stack` 표기 갱신** (hexa-lang
  PR #265 squash-merged to origin/main · merge commit
  `326fdecfdc39d1b9185da5a8e022e46702f0ab09` · admin-merge per
  documented bootstrap-CI infra-fail pattern · 같은 PR #196/#208/
  #247/#263 의 fail mode). G31 branch-complete (G31a + G31b) 위
  ultimate-form parity 의 Ineichen clearsky leaf 도 hexa-native
  화 — Linke turbidity climatology lookup 만 pvlib 잔여 (D80
  endpoint compliance 의 NEAR-FULL closure · "FULL" 은 turbidity
  lookup 도 hexa-native 화 시점).
  - **hexa-lang side artifact** (PR #265 · 2 commit ·
    `a6567c5a` kernel+test · `62a562db` producer+batch):
    - `stdlib/kernels/solar/clearsky_kernel.hexa` 에 5 new pub
      fn (`relative_airmass_kasten` · `alt2pres_barometric` ·
      `absolute_airmass` · `ineichen_clearsky` · `ineichen_
      clearsky_batch`). Kasten 1989 + Perez clear-sky model
      (DNI / GHI / DHI 3-output) · perez_enhancement default
      preserved
    - `stdlib/kernels/solar/clearsky_kernel_test.hexa` 에 7 new
      test case (Phoenix noon · 다양한 zenith · altitude
      sensitivity · airmass forms · batch consistency 등) →
      34/34 PASS @ <1e-10 relative tolerance vs pvlib 0.13.0
    - producer-side batch wrapper `_ineichen_clearsky_batch.
      hexa` (G31b 의 `_solar_position_batch.hexa` mirror
      pattern · per-timestamp `hexa run` cold cost 회피)
  - **demiurge side smoke verification** (producer
    `nrel_midc_pyranometer.py` `_compute_modeled()` 의 4 pvlib
    call → 1 hexa subprocess swap):
    - mean_rel_err = **0.049674869** (G31b baseline 0.04967492
      위 drift **5e-6** · 1e-3 transcription threshold 의 1/200
      · 0.05 absolute threshold 기준 PASS margin 0.000325 →
      0.000325 거의 무변화)
    - `pass=true` · `absorbed=true` 유지 · `bridge_stack` 표기
      `"hexa_native_solar_position + hexa_native_ineichen_
      clearsky (Linke from pvlib turbidity climatology)"` 로
      갱신
    - 4 → 1 subprocess collapse: `pvlib.clearsky.ineichen(...)`
      + `pvlib.atmosphere.get_relative_airmass(z)` + `pvlib.
      atmosphere.alt2pres(altitude)` + `pvlib.atmosphere.get_
      absolute_airmass(rel_am, p)` 한 batch CLI 호출 안에
      흡수됨
  - **3 algorithm transcription notes** (Linke turbidity 외
    discoveries):
    - **perez_enhancement default 유지**: pvlib default
      (perez_enhancement = False) 를 그대로 transcribe — 변경
      시 mean_rel_err drift ≥ 1e-4 expected · scope 외
    - **Kasten airmass form equivalence**: hexa-native form
      `relative_airmass_kasten(z) = 1 / (cos(z) + 0.50572 *
      (96.07995 - degrees(z))^-1.6364)` ≡ pvlib `get_relative_
      airmass(z, model='kastenyoung1989')` (test fixture <1e-10
      relative drift)
    - **`HEXA_LANG` env var workaround**: producer subprocess
      에서 worktree-local stdlib import 를 `HEXA_LANG=<repo
      root>` 로 override (system-installed hexa-lang 대신
      sibling repo 의 in-flight stdlib 가 load 되도록 ·
      별도 axis 로 `hexa run --stdlib` flag 검토 가능)
  - **κ-69 R8 진척**: G31β = G31 의 follow-on (별 G-item 아님 ·
    G31 exit criterion 3 의 bridge_stack audit 의 확대 closure).
    R8 4 G-item 의 ledger 변동 없음 (G31 + G34 `[x]` · G32 + G33
    still `[ ]`) — G31β 는 G31 의 ultimate-form parity 완성도
    심화 (sun-position axis only → sun-position + clearsky axis).
    다음 lowest-friction = G32 decision gate (5-fold lock-in cell
    pick · code 0).
  - **cross-repo discipline**: 본 commit 은 demiurge-side
    narrative update only. hexa-lang PR #265 merge 시각만 박제
    (sibling repo 측 work 미접촉 · 본 cycle 의 sibling work 는
    이미 PR #265 안에 absorbed). post-merge worktree cleanup
    (`~/core/hexa-lang-g31`) 은 별도 step 으로 user 가 inspect
    후 결정.
  - **inbox-file ref fix (side-fix · 본 cycle audit)**: 본 Log
    entry 의 2026-05-21 `## Log` 헤드 직전 entry (§12.1 (e)
    LANDED) 의 "inbox note filed `2026-05-21-rfc006-§5-multibit-
    width-truncation.md`" reference 가 phantom (해당 inbox file
    부재 · 가장 가까운 name `rfc006-s5-area-oracle-parity-
    handoff.md` 는 concurrent agent domain 으로 off-limits).
    Reference 를 narrative-carried 표기로 fix (별 file 신설 0).

- 2026-05-21 — **§12.1 (e) `fifo_mem` 2-D LHS Option A LANDED ·
  Tier-1 (e) own-scope CLOSED · ARCH §12.1 (e) `[ ]` → `[x]` flip**
  (hexa-lang direct commit `c4b35b13` `feat(read_verilog): RFC 006
  §5 Tier-1 (e) Option A — 2-D LHS flat $dff demux (T76 PASS ·
  router_d{4,6} area > 0 unblocked)` · 2026-05-21T14:32 KST · NOT
  via PR · direct push to hexa-lang origin/main). post-G31-merge
  consolidation audit 에서 hexa-lang sibling-repo log scan 으로
  발견된 cross-repo land — ARCH §12.1 의 (e) `[ ]` 표시 stale.
  Honest update + (b)..(i) cluster framing 갱신.
  - **landing detail**: 2-D unpacked array `fifo_mem[pp][...] <= ...`
    writes 가 frontend 에서 더이상 drop 되지 않음. `_rv_emit_body_v2`
    의 `if has_idx2 == 1 { continue }` honest-skip 제거 + 4 sub-case
    demux emit (const/dyn outer × const/dyn inner). per-slot `$eq +
    $and + $mux + $dff` cell sequence. `_rv_parse_port_decl` 의
    second unpacked range parse + `_rv_array_bound2` 신규 helper.
  - **measurement delta** (sky130_fd_sc_hd · ABC 2026-05-21):
    - router_d4 = 559.286 → **1207.41 µm²** (+2.16× · oracle gap
      99.09% → 98.05%)
    - router_d6 = 771.99 → **1677.86 µm²** (+2.17× · oracle gap
      99.18% → 98.21%)
    - both `abc_map: ok` · no NetworkCheck failure · no honest-skip
  - **selftest delta**: read_verilog 78/78 → **79/79 PASS** (+T76
    minimum-shape 2-D `m[i][j] <= d` N=M=2 falsifier). passes 35/35
    · abc_map 7/7 · rtlil 11/11 · liberty 8/8 — zero regression.
  - **follow-up** (same-cycle): hexa-lang `a4a032af`
    `fix(read_verilog): 2-D LHS D-wire width-aware — match slot
    width via _rv_v2_wire_width` (15:27 KST · post-G34 land time).
    D-wire packed-width mirror via new `_rv_v2_wire_width(m, name)`
    helper. 79/79 PASS preserved · area delta NONE (BLIF emitter
    still collapses multi-bit cells to single `.latch` lines ·
    filing deferred · narrative carried by this Log entry — 별
    inbox note 신설 0).
  - **scope honesty (g3)**: (e) 의 own-scope 만 CLOSED — area > 0
    + ABC accepts + no honest-skip + 측정 가능. §5 absolute area
    gap ~98% 잔존 (Option A flat $dff 는 substrate `synth_memory_
    dff` consolidated count 보다 ~10× 비쌈 · 알려진 cost model).
    ±5 % closure 필요 시 Option B (RTLIL `$memrd` / `$memwr` cells
    + module-level `$mem`) 또는 (f) crossbar output array writes
    territory. NO `Yosys absorbed` claim. ABSORPTION.md §178 yosys
    row 변경 0 · `measurement_gate = OPEN` 유지.
  - **§12.1 in-place 갱신**: (e) bullet `[ ]` → `[x]` · "shortest
    path = PR #256 inbox patch Option A" line 제거 (Option A 가
    실제 land 된 form · PR #256 inbox 는 이제 historical note) ·
    "current gate state" 의 area 수치 갱신 + PR #261 → `c4b35b13`
    anchor 추가 · "estimate" 의 Tier-1 cluster (e)+(f)+(g)+(h)+(i)
    → (f)+(g)+(h)+(i) 로 정정 + Option A 한계 narrative 명시.
  - **cross-repo discipline**: 본 commit 은 demiurge-side narrative
    update only (sibling repo 측 work 미접촉 · §12.1 shape-note
    "demiurge 측 commit 0 에 가까운 axis" 유지). hexa-lang `c4b35b13`
    + `a4a032af` 의 land 시각만 박제.

- 2026-05-21 — **G34 governance row LANDED · κ-68 R7 DEFERRED Stage 2
  closure · ARCH §11.4 G34 `[ ]` → `[x]` flip** (constitution.md v1.0.0
  → v1.1.0 · MINOR bump). κ-68 G30 의 Stage 2 (constitution.md
  narrative governance) 가 constitution.md populate (`99ccbc1`) 위
  같은 session 안에 closure. work 요약:
  - **artifact**: `.specify/memory/constitution.md` 에 새 section
    `## Governance Rows` + `R1. Measured-Oracle Invariant` row land.
    row body = invariant 본문 (`absorbed=true ⇔ measuredOracle.is
    MeasuredOraclePASS=true`) + 2 carve-out (D106 illustrative ·
    D95/D103 substrate-parity) + first-land cite (κ-68 G29 / D110 /
    NREL MIDC SRRL pyranometer GHI / mean_rel_err 0.04967 ≤ 0.05 /
    commit `80a1664`) + load-bearing enforcement pointer (`fee34cc`
    G30 Stage 1 XCTest 3-method) + cross-link cluster (ARCH §11.4
    G30/G34 · design.md D109/D110/D103/D106 · RFC 013 §6.11/§6.12).
  - **stage separation**: Stage 1 (XCTest invariant · `fee34cc`) 가
    load-bearing enforcement vehicle 임을 row 본문이 명시 — `## Governance
    Rows` section header 의 docstring 도 "row 자체는 narrative
    governance pointer, 실제 enforcement 는 test/code" 패턴 명시.
    이로써 향후 governance row 들도 같은 pattern (narrative ↔ typed
    test pointer) 으로 land 됨.
  - **semver MINOR bump 1.0.0 → 1.1.0**: 새 section (`## Governance
    Rows`) 추가 = MINOR per constitution.md `## Governance` rule
    (MAJOR = principle removal/redefinition · MINOR = new principle/
    section · PATCH = wording). Ratified/Last Amended 2026-05-21 같은
    day update.
  - **G33 미land 위 G34 land 의 정당성**: G34 exit criterion 의 3번째
    bullet ("G33 까지 land 된 fixture-driven invariant 일치 audit") 은
    Stage 2 narrative governance 가 G29 first-land 위 닫히는 구조라 G33
    가 strict pre-condition 아님 (G29 의 single PASS instance 가
    invariant 의 first concrete witness · row 는 그 위 narrative
    anchor). G33 land 시 row body 에 second-cell first-flip 을 추가
    cycle 로 append.
  - **§11.4 G34 block 갱신**: heading `[ ]` → `[x]` · `**artifact**`
    sub-bullet 추가 (constitution.md row body 요약 + semver bump) ·
    `exit criterion` 3 bullet 모두 `[x]` 표기 + G33 dependency note
    명시 · `deps` 에 G31a+G31b bridge_stack semantics cross-ref 추가
    (PR #263 merge cycle 안의 same-day land 라 자연스러운 cross-link) ·
    `est_actual ≈ 0.3 session` 박제.
  - **κ-69 R8 critical-path 진척**: §11.4 Round 8 의 4 G-item 중 G31
    + G34 `[x]` (G31 = G31 G29-β branch-complete + origin/main land ·
    G34 = governance row land). G32 + G33 still `[ ]` — 다음 lowest-
    friction step = G32 decision gate (5-fold lock-in cell pick · code
    0) 또는 G31β (Ineichen clearsky hexa-native port). κ-69 = (a)
    ultimate-form parity (G31 ✓) + (b) 두번째 cell mirror (G32..G33
    미land) + (c) governance Stage 2 (G34 ✓) 의 3 axis 중 2 axis closed.

- 2026-05-21 — **G31 fully LANDED origin/main · PR #263 squash-merged
  · ARCH §11.4 G31 `[~]` → `[x]` flip** (hexa-lang merge commit
  `8eec8e734f6db6a9275218dc4e2ebb5a9cf41f15` · mergedAt
  2026-05-21T06:08:49Z · mergedBy dancinlife). κ-69 opening cycle
  안에 G31a + G31b 둘 다 same-day origin/main land — 1 session
  est_actual (1-3 session estimate 의 lower-bound 도 밑돔). work
  요약:
  - **merge path**: clean squash-merge (admin-merge 미사용 · PR
    #263 가 CI infra-fail (bootstrap × 3 + grace-consent) 의 documented
    pattern 위에서도 squash-merge gate 통과). `gh pr merge 263
    --squash --delete-branch` 의 local branch-delete 단계만
    `worktree '/Users/ghost/core/hexa-lang' uses main` 으로 인해
    local-side error (remote branch 는 server-side 정상 삭제 ·
    state=MERGED · merge SHA 확인됨)
  - **ARCH §11.4 G31 block 갱신**:
    - heading `[~]` → `[x]` · partial-land annotation 제거 후 merge
      SHA + origin/main land 표기
    - `deps` line 의 "PR #263 merge (origin/main land 시 → `[x]`)"
      → "PR #263 MERGED 2026-05-21 (`<sha>`) → G31 `[x]`"
    - `est` line 의 "merge 대기만 남음 (review + merge 후 `[~]` →
      `[x]`)" → "G31 fully landed same-cycle · est_actual = 1
      session · merge SHA 박제"
  - **`provisional=true` 강등 risk 제거** (D80 §0 endpoint compliance ·
    sun-position axis only): G31b smoke verification 시점에 이미
    smoke PASS (mean_rel_err 0.04967 · 0.05 threshold doubled margin) ·
    `absorbed=true` `pass=true` 유지 ·  `bridge_stack` =
    `"hexa_native_solar_position + pvlib Ineichen clearsky"` 으로
    honest 갱신 완료. PR #263 merge 으로 인해 origin/main 위에서
    이 honest bridge_stack 표기가 reproducibly 살아남음 → G29 first-
    flip 의 `provisional=true` 강등 risk 가 sun-position axis 에서
    완전 closure. Ineichen clearsky port 는 G31β 별 scope (κ-69+).
  - **κ-69 critical-path 진척**: §11.4 Round 8 의 4 G-item 중 G31
    `[x]` (first full-land) · G32/G33/G34 still `[ ]`. 다음 lowest-
    friction step = G32 decision gate (5-fold lock-in cell pick · code
    0) 또는 G31β (Ineichen clearsky hexa-native port).
- 2026-05-21 — **D111 ratified · §4.5 신설 · generic verb-cell
  dispatch (`cellrun.hexa` + `.demi` manifest) 가 cockpit dispatch
  의 ultimate-form target 으로 명문화**. 2026-05-21 cycle 의 sscb
  7-verb walkthrough 실 측정 (3/7 wired · 4/7 honest-skip) 이
  trigger — 사용자 직접 관찰 "SSCB · RTSC 이렇게 전용함수가 아니라
  시스템 그 자체를 구축해야돼" 가 D111 의 motivation. cellrun.hexa
  가 그 "시스템" 의 정확한 shape:
  - **현 상태 명시화**: 46 `*Producer.swift` + 40+ hardcoded
    `(.verb, "domain")` switch case = **transitional bridge**
    (D14 / D18 / §0 hexa-only ultimate form). 새 도메인 추가 =
    7 Swift class + 7 switch case = ai-native 원칙 위반 (prose-
    shaped code).
  - **target shape**: ActionDispatch.swift = thin spawner ·
    실제 dispatch logic = `stdlib/cockpit/cellrun.hexa` 안 ·
    per-domain `.demi` manifest 가 [cell.<verb>] 섹션 별 wiring
    (substrate · script · record_kind · output_dir · required_
    deps · gate_default · absorbed_default · scope_caveats ·
    fallback variants).
  - **새 도메인 추가 cost**: 7 Swift class + switch (700-1400
    line) → `<id>.demi` manifest 1 file (80-120 line). g3 honest-
    skip 도 manifest 부재 자동 처리 (typed-by-config).
  - **Phase A 진행 중** (concurrent agent · 2026-05-21 cycle 안):
    `~/core/hexa-lang-cellrun` isolated worktree 에서 `stdlib/
    cockpit/cellrun.hexa` scaffold 작성 중 + demiurge 측
    migration inventory + sscb.demi proof-of-concept 동시 진행.
    PR open 은 review 대기.
  - **Phase B..E migration**: B = sscb.demi PoC (1-2 session) ·
    C = 46 producer 점진 migration (5-10 session) · D =
    ActionDispatch 5-line thin spawner 축소 (1 session) · E =
    record schema generalization optional (2-3 session). 누적
    10-17 session · multi-cycle work. [**superseded same-day 저녁
    → 15-20 session per Phase B step 3 observed cost · see top-of-
    Log entry 2026-05-21 honest correction**]
  - **axis distinction**: D111 = dispatch-mechanism axis ·
    cell `absorbed` 와 무관 (D103 dimension separation 보존) ·
    D74 ProducerRegistry alternatives 패턴 자연 흡수 (`[cell.
    <verb>.<variant>]` 섹션 multiple).
  - **§11.4 G32 → D112 shift**: 본 D111 land 직전 G32 plan 이
    "design.md D111" 를 cite 했지만 cellrun 이 먼저 land 하여
    D111 차지 · G32 = D112 로 references 갱신 (2건 in §11.4).
  - **provenance**: 사용자가 SSCB walkthrough 후 직접 "시스템
    자체를 구축해야돼" 라고 지시 · D111 = 그 지시의 doctrinal
    ratification.
- 2026-05-21 — **G31b producer integration landed · same-cycle full
  G31 partial → branch-complete** (hexa-lang PR #263 OPEN with 2
  commits — `740964a0` G31a + `47c2378e` G31b). κ-69 opening 같은
  cycle 안에 G31 의 두 half 가 모두 branch 측 land. `[~]` 유지
  (PR merge 대기 · merge 시 `[x]` 로 flip). work 요약:
  - **artifact** (hexa-lang `47c2378e` · branch `g31-solar-
    position-hexa-native-port`):
    - new `stdlib/energy/_solar_position_batch.hexa` (67-line ·
      argv `<year> <doy> <utc_hour_start> <step_min> <n_steps>
      <lat> <lon>` → stdout N zenith lines · internal loop
      using `solar_kernel::apparent_zenith`)
    - modified `stdlib/energy/nrel_midc_pyranometer.py` (+141 /
      -38 line · `_compute_modeled()` swap + `pvlib.clearsky.
      ineichen(apparent_zenith=hexa_native_z, ...)` external
      pass + `bridge_stack` field 갱신)
  - **smoke test PASS** (G31b acceptance):
    - mean_rel_err = **0.04967492** vs baseline 0.04988 ·
      threshold 0.05 → PASS margin doubled (0.00033 → 0.00067 ·
      약 21bp 개선 · regression NOT)
    - n_clearsky=480 · daylight=831 · dropped=351 (cloudy/cloud-
      enhanced)
    - max_rel_err=0.22708 (clear-sky window 의 cloud-edge
      transient · honest documented in dataset_caveats)
    - `absorbed=true` `pass=true` 유지 (κ-68 G29 first-flip
      gate 안 깨짐)
    - bridge_stack = `"hexa_native_solar_position + pvlib
      Ineichen clearsky"` 으로 honest 갱신 (D80 §0 endpoint
      compliance · sun-position axis only · Ineichen 는 G31β)
  - **batch wrapper rationale**: Approach A (per-timestamp `hexa
    run`) = 1440 × ~10s cold-start = 4-hour infeasible. Approach
    B (batch wrapper · single subprocess loop internally) = 9s
    wall for 1440 zeniths. native binary 자체는 0.48s, cold-
    start overhead 가 dominant — batch 가 자연스러운 amortization.
  - **infra discoveries** (별 axis · note 박제):
    - `/tmp` output path 가 `hexa build` panic-trigger guard
      (April 2026 mac kernel-panic mitigation) 에 의해 차단 —
      batch wrapper 는 `hexa run` 만 사용해서 sidestep (run mode
      cached artifact path 사용)
    - Sandia 1985 ephemeris (hexa-native) vs pvlib NREL SPA의
      0.001-0.002° drift 는 algorithm choice 차이 (kernel
      docstring 의 <1e-9 relative 와 일치) · regression 아님
    - NREL MIDC HTTP fetch 가 producer 총 3m17s 의 dominant
      cost — hexa-native subprocess overhead 는 noise-floor 이하
  - **PR #263 status**: OPEN with 2 commits ready-to-merge ·
    smoke verified · merge 시 ARCH §11.4 G31 `[~]` → `[x]` flip
    + bridge_stack audit 완료 + provisional=true 강등 risk 제거
  - **next dep chain**: G31β (Ineichen clearsky 도 hexa-native
    port · κ-69+ scope) · 또는 κ-69 R8 의 다른 axis (G32/G33/G34
    중 G32 decision gate 가 lowest-friction next)
- 2026-05-21 — **G31a wrapper half landed · κ-69 first cross-repo
  partial-land** (hexa-lang PR #263 OPEN). κ-69 opening 같은 cycle
  안에 G31 의 wrapper 부분이 hexa-lang sibling repo 측 land — ARCH
  §11.4 G31 `[ ]` → `[~]` (partial · G31a ✓ / G31b pending). work
  요약:
  - **isolation strategy**: hexa-lang main worktree 가 다른 agent
    의 504-line WIP (정확히 §12.1 (e) fifo_mem 2-D LHS axis · 직접
    충돌 위험) + 5 modified files 로 dirty 상태 였음. `git worktree
    add /Users/ghost/core/hexa-lang-g31 origin/main` 로 clean
    origin/main 위 격리 워크트리 생성 + branch `g31-solar-position-
    hexa-native-port` checkout. memory note `feedback_hexa_lang_
    concurrent_agents` 의 권고 (worktree 공유 회피 패턴) 따름.
  - **artifact** (hexa-lang `740964a0`): `stdlib/energy/_solar_
    position_cli.hexa` 64-line wrapper. argv-driven per-timestamp
    interface (`<year> <doy> <utc_hour> <lat> <lon> [pressure_pa]
    [temp_c]` → stdout `apparent_zenith_deg`). internal call site
    = clean-room hexa-native `solar_kernel::apparent_zenith` (κ-65
    D80 g_hexa_only pilot).
  - **stdlib/sys avoidance**: 초기 build 가 `use "stdlib/sys"` 로
    인해 `read_line` undeclared 컴파일 에러. stdlib/sys 의
    `sys_stdin_read_line` 가 broken runtime symbol 참조 (별 axis ·
    upstream). wrapper 는 stdin 미사용 → `use "stdlib/sys"` drop +
    global builtins (`args()` · `exit()` · `println()` · `to_int()`
    · `to_float()`) 직접 사용. workaround pattern 박제.
  - **argv shape discovery**: `hexa run script.hexa user-args...`
    모드의 `args()` = `[cached_binary_path, ...user_args]` (no
    script_path slot in argv) — user args start at argv[1]. 초기
    offset 2 가 틀려서 usage error 트리거, debug print 으로 확인
    후 정정.
  - **parity verification** (smoke · solar_kernel_test 의 <1e-9
    claim 일치 확인):
    - noon Phoenix MST 2024-06-15 (year=2024, doy=167, utc_h=19.5,
      lat=33.4484, lon=-112.0740): hexa-native **10.0999°** vs
      pvlib 0.13.0 **10.097987637367325°** → Δ ≈ 0.002°
    - crepuscular 5:30am Phoenix MST 같은 day (utc_h=12.5): hexa-
      native **88.3214°** (해 막 뜬 직후 · 합리적)
  - **PR #263 OPEN**: `feat(stdlib/energy): G31 G29-β · hexa-native
    sun-position CLI wrapper`. zero regression (leaf primitive, 호
    출자 0 in-tree). merge gate for G31b producer integration.
  - **G31b follow-on (1-2 session est)**: demiurge sibling repo 측
    work — `nrel_midc_pyranometer.py::_compute_modeled()` 에서
    `loc.get_solarposition()` → subprocess `hexa run wrapper` swap
    + `pvlib.clearsky.ineichen(apparent_zenith=...)` external pass
    + NREL MIDC 480-sample mean rel_err ≤ 5% 유지 verify +
    `bridge_stack` field "hexa_native_solar_position + pvlib
    Ineichen" 갱신. PR #263 merge 가 G31b 의 dependency.
- 2026-05-21 — **§12.1 PR state drift 정정** (post-cross-repo-audit ·
  ARCH 사실 honesty). hexa-lang `gh pr view` 로 실제 PR state 점검
  결과 §12.1 + 이전 Log entry 의 PR# / merge state 에 3건 drift
  발견 → §12.1 in-place 정정 + 본 Log entry 박제:
  - **§12.1 (b) PR #255 abc_map honesty**: ARCH 가 `[x] MERGED` 로
    기록 → 실제 **OPEN** (submitted 2026-05-20 · selftest PASS ·
    merge pending review). `[~] OPEN` 으로 정정.
  - **§12.1 (d) `rr_ptr__d` comb-loop**: ARCH 가 "hexa-lang PR #260
    (`c10699c2`) MERGED" 로 기록 → 실제 PR #260 은 OPEN (branch
    `rfc006-yosys-ssa-seed-fix` · parallel attempt at same target).
    동일 (d) target 의 실제 land 는 **PR #261 (`0ca0994f`)** MERGED
    2026-05-20T19:26:33Z (RFC 073 Phase 3g — SSA pre-loop init
    redirect). PR #260 → PR #261 로 정정, PR #260 은 superseded
    note 박음.
  - **PR #259 (G29 first flip)**: confirmed MERGED ✓ — drift 없음
    (merge commit `b8d35920cc24fefafad555bf254c2a3576b8840f` ·
    2026-05-20T19:08:59Z).
  - **이전 Log entries** (2026-05-21 chip §B substrate-axis cycle
    bracket entry · 2026-05-21 κ-68 closure narrative) 의 PR#
    references 는 historical record 로 보존 — drift 가 그 시점의
    write-time 정보 한계 때문. SSOT 정정은 §12.1 in-place + 본
    correction entry 가 carry.
  - **cross-repo audit trigger**: 이세션의 cross-repo prep (hexa-lang
    `gh pr view` · PR #256 inbox patch · §12.1 (e) collision
    확인) 가 부산물로 표면화. 다음 cross-repo audit 주기 (예: §12.1
    (e) land cycle · G31 land cycle) 에 같은 패턴으로 점검할 것.
- 2026-05-21 — **κ-69 opening · §11.4 Round 8 scaffold (G31..G34)
  pre-code 박음** (RFC 013 §6.11 LANDED 이후의 next phase boundary).
  κ-68 closure entry 의 'κ-69 reserved scope' 약속 (G29-β · 다른
  cell measured-oracle round · G30 Stage 2) 을 4 placeholder G-item
  으로 박음 — code 변경 0, ARCH narrative 만:
  - **G31 [ ]** Energy/solar `solar_position_kernel` hexa-native
    runtime call site port (D80 ultimate-form parity · G29-β
    follow-on · pvlib bridge 의존 제거 · MeasuredOracleRef.bridge
    Stack 표기 갱신 · provisional=true 강등 risk 제거). 1-3 session
    est. hexa-lang substrate 작업 · demiurge code mostly 0.
  - **G32 [ ]** 다음 cell pick + measured-oracle source 5-fold
    decision (G27 mirror · D106 illustrative gate 제외 · D95
    computed-projection 만족 cell 제외). 후보 cluster = Aura
    soft-biology (PhysioNet) · Ufo non-illustrative stage ·
    Mobility / Grid / Energy wind sub-cell. design.md D115 land
    예정. 0.3-0.5 session est. code 0.
  - **G33 [ ]** G32 cell 첫 `absorbed=true` legitimate flip
    (G29 mirror · κ-68 G29 와 다른 점: schema half 재사용 · 다른
    record type 에 MeasuredOracleRef field land · XCTest invariant
    extension). 2-4 session est.
  - **G34 [ ]** G30 Stage 2 — `.specify/memory/constitution.md`
    governance row land (κ-68 R7 DEFERRED · constitution.md
    populate 후 본 row 자체는 doc edit). 0.3-0.5 session est.
  - **§11.4 title** G1–G30 → G1–G34, intro Round 7 'in-progress'
    → 'LANDED', Round 8 scaffold 항목 추가. **§11.3 head note**
    Round 1-7 → Round 1-8 표기 동시 갱신.
  - **§12.1 chip §B substrate-axis** 와의 관계: §12.1 (e..i) 와
    §11.4 Round 8 (G31..G34) 은 두 별 axis — substrate-side
    measurement_gate 와 per-cell measured-oracle 둘 다 독립
    진행. §12.1 work 는 sibling repo hexa-lang 에서, §11.4 Round
    8 work 는 mostly demiurge (G31 hexa-lang substrate 제외) ·
    별도 cycle 로 land.
- 2026-05-21 — **ARCH §12 신설 · chip §B substrate-axis 잔여 로드맵
  YOSYS.md → ARCH.md 이관**. 06a8428 (κ-68 closure cycle) 에서 git
  rm 된 구 root `YOSYS.md` 의 Tier-1/2/3 잔여 로드맵을 본 파일 §12.1
  로 흡수. 이관 동기: per-cell measured-oracle axis (κ-43 cell flip
  · κ-68 measurement-parity flip) 와 substrate-axis (hexa-native
  parity port · rfc_006 §5 `measurement_gate`) 는 D80 endpoint
  rule §0 의 두 개 별 axis 인데, 후자의 narrative SSOT 가 git rm
  이후 ARCH `## Log` 안에만 흩어져 있었음 — 구조적 anchor 부재.
  §12 가 새 anchor 가 되어 (a) §11.4 G-round 와 분리된 substrate-
  side 트랙 임을 명시 (b) Tier-1 (e..i) / Tier-2 (3 item) / Tier-3
  (2 item) 잔여 work 구조적 박음 (c) 8-16 session estimate 박음
  (d) cell-flip vs gate-flip dimension 박음. detail SSOT 는 여전히
  `inbox/notes/rfc006-s5-area-oracle-parity-handoff.md` (entries
  (o)..(bb)+ · 1754 line). 다음 substrate-axis work commit 부터는
  ARCH §12.1 의 해당 `[ ]` 항목을 `[x]` 로 flip + `## Log` 에 narrative
  bracket 박는 패턴 (§11.4 G-item 과 동형) 채택.
- 2026-05-20 — ARCH.md created. Consolidates D72 (kernel layer),
  D73 (firmware domain), D74 (ProducerRegistry), D76
  (SceneDescriptor), D77 (chem + bio domains), D78 (domain graph
  DAG + multi-facet tag) into one narrative architecture SSOT.
  Existing terse machine-readable index `ARCH.tape` is retained
  for tape-format consumers; this file is the human / cross-link
  layer. Numbers and counts deliberately deferred to design.md /
  PLAN.md / GOAL.md (g_ssot_single_source D50).
- 2026-05-20 — §11 Worked simulations added — two end-to-end
  design walk-throughs (`alien-disc-mk1` / `aura-clip-mk1`)
  recorded as canonical test cases. §11.4 carries the G1–G8
  implementation checklist with explicit deps / new files / edit
  targets / exit criteria per item. Round grouping: G1+G3+G5
  fundamental, G2+G7 honesty surface, G4+G6+G8 cross-domain
  audit. No code changed yet — these are design tests.
- 2026-05-20 — §0 hexa-only first-principle added (D80, AGENTS.tape
  `@D g_hexa_only` INDEX top). User gate "hexa only / hexa-native
  최상단 기록". Raises `g_hexa_native` (D14+D18, absorption-time
  preference) to absolute endpoint rule. Python/Swift/external CLI
  are transitional pointers, not endpoints. `absorbed=true` non-
  provisionally requires the hexa-native parity port. cern+synth
  (κ-51) reclassified as *provisional* (scope_caveats 이미 명시 한
  형식의 typed 화는 후속 phase).
- 2026-05-20 — §11.4 G1–G8 → G1–G12 확장. κ-62 (3322523) 에서 G1–G8
  all `[x]` 마감 완료 audit, 헤딩 노트 갱신. κ-65 D80 sweep
  (5e9f6dea) 산출물 cover 를 위한 Round 4 (G9–G12) 추가: G9
  `HexaNativeParityRef` 8-field schema + 5 cell-record carrier, G10
  `DependenciesLoader` 의 44-row cross-repo SSOT consumer (DEPENDENCIES.
  demi), G11 `GateType.hexaNativeFuture` (heavy-port bucket, exhaustive
  switch 갱신), G12 hexa-lang sibling-repo fix (a272c9c4 codegen
  param-shadow + `stdlib/core/math/wrap_pi.hexa` primitive · 4389da0c
  pilot-pattern reconcile).
- 2026-05-20 — §11.4 G1–G12 → G1–G18 확장. 2026-05-20 cycle 의
  D80 SSOT 통합 + 후속 sweep (D87..D101) 산출물 cover 를 위한
  Round 5 (G13–G18) 추가: G13 `PILOTS.demi` 8-field SSOT + 12-row
  coverage (2d07fd8 foundation · efa4afe T7 · a5d12d2 D95 computed
  absorbed · 87cb765 / c63f406 / f28c1b0 / a2fcb1b D80 pilots
  #9..#12 · 3215cea chem seed), G14 19/19 도메인 narrative coverage
  (47bf504 D96 5 sibling rows + e451037 D100 14 non-sibling rows),
  G15 3-tier substrate link-integrity verifier (74a1b92 D97 Q3=A,
  `SUBSTRATE_LINKS.demi` + 3 XCTest tier), G16 cockpit
  `HexaNativeParityChip` 3-case 시각화 (f036f6f D99 render-only,
  pure-data model + SwiftUI view), G17 `DEPENDENCIES.demi ↔ PILOTS.
  demi` cross-ref CI (384101b D98 Phase F, 3 XCTest method), G18
  `DEMIURGE_HEXA_LANG` env-var deprecation (8fc0862 D101 D3/D88
  후속). 헤딩 노트 G1–G18 로 갱신.
- 2026-05-20 — §11.4 G1–G18 → G1–G24 확장 (+ G25/G26 post-closure
  pilot + breakthrough note 박제). 같은 2026-05-20 cycle 의 κ-67
  closure 및 그 직후 추가 pilot 산출물 cover 를 위한 Round 6 (G19–
  G26) 추가: G19 chem 첫 `PILOTS.demi` row (a033def D102 Stage-0
  scaffolding), G20 cell `absorbed` vs `isHexaNativeAbsorbed`
  dimension separation docstring (105315e D103 코드 변경 0), G21
  RFC 013 status `PARTIAL-LAND` → `MOSTLY-LANDED` refresh (943a5b8
  D105 κ-67 sweep reconciliation), G22 `.illustrativePhysics`
  `GateType` 4번째 case (f9a9a90 D106 RFC 013 §6.12 LANDED · anti-
  conflation cyan tone), G23 `SiblingRepoSpawner.resolveEntrypoint
  ()` 5th fallback `cli/hexa-<id>.hexa` (e66e4c0 D107 priority-
  preserving), G24 κ-67 closure 박제 (eea2804 D108 D87..D107 누적
  · 3 doc SSOT cross-link), G25 geodesy WGS84 14번째 D80 pilot
  (acac78c · hexa-lang `b7a43493` · 15th kernel folder · bridge
  substrate · 70/70 PASS @ 1e-10 · 누적 14 D80 pilots / 445
  assertions / 16 PILOTS rows), G26 D80 sweep close breakthrough
  note (1f9f934 · cold-start anchor · inbox/INDEX 27 entries).
  헤딩 노트 G1–G24 로 갱신 (G25/G26 는 Round 6 안 post-closure
  bracket).
- 2026-05-20 — §11.4 G1–G24 → G1–G30 확장. **Round 7 scaffold**
  (`κ-68 per-cell measured-oracle parity round` — RFC 013 §6.11 ·
  in-progress) 4 placeholder G-item 박음 (G27 cell + oracle 선정
  pre-code gate · G28 producer wire `absorbed` 미flip · G29 첫
  cell `absorbed: true` legitimate flip NOT D95 computed · G30
  governance invariant typed enforcement). pre-code 단계 — code
  변경 0, ARCH narrative 만 확장. stored `absorbed: Bool` 의 첫
  legitimate flip 을 cell-side measured oracle 로 트리거하는
  round 의 frame 을 박은 것. illustrative-physics gate (D106) 적용
  cell 은 본 round 의 flip 대상에서 제외 (RFC 013 §6.12 anti-
  conflation 유지).
- 2026-05-21 — **Round 7 close · κ-68 closure narrative bracket**
  (RFC 013 §6.11 `queued` → `LANDED` · §11.4 G27..G30 4 G-item 모두
  `[x]` 한 사이클 마감). 2026-05-20 scaffold 직후 사이클에서 4-fold
  full land 가 박혔으며 G-item 자체 `[x]` flip 은 §11.4 본문에 이미
  반영. 본 Log entry 는 그 narrative bracket close 만 박제:
  - **G27 [x]** (D109 · `5392213`) — cell pick = Energy/solar +
    external oracle = NREL MIDC SRRL Golden CO pyranometer GHI
    (single clear-sky day · 1-min cadence) + bridge = pvlib clearsky
    /transposition trusted + hexa-native scope = `solar_position_
    kernel` + PASS criterion = mean rel_err ≤ 5%. 5 sub-decision
    default lock-in · code 0 (decision-only).
  - **G28 [x]** (G28a `4a1a087` demiurge Swift + G28b PR #248 STUB
    MERGED hexa-lang) — schema-half: `MeasuredOracleRef` 8-field
    Codable Sendable Equatable + `EnergyVerifyRecord.measuredOracle`
    optional field + `isMeasuredOraclePASS` computed predicate + 7
    XCTest method (Codable round-trip · snake_case JSON wire ·
    D103 invariant). hexa-lang STUB producer (60-sample synthetic
    clear-sky) 가 schema half end-to-end emit→decode 입증.
  - **G29 [x]** (D110 · `80a1664` demiurge + hexa-lang `b8d35920`
    PR #259 REAL MERGED) — first cell `absorbed=true` **legitimate
    flip** (mean_rel_err **0.0499 vs threshold 0.05** marginal PASS ·
    480 clear-sky samples · 2024-06-15 SRRL BMS · NOT D95 computed
    projection · NOT D106 illustrative). stored `absorbed: Bool` 의
    첫 legitimate flip — κ-43 dynamic flip 의 measured-oracle axis
    mirror.
  - **G30 Stage 1 [x]** (`fee34cc`) — XCTest invariant load-bearing
    land (3 test method · `absorbed=true` ⇔ `measuredOracle.isMeasured
    OraclePASS=true` typed enforcement · D95 computed projection
    부산물 차단 · D106 illustrative exempt). G30 Stage 2 (`.specify/
    memory/constitution.md` governance row) 는 constitution.md
    populate 후로 deferred — Stage 1 만으로 load-bearing.
  - **RFC 013** `MOSTLY-LANDED` → `LANDED` (§6.11 entry refresh ·
    §9 Log new entry). κ-67 의 substrate-parity axis (§6.1..6.10 +
    6.12) 와 κ-68 의 measurement-parity axis (§6.11) 가 D103
    dimension-separation 으로 typed-enforce — 두 axis 가 별 round
    로 land.
  - **κ-69 reserved scope** (다음 phase boundary): G29-β (hexa-native
    sun-position runtime call site port — solar_position_kernel.hexa
    의 D80 ultimate-form parity) + 다른 cell measured-oracle round
    (Aura / Ufo 등 · D106 illustrative 제외) + G30 Stage 2
    (constitution.md populate 후 governance row). §11.4 Round 8
    scaffold 는 κ-69 opening 시점에 박음.
- 2026-05-21 — **chip §B substrate-axis · yosys measurement chain
  첫 area > 0 측정 (별 axis — κ-43 dynamic flip 의 substrate-side
  확장 work)**. hexa-lang PR #260 (`c10699c2`) MERGED — `read_verilog.
  hexa::_rv_parse_always` for-handler 의 SSA chain pre-loop alias
  (`connect(s__ssa0, s)`) 와 post-loop publish (`connect(s, s__ssaP)`)
  결합으로 발생한 `s__ssa0 = s = s__ssaP` comb cycle (`rr_ptr__d`
  종단 ~13-hop) 을 `connect_lhs[]` 역방향 scan 으로 pre-loop driver
  rhs 직접 seed 하여 해체. cycle 해체 + 외부 readers 는 여전히
  post-loop publish 통해 정확한 값 read. T74c 재작성 + T74d
  regression guard 추가. read_verilog selftest 77/77 PASS · round_
  trip 12/12 · abc_map 7/7 (zero regression).
  - **첫 area > 0 측정** (mac-side `HEXA_EXEC_NO_SHELL=1 hexa run
    stdlib/yosys/gate_record.hexa`, cleared `/tmp/_hexa_yosys_gate_
    *_out.blif`): router_d4 = **559.286 µm²** (oracle 61,763 ·
    Δ=99.09%) · router_d6 = **771.99 µm²** (oracle 93,608.5 ·
    Δ=99.18%) · 둘 다 `abc_map: ok exit=0`. 어제 23:48 까지 stale
    BLIF false-positive 였던 chain 이 honest measurement 로 전환.
  - **Tier-1 closure 진행** (post-(d)-close 2026-05-21): (0) exec
    runtime · (a) PR #247 SSA · (b) PR #255 abc_map honesty · (c)
    script reorder · (d) **rr_ptr__d cross-iter comb-loop** 모두
    closed. (e) `fifo_mem[*]` 2-D LHS RTLIL Memory emit (40 d4 /
    52 d6 const-tied nets · ~60k µm² oracle gap) + (f) re-measure
    ±5% gate (area ∈ [58,675, 64,851] d4 + [88,928, 98,289] d6) 만
    남음. PR #256 inbox patch 의 Option A (per-element flat `$dff`)
    가 shortest path.
  - **κ-43 axis 와의 관계**: chip §B+§D 는 κ-43 (D70 dynamic flip
    2026-05-?) 시점에 이미 `absorbed=true` — substrate yosys + booksim
    측정 fact 위에서 박힌 첫 dynamic flip. 본 PR #260 work 는 그
    cell 의 **hexa-native parity port** axis 진척 (D80 endpoint
    rule · §0 first principle) — substrate yosys 가 측정한 oracle
    area 를 hexa-native synth chain 이 ±5% 안에서 재현하는 것이
    목표. κ-43 cell 상태 자체는 unchanged (이미 `absorbed=true`),
    rfc_006 §5 `measurement_gate = OPEN` (g3 — `CLOSED_MEASURED`
    flip 은 area > 0 → ±5% 측정 후 g3-conditional) 도 OPEN 유지.
  - **SSOT 분리**: 측정-fact + Tier-1/2/3 roadmap + landing timeline
    의 detail SSOT 는 `inbox/notes/rfc006-s5-area-oracle-parity-
    handoff.md` (entries (o)-(u)+ 누적). 본 axis 의 narrative SSOT
    는 ARCH `## Log` (κ-68 closure 와 동일 cycle 2026-05-21 KST 에서
    chip §B substrate-axis 도 measurement breakthrough 가 있었다는
    사실 박제). 별 도메인 SSOT 파일 (구 `YOSYS.md`) 은 본 entry
    박제 시점에 git rm — narrative 는 ARCH 가 carry, detail handoff
    는 inbox/notes 가 carry, 측정 fact (oracle d4=61,762.99 µm² /
    d6=93,608.53 µm² / ratio 1.5156× bit-exact · Tier-1/2/3 89%
    prune · 8-16 session estimate) 는 git history (last commit `338837f`
    + 본 closure cycle) 에서 retrievable.
  - **demiurge 측 code commit 0**: 본 PR #260 land 는 hexa-lang 측
    work (sibling repo `~/core/hexa-lang`), demiurge 는 narrative
    emit (본 entry) + 구 `YOSYS.md` git rm 만. cell schema / record
    변경 없음 — chip §B+§D 의 κ-43 ProducerRegistry 와 동일 structure,
    measured area 가 진척한 것뿐.
