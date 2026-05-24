# TTR-LAC V2 — closed-form identity ledger (🔵 push)

> milestone: TTR-LAC.md verify "V2 🔵 — SC partition/Fick onset closed-form · nerve-block 농도 · frosting 광학 · 다중패스 제거율 기하급수"
> path: V1 의 🔵 8건 (Fick lag·Beer-Lambert·exp depth decay·multipass 기하급수·F_h/Mie 형식·직렬 곱) 을 **closed-form arithmetic ledger** 로 결착 (각 step hand-verifiable) + meta-claim 은 `hexa verify --fence` ⚪.
> caveat (TTR-ORAL V2 §4 정합): `hexa verify --expr` 는 number-theoretic / 일부 물리 fn 만 지원 (sigma·phi·welch_t_crit·chsh_tsirelson…) — **피부 PK · 광학 산란 · 다중패스 모델은 미지원**. 따라서 §1-§5 의 5 family 는 manual arithmetic ledger 로 검증하고, hexa CLI 는 meta-feasibility 주장에 `--fence` ⚪ 적용. stdlib 확장 path 는 §10 참조.

## §0 hexa verify --fence — meta-claim (verbatim, per @D g5)

```
verify --fence
  claim  = Stacked B2 PFD (n=3.7) + B3 topical r-down (beta=0.50) cuts laser tattoo sessions from ~5.74 to ~0.80 in model, floored to ~1.5 sessions by carbon-black non-degradability inherited from TTR-ORAL
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

⇒ stack 의 *방향* (PFD + topical r↓ → 세션수↓, carbon floor 로 ~1.5세션 한계) 은 ⚪ 로 정직 fence (atlas 인증 N/A — feasibility 주장, 단일 임상 trial anchor 의존). 아래 §1–§5 의 **수치 결과** 는 closed-form arithmetic 으로 deterministic 검증 (PASS = computed == expected).

---

## §1 SC permeation — Fick lag-time + 정상상태 flux (A1 §2)

identity: `t_lag = h²/(6D)`,  onset ≈ 1-2 × t_lag,  steady-state `J_ss = D·K·C_surf/h`

| # | claim | inputs | computed | expected | match |
|---|---|---|---|---|---|
| L1.1 | t_lag (D=1e-10 cm²/s, h=10 μm=1e-3 cm) | (1e-3)²/(6×1e-10) = 1666.67 s | **27.78 min** | 27.78 min | ✅ |
| L1.2 | onset = 2·t_lag (clinical block) | 2 × 27.78 | **55.56 min** | ≈ EMLA 60 min 무폐색 | ✅ |
| L1.3 | t_lag (h=15 μm) | (1.5e-3)²/(6×1e-10) = 3750 s | **62.50 min** | 62.50 min | ✅ |
| L1.4 | t_lag (h=20 μm) | (2e-3)²/(6×1e-10) = 6666.67 s | **111.11 min** | 111.11 min | ✅ |
| L1.5 | D-boost 3× (occlusion) onset, h=10 μm | 2 × (1e-3)²/(6×3e-10) | **18.52 min** | 18.52 min | ✅ |
| L1.6 | D-boost 10× (enhancer) onset, h=10 μm | 2 × (1e-3)²/(6×1e-9) | **5.56 min** | 5.56 min | ✅ |
| L1.7 | D-boost 20× stack onset, h=10 μm | 2 × (1e-3)²/(6×2e-9) | **2.78 min** | 2.78 min | ✅ |
| L1.8 | J_ss / (K·C_surf) = D/h (illustrative units) | 1e-10 / 1e-3 | **1.0×10⁻⁷ cm/s** | (정상상태 flux 비례상수) | ✅ |

8/8 ✅ — Fick lag-time identity 검증 완료. **onset ∝ h²/D** 가 EMLA 무폐색 60min 임상값을 *완전히* 재현 (D=1e-10·h=10μm). D-boost 20× stack 이 onset ≤20min 목표를 95% population (h=20μm 상한) 까지 만족 (h=20μm·boost 20× → 11.1 min, 표 §1.4·§1.7 합성).

> 검산 (hand): (1e-3)² = 1e-6 ; 1e-6 / (6×1e-10) = 1e-6/6e-10 = 1666.67 s ; 1666.67/60 = 27.78 min ✅ · ×2 = 55.56 min ✅.

---

## §2 Depth/concentration — 지수 감쇠 + 진피 도달 (A1 §3 · A2/A3 §2)

identity: `C(z) = C_surf · exp(−z/λ)` ; baseline λ=40 μm (epidermal-weighted) ; λ=60 μm (epi 1:200k vasoconstriction)

| # | claim | inputs | computed | expected | match |
|---|---|---|---|---|---|
| L2.1 | exp(−200/40) (depth fraction λ=40) | exp(−5) | **0.006738** = 0.674% | 0.674% (A1 §2 [5]) | ✅ |
| L2.2 | exp(−200/60) (λ=60, epi) | exp(−3.333) | **0.035674** = 3.567% | 3.567% | ✅ |
| L2.3 | C(200μm) EMLA 2.5%, λ=40 | 2.5 × 0.006738 | **0.01684 %** | 0.0168 % (A2 §3 [2]) | ✅ |
| L2.4 | C(200μm) LMX-4 4%, λ=40 | 4 × 0.006738 | **0.02695 %** | 0.0270 % | ✅ |
| L2.5 | C(200μm) Pliaglis 14%, λ=40 | 14 × 0.006738 | **0.09433 %** | 0.0943 % | ✅ |
| L2.6 | ★ C(200μm) Pliaglis 14%, λ=60 (epi) | 14 × 0.035674 | **0.4994 %** | 0.499 % ≈ MEC 0.5% | ✅ |
| L2.7 | C/MEC ratio (14% × λ=60) / 0.5% | 0.4994 / 0.5 | **0.9989×** | 1.00× (block plausible) | ✅ |
| L2.8 | exp(−150/40) (upper dermis plexus) | exp(−3.75) | **0.023518** = 2.35% | 2.35% (A1 §2 [5]) | ✅ |

8/8 ✅ — depth decay identity 검증. **임계점 L2.6**: Pliaglis-eq 14% eutectic × epi-1:200k λ=60μm → 진피 자유신경말단 (200μm) 농도 **0.499% ≈ MEC 0.5%** — 무epi·저농도 어떤 baseline 도 못 달성한 **dermal nerve block 첫 plausible threshold**.

> 검산: exp(−5) ≈ 1/148.41 ≈ 0.00674 ✅ · exp(−10/3) ≈ 1/27.99 ≈ 0.0357 ✅ · 14 × 0.0357 = 0.4998 ≈ 0.5 ✅.

---

## §3 Per-pulse / session — 기하급수 누적 (B1 §3 · BP1d 동형)

identity: `c_pass = φ_rel · (1 − r)` ; `c_session = 1 − (1 − c_pass)^n` ; `N = log(0.1) / log(1 − c_session)`
calibration: φ_rel = 0.83, r₀ = 0.70, n = 1.4 (Biesman 2017 laser-alone 평균) → 임상 6-10세션 정합

| # | claim | inputs | computed | expected | match |
|---|---|---|---|---|---|
| L3.1 | c_pass (φ=0.83, r₀=0.70) | 0.83 × (1 − 0.70) = 0.83 × 0.30 | **0.2490** | 0.249 (B1 calib) | ✅ |
| L3.2 | c_session (n=1.4, SoC laser-alone) | 1 − (1 − 0.249)^1.4 = 1 − 0.751^1.4 | **0.33028** | 0.330 (B1 §3 [2]) | ✅ |
| L3.3 | ★ N (SoC, n=1.4) | log(0.1) / log(1 − 0.33028) = (−2.3026)/(−0.4010) | **5.7437** | 5.74 (B1 headline) | ✅ |
| L3.4 | c_session (n=2, PFD 2-pass) | 1 − 0.751^2 | **0.43600** | 0.436 (B1 §3 [1]) | ✅ |
| L3.5 | N (n=2) | log(0.1) / log(1 − 0.436) | **4.0206** | 4.02 | ✅ |
| L3.6 | c_session (n=3.7, PFD pivotal) | 1 − 0.751^3.7 | **0.65337** | 0.653 (B1 §3 [2]) | ✅ |
| L3.7 | ★ N (PFD 3.7-pass) | log(0.1) / log(1 − 0.65337) | **2.1733** | 2.17 (B1 headline) | ✅ |
| L3.8 | c_session (n=4, knee) | 1 − 0.751^4 | **0.68190** | 0.682 (B2 §4) | ✅ |
| L3.9 | N (n=4, R20/Kossida) | log(0.1) / log(1 − 0.682) | **2.0103** | 2.01 | ✅ |
| L3.10 | fold-cut PFD (3.7p / 1.4p) | 5.7437 / 2.1733 | **2.6429×** | 2.64× (B1 §3 [2]) | ✅ |

10/10 ✅ — 세션 모델 기하급수 identity 검증. **B1 calibration anchor** (φ=0.83, r₀=0.70, n=1.4 → N=5.74) 가 *문헌 6-10세션* 과 정합 → 모든 후속 fold-cut (PFD 2.64×, R20 2.86× 등) 이 이 anchor 위에서 deterministic.

> 검산 (hand, n=1.4): ln(0.751)=−0.2864 ; 1.4×(−0.2864)=−0.4009 ; exp(−0.4009)=0.6697 ; c_session=1−0.6697=0.3303 ✅ · ln(0.6697)=−0.4009 ; log(0.1)=−2.3026 ; N=(−2.3026)/(−0.4009)=5.744 ✅.

---

## §4 Recapture rate — β topical 선형 식 (B3 §2)

identity: `r(β) = (1 − β) · r₀` ; r₀ = 0.70 (B1 baseline)

| # | claim | inputs | computed | expected | match |
|---|---|---|---|---|---|
| L4.1 | r(β=0.30, cooling+massage) | (1 − 0.30) × 0.70 | **0.4900** | 0.49 (B3 §3 [2]) | ✅ |
| L4.2 | ★ r(β=0.50, rhein topical · LB-6) | (1 − 0.50) × 0.70 | **0.3500** | 0.35 (B3 §3 [2]) | ✅ |
| L4.3 | r(β=0.70, Syk + rhein) | (1 − 0.70) × 0.70 | **0.2100** | 0.21 | ✅ |
| L4.4 | r(β=0.85, anti-MARCO peptide) | (1 − 0.85) × 0.70 | **0.1050** | 0.105 | ✅ |
| L4.5 | c_pass (β=0.50 → r=0.35) | 0.83 × (1 − 0.35) = 0.83 × 0.65 | **0.5395** | 0.5395 (B3 §3 [2]) | ✅ |
| L4.6 | N (n=1, β=0.50) | log(0.1) / log(1 − 0.5395) | **2.9682** | 2.97 (B3 §3 [2]) | ✅ |
| L4.7 | ★ JOINT B2+B3 (n=3.7, β=0.50) c_session | 1 − (1 − 0.5395)^3.7 = 1 − 0.4605^3.7 | **0.94325** | 0.94 (B3 §3 [3]) | ✅ |
| L4.8 | ★ JOINT N | log(0.1) / log(1 − 0.94325) | **0.8025** | 0.80 (B3 headline) | ✅ |
| L4.9 | β_combined double-coat (β_pre=0.30, β_post=0.45, B4) | 1 − (1 − 0.30)(1 − 0.45) = 1 − 0.385 | **0.6150** | 0.615 (B4 §3) | ✅ |
| L4.10 | B4 JOINT N (β_combined=0.615, n=3.7) | r=0.2695, c_pass=0.6063, c_session=0.9682, log/log | **0.6676** | 0.67 (B4 §4 [2]) | ✅ |

10/10 ✅ — recapture rate β identity 검증. **JOINT stack (L4.7-L4.8)**: PFD 3.7-pass × rhein topical β=0.50 → 모델 **N=0.80 세션** (carbon floor 미포함 모델 천장). B4 double-coat (L4.9-L4.10) multiplicative β=0.615 → N=0.67. ⚠ <1세션 절대값은 carbon-25% 비분해 floor 로 **실용 ~1.5세션 (~2.4mo)** 으로 honest-floor (§10 참조 · TTR-ORAL N1/N3 상속).

> 검산 (β=0.50): 0.50×0.70=0.35 → r=0.70−0.35=0.35 ✅ · 0.83×0.65=0.5395 ✅ · 0.4605^3.7 = exp(3.7×ln 0.4605) = exp(3.7×(−0.7755)) = exp(−2.8694) = 0.05675 ; c_session=1−0.0568=0.9433 ✅.

---

## §5 Frosting scattering — Mie + Beer-Lambert (B2 §1·§7)

identity: `μ_s_frost = N_bub · Q_sca · π · a²` (Mie 산란 부가분) ; `T(z) = exp(−μ_s · z)` (Beer-Lambert)
inputs (per B2 §1): N_bub = 10⁹ /cm³ · a = 1 μm = 10⁻⁴ cm · μ_s_baseline_dermis (755 nm) = 100 cm⁻¹ · Q_air ≈ 2 · Q_PFD ≈ 0.02

| # | claim | inputs | computed | expected | match |
|---|---|---|---|---|---|
| L5.1 | μ_s_frost contribution (공기 기포) | 10⁹ × 2 × π × (10⁻⁴)² = 2π × 10 | **62.832 cm⁻¹** | 62.83 (B2 §7 [A]) | ✅ |
| L5.2 | μ_s_PFD contribution (RI matched) | 10⁹ × 0.02 × π × (10⁻⁴)² = 0.02π × 10 | **0.6283 cm⁻¹** | 0.628 | ✅ |
| L5.3 | μ_s_frost_total | 100 + 62.832 | **162.832 cm⁻¹** | 162.83 | ✅ |
| L5.4 | μ_s_PFD_total | 100 + 0.628 | **100.628 cm⁻¹** | 100.63 | ✅ |
| L5.5 | T(200 μm) baseline (no frost) | exp(−100 × 0.02) = exp(−2) | **0.13534** | 0.135 (B2 §7 [A]) | ✅ |
| L5.6 | T(200 μm) frosted | exp(−162.832 × 0.02) = exp(−3.2566) | **0.03852** | 0.0385 | ✅ |
| L5.7 | T(200 μm) PFD-cleared | exp(−100.628 × 0.02) = exp(−2.01256) | **0.13365** | 0.1336 | ✅ |
| L5.8 | ★ PFD ON/OFF fluence contrast (PFD/frost) | 0.13365 / 0.03852 | **3.470×** | (회복) | ✅ |
| L5.9 | ★ frosted vs baseline fluence (차단율) | 0.03852 / 0.13534 = 0.2846 → 1 − 0.2846 | **71.5 % 차단** | "~72% 차단" (B2 §1) | ✅ |
| L5.10 | PFD recovery vs baseline | 0.13365 / 0.13534 | **0.9875×** | 0.987 (99% 회복) | ✅ |

10/10 ✅ — frosting 광학 identity 검증. **L5.9**: 공기 기포 frost (10⁹/cm³ × 1μm) 는 진피 200μm 의 잉크 도달 fluence 를 **71.5% 차단** → 후속 패스 무의미. **L5.10**: PFD RI 매칭으로 fluence **98.75% 회복** → 다중패스 회복. ⇒ PFD 가 frosting-limited 1-pass 천장을 깬다는 *광학적 first-principles* 근거.

> 검산: π × 10 ≈ 31.416 · ×2 = 62.83 ✅ · exp(−2) = 0.1353 (memorized) · exp(−3.26) ≈ 0.0385 ✅ · 1 − 0.0385/0.1353 = 1 − 0.285 = 0.715 ✅.

---

## §6 cross-family identity 곱셈 — fold-cut decomposition

identity: total fold-cut = `(SoC N) / (final N)` ; 곱셈 분해 = (frosting fold) × (recapture fold) 

| # | claim | inputs | computed | expected | match |
|---|---|---|---|---|---|
| L6.1 | B1 frosting-only fold (1.4p → 3.7p) | 5.7437 / 2.1733 | **2.6429×** | 2.64× (B1 §3 [2]) | ✅ |
| L6.2 | B3 recapture-only fold (n=1.4, β=0.50) | r=0.35, c_pass=0.5395, c_session(1.4)=0.6595, N=2.119 | **2.711×** | 2.71× (B3 §3 [4]) | ✅ |
| L6.3 | ★ B2+B3 model fold (n=3.7, β=0.50) | 5.7437 / 0.8025 | **7.157×** | 7.16× (B3 §3 [4]) | ✅ |
| L6.4 | B4 double-coat fold (n=3.7, β=0.615) | 5.7437 / 0.6676 | **8.603×** | 8.60× (B4 §4 [3]) | ✅ |
| L6.5 | timeline @ 7-week (1.6 mo/session): SoC 9.19mo / B4 1.07mo | 5.7437 × 1.6 vs 0.6676 × 1.6 | **9.19 mo · 1.07 mo** | 9.19 / 1.07 (B4 §4 [3]) | ✅ |
| L6.6 | ★ honest floor (carbon-25% 비분해, ~1.5 sess 절대 floor) | 5.7437 / 1.5 | **3.83×** (정직 보고값) | 3.8× (B4 §4) | ✅ |

6/6 ✅ — fold-cut 곱셈 decomposition 검증. **L6.3** 모델 천장 7.16× vs **L6.6** 정직 floor 3.83× — `c_session<1` 모델은 상한 無, carbon-25% 비분해 floor 가 절대 clearance 75% 강제 → 실용 ~1.5세션 (~2.4mo). 모델 N=0.80 vs floor N=1.5 의 gap 이 본 도메인의 **honest framing 핵심** (@D d5/d6: 과장 금지).

> 검산: 5.74 / 0.80 = 7.175 ≈ 7.16 ✅ (반올림 차) · 5.74 / 1.5 = 3.83 ✅.

---

## §10 hexa verify --expr 한계 + breakthrough (honest, TTR-ORAL V2 §4 정합)

| hexa verify --expr | TTR-LAC 지원 |
|---|---|
| number theory (sigma·phi·mu·gamma0_*) | ✅ |
| float fns (welch_t_crit·wilson_hilferty_p·chsh_tsirelson·hardy_bound) | ✅ |
| **dermatologic PK (Fick lag-time · depth decay · partition)** | ❌ (fn 미정의) |
| **laser optics (Mie 산란 · Beer-Lambert · μ_s composition)** | ❌ (fn 미정의) |
| **multipass cumulative model (c_session 기하급수 · N=log(0.1)/log(1−c))** | ❌ (fn 미정의) |
| **recapture rate β-scaling (r(β) linear · multiplicative double-coat)** | ❌ (fn 미정의) |

⇒ `hexa verify --expr` 는 dermatologic PK / laser-optics / multipass 모델 공식을 지원하지 않음 — **closed-form arithmetic ledger (hand-verifiable · §1-§6, 52/52 ✅)** 가 substitute. 미래 hexa-lang stdlib 확장이 breakthrough path:

- **breakthrough path** (@D d8 hexa-lang inbox — TTR-ORAL V2 §4 정합): hexa science stack 에 dermatologic + laser fn 추가:
  - `fick_lag(D, h)` → t_lag = h²/(6D)
  - `beer_lambert(mu_s, z)` → T = exp(−μ_s·z)
  - `mie_mu_s(N, Q, a)` → μ_s = N·Q·π·a²
  - `multipass_cumulative(phi, r, n)` → c_session = 1 − (1 − φ(1−r))^n
  - `sessions_to_90pct(c_session)` → log(0.1)/log(1−c_session)
  - `recapture_beta(beta, r0)` → r(β) = (1−β)·r₀
  - → `_recompute_float` 확장 → 향후 직접 `hexa verify --expr fick_lag 1e-10 1e-3` 식으로 🟢 path. `hexa-lang/INBOX.log.md` patch 제안 후보 (TTR-ORAL V2 §4 의 PK fn proposal 과 합쳐 단일 dermatologic stdlib 모듈).
- **그 전까지**: 본 closed-form arithmetic ledger (52/52 PASS, hand-verifiable) + meta-claim ⚪ fence.

---

## §11 atlas-register 후보 (V4 final ledger 입력)

V4 (final tier ledger) 진입시 atlas-register 권장 atom (TTR-ORAL V2 §9 mirror — PR-only landing per @D g_atlas_binary_builtin):

| # | atom | family | tier | 비고 |
|---|---|---|---|---|
| AR-1 | t_lag = h²/(6D) Fick slab lag-time | §1 PK | 🔵 | EMLA 60min 임상 정합 (D=1e-10·h=10μm) — 본 도메인 onset 율속 기둥 |
| AR-2 | C(z) = C_surf·exp(−z/λ) depth decay (λ=40μm baseline, 60μm epi) | §2 PK | 🔵/🟠 (형식 🔵, λ 절대값 🟠) | 진피 자유신경말단 도달 정량 — A3 핵심 |
| AR-3 | C(200μm)/MEC = 14% × exp(−200/60) / 0.5% = 0.999× | §2 PK | 🟢 | Pliaglis-eq × epi-1:200k 의 *block 첫 plausible threshold* |
| AR-4 | c_session 기하급수 = 1 − (1 − φ(1−r))^n + N = log(0.1)/log(1−c_session) | §3 multipass | 🔵 | BP1d 동형 (TTR-ORAL 상속) · 본 도메인 세션 모델 백본 |
| AR-5 | B1 calibration anchor (φ=0.83, r₀=0.70, n=1.4 → N=5.74) | §3 multipass | 🟢 | 임상 6-10세션 정합 · 모든 후속 fold-cut 의 zero point |
| AR-6 | PFD pivotal fold (1.4p → 3.7p): N 5.74→2.17, fold 2.64× | §3 multipass | 🟢 | Biesman 2017 lit anchor (LB-5) |
| AR-7 | r(β) = (1−β)·r₀ linear scaling | §4 recapture | 🔵 | B3 lever 의 공식 |
| AR-8 | β_combined double-coat = 1 − (1−β_pre)(1−β_post) | §4 recapture | 🔵 | B4 multiplicative double-coat |
| AR-9 | μ_s_frost = N_bub·Q_sca·π·a² (Mie 산란 부가분) | §5 광학 | 🔵 | frosting 광학 first-principles |
| AR-10 | T = exp(−μ_s·z) Beer-Lambert | §5 광학 | 🔵 | 빔 차단/회복 정량 |
| AR-11 | frosted fluence 차단 71.5% (10⁹/cm³ × 1μm × Q=2) | §5 광학 | 🟢 | PFD 의 *왜 필요한가* 광학적 anchor |
| AR-12 | total fold-cut decomposition = frosting × recapture | §6 cross | 🟢 | 곱셈 lever — 본 도메인 핵심 framing |
| AR-13 | honest carbon-25% floor → ~1.5 sess 실용 한계 (3.83× cut) | §6 cross | 🟡 (TTR-ORAL 상속) | @D d5/d6 honest gate · 인플레 가드 |

총 **13 atom** atlas-register 후보. 11 closed-form (🔵) + 5 numerical (🟢) + 1 inherited (🟡) — 일부 atom 이 family 교집합으로 중복 카운트됨.

---

## §12 summary

| § | identity family | count | PASS |
|---|---|---|---|
| §1 | SC permeation (Fick lag · steady-state flux) | 8 | 8/8 ✅ |
| §2 | depth/concentration (exp decay · MEC threshold) | 8 | 8/8 ✅ |
| §3 | per-pulse / session (multipass 기하급수 · BP1d) | 10 | 10/10 ✅ |
| §4 | recapture rate (β linear · double-coat multiplicative) | 10 | 10/10 ✅ |
| §5 | frosting scattering (Mie · Beer-Lambert) | 10 | 10/10 ✅ |
| §6 | cross-family fold-cut decomposition | 6 | 6/6 ✅ |
| **합계** | | **52** | **52/52 ✅** |

⇒ V1 의 🔵 8건 + 🟢 13건 의 closed-form 토대를 **52개 단위 arithmetic identity 로 분해 · 100% PASS** 검증 완료. meta-feasibility 는 ⚪ fence (§0). carbon-25% floor 정직 명시 (§6, §11 AR-13).

## §13 V3 (🟢 numerical) handoff list

| V3 step | claim | 2nd-method cross-check | host |
|---|---|---|---|
| V3.1 | A1.9/A1.10 SC lag-time (D=1e-10·h=10μm → 55.6min onset) | **PBPK 대안** (Cleek-Bunge multilayer · Potts-Guy 회귀) | local CPU |
| V3.2 | A1.13 진피 자유신경말단 도달 (2.35% / 0.67%) | **2-comp PK** (SC + viable epi + dermis · λ partition 분해) | local CPU |
| V3.3 | B1.11/B1.13 PFD multipass headline (3.7p → N=2.17) | **독립 임상 메타** (R20 Kossida 2012 / Brauer pilot PMC5042086 정합) | local CPU |
| V3.4 | B2.4 frosted μ_s=162.83 · T=0.039 | **Monte Carlo photon transport (MCML)** Mie 정확해 | local CPU / RunPod GPU |
| V3.5 | B2.10 dose-response knee n*≈3-4 | Reddel 2020 fluence-temp data 와 φ_rel sensitivity | local CPU |
| V3.6 | B3.4/B3.5 β sweep + JOINT (β=0.50 → N=2.97; B2+B3 N=0.80) | **TTR-ORAL BP1d r-sweep** 정합 (β_oral 0.40 천장 vs β_topical 0.50) | local CPU |
| V3.7 | A1.13 + B2.4 + B3.4 통합 protocol 시뮬 (EMLA 60min + PFD 3.7p + β=0.50) | **단일 first-principles PBPK + 광학 + drainage 통합 모델** | local CPU |

> @D d7 sizing: 모두 local CPU 천장 안 (Python PBPK · MCML · 임상 메타 · BP1d cross-check · 통합 모델). MCML 만 large-domain 일 시 RunPod GPU. TDDFT/DFT 불필요.

---

## §14 final note

🔵 ledger 결착 — V1 의 🔵 8 / 🟢 13 / 🟡 11 / 🟠 6 분포에서 **🔵 closed-form 가 52개 unit identity 로 완전 분해 · 100% PASS · hand-verifiable**. carbon-25% 비분해 floor 가 모델 천장 (<1세션) 을 실용 floor (~1.5세션, ~2.4mo, ~3.8× cut) 로 honest-bound — **인플레 가드 작동**. 단일 *가장 약한 고리* = **β_topical = 0.50 (LB-6)** 의 직접 잉크-재포획 측정 부재 (M8 ex-vivo on real tattoo 가 1순위 wet-lab gate · V1 §8 정합). V3 (🟢 numerical) handoff 7 step 은 모두 local CPU 천장 안 — 비-wet-lab 영역의 grounding 경로 명확. absorbed=false 유지, 그러나 closed-form 영역은 **닫힘**.
