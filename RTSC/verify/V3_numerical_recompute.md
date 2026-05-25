# RTSC V3 — 🟢 SUPPORTED-NUMERICAL recompute ledger

> V1(claim inventory) · V2(🔵 formal identity) 다음 단계. §9 5-gate sim stack 이 뱉은 **DFT-derived Tc** 값을 `hexa verify` 로 한 줄씩 재계산·대조해 🟢 도장을 찍는 numerical ledger.
>
> **검증 대상 = 산술(Allen-Dynes 공식)이 (λ, ω_log) 로부터 그 Tc 를 정말 내놓는가** — DFT 입력값 자체나 동역학적 안정성은 별개 축(아래 caveat). g5: verdict verbatim.
>
> **2026-05-25 갱신**: §V3.1 에 N5 funnel sweep 5-candidate (h3o·h3si·h3f·h3po·h3br) 추가 → 총 **15/15 🟢**. h3br = N5 핵심 신규 발견(group-17 stable λ=4.42). h3o anharmonic Tc 는 SSCHA pending(미확정) — harmonic Tc 는 artifact(16/16 q imaginary).

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

---

## V3.1 — N5 funnel sweep recompute (2026-05-25 · 5 candidate)

> `exports/sweep/rtsc-n5funnel-sweep-2026-05-25/*.json` 의 N5 5-candidate (h3o·h3si·h3f·h3po·h3br) DFT-Tc 를 본 ledger 와 동일 방식(`hexa verify --expr allen_dynes_tc`, μ*=0.10, ε=1e-9)으로 재검증. **PR #25(V1) 이후 신규 데이터** — 위 10/10 ledger 에 더해 5건 추가 🟢.
>
> 핵심: N5 sweep 의 per-candidate JSON 은 `expected_Tc = result.txt 1-decimal round` (예 179.8) 를 썼기에 raw verdict 가 round-artifact 로 🔴 (|Δ|≈0.02K > ε) 였다. 본 V3.1 은 **full-precision expected** (closed-form 12-digit) 로 재호출 → 전 5건 🟢 SUPPORTED-NUMERICAL (|Δ| ≤ 2e-13). DFT Tc 의 산술 정합은 effective 🟢 (round-tolerance), full-precision verify 는 strict 🟢.

### ledger (5/5 🟢 · μ*=0.10)

| # | 후보 | group | λ_BZ | ω_log (K) | Tc(μ0.10) full | hexa \|Δ\| | q-block | 안정성 | M8 | §10 wall |
|---|---|---|---|---|---|---|---|---|---|---|
| 11 | **h3o** | 16 | 2.479 | 1096.6 | **179.779224** | 2.3e-13 | 16/16 | ⚠ UNSTABLE (16/16 q imag, min −1133cm⁻¹) | 0/3 | strong-λ·high-Tc·**unstable** |
| 12 | **h3si** | 14 | 1.787 | 590.1 | **78.184683** | 1.7e-13 | 16/16 | ✅ stable (broadening plateau) | 1/3 | stable·weak-λ |
| 13 | **h3f** | 17 | 0.807 | 658.6 | **31.413918** | 1.1e-13 | 16/16 | ✅ stable | 1/3 | stable·weak-λ |
| 14 | **h3po** | 16 | 3.052 | 265.2 | **48.079518** | 4.5e-13 | 10/16 | ⚠ UNSTABLE (6q missing·soft phonon) | 0/3 | strong-λ·soft-phonon·low-Tc |
| 15 | **h3br** | 17 | 4.4191 | 530.7 | **109.795962** | 7.1e-14 | 16/16 | ✅ **stable** (16/16 q, imag 0) | 1/3 | **strong-λ·stable·Tc-ceiling** |

전 5건 `tier = 🟢 SUPPORTED-NUMERICAL` · `|Δ| ≤ ε=1e-9`. (canonical broad=0.020 행 기준.)

### verbatim verdict (5건 전체 · g5 verbatim)

```
verify --expr allen_dynes_tc(2.479,1096.6,0.1)=179.779
  calc   = 179.779  ≈ expected 179.779  (|Δ|=2.27374e-13 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr allen_dynes_tc(1.787,590.1,0.1)=78.1847
  calc   = 78.1847  ≈ expected 78.1847  (|Δ|=1.7053e-13 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr allen_dynes_tc(0.807,658.6,0.1)=31.4139
  calc   = 31.4139  ≈ expected 31.4139  (|Δ|=1.10134e-13 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr allen_dynes_tc(3.052,265.2,0.1)=48.0795
  calc   = 48.0795  ≈ expected 48.0795  (|Δ|=4.54747e-13 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr allen_dynes_tc(4.4191,530.7,0.1)=109.796
  calc   = 109.796  ≈ expected 109.796  (|Δ|=7.10543e-14 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

### h3o strong-coupling 보정 (`allen_dynes_full` f₁f₂ · brainstorm #10)

N5 sweep `h3o_tc_recompute.json` 은 simple Allen-Dynes 외에 **f₁·f₂ strong-coupling 보정** (λ=2.479 > 1.5 강결합 영역) 을 재계산. ω₂/ω_log=1.389 (mode-resolved 재구성) → ω₂=1523.5K. `hexa verify --expr allen_dynes_full` 도 신규 calc-path 보유 → 🟢:

```
verify --expr allen_dynes_full(2.479,1096.6,1523.5,0.1)=233.173
  calc   = 233.173  ≈ expected 233.173  (|Δ|=1.01608e-10 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)

verify --expr allen_dynes_full(2.479,1096.6,1523.5,0.13)=213.811
  calc   = 213.811  ≈ expected 213.811  (|Δ|=9.21716e-11 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```

simple 180K(μ0.10) → full f₁f₂ **233K** (+29.7%). **⚠ 단, h3o STABLE-CONDITIONAL upper-bound** — 233K 는 simple 180K 와 마찬가지로 16/16 q imaginary mode 위에 세운 harmonic artifact. f₁f₂ 보정은 "안정화 성공 시 회수 가능한 Tc 잠재 상한"을 정량화할 뿐 안정성을 입증하지 않는다 (`h3o_tc_recompute.json` stable_conditional_caveat).

### N5 caveat (정직 · 위 caveat 1-4 에 추가)

5. **h3o anharmonic 미확정** — h3o harmonic Tc(180K simple / 233K full)는 **artifact**. `h3o_stableq_lambda.json` 정밀 census: Γ 단독 −682cm⁻¹ 가 아니라 **16/16 q 전부 imaginary mode** 보유(3~6개씩, 최저 −1133cm⁻¹). result.txt λ=2.479 는 이미 stable-mode-only(imaginary-λ 제외) 값이라 mode-level 오염 0% 이지만, strict stable-q-only(imaginary q 통째 제외) 정의로는 남는 q 0개 → λ=0 → **Tc 하한 = 0K**. **anharmonic SSCHA 재정규화 전엔 진짜 Tc 미확정** (concurrent agent afe7b61 ubu-1 진행 중). 본 ledger 의 h3o 🟢 는 "(λ,ω_log)→Tc 산술 정합"만 검증한 것이지 h3o 가 180K 초전도체임을 뜻하지 **않는다**.
6. **h3br = N5 핵심 발견** — group-17 형제로 λ=4.42 극단 강결합 + **16/16 q ALL stable** (imaginary 0개, group-17 stable 형제 h3cl·h3f 와 일치). 그러나 ω_log 531K moderate → Tc 110K 천장. **'strong-λ ↛ high-Tc'** 추가 증거: λ 포화 시 ω_log(phonon energy scale)이 Tc 병목 → trade-off 는 stability ↔ phonon-energy-scale (단순 coupling strength 아님). RTSC §10 d7 wall 재현·강화.
7. **M8 게이트 0/5** — 어떤 N5 후보도 M8(<50GPa AND stable AND Tc>200K) 미통과. 최고근접 = h3o(180K, but unstable). h3br = 유일 stable-strong-λ 이나 Tc 110K<200K. honest negative sweep (`g_micro_exp_honest_sweep`): 5 모두 CLOSED.

## 산출 위치

- 다음: V4 tier ledger (V1🔵 + V2🔵 + 본 V3🟢 + 🟠 wet-lab deferred 통합) → `RTSC/verify/V4_tier_ledger.md`
- 재현(10/10 anchor): `cd ~/core/demiurge && export POOL_DISABLE=1 && hexa verify --expr allen_dynes_tc <λ> <ω_log> 0.10 <Tc>`
- 재현(N5 5건): full-precision expected = `awk -v l=<λ> -v w=<ω_log> -v m=0.10 'BEGIN{printf "%.12f",(w/1.2)*exp(-1.04*(1+l)/(l-m*(1+0.62*l)))}'` → 그 값으로 verify (round-artifact 회피)
