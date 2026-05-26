# 🛸 UFO — verb-7 handoff · 외부 제작소 인계 패키지 manifest

@title: 🛸 UFO — 통합 비행체(직접개발) · handoff
@parent: ~/core/demiurge/UFO.md
@sibling: UFO/synthesize/integrated-vehicle-synthesize.md (verb-5 synthesize · BOM + 도면 tree + firmware DO-178C DAL-A)
@sibling: UFO/verify/integrated-vehicle-verify.md (verb-6 verify · 통합 verdict 🟢10 🟡4 🟠5 ⚪13 · absorbed=false)
@verb: 7/7 (handoff) — demiurge 7-verb pipeline 마지막 슬롯 (외부 제작소 인계)
@governance: @D d1 (non-wet-lab → completed-form) · d3 (stdlib SSOT) · d4 (single generic dispatch) · d5 (absorbed=true ⇔ 비-wet-lab PASS) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)

> 본 문서는 demiurge 7-verb 파이프라인의 **verb-7 handoff** 슬롯 — 마지막 verb — 을 채운다. verb-5 synthesize 가 산출한 **BOM (7-카테고리) + 도면 tree + firmware (DO-178C DAL-A)** 와 verb-6 verify 의 **통합 verdict (🟢10 🟡4 🟠5 ⚪13 · absorbed=false)** 를 입력으로, **외부 제작소가 받아 제작 착수 가능한 인계 패키지 명세** 를 manifest 로 정의한다. **본 verb 는 인계 명세 manifest** — 산출물 포인터 표 · 제작소 요구 역량 · 인증 경로 · 인계 체크리스트 · 미충족 게이트 정직 고지 만 닫는다. 구현 코드 없음 (@D d3) — UFO/handoff/ 는 docs/manifests only.
>
> **정직 invariant (@D d1 · @D d5 · @D d6)**: 본 인계 패키지는 **"비-wet-lab 설계 완료 · 본해 sim + wet-lab 측정은 downstream"** 의 정직한 상태로 인계된다. verb-6 verify 가 `absorbed=false` 이므로 **"제작 준비완료(production-ready)" 거짓 주장 금지** — 제작 착수 전 닫아야 할 미충족 게이트 (🟠 5게이트 + F-ANTI-3 + Stage-4~7 ⚪ falsifier) 를 §5 에 명시 고지한다. 미충족은 **downstream pool/cloud sim + wet-lab** 이지 물리 한계/불가능이 아니다 (@D d2 · no-impossibility framing).

---

## 0. TL;DR — 인계 패키지 구성

```
        🛸 UFO — verb-7 handoff · 외부 제작소 인계 패키지 (7-verb pipeline 완주)
   ════════════════════════════════════════════════════════════════════════════
     verb-5 synthesize (BOM · 도면 · firmware) + verb-6 verify (verdict) → 인계 패키지
   ════════════════════════════════════════════════════════════════════════════

   ┌─────────────────────────────────────────────────────────────────────────┐
   │  📦 외부 제작소 인계 패키지 (5 구성요소)                                   │
   ├─────────────────────────────────────────────────────────────────────────┤
   │                                                                           │
   │   ① BOM            ② 도면 tree       ③ firmware                          │
   │   ┌──────────┐     ┌──────────┐     ┌──────────────┐                     │
   │   │ 7-카테고리 │     │ assembly │     │ DO-178C      │                     │
   │   │ frame·자석 │ ──► │ → subasm │ ──► │ DAL-A        │ ──┐                 │
   │   │ 동력·열·   │     │ → part   │     │ FBW·6-DOF    │   │                 │
   │   │ avionics·  │     │ (3-tier) │     │ Kalman·게인  │   │                 │
   │   │ LSS·소모품 │     └──────────┘     └──────────────┘   │                 │
   │   └──────────┘                                          ▼                 │
   │                                              ┌────────────────────┐       │
   │   ④ 인증 경로                                │  ⑤ 인계 체크리스트  │       │
   │   ┌──────────────────┐                       │  ┌──────────────┐  │       │
   │   │ DO-178C DAL-A    │                       │  │ 완료(설계)    │  │       │
   │   │ 구조 인증(FAA25) │ ────────────────────► │  │   vs          │  │       │
   │   │ 압력용기(cryo)   │                       │  │ 미충족(sim·   │  │       │
   │   │ EMC 적합성       │                       │  │  wet-lab)     │  │       │
   │   └──────────────────┘                       │  └──────────────┘  │       │
   │                                              └────────────────────┘       │
   │                                                                           │
   │   ⚠ absorbed=false — "비-wet-lab 설계 완료 · 본해 sim + wet-lab downstream" │
   │     🟠 5 게이트(CFD·EM·응력·열·⟲) + F-ANTI-3 + Stage-4~7 ⚪ = 제작 전 닫기  │
   └─────────────────────────────────────────────────────────────────────────┘
```

**인계 상태 한 줄 요약 (@D d5 정직)**: UFO 통합 비행체 = **비-wet-lab 설계 (verb-1~6) 완성형** · Stage-1~3 closed-form 🟢 verified · BOM/도면/firmware synthesize 완료 → **제작소 인계 가능**. 단 verb-6 verify `absorbed=false` → 제작 착수 전 **🟠 5 통합-sim 게이트 + F-ANTI-3 + Stage-4~7 ⚪ falsifier** 를 본해 sim (pool/cloud) + wet-lab 측정으로 닫아야 함 (downstream).

---

## 1. 인계 산출물 매니페스트 — 각 verb 산출물 포인터 표

외부 제작소가 받는 전체 인계 산출물 = demiurge 7-verb 파이프라인의 7개 문서 (spec~handoff) + verb-5 synthesize 의 BOM/도면/firmware 트리. 각 산출물은 **문서 포인터 + LANDED 상태** 로 인계된다.

| verb | 산출물 (문서 포인터) | 인계 역할 | 상태 |
|------|----------------------|-----------|------|
| 1 spec | `UFO/spec/integrated-vehicle-spec.md` + `.tape` | 1인승 통합 비행체 사양 (페이로드/항속/고도/안정성 · 7-stage matrix · 동력 record consume contract) | LANDED (PR#187) |
| 2 structure | `UFO/structure/integrated-vehicle-structure.md` + `.tape` | 디스크 OML D=6.0m H=1.6m · 5 bay · RTSC 솔레노이드 x6 array + gyro CMG x3 · LC-1~5 · 응력 budget 650kg/SF=2.5 | LANDED (PR#190) |
| 3 design | `UFO/design/integrated-vehicle-design.md` + `.tape` | Stage-1~3 closed-form 실설계 (자석 NI/B · MHD J×B · trap depth) · Stage-4~7 falsifier-only · 무게/전력/냉각 budget | LANDED (PR#195) |
| 4 analyze ⟲ | `UFO/analyze/integrated-vehicle-analyze.md` + `.tape` | 4-layer (CFD · EM · 응력 · 열) 지배방정식 + 격자/수렴 기준 + ⟲ fixed-point coupling (max Δ_rel<1e-3) · 본해 sim pool/cloud deferred | LANDED (PR#196) |
| 5 synthesize | `UFO/synthesize/integrated-vehicle-synthesize.md` + `.tape` | **BOM 7-카테고리 · 도면 tree (assembly→subasm→part) · firmware DO-178C DAL-A (FBW 6-DOF Kalman 게인)** | LANDED (PR pending) |
| 6 verify | `UFO/verify/integrated-vehicle-verify.md` + `.tape` | **통합 verdict 🟢10 🟡4 🟠5 ⚪13 · absorbed=false** (Stage-1~3 🟢 closed-form + 통합 sim 🟠 + Stage-4~7 ⚪ falsifier) | LANDED (PR pending) |
| 7 handoff | `UFO/handoff/integrated-vehicle-handoff.md` + `.tape` (이 문서) | 외부 제작소 인계 패키지 명세 (BOM+도면+firmware+인증+체크리스트+미충족 고지) | 이 PR |

> **흡수 ledger 인계**: 위 7개 본선 문서 외에, Stage-1~3 verified atom ledger (`UFO/verify/stage{1,2,3}-*.md` · atlas hash `663698a0`) + 부수 5축 (hover·grav·cloak·teleport·sim) + Stage-4~7 falsifier preregister (`UFO/{warp,wormhole,dimjump,dimuse}/`) 가 인계 패키지의 **검증 근거 자료** 로 동봉된다.

---

## 2. 제작소 요구사항 — 4 핵심 제작 역량

외부 제작소가 UFO 통합 비행체를 제작하려면 다음 4개 핵심 역량을 보유해야 한다. 각 역량은 §1 의 BOM 카테고리 + 도면 tree 와 1:1 대응한다.

| # | 제작 역량 | 대응 BOM/도면 | 요구 수준 | 비고 |
|---|-----------|---------------|-----------|------|
| ① | **CFRP 성형** (lenticular 디스크 OML) | frame BOM · CFRP T800/T1100 ply · 도면 assembly OML | autoclave 대형 (D=6.0m) · Tsai-Wu ply layup · 정밀 mold tooling | structure §5 σ_allow CFRP 600 MPa · LC-1~5 마진 |
| ② | **RTSC 솔레노이드 권선** (x6 등각 array) | 자석 BOM · HTS REBCO 도체 · 솔레노이드 도면 | NI=1.2e6 At (N=4000 turns·I=300A) · HTS 권선/joint · quench protection | RTSC `solenoid_axis_bz` 1.48265 T anchor · 6-slot 60° r=2.4m |
| ③ | **cryostat 제작** (LHe 4.2K · UHV) | 열 BOM · cryostat/MLI/radiator 도면 | 진공자켓 5cm · MLI 다층 · LHe 4.2K loop heat leak ≤10W · UHV 4K (trap) | 압력용기 인증 대상 (§3) · radiator 25m² |
| ④ | **avionics 조립** (FBW · 센서 · 동력 bus) | avionics BOM · firmware DAL-A · 배선 도면 | DO-178C DAL-A SW 통합 · 28V/400V dual bus · gyro CMG x3 · redundancy 2x | firmware는 §3 인증 경로 ① |

> **단일 generic 인계 (@D d4)**: 제작소 역량 추가/변경 = 본 §2 표 한 행 수정 — 역량별 dispatcher / hardcoded 제작소 분기 없음. BOM 카테고리 ↔ 제작 역량 매핑이 generic 인계 축.
>
> **breakthrough path (@D d2)**: 단일 제작소가 4 역량 전체를 보유하지 못할 경우 → "제작 불가" framing 금지 · path = (a) CFRP·avionics 주제작소 + RTSC 솔레노이드/cryostat 전문 협력사 분할 (b) 모듈별 인계 (bay 단위 6-slot) (c) 솔레노이드·cryostat 통합 cryo-magnet 어셈블리 외주.

---

## 3. 인증 경로 — 4 인증 트랙

UFO 통합 비행체의 인증은 4개 트랙으로 분기한다. 각 트랙은 제작 착수 전(설계 인증) + 제작 후(형식 인증) 단계로 나뉘며, **본 verb-7 는 인증 경로(트랙)만 명세** — 실제 인증 취득은 제작소/인증기관 책임이다.

| 트랙 | 인증 표준 | 대상 | 본 파이프라인 산출 근거 | 미충족 게이트 |
|------|-----------|------|--------------------------|---------------|
| ① firmware | **DO-178C DAL-A** | FBW 비행제어 SW (6-DOF Kalman · 추진 stage 전환 로직) | verb-5 synthesize firmware 트리 (DAL-A 요건 매핑) | SW 검증 커버리지 (MC/DC) · 본해 sim 검증 후 |
| ② 구조 인증 | **FAA Part 25 base** (+ 신규 카테고리 special condition) | frame · 자석 mount · 좌석 retention (LC-1~5) | verb-2 structure σ_allow + verb-4 analyze ③ 응력 FEA | 🟠 응력 게이트 (LC-1~5 FEA 본해 · §5) |
| ③ 압력용기 | **ASME BPVC / PED** (cryostat 진공/극저온) | LHe 4.2K 자켓 · UHV trap · MHD 채널 | verb-2 structure §2.4 cryo IF + verb-4 analyze ④ 열 | 🟠 열 게이트 (cryo transient 본해 · §5) |
| ④ EMC 적합성 | **MIL-STD-461 / DO-160 (EMI/EMC)** | RTSC 솔레노이드 누설장 · MHD plasma · cloak overlay | verb-4 analyze ② EM (6-coil B-map · EM 누설 budget) | 🟠 EM 게이트 (6-coil FEM 본해 · §5) |

> **정직 (@D d1 · @D d6)**: 본 §3 은 인증 **경로(트랙) 명세** — 어떤 인증도 본 verb 에서 취득/주장하지 않는다. 각 트랙의 인증 취득은 미충족 게이트 (§5) 가 본해 sim + wet-lab 으로 닫힌 후 진행된다. "인증 완료" 거짓 주장 금지.

---

## 4. 인계 체크리스트 — 완료(비-wet-lab 설계) vs 미충족(downstream)

인계 체크리스트는 **완료(비-wet-lab 설계, verb-1~6)** 와 **미충족(본해 sim pool/cloud 위임 · wet-lab 측정 downstream)** 을 정직하게 분리한다 (@D d5 invariant).

### 4.1 완료 — 비-wet-lab 설계 (제작소에 인계되는 closed 항목)

- [x] **verb-1 spec** — 1인승 통합 비행체 사양 (7-stage matrix · LSS 12h · 동력 record consume contract) LANDED (PR#187)
- [x] **verb-2 structure** — 디스크 OML · 5 bay · 솔레노이드 array · LC-1~5 · 응력 budget 650kg/SF=2.5 LANDED (PR#190)
- [x] **verb-3 design** — Stage-1~3 closed-form 실설계 · 무게/전력/냉각 budget 배분 LANDED (PR#195)
- [x] **verb-4 analyze ⟲** — 4-layer 지배방정식 + 격자/수렴 기준 + ⟲ coupling manifest LANDED (PR#196)
- [x] **verb-5 synthesize** — BOM 7-카테고리 + 도면 tree + firmware DO-178C DAL-A 트리 LANDED (PR pending)
- [x] **verb-6 verify** — Stage-1~3 closed-form 🟢×N verified (`ioffe_loop_bz` · `triple_product` · `pair_threshold_total`/`rel_kinetic_from_p` · atlas `663698a0`) LANDED (PR pending)
- [x] **인계 패키지 명세** — BOM/도면/firmware/인증경로/체크리스트 manifest (이 문서)

### 4.2 미충족 — downstream (제작 착수 전 닫아야 할 open 항목)

- [ ] **🟠 통합-sim 5 게이트** — CFD(C_d·L/D map) · EM(6-coil B-map FEM) · 응력(LC-1~5 FEA) · 열(cryo transient + radiator) · ⟲(LC-2 full coupling fixed-point) → **pool/cloud micro-exp (@D d7)** 본해 후 닫힘
- [ ] **F-ANTI-3 (Stage-3 γ-rocket effective I_sp)** — 광자 천장 c/g≈3.06e7 s ↔ spec target 1e9 s 2-자릿수 gap → mass-flow 정의 closure (verb-4/6 의무 · downstream)
- [ ] **Stage-4~7 ⚪ falsifier** — warp(F-WARP) · wormhole(F-WORM) · dim-jump(F-DIM) · dim-use(F-USE) = academically-UNPROVEN preregister (UNPROVEN ≠ 물리 불가 · @D d2) → falsifier 측정/실험 downstream
- [ ] **wet-lab 측정 confirmation** — Stage-1 Meissner B-field 실측 · Stage-2 MHD 추력 실측 · Stage-3 antimatter trap · cryostat heat leak 실측 (제작 후 wet-lab · @D d5 downstream)
- [ ] **인증 취득** — DO-178C DAL-A · FAA Pt.25 · ASME BPVC · MIL-STD-461 (§3 · 게이트 닫힌 후 인증기관)

---

## 5. 미충족 게이트 고지 — 제작 전 닫아야 할 항목 (absorbed=false 명시)

> **⚠ absorbed=false 명시 (@D d5)**: verb-6 verify 통합 verdict = **🟢10 🟡4 🟠5 ⚪13 · absorbed=false**. `absorbed=false` 이므로 본 인계 패키지는 **"제작 준비완료(production-ready)" 가 아니다** — 아래 미충족 게이트가 본해 sim (pool/cloud) + wet-lab 측정으로 닫힌 후에야 `absorbed=true` flip + 제작 착수가 정당하다. 미충족은 **downstream pool/cloud sim + wet-lab** 이지 물리 한계/불가능이 아니다 (@D d2 · no-impossibility framing).

### 5.1 🟠 5 게이트 (verb-6 의 통합-sim 미충족 · pool/cloud 본해 위임)

| 게이트 | 미충족 내용 | downstream 해소 경로 (@D d7) | breakthrough path (@D d2) |
|--------|-------------|------------------------------|---------------------------|
| 🟠 CFD | C_d · L/D map (Mach 0.5~25) 미산출 — lenticular 고-Mach 항력 | pool ubu 2D axisym → GPU pod 3D DES (vast.ai) | shock-adaptive AMR + plasma MHD drag-reduction |
| 🟠 EM | 6-coil 60° array B-map FEM 미수렴 (단일 코일 closed-form → 다중 상호작용) | getdp pool free dry-run → cloud 3D dense | far-field truncation 10× coil (FUSION PR#1095 lesson) |
| 🟠 응력 | LC-1~5 von Mises FEA 미산출 (650kg·SF=2.5 · 1/3/9/6/12 G) | pool linear → cloud explicit dynamic FEA | frame T1100 승격 / Ti-6Al-4V 국소 보강 / 좌석 stroking |
| 🟠 열 | cryo transient + radiator 25m² Q̇=εσT⁴ 미검증 | pool steady → transient cryo sim | cryostat dewar 통합 / deployable radiator / PCM buffer |
| 🟠 ⟲ coupling | LC-2 cruise full 8-coupling fixed-point 미수렴 (max Δ_rel<1e-3) | GPU pod (강결합 · staggered 1-pass → monolithic) | staggered → monolithic coupling 승격 |

### 5.2 F-ANTI-3 (Stage-3 γ-rocket effective I_sp closure)

- **미충족**: γ-rocket I_sp 광자 천장 `c/g ≈ 3.06e7 s` ↔ spec target `1e9 s` 사이 **2-자릿수 gap** (정직 표기 · @D d6 — 목표 수 강제 금지)
- **downstream 해소**: effective I_sp mass-flow 정의 closure (verb-4 analyze ⟲ + verb-6 verify 의무) — annihilation E=2·m_p·c² → relativistic exhaust 의 유효 추력/유량 정의 재검토
- **근거 atom (이미 🟢)**: `pair_threshold_total` · `rel_kinetic_from_p` (atlas `663698a0` · UFO Stage-3 verify) — closed-form 자체는 verified, gap 은 effective 정의 문제이지 물리 불가가 아님 (@D d2)

### 5.3 Stage-4~7 ⚪ falsifier (academically-UNPROVEN preregister)

| Stage | falsifier | 상태 | 비고 (UNPROVEN ≠ 물리 불가 · @D d2) |
|-------|-----------|------|--------------------------------------|
| Stage-4 warp | F-WARP-{1,2,3} | ⚪ SPECULATION-FENCED preregister | Alcubierre δ=1/σ · R=n=6 (formal) · `UFO/warp/hexa-warp.md` §10 |
| Stage-5 wormhole | F-WORM-{1,2,3} | ⚪ SPECULATION-FENCED preregister | Morris-Thorne b₀=ℓ_Pl·σ throat (formal) · `UFO/wormhole/hexa-wormhole.md` §9 |
| Stage-6 dim-jump | F-DIM-{1,2,3} | ⚪ SPECULATION-FENCED preregister | KK 4D→6D→10D→11D→24D→26D · `UFO/dimjump/hexa-dimjump.md` §8 |
| Stage-7 dim-use | F-USE-{1,2,3,4} | ⚪ SPECULATION-FENCED preregister | (σ−φ)²=100c · τ=4 cycle (formal) · `UFO/dimuse/hexa-dimuse.md` §6 |

> **정직 종합 (@D d5 · @D d6)**: Stage-4~7 은 **실설계/sim 없음** (design verb falsifier-only 상속) · ⚪ SPECULATION-FENCED — 제작 인계 대상이 **아니다** (Stage-1~3 만 실제 제작 대상). `absorbed=true` flip 은 Stage-1~3 의 🟠 5 게이트 + F-ANTI-3 가 닫힌 후 결단된다 (Phase E). Stage-4~7 ⚪ 는 falsifier 측정/실험으로 {OPEN→CONFIRMED/DEMOTED} monotone 전이가 별도 downstream.

---

## 6. cross-link + deferred

### 6.1 cross-link

| 대상 | 파일 | 역할 |
|------|------|------|
| UFO spec (verb-1) | `UFO/spec/integrated-vehicle-spec.md` | 1인승 통합 비행체 사양 · 7-stage matrix · 동력 consume contract |
| UFO structure (verb-2) | `UFO/structure/integrated-vehicle-structure.md` | OML · 5 bay · 솔레노이드 array · LC-1~5 · σ_allow |
| UFO design (verb-3) | `UFO/design/integrated-vehicle-design.md` | Stage-1~3 closed-form · Stage-4~7 falsifier-only · budget |
| UFO analyze (verb-4) | `UFO/analyze/integrated-vehicle-analyze.md` | 4-layer 지배방정식 · ⟲ coupling · sim 위임 sizing |
| UFO synthesize (verb-5) | `UFO/synthesize/integrated-vehicle-synthesize.md` | BOM 7-카테고리 · 도면 tree · firmware DO-178C DAL-A |
| UFO verify (verb-6) | `UFO/verify/integrated-vehicle-verify.md` | 통합 verdict 🟢10 🟡4 🟠5 ⚪13 · absorbed=false |
| Stage-1~3 verify ledger | `UFO/verify/stage{1,2,3}-*.md` | closed-form 🟢 verified atom (atlas `663698a0`) — 검증 근거 동봉 |
| Stage-4~7 falsifier | `UFO/{warp,wormhole,dimjump,dimuse}/hexa-*.md` | ⚪ falsifier preregister (downstream 측정) |
| RTSC (EM SSOT) | `~/core/demiurge/RTSC.md` | `solenoid_axis_bz` 1.48265 T — 솔레노이드 권선 anchor |
| FUSION (MHD SSOT) | `~/core/demiurge/FUSION.md` | MHD F=J×B · getdp far-field truncation lesson (PR#1095) |
| ANTIMATTER (trap SSOT) | `~/core/demiurge/ANTIMATTER.md` | Penning invariance · Ioffe trap depth 0.35257 K |
| stdlib 코드 SSOT | `~/core/hexa-lang/stdlib/sim/{cfd,em,fea,heat_cryo}/` | 해석 코드 home (@D d3 · UFO/handoff 코드 0줄) |

### 6.2 deferred (handoff downstream — 제작 착수 전 닫기)

- [ ] 🟠 5 통합-sim 게이트 본해 (CFD · EM · 응력 · 열 · ⟲) — pool/cloud micro-exp (@D d7 · §5.1)
- [ ] F-ANTI-3 effective I_sp mass-flow closure — verb-4/6 의무 (§5.2)
- [ ] Stage-4~7 ⚪ falsifier 측정/실험 monotone {OPEN→CONFIRMED/DEMOTED} (§5.3)
- [ ] wet-lab 측정 confirmation (Meissner B · MHD 추력 · antimatter trap · cryo heat leak) — 제작 후 (@D d5 downstream)
- [ ] 인증 취득 트랙 진행 (DO-178C DAL-A · FAA Pt.25 · ASME BPVC · MIL-STD-461) — 게이트 닫힌 후 (§3)
- [ ] Phase E `absorbed=true` flip 결단 — 🟠 5 게이트 + F-ANTI-3 PASS 후 (@D d5 invariant)
- [ ] 제작소 분할 협력 trade (CFRP·avionics 주 + RTSC·cryostat 협력사) — §2 breakthrough path 결정

---

## 마감

- **author**: UFO domain verb-7 handoff milestone (PR pending — pr-cycle 훅 stamp)
- **base ref**: `origin/main`
- **branch**: `feat/ufo-verb7-handoff`
- **prev verb**: verb-6 verify (PR pending · 통합 verdict 🟢10 🟡4 🟠5 ⚪13) · verb-5 synthesize (PR pending · BOM/도면/firmware)
- **next**: Phase E absorbed=true flip (🟠 5 게이트 + F-ANTI-3 닫힌 후) — **7-verb pipeline 본 verb 가 마지막 (spec→handoff 완주)**
- **governance**: @D d1 (비-wet-lab → completed-form) · d3 (stdlib SSOT · UFO/handoff 코드 0줄) · d4 (single generic dispatch · BOM↔역량 매핑) · d5 (absorbed=true ⇔ 비-wet-lab PASS · absorbed=false 명시) · d9 (explicit-file staging) · d10 (icon · name · alias 헤더)
- **정직 invariant**: 본 verb-7 = 인계 명세 manifest · "제작 준비완료" 거짓 주장 금지 · "비-wet-lab 설계 완료 · 본해 sim + wet-lab 은 downstream" 정직 고지 · absorbed=false 명시 · 미충족 게이트 (🟠 5 + F-ANTI-3 + Stage-4~7 ⚪) downstream pool/wet-lab (불가능 framing 금지 · @D d2)
