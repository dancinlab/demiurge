# GOAL — hexa-arch 의 한 문장

```
/goal hexa-arch 가 — 칩 전용 EDA 툴이나 단일-도메인 모델러가 아니라 — 어떤 공학 시스템이든 명세→구조→설계→해석⟲→합성→검증→인계 7-verb 로 *설계 자체*를 계산·검증하고, 물질합성→칩아키텍쳐→부품설계를 한 줄로 잇는, 측정 전엔 무엇도 과대주장하지 않는(g3) 정직한 hexa-native 메타-컨덕터가 되게 만든다.
```

> **한 문장 (canonical)**: hexa-arch 는 분야-무관 7-verb 로 *설계 자체*를
> 계산·검증하고 외부 선행기술을 공개면 clean-room 으로 흡수해 **물질→칩→
> 부품을 직렬로 지휘**하는, **정직(no-over-claim, g3)** 한 hexa-native
> 메타프레임워크다.

## 무엇이 아닌가 (NOT)

- 칩 전용 EDA 툴 아님 (chip 은 *도메인 1개*; cohort = cern·antimatter·
  rtsc·space·energy·brain + 14 맵)
- 단일-도메인 모델러 아님 (vs SysML / Modelica — 분야 무관 spine)
- proprietary 블랙박스 아님 (vs Cadence / Synopsys — cited·공개감사·honest-gated)
- 물질/분자 *계산기* 아님 — 그건 hexa-matter(물질)·hexa-bio(분자);
  hexa-arch 는 **설계 자체**를 계산 (hexa-matter·hexa-bio·comb 모두
  typed-interface 소비 — hexa-matter 흡수 SSOT = hexa-lang, D17 이
  D12 supersede; hexa-arch 는 소비자)
- 측정 없이 "absorbed/parity/resolved" 주장하는 것 아님 (g3 — `@F f2`)

## 무엇인가 (IS)

- 분야-무관 **7-verb** (`명세→구조→설계→해석⟲→합성→검증→인계`, 9
  라이프사이클 cited — `design.md` D5) 로 설계를 계산·검증
- **메타-컨덕터** (D11): 물질합성→칩아키텍쳐→부품설계를 직렬로,
  각 pass 의 HANDOFF → 다음 pass 의 SPECIFY (rfc_004 §3/§4)
- 외부 선행기술을 **공개면 clean-room** (D1) 으로 흡수 → hexa-native
  (재사용 모듈은 `hexa-lang/stdlib/`, D15 — hexa-arch 는 소비자)
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

**메타프레임워크 design-baseline 완결, GUI 미완·체인 미배선.** north-star
불변. 측정된 거리:

- ✅ 7-verb spine cited (9 라이프사이클) · 14 도메인 공개면 맵 ·
  rfc_001..005 · AGENTS.tape 거버넌스 · D1–D16 감사추적 · comb archive
- ✅ **hexa-matter measured-parity 검증됨 (단, hexa-lang 소유 — D17)**:
  rfc_005 §4 selftest **38/38** · parity **29/29** · verify 4/4 ·
  36/36 spec 는 실측 사실이나, ④ 조사로 그것이 **hexa-lang 의 이미
  완료된 흡수**임이 드러남. D17 = hexa-lang SSOT · hexa-arch 는
  소비-포인터 (`domains/matter/` 중복 사본 git-rm, pointer 化;
  rfc_005 tombstone CANCELLED). over-claim 0 — hexa-arch 는 흡수
  소유 주장 안 함.
- 🟡 chip §B = **GATE_B_PINNED_MET** — pinned 기준 PASS(모델 단순화
  하에) 이나 full-curve parity·§D 미입증; `absorbed=false` 유지 (g3).
- 🕳️ **GUI 미완** (D16 = macOS Swift, *설계 결정만*; 빌드 downstream) ·
  chain seams 미배선 · hexa-matter tombstone ⑤⑥ GATED · hexa-lang
  booksim 커밋 미push.

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
