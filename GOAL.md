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

**4-Phase 설계 design-complete, 코드·앱·wired·absorbed 모두 0.**
north-star 불변. 측정된 거리 (g3 — 과대주장 금지):

- ✅ **설계 골격 완결**: 7-verb spine cited (9 라이프사이클·D5) ·
  **15 도메인 공개면 맵** (13 Cohort cited + `component.md` cited
  this session per D21 + `matter/` D17 pointer) · **RFC 9건**
  (rfc_001/002/003 booksim+F1F2·rfc_004 e2e·rfc_005 SUPERSEDED D17·
  rfc_006 Yosys 설계+D18/D19·rfc_007/008 두 seam v0·rfc_009 macOS
  Swift cockpit spec) · **design.md D1–D22 감사추적** ·
  AGENTS.tape 거버넌스 (D22 정합) · CHARTER+HANDOFF reconciled.
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
- 🟡 **chip §B = `GATE_B_PINNED_MET`** — pinned PASS(모델 단순화),
  full-curve parity·§D 미입증; `absorbed=false` 유지.
- 🕳️ **코드·앱 0** (Swift 빌드 = D22 downstream OOS) · **seam records
  0** (rfc_007/008 v0, `records/` 의도적 빈칸 = g3 위조 0) ·
  **Yosys §4 모듈 미구현** (hexa-lang 세션, D19) · **`d5a63a82`
  미push** (hexa-lang 세션 ahead 18) · 어떤 도메인도 `absorbed=true`
  아님.

> GOAL 한 줄(north-star)은 불변 — 달성 주장 아님, 측정 거리 명시.

## cross-link

- `design.md` — D1–D16 결정 감사추적 (gated picks SSOT)
- `AGENTS.tape` — 강제 거버넌스 (`g_stdlib_ownership`·g3·`@F`)
- `CHARTER.md` + `HANDOFF.md` — mission / arch / why
- `PLAN.md` — `## 계획`(GUI 완성까지 forward) + `## 진행 로그`(append-only)
- `proposals/rfc_001..005` · `domains/`(14 + `matter/`) · `archive/comb/`
- `README.md` — 콜드 엔트리 7-verb 가족

---

## Log

- 2026-05-18 — GOAL.md 생성 (anima/GOAL.md 포맷 미러: 한문장 fenced +
  NOT/IS + 수단-트리 + 정직한-위치(g3) + cross-link + `## Log`).
  canonical 한 문장 = north-star, 불변. 현 정직 위치: design-baseline
  완결 · hexa-matter measured-parity 흡수 ✅ · chip §B GATE_B_PINNED_MET ·
  GUI(D16) 설계만·미빌드. 진척 SSOT = PLAN.md/design.md, 본 파일 = "왜".
- 2026-05-19 — "현재 정직한 위치" 섹션을 post-D22 로 갱신 (north-star
  불변, 섹션만 갱신). 새 측정 fact 추가: 4-Phase 설계 design-complete ·
  RFC 9건 · D1–D22 · 15 도메인맵 · component cited-research debt ①
  상환 · inbox handoff 적재 · `inbox_sync` 통과. 갭은 더 정확히: 코드·앱
  0 · seam records 0 (v0 의도적 빈칸) · Yosys §4 미구현 (hexa-lang
  세션) · `d5a63a82` 미push만 (g3 정정: 61866308 은 이미 push됨). 새
  결정 없음 — position-section 정합만.
