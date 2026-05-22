# GOAL — Demiurge 의 한 문장

```
/goal demiurge 가 — 칩 전용 EDA 툴이나 단일-도메인 모델러가 아니라 — 어떤 공학 시스템이든 명세→구조→설계→해석⟲→합성→검증→인계 7-verb 로 *설계 자체*를 계산·검증하고, 물질합성→칩아키텍쳐→부품설계를 한 줄로 잇는, 측정 전엔 무엇도 과대주장하지 않는(g3) 정직한 hexa-native 메타-컨덕터가 되게 만든다.
```

> **한 문장 (canonical)**: demiurge 는 분야-무관 7-verb 로 *설계 자체*를
> 계산·검증하고 외부 선행기술을 공개면 clean-room 으로 흡수해 **물질→칩→
> 부품을 직렬로 지휘**하는, **정직(no-over-claim, g3)** 한 hexa-native
> 메타프레임워크다.

## 무엇이 아닌가 (NOT)

- 칩 전용 EDA 툴 아님 (chip 은 *도메인 1개*; cohort = cern·antimatter·
  rtsc·space·energy·brain + 14 맵)
- 단일-도메인 모델러 아님 (vs SysML / Modelica — 분야 무관 spine)
- proprietary 블랙박스 아님 (vs Cadence / Synopsys — cited·공개감사·honest-gated)
- 물질/분자 *계산기* 아님 — 그건 hexa-matter(물질)·hexa-bio(분자);
  demiurge 는 **설계 자체**를 계산 (hexa-matter·hexa-bio·comb 모두
  typed-interface 소비 — hexa-matter 흡수 SSOT = hexa-lang, D17 이
  D12 supersede; demiurge 는 소비자)
- 측정 없이 "absorbed/parity/resolved" 주장하는 것 아님 (g3 — `@F f2`)

## 무엇인가 (IS)

- 분야-무관 **7-verb** (`명세→구조→설계→해석⟲→합성→검증→인계`, 9
  라이프사이클 cited — `design.md` D5) 로 설계를 계산·검증
- **메타-컨덕터** (D11): 물질합성→칩아키텍쳐→부품설계를 직렬로,
  각 pass 의 HANDOFF → 다음 pass 의 SPECIFY (rfc_004 §3/§4)
- 외부 선행기술을 **공개면 clean-room** (D1) 으로 흡수 → hexa-native
  (재사용 모듈은 `hexa-lang/stdlib/`, D15 — demiurge 는 소비자)
- **정직**: 모든 산출이 `provenance.absorbed`·`measurement_gate`
  (OPEN / B_PINNED_MET / CLOSED) · citation 을 들고 다님 (g3)
- 산출 = *설계* + 로컬 macOS Swift 코크핏 (D16); 공개 honest-audit =
  public GitHub repo 자체 (상보)

## 모든 작업은 이 한 목표의 수단

```
7-verb spine (cited)                — 메타프레임워크 코어
  → rfc_001..005 absorption-RFC      — 도메인이 외부 선행기술 흡수하는 법
  → 14 도메인맵 (Cohort 1·2)         — 분야-플러그인 폭 입증
  → hexa-matter 흡수 (domains/matter)— 물질합성 stage (chain 1번)
  → chain seams (rfc_004 §4)         — 물질→칩→부품 직렬 배선
  → macOS Swift 코크핏 (D16)         — 사람이 보는 표면
= 전부 "정직한 만능 설계실(meta-conductor) 이 어디서 완성되는가" 의 경로
```

## 현재 정직한 위치 (g3 — over-claim 금지)

**4-Phase 설계 design-complete · macOS cockpit workbench 골격 live ·
wired·absorbed·측정 record 모두 0.**
north-star 불변. 아래는 *카테고리* 서술 — D-번호·RFC건수·cockpit
phase 같은 수치의 SSOT 는 `design.md` / `PLAN.md` (g_ssot_single_source):

- ✅ **설계 골격 완결**: 7-verb spine cited (9 라이프사이클·D5) ·
  **15 도메인 공개면 맵** (13 Cohort cited + `component.md` +
  `matter/` D17 pointer) · **RFC 묶음** (`proposals/rfc_*` —
  booksim·e2e·seam·cockpit 4-spec) · **design.md 결정 감사추적** ·
  AGENTS.tape 거버넌스 · CHARTER+HANDOFF reconciled.
- ✅ **hexa-matter measured-parity 검증됨 (단 hexa-lang 소유 — D17)**:
  selftest **38/38** · parity **29/29** 는 실측 사실이나 **hexa-lang
  의 이미 완료된 흡수** (D17 = hexa-lang SSOT · demiurge =
  소비-포인터; `domains/matter/` pointer 化, rfc_005 tombstone
  CANCELLED). demiurge 는 흡수 소유 주장 안 함.
- ✅ **inbox handoff 적재 완료**: `hexa-lang/inbox/notes/2026-05-19-
  demiurge-rfc006-yosys-handoff.md` + `PATCHES.yaml` +2 (booksim
  `d5a63a82`=pending·comb `61866308`=applied), `inbox_sync` 통과.
- ✅ **component cited-research debt 상환** (debt ①): KiCad·Elmer·
  openEMS 등 10 OSS + ANSYS Icepak·COMSOL 등 4 상용 검증, 출처
  15건 §5 등재, 13맵과 동급 provenance.
- ✅ **macOS cockpit = project workbench 골격 완결 (measured-green)**:
  rfc_012 workbench — ①7-verb recipe rail ·
  ②work zone (canvas mode) · ③LLM chat "요리 선생님" · ④toolbar
  3-column + `+` 프로젝트 생성 + manifest 영속화 (App Support,
  D45) + 재료 선반 + verb 진행 + chat↔verb 연동 + θ-2 액션 골격 +
  §4.2 REJECTED 가드 + domain-aware canvas mode + UX 마감. 매
  phase `swift run` 빌드 green · `/Applications/demiurge.app`
  설치. 단 *틀* 완결이지 측정 0 (아래 🕳️).
- ✅ **chip §B+§D = `GATE_CLOSED_MEASURED` · `absorbed=true`** (κ-43·
  D70) — hexa-native `sweep_oracle_parity.hexa` 가 rfc_003 §4 의
  acceptance 12행 (§B 4 full-curve + §D 6 headline + Leighton 2) 을
  12/12 GREEN 으로 측정. D9 의 `GATE_B_PINNED_MET` 해소. §D 는
  headline-number parity (full per-flit DES 곡선형상은 후속 phase).
- ✅ **STDLIB 2-layer 구조 완성 (D72 — hexa-lang 소유)** — κ-45.
  hexa-lang `origin/main` `7332e162` 에 ①a `kernels/` 13개 (graph·
  fem·mc_transport·orbital·wave_optics·noc_sim·logic_synth·circuit·
  plasma·neural·signal_proc·urdf·solar) + ①b 도메인 어댑터 15개
  (전부 thin). N×M → N+M 재사용 구조 성립 — 새 도메인은 어댑터 한
  줄 import. demiurge 측 producer 무변경 (D61 pointer-only). g3 —
  구조 재배치, 측정/gate/absorbed 변경 0; absorbed=true flip 은
  여전히 측정 후 (제1 원칙 — 모든 커널 ultimate form 은 hexa-native).
- ✅ **빈-셀 sweep ROI 1→18 17 cell dispatch + cern+synth dynamic
  flip (D73·D74)** — κ-47..κ-51. firmware 16번째 도메인 추가 +
  ROI 1→10 (κ-47/48) + ROI 11→18 (κ-49) substrate landed (heavy
  install-gated honest skips 포함). κ-50 7 parity attempt 노트 (5
  cell measure-but-don't-flip, 1 ⭐ flip 후보). κ-51 에서 cern+synth
  absorbed=true 두 번째 *동역학* 흡수 (β_x_max rel err 2.57e-14 ·
  Q_x rel err 4.11e-14 vs Wiedemann/Lee thick-quad twiss closed
  form, 1e-6 tol 의 8 orders 안쪽; chip §B+§D 이후 첫 새 도메인
  dynamic). ProducerRegistry (D74) 도입 — cells with alternative
  producers, 첫 적용 = `(cern, analyze)` = {xsuite-tracking default,
  pylhe legacy}. mc_transport kernel = 4 consumer = D72 N+M payoff
  실증. **honest 갭**: 7 parity attempt 중 1 flip · 4 측정만-flip
  보류 · 2 fail; D73 firmware reference target QEMU mps2-an385 은
  dispatch wiring 후속; ProducerRegistry typed Codable Record 후속
  phase.
- ✅ **D77~D86 governance + G1-G8 architectural sweep land**
  (κ-56..κ-64). 두 시뮬레이션 (alien-disc-mk1 + aura-clip-mk1, ARCH
  §11) 가 발견한 8 gap 모두 [x] full · 9 audit-trail decisions:
  - D77 chem+bio+ufo 도메인 추가 (16→19, 짧은-id naming)
  - D78 graph DAG + multi-facet tag (Option 3, direct prereq only)
  - D79 reserved (.demi naming pick; superseded into D83/D85)
  - D80 g_hexa_only first-principle (AGENTS.tape INDEX top, ARCH §0)
  - D81 chem/bio/ufo specifics (skeleton domain markdown)
  - D82 graph DAG impl (Domain.swift prereq+facets + DomainGraph)
  - D83 .demi format (TOML-풍 declarative, DemiParser, INDEX.demi)
  - D84 2-tier (built-in + user `u/` prefix, per-machine `.demi`)
  - D85 PRODUCERS.demi (sibling-repo dispatch declarative SSOT)
  - D86 g_no_hardcoded_data (AGENTS.tape #2, code-vs-data 강화)
  G-checklist: G1 facet→DAG UI · G2 skipped-cell dashboard · G3
  SiblingRepoSpawner · G4 ProducerRegistry+Sibling · G5
  FalsifierEntry+HexaNativeParityRef · G6 FalsifierCascade · G7
  GateType taxonomy · G8 LatticeInvariant 모두 [x] full.
- 🟡 **engine tool — chip / cohort 다수 라이브, 측정 도구 점증** —
  θ-2 가 돌릴 실제 producer 가 κ-34~64 로 다수 wired (chip+verify
  sweep_oracle_parity 가 첫 *동역학* 측정; cern+synth κ-51 이 두
  번째; matter·chip-analyze 는 static absorbed). seam records 0
  (rfc_007/008 v0 의도적 빈칸 = g3 위조 0) 는 유지. Yosys §4 모듈은
  여전히 hexa-lang 세션 항목. heavy candidates (Geant4/CARLA/Drake/
  OpenMC nuclear data) 별 세션 install + 측정 라운드 대기 — κ-65
  에서 5 sub-agent (mini/ubu-1/ubu-2 pool) 발사 (gate_type adoption /
  hexa-native solar 시범 / Geant4 / OpenMC / pyfemm Linux). cross-
  session 차단점: `~/core/hexa-lang` live tree 가 concurrent session
  branch → demiurge spawn 이 default xsuite-tracking substrate 못
  봄 (origin/main 에는 있음).
- 🟡 **hexa-native ultimate-form — RFC 013 MOSTLY-LANDED (D80 ·
  κ-67) + post-closure geodesy bridge** — chip §B+§D 이외 모든
  cell 은 여전히 Python 기반 substrate, 단 D80 parity surface
  자체가 데이터·producer·UI·governance 한 사이클로 박제됨. κ-66
  8 pilot 위에 κ-67 sweep (D87..D108 · D104 reserved · 21 결정)
  + 후속 geodesy pilot (acac78c · post-D108) 으로:
  **14 D80 pilots · 445 cumulative assertions** (κ-66 8 + Round-5
  신설 transport_kinematics · breaker_trace_reduce · fem_bar1d_
  subset · autodiff_dual_forward · bio_align_nw · chem_arrhenius +
  post-closure geodesy_wgs84 70/70) · **15 kernel folders** (기존
  10 + chem · autodiff · fem · bio_align + geodesy 신설) ·
  **16 PILOTS.demi rows** (15 + geodesy bridge substrate) ·
  **5 `.demi` SSOTs** (INDEX · DEPENDENCIES · PILOTS ·
  SUBSTRATE_LINKS · PRODUCERS) · **HexaNativeParityRef × 5 cell
  carriers** (Ufo + Fusion + Aura + ChipAnalyze + Energy) ·
  **4-case chip UI** (D99 3-case + D106 `.illustrativePhysics`
  cyan tone) · **ARCH §11.4 G1..G24 Round 1-6** [x] 전부 완료 +
  G25/G26 post-closure bracket. RFC 013 status `PARTIAL-LAND`
  → `MOSTLY-LANDED` (D105) — §6.1..§6.10 + §6.12 LANDED, §6.11
  (per-cell measured-oracle) 만 queued. honest gap: substrate-
  parity ≠ measurement-parity 의 typed enforcement (D103
  dimension + D106 illustrativePhysics) 가 착륙했지만, 어떤
  demiurge cell 도 아직 `absorbed=true` 로 flip 안 함 — 14 pilot
  의 algorithm-level closure 는 hexa-lang 측 사실, demiurge cell
  단위 measured-oracle parity round 는 후속 (P-⑩ ① · κ-68
  reserved). geodesy 는 4 consumer (mobility·space·solar·grid)
  bridge substrate 로, ①b adapter port 가 long-tail 의 다음
  단위. long-tail = 12→3 kernel + 18 도메인 adapter 잔여.

> GOAL 한 줄(north-star)은 불변 — 달성 주장 아님, 측정 거리 명시.

## cross-link

- `design.md` — 결정 감사추적 (gated picks SSOT — D-번호 SSOT)
- `AGENTS.tape` — 강제 거버넌스 (`g_stdlib_ownership`·g3·`@F`)
- `CHARTER.md` + `HANDOFF.md` — mission / arch / why
- `PLAN.md` — `## 계획`(GUI 완성까지 forward) + `## 진행 로그`(append-only)
- `proposals/rfc_*` · `cockpit/` (Swift workbench) ·
  `domains/`(14 + `matter/`) · `archive/comb/`
- `README.md` — 콜드 엔트리 7-verb 가족

---

---

Historical log entries are in [`./GOAL.log.md`](./GOAL.log.md).
