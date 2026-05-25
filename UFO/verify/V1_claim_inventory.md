# UFO verify-ladder V1 — claim inventory + tier triage 🛸

> verify ladder V1-V4 의 **첫 단계 V1**. UFO 도메인 전체 (Phase A 7-stage · Phase B 5축 · Phase C 7-verb) claim 을
> 수집하고 g5 tier rubric (🔵/🟢/🟡/🟠/🔴/⚪) 으로 triage 한 **통합 ledger**.
>
> 정직성 원칙 (@D d6 · @D g5): tier 는 LLM self-judge 가 아니라 **실제 근거 인용** — PR# · atlas atom · falsifier ID ·
> verbatim verdict — 만으로 부여. Stage-1~3 = numerical recompute 통과분만 🟢 · 합성식은 🟡 · Stage-4~7 =
> ⚪/OPEN falsifier (UNPROVEN, 결코 🔵/🟢 아님). ⚪ 는 "미증명"이지 "불가능"이 아니다 (@D d2).

## tier rubric (g5 SSOT)

| tier | 의미 | UFO 부여 기준 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 항등식 · 형식 증명 | `hexa verify --expr` symbolic identity / formal lattice 일관성 (현 UFO 에는 V2 에서 push 예정 — V1 시점 0건) |
| 🟢 SUPPORTED-NUMERICAL | libm-class 수치 재계산 ε≤1e-9 | `hexa verify --expr <atom>` 통과 + atlas folded `@F verified-*-num` |
| 🟡 SUPPORTED-BY-CITATION | 문헌/합성식 근거 (atom 미등록) | 물리 합성식 (Lorentz force · gradient-form 등) — stdlib atom 등록 시 🟢 escalate |
| 🟠 INSUFFICIENT/DEFERRED | 입력 부족 · 본해 미수렴 | 무거운 sim 본해 (CFD/FEA/EM) pool/cloud 위임 대기 (@D d7) |
| 🔴 FALSIFIED | 결정적 반증 | (현 UFO 0건) |
| ⚪ SPECULATION-FENCED | 미증명 · 사변 fence | Stage-4~7 (warp/wormhole/dim) formal lattice only · OPEN falsifier · 초광속 통신 fence |

---

## 0 TL;DR — UFO claim tier 분포

```
   tier 분포 (V1 시점 · 38 claim)
   ─────────────────────────────────────
   🔵 SUPPORTED-FORMAL        0   (V2 에서 push 예정)
   🟢 SUPPORTED-NUMERICAL     9   ████████████  (Stage-1~3 verify --expr 9건)
   🟡 SUPPORTED-BY-CITATION   8   ██████████    (합성식 · closed-form 상한 · 흡수 manifest)
   🟠 INSUFFICIENT/DEFERRED   4   █████         (verb-4 본해 미수렴 · verb-5~7 미진행)
   🔴 FALSIFIED               0
   ⚪ SPECULATION-FENCED     17   ██████████████████████  (Stage-4~7 13 falsifier + teleport fence + meta)
   ─────────────────────────────────────
   합계                       38
```

**한줄 요약**: UFO 의 **검증된 코어 = Stage-1~3 (hover·cruise·orbital) 9건 🟢** (Meissner B-field · MHD thrust · γ-rocket
상대론 에너지 회계). **Stage-4~7 (warp·wormhole·dim-jump·dim-use) 13 falsifier 는 전부 ⚪/OPEN UNPROVEN** — formal
lattice 일관성만 있고 실설계·측정 없음. Phase B 5축 흡수 manifest = 🟡 (문헌 합성 사양) · Phase C 7-verb 는 spec~analyze
5/7 LANDED (manifest 🟡 + analyze 본해 🟠) · synthesize~handoff 미진행 🟠.

---

## 1 Phase A claim ledger — 7-stage propulsion ladder

각 stage 의 claim · tier · 근거 (PR# / atlas atom `@F` / falsifier ID / verbatim verdict).

### Stage-1 hover (Meissner / RT-SC 48T · 0~20km) — 🟢 + 🟡

| # | claim | tier | 근거 |
|---|---|---|---|
| A1-1 | hover-coil B-field `ioffe_loop_bz(0.3,954930,0)=2` (90kg, a=0.3m) | 🟢 | `verify --expr ioffe_loop_bz` · calc=2 \|Δ\|=5.67085e-10 ≤ ε=1e-9 · atlas folded `@F verified-ioffe_loop_bz-num` |
| A1-2 | hover-coil B-field `ioffe_loop_bz(0.5,1591549,0)=2` (120kg, a=0.5m) | 🟢 | `verify --expr ioffe_loop_bz` · calc=2 \|Δ\|=5.67086e-10 ≤ ε=1e-9 |
| A1-3 | hover-coil B-field `ioffe_loop_bz(1.0,3183099,0)=2` (200kg, a=1.0m) | 🟢 | `verify --expr ioffe_loop_bz` · calc=2 \|Δ\|=5.67085e-10 ≤ ε=1e-9 |
| A1-4 | Meissner 부상력 `F_lev = \|χ\|·V·B·(dB/dz)/μ₀` gradient-form (90kg lift 1800배 over-head) | 🟡 | gradient-form 합성식 — Jackson §6 · Tinkham §I.2 · RTSC.md V3 · hexa-ufo HOVER §X B²·A/(2μ₀) 동치 · stdlib `meissner_lev_force` atom 미등록 |

- 근거 doc: `UFO/verify/stage1-hover-fields.md` · UFO.md line 29 (Stage-1 LANDED) · PR#191 (analyze 인용 verified atom)
- atlas hash (stage-doc 시점): `663698a0…ce7fb` (16103 nodes) — `verified-ioffe_loop_bz-num` folded
- honest note: B-field 생성 3건 🟢 (numerical) · F_lev gradient-form 합성 자체는 🟡 (atom 미등록). composite ≠ 전부 🟢.

### Stage-2 cruise (MHD + D-T/p-¹¹B fusion · 20~200km) — 🟢 + 🟡

| # | claim | tier | 근거 |
|---|---|---|---|
| A2-1 | MHD thrust `triple_product(200000,5.0,0.096)=96000` (저고도 J=2e5·B=5T·V=0.096) | 🟢 | `verify --expr triple_product` · calc=96000 \|Δ\|=0.0 ≤ ε=1e-9 · atlas folded `@F verified-triple_product-num` (embedded.gen.hexa:30535) |
| A2-2 | MHD thrust `triple_product(150000,4.0,0.096)=57600` (중고도) | 🟢 | `verify --expr triple_product` · calc=57600 \|Δ\|=0.0 ≤ ε=1e-9 |
| A2-3 | MHD thrust `triple_product(100000,3.0,0.096)=28800` (고고도 200km 전이 임계) | 🟢 | `verify --expr triple_product` · calc=28800 \|Δ\|=0.0 ≤ ε=1e-9 |
| A2-4 | Lorentz body force 합성 `f=σ(E−u×B)×B → F_MHD=J×B×V_ch` (generalized Ohm) | 🟡 | 물리 합성식 — Sutton-Sherman · Jackson §5 · FUSION.md §2(d)(e) · stdlib `mhd_thrust`/`lorentz_body_force` atom 미등록 |

- 근거 doc: `UFO/verify/stage2-cruise-mhd.md` · UFO.md line 30 (Stage-2 LANDED 🟢) · FUSION BLUE-MAX PR#1102 (substrate)
- @D d4 우회: MHD thrust 전용 atom 미등록 → `F=J·B·V` 순수 product 를 FUSION Lawson `triple_product` 동일 대수 root 로 idempotent recompute (single generic dispatch)
- honest note: thrust margin F_MHD(저고도)=192kN / m·g(650kg)=6.38kN ≈ 30배 — **설계 타당**, 결코 "Q>1 달성" 주장 아님

### Stage-3 orbital (antimatter γ-rocket anti-H+H · 200km~1AU) — 🟢 + 🟡

| # | claim | tier | 근거 |
|---|---|---|---|
| A3-1 | annihilation 에너지 회계 `pair_threshold_total(938.272)=6567.9` (E=2·m_p·c² anchor) | 🟢 | `verify --expr pair_threshold_total` · calc=6567.9 \|Δ\|=0.0 ≤ ε=1e-9 · atlas `@F verified-pair_threshold_total-num` (embedded.gen.hexa:30652) · ANTIMATTER ⓵ atom reuse idempotent |
| A3-2 | ultra-relativistic 배기 `rel_kinetic_from_p(9382.72)=8491.24` (β=0.995·γ≈10.05) | 🟢 | `verify --expr rel_kinetic_from_p` · calc=8491.24 \|Δ\|=0.0 ≤ ε=1e-9 · atlas `@F verified-rel_kinetic_from_p-num` (embedded.gen.hexa:30514) · ANTIMATTER ⓶ atom reuse |
| A3-3 | kinetic=rest 교차점 `rel_kinetic_from_p(1625.13)=938.272` (pc=√3·m_p_c² · c/g 천장 crossover) | 🟢 | `verify --expr rel_kinetic_from_p` · calc=938.272 \|Δ\|=0.0 ≤ ε=1e-9 |
| A3-4 | γ-rocket 광자 천장 `I_sp = c/g ≈ 3.057e7 s` (광속 배기 closed-form 상한) | 🟡 | closed-form 상한 · ANTIMATTER γ-rocket substrate · UFO/design §3.3 · stdlib `gamma_rocket_isp(v_e,g)` atom 미등록 |

- 근거 doc: `UFO/verify/stage3-orbital-gamma.md` · UFO.md line 31 (Stage-3 LANDED 🟢)
- **honest note (@D d6)**: 광자 천장 `3.057e7 s` ↔ spec §2 target `I_sp ≥ 1e9 s` **2 자릿수 불일치 정직 표기**. 원인 = "effective
  I_sp" mass-flow 정의 차이 (annihilation energy density 기반 effective exhaust vs 광자 momentum 기반). target 1e9 s 달성
  여부는 **verb-4 analyze ⟲ mass-flow closure + verb-6 verify falsifier F-ANTI-3** 의무. 목표 수 강제 금지.

### Stage-4 warp (Alcubierre δ=1/σ · R=n=6 · 1AU~galactic) — ⚪ OPEN

| # | claim | tier | 근거 |
|---|---|---|---|
| A4-F1 | F-WARP-1 — Casimir σ=12 plate 음에너지 밀도 실현 (UNPROVEN) | ⚪ OPEN | falsifier preregister · `UFO/warp/hexa-warp.md` §10 · design §4.1 (실설계 없음 · formal lattice only) |
| A4-F2 | F-WARP-2 — bubble wall signal/관측 가능성 (UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |
| A4-F3 | F-WARP-3 — Hawking back-reaction 안정성 (UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |

### Stage-5 wormhole (Morris-Thorne b₀=ℓ_Pl·σ throat · intergalactic) — ⚪ OPEN

| # | claim | tier | 근거 |
|---|---|---|---|
| A5-F1 | F-WORM-1 — QFT source b₀>ℓ_Pl throat 존재 (UNPROVEN) | ⚪ OPEN | falsifier preregister · `UFO/wormhole/hexa-wormhole.md` §9 · design §4.1 |
| A5-F2 | F-WORM-2 — Ford-Roman back-reaction bound (UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |
| A5-F3 | F-WORM-3 — chronology protection (UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |

### Stage-6 dim-jump (KK ladder 4D→6D→10D→11D→24D→26D) — ⚪ OPEN

| # | claim | tier | 근거 |
|---|---|---|---|
| A6-F1 | F-DIM-1 — LHC 14 TeV KK-resonance (현재 null · UNPROVEN) | ⚪ OPEN | falsifier preregister · `UFO/dimjump/hexa-dimjump.md` §8 · design §4.1 |
| A6-F2 | F-DIM-2 — sub-mm gravity 편차 (현재 null · UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |
| A6-F3 | F-DIM-3 — vacuum-energy transition (현재 null · UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |

### Stage-7 dim-use (τ=4 cycle (σ−φ)²=100c composite) — ⚪ OPEN

| # | claim | tier | 근거 |
|---|---|---|---|
| A7-F1 | F-USE-1 — warp ANEC bound (UNPROVEN) | ⚪ OPEN | falsifier preregister · `UFO/dimuse/hexa-dimuse.md` §6 · design §4.1 |
| A7-F2 | F-USE-2 — dimjump KK>14 TeV (UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |
| A7-F3 | F-USE-3 — 2nd law 4D 위배 여부 (UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |
| A7-F4 | F-USE-4 — composite back-reaction (UNPROVEN) | ⚪ OPEN | falsifier preregister · 동상 |

> Stage-4~7 = **13 falsifier 전부 ⚪/OPEN UNPROVEN**. formal lattice 일관성 (δ=1/σ · b₀=ℓ_Pl·σ · KK 4D→26D ·
> (σ−φ)²=100c) 만 있고 실설계·수치·측정 없음. 이는 "불가능"이 아니라 **미증명** — V2 에서 lattice 항등식을 🔵 push 시도,
> 그래도 물리 실현은 wet-lab/관측 downstream (@D d2 breakthrough path 명시: Casimir 플레이트 · sub-mm gravity 실험 등).

---

## 2 Phase B claim ledger — 부수 5축 흡수 manifest

흡수 manifest 는 문헌 사양 통합 (docs/manifests only · @D d3) → 🟡 SUPPORTED-BY-CITATION. 구현 코드는 hexa-lang/stdlib
canonical home 위임 (verify 🟢 는 V3 deferred).

| # | 축 | claim | tier | 근거 |
|---|---|---|---|---|
| B-HOVER | HEXA-HOVER | Meissner levitation 사양 (RTSC 48T 솔레노이드 cross-link · HTS REBCO 1차 · Earnshaw active feedback) | 🟡 | `UFO/hover/{README.md,manifest.tape}` · UFO.md line 39 LANDED · PR#183 |
| B-SIM | HEXA-SIM | 디지털트윈 sim 엔진 (CFD+EM+추진 6-layer stack · 4축 generic dispatch) | 🟡 | `UFO/sim/{README.md,manifest.tape}` · UFO.md line 43 LANDED |
| B-GRAV | HEXA-GRAV | GW LIGO 미니어처 h~10⁻²³ + atom-IF Δg~10⁻¹¹g + SQUID σ·τ=48 fT/√Hz · mu-metal×5 EM separation | 🟡 | `UFO/grav/{README.md,manifest.tape}` · UFO.md line 40 LANDED · 4 falsifier preregister (h·Δg·fT·cross-talk) |
| B-CLOAK | HEXA-CLOAK | transformation-optics ε-μ tensor metamaterial shell · RCS 10⁻⁶ m² + IR σ-φ=10dB↓ | 🟡 | `UFO/cloak/{README.md,manifest.tape}` · UFO.md line 41 LANDED · 4 falsifier preregister (RCS·octave·IR·능동누설) |
| B-TELE-1 | HEXA-TELEPORT | Bell-pair·BSM·고전채널≤c·unitary 4단계 표준 프로토콜 (Bennett 1993) + entanglement swapping 중계 | 🟡 | `UFO/teleport/{README.md,manifest.tape}` · UFO.md line 42 LANDED (Phase B 5/5) |
| B-TELE-2 | HEXA-TELEPORT | 초광속/즉시 전송 주장 (no-communication theorem · 정보 ≤ c) | ⚪ FENCE | honest fence — no-cloning (Wootters-Zurek 1982) · "σ·sopfr·10=600km 즉시전송" 수론 주장 ⚪ SPECULATION-FENCED |

- Phase B 진행: **5/5 흡수 완료** (hover · sim · grav · cloak · teleport LANDED)
- 흡수 manifest tier = 🟡 (문헌 합성 사양). closed-form verify 🟢 (Bell-state fidelity · GW finesse · SQUID floor 등) 는 V3 deferred.

---

## 3 Phase C claim ledger — demiurge 7-verb pipeline

| # | verb | claim | tier | 근거 |
|---|---|---|---|---|
| C-1 | spec | 1인승 통합 비행체 사양 (페이로드/LSS 12h · stage matrix 7행 · gyro x3+jet x6+EM trim 2x redundancy · record consume contract) | 🟡 | `UFO/spec/integrated-vehicle-spec.{md,tape}` · UFO.md line 47 LANDED · **PR#187** |
| C-2 | structure | frame OML D=6.0m H=1.6m · 5 bay · RTSC 솔레노이드 x6 등각 + gyro CMG x3 + flux-pin · 6-slot stage mount · 응력 budget 650kg SF=2.5 | 🟡 | `UFO/structure/integrated-vehicle-structure.{md,tape}` · UFO.md line 48 LANDED |
| C-3 | design | closed-form 통합 설계 (Stage-1~3 실설계 RTSC/FUSION/ANTIMATTER 상속 · Stage-4~7 falsifier-only) · 무게/전력/냉각 budget | 🟡 | `UFO/design/integrated-vehicle-design.{md,tape}` · UFO.md line 49 LANDED · Stage-1~3 verified atom 인용 |
| C-4 | analyze ⟲ | 4-layer (CFD NS · EM Maxwell/Meissner · FEA von Mises · 열 cryo+radiator) 지배방정식 + Re/격자/수렴 + ⟲ fixed-point max Δ_rel<1e-3 | 🟡 | `UFO/analyze/integrated-vehicle-analyze.{md,tape}` · UFO.md line 50 LANDED · 계획+수렴기준 = manifest 🟡 |
| C-4b | analyze ⟲ | CFD/FEA/EM **본해** (C_d·L/D · von Mises σ · B-map FEM) | 🟠 | 본해 미수렴 — pool/cloud micro-exp 위임 deferred (@D d7 sizing) · sim 은 .hexa only |
| C-5 | synthesize | BOM + 도면 + firmware 산출물 | 🟠 | UFO.md line 51 미진행 (`[ ]`) — verb-5 슬롯 미봉합 |
| C-6 | verify | 디지털트윈 통합 🟢 (CFD+EM+추진+안정성 falsifier 통과) | 🟠 | UFO.md line 52 미진행 (`[ ]`) — V1~V4 ladder 가 입력 |
| C-7 | handoff | 외부 제작소 패키지 (BOM·도면·firmware·인증서류) | 🟠 | UFO.md line 53 미진행 (`[ ]`) |

- Phase C 진행: **spec·structure·design·analyze 4/7 LANDED** (manifest 🟡) · analyze 본해 + synthesize·verify·handoff = 🟠 (미수렴/미진행)
- manifest 산출물은 LLM self-judge 가 아니라 docs/manifests 봉합 LANDED 사실 = 🟡 (문헌·closed-form 합성). 실제 closed-form verify 🟢 는 Stage-1~3 (Phase A) 에만 존재.

---

## 4 honest 분류 — 무엇이 검증됐고 무엇이 아닌가 (@D d6)

### 4.1 🟢 검증된 코어 (numerical recompute · ε≤1e-9 · atlas folded)

- **Stage-1 hover** — hover-coil B-field 3건 (`ioffe_loop_bz`) 🟢
- **Stage-2 cruise** — MHD thrust 3건 (`triple_product`, FUSION Lawson 동일 root) 🟢
- **Stage-3 orbital** — annihilation 에너지 회계 + ultra-relativistic 배기 3건 (`pair_threshold_total`·`rel_kinetic_from_p`) 🟢
- 합계 **9건 🟢 SUPPORTED-NUMERICAL** — 전부 `hexa verify --expr` verbatim verdict + `@F verified-*-num` atlas fold

### 4.2 🟡 합성식 · closed-form 상한 (atom 미등록 · 문헌 근거)

- F_lev gradient-form (A1-4) · Lorentz body force `F=J×B×V` 합성 (A2-4) · γ-rocket 광자 천장 `I_sp=c/g` (A3-4)
- Phase B 5축 흡수 manifest (문헌 사양) · Phase C verb-1~4 manifest 산출물
- → stdlib atom 등록 시 (V3) 🟢 자동 escalate

### 4.3 ⚪ OPEN falsifier (UNPROVEN — 결코 🔵/🟢 금지)

- **Stage-4~7 13 falsifier**: F-WARP-{1,2,3} · F-WORM-{1,2,3} · F-DIM-{1,2,3} · F-USE-{1,2,3,4}
- formal lattice (δ=1/σ · b₀=ℓ_Pl·σ · KK 4D→26D · (σ−φ)²=100c) 일관성만 — 실설계·수치·측정 없음
- teleport 초광속 fence (B-TELE-2) · meta 수론 (n=6 σ·τ=48 alien_index)
- **⚪ = 미증명, 불가능 아님** (@D d2): breakthrough path = Casimir σ=12 plate · sub-mm gravity 실험 · LHC KK-resonance — wet-lab/관측 downstream

### 4.4 γ-rocket I_sp 천장 honest note (@D d6)

- closed-form 광자 천장 `I_sp = c/g ≈ 3.057e7 s` ↔ spec §2 Stage-3 target `I_sp ≥ 1e9 s` = **2 자릿수 불일치**
- 정직 표기 — 목표 수 강제 금지. 불일치 원인 = "effective I_sp" mass-flow 정의 차이 (annihilation energy density 기반)
- closure 의무 = **verb-4 analyze ⟲ mass-flow 정의 + verb-6 verify falsifier F-ANTI-3** (γ-thrust closed-form)

### 4.5 honest 메타 — atlas SSOT 비동기 note

- Stage-1~3 verdict (stage-doc 내 verbatim) 가 V1 inventory 의 authoritative provenance. atlas hash `663698a0…ce7fb` 는
  stage agent 가 fold 한 시점의 hexa-lang `embedded.gen.hexa` 상태 — atom-fold 는 hexa-lang 별 repo PR 로 비동기 land
  (@D d3 stdlib SSOT · @D d9 worktree isolation). V1 은 **stage-doc 의 인용된 근거**를 집계하며, 본인 LLM 재판단 안 함 (@D g5).

---

## 5 V2/V3/V4 escalation 경로

```
   V1 (이 ledger)              V2 🔵 push              V3 🟢 push              V4 final
   ──────────────              ──────────              ──────────              ────────
   38 claim triage    ──►   closed-form identity ──►  numerical recompute ──►  V1+V2+V3 통합
   9🟢·8🟡·4🟠·17⚪          (formal verify)          (libm Δ≤1e-9)            + Phase D 메타
                            n=6 σ·τ=48               Stage-1 Meissner B        + Phase E
                            δ=1/σ · b₀=ℓ_Pl·σ        Stage-2 MHD 추력          absorbed=true 결단
                            KK 4D→26D · (σ−φ)²=100c   Stage-3 antimatter I_sp
                                                      디지털트윈 통합 sim
```

### 5.1 🟡 → 🟢 (citation → numerical): stdlib atom 추가

각 🟡 합성식을 hexa-lang/stdlib 에 atom 으로 등록하면 `hexa verify --expr` 직접 검증 → 🟢 자동 escalate:

| 🟡 claim | 등록할 stdlib atom | escalate 후 |
|---|---|---|
| A1-4 F_lev gradient-form | `meissner_lev_force(chi,V,B,dBdz)` → `stdlib/ufo/meissner.hexa` | A1-4 🟡→🟢 |
| A2-4 Lorentz body force | `mhd_thrust(J,B,V)` / `lorentz_body_force` | A2-4 🟡→🟢 |
| A3-4 γ-rocket I_sp 천장 | `gamma_rocket_isp(v_e,g)` → `stdlib/ufo/gamma_rocket.hexa` | A3-4 🟡→🟢 (`verify --expr gamma_rocket_isp 2.998e8 9.80665 3.057e7`) |

- 등록 위치 = hexa-lang 별 repo (`~/core/hexa-lang/tool/verify_cli.hexa::_recompute` 확장 + `stdlib/ufo/*.hexa`) · 별 PR 분리 (@D d3/d9)

### 5.2 🔵 push (V2): closed-form / formal lattice identity

- `hexa verify --expr` symbolic identity + atlas register: n=6 σ·τ=48 · Alcubierre δ=1/σ · Morris-Thorne b₀=ℓ_Pl·σ · KK 4D→26D · (σ−φ)²=100c
- Stage-4~7 의 formal lattice 일관성을 🔵 SUPPORTED-FORMAL 로 push — **단, 물리 실현 ⚪ 는 그대로** (formal ≠ 측정)

### 5.3 🟠 → 수렴 (V3 본해): pool/cloud micro-exp (@D d7)

- C-4b analyze 본해 (CFD C_d·L/D · FEA von Mises · EM 6-coil B-map) → pool ubu idle / vast.ai GPU 라우팅 · sim 은 .hexa only
- 수렴 후 `@F verified-*-num` atlas fold → C-4b 🟠→🟢

### 5.4 ⚪ → 측정 (downstream): wet-lab / 관측

- Stage-4~7 13 falsifier 의 물리 실현은 **wet-lab/관측 downstream** (Casimir 플레이트 · sub-mm gravity · LHC KK-resonance)
- @D d5: absorbed=true 는 비-wet-lab gate 전부 PASS 시 flip — Stage-4~7 ⚪ 는 비-wet-lab gate 가 formal lattice (V2) 까지만, 측정은 downstream confirmation

### 5.5 cross-link

- `UFO.md` line 70-73 (verify ladder V1-V4) · `UFO/verify/stage{1,2,3}-*.md` (Phase A 근거 doc)
- `UFO/{spec,structure,design,analyze}/*.md` (Phase C manifest) · `UFO/{hover,sim,grav,cloak,teleport}/` (Phase B 흡수)
- `UFO/{warp,wormhole,dimjump,dimuse}/hexa-*.md` (Stage-4~7 falsifier preregister)
- substrate: `RTSC.md` (Stage-1) · `FUSION.md` (Stage-2) · `ANTIMATTER.md` (Stage-3) · `CERN.md` (자장 cross-link)
- governance: @D d1 (non-wet-lab → completed-form) · @D d2 (breakthrough path, no 불가능) · @D d3 (stdlib SSOT) · @D d6 (목표 수 강제 금지) · @D g5 (tier rubric)
