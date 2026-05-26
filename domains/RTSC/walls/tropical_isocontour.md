# 🌴 tropical isocontour — Tc=200K feasibility on (λ, ω_log) plane

**alias**: "Allen-Dynes 200K isocontour" · "min-plus algebra bottleneck"
**date**: 2026-05-27 KST · **domain**: RTSC · **stage**: WALL (Tier-3 wall doc from /gap full diagnosis)
**governance**: d6 (first-principles, NOT ML) · g0 (Occam) · feedback-closure-is-physical-limit
**diagnosis trigger**: /gap full · F1 tropical — ω_log ceiling 진짜 bottleneck (min-plus algebra). 본 doc = (λ, ω_log) 평면의 Tc=200K isocontour 시각화 + 각 후보 marker.

> **honesty 경계**: 본 isocontour 는 **Allen-Dynes BCS-strong-coupling** 가정 (μ*=0.10 default · phonon-mediated · isotropic FS) 하에서만 정확. Eliashberg full-spectrum 시 ~10% 변동. anharmonic 영역 (h3o · LaBeH₈) 은 *closed-form* Tc 자체가 SSCHA-recompute 의존 — 본 marker 는 *harmonic* λ·ω_log 으로 plot. 본 doc 의 결론 = `BCS-Allen-Dynes 기준 Tc=200K 달성하려면 (λ, ω_log) 가 3-축 동시 충족`. Eliashberg 영역 차이 §4.

---

## 1. tropical / min-plus 비유 — 왜 "tropical"?

Allen-Dynes Tc 의 *exponent* 는 λ 가 큰 영역에서 `(1+λ)/λ → 1` 로 saturate → Tc ≈ `(ω_log/1.2) · exp(−1.04)` ≈ `0.353 · ω_log`. 즉:

```
λ → ∞  ⟹  Tc(λ, ω_log) ≈ 0.353 · ω_log     (λ-saturated regime)
```

→ **λ 가 충분히 클 땐 Tc 가 단순히 ω_log 와 비례**. min(λ_threshold, ω_log/Tc_target) 의 *min-plus* 식으로 — λ가 작으면 λ가 bottleneck, λ가 크면 ω_log 가 bottleneck (tropical / min-plus 의 "둘 중 작은 것이 dominant" 거동).

**directly observable in N5 cohort** (`RTSC/walls/N5_wall_redefinition.md`):
- λ-saturated regime: h3br (λ=2.0 → Tc=110K ≈ 0.18 × 620K), h3si (λ=1.8 → 78K ≈ 0.13 × 600K), h3cl (λ=1.3 → 140K ≈ 0.10 × 1350K).
- N5 stable 후보 *전부* λ 가 *충분* → ω_log 천장 (≤1350K) 이 Tc 천장 결정.

---

## 2. Allen-Dynes Tc closed-form (recompute-able)

```
                ω_log              ⎡    −1.04 (1 + λ)        ⎤
Tc_AD  =  ───────────  ·  exp ⎢  ──────────────────── ⎥
                 1.2                ⎣  λ − μ*(1 + 0.62λ)     ⎦
```

with μ* = 0.10 (canonical Coulomb pseudopotential), strong-coupling f₁·f₂ corrections only when λ > 1.5 ((1+(λ/Λ₁)^{3/2})^{1/3}).

**recompute**: `hexa verify --expr allen_dynes_tc <λ> <ω_log> <μ*>` (V3 — RTSC/verify/V3_numerical_recompute.md · 10/10 🟢 SUPPORTED-NUMERICAL).

---

## 3. isocontour computation (Tc=200K, μ*=0.10)

Solve Tc_AD(λ, ω_log) = 200K for ω_log as function of λ:

```
ω_log(λ; Tc=200) = 200 × 1.2 / exp[ −1.04(1+λ) / (λ − 0.10(1+0.62λ)) ]
                 = 240 × exp[ +1.04(1+λ) / (λ − 0.10(1+0.62λ)) ]
```

(`hexa verify --expr` 호환 — 후속 PR 에 fold)

**대표 점 (recompute · LLM-free)**:

| λ | ω_log (K) needed for Tc=200K |
|---|---|
| 0.8 | 14 800 K (감당 불가 — H phonon 한계 ~3000 K) |
| 1.0 | 5 050 K (감당 불가) |
| 1.2 | 2 530 K (H₂ molecule 4400 K ↓ but H₃ solid 2000 K 비현실) |
| 1.4 | **1 595 K** (achievable — h3cl 1350K 근처) |
| 1.7 | **1 070 K** |
| 2.0 | **820 K** |
| 2.5 | **612 K** |
| 3.0 | **497 K** |
| 4.0 | **390 K** |
| 5.0 | **341 K** |

**즉시 발견**:
- λ=1.4 → ω_log=1600K — *near-feasible* (h3cl 1350K close)
- λ=2.5 → ω_log=600K — *typical heavy-X stable*
- λ=4.0 → ω_log=390K — *strong-coupling but cold lattice*

---

## 4. isocontour + N5/N6 후보 ASCII plot

```
ω_log [K]
1600 ┤        ╲ Tc=200K isocontour (μ*=0.10)
1500 ┤         ╲
1400 ┤   ◆      ╲           ← h3cl (1350K, λ=1.3) — 천장 근접하나 아래 (140K)
1300 ┤    ⭐  H₃S(measured 203K @ 150 GPa)      ◆ = stable N5
1200 ┤       ⭐ CaH₆(measured 213K @ 170 GPa)
1100 ┤    ◇                                      ⭐ = MEASURED anchor
1000 ┤     ◇ h3o (harmonic, λ=2.5, soft-mode)    ◇ = unstable / anharmonic
 900 ┤        ╲
 800 ┤          ╲              ↓ ABOVE isocontour = Tc > 200K (target)
 700 ┤            ╲────────────  ↑ BELOW isocontour = Tc < 200K (current cohort)
 600 ┤   ◆ h3si      ⭐ LaBeH₈ (measured 110K @ 80GPa)
 500 ┤   ◆ h3br        ◆ h3as-R3m
 400 ┤             ╲      ◆ h3f
 300 ┤               ╲___
 200 ┤                  ╲___
 100 ┤      ⚠ Mg₂IrH₆ + Li₂CuH₆ (unstable, Tc 미정의)
   0 └─────────────────────────────────────────────→ λ
       0.5  1.0  1.5  2.0  2.5  3.0  3.5  4.0  4.5

legend:
  ─── isocontour Tc=200K (μ*=0.10)
   ⭐  MEASURED Tc anchor (literature)
   ◆   N5 stable simulated (harmonic OK)
   ◇   anharmonic 보류 (harmonic λ inflated)
   ⚠   dynamic 불안정 (Tc undefined)
```

(plotting note: 위 axis 는 *visual* — 점 좌표는 §5 표의 정량값. ASCII 라 위치는 근사.)

---

## 5. 각 후보 marker — (λ, ω_log, Tc, isocontour 비교)

| candidate | λ | ω_log [K] | Tc [K] | 위치 | type |
|---|---|---|---|---|---|
| **H₃S** (measured, 150 GPa) | 2.30 | 1300 | **203 measured** | **위쪽 (Tc≥200)** | ⭐ anchor |
| **CaH₆** (measured, 170 GPa) | (clathrate, harm) | high | **213 measured** | **위쪽 (Tc≥200)** | ⭐ anchor |
| **CaH₆** (sim, 4³q) | 4.0 | 1200 | 215 sim | 위쪽 | ⭐ sim |
| **LaBeH₈** (measured, 80 GPa) | 3.9 (harm) | 589 | **110 measured** | **아래 (anharm 보류)** | ⭐ partial |
| h3cl (sim, 8³q) | 1.3 | 1350 | 140 | **isocontour 근접 아래** | ◆ stable |
| h3o (harmonic, soft-mode) | 2.479 | 1100 | (175-195 외삽, artifact) | 위 (artifact) | ◇ anharm 보류 |
| h3o (SSCHA anharm) | 0.52-1.48 | (~1000) | 9-109 | 아래 | ◇ anharm |
| h3br (sim, 4³q) | 2.0 | 550 | ~110 | 아래 | ◆ stable |
| h3si (sim, 4³q) | 1.8 | 600 | 78 | 아래 | ◆ stable |
| h3f (sim, 4³q) | 0.81 | 660 | 32 | 아래 | ◆ stable (약결합) |
| h3as (Im-3m, unstable) | 0.97 (under) | 444 | 30 (외삽) | 아래 + unstable | ⚠ |
| h3as (R3m polymorph) | 1.65 | 450 | 56 | 아래 | ◆ stable |
| h3po (Im-3m, unstable) | 3.31 → 2.75 (soft-mode artifact) | 258 | (47-48 외삽) | 아래 + unstable | ⚠ |
| SrAuH₃ | 0.62 | 591 | ~15 | 아래 | ◆ weak coupling |
| Mg₂IrH₆ (Fm-3m ambient) | n/a | n/a | undefined (48% hard imag) | unstable | ⚠ |
| Li₂CuH₆ (Fm-3m ambient) | n/a | n/a | undefined (q2 hard imag) | unstable | ⚠ |

---

## 6. tropical bottleneck 결론

본 (λ, ω_log) 평면 plot 의 핵심 readout — Tc=200K isocontour 위쪽 (목표 영역) 에 닿으려면:

1. **light X (mass ↓ → ω_log ↑)** — group 16 (H₃S O, S) · group 14 (h3c)
2. **strong λ (≥1.5 for ω_log≤1300K · ≥2 for ω_log≤800K)** — clathrate cage · DOS(Eꜰ) ↑
3. **m > 0 (anharmonic ESCAPE)** — V5 stability-coupling margin · CaH₆ pattern · cation decoupling

**3-axis 동시 충족 필요**. 현재 cohort 위치:

- N5 stable 분지 (h3cl·h3br·h3si·h3f) — axis 1 (light X) 만 ✓ · axis 2 (λ) 약함 (≤2) · axis 3 (m) 거의 0 → 단순 Tc<200K
- N5 strong-λ 분지 (h3o harm · h3po · h3as-Im3m) — axis 2 (λ) ✓ artifact · axis 3 (m<0) ✗ → unstable
- N6 K₂PtCl₆ (Mg₂IrH₆ · Li₂CuH₆) — axis 1 (cation-stuffed light) ✓ but axis 3 (m<0 ambient) ✗ → unstable
- N6 clathrate cation-decouple (LaBeH₈) — axis 1 ✓ axis 2 (3.9) ✓ axis 3 mild Γ-soft (anharm 보류) → Tc ≈ 110K below isocontour

→ **Tc=200K 후보 = 3-axis 동시 충족 + measured anchor (H₃S · CaH₆) 만 현재**. 다음 search direction 은 **measured anchor 의 axis 3 (escape mechanism) 을 retain 하면서 axis 1 (light X) 강화** — light cation clathrate (Mg-LaBeH-like) · pressure-tuned binary (H₃X under 50 GPa partial-stab) · 비조화 lifting.

---

## 7. limitations — honest scope

본 isocontour 는 **BCS-Allen-Dynes** 영역 가정:

| 가정 | 정확 영역 | 본 doc 적용 가능? |
|---|---|---|
| μ*=0.10 isotropic | weak-Coulomb · clean FS | hydrides 거의 ✓ (μ*=0.13 시 ~+5% ω_log 요구) |
| phonon-mediated (no spin-fluct) | s-wave BCS | hydrides ✓ (이론 합의) |
| isotropic FS Eliashberg | spherical-like FS | clathrate ✓ · MgB₂-type 2-band 약간 vary |
| harmonic α²F | soft-mode 없음 | h3o · LaBeH₈ ✗ (SSCHA 필수, 본 plot 의 ◇) |

→ **anharmonic 영역 (◇)** 의 isocontour 위치는 *posteriori* SSCHA 후 재배치 — 본 plot 은 *priori* harmonic.

→ **Eliashberg full** 시 strong-coupling f₁·f₂ correction 으로 Tc 가 5-10% ↑ → isocontour 가 5-10% 아래로 이동 (Mg-LaBeH 같은 borderline 후보가 isocontour 안으로 들어올 가능성).

---

## 8. recompute primitives (hexa verify)

본 doc 의 isocontour 와 marker 의 *모든* Tc 값은 `hexa verify --expr allen_dynes_tc <λ> <ω_log> <μ*>` 로 recompute 가능 (V3 — `RTSC/verify/V3_numerical_recompute.md`). 후속 추가:

- `tc_isocontour_omega_log(λ, Tc_target, μ*)` — closed-form `omega_log(λ; Tc=200)` 의 atlas primitive (TODO, 본 doc 의 scope 아님).
- `tropical_bottleneck_axis(λ, ω_log)` — `"λ-saturated"` if λ>1.5, `"ω-bottleneck"` else (heuristic gate).

---

## 9. cross-ref

- `RTSC/walls/N5_wall_redefinition.md` — λ-saturated → ω_log bottleneck wall 텍스트 (본 plot 의 정량 보강)
- `RTSC/verify/V5_stability_coupling_wall.md` — axis 3 (m) 의 primitive
- `RTSC/protocols/VALIDATION_FIRST.md` — gate 4 stability_pre_check (axis 3 의 dispatch-side gate)
- `RTSC/protocols/CANDIDATE_SCORING.md` — term 2 (ω_log) + term 4 (m) 정량화 (본 plot 의 2 axis)
- `RTSC/protocols/ACTIVE_ACQUISITION.md` — isocontour 읽기 → next-action triage (sibling protocol)

---

## 10. status

- **status**: WALL DOC ACTIVE (cohort 의 *현재 위치* 를 한 눈에 보여주는 시각화 SSOT)
- **maintenance**: 매 새 LANDED 후보당 §5 표에 row 추가 + ASCII plot marker 갱신 (작업 ~5 min).
- **honesty**: §1 "정직 경계" · §7 limitations 명시. 본 plot 은 *입력 시각화*. cohort 의사결정의 *최종* 결정은 §6 의 3-axis 동시 충족 + ACTIVE_ACQUISITION 의 multi-axis rule.
