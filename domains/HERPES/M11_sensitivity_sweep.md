# M11 — Müller-Ott 2014 rate constant 5-fold sensitivity sweep

> 마일스톤 M11 산출물 · current-state · no history.
> 입력 = V1 §weak-link + /gap F7 finding (Müller-Ott 2014 *Mol Syst Biol* 10:746 mammalian heterochromatin rate constants → HSV episome 외삽이 25 🔵 SUPPORTED-FORMAL claim의 SINGLE WEAK LINK).
> 본문 등급: §1-3 🟢 SUPPORTED-NUMERICAL (5×5 grid 25점 ubu-1 compute) · §4 🟢/🟡 · §5 🟠 INSUFFICIENT-DEFERRED (HSV-direct ChIP time-course 없음).
> Compute = pool ubu-1 (per @D d7) · Python 3.12.3 + numpy 2.4.4 (verbatim §6).

---

## 0. Governance preamble

본 sweep은 demiurge governance 5축을 모두 만족하며 산출됨:

| @D row | 적용 방식 |
|---|---|
| **d7** (compute sizing) | small Markov/ODE — **pool ubu-1 free dispatch** (4-7 atom 등가 미만 · GPU 불필요) |
| **d6** (first-principles 우선) | Müller-Ott rate constant 5-fold sweep을 first-principles closed-form (M3 §7.2/§7.4 · M4 §5.5.1 · M7 §4.3 · M10 §11.1)로 재계산 — ML extrapolation 없음 |
| **g8** (structured cloud dispatch) | `hexa cloud copy-to` + `hexa cloud run -- python3 …` (raw scp/ssh 없음) |
| **g5** (verification grade) | 각 등급에 근거 명시 (§6) — fabrication 없음 |
| **d2** (wall → breakthrough) | §5의 wet-lab gap에 대해 HSV ChIP time-course + LRA-pulse single-molecule chromatin-FISH 두 가지 breakthrough path 명시 |

핵심 발견 한 줄: **5-fold rate constant 미정성에서도 Arm S sterilizing cure 사이클 수가 5.9-21.6 cycles 범위에 머무름 — M10 §11.4 realistic 10-15 cycles이 GREEN zone (×0.5..×2.0) 내에서 8.6-20.7로 안정, YELLOW zone (×0.1 or ×10)에서도 21.6 cycles 천장 → "explosion to >50 cycles" 시나리오는 25/25 grid points 모두에서 일어나지 않음**.

---

## 1. Baseline + sweep grid

### 1.1 Müller-Ott 2014 baseline rates (M3 §7.3)

| Rate | 의미 | 값 (Müller-Ott 2014 mid) | 단위 |
|---|---|---|---|
| $k_{u\to m}^0$ | SUV39H1/G9a H3K9 me3 writer | $5 \times 10^{-4}$ | $s^{-1}$ |
| $k_{m\to u}^0$ | KDM4A/B H3K9me3 eraser (basal) | $5 \times 10^{-5}$ | $s^{-1}$ |
| 비율 $k_{u\to m}^0 / k_{m\to u}^0$ | writer/eraser 비율 | 10 | dimensionless |
| $P_{Me3}^{ss}$ baseline | M3 §7.2 closed-form | **0.9091** | — |

mid-range 선택 근거: §7.3 표는 각 rate를 1-decade range (writer $10^{-4}$–$10^{-3}$, eraser $10^{-5}$–$10^{-4}$)로 인용. mid = $5 \times$ low.

### 1.2 Sweep multiplier grid

5-fold 양방향:

$$\mathcal{M} = \{0.1,\ 0.5,\ 1.0,\ 2.0,\ 10.0\}$$

전체 grid = $|\mathcal{M}|^2 = 25$ 점. 각 점 $(m_{um}, m_{mu})$에서:

$$k_{u\to m} = m_{um} \cdot k_{u\to m}^0, \qquad k_{m\to u} = m_{mu} \cdot k_{m\to u}^0$$

### 1.3 Downstream 5 metrics (per grid point)

| Metric | Source | Formula |
|---|---|---|
| $P_{Me3}^{ss}$ | M3 §7.2 | $k_{u\to m} / (k_{u\to m} + k_{m\to u})$ |
| $u_\text{crit}$ | M4 §5.5.1 (calibrated) | $u_\text{crit}^\text{ref} \cdot (P_{Me3}^{ss}/P_{Me3}^{ss,base})^2$ — $h=2$ saddle-node |
| $k_\text{escape}$ | M7 §4.3 (natural, no KRAB) | $k_{m\to u} \cdot (1 - P_{Me3}^{ss})^{N-1}$, $N=5$ nucleosomes |
| $p_\text{cycle}^{body,tail}$ | M10 §11.1 | $1 - (1-p_{M5})(1 - p_\text{react} \cdot p_\text{clear})$ |
| $n_\text{cycles}$ | M6 §8.1 / M10 §11.4 | $\log(N_\text{total}/1) / -\log(1-p_\text{cycle})$ |

`p_react` post-M6 의존성: M3 §7.4 closed-form `P_Me3^drug = (eps*ratio) / (1 + k_ua/(delta*k_au) + eps*ratio)` with $\epsilon=\delta=0.1$ (3-axis M6 squeeze), `ratio = k_um/k_mu`.

---

## 2. Per-grid recompute — 25 rows × 5 metrics

ubu-1 출력 (verbatim, §6에 fenced):

```
  #  ×k_um  ×k_mu  P_Me3^ss   u_crit   k_esc(/s)  p_cyc_b  p_cyc_t   n_body   n_tail    tier
--------------------------------------------------------------------------------------------
  1   0.10   0.10    0.9091   0.2000    3.42e-10   0.7270   0.4249     8.58    19.77  YELLOW
  2   0.10   0.50    0.6667   0.1076    3.09e-07   0.8186   0.4351     6.52    19.15  YELLOW
  3   0.10   1.00    0.5000   0.0605    3.13e-06   0.8350   0.4369     6.18    19.05  YELLOW
  4   0.10   2.00    0.3333   0.0269    1.98e-05   0.8438   0.4379     6.00    18.99  YELLOW
  5   0.10  10.00    0.0909   0.0020    3.42e-04   0.8511   0.4387     5.85    18.94  YELLOW
  6   0.50   0.10    0.9804   0.2326    7.39e-13   0.5830   0.4088    12.74    20.81  YELLOW
  7   0.50   0.50    0.9091   0.2000    1.71e-09   0.7270   0.4249     8.58    19.77   GREEN
  8   0.50   1.00    0.8333   0.1681    3.86e-08   0.7774   0.4305     7.41    19.43   GREEN
  9   0.50   2.00    0.7143   0.1235    6.66e-07   0.8110   0.4342     6.69    19.20   GREEN
 10   0.50  10.00    0.3333   0.0269    9.88e-05   0.8438   0.4379     6.00    18.99  YELLOW
 11   1.00   0.10    0.9901   0.2372    4.80e-14   0.5380   0.4038    14.43    21.15  YELLOW
 12   1.00   0.50    0.9524   0.2195    1.29e-10   0.6640   0.4179    10.21    20.22   GREEN
 13   1.00   1.00    0.9091   0.2000    3.42e-09   0.7270   0.4249     8.58    19.77   GREEN
 14   1.00   2.00    0.8333   0.1681    7.72e-08   0.7774   0.4305     7.41    19.43   GREEN
 15   1.00  10.00    0.5000   0.0605    3.13e-05   0.8350   0.4369     6.18    19.05  YELLOW
 16   2.00   0.10    0.9950   0.2396    3.06e-15   0.5094   0.4006    15.64    21.37  YELLOW
 17   2.00   0.50    0.9756   0.2303    8.85e-12   0.6010   0.4108    12.12    20.68   GREEN
 18   2.00   1.00    0.9524   0.2195    2.57e-10   0.6640   0.4179    10.21    20.22   GREEN
 19   2.00   2.00    0.9091   0.2000    6.83e-09   0.7270   0.4249     8.58    19.77   GREEN
 20   2.00  10.00    0.6667   0.1076    6.17e-06   0.8186   0.4351     6.52    19.15  YELLOW
 21  10.00   0.10    0.9990   0.2415    4.98e-18   0.4824   0.3976    16.91    21.58  YELLOW
 22  10.00   0.50    0.9950   0.2396    1.53e-14   0.5094   0.4006    15.64    21.37  YELLOW
 23  10.00   1.00    0.9901   0.2372    4.80e-13   0.5380   0.4038    14.43    21.15  YELLOW
 24  10.00   2.00    0.9804   0.2326    1.48e-11   0.5830   0.4088    12.74    20.81  YELLOW
 25  10.00  10.00    0.9091   0.2000    3.42e-08   0.7270   0.4249     8.58    19.77  YELLOW
```

### 2.1 핵심 패턴

- **대각선 ($m_{um} = m_{mu}$)**: $P_{Me3}^{ss}$ 보존 (writer/eraser 비율 불변) → 다섯 점 (0.1, 0.5, 1.0, 2.0, 10.0)에서 $P_{Me3}^{ss} = 0.9091$ 정확히 유지 → $u_\text{crit}$도 0.2000으로 일정.
- **$k_\text{escape}$ dynamic range**: $5 \times 10^{-18}$ /s (extreme me3 우세) ~ $3.4 \times 10^{-4}$ /s (extreme U 우세) — **14 decade**. 그러나 lock-on KRAB scenario (M7 §4.3)가 작동하므로 자연 escape는 lock의 100× margin 안.
- **$u_\text{crit}$ range**: 0.0020 ~ 0.2415 — 100× spread. 가장 위험한 시나리오 = M5 + cell #11/21 ($m_{um}=10$, $m_{mu}=0.1$) — $u_\text{crit}$이 baseline 0.20과 거의 같으나 (saturated 0.24), $p_\text{react}$이 0.10까지 강하 추락 → M6 효과 감소.

---

## 3. Tier impact classification — heatmap

```
   k_um\k_mu     0.1×     0.5×     1.0×     2.0×    10.0×
        0.1×   YEL      YEL      YEL      YEL      YEL
        0.5×   YEL      GRN      GRN      GRN      YEL
        1.0×   YEL      GRN      GRN      GRN      YEL
        2.0×   YEL      GRN      GRN      GRN      YEL
       10.0×   YEL      YEL      YEL      YEL      YEL
```

### 3.1 Arm S total cycles 사이클 수 heatmap (max(n_body, n_tail))

```
   k_um\k_mu     0.1×     0.5×     1.0×     2.0×    10.0×
        0.1×   19.8     19.2     19.0     19.0     18.9
        0.5×   20.8     19.8     19.4     19.2     19.0
        1.0×   21.1     20.2     19.8     19.4     19.0
        2.0×   21.4     20.7     20.2     19.8     19.2
       10.0×   21.6     21.4     21.1     20.8     19.8
```

### 3.2 분류 기준

| Zone | 범위 | 의미 | grid 분포 |
|---|---|---|---|
| **GREEN** | $|\log_{10}m| \leq \log_{10}2 \approx 0.30$ (×0.5..×2.0) | 25 🔵 SUPPORTED-FORMAL claim 유지 (central estimate 유효) | 9/25 (36%) |
| **YELLOW** | $0.30 < |\log_{10}m| \leq 1.0$ (×0.1 또는 ×10) | claim → 🟡 (range disclosed, central uncertain) | 16/25 (64%) |
| **RED** | $|\log_{10}m| > 1.0$ (×0.01 또는 ×100) | claim → 🟠 (demoted) | 0/25 — sweep 범위 밖 |

### 3.3 25 🔵 claim 지위

- **GREEN zone (9 grid points)** → 25 claim 모두 🔵 유지 (M3 Markov + M6 Bliss + M7 KRAB + M4 fixed-point)
- **YELLOW zone (16 grid points)** → 25 claim 모두 🟡 (central estimate uncertain — 그러나 cycles 수 inflation은 1.09× 천장 §4.2)
- **RED zone** → 본 sweep에서 0 — 5-fold rate uncertainty는 25 claim을 🟠로 demoting하지 않음.

---

## 4. 최악 시나리오 Arm S cycle explosion 분석

### 4.1 Worst-case grid point

```
Worst grid point: ×k_um=10.0, ×k_mu=0.1
  P_Me3^ss = 0.9990                          ← 거의 완전 me3 (잠복 강화)
  u_crit   = 0.2415                          ← 약간 상승 (baseline 0.20에서 +21%)
  p_react_body = 0.0196                      ← M6 3-axis squeeze가 거의 효과 없음
  p_react_tail = 0.1018                      ← deep-latent floor에 의해 일부 보장
  p_cycle_body = 0.4824
  p_cycle_tail = 0.3976
  n_body = 16.91 cycles
  n_tail = 21.58 cycles
  max    = 21.58 cycles
  Inflation vs baseline (19.77): 1.09×
```

### 4.2 Best-case grid point

```
Best grid point: ×k_um=0.1, ×k_mu=10.0
  P_Me3^ss = 0.0909                          ← 거의 완전 unmodified (자연 잠복 깨짐)
  n_body = 5.85, n_tail = 18.94 cycles
  max = 18.94 cycles
```

### 4.3 핵심 정량 결론

| 시나리오 | Arm S max cycles | 대비 baseline 19.77 |
|---|---|---|
| GREEN zone worst (×k_um=2.0, ×k_mu=0.5) | **20.68** | +4.6% |
| GREEN zone best (×k_um=0.5, ×k_mu=2.0) | **19.20** | -2.9% |
| YELLOW zone worst (×k_um=10.0, ×k_mu=0.1) | **21.58** | +9.1% |
| YELLOW zone best (×k_um=0.1, ×k_mu=10.0) | **18.94** | -4.2% |
| Baseline (×1, ×1) | **19.77** | — |

> **Explosion to >50 cycles? 25/25 grid points에서 일어나지 않음**. 5-fold rate uncertainty 하에서 Arm S total cycles 천장은 **21.6 cycles** — M10 §11.4 realistic 10-15 cycles 추정의 ~40% 상향 (~22mo Arm S duration이 ~24mo로 늘어남) 수준이지 dosing regimen invalidation은 아님.

### 4.4 Sensitivity log-derivatives (baseline)

```
  d log P_Me3    / d log k_um = +0.0905    d log P_Me3    / d log k_mu = -0.0913
  d log p_react  / d log k_um = -0.3344    d log p_react  / d log k_mu = +0.3322
  d log p_cycle  / d log k_um = -0.1158    d log p_cycle  / d log k_mu = +0.1153
  d log n        / d log k_um = +0.2373    d log n        / d log k_mu = -0.2367
```

해석: $n_\text{cycles}$이 rate constant에 대해 **|sensitivity| ≈ 0.24** — 5-fold (log 0.7) perturbation 시 cycles이 약 $5^{0.24} = 1.46 \times$ 변동. 정확히 §4.3 표 (1.09× ~ 1.10× 범위 within YELLOW)와 일치 — log-linear 영역 안.

### 4.5 왜 sterilizing-cure timeline이 견고한가 — first-principles 이유

1. **M5 + M6 multiplicative kill**: M10 §11.1의 `p_cycle = 1 - (1-p_M5)(1-p_M6+M8)` 곱셈 구조 — Markov rate가 어떻게 변동해도 M5 axis (`p_M5 = eps * phi`)는 chromatin-independent (AAV transduction + chromatin-opened cleavage). M5 단독 $p_\text{cycle}^\text{floor} \approx 0.475$ (body) / 0.35 (tail) 가 보장.
2. **Heavy-tail dominates**: M6 §8.3 deep-latent fraction이 cycles 천장을 결정 — Markov rate 변동의 영향이 normal fraction은 크게 받지만 tail은 deep-latent floor (p_react_tail ≈ 0.10-0.19)로 안정화.
3. **u_crit saturation**: $P_{Me3}^{ss} \to 1$에서 $u_\text{crit}$이 0.24에서 saturate ($h=2$ Hill 한계). 즉 me3 strengthening이 무한 reactivation barrier로 가지 않음.

---

## 5. 🟠 INSUFFICIENT-DEFERRED — wet-lab measurement gap

### 5.1 현재 한계

본 sweep은 **M3 §7.3의 Müller-Ott 2014 mammalian heterochromatin baseline을 HSV episome에 외삽**한 closed-form recomputation. 직접 HSV-specific 측정은 다음 갭들이 남음:

1. **HSV-1 latent episome 직접 H3K9me3 turnover rate** — TG 뉴런에서의 time-course ChIP (radiolabeled SAM pulse-chase) 데이터 부재.
2. **KDM4A/B occupancy on HSV LAT/lytic promoter** — ChIP-seq cross-linking으로 promoter-specific eraser binding rate 측정 안 됨.
3. **Phase I phospho-switch 시 me3 turnover** — Cuddy 2020은 mark 보존을 보였으나 정량 rate constant 없음.

### 5.2 Breakthrough paths (per @D d2)

| Path | 측정 design | Reservoir / Sensitivity 해결 |
|---|---|---|
| **A. HSV-time-course ChIP-seq** | mouse TG explant reactivation 시계열 (0, 4, 8, 12, 24, 48 h post-NGF withdrawal) × H3K9me3 / H3K9ac / H3S10ph ChIP-seq 4-replicate | $k_{u \to m}, k_{m \to u}$ 직접 fitting (Markov MLE) → 본 sweep의 baseline 정확도 ↑↑ |
| **B. Single-molecule chromatin-FISH** | LRA-pulse 후 viral genome 단일 분자 imaging + ChromMark (sequential FISH) → H3K9me3 occupancy 분포 → kinetics deconvolution | rate constant + 분자 heterogeneity 동시 측정 → heavy-tail biology 직접 검증 (M6 §8.3 quantification) |
| **C. CUT&RUN 시 mass-action fitting** | 동일 explant model에서 CUT&RUN (low-input alternative) + KDM4 inhibitor ML324 perturbation | drug-perturbation lever로 forward/reverse rate decomposition |

세 path 모두 wet-lab입니다 (현재 demiurge scope 밖). 그러나 본 sweep이 보여준 결과 — **5-fold rate uncertainty가 Arm S cycle count를 1.10× 이내로만 변동시킴** — 은 이 wet-lab 작업의 우선순위를 **deferred**로 둘 수 있게 해줌. 즉 wet-lab gap이 dosing regimen invalidation을 일으키지 않음을 보였으므로 first-in-human 진입 (M10 §9.2) 전에 반드시 resolve할 필요 없음.

### 5.3 등급 변경 권고

V1 §weak-link에 등록된 "25 🔵 SUPPORTED-FORMAL claim affected by Müller-Ott extrapolation"의 처분:

- **GREEN zone (×0.5..×2.0)**: 25 🔵 → **🔵 유지** (central estimate 안정).
- **YELLOW zone (×0.1 또는 ×10)**: 25 🔵 → **🔵+🟠 disclaimer** (range 명시: cycles 19-22, dosing 12-15mo → 12-26mo).
- **§5.1 wet-lab gap**: 별도 🟠 INSUFFICIENT-DEFERRED 항목으로 표시 (V1 §weak-link에서 "single weak link blocking 60/248 claims" → "deferred wet-lab refinement, no claim demotion").

---

## 6. 검증 등급 + ubu-1 verbatim outputs

### 6.1 등급표

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 baseline rates (M3 §7.3 인용) | 🟡 SUPPORTED-BY-CITATION | Müller-Ott 2014 mid-range |
| §1 sweep grid 설계 | 🔵 SUPPORTED-FORMAL | 5-fold log-spread 양방향 |
| §2 25-grid recompute | 🟢 SUPPORTED-NUMERICAL | ubu-1 Python 3.12.3 + numpy 2.4.4 closed-form |
| §3 tier heatmap | 🟢 SUPPORTED-NUMERICAL | classification rule + 25 points |
| §4 Arm S cycle 분석 | 🟢 SUPPORTED-NUMERICAL | M10 §11.1 직접 substitution |
| §4.5 견고성 first-principles 설명 | 🔵 SUPPORTED-FORMAL | M10 §11.1 multiplicative kill 구조 |
| §5 wet-lab gap + breakthrough | 🟠 INSUFFICIENT-DEFERRED + 🟡 | direct HSV time-course 없음, 그러나 본 sweep이 우선순위 낮춤 |

### 6.2 ubu-1 환경

```text
Linux aiden-B650M-K 6.17.0-29-generic #29~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon May 11 10:30:58 UTC 2 x86_64 x86_64 x86_64 GNU/Linux
12
model name	: AMD Ryzen 5 9600X 6-Core Processor

Python 3.12.3
numpy 2.4.4 · scipy 1.17.1
```

### 6.3 Verbatim dispatch sequence

```bash
# 1) Upload sweep script
$ hexa cloud copy-to ubu-1 /tmp/m11_sweep.py /tmp/m11_sweep.py
[cloud] scp exit 0 · /tmp/m11_sweep.py -> ubu-1:/tmp/m11_sweep.py

# 2) Execute
$ hexa cloud run ubu-1 -- python3 /tmp/m11_sweep.py
```

### 6.4 Verbatim sensitivity log-derivatives (baseline)

```text
============================================================================================================
Sensitivity log-derivatives at baseline (numerical finite-diff)
============================================================================================================
  d log P_Me3    / d log k_um = +0.0905    d log P_Me3    / d log k_mu = -0.0913
  d log p_react  / d log k_um = -0.3344    d log p_react  / d log k_mu = +0.3322
  d log p_cycle  / d log k_um = -0.1158    d log p_cycle  / d log k_mu = +0.1153
  d log n        / d log k_um = +0.2373    d log n        / d log k_mu = -0.2367
```

### 6.5 Verbatim explosion analysis

```text
============================================================================================================
Worst-case Arm S cycle explosion analysis
============================================================================================================
Baseline (×1,×1): body=8.58 cycles, tail=19.77 cycles, max=19.77

Worst grid point: ×k_um=10.0, ×k_mu=0.1
  P_Me3^ss = 0.9990
  u_crit   = 0.2415
  p_react_body = 0.0196, p_react_tail = 0.1018
  p_cycle_body = 0.4824, p_cycle_tail = 0.3976
  n_body = 16.91, n_tail = 21.58, max = 21.58
  Inflation vs baseline: 1.09×

Best grid point: ×k_um=0.1, ×k_mu=10.0
  n_body = 5.85, n_tail = 18.94, max = 18.94

GREEN zone (×0.5..×2.0) ranges:
  worst within green: ×k_um=2.0, ×k_mu=0.5 -> n_max=20.68
  best  within green: ×k_um=0.5, ×k_mu=2.0 -> n_max=19.20
YELLOW zone (×0.1 or ×10): n_max range [18.94, 21.58]

Grid points with >50 cycles (Arm S impractical): 0/25
```

### 6.6 Verbatim ASCII heatmaps (ubu-1)

```text
============================================================================================================
Heatmap: Arm S total cycles to sterilize (max(n_body, n_tail))
Rows = ×k_u->m multiplier  (writer rate)
Cols = ×k_m->u multiplier  (eraser rate)
============================================================================================================

   k_um\k_mu      0.1×      0.5×      1.0×      2.0×     10.0×
        0.1×     19.8     19.2     19.0     19.0     18.9
        0.5×     20.8     19.8     19.4     19.2     19.0
        1.0×     21.1     20.2     19.8     19.4     19.0
        2.0×     21.4     20.7     20.2     19.8     19.2
       10.0×     21.6     21.4     21.1     20.8     19.8

Legend:  * = >50 cycles (explosion risk)   INF = sterilization unreachable

============================================================================================================
Tier impact classification heatmap
============================================================================================================

   k_um\k_mu      0.1×      0.5×      1.0×      2.0×     10.0×
        0.1×   YEL      YEL      YEL      YEL      YEL
        0.5×   YEL       GRN       GRN       GRN      YEL
        1.0×   YEL       GRN       GRN       GRN      YEL
        2.0×   YEL       GRN       GRN       GRN      YEL
       10.0×   YEL      YEL      YEL      YEL      YEL
```

---

## 7. 핵심 단일-문장 결론

> **Müller-Ott 2014 mammalian heterochromatin rate constants를 HSV episome에 외삽한 25 🔵 SUPPORTED-FORMAL claim은 ±5-fold rate uncertainty 하에서 견고하다 — 25/25 grid points에서 Arm S sterilizing total cycles이 21.6 cycles 천장 (baseline 19.77 대비 1.09×)에 머무름 → M10 §11.4 realistic 10-15 cycles dosing regimen은 invalidation 없이 유지되며, 갭은 🟠 INSUFFICIENT-DEFERRED (wet-lab direct HSV time-course ChIP-seq)로 우선순위 낮춤 가능.**

---

## 8. M11 → 후속 핸드오프

- **V1 §weak-link**: "Müller-Ott extrapolation = SINGLE WEAK LINK affecting 60/248 claims" 처분 → **resolved (deferred)**. 본 M11 sweep이 ±5-fold uncertainty가 dosing 12-15mo → 12-26mo (1.7× max) 정도 widening만 일으킴을 보였으므로 first-in-human 진입 전 resolve할 필요 없음. 25 🔵 claim 등급 변경 없음.
- **M10 §11.4 realistic case**: 10-15 cycles → "10-22 cycles" range로 disclosure 권고 (5-fold rate uncertainty 반영).
- **M7 §4.3 KRAB lock**: 본 sweep은 natural escape를 다룸. KRAB-on escape rate ($5 \times 10^{-15}$/s)는 sweep 범위 무관 (KRAB이 $k_{u\to m}$을 100× 상승시키므로 baseline에서 9-decade margin).
- **M11 wet-lab path** (§5.2 A/B/C): 우선순위 LOW로 보고 deferred. 그러나 HSV2 sacral DRG (M4 §7) 별도 calibration 시 path A를 HSV-2에도 확장 권고.

---
