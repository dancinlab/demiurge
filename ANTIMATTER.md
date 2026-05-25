# ANTIMATTER — 반물질 공장 (생산라인 = 축) progress board

@title: 🏭 ANTIMATTER — 반물질 공장(반물질 만드는 라인)

@goal: 반물질 공장 — 생성→감속→포획→냉각→합성→가둠→측정 7공정을 (a) 공정별 물리량 폐형해/수치로 verify 닫고(verify-native) (b) 풀 7-verb 파이프(specify→…→handoff)로 트랩·소스 설계 사양까지 인계. absorbed=true ⇔ 全 non-wet-lab gate PASS (실측은 downstream confirmation · @D d5)

## Milestones (progress)

- [x] ⓵생성 — pair-production threshold 폐형해/수치 재현 (p+p→p+p+p̄+p) — **T_th = 6 m_p c² 🔵 SUPPORTED-FORMAL** · 5629.632 MeV ≈ 5.63 GeV 🟢 SUPPORTED-NUMERICAL (`hexa verify --expr`, mini · 2026-05-25) · atlas `@F verified-pair_threshold_factor-1`. (표적 yield 별도 cell 남음)
- [x] ⓶감속 — AD/ELENA 감속 ladder (GeV→keV) 빔동역학 에너지 단계 수치 검증 — 🟢 SUPPORTED-NUMERICAL ×4 (상대론 정확식 T=√((pc)²+(m_p c²)²)−m_p c², m_p c²=938.272 MeV · 역식 pc=√(T²+2·T·m_p c²)) · AD-in pc=3500→T=2685.311 MeV(≈2.685 GeV) · AD-out pc=100→T=5.3139 MeV · ELENA-out T=100 keV→pc=13.699 MeV/c · 역변환 roundtrip pc=100 |Δ|=7.4e-13 · 비상대론 극한 pc→√(2 m_p c²·T)=13.6987(Δ=3.6e-4 MeV/c, ~3e-5 frac, 환원 확인; 단 ε=1e-9 엄밀 probe는 T²항≠0 ⇒ 🔴 정직) · negative control 🔴 (`rel_kinetic_from_p`/`rel_p_from_kinetic`, hexa verify mini · POOL_DISABLE=1 · hexa-lang PR #1014 merged · `exports/antimatter/verify/2026-05-25T10-43-31Z/`)
- [x] ⓷포획 — 페닝트랩 전하-입자 3주파수(axial·cyclotron·magnetron) 폐형해 + invariance theorem — 🟢 (p̄ B=5T·U₀=10V·d=5mm: ω_c·ω_z·ω₊·ω₋ + Brown–Gabrielse 불변량 ω_c²=ω₊²+ω_z²+ω₋² · `penning_omega_plus`/`penning_omega_minus`/`penning_invariance` hexa-native recompute |Δ|=0.0 · `exports/antimatter/verify/2026-05-25T09-11-36Z/`)
- [ ] ⓸냉각 — 전자냉각 / 공감냉각 시간상수 + 평형 온도 수치
- [x] ⓹합성 — p̄+e⁺→H̄ 3체 재결합률(스케일링) 폐형해 — 🔵+🟢 (cold trapped plasma 3체 채널 p̄+e⁺+e⁺→H̄+e⁺ 지배: α₃ᵦ∝n_e·T^(−9/2) → rate/p̄∝n_e²·T^(−9/2) · Mansbach–Keck 1969 / Glinsky–O'Neil 1991. **밀도멱=2 정확한 정수 🔵** · **T-지수=−9/2=−4.5 🟢** · 수치예 α(4K)/α(100K)=(100/4)^4.5=25^4.5=5⁹=1953125.0 🟢. `recomb_3body_density_power`/`recomb_3body_exponent`/`recomb_3body_tratio` hexa-native recompute · 음성대조 3건 모두 🔴 FALSIFIED(결정론 증명) · hexa-lang PR #1018 MERGED · `exports/antimatter/verify/2026-05-25T10-43-31Z/`)
- [ ] ⓺가둠 — Ioffe-Pritchard 자기최소 트랩 B장 + trap depth (RTSC getdp 4.0 · Wheeler 폐형해 **상속**) — verify
- [x] ⓻측정 — 반수소 1S-2S 전이주파수 leading 폐형해 `f = (3/4)·R∞·c ≈ 2.4674 PHz` 🟢 verify (factor 3/4 + 수치, `transition_factor_1s2s`/`h1s2s_rydberg`, mini · hexa-lang PR #1005) · gap-to-measured = 환산질량 m_e/(m_e+m_p)≈0.99946 + QED/Lamb (15자리 재현 X, 정직 명시) · **CPT Δ(H vs H̄)는 실측 oracle 필요 ⇒ absorbed=false 유지** (@D d5)
- [ ] 7-verb 풀파이프 1회 관통 (specify→structure→design→analyze→synthesize→verify→handoff) — 1개 공정 cell
- [ ] 공장 설계 인계 doc — 트랩·소스 사양 record (`exports/antimatter/handoff/...`)
- [ ] absorbed=true → ANTIMATTER absorbed (全 non-wet-lab gate PASS · @D d5)

## verify (🔵/🟢 push · @D g5 · demiurge 자산 필수)

- [ ] V1 claim inventory + tier triage (🔵/🟢/🟡/🟠) — 7공정 물리량 목록화
- [ ] V2 🔵 push — pair-threshold · Penning 3-freq · Rydberg/QED 1S-2S · Ioffe-P trap depth closed-form identity → `hexa verify --expr` + atlas register · **Penning 3-freq DONE → 🟢** (`penning_omega_plus`/`penning_omega_minus`/`penning_invariance` 등록 + `--from-verify` atlas fold; 폐형해이나 sqrt 포함 libm-class라 tier=🟢, 불변량 잔차=0.0 exact) · **pair-threshold DONE → 🔵 factor-6 + 🟢 수치** · **1S-2S Rydberg DONE → 🟢** (`transition_factor_1s2s`=3/4 + `h1s2s_rydberg`=(3/4)R∞c·1e-15 PHz, hexa-lang PR #1005)
- [ ] V3 🟢 push — libm/Newton 수치 재현 (감속 ladder · 재결합률 · 냉각 시간상수) · **Penning 3-freq 3-atom 🟢 |Δ|=0.0 (2026-05-25)** · **1S-2S leading freq 🟢 2.46738 PHz |Δ|=8.88e-16 (2026-05-25)** · **⓶감속 ladder DONE → 🟢** (`rel_kinetic_from_p`/`rel_p_from_kinetic` ×4 rungs+inverse · 비상대론 극한 환원 확인 · negative control 🔴, hexa-lang PR #1014)
- [ ] V4 tier ledger — V1+V2+V3 통합 + CPT Δ + absorbed=false 정직 명시

---

## 0. TL;DR

ANTIMATTER 는 **반물질 공장** 한 도메인이다. CERN 이 자기네 반양성자 감속기 시설을 *Antimatter Factory* 라 부르듯, 여기서도 **생산라인의 각 공정이 곧 한 축**이다 — RTSC 가 자석 하나를 5축으로 펼친 것과 동일한 패턴. 분광·가둠·생성을 별개 도메인으로 쪼개지 않고 한 우산 아래 *공정 축*으로 둔다 (Occam g0). **⓺가둠 축은 RTSC 자석 toolchain(getdp 4.0 · Wheeler 폐형해)을 직계 상속**한다.

```
양성자빔 → ⓵생성 → ⓶감속 → ⓷포획 → ⓸냉각 → ⓹합성 → ⓺가둠 → ⓻측정
 protons  표적충돌  AD/ELENA  페닝트랩  전자냉각  p̄+e⁺   자기최소   1S-2S·중력
          pair생성  GeV→keV  (전하)            →H̄bar   트랩      CPT 대칭
                                                       └── RTSC 자석 toolchain 재사용 ──┘
```

## 1. 두 목표 (a+b)

| 목표 | 내용 | 게이트 |
|---|---|---|
| **(a) verify-native** | 7공정 물리량을 폐형해(🔵)/수치(🟢)로 재현해 닫음 | `hexa verify` verdict verbatim · @D g5 |
| **(b) 풀 7-verb 공장** | specify→…→handoff 로 트랩·소스 설계 사양까지 인계 | `exports/antimatter/<verb>/...` record |

→ absorbed=true ⇔ (a)+(b) 의 全 non-wet-lab gate PASS. 실측(반수소 실제 생성·측정)은 downstream confirmation (@D d5 · d1).

## 2. 축 구조 (RTSC 미러링)

| 축 | 값 | 비고 |
|---|---|---|
| **A 공정단계** | ⓵생성 · ⓶감속 · ⓷포획 · ⓸냉각 · ⓹합성 · ⓺가둠 · ⓻측정 | 공장 spine = 7-verb 와 정렬 |
| **B 반입자종** | p̄ (반양성자) · e⁺ (양전자) · H̄ (반수소) · Ps (포지트로늄) | RTSC 의 conductor 축 자리 |
| **C 솔버/검증** | getdp(트랩 B장) · QED/Rydberg 폐형해(분광) · 빔동역학 수치 · `hexa verify` | ⓺는 RTSC 재사용 |
| **D verb** | specify→structure→design→analyze→synthesize→verify→handoff | 7-verb 척추 |
| **E 시설/온도** | 4 K cryostat · 자기최소 trap depth · UHV | device-side |

## 3. 공정 × 물리 (verify 타깃)

기호: 🔵 폐형해 · 🟢 수치 · 🟡 인용 · 🟠 외부의존

| 공정 | 핵심 물리량 | tier 타깃 | 솔버 |
|---|---|:---:|---|
| ⓵생성 | pair-production threshold (E_th≈6.5 GeV) · 표적 yield | 🔵→🟢 | closed-form · 수치 |
| ⓶감속 | 감속 ladder (GeV→keV) 빔동역학 | 🟢 | 빔동역학 수치 |
| ⓷포획 | 페닝트랩 3주파수 + invariance theorem | 🔵 | closed-form |
| ⓸냉각 | 전자냉각/공감냉각 시간상수 · 평형 T | 🟢 | 수치 |
| ⓹합성 | p̄+e⁺→H̄ 3체 재결합률 스케일링 | 🔵→🟢 | closed-form |
| ⓺가둠 | Ioffe-Pritchard B_min · trap depth (mK) | 🔵+FEM | **getdp 4.0 (RTSC 상속)** · Wheeler |
| ⓻측정 | 반수소 1S-2S 주파수 · p̄ g-factor → CPT Δ | 🔵 | QED/Rydberg closed-form |

## 4. RTSC 자석 toolchain 상속 (⓺가둠)

⓺가둠 축은 신규 코드가 아니라 **방금 만든 RTSC 자석 cell 의 직계 확장**:

| RTSC 자산 | ANTIMATTER 재사용 |
|---|---|
| `solenoid_axisym.geo` / `.pro` (getdp 4.0) | Ioffe-Pritchard 자기최소 트랩 geo/pro 로 파생 |
| Wheeler on-axis B 폐형해 검증기 (M318) | 트랩 축상 B_min 깊이 cross-check |
| 5-axis `RtscVerifyRecord` 스키마 | `device=ioffe_pritchard_trap` 값 추가 |

→ 솔레노이드가 *자기장을 모으는* 장치라면, Ioffe-Pritchard 트랩은 *자기장 최소점(우물)* 을 만들어 중성 반수소를 가두는 장치. 같은 getdp magnetostatic 척추, 형상만 다름.

## 5. Cross-reference

- `RTSC.md` §4.2 — getdp 4.0 ARM toolchain + Wheeler 폐형해 (⓺가둠 상속원)
- `exports/cern/synthesize/` — CERN 가속기 도메인 (감속기 시설 인접)
- `~/core/hexa-lang/stdlib/rtsc/templates/` — getdp `.geo`/`.pro` 파생원
- @D d1 (non-wet-lab → completed-form) · d5 (absorbed ⇔ 全 gate PASS) · d6 (first-principles physics)
- @D g5 (verify via hexa CLI · verdict verbatim)
