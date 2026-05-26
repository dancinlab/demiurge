# 🛸 UFO/hover — HEXA-HOVER 축 흡수 (Meissner levitation 사양)

> alias: `hover` · UFO Stage-1 부상축 · 비행체 0~20km 고도 영역의 부상력 SSOT manifest

## 0. TL;DR — UFO Stage-1 Meissner levitation 흡수 요약

UFO Stage-1 hover 축은 **RTSC 자석(48T 솔레노이드) + 비행체 하부 도체 plate (HTS / RT-SC 후보)** 의 **Meissner 반자성 부상력** 으로 0~20 km 고도를 커버한다. 본 manifest 는 `~/core/hexa-ufo/HEXA-HOVER.md` (32KB · 706 LOC) + `~/core/hexa-ufo/HOVER.md` (36KB · 733 LOC) 두 SSOT 의 사양 측면만 흡수하며, 부상력 계산 코드는 hexa-lang/stdlib 또는 hexa-ufo 의 canonical home 에 둔다 (@D d3).

```
   ┌─────────────────────────────────────────────────────────────┐
   │                       비행체 동체                            │
   │                                                             │
   │   ╔══════════════════════════════════════════════════════╗  │
   │   ║   하부 도체 plate (HTS REBCO / RT-SC 후보)           ║  │
   │   ║   χ_diamag < 0 · Meissner 효과 active                 ║  │
   │   ╚══════════════════════════════════════════════════════╝  │
   │           ▲ F_lev = (B·∇B/μ₀) · V · |χ|                     │
   │           │                                                 │
   │   ··· B-field (외부 자장: 지자기 + RTSC 인공 안내 솔레노이드) ···
   │   ──────────────────────────────────────────────────────    │
   │   ▒▒▒▒▒▒▒▒▒▒▒▒  지면 / 안내 레일  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒          │
   └─────────────────────────────────────────────────────────────┘
```

핵심:

- **무동력 부상**: Meissner 반자성 → 정상상태 0 W (열손실 = 도체 R(T) 잔류 · 안정성 제어 W 만)
- **자석 자산 = RTSC**: `RTSC.md` 솔레노이드 (HTS REBCO 77K · μ_r≈1) 또는 RT-SC 가설 자산 reference
- **고도 범위**: 0~20 km · 지자기 (B≈25-65 μT) + 인공 안내 자기장 (RTSC 솔레노이드 array · B≈1-48 T 국소)
- **안정성**: Earnshaw 정리에 따라 정적 부상 불가 → active feedback (gyro · 자기 stiffness coil)

## 1. 흡수 source

| source | path | SHA-1 | LOC | size | 흡수 일자 |
|--------|------|-------|-----|------|-----------|
| HEXA-HOVER spec | `~/core/hexa-ufo/HEXA-HOVER.md` | `a5f60e2582fcb27ff24f3119a5eaa69ce8b8298d` | 706 | 32 KB | 2026-05-25 |
| HOVER spec | `~/core/hexa-ufo/HOVER.md` | `acd19ccb8c291ba49d3ab94e79afd8e150afd267` | 733 | 36 KB | 2026-05-25 |
| hover-canon dir | `~/core/hexa-ufo/hover-canon/` | (tree) | — | — | 2026-05-25 |
| hexa-hover dir | `~/core/hexa-ufo/hexa-hover/` | (tree) | — | — | 2026-05-25 |
| hover dir | `~/core/hexa-ufo/hover/` | (tree) | — | — | 2026-05-25 |

흡수 범위 = **사양 manifest 만**. 실제 levitation 계산 / 시뮬 코드는 `~/core/hexa-lang/stdlib` (cross-domain) 또는 `~/core/hexa-ufo` 의 canonical home 에 두며 본 manifest 는 reference 로 cross-link 한다 (@D d3 — 단일 canonical 구현 home).

## 2. 부상 원리 — Meissner 효과 closed-form

Meissner 반자성 부상력 (1 차 근사, paramagnetic 무시):

```
F_lev = (1/μ₀) · ∫ |χ| · B · (∇B) dV   [N]

여기서:
   χ      = 반자성 자화율 (Meissner 상태 χ ≈ -1, perfect diamagnet)
   B      = local 자기장 [T]
   ∇B     = local 자기장 구배 [T/m]
   V      = 도체 plate 부피 [m³]
   μ₀     = 진공 투자율 = 4π × 10⁻⁷ [T·m/A]
```

단순 가정 (균질 plate · 1-D 구배):

```
F_lev ≈ |χ| · V · B · (dB/dz) / μ₀   [N]
```

1인승 비행체 (m = 60 kg + payload 30 kg = 90 kg total, mg ≈ 883 N) 부상에 필요한:

- B · (dB/dz) ≈ μ₀ · m · g / (|χ| · V)
- |χ| = 1 (perfect Meissner) · V = 0.01 m³ (1 m² × 10 mm plate) 가정 → B·(dB/dz) ≈ 1.1 × 10⁵ T²/m
- → 예: B = 5 T, dB/dz = 2.2 × 10⁴ T/m (강한 구배) 또는 B = 10 T, dB/dz = 1.1 × 10⁴ T/m

**구배 자기장 = 핵심**: 균일 B-field 만으로는 부상력 0 (∇B = 0). RTSC.md 의 솔레노이드 array 가 의도적 ∇B 를 제공.

## 3. 자석 사양 — RTSC 48T 솔레노이드 (자산 reference)

| 항목 | 값 | source |
|------|-----|--------|
| device | HTS 솔레노이드 array | `RTSC.md` §1 device 축 |
| conductor | HTS REBCO (77K · μ_r ≈ 1) | `RTSC.md` §2-§3 |
| target peak B | 48 T (n=6 산술 σ·τ=48) | `~/core/hexa-ufo/HEXA-HOVER.md` |
| formulation | 2-D axisym A-φ 선형 magnetostatic (GetDP 3.5.0) | `RTSC.md` line 187 |
| .pro template | `RTSC/magnet/getdp/solenoid_axisym.pro` | PR #92 (RTSC.md line 301) |
| Meissner 검증 | ✓ (closed-form + GetDP cross) | `RTSC.md` line 178 매트릭스 |
| Tc 사양 | RT-SC (≥ 270 K) 가설 추적 중 | `RTSC.md` line 543 |

cross-link: 본 UFO/hover manifest 는 **자석 substrate** 를 `RTSC.md` 에 위임 — UFO Stage-1 부상력은 `RTSC.md` 의 verify 결과를 consume.

## 4. 도체 사양 — 비행체 하부 plate 비교

| 도체 후보 | T_c | |χ| | 동작 온도 | 냉각 | 1차 후보? |
|----------|-----|-----|-----------|------|-----------|
| Cu (상전도) | — | ~10⁻⁵ | 상온 OK | ✗ | ✗ (반자성 너무 약함) |
| Nb-Ti (LTS) | 9.2 K | ~1 | 4.2 K (LHe) | ✓ 무거움 | △ (냉각 부담) |
| YBCO REBCO (HTS) | 92 K | ~1 | 77 K (LN₂) | ✓ 경량화 가능 | ✓ 현실적 1차 후보 |
| MgB₂ | 39 K | ~1 | 20 K (cryocooler) | ✓ | △ |
| RT-SC 후보 (가설) | ≥ 270 K | ~1 | 상온 동작 | ✗ 불필요 | ✓ 궁극 목표 (RTSC.md 추적) |

**1차 absorb 결정**: HTS REBCO (77 K LN₂ 냉각) — 현재 실현 가능 + RTSC.md 의 `device=솔레노이드 · conductor=HTS REBCO` 와 동일 라인.

**궁극 absorb 목표**: RT-SC 후보 가설 (RTSC.md §8.4 9-test 매트릭스 통과 시) — 냉각 인프라 제거 → 비행체 무게/복잡도 σ-φ=10× 감소.

## 5. 동적 안정성 — Earnshaw + active feedback

**Earnshaw 정리**: 정전기 / 정자기 만으로는 자유공간 3-D 안정 정지점 부상 불가능 (Δ²V ≥ 0).

→ **active stabilization 필수**. 3 경로:

1. **자기 stiffness coil** (active EM feedback) — 6-DOF (x,y,z + roll,pitch,yaw) 별 PID 제어, 응답 μ=1 ms (HEXA-HOVER.md §4 line 100 인용).
2. **gyro 자율 안정화** — n=6 로터 60° 간격 배치 (HEXA-HOVER §1.2), 각운동량 보존으로 roll/pitch 복원.
3. **dynamic Meissner (flux pinning)** — Type-II 초전도체 flux pinning 사용 시 부분적 정적 안정 (pinning force ≈ Meissner force) → Earnshaw 우회.

**1차 absorb 결정**: 3 경로 hybrid (active coil 주 + gyro 보조 + flux pinning 보강).

## 6. 고도 범위 — 0~20 km

| 고도 영역 | 외부 B-source | 부상 모드 |
|-----------|---------------|-----------|
| 0~10 m | 지면 안내 레일 (RTSC 솔레노이드 array · B≈1-10 T 국소) | 강 부상 (low-altitude) |
| 10 m~1 km | 분산 안내 솔레노이드 grid (도시 인프라) | 중 부상 (cruise low) |
| 1~20 km | 지자기 (B≈25-65 μT) + 비행체 탑재 자석 array | 약 부상 + 양력 보조 (atmospheric assist) |

> 20 km 이상은 UFO Stage-2 cruise (`FUSION.md` MHD 추진) 로 인계 — Stage-1 의 종착 고도.

## 7. cross-link

- `~/core/hexa-ufo/HEXA-HOVER.md` — Stage-1 호버보드 spec SSOT (706 LOC · n=6 산술 + σ·τ=48 + 13-falsifier)
- `~/core/hexa-ufo/HOVER.md` — 1인승 호버카 spec (733 LOC · Meissner 부양 + AI 자동 충돌회피)
- `~/core/hexa-ufo/hover-canon/`, `~/core/hexa-ufo/hexa-hover/`, `~/core/hexa-ufo/hover/` — 보조 canon 디렉터리
- `~/core/demiurge/RTSC.md` — Stage-1 자석 substrate (Meissner 검증 · 48T 솔레노이드 · HTS REBCO · 9-test 매트릭스)
- `~/core/demiurge/UFO.md` Phase A milestone Stage-1 hover + Phase B HEXA-HOVER 축 흡수
- @D d1 (non-wet-lab → completed-form) · @D d3 (stdlib SSOT) · @D d4 (single generic dispatch) · @D d10 (icon·name·alias 헤더)
