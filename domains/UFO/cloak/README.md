# 🛸 UFO/cloak — HEXA-CLOAK 축 흡수 (EM 가시성 차단 layer 사양)

> alias: `cloak` · UFO Phase B 부수 5축 중 4/5 (HEXA-HOVER ✓ · HEXA-SIM ✓ · HEXA-GRAV ✓ · **HEXA-CLOAK** · HEXA-TELEPORT) · 비행체 EM 가시성 차단 (transformation optics · metamaterial cloak · radar/optical stealth) 사양 SSOT manifest

## 0. TL;DR — UFO/cloak 축 흡수 요약 (transformation optics + metamaterial + stealth)

UFO/cloak 축은 **(1) transformation-optics cloak (좌표변환으로 빛을 우회시키는 ε-μ tensor metamaterial shell)** + **(2) radar/optical stealth (RCS 감소 · IR 억제)** 두 사양을 묶어 비행체 EM 가시성 차단 layer manifest 로 흡수한다. 본 디렉터리는 사양 manifest 만 보유하며, 실제 transformation-optics tensor 계산 · metamaterial unit-cell FDTD · RCS 산출 코드는 `~/core/hexa-lang/stdlib/` 또는 `UFO/hexa-cloak/` 의 canonical home 에 둔다 (@D d3).

```
   ┌────────────────────────────────────────────────────────────────────────┐
   │                       비행체 동체 (lenticular OML)                       │
   │                                                                        │
   │      ╔══════════════════════════════════════════════════════════╗      │
   │      ║  HEXA-CLOAK shell — metamaterial 적층 (ε(r), μ(r) tensor)  ║      │
   │      ║   ┌────────────────────────────────────────────────────┐ ║      │
   │      ║   │ transformation optics: 입사파 → shell 내부 우회 →    │ ║      │
   │      ║   │   원래 진행방향 복원 (위상·진폭 보존, 그림자 0)      │ ║      │
   │      ║   │                                                    │ ║      │
   │      ║   │   →→→→→→→╮              ╭→→→→→→→  (radar/optical)   │ ║      │
   │      ║   │          ╲   [동체]    ╱                           │ ║      │
   │      ║   │   →→→→→→→→╲────────────╱→→→→→→→→                    │ ║      │
   │      ║   │           (빛이 동체를 휘감아 지나감)                │ ║      │
   │      ║   └────────────────────────────────────────────────────┘ ║      │
   │      ╚══════════════════════════════════════════════════════════╝      │
   │           ⇅ Stage 추진 EM 누설 (RTSC B · γ-rocket EMI) vs cloak 양립성   │
   │   ··· Stage-1 RTSC 솔레노이드 B(≈1-48 T) — Meissner self-shield 활용 ···  │
   └────────────────────────────────────────────────────────────────────────┘
```

핵심:

- **이중 사양**: transformation-optics cloak (ε-μ tensor shell) + radar/optical stealth (RCS 감소 · IR 억제)
- **메타물질 shell**: 음굴절률(n<0) n=6 육각 격자 · RT-SC 공명 ε<0 + SRR μ<0 → Snell 음의 해로 빛 우회
- **양립성 risk**: Stage 추진 EM 누설 (RTSC B-field · γ-rocket EMI) vs cloak layer → Meissner self-shield + 누설창 격리
- **falsifier preregister**: RCS 감소 미달 / 대역 누설 / IR 억제 미달 시 사양 폐기 + breakthrough path surface

## 1. 흡수 source — `UFO/HEXA-CLOAK.md` + cloak-canon 디렉터리 인벤토리

| source | path | SHA-1 | LOC | 비고 |
|--------|------|-------|-----|------|
| HEXA-CLOAK spec (한) | `UFO/HEXA-CLOAK.md` | `7efd741da2a9645da1f0a00b1f2712d03cc12638` | 678 | 본 흡수의 1차 reference (항공 스텔스 n=6) |
| CLOAK 통합 (한) | `UFO/CLOAK.md` | `8d855b9ed757f4b5408dac0fe0b1ebeb9f82e492` | 948 | 음굴절률 SRR · RCS · 전대역 (최대 source) |
| cloak dir (in-tree, 영) | `UFO/cloak/hexa-cloak.md` | `3cdb0e6421815aa05af7993d823b2bed61446c81` | 471 | 본 manifest 와 공존 (영문 변형) |
| cloak canon (영) | `UFO/cloak-canon/cloak.md` | `5076cceef7d2583be76a362dec8656da6888ac98` | 698 | transformation-optics + ε-μ 표준 |
| hexa-cloak canon (영) | `UFO/hexa-cloak/hexa-cloak.md` | `ad9ba0ed79118f8a399723da4770a6407260c2cb` | 474 | canonical aerospace stealth 변형 |

흡수 일자: 2026-05-25 · 흡수 범위 = **사양 manifest 만** — 실제 transformation-optics tensor 계산 · metamaterial FDTD/HFSS unit-cell · RCS 산출 코드는 `~/core/hexa-lang/stdlib/` (cross-domain) 또는 `UFO/hexa-cloak/` canonical home 에 두고 본 manifest 는 reference 로 cross-link (@D d3).

## 2. transformation-optics cloak 사양 — metamaterial shell · ε-μ tensor

좌표변환(transformation optics)으로 입사 EM파를 동체 주위로 우회시키는 메타물질 shell 사양 (cloak-canon §1-§4 + CLOAK.md §1 기반).

### 2.1 원리 — 좌표변환 → 음굴절률 메타물질

```
┌──────────────────────────────────────────────────────────────────────┐
│  transformation optics: 공간 좌표 r → r' 로 압축 → ε,μ tensor 재분포    │
├──────────────────────────────────────────────────────────────────────┤
│   ε_eff < 0  AND  μ_eff < 0   ⇒   n_eff = -√(εμ) < 0  (음굴절률)      │
│                                                                      │
│   RT-SC 공명 전도로 ε<0 달성  (플라즈마 주파수 ω_p 근방)              │
│   SRR(Split-Ring Resonator) 육각 배열로 μ<0 달성                      │
│                                                                      │
│   Snell 음의 해 → 빛이 동체를 휘감아 우회 (cloaking)                  │
│   셀 구조: 벌집 n=6 · 피치 a = σ-φ = 10 nm (광학) ~ mm (radar)        │
└──────────────────────────────────────────────────────────────────────┘
```

### 2.2 ε-μ tensor 사양 (구형 cloak Pendry 좌표변환 형)

| tensor 성분 | 좌표변환 식 (구형 cloak, b≤r≤a) | n=6 근거 | 비고 |
|-------------|--------------------------------|---------|------|
| ε_r = μ_r | (a/(a−b))² · (r−b)²/r² | radial 압축 prefactor | 내반경 b → 외반경 a |
| ε_θ = μ_θ | (a/(a−b))² | 각방향 상수 | 등방 가정 |
| ε_φ = μ_φ | (a/(a−b))² | 각방향 상수 | impedance match Z=√(μ/ε)=1 |
| 셀 피치 a | σ-φ=10 (단위 = λ/N) | n=6 육각 격자 | 광학 nm · radar mm |
| 적층 수 N | σ·τ=48 layer (그라데이션) | 음굴절 tensor 근사 | discretization step |

- **impedance matching**: shell 외부와 Z=√(μ/ε)=1 정합 → 반사 0 (그림자 없는 완전 우회 이상치). 실제 metamaterial 은 dispersion 으로 협대역.
- **광대역 확장**: 단일 공진 SRR 은 협대역 → n=6 다중 공진 셀 적층 (σ-τ=8 octaves · 100 MHz~500 THz) 으로 대역 확장 (CLOAK.md §1).
- **경량**: φ=2 kg/m² metamaterial 필름 (HEXA-CLOAK.md §1) — 기존 스텔스 코팅 τ=4 kg/m² 대비 절반.

### 2.3 RT-SC 기반 ε<0 — Meissner EM 차폐 결합

- RT-SC(상온 초전도) 공명 전도로 플라즈마 주파수 ω_p 근방에서 ε<0 달성 (CLOAK.md §1 · HEXA-CLOAK.md §1).
- Meissner 효과 (B 완전 배제) 는 정자기/저주파 EM 차폐로 cloak 과 상보 — §4 비행체 통합에서 Stage-1 RTSC 솔레노이드의 self-shield 로 재활용.
- RT-SC 의존성: `RTSC.md` (room-temp-sc) 의 도체 사양 인수 — REBCO / MgB₂ 후보 (HEXA-HOVER 와 도체 공유).

**falsifier preregister** (cloak-canon §7 + CLOAK.md §7 기반):
1. impedance mismatch 로 shell 반사율 > 1% (전대역 평균) → "완전 우회" 사양 폐기 · partial-cloak 모드로 격하.
2. metamaterial 협대역으로 σ-τ=8 octaves 중 2 octave 미만 cover → 전대역 통합 사양 폐기.
3. φ=2 kg/m² 초과 (실측 > 4 kg/m²) → 비행체 탑재 경량성 폐기 · 부분 패치 모드.

## 3. radar/optical stealth — RCS 감소 · IR 억제

transformation-optics 완전 우회가 협대역 한계에 막힐 때를 대비한 **공학적 stealth 사양** (CLOAK.md §1-§2 + HEXA-CLOAK.md §1 기반). 두 layer (cloak + stealth) 는 상보적으로 적층.

| stealth 항목 | 현재 SOTA | UFO HEXA-CLOAK target | n=6 근거 |
|--------------|-----------|------------------------|---------|
| RCS (radar cross-section) | F-22 ~10⁻⁴ m² | **10⁻⁶ m²** | 1/σ² · 100× 감소 (HEXA-CLOAK §1) |
| 레이더 탐지거리 | 1× (기준) | **1/6 (R∝RCS^¼)** | n=6 · σ-φ⁻³ RCS (CLOAK §1) |
| 대역 | X-band | **전 대역 (radar~IR)** | σ-τ=8 octaves |
| IR 신호 (적외선) | 엔진 plume 강함 | **σ-φ=10 dB↓ 억제** | 음향/열 메타셀 (CLOAK §1) |
| 코팅 비용 | $50M/항공기 | **$500/m² 필름** | 메타셀 필름화 (CLOAK §1) |

- **RCS 감소 메커니즘**: (1) 음굴절 우회 (cloak shell) + (2) radar-absorbing metamaterial (저항성 sheet) + (3) lenticular OML 형상 산란 (구조 자체 · UFO/structure §1 radar caveat 연동).
- **IR 억제**: Stage 추진 plume (MHD/γ-rocket) 의 적외선 신호를 cryo heat-sink + 방사율 제어 메타셀로 σ-φ=10 dB 억제 — UFO/grav 의 cryo 인프라 (4 K LHe · 77 K LN₂) 와 공유 (@D d4 generic dispatch).
- **광학 stealth (가시광)**: σ-τ=8 octave 상단에서 가시광 투명화 (음굴절 우회) — 단, 회절 한계로 동체 크기 ≫ λ 영역에서만 근사 cloaking (cloak-canon §7 FALSIFIER 영역).

**falsifier preregister**:
1. anechoic chamber 실측 RCS > 10⁻⁵ m² (X-band) → RCS 100× 감소 사양 폐기 · 10× 감소로 하향.
2. IR 억제 < 5 dB (3-5 μm 대역) → plume IR stealth 사양 폐기 · cryo-only 모드.
3. 가시광 cloaking 회절 한계로 동체 윤곽 식별 가능 (관측자 거리 < σ·τ=48 m) → 광학 cloak 폐기 · radar/IR-only 모드.

## 4. 비행체 통합 — Stage 추진 EM 누설 vs cloak layer 양립성

UFO 비행체에 HEXA-CLOAK 통합 시 핵심 risk = **Stage-1/2/3 추진 system 의 EM 누설이 cloak shell 의 우회를 깨뜨리는가** (능동 EM 방출 = stealth 의 천적).

| risk axis | EM 누설 source | cloak 양립성 방안 |
|-----------|----------------|--------------------|
| RTSC 솔레노이드 B-field | Stage-1 hover (B ≈ 1-48 T) | Meissner self-shield (RT-SC 외피 B 배제) · 정자기 누설 → shell ε<0 과 무간섭 (저주파) |
| FUSION MHD 방전 EMI | Stage-2 cruise | MHD duct Faraday cage · RF 누설창을 cloak band-stop 셀로 격리 |
| ANTIMATTER γ-rocket | Stage-3 escape (γ + EMI) | γ는 EM cloak 무관 (고에너지) · γ-shield(DU+W+B₄C) 별도 · RF EMI 만 cage |
| 능동 radar/통신 송신 | 비행체 자체 sensor/comm | LPI(low-probability-intercept) waveform · cloak band 외 송신창 · GW 통신(EM-free) 대체 (UFO/grav) |
| 열(IR) plume 누설 | Stage-1~3 thrust | cryo heat-sink + 방사율 메타셀 (§3) · plume 후방 격리 |

**양립성 budget**:

```
┌──────────────────────────────────────────────────────────────────────┐
│  Stage 추진 EM 누설 vs cloak layer 양립성 budget                       │
├──────────────────────────────────────────────────────────────────────┤
│  RTSC 솔레노이드 B (1-48 T · 정자기/저주파)                           │
│      → cloak shell ε<0 은 광학/radar band → 저주파 B 와 무간섭         │
│      → RT-SC 외피 Meissner self-shield (B 외부 배제) → 누설 ≈ 0        │
│                                                                       │
│  RF EMI (MHD 방전 · γ-rocket 점화 · sensor/comm)                      │
│      → Faraday cage + cloak band-stop 셀 → 누설창 σ-φ=10 dB 억제       │
│      → 능동 송신은 cloak band 외 + LPI waveform (간헐 · 협대역)        │
│                                                                       │
│  IR plume (3-5 μm · 8-12 μm)                                          │
│      → cryo heat-sink (4 K/77 K, UFO/grav 공유) + 방사율 메타셀        │
│      → plume 후방 격리 + σ-φ=10 dB 억제                                │
└──────────────────────────────────────────────────────────────────────┘
```

**Stage 별 운용 모드**:
- **Stage-1 hover (0-20 km)**: cloak 전대역 active (대기권 radar 위협 최대) · RTSC Meissner self-shield 로 자장 누설 0 · 능동 송신 최소.
- **Stage-2 cruise (20-200 km)**: cloak + IR 억제 (MHD plume) · GW 통신 (UFO/grav · EM-free) 우선 → 능동 RF 송신 회피.
- **Stage-3+ escape (>200 km)**: 진공권 radar 위협 감소 → cloak idle 가능 · γ-rocket EMI 는 cage-only · stealth 우선순위 하향.

## 5. cross-link

- `UFO/HEXA-CLOAK.md` — Phase B HEXA-CLOAK 1차 reference (678 LOC · 항공 스텔스 n=6 산술 + Mk.I~V 진화)
- `UFO/CLOAK.md` — EM 가시성 차단 통합 spec (948 LOC · 음굴절률 SRR · RCS · 전대역 · 최대 source)
- `UFO/cloak/hexa-cloak.md` — in-tree 영문 변형 (471 LOC · 본 manifest 와 공존)
- `UFO/cloak-canon/cloak.md` — transformation-optics + ε-μ tensor 표준 (698 LOC)
- `UFO/hexa-cloak/hexa-cloak.md` — canonical aerospace stealth 변형 (474 LOC)
- `~/core/hexa-lang/stdlib/` — transformation-optics tensor / metamaterial FDTD / RCS 구현 SSOT (코드 home · @D d3)
- `UFO/structure/integrated-vehicle-structure.md` — §1 frame OML radar/EM caveat (HEXA-CLOAK overlay 적층 슬롯)
- `UFO/grav/README.md` — cryo 인프라 공유 (IR 억제 heat-sink) · GW 통신 (EM-free 송신 대체)
- `RTSC.md` — RT-SC 도체 사양 인수 (ε<0 공명 · Meissner self-shield)
- `FUSION.md` — Stage-2 cruise MHD 방전 EMI source
- `ANTIMATTER.md` — Stage-3 γ-rocket EMI + γ-shield source
- `UFO.md` Phase B milestone — HEXA-CLOAK 축 흡수 (이 흡수)
- @D d1 (non-wet-lab → completed-form) · @D d3 (stdlib SSOT) · @D d4 (single generic dispatch) · @D d9 (worktree isolation) · @D d10 (icon·name·alias 헤더)
