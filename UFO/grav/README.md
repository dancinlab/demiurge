# 🛸 UFO/grav — HEXA-GRAV 축 흡수 (gravity-wave + quantum-gravity-sensor 사양)

> alias: `grav` · UFO Phase B 부수 5축 중 3/5 (HEXA-HOVER ✓ · HEXA-SIM ✓ · **HEXA-GRAV** · HEXA-CLOAK · HEXA-TELEPORT) · 비행체 관성/중력 sensor + GW 검출/통신 사양 SSOT manifest

## 0. TL;DR — UFO/grav 축 흡수 요약 (gravity wave + sensor + 비행체 통합)

UFO/grav 축은 **(1) gravity-wave 검출·통신 (LIGO 4 km → SC 42 km 미니어처)** + **(2) quantum-gravity-sensor (관성 보강용 atom-interferometer + superconducting gravimeter)** 의 두 사양을 묶어 비행체 통합 가능성 manifest 로 흡수한다. 본 디렉터리는 사양 manifest 만 보유하며, 실제 sensor / interferometer / SQUID 계산 코드는 `~/core/hexa-lang/stdlib/` 또는 `UFO/hexa-grav/` 의 canonical home 에 둔다 (@D d3).

```
   ┌───────────────────────────────────────────────────────────────────────┐
   │                       비행체 동체                                       │
   │                                                                       │
   │   ╔═════════════════════════════════════════════════════════════════╗ │
   │   ║  ① GW arm (mini-LIGO · L_arm ≈ 1-10 m · SC 미러 finesse=σ·τ=48) ║ │
   │   ║      h ~ 10⁻²³ (n=6 σ·J₂·10⁻²⁶) · BH-병합 검출 + 지각관통 통신   ║ │
   │   ╠═════════════════════════════════════════════════════════════════╣ │
   │   ║  ② QGS bay (관성 보강 · IMU+)                                    ║ │
   │   ║     ┌────────────────────┬────────────────────────┐             ║ │
   │   ║     │ atom interferometer│ SC gravimeter (SQUID)   │             ║ │
   │   ║     │ Δg ≤ 10⁻¹¹ g       │ B-fT/√Hz (σ·τ=48 fT)    │             ║ │
   │   ║     └────────────────────┴────────────────────────┘             ║ │
   │   ╚═════════════════════════════════════════════════════════════════╝ │
   │           ⇅ EM/관성 separation (Stage-1/2/3 추진 cross-talk 0)        │
   │   ··· Stage-1 RTSC 솔레노이드 B-field (≈1-48 T) — shielded ···         │
   └───────────────────────────────────────────────────────────────────────┘
```

핵심:

- **이중 사양**: gravity-wave (관측 + 잠재 통신) + quantum-gravity-sensor (관성/중력 보강 IMU+)
- **비행체 탑재 미니어처화**: LIGO 4 km → SC 42 km equivalent arm (광공진 finesse · n=6 σ·τ=48)
- **EM/관성 separation**: Stage-1 RTSC 솔레노이드 자장 cross-talk 0 — shielded + active null
- **falsifier preregister**: 감도 10⁻²³ 미달 / Δg 10⁻¹¹ 미달 시 사양 폐기

## 1. 흡수 source — `UFO/HEXA-GRAV.md` + grav-canon 디렉터리 인벤토리

| source | path | SHA-1 | LOC | 비고 |
|--------|------|-------|-----|------|
| HEXA-GRAV spec | `UFO/HEXA-GRAV.md` | `2d9c00d13deffda2d0d947963888cd534cb7c6b1` | 653 | 본 흡수의 1차 reference |
| hexa-grav dir | `UFO/hexa-grav/hexa-grav.md` | `a1843b842b6c149af28352fb37424fe393ddb486` | 656 | canonical variant |
| grav dir (in-tree) | `UFO/grav/hexa-grav.md` | `f4aabb59854687bc0b9b3d2e7219764369d8d8d0` | 653 | 본 manifest와 공존 |
| gravity-wave canon | `UFO/gravity-wave-canon/gravity-wave.md` | `78e02449236d2b92def7a7ca147de274ab958b66` | 855 | GW 표준 (LIGO σ=12) |
| QGS canon | `UFO/quantum-gravity-sensor-canon/quantum-gravity-sensor.md` | `a99655a854b69839af026d4457fb35f30fe1e1c4` | 861 | atom + SQUID 사양 |

흡수 일자: 2026-05-25 · 흡수 범위 = **사양 manifest 만** — 실제 GW interferometer / atom-interferometer / SQUID 계산 코드는 `~/core/hexa-lang/stdlib/` (cross-domain) 또는 `UFO/hexa-grav/` canonical home 에 두고 본 manifest 는 reference 로 cross-link (@D d3).

## 2. Gravity-wave 사양 — LIGO-class detector miniaturization

비행체 탑재 가능 미니어처 LIGO 사양 (gravity-wave-canon §1-§4 기반).

| 항목 | LIGO O4 (지상) | UFO 탑재형 (target) | n=6 근거 |
|------|----------------|---------------------|---------|
| arm 물리 길이 | 4 km | **1-10 m** | 비행체 fit (sopfr=5 m typ) |
| arm 광등가 길이 | 100-300 km | **42 km eq.** | n=6 · finesse F=σ·τ=48 |
| 미러 | 약 40 kg fused silica | **SC 코팅 micro-mirror** | HTS REBCO 반사 · χ_diamag |
| 감도 (strain) | h ~ 10⁻²¹ | **h ~ 10⁻²³** | σ·J₂·10⁻²⁶ = 12·24·10⁻²⁶ |
| 검출률 | 연 ~10건 | **연 σ·τ=48건** | BH-병합 매주 n=6건 |
| SQUID 자장 floor | — | **1 fT/√Hz** | σ·τ=48 fT/√Hz 한계 |
| 활용 | 관측-only | **관측 + 잠재 통신** | GW 지각관통 (EM 차폐 무관) |

**비행체 탑재 가능성**:
- 진공 베이 (10⁻⁹ Torr) 1-10 m arm · SC micro-mirror finesse F=48 → 등가 arm L_eff = L · 2F/π ≈ 30 F · L_arm 광경로
- 진동 분리: HEXA-HOVER active stabilization 의 6-DOF PID (μ=1 ms) 와 공유 — gyro/PID feedback 재활용 (@D d4 generic dispatch)
- 잠재 GW 통신: BH-병합 신호 외 인공 변조 GW 송신 (이론적 · falsifier 영역) — `~/core/hexa-ufo/HEXA-GRAV.md` Mk.V 가설

**falsifier preregister** (gravity-wave-canon §7.10 + HEXA-GRAV §7.10 기반):
1. arm 1 m 의 SC 미러 finesse F=48 미달 시 (h 감도 > 10⁻²² 한계) → 미니어처화 사양 폐기.
2. BH-병합 검출률 < 연 1 건 (12-month 누적) 시 → 비행체 탑재 가치 폐기.
3. GW 통신 송신 SNR 미달 (수신/잡음 < 3σ) → Mk.V 통신 가설 폐기 · 관측-only 모드 유지.

## 3. Quantum-gravity-sensor 사양 — atom interferometer + SC gravimeter (관성 보강)

QGS canon 의 두 sensor primitive 를 비행체 IMU+ 로 흡수.

| sensor | primitive | floor (target) | 비행체 활용 |
|--------|-----------|----------------|------------|
| atom interferometer | Mach-Zehnder Raman π/2-π-π/2 | **Δg ≤ 10⁻¹¹ g** | 절대 가속도 (drift-free IMU) |
| SC gravimeter | SQUID + sphere levitation | **B-fT/√Hz (σ·τ=48)** | 외부 중력 구배 (지질·관통 mass detect) |
| atomic clock (보조) | Sr/Yb 광격자 | **Δν/ν ≤ 10⁻¹⁸** | 시각 동기 + 적색편이 hot-test |

**관성 보강 활용**:
- **drift-free IMU**: 현재 비행체 IMU (MEMS gyro+accel) drift ~ 1°/h. atom-interferometer 추가 → 절대 가속도 reference 로 calibration → 누적 위치오차 σ-φ=10× 축소.
- **stealth 항법 (GPS-denied)**: GPS-spoof 환경에서 atom-IF + SQUID gravimeter 중력 지도 매칭 → 추정 위치오차 σ·τ=48 m → 10 m 수준.
- **mass 침투 detect**: 비행체 하방 mass anomaly (지하 시설·암반) → SC gravimeter B-fT 신호.

**환경 요건**:
- atom-IF: 진공 10⁻⁹ Torr · 자기 차폐 (B_ext < 10 nT) — RTSC 솔레노이드 48 T 와 거리 σ-φ=10 m 또는 mu-metal 적층 차폐.
- SC gravimeter: 4 K (LHe) 또는 20 K (cryocooler) — 비행체 cryo 인프라 공유 (HEXA-HOVER HTS REBCO 77 K · FUSION HTS magnet 20 K).

**falsifier preregister**:
1. atom-IF Δg > 10⁻¹⁰ g (1 σ, 1 Hz 대역) → 관성 보강 사양 폐기 · 기존 MEMS IMU 만 유지.
2. SC gravimeter B-floor > 10 fT/√Hz @ 1 Hz → 외부 중력 mapping 가치 폐기.
3. RTSC 자장 cross-talk 으로 atom-IF fringe contrast < 0.3 → EM/관성 separation 사양 재설계 필요.

## 4. 비행체 통합 — EM/관성 separation + 시그널 isolation

UFO 비행체에 GW + QGS 통합 시 가장 큰 risk = **Stage-1/2/3 추진 system 의 EM/관성 cross-talk**.

| risk axis | source | 차폐/isolation 방안 |
|-----------|--------|---------------------|
| RTSC 솔레노이드 자장 | Stage-1 hover (B ≈ 1-48 T) | mu-metal 적층 (μ_r ≈ 10⁵) · 거리 σ-φ=10 m · active null coil |
| FUSION MHD 추력 진동 | Stage-2 cruise | 6-DOF active 진동분리 (PID μ=1 ms, HEXA-HOVER 와 공유) |
| ANTIMATTER γ-rocket EMI | Stage-3 escape | Pb 차폐 + Faraday cage · GW arm 광경로는 진공 격리 |
| 비행체 자체 가속도 | Stage-1~3 thrust | atom-IF self-calibration · 비행 구간별 IMU offset 보정 |
| thermal drift | cryo 인프라 | 4 K LHe + 77 K LN₂ 다층 dewar · 외피 280 K reservoir |

**EM/관성 separation 요구**:

```
┌──────────────────────────────────────────────────────────────────────┐
│  비행체 통합 시그널 isolation budget                                   │
├──────────────────────────────────────────────────────────────────────┤
│  RTSC 솔레노이드 B (1-48 T)                                           │
│      → mu-metal × 5 layers (1/μ_r⁵ ≈ 10⁻²⁵)                          │
│      → 거리 σ-φ=10 m · 1/r³ 감쇠 (≈10⁻³)                              │
│      → active null coil · 잔류 < 10 nT (atom-IF spec)                │
│                                                                       │
│  진동 (MHD/γ-rocket)                                                  │
│      → 6-DOF active platform · 1 Hz~10 kHz 영역 -120 dB              │
│      → 잔류 변위 < 10⁻¹⁸ m/√Hz (GW arm spec)                          │
│                                                                       │
│  열                                                                   │
│      → 다층 dewar (280 K → 77 K → 20 K → 4 K)                         │
│      → cryo 인프라 σ·τ=48 W 부하 (재활용 hover/FUSION)                 │
└──────────────────────────────────────────────────────────────────────┘
```

**Stage 별 운용 모드**:
- **Stage-1 hover (0-20 km)**: atom-IF + SC gravimeter active (GPS-denied 항법 강화) · GW arm idle (지자기/RTSC 노이즈 큼).
- **Stage-2 cruise (20-200 km)**: atom-IF + GW arm dual mode (대기 진동 감소).
- **Stage-3+ escape (>200 km)**: 진공·무진동 영역 → GW arm 풀 감도 (h ~ 10⁻²³) · QGS 절대 항법.

## 5. cross-link

- `UFO/HEXA-GRAV.md` — Phase B HEXA-GRAV 1차 reference (653 LOC · n=6 산술 + Mk.I~V 진화)
- `UFO/hexa-grav/hexa-grav.md` — canonical variant (656 LOC)
- `UFO/grav/hexa-grav.md` — in-tree spec (653 LOC · 본 manifest 와 공존)
- `UFO/gravity-wave-canon/gravity-wave.md` — LIGO 표준 + miniaturization (855 LOC)
- `UFO/quantum-gravity-sensor-canon/quantum-gravity-sensor.md` — atom-IF + SQUID 표준 (861 LOC)
- `~/core/hexa-lang/stdlib/` — sensor / interferometer / SQUID 구현 SSOT (코드 home · @D d3)
- `RTSC.md` — 자석 cross-talk source · mu-metal 차폐 spec 인수
- `FUSION.md` — Stage-2 cruise MHD 진동 source
- `ANTIMATTER.md` — Stage-3 γ-rocket EMI source
- `UFO.md` Phase B milestone — HEXA-GRAV 축 흡수 (이 흡수)
- @D d1 (non-wet-lab → completed-form) · @D d3 (stdlib SSOT) · @D d4 (single generic dispatch) · @D d9 (worktree isolation) · @D d10 (icon·name·alias 헤더)
