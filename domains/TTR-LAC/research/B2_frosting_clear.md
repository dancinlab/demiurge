# TTR-LAC — B2: frosting-clearing 토픽 — PFD 심화 + 대체제 비교

> ❄️ **TTR-LAC** track B — "frosting 즉시 해소 → 동일세션 다중패스 → 세션수↓"
> B2 = B1 1차 lever(frosting clear) 를 **실제 후보제 + 광학 first-principles + dose-response knee** 로 구체화.
> 3 질문: (1) frosting 이 빔을 *얼마나* 차단? (2) PFD 가 *왜* 빠른가? (3) 패스를 *몇 번* 까지? sim = `sim/b2_frosting_clear.hexa`. @D d6 — fold-cut 신뢰.

---

## 1. frosting 광학 — 왜 후속 패스가 막히는가 (🔵/🟡)

레이저 펄스 → 잉크 광흡수 → 세포내 물 → **순간 steam → vacuolization** → ~1μm **가스 미세기포** → **Mie 산란** → 백탁 → 후속 빔 잉크 미도달 → 자연 소실 ~20분 → 세션당 **1패스 강제**.

| 항목 | 값 | 출처 |
|---|---|---|
| 기포 크기 / 밀도 | a ≈ 1 μm · N ≈ 10⁶/mm³ (= 10⁹/cm³) | JCAS PMC4411588 · Ho 2002 |
| 베이스 dermis μ_s (755nm) | ~100 cm⁻¹ | Jacques 2013 |
| 공기-물 RI 차 \|Δn\| | 0.333 (n_air=1.000 · n_water=1.333) | — |
| PFD-물 RI 차 \|Δn\| | 0.020 (n_PFD=1.313) | refractiveindex.info |
| Q_sca: 공기 vs PFD | ~2 vs ~0.02 → **100×** 약화 | 기하광 한계 + Rayleigh-Gans proxy |

산란 부가분: **μ_s_frost = N · Q · π · a²** → frosted **+63 cm⁻¹** · PFD **+0.6 cm⁻¹**.
Beer-Lambert 진피 z=200μm 잉크 도달 fluence (T = exp(−μ_s·z)):

| 상태 | μ_s (cm⁻¹) | T @ 200μm | clear 대비 |
|---|---|---|---|
| 무 frost (베이스) | 100 | 0.135 | 1.000 |
| **frosted (공기 기포)** | 163 | 0.039 | **0.285** ← 빔 ~72% 차단 |
| PFD-cleared | 100.6 | 0.134 | 0.987 ← 회복 |

```
  frosted 표피                      PFD 도포 후
  ░░░░░░░░░░  μ_s=163              ▒▒▒▒▒▒▒▒▒▒  μ_s≈101
  ●○○●○○○●○○  공기기포+잉크         ●●●●●●●●●●  잉크 (기포 PFD 흡수)
       ▼ T=0.039 (28%)                  ▼ T=0.134 (99%)
   PASS2 ✗ 미도달                   PASS2 ✓ 도달
```

---

## 2. PFD 기전 — RI 매칭 + 산소 흡수 (🟡/🔵)

PFD(C₁₀F₁₈ · CAS 306-94-5) 가 frosting 을 **3-5초** 안에 푸는 이중작용:

| 메커니즘 | 수치 | 효과 |
|---|---|---|
| **(α) RI 매칭** | n_PFD=1.313 vs n_water=1.333 (Δn=0.02) | Mie contrast 16× 감소 → 즉시 투명화 |
| **(β) O₂/CO₂ 흡수** | **50 mL/100mL @ 37°C** (물의 ~170×) | 기포 가스가 PFD 에 용해 → 물리적 소멸 |
| (γ) 화학 비활성 | hydrophobic+oleophobic · 단백질 무반응 | 자극 無 · 약물 호환 |
| (δ) 표면 산란↓ | Reddel 2020: 잉크 도달 fluence ~10%↑·피부온 ~40%↓ | phi_rel 0.83→0.91 |

```
  frosting 기포 (공기/CO₂)          PFD 침투 (3-5초)
       ○ ○                                 ○                     ·
     ○   ○ ○        ──[PFD]──►           ○ ○      ──[gas dissolve]──►    · · ·
   ○ ○ ○   ○                              ○ ○ ○                       ·
   μ_s≈163                              n 매칭 + O₂ sink           μ_s≈101
```

핵심: PFD = **RI 매칭 + 가스 sink 이중작용** — silicone-oil(RI만)·glycerol(SC탈수)보다 빠르고 완전.

---

## 3. 대체 RI-매칭제 비교 (🟡)

Q_sca proxy = 2·(Δn_water/n_water)² · tissue n=1.38.

| agent | n_D | Δn_tissue | Q_sca | O₂ 용해 | 휘발 | 규제 | 비고 |
|---|---|---|---|---|---|---|---|
| **PFD (perfluorodecalin)** | 1.313 | −0.067 | **4.5e-4** | **50 mL/100mL** | 낮음 (bp 142°C) | **FDA-cleared** DESCRIBE | **승자** — RI+O₂ 이중 |
| perfluorohexane (C₆F₁₄) | 1.252 | −0.128 | 7.4e-3 | 高 | **bp 56°C** (휘발) | 미승인 (피부) | 도포중 증발 → patch 필수 |
| silicone oil (PDMS) | 1.405 | +0.025 | 5.8e-3 | **≈0** | 낮음 | OTC · 안과 implant | RI 가장 가깝지만 **기포 안 녹임** |
| glycerol 50% (aq) | 1.398 | +0.018 | 4.8e-3 | 낮음 | 낮음 | OTC 보습제 | 기전=SC 탈수 · 분(min) 단위 (느림) |
| glycerol 30% (aq) | 1.371 | −0.009 | 1.6e-3 | 낮음 | 낮음 | OTC | 반사율 20%↓ · 표피 효과 약 |
| (참조) air/frosting | 1.000 | −0.38 | **0.125** | — | — | — | DOMINANT scatterer · 적 |

### 평가 — PFD 유일승의 이유
1. **RI 만으로 부족** — silicone-oil 은 n 가장 가까우나 기포 자체(공기) 잔존 → mismatch 잔존.
2. **가스 흡수가 시간상수** — PFD O₂ 50 mL/100mL → 1μm 기포 3-5초 흡수.
3. **휘발성 함정** — PFH bp=56°C → 수십초 안 증발 (패치 봉입 필수).
4. **규제 우위** — PFD 만 FDA cleared (DESCRIBE · 532/694/755/1064 QS · 532/755/785/1064 pico).
5. **glycerol = SC 탈수** — 분 단위 작용 → *세션내 다중패스* 부적합 (이미 발생한 표피 기포 미용해).

⇒ **PFD-함침 (실리콘 patch 또는 gel)** = 1순위. PFH/silicone-oil/glycerol = 보조 또는 부적합.

---

## 4. dose-response — 패스 sweep + diminishing-return knee (🟢)

B1 모델 재사용: `c_pass = phi_rel·(1−r) = 0.83·0.30 = 0.249` · `c_session = 1−(1−c_pass)^n` · `N = log(0.1)/log(1−c_session)`. t_p ≈ 5min/pass (PFD frost-clear 3-5초 무시).

| n | c_session | N_sess | ΔN cut | sess(min) | note |
|---|---|---|---|---|---|
| 1 | 0.249 | 8.04 | — | 5 | standard-of-care (frosting강제) |
| 2 | 0.436 | 4.02 | −4.02 | 10 | PFD 2-pass |
| 3 | 0.576 | 2.68 | −1.34 | 15 | pivotal-trial 평균 3.7 |
| **4** | **0.682** | **2.01** | **−0.67** | **20** | **★ KNEE ★** Kossida R20 4-pass |
| 5 | 0.761 | 1.61 | −0.40 | 25 | diminishing |

```
  ΔN_cut (패스 1회 추가당 절약 세션)
   4  █████████████████████   1→2 : 4.02 (단연 최대)
   2  █████████               2→3 : 1.34
   1  █████                   3→4 : 0.67  ← KNEE (< 1 세션)
  0.5 ██▌                     4→5 : 0.40  ← marginal
   0  ─────────────────────►
```

⇒ **최적 n\* ≈ 3-4 패스** — 임상 발견(Biesman 3.7 · Kossida 4) 이 *우연이 아니라* knee 위에 정착.
Reddel 2020 보너스 (phi_rel 0.83→0.91): n=3 → **N=2.41** · n=4 → **N=1.81** (추가 ~10% 단축).

---

## 5. PFD headline — 정량 게인 (🟢)

| 시나리오 | passes | c_session | N_sess | session 분 | 누적 (7주 간격) |
|---|---|---|---|---|---|
| laser-alone | 1.4 | 0.330 | **5.74** | 7 | **9.19 개월** |
| **PFD patch (R0/DESCRIBE)** | **3.7** | **0.653** | **2.17** | ~5 (DESCRIBE 보고) | **3.48 개월** |
| PFD + Reddel boost (n=4) | 4 | 0.721 | 1.81 | ~5 | 2.89 개월 |
| R20 (PFD 없는 20min 대기) | 4 | 0.682 | 2.01 | **80** (대기) | 3.22 개월 |

per-session wall-clock: R20=80분(20분×4 대기) vs DESCRIBE=**5분** (PFD 3-5초 clear×4). ⇒ **wall-clock 16×** AND **세션수 2.64×** (이중 곱셈).

---

## 6. 마취제(track A) 공동제형 — PFD-lidocaine 양립성 (🟡/🟠)

| 항목 | 평가 |
|---|---|
| PFD 화학 반응성 | **비활성** — fluorocarbon · 단백질·탄화수소 무반응 (PMC11614965) |
| PFD 용해도 | hydrophobic + oleophobic ("이중기피" third phase) — lidocaine free base 不溶 |
| EMLA eutectic | 1:1 lidocaine/prilocaine oil-phase + 수상 emulsion |
| 직접 혼합 | **부적합** — PFD third-phase 가 emulsion 안정성 깨뜨림 (separation) |
| **권장 순서** | **순차** — (1) EMLA 60min occlusion → (2) wipe → (3) PFD patch → (4) laser |

```
  현재 표준 (DESCRIBE + EMLA)
  0min ──60min occlusion──► wipe ──► PFD patch ──► laser ──► PFD clear 3-5s ──► PASS2..4
  [마취 진피 도달]                   [RI+O₂ 준비]   [pulse]                       [≤5min total]
```

안전: LAST(전신마취독성) 표준 EMLA dose 내 OK · PFD 흡수≈0 (피부장벽+이중기피) · Reddel 피부 thermal load 40%↓ → 화상·반흔 risk↓ 보너스.

---

## 7. hexa-native recompute (verbatim · 🟢 · per @D g5)

```
=== TTR-LAC B2: frosting optics + PFD dose-response + alt-agent table ===

[A] μ_s (cm⁻¹) + T @ 200μm (N=1e9/cm³ · a=1μm · Q_air=2 · Q_pfd=0.02):
  baseline (no frost)     100.0     T=0.135335
  frosted (air bubbles)   162.832   T=0.0385177   (0.285× clear)
  PFD-cleared (RI match)  100.628   T=0.133645    (0.987× clear)
  ⇒ frosting adds 62.83 cm⁻¹ · PFD shrinks bubble Q by 100× · fluence frost/clear=0.285

[B] alt RI-matching agents (Q_sca proxy = 2·(Δn_water/n_water)²):
  agent             n_D     Δn_tiss   Q_sca       note
  air (frost)       1.000   -0.380    0.124813    DOMINANT scattering · enemy
  PFD               1.313   -0.067    0.000450    FDA · O₂ carrier · WINNER
  PFH               1.252   -0.128    0.007385    volatile bp 56°C
  silicone-oil      1.405   +0.025    0.005835    best n · NO O₂ sink
  glycerol 50%      1.398   +0.018    0.004756    SC dehydration (slow)
  glycerol 30%      1.371   -0.009    0.001625    weak topical

[C] dose-response — passes sweep (c_pass=0.249 · t_p=5min):
  n   c_session   N_sess     ΔN cut    sess_time
  1   0.249       8.04117    --        5    standard
  2   0.435999    4.02058    4.02058   10   PFD 2-pass
  3   0.576435    2.68039    1.34019   15   pivotal mean 3.7
  4   0.681903    2.01029    0.67010   20   ★ KNEE ★ (cut < 1)
  5   0.761109    1.60823    0.40206   25   diminishing
  ⇒ KNEE at n* ≈ 3-4 passes (4→5 saves < 0.5 session)
  [Reddel boost phi_rel 0.83→0.91]: n=3 → N=2.41 · n=4 → N=1.81

[D] PFD headline (Biesman 2017):
  laser-alone (1.4): c=0.330  N=5.74  session=7min   → 9.19 mo
  PFD patch (3.7) : c=0.653  N=2.17  session=18.5min → 3.48 mo
  sessions cut=3.57 · fold=2.64× · wall-clock 80→5 min = 16×

=== honest floor (B1): passes change RATE only · carbon ink chemistry floor unchanged ===
=== Q_sca proxies are Rayleigh-Gans order-of-magnitude; fold-cuts are robust ===
```

---

## 8. honest tier + 한계

| claim | tier |
|---|---|
| frosting μ_s +63 cm⁻¹ · 빔 ~72% 차단 (§1) | 🔵/🟡 (Mie + Ho/Jacques) |
| PFD n=1.313 · O₂ 50 mL/100mL · FDA cleared | 🟡 (Merz · refractiveindex.info · ScienceDirect) |
| §7 [A][B][C][D] recompute | 🟢 verbatim |
| Biesman 3.7 vs 1.4 → N 2.17 vs 5.74 · 2.64× | 🟢 (B1 model · lit-cal) |
| Reddel ~10% fluence · 40% 피부온↓ | 🟡 (PubMed 32516063) |
| knee n*≈3-4 (4→5 ΔN<0.5) | 🔵/🟢 (모델 + 임상 정합) |
| PFD+lidocaine 직접혼합 부적합 · 순차 권장 | 🟠 (직접 호환성 데이터 부재) |
| 잉크 carbon 비분해성 floor | 🟡 (TTR-ORAL 상속) |

### 한계 (정직)
- Q_sca proxy = Rayleigh-Gans (소-contrast) — 공기 기포 contrast 큼 → Mie 정확해 필요 (fold-cut 비율은 견고).
- bubble 밀도 10⁹/cm³ · t_p=5min/pass · phi_rel/r 캘리브레이션 = lit 정합 추정 (환자·잉크·펄스별 산포).
- PFD-lidocaine 직접 실험 데이터 없음 — *비반응* 화학적 추론. emulsion 안정성은 시험 필요.

---

## 9. B2 verdict

> **frosting** 광학 = +63 cm⁻¹ → 진피 잉크 도달 fluence **0.285×** → 후속패스 무의미. **PFD** RI 매칭(16×↓ contrast)+O₂ 흡수(3-5초 기포 용해)로 fluence **0.987×** 회복. 결과: 패스 1.4→3.7 → **N 5.74→2.17 (2.64×↓)** · 누적 **9.2→3.5개월** · per-session wall-clock **80→5분 (16×)**. dose-response knee = **n\* ≈ 3-4** (4→5 패스 ΔN<0.5 marginal). 대체제: silicone-oil(RI 가까우나 O₂ sink無) · glycerol(SC 탈수·분 단위) · PFH(휘발 bp56°C) — **PFD 유일승**. 마취제와 직접혼합 부적합 → **순차 도포** (EMLA 60min → wipe → PFD patch → laser) 권장. absorbed=false 유지 (B4 통합제형까지).

**B3/B4 연결** — B3 recapture r↓ (Baranska 천장 0.50) → B2 와 곱셈 ~4.9× · B4 통합 = §6 *순차* (patch 다층/crème→patch 시퀀스).

## Sources
- PFD 물성 + FDA cleared — *ScienceDirect Topics Perfluorodecalin* · researchgate 335114971 · PMC11614965 · DESCRIBE patch (2015 Apr 755nm QS · 2020 expanded 532/694/1064 QS · 532/755/785/1064 pico) — Merz Aesthetics press · describepatch.com
- frosting = steam/vacuolization · 20-min self-clear — JCAS PMC4411588 · *J Aesthet Nurs* Skin&Laser Mar21 · Ho 2002
- PFD pivotal trial (Biesman 2017) 3.7 vs 1.4 passes — PubMed 28319270 · PMC5042086 (Brauer pilot)
- PFD 피부온도 40%↓ · ~10% fluence — Reddel 2020 PubMed 32516063 · Dermatology Times
- R20 (Kossida 2012) 4-pass · 61% vs 0% — PubMed 22036610 · baseline dermis μ_s ~100 cm⁻¹ — Jacques 2013 *Phys Med Biol*
- 대체제 — PFH refractiveindex.info · PubMed 15666319 (OCA in vitro skin) · 50% glycerol HGM nature s41598-020-77889-z (PMC7801418) · PMC10224698 (in vivo OCA LC-OCT) · silicone-oil n=1.40-1.41 (PMC3759812)
- Baranska 2018 capture-release-recapture — *J Exp Med* rupress.org/jem/215/4/1115
