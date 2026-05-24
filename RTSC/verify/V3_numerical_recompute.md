# RTSC V3 — 🟢 SUPPORTED-NUMERICAL recompute ledger

> V1(claim inventory) · V2(🔵 formal identity) 다음 단계. §9 5-gate sim stack 이 뱉은 **DFT-derived Tc** 값을 `hexa verify` 로 한 줄씩 재계산·대조해 🟢 도장을 찍는 numerical ledger.
>
> **검증 대상 = 산술(Allen-Dynes 공식)이 (λ, ω_log) 로부터 그 Tc 를 정말 내놓는가** — DFT 입력값 자체나 동역학적 안정성은 별개 축(아래 caveat). g5: verdict verbatim.

## method

- fn: `allen_dynes_tc(λ, ω_log, μ*)` = `(ω_log/1.2)·exp(-1.04(1+λ) / (λ - μ*(1+0.62λ)))` (V2 closed-form, 3-arg)
- recompute: `hexa verify --expr allen_dynes_tc <λ> <ω_log> <μ*> <expected_Tc>` · μ*=0.10 · ε=1e-9 (libm-class, TECS-L Tier 2)
- expected_Tc: 각 후보 `results_by_broadening` 의 broad=0.015 Ry headline 행 (exact 값은 동일 공식으로 재산출, JSON 반올림값과 일치 확인)
- host: mini (macOS) · `POOL_DISABLE=1` 로 로컬 강제 (per [[reference_hexa_verify_host_mini]] — ubu-2 segfault 회피)
- source: `exports/material_discovery/rtsc_*_dft_*q_*.json` (6³q, CaH₆ 4³q) · h3cl-8q 는 ubu-1 8³q converged

## ledger (10/10 🟢)

| # | 후보 | λ_BZ | ω_log (K) | Tc(μ0.10) exact | JSON | grid | 안정성 | §9.15 |
|---|---|---|---|---|---|---|---|---|
| 1 | **h3cl** (conv) | 1.368 | 1349.8 | **140.3242271664** | 140.3 | 8³q ✅ | **stable #1** | FAIL(above) |
| 2 | h3cl | 1.135 | 1254.2 | 104.5971639064 | 104.6 | 6³q | stable #1 | FAIL(above) |
| 3 | h3o | 2.729 | 1110.8 | 191.3108315324 | 191.3 | 6³q | ⚠ UNSTABLE (imag mode) — upper-bound | — |
| 4 | h3f | 0.816 | 652.4 | 31.8175354853 | 31.8 | 6³q | ⚠ UNSTABLE (imag mode) | FAIL(below) |
| 5 | h3si | 1.724 | 623.6 | 80.3064679971 | 80.3 | 6³q | ⚠ UNSTABLE (imag mode) | PASS |
| 6 | h3se | 1.258 | 1356.7 | 128.5254173958 | 128.5 | 6³q | TBD | — |
| 7 | h3te | 2.350 | 468.3 | 74.5246613996 | 74.5 | 6³q | TBD | — |
| 8 | h3po | 3.313 | 258.2 | 48.4249324343 | 48.4 | 6³q | TBD | — |
| 9 | **H₃S** (anchor) | 2.619 | 1154.3 | 194.7717274829 | 194.8 | 6³q | stable (textbook) | meas 203K |
| 10 | **CaH₆** (anchor) | 4.376 | 1236.4 | 255.0638511525 | 255.1 | 4³q | stable (textbook) | meas 215K |

전 10건 `tier = 🟢 SUPPORTED-NUMERICAL` · `|Δ| ≤ ε=1e-9`. exact 값이 JSON 반올림값과 모두 일치 → DFT 산출 Tc 의 산술 정합 확정.

### verbatim verdict (대표 #1 · 나머지 9건 동일 tier)

```
verify --expr allen_dynes_tc(1.368,1349.8,0.1)=140.324
  calc   = 140.324  ≈ expected 140.324  (|Δ|=2.7967e-11 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

## caveat (검증 범위 명시)

1. **이건 산술 검증이다** — `hexa verify` 가 확인한 것은 "(λ, ω_log, μ*) → Tc" 가 Allen-Dynes 공식대로 나오는가 (V2 closed-form 의 numerical instance). DFT 가 뽑은 λ/ω_log 자체의 정확도, k/q-grid 수렴, 동역학적 안정성은 **이 ledger 의 범위가 아니다**.
2. **안정성 ≠ Tc** — h3o(191K)·h3f·h3si 는 imaginary phonon mode 보유 = 동역학적 불안정. 표의 Tc 는 unstable-mode-drop **upper-bound** 라 구조 신뢰 낮음 (§9.x · ph.out raw mode 파싱). 안정 후보는 **h3cl** (stable #1). h3se/h3te/h3po 안정성은 TBD (raw phonon 재확인 필요).
3. **grid** — h3cl headline 은 ubu-1 8³q converged (λ=1.21–1.37 broadening plateau · ω_log~1350K). 6³q(#2)는 superseded. 타 후보는 6³q(CaH₆ 4³q) — 8³q 재실행 시 ~5–10% 상향 가능 (h3cl 6q→8q 가 Tc 105→123–140 상향 전례).
4. **anchor 정합** — H₃S 194.8K (meas 203K, broad=0.015; broadening 수렴 시 ~175–195K) · CaH₆ 255K (meas 215K, broad=0.015 과대; 수렴 ~213–223K) — anchor 는 측정값과 같은 자릿수 (V1 anchor 재현과 일관).

## 산출 위치

- 다음: V4 tier ledger (V1🔵 + V2🔵 + 본 V3🟢 + 🟠 wet-lab deferred 통합) → `RTSC/verify/V4_tier_ledger.md`
- 재현: `cd ~/core/demiurge && export POOL_DISABLE=1 && hexa verify --expr allen_dynes_tc <λ> <ω_log> 0.10 <Tc>`
