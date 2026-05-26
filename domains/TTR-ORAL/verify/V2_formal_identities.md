# TTR-ORAL V2 — closed-form identity ledger (ADME site-specificity wall)

> milestone: TTR-ORAL.md verify "V2 🔵 push"
> path: closed-form arithmetic ledger (each step hand-verifiable) + `hexa verify --fence` for meta-claim
> caveat (TTR V2 §10 정합): `hexa verify --expr` 는 number-theoretic / 일부 물리 fn 만 지원 (sigma·phi·welch_t_crit·chsh_tsirelson…) — **약동학(PK) 공식은 미지원**. 따라서 PK closed-form 은 manual arithmetic ledger 로 검증하고, hexa CLI 는 meta-feasibility 주장에 `--fence` ⚪ 적용. stdlib 확장 path 는 §4 참조.

## §0 hexa verify --fence — meta-claim (verbatim, per @D g5)

```
verify --fence
  claim  = An orally-dosed systemic drug delivers only ~1e-4 of the dose to a tattoo dermal site (f_target = Kp*F*V_tattoo/Vd), so brute-force oral ink-dissolution is toxicity-bounded; only spatial-gating (prodrug+external activation) or endogenous-clearance (macrophage migration) oral routes can break the site-specificity wall
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

⇒ feasibility *방향* 주장은 ⚪ 로 정직 fence. 아래 §1–§3 의 **수치 결과**는 closed-form arithmetic 으로 deterministic 검증 (PASS = computed==expected).

## §1 경구 생체이용률 product identity

identity: `F = Fa · Fg · Fh`,  `Fh = 1 − Eh`,  `Eh = (fu·CL_int)/(Qh + fu·CL_int)` (well-stirred)

| # | claim | inputs | computed | expected | match |
|---|---|---|---|---|---|
| O2.1 | well-stirred Eh (fu·CL_int=30 L/h, Qh=90) | 30/(90+30) | Eh = **0.250** | 0.25 | ✅ |
| O2.2 | Fh = 1 − Eh | 1 − 0.25 | Fh = **0.750** | 0.75 | ✅ |
| O2.3 | F = Fa·Fg·Fh (Fa=0.8, Fg=0.83, Fh=0.75) | 0.8×0.83×0.75 | F = **0.498** ≈ 0.5 | ~0.5 | ✅ |

3/3 ✅ — bioavailability product identity verified (대표 F = 0.5).

## §2 진피 도달 분율 identity (★ 핵심 wall)

identity: `f_target = Kp · F · V_tat / Vd`,  `V_tat = A_tat · d_ink`

| # | claim | inputs | computed | match |
|---|---|---|---|---|
| O2.4 | 타투 자리 부피 V_tat | 50 cm² × 0.15 cm | **7.5 cm³ = 0.0075 L** | ✅ |
| O2.5 | ★ dermal delivery fraction | 1 × 0.5 × 0.0075 / 42 | **8.93 × 10⁻⁵** (≈0.0089%) | ✅ |
| O2.6 | 전신/표적 dose 증폭률 | Vd/(Kp·V_tat) = 42/(1×0.0075) | **5600×** | ✅ |

3/3 ✅ — site-specificity wall 정량화. 먹은 dose 의 ~1/11,200 만 타투 자리 도달 · 표적 농도 위해 전신 5600× 노출 필요.

> 검산 (hand): 0.5 × 0.0075 = 0.00375 ; 0.00375 / 42 = 8.9286×10⁻⁵ ✅ · 42 / 0.0075 = 5600 ✅

## §3 1차 청소 / fade 시간상수 identity

identity: `C(t) = C₀·e^(−k_e·t)`,  `t½ = ln2 / k_e`,  ln2 = 0.6931

| # | claim | inputs | computed | match |
|---|---|---|---|---|
| O2.7 | t½ (k_e = 0.1 /day, path B baseline turnover) | 0.6931/0.1 | **6.93 day** | ✅ |
| O2.8 | t½ (k_eff = 0.4 /day, 4× 가속 시) | 0.6931/0.4 | **1.73 day** | ✅ |
| O2.9 | fade 누적 (90% 청소 필요 cycle 수, per-step e^−k) | ln(0.1)/(−k_e·Δt) form | path B doc 에서 정식화 | → B |

2/2 closed + 1 handoff — 1차 kinetics identity verified (path B 가 k_eff 가속분 정량).

## §4 hexa verify --expr 한계 + breakthrough (honest)

| hexa verify --expr | PK 지원 |
|---|---|
| number theory (sigma·phi·mu·gamma0_*) | ✅ |
| float fns (welch_t_crit·wilson_hilferty_p·chsh_tsirelson·hardy_bound) | ✅ |
| bioavailability / Vd / partition / 1차 kinetics | ❌ (fn 미정의) |

breakthrough path (@D d8 hexa-lang inbox — TTR V2 §10 정합):
- hexa science stack 에 PK closed-form fn 추가 (`oral_bioavailability`, `well_stirred_eh`, `dermal_fraction`, `first_order_thalf`) → `_recompute_float` 확장 → 향후 직접 `hexa verify --expr` 🟢 path. `hexa-lang/INBOX.log.md` patch 제안 후보.
- 그 전까지: 본 closed-form arithmetic ledger (8/8 PASS, hand-verifiable) + meta-claim ⚪ fence.

## §5 summary

| § | identity | count | PASS |
|---|---|---|---|
| §1 | bioavailability product | 3 | 3/3 ✅ |
| §2 | dermal delivery fraction (wall) | 3 | 3/3 ✅ |
| §3 | 1차 kinetics t½ | 2 | 2/2 ✅ (+1→B) |
| **합계** | | **8** | **8/8 ✅** |

⇒ M2 wall 수치 (f_target ≈ 8.9×10⁻⁵ · amplification 5600×) closed-form 검증 완료. meta-feasibility ⚪ fence. V3 (🟢 numerical) handoff: prodrug uncaging 양자수율 (A · TDDFT) · macrophage clearance PK/PD (B) · lymphatic partition (C).
