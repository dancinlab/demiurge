# H₃Br DFT 도착 시 critical-test 가설 — group-17 mid-heavy halide outlier

**status**: pre-arrival hypothesis (cycle 7 closure 2026-05-24)
**ETA**: DFT 결과 도착 ~04:00 5/25 KST (~25h)
**scope**: H₃Br Im-3m primitive · celldm 6.6 bohr · 4 atom · group-17
**reason**: ALIGNN family-wide 9/9 baseline 에서 H₃Br λ=1.11 이 **family 안 유일 λ≥1 outlier** (h3cl 0.81 외) — group-17 mid-heavy halide axis 의 결정적 test point

---

## ALIGNN cycle 7 numerical fingerprint

| 항목 | 값 | meta |
|---|---:|---|
| λ (Allen-Dynes from a²F) | **1.11** | family 안 유일 strong-coupling outlier 외 h3cl |
| ω_log | 29 K | 매우 낮음 (Br heavy mass) |
| Tc-direct head | 4.29 K | family typical cap |
| celldm | 6.60 bohr | h3cl 5.66 보다 17% 큰 cell |
| anion χ | 2.96 | F 3.98 · Cl 3.16 · Br 2.96 — group-17 단조 감소 |
| anion mass | 79.9 amu | F 19 · Cl 35.5 · Br 79.9 |

artifact: `~/etc/rtsc-results/h3br/alignn_predict.json` (cycle 7, pool:ubu-1 sync 완료)

---

## critical-test 가설 3종

### (a) h3cl monotone broad sweep 패턴 재현 → DFT λ 진짜 1.5+

cycle 5 의 h3cl DFT 결과 (§9.15) = λ 1.14–1.41 monotone 상승 (broad 0.015–0.030, 6³ q 미수렴 sign). ALIGNN underprediction +57% (0.81 vs 1.27 DFT). H₃Br 도 같은 under-conv 패턴이면 DFT λ ≈ 1.5–1.8 가능 → group-17 안에서 H₃Cl 보다 더 강한 결합.

### (b) χ-damage 가설 검증 — light X 과보호 falsified, mid-heavy χ 가 sweet spot

§9.15 Bayesian update (RTSC.log) 에서 group-17 trend = electronegativity-damage dominant (light F 가장 약함). 단조 extrapolation:
- H₃F (χ=3.98) → Tc 31 K (LANDED 🔴 FAIL below)
- H₃Cl (χ=3.16) → Tc 120 K (LANDED 🔴 FAIL above)
- **H₃Br (χ=2.96) → Tc 50–100 K 예상** (χ-damage 더 약함, mass-volume penalty 절반)

→ group-17 sweet spot = mid-heavy halide 가설 결정적 검증. **PASS pred 50–100** 이면 group-17 axis = χ-damage dominant 확정 · FAIL 이면 mass-volume axis 추가 필요.

### (c) celldm 6.6 → ω_log 손해 → Tc cap

celldm 6.6 bohr (h3cl 5.66 보다 17% 큰 cell, ω_log proportional to 1/cell^α) → DFT ω_log 가 1000 K → 400-600 K 범위로 떨어질 가능성. Tc_AD = ω_log × f(λ) → λ 1.5 라도 ω_log 가 절반이면 Tc 절반. 정량 예측:

| λ | ω_log (K) | Tc_AD μ=0.10 (K) |
|---:|---:|---:|
| 1.1 (ALIGNN as-is) | 30 | <2 (family cap) |
| 1.5 (h3cl 패턴) | 400 | 50–70 |
| 1.5 | 600 | 80–100 |
| 1.8 | 600 | 100–130 |

---

## 예상 결과 zone

- **Tc(h3br) DFT μ=0.10 ~ 50–100 K** (cycle 7 ALIGNN strong-coupling hint + Br χ-damage 약함 + celldm 6.6 ω_log 손해)
- group-17 정정된 trend = electronegativity-damage dominant (light F 가장 약함, mid-heavy halide Br 가 sweet spot 일 가능성)

## DFT 도착 시 actions

1. `~/etc/rtsc-results/h3br/dft_complete_*.json` parse → λ · ω_log · Tc 추출
2. (a)/(b)/(c) 3 가설 verdict (PASS/FAIL) 표 갱신
3. RTSC.log.md §9.15 의 h3br 행 verdict 확정 (4-zone 정렬 update)
4. inbox `d7-wall-mechanism-breakthrough-paths-2026-05-23.md` 의 cycle 8 update section
5. group-17 axis verdict 확정 (χ-damage dominant 여부) — RTSC.md §9.14 ALIGNN family-wide 표 의 H₃Br 행 갱신

## R4 보호

- `absorbed=false` · `gate_type=simulation-only-prediction` · domain=material
- 본 가설 ≠ discovery claim — DFT prediction 의 critical-test 만
- ambient 영역 PASS/FAIL 와 무관 (high-P regime 150-200 GPa)

## 연관

- `d7-wall-mechanism-breakthrough-paths-2026-05-23.md` (2026-05-24 update) — ALIGNN family-wide 9/9 통합
- `h3cl-d7-wall-breakthrough-2026-05-23.md` — h3cl monotone broad sweep root data (가설 (a) reference)
- `h3o-novel-191k-group16-sweet-spot-2026-05-23.md` — group-16 axis (parallel comparison)
- RTSC.md §9.14 — H₃X group 14-17 parallel fanout (h3br 진행 행)
- RTSC.log.md §9.15 — Bayesian update SSOT (h3br PENDING)
