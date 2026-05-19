# ABSORPTION — 외부 도구 흡수 가이드

> demiurge 가 외부 라이브러리·도구를 도입할 때 *어느 영역으로 가는지*
> 의 분류 + 절차. rfc_001~005 의 "absorption" 용어와 직접 일관 — 모든
> 새 도구는 ①~⑤ 영역 중 적절한 곳으로 배치된다.

## 핵심 원칙

> ⚠️ **제1 원칙 — 모든 producer 는 결국 hexa-native (`.hexa`) 로
> 작성한다.** Python · shell · docker substrate wrapper 는 *임시
> stepping-stone* 일 뿐 흡수의 종착점이 아니다. `absorbed=true` 는
> `hexa-lang/stdlib/<domain>/<tool>.hexa` 가 **자체 측정**해 parity
> 를 통과할 때만 부여된다 (D17 · D61 · 아래 「hexa 포팅 단계」 §).
> substrate 단계에 영구히 머무는 것은 **흡수 실패**다 — 새 producer
> 는 substrate 로 시작하되, hexa-native 포팅이 명시적 다음 목표로
> 기록되어야 한다 (PLAN.md κ entry + design.md D-decision).

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

## hexa 포팅 단계 (substrate → absorbed=true)

`①` STDLIB 의 Python / shell wrapper 는 **임시 substrate**이지
최종 목표가 아닙니다. **absorbed=true 의 전제는 hexa-native 재구현**
— D17 matter parity 의 패턴.

```
Stage 1   substrate wrapper       Python · shell · docker spawn
          ──────────────────       hexa-lang/stdlib/<domain>/<tool>.py
                                   외부 도구 binary 의 신뢰에 기댐
                                   measurement_gate = OPEN 또는 CLOSED
                                   ✗ absorbed = false (도구는 외부)
                │
                ▼   clean-room 재유도 (알고리즘만, 코드 NO)
                │
Stage 2   hexa-native 포팅          .hexa 모듈
          ──────────────────       hexa-lang/stdlib/<domain>/<tool>.hexa
                                   알고리즘 자체 재유도, spawn 0
                │
                ▼   parity check (substrate vs hexa output ± tol)
                │
Stage 3   parity 측정               rfc_001~005 §8 measured-gate 패턴
          ──────────────────       PASS → absorbed=true 권한 획득
                │
                ▼
Stage 4   absorbed=true            gate=CLOSED_MEASURED + absorbed=true
          ──────────────────       D17 matter / Leighton chip+analyze 예
```

**현재 단계별 producer 분류**:

| Stage 4 (absorbed=true)   | Stage 1 (substrate, absorbed=false) |
|---------------------------|-------------------------------------|
| matter+analyze (hexa-matter) | sscb / grid / bot / energy / space  |
| chip+analyze (Leighton 수학) | component / brain / mobility / fusion |
| chip+verify (booksim §B+§D κ-43, 12/12 GREEN) | antimatter / cern / aura / scope |
|                             | chip-synth(yosys substrate) |

**Stage 2→3 진입 (hexa-native port + parity 측정, 단 Stage 4 미부여)**:
`fusion+analyze` (κ-41 — `plasma_metrics.hexa`, parity 9/9) ·
`component+verify` (κ-39 addendum — `heat_conduction.hexa`, thermal
parity 4 %) · `sscb` (κ-40 — `wolfspeed.hexa` parser). 셋 다 clean-room
hexa-native 재유도 + substrate parity 는 통과했으나 입력이 textbook/
synthetic 이라 `absorbed=false` 유지 — Stage 4 는 측정된 입력 필요.

**hexa 포팅 난이도 (참고)**:

| producer            | hexa 포팅 작업량                            |
|---------------------|--------------------------------------------|
| networkx (grid)     | ⭐⭐ — graph algorithm stdlib, 작음           |
| urdfpy (bot)        | ⭐⭐ — XML parser + tree                     |
| skyfield (space)    | ⭐⭐⭐ — SGP4 propagator, 표준 알고리즘         |
| pvlib (energy)      | ⭐⭐⭐ — clear-sky 모델 + PV I-V curve        |
| ngspice (sscb)      | ⭐⭐⭐⭐ — sparse solver + MNA + trapz       |
| yosys (chip)        | ⭐⭐⭐⭐ — read_verilog scope 확장 (이미 일부)   |
| FreeCAD (component) | ⭐⭐⭐⭐⭐ — OpenCascade B-Rep kernel clean-room |
| Code_Aster          | ⭐⭐⭐⭐⭐ — FEM solver 전체                    |
| Geant4              | ⭐⭐⭐⭐⭐ — Monte Carlo 입자 simulator         |
| OpenFOAM            | ⭐⭐⭐⭐⭐ — CFD solver                       |

⚠️ 대부분 거대 도구는 hexa 포팅이 매우 큰 작업 (수개월~수년).
substrate 상태에서 GOAL 의 "측정 전엔 과대주장 금지" (g3) 가 정확히
적용 — `absorbed=false` 유지. **substrate 측정 ≠ 흡수**.

D17 matter parity (29/29 PASS) 가 hexa 포팅의 *최초* 완성 사례 —
hexa-lang/stdlib/matter 가 자체 hexa-native, parity ±tolerance 후
absorbed=true 권한.

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

> gate·absorbed 값은 각 `exports/<domain>/` record 의 provenance
> 필드를 SSOT 로 그대로 옮긴 것 (g3 — 표가 record 를 위조하지 않음).

| 도메인     | verb       | producer                       | 영역  | gate                              | absorbed |
|-----------|------------|--------------------------------|-------|-----------------------------------|----------|
| chip      | verify     | booksim sweep_oracle_parity (§B+§D) | ①+④ | GATE_CLOSED_MEASURED          | **true** |
| chip      | synthesize | yosys substrate                | ①+④   | GATE_CLOSED_MEASURED (substrate)  | false ✱  |
| chip      | analyze    | hexa_native_booksim_oracle (Leighton) | ①+④ | GATE_CLOSED_MEASURED (analytic) | **true** |
| matter    | analyze    | hexa-matter closure aggregator | ①+④   | GATE_CLOSED_MEASURED              | **true** |
| component | synthesize | freecad 1.1.1 parametric       | ④     | GATE_OPEN                         | false    |
| component | verify     | gmsh 4.15.2 + scikit-fem 12.0.1 FEM | ①+④ | GATE_OPEN                       | false    |
| sscb      | analyze    | ngspice 46 transient           | ①+④   | GATE_OPEN                         | false    |
| grid      | structure  | networkx 3.2.1 IEEE 14-bus     | ④     | GATE_CLOSED_MEASURED              | false    |
| energy    | analyze    | pvlib 0.15.1 clear-sky         | ④     | GATE_OPEN                         | false    |
| space     | analyze    | skyfield 1.54 + sgp4 2.25      | ④     | GATE_OPEN                         | false    |
| brain     | analyze    | brian2 LIF (no record on disk yet) | ④ | GATE_OPEN                         | false    |
| mobility  | analyze    | osmnx 2.1.0 road-network       | ④     | GATE_OPEN                         | false    |
| aura      | analyze    | mne 1.12.1 EEG band-power      | ④     | GATE_OPEN                         | false    |
| scope     | analyze    | poppy 1.1.2 optical PSF        | ④     | GATE_OPEN                         | false    |
| bot       | structure  | yourdfpy 0.0.60 URDF parser    | ④     | GATE_OPEN                         | false    |
| antimatter| analyze    | particle 0.26.2 PDG lookup     | ④     | GATE_OPEN                         | false    |
| cern      | verify     | particle 0.26.2 + Bethe-Bloch analytic | ①+④ | GATE_OPEN                   | false    |
| cern      | analyze    | pylhe 1.0.4 LHE event stats    | ④     | GATE_OPEN                         | false    |
| fusion    | analyze    | plasmapy 2026.2.0 derived params | ①+④  | GATE_OPEN                       | false ✦  |

✦ **Stage 3 parity 통과, 단 absorbed=false (g3)** — fusion+analyze 는
substrate (`plasma_metrics.py`, plasmapy) **와** clean-room hexa-native
port (`plasma_metrics.hexa`, plasmapy 코드 0) 를 둘 다 갖고, Stage 3
parity test 9/9 PASS (κ-41 / D69). 그러나 `absorbed=false` *영구* —
입력 운전점 (n_e=1e20·T_e=10keV·B=5.3T) 이 textbook ITER reference 일
뿐 실제 토카막 측정이 아니기 때문. Stage 4 absorbed=true 는 real
device shot (Thomson-scattering / interferometry) 가 producer 에
연결돼야. matter (D17) 와 대비: matter 는 입력도 측정값이라 Stage 4,
fusion 은 hexa-native 재유도는 됐으나 입력이 textbook → Stage 3 에서
정직하게 멈춤.

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

## 흡수 후보 우선순위 (deep research 2026-05-20)

> 두 deep-research 라운드 (web + arxiv) 의 통합 우선순위. "필요한
> 부분만" 골라 흡수하도록 ROI 순 — `inbox/notes/absorption-empty-
> cells-research-2026-05-20.md` (18 빈 measurable 셀) +
> `inbox/notes/hexa-8domain-measurement-stack-2026-05-20.md`
> (rtsc·cern·antimatter·ufo·space·fusion·mobility·aura 실측 stack).

### 즉시 가능 — 도구 이미 설치 / pure-pip macOS quick win

| 셀                  | producer 후보              | ROI       | 비고 |
|--------------------|---------------------------|-----------|------|
| sscb + synthesize  | FEMMT (이미 설치)          | ⭐⭐⭐⭐⭐ | Swift wrapper 만 |
| sscb + verify      | ngspice / OpenFOAM (설치)  | ⭐⭐⭐⭐⭐ | Swift wrapper 만 |
| scope + verify     | POPPY / WebbPSF (pip)      | ⭐⭐⭐⭐⭐ | scope+analyze 확장 |
| cern + synthesize  | Xsuite + cpymad (pip)      | ⭐⭐⭐⭐  | cern 3/4 완성 |
| component + analyze| CalculiX                   | ⭐⭐⭐⭐  | κ-44 gmsh+scikit-fem 확장 |
| space / energy + synthesize | poliastro · PyPSA (pip) | ⭐⭐⭐ | |

### substrate 업그레이드 — 1점 → full stack (GOAL P-⑧ fast path)

| 도메인  | 현재 substrate | 업그레이드      | ROI   |
|--------|---------------|----------------|-------|
| aura   | MNE 1점       | + mne-connectivity | ⭐ |
| space  | skyfield      | + poliastro     | ⭐⭐  |
| fusion | plasmapy      | + FreeGS (평형) | ⭐⭐  |
| cern   | Bethe-Bloch   | + Xsuite tracking | ⭐⭐ |
| mobility | osmnx       | + SUMO traffic  | ⭐⭐  |

### 중간 — 설치 의존성 있음

| 셀             | producer            | ROI    | 비고 |
|---------------|---------------------|--------|------|
| rtsc + analyze | FiQuS (CERN STEAM)  | ⭐⭐⭐ | pip + Gmsh + GetDP 필요. rtsc 는 producer 0 — 최고 레버리지 빈 도메인. arxiv 2311.09177 |

### 무거움 / blocked (honest)

- **Geant4** — antimatter · cern · fusion 공유 transport producer 1개로
  8/13 도메인 레버리지 가능하나 multi-hour C++ 빌드 (⭐⭐⭐⭐⭐).
- **antimatter 진짜 측정** — packaged OSS non-neutral-plasma / trap
  simulator **없음** (honest gap). 연구실은 bespoke PIC/MD. WarpX-PIC
  / LAMMPS-MD 가 adaptable proxy.
- **CARLA** (mobility+verify) — macOS 빌드 없음, Linux pool 전용.
- **proprietary gap** — space reentry (SCARAB/DRAMA) · fusion edge
  (SOLPS-ITER) · mobility SOTIF · aura Sim4Life — domain-map §4 와 일치.
- **ufo** — domain map 자체가 없음. 측정 라이브러리 없음 →
  `domains/ufo.md` 를 먼저 작성해야 producer 작업 가능.

### 종합 ROI 우선순위

```
즉시:   sscb(synth·verify) → scope(verify) → cern(synth) → component(analyze)
fast:   aura → space → fusion → cern → mobility (substrate 업그레이드)
중간:   rtsc(FiQuS)
보류:   antimatter 실측 · Geant4 공유 transport · ufo (domain map 먼저)
```

모든 후보는 substrate 로 시작하되 **제1 원칙** — hexa-native 포팅이
명시적 다음 목표 (위 「핵심 원칙」 + 「hexa 포팅 단계」).

## See also

- D15 — stdlib 은 hexa-lang 단독 소유
- D17 — matter parity 가 hexa-lang SSOT (demiurge consumer)
- D50 — g_ssot_single_source / CLI↔cockpit 멱등
- D53 — 7-verb 셀 매핑 = measurable-only
- D54 — component synthesize = FreeCAD parametric
- D55 — sscb analyze = ngspice transient (first cohort producer)
- D61 — producer script SSOT = `~/core/hexa-lang/stdlib/<domain>/<tool>.py`
  (sibling repo; `cockpit/scripts/*.py` 금지 for NEW producers)
- aura + scope analyze 동시 cohort sweep (MNE-Python + POPPY; D61
  producer SSOT 정합 박제) — cohort 병렬 라운드 producer, standalone
  PLAN κ / D-block 없음 (post-merge reconstructed)
- rfc_001 §8 · rfc_002 §3 — F1F2 schema + 측정 gate 규칙
- `proposals/rfc_001` ~ `rfc_005` — 도메인-별 absorption RFC

## 포그라운드 직접 진행용 프롬프트 카탈로그

> 오래 걸리는 producer (FEM 시뮬 · device-model 흡수 · 거대 도구
> 설치 · multi-config sweep · 큰 학습 곡선) 은 background sub-agent
> 보다 **별도 Claude Code 세션에서 사용자가 직접 진행**하는 것이
> 안전합니다 — sub-agent 는 토큰 / 시간 한계로 commit 직전에 끊길
> 위험이 큽니다 (실제 사례: bot+structure Agent 가 verify 단계에서
> 토큰 끊김).

### Template — 새 producer 1셀 wiring

```
demiurge `<DOMAIN> + <verb>` 셀에 lowest-hanging-fruit producer 를
추가해주세요.

repo: ~/core/demiurge. AGENTS.tape `@D g_demiurge_pointer_only` (D61)
필수 준수:
- producer script SSOT = `~/core/hexa-lang/stdlib/<DOMAIN>/<tool>.py`
  (또는 hexa-native wrapper). hexa-lang 디렉토리 새로 만들 것.
- demiurge 측 = `cockpit/Sources/DemiurgeCore/Loaders/
  <Domain><Verb>Producer.swift` (`Process` spawn wrapper 만).
- `cockpit/scripts/*.py` 절대 만들지 말 것 — 위반시 PR block.

패턴: matter / sscb / energy / chip-analyze / grid producer 의
D17 / D61 정합 미러.

작업:
1. `domains/<DOMAIN>.md` §2 도구맵 → 가장 가벼운 OSS (pip · brew 한 줄).
2. `hexa-lang/stdlib/<DOMAIN>/<tool>.py` — 표준 sample, 측정 한 점.
3. demiurge Swift `<Domain><Verb>Producer.swift` (spawn) +
   `<Domain>Record.swift` typed + `ActionDispatch` case.
4. `design.md` D-num + `PLAN.md` κ-num + `ABSORPTION.md` ④ 표 row
   추가 + `exports/<DOMAIN>/` record emit.
5. 빌드 green + `swift run DemiurgeCLI action <verb> <DOMAIN>` 검증.
6. commit (push 는 사용자 결정).

g3: GATE_OPEN / absorbed=false 기본 (외부 도구). 수학적 fact 면
GATE_CLOSED_MEASURED 가능 (chip+analyze · grid+structure · matter
+analyze 의 패턴). hexa-native 자체 측정만 absorbed=true.

Pool 자원: wilson-pool 의 Bash hook 이 무거운 명령 (swift build /
hexa run / docker run / brew / pip 등) 을 자동으로 mini(macOS) ·
ubu-1(linux) · ubu-2(linux) 에 round-robin 라우팅. 명령을 묶지 말고
한 번씩 흘려보내 hook 이 분배하게 할 것. macOS 부하 분산 = 사용자
명시 우선사항. mini 다운이면 macOS-only 명령(swift run · freecadcmd
등) 은 로컬로 폴백.
```

### 무거운 후보 — 별도 세션 권장

| 후보                                | 도구                         | 비용     | 상태  |
|------------------------------------|------------------------------|----------|-------|
| antimatter / cern + measured       | Geant4 + ROOT                | 1-2일    | 진행  |
| fusion + verify (CFD)              | `hexa-lang/stdlib/fusion` 포팅 (clean-room) | 1-2주 |       |
| Wolfspeed SiC `.lib` 흡수 (sscb)   | 측정 데이터 + DEVSIM TCAD    | 수일     | ✅ κ-41 — `stdlib/sscb/` 7모듈 GREEN. **DC 디바이스 모델 `absorbed=true` (D71)**: hexa-native VDMOS DC solver (`vdmos.hexa`, subprocess 0) 가 실 Wolfspeed C3M0021120K datasheet Rev.4 의 R_DS(on)·V_GS(th) 를 1.08%·2.15% 재현 (ngspice cross-check 0.0212265Ω 소수5자리 일치). transient 회로 시뮬은 별개 scope (substrate). |
| chip §B full-curve parity          | booksim 9-sweep + parity     | 수일     | ✅ κ-43 (경로결정 κ-37) |
| Yosys hexa-native absorbed=true    | `stdlib/yosys/read_verilog` scope 확장 (localparam · generate · always · function automatic · multi-D mem · signed arith) → router_d{4,6}.v hexa-native 합성 → ±5% 오라클 매치 | 1-2주 | 진행  |

### 사용법

새 Claude Code 세션 열고 위 Template 을 그대로 복사 + `<DOMAIN>` /
`<verb>` 치환. background sub-agent 가 아니라 **포그라운드** 에서
사용자가 진행하면 토큰 한계로 끊길 위험 없음. 무거운 후보는 hint
1줄 추가 ("OpenFOAM tokamak SOL pipe flow" 같은) 로 producer 의
스코프를 좁힐 것.

### Pool 자원 활용 (wilson-pool)

이 머신은 wilson-pool roster (mini · ubu-1 · ubu-2) 에 자동
라우팅됩니다. macOS 본체 부하 회피가 사용자의 명시 우선사항이라
**무거운 명령은 일부러 묶지 말고 그대로 흘려보내는 것이 원칙** —
hook 이 알아서 분배합니다.

```
호스트     │ 플랫폼   │ 라우팅 대상
──────────┼─────────┼───────────────────────────────────
mini      │ macOS   │ swift build · freecadcmd · macOS-only
ubu-1     │ linux   │ pip · docker · gmsh CLI · yosys 등
ubu-2     │ linux   │ ubu-1 와 round-robin (load balance)
local mac │ -       │ pool 호스트 다운시 fallback (swift run)
```

- 모든 사용자 prompt 와 sub-agent prompt 에 "wilson-pool hook 이
  자동 라우팅 — 명령 묶지 않고 흘려보내라" 한 줄 명시 권장.
- `docker run` · `pip install` · `brew install` · `swift build` ·
  `hexa run` 모두 hook 이 감지.
- Read · Write · Edit · Grep 은 항상 local (file edit 은 동기화 안
  됨).
- mini 다운 사례: 라우팅 시도 → SSH timeout → ubu fallback or
  local. 빌드 끊김 발생 시 wilson-pool 상태 확인 (`! ssh mini` 등)
  후 재시도.

---

## Log

- 2026-05-20 — created. 외부 라이브러리/도구 흡수 시 ①~⑤ 영역 (STDLIB
  / DOMAIN_MAP / RECORD / WORKFLOW / HONESTY) 분류 + 8-단계 흡수 절차
  + 현재 흡수된 producer 5건 표 + 가벼운 distrib 선호. substrate vs
  absorbed 구분 (Yosys §5 사례) 명시. 새 D-decision 없음 — 기존
  D15/D17/D50/D53~D55 + rfc_001~005 cite.
- 2026-05-20 — **제1 원칙 추가** (사용자 지시): 모든 producer 의
  최종 형태 = hexa-native (`.hexa`), substrate wrapper 는 임시
  stepping-stone. 핵심 원칙 최상단에 박제. + 두 deep-research
  라운드 통합 「흡수 후보 우선순위」 섹션 추가 — 18 빈 measurable
  셀 + 8 도메인 (rtsc·cern·antimatter·ufo·space·fusion·mobility·
  aura) 실측 stack, ROI 순, arxiv reference 동반, macOS-blocked
  honest 명시. 새 D-decision 없음 — research 정리.
- 2026-05-20 — κ-39 (D66) — `component + verify` 행이 "현재까지
  흡수된 producer" 표에 추가됨 (gmsh 4.15.2 + scikit-fem 12.0.1,
  GATE_OPEN, absorbed=false). 동시에 "무거운 후보 — 별도 세션 권장"
  표에서 같은 행 제거 — docker (Salome-Meca 5 GB+) 가 아니라 pip
  라이브러리 4종 (gmsh · scikit-fem · meshio · numpy, ~70 MB) 만으로
  흡수가 가능했기 때문 (당초 가정 = docker 필수). SECOND
  D61-compliant-from-birth producer (script SSOT = `~/core/hexa-lang/
  stdlib/component/gmsh_skfem.py`).
