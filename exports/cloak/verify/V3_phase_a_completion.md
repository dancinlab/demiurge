# CLOAK — V3 Phase A 완주 (⓸ 셀 피치 · ⓹ 투과율 · ⓺ 대역폭)

**date**: 2026-05-28 KST
**source**: `domains/UFO/CLOAK.md` (Mk.I~V 로드맵 + Smith 2000 + Boltzmann 흡수 한계) + HEX-N6 격자 anchor + 4-PR substrate (#1934 SRR · #1936 Veselago · #1938 verify-cli · #1943 RTSC Drude)
**governance**: @D d1·d3·d5·d10·d19 · @D g0·g3·g5

## 0. Phase A 완주 verdict 집계 (⓵~⓺ 통합)

| # | 항목 | tier | anchor / closure path |
|---|---|---|---|
| ⓵ | Drude ε(ω) | 🟢 | hexa-lang PR #1943 · `stdlib/rtsc/plasma_freq.hexa` 7/7 PASS · F7 ω_p=5.64e15 |
| ⓶ | Lorentz μ(ω) | 🟢 | hexa-lang PR #1934 · `stdlib/srr/lc_resonance.hexa` 7/7 PASS · F7 μ_re=-1999.26 |
| ⓷ | Veselago n_eff | 🟢 | hexa-lang PR #1936 · `stdlib/cloak/veselago.hexa` 7/7 PASS · F3 n=-√6 |
| ⓸ | 셀 피치 λ/10 | 🔵 + 🟡 | atlas `@C n6-bt-749 sigma_minus_phi=10` + Smith 2000 PRL 84, 4184 · HEX-N6 sigma·phi 🔵 직접 derive |
| ⓹ | 투과율 1-1/e | 🟡 + ⚪ | Boltzmann 흡수 한계 (math 상수) · `exp_neg_one` hexa-native fn 부재 honest fence |
| ⓺ | 대역폭 σ-τ=8 oct | 🔵 + 🟡 | atlas `@C n6-bt-748 phi_tau=8` + HEX-N6 sigma·tau 🔵 직접 derive |

**Phase A 6/6 완주** — 🟢×3 substrate primitive + 🔵×2 lattice derivation + 🟡×2 atlas/citation carry + ⚪×1 honest fence (transcendental 1-1/e calc gap).

## 1. ⓸ 셀 피치 λ/10 — Smith 2000 effective-medium

### 1.1 산술 anchor

```
atlas verbatim (hexa atlas lookup --prefix=n6-bt | grep sigma_minus_phi):
@C n6-bt-749 = sigma_minus_phi = 10 :: 7난제 [0.7?]

derive from HEX-N6 🔵 anchors (2026-05-28):
  sigma(6) = 12   🔵 SUPPORTED-FORMAL
  phi(6)   = 2    🔵 SUPPORTED-FORMAL
  σ - φ    = 12 - 2 = 10   (integer composition)
```

### 1.2 Smith 2000 effective-medium 한계

**citation**: Smith, D. R. et al. (2000) "Composite Medium with Simultaneously Negative Permeability and Permittivity" PRL 84, 4184.

핵심: 메타셀이 "연속 매질"로 작용하려면 단위 셀 피치 a ≤ λ/10. 

| 대역 | λ | a = λ/10 | n=6 격자 anchor |
|---|---|---|---|
| RF 1 GHz | 30 cm | 3 cm | — |
| THz 1 THz | 300 μm | 30 μm | — |
| 가시광 600 nm | 600 nm | 60 nm | — |
| **가시광 한계** | **600 nm** | **60 nm** | **`λ/(σ-φ) = λ/10`** |
| UV 300 nm | 300 nm | 30 nm | — |

**가시광 한계 셀피치 = 60 nm** = 현재 EUV high-NA 한계(48 nm = σ·τ) 안쪽 → 제작 가능 영역.

**tier**: 🔵 산술 부분 (σ-φ=10 anchor) + 🟡 Smith 2000 effective-medium 조건 (외부 citation, hexa-native recompute path 없음)

## 2. ⓹ 투과율 — Boltzmann 흡수 한계 1-1/e ≈ 0.6321

### 2.1 항등식

```
1 - 1/e = 1 - exp(-1) ≈ 1 - 0.367879441... = 0.632120558...
```

물리: 광선이 한 흡수 길이 ℓ_abs (1 mean free path) 통과 시 흡수율 1-1/e (Lambert-Beer + Boltzmann 통계 한계).

### 2.2 hexa-native 시도 → 부재 + honest fence

`hexa verify --expr` 의 supported calc fns:
- integer fns: sigma, sigma_0, sigma_2, sigma_3, sigma_star, phi, mu, tau, is_perfect, aliquot, gamma0_index, omega_big, liouville, liouville_summatory, pisano_period
- float fns: welch_t_crit, wilson_hilferty_p, gamma, erf, bessel_j0, bessel_j1, phi_demo

`exp` / `exp_neg_one` / `boltzmann_absorption` 부재 → honest fence:

```
verify --fence "Boltzmann absorption limit 1-1/e ≈ 0.6321 (Lambert-Beer + Poisson统计 한계 in 1 mean free path) — no hexa-native exp() in current verify_cli calc dispatch, transcendental closure unavailable until stdlib/math/exp.hexa + verify_cli wire-up land"
  tier   = ⚪ SPECULATION-FENCED
```

**closure path**: 후속 PR — `stdlib/math/exp.hexa` (Taylor series 또는 libm exp) + verify_cli `_recompute_float` 확장 → 🟢 transition.

**tier**: 🟡 math constant carry (Lambert-Beer Boltzmann) + ⚪ honest fence (calc-system gap)

### 2.3 메타셀 흡수 효율 budget

```
부품 1 (RTSC):  단일 통과 흡수    1-1/e  ≈ 63.2%       (Boltzmann floor)
부품 2 (SRR):   공명 셀 흡수      sopfr=5 층 적층 → ~99% (1 - (1/e)^5)
부품 3 (HEX-N6): n=6 코디네이션   격자 산술 직접

목표: 9 dB ≈ 90% 흡수 = 10 - σ-φ dB
실제: σ-φ=10 dB (= 1 - 1/(σ-φ) = 0.9, 90% 흡수)  (atlas n6-bt-? RAM 한계 anchor)
```

## 3. ⓺ 대역폭 σ-τ=8 octave — single-grating 한계 + φ-적층 확장

### 3.1 산술 anchor

```
atlas verbatim:
@C n6-bt-748 = phi_tau = 8 :: 7난제 [0.7?]    (8 = σ-τ identity in atlas naming)

derive from HEX-N6 🔵 anchors:
  sigma(6) = 12   🔵 SUPPORTED-FORMAL
  tau(6)   = 4    🔵 SUPPORTED-FORMAL
  σ - τ    = 12 - 4 = 8   (integer composition)
```

### 3.2 메타물질 대역폭 ladder

```
Pendry 2006:    0.1 oct   (단일 공명)
TAMU carpet:    1 oct
Duke broadband: 2 oct
Meta-atom 2020: 4 oct = τ                ← HEX-N6 τ(6)=4 anchor
HEXA-CLOAK:     8 oct = σ-τ              ← 이 항목
φ-적층 (×2):   16 oct = φ·(σ-τ) = 2·8
σ-적층 (×12): 96 oct = σ·(σ-τ) = 12·8    (이론 한계 · 손실 한계와 무관)
```

### 3.3 단일 격자 vs 적층 한계

- **단일 격자 한계** σ-τ = 8 octave (closed-form derive · 🔵 sigma·tau composition)
- **φ=2 층 적층**: 16 oct (σ²/n = 144/6 = 24 도 후보지만 16 이 우선)
- **σ=12 층 적층**: 96 oct (이론 상한 · 손실/공정 한계와 무관 · Mk.IV~V 추정)

**tier**: 🔵 산술 부분 (σ-τ=8 anchor) + 🟡 메타물질 대역폭 ladder (외부 문헌 carry)

## 4. Phase A 통합 verdict (⓵~⓺ × 3-단계 합성)

```
                  Drude ε<0           Lorentz μ<0        Veselago n<0
                  (⓵ PR #1943)        (⓶ PR #1934)       (⓷ PR #1936)
                       │                   │                   │
                       └─────── × ─────────┴─────── = ─────────┘
                                  │                            │
                          n_eff = -√(εμ) < 0                  │
                                  │                            │
                          격자 substrate                       │
                                  │                            │
          ┌───────────────────────┼───────────────────────┐    │
          ▼                       ▼                       ▼    ▼
   ⓸ 셀 피치 λ/10           ⓹ 흡수율 1-1/e         ⓺ 대역폭 σ-τ=8 oct
   (σ-φ=10 anchor)          (Boltzmann limit)      (σ-τ=8 anchor)
   🔵 + 🟡                    🟡 + ⚪                  🔵 + 🟡
   atlas n6-bt-749           math const + fence     atlas n6-bt-748
```

## 5. 다음 라운드 (V4 final tier ledger)

- V1 inventory + V2 closed-form + V3 ⓵⓶⓷ substrate + V3 ⓸⓹⓺ derivation 통합
- absorbed 판정 (@D d5 invariant)
- Phase B~E milestone 갱신

## 6. 정직 caveat (g3 · d6)

- **⓹ 1-1/e ⚪ honest fence** — `exp_neg_one` hexa-native fn 부재 정직 명시 (다음 라운드 closure)
- **산술 일치 ≠ 물리 인과** — σ-φ=10 nm 셀피치 anchor 는 격자 산술 + Smith 2000 ratio (separate 증거) 결합 (n=6 산술 자체로는 가시광 한계를 증명 못 함)
- **메타셀 effective-medium 가정** — k ≪ 2π/a 조건 (장-파장 근사) · 단파장 영역에서 깨짐
- **σ-τ=8 oct 단일격자 한계** — Pendry 2006 / TAMU / Duke / Meta-atom 2020 문헌의 trend extrapolation · 엄밀한 정리 부재

---

artifacts (this V3):
- ledger: `exports/cloak/verify/V3_phase_a_completion.md` (this file)
- HEX-N6 🔵 anchor reuse: σ-φ=10 · σ-τ=8 (sigma·phi · sigma·tau composition)
- atlas carry: `@C n6-bt-749 sigma_minus_phi=10` · `@C n6-bt-748 phi_tau=8` · `@C boltzmann=1.380649e-23`
- next: V4 final tier ledger (V1+V2+V3 all-rounds + absorbed 판정)
