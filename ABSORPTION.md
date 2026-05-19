# ABSORPTION — 외부 도구 흡수 가이드

> demiurge 가 외부 라이브러리·도구를 도입할 때 *어느 영역으로 가는지*
> 의 분류 + 절차. rfc_001~005 의 "absorption" 용어와 직접 일관 — 모든
> 새 도구는 ①~⑤ 영역 중 적절한 곳으로 배치된다.

## 핵심 원칙

- demiurge 는 **메타-컨덕터** — 자체 GUI(cockpit) + 7-verb spine +
  typed record schema 를 가짐.
- 외부 도구는 **계산 커널 / 도메인 지식** 만 제공한다. 그들의
  GUI·wizard·viewer 는 demiurge 가 **재사용하지 않는다**.
- 모든 흡수는 **g3 정직** (측정 전엔 `absorbed=true` 금지) 을 통과한다.

## ①~⑤ 영역 분류

### ① STDLIB — 계산 커널
- **SSOT**: `hexa-lang/stdlib/<topic>/` (D15·D17 — hexa-lang 단독 소유)
- **무엇이 들어가나**: solver · mesher · synthesis · parser · oracle
  알고리즘 (수학·물리 verdict 의 *엔진*)
- **예**: `stdlib/booksim` (NoC sim) · `stdlib/yosys` (synthesis) ·
  `stdlib/matter` (closure invariant) · `stdlib/atoms` (EMT)
- **demiurge 측**: consumer 만. typed-interface 로 record 수신·표시.

### ② DOMAIN_MAP — 분야 공개면
- **SSOT**: `demiurge/domains/<name>.md`
- **무엇이 들어가나**: §1 deliverable · §2 도구맵 · §5 인용 자료 ·
  §6 workbench shelf 옵션
- **예**: `chip.md` · `component.md` · `brain.md` · `sscb.md` ·
  `energy.md` ·  …(15 도메인)
- **누가 만드나**: domain expert + AI 합작, cited research 동반.

### ③ RECORD — typed interface
- **SSOT**: `proposals/rfc_002` (F1F2 schema) +
  `cockpit/Sources/DemiurgeCore/Models/`
- **무엇이 들어가나**: F1F2Record (chip) · ComponentRecord
  (component) · MatterRecord (matter) · 새 도메인-별 Record
- **공통 provenance 필드**: `absorbed` · `measurement_gate` ·
  `scope_caveats` · `producer`
- **모든 producer 는 이 schema 에 맞춰 emit** — demiurge 가
  byte-identical 하게 디코딩.

### ④ WORKFLOW — verb × domain 매핑
- **SSOT**: `cockpit/Sources/DemiurgeCore/Loaders/ActionDispatch.swift`
  의 `runEngineTool(verb:, domain:)` switch
- **무엇이 들어가나**: 어느 (verb, domain) 셀에 어느 producer 가
  매핑되는지
- **정책 (D53)**: measurable-only — 합성·검증·해석 등 측정-verb 셀만
  매핑, LLM 5 verb 는 claude CLI fallback 영구 유지.
- **추가 방법**: producer 가 ① 에 라이브하면 case 한 줄 추가 — 어댑터
  패턴은 매핑 5+ 시점 (premature abstraction 회피).

### ⑤ HONESTY — provenance · gate · g3
- **SSOT**: `AGENTS.tape` 의 `g3_no_over_claim` + `design.md` D-decisions
- **무엇이 들어가나**: `absorbed=true` 의 정의 · gate 4-state 의 의미
  (OPEN / B_PINNED_MET / CLOSED_MEASURED / FAILED) · scope_caveats
  작성 규칙
- **불변**: 측정 전엔 어떤 셀도 `GATE_CLOSED_MEASURED` /
  `absorbed=true` 주장 금지. 외부 도구의 *substrate-측정* 과 *hexa-
  native absorbed* 는 별개 (Yosys §5 예시).

## 불필요 — 재사용하지 않는 부분

```
외부 도구의 GUI · wizard · viewer · assembly · drawing · sketcher
```

demiurge cockpit (SwiftUI + RealityKit) 이 이 역할을 자체 spine 으로
가진다. 외부 도구는 CLI / Python script mode 로만 호출 — GUI 부분은
dormant.

## 흡수 절차 (체크리스트)

1. **분야 매핑** — 도메인이 ② 의 어느 `.md` 와 일치? 새 분야면
   `domains/<new>.md` 생성, §1~§6 cited.
2. **계산 커널 식별** — 외부 도구의 CLI / Python API 중 *측정 가능한
   부분*. GUI 무시.
3. **stdlib 배치** — `hexa-lang/stdlib/<topic>/` 에 hexa-native wrapper
   또는 clean-room absorption 모듈 작성 (rfc_001 §7.2 패턴).
4. **record schema** — 기존 (F1F2 / Component / Matter) 와 동일 구조의
   새 Record 또는 기존 확장. ③ 에 추가.
5. **매핑** — ActionDispatch.runEngineTool 에 case 추가 (D53 정합).
6. **g3 gate** — scope_caveats · measurement_gate · absorbed 정직
   설정. 측정 없으면 GATE_OPEN.
7. **D-decision** — `design.md` 에 새 producer 도입 결정 기록.
8. **PLAN κ entry** — `PLAN.md` `## 진행 로그` 에 append-only.

## 현재까지 흡수된 producer

| 도메인     | verb       | producer                       | 영역  | gate                              | absorbed |
|-----------|------------|--------------------------------|-------|-----------------------------------|----------|
| chip      | verify     | booksim cmd_measure            | ①+④   | GATE_OPEN                         | false    |
| chip      | synthesize | yosys 0.65 substrate           | ①+④   | GATE_CLOSED_MEASURED (substrate)  | false ✱  |
| matter    | analyze    | hexa-matter closure aggregator | ①+④   | GATE_CLOSED_MEASURED              | **true** |
| component | synthesize | FreeCAD 1.1.1 parametric       | ④     | GATE_OPEN                         | false    |
| sscb      | analyze    | ngspice 46 transient           | ①+④   | GATE_OPEN                         | false    |
| aura      | analyze    | MNE-Python 1.12.1 Welch PSD    | ①+④   | GATE_OPEN                         | false    |
| scope     | analyze    | POPPY 1.1.2 segmented-mirror PSF | ①+④ | GATE_OPEN                         | false    |

✱ **substrate vs absorbed 구분 (g3)** — Yosys §5 는 *외부 yosys
binary + SKY130* 로 측정해서 cited oracle ±5 % 안에 들었으나, hexa-
native `stdlib/yosys/read_verilog` 의 scope 가 부족해 hexa-lang 자체
재현은 미완. **gate CLOSED ≠ absorbed**. absorbed=true 는 hexa-lang
이 *자체* 측정해 동일 결과를 낼 때만 (D17 매트 패턴).

(나머지 셀은 LLM claude fallback — D53 measurable-only 정책에 따라
producer 가 ① 에 들어오는 순서대로 매핑 추가.)

## 가벼운 distrib 선호

`①` 의 도구는 가능하면 **CLI-only / script-mode** distrib 으로:

- Salome-Meca docker (5 GB+, GUI 포함) → `renumics/code-aster` 같은
  CLI-only docker
- FreeCAD.app 전체 (1.5 GB+) → `freecadcmd` 만 사용, GUI dormant
- gmsh CLI 만 (이미 가볍, 83 MB)
- yosys CLI 만 (waveform viewer 무시)

## See also

- D15 — stdlib 은 hexa-lang 단독 소유
- D17 — matter parity 가 hexa-lang SSOT (demiurge consumer)
- D50 — g_ssot_single_source / CLI↔cockpit 멱등
- D53 — 7-verb 셀 매핑 = measurable-only
- D54 — component synthesize = FreeCAD parametric
- D55 — sscb analyze = ngspice transient (first cohort producer)
- D61 — producer script SSOT = `~/core/hexa-lang/stdlib/<domain>/<tool>.py`
  (sibling repo; `cockpit/scripts/*.py` 금지 for NEW producers)
- D67 — aura + scope analyze 동시 cohort sweep (κ-35; MNE-Python +
  POPPY; D61 producer SSOT 정합 박제)
- rfc_001 §8 · rfc_002 §3 — F1F2 schema + 측정 gate 규칙
- `proposals/rfc_001` ~ `rfc_005` — 도메인-별 absorption RFC

---

## Log

- 2026-05-20 — created. 외부 라이브러리/도구 흡수 시 ①~⑤ 영역 (STDLIB
  / DOMAIN_MAP / RECORD / WORKFLOW / HONESTY) 분류 + 8-단계 흡수 절차
  + 현재 흡수된 producer 5건 표 + 가벼운 distrib 선호. substrate vs
  absorbed 구분 (Yosys §5 사례) 명시. 새 D-decision 없음 — 기존
  D15/D17/D50/D53~D55 + rfc_001~005 cite.
- 2026-05-20 — **κ-35 cohort sweep #2~#3**: producer 표에 2 행 추가
  (aura + analyze = MNE-Python 1.12.1; scope + analyze = POPPY 1.1.2).
  See also 섹션에 D61 (producer SSOT = hexa-lang/stdlib/<domain>/) +
  D67 (κ-35 결정) 추가. rtsc 는 honest deferred — Wine 의존 + GetDP
  수작업으로 한 줄 pip 매핑 불가 (inbox/notes/cohort-pickup-rtsc-femm-
  producer.md). 흡수 producer 총 7 종 (chip 2 + matter 1 + component 1
  + sscb 1 + **aura 1** + **scope 1**).
