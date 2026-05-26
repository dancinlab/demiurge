# TTR-ORAL — N2: monocyte trojan-horse (재포획자를 *교체 단계*에서 친다)

> 🦠 **TTR-ORAL** — "면역세포 택배" · NOVEL mechanism candidate (@D d11)
> 핵심 전환: 재포획 r 은 **진피에 새로 도착한 monocyte-derived macrophage** 가 방출 색소를 다시 삼키기 때문에 일어난다 (Baranska: 영구성=macrophage *renewal*, 죽는 진피 macrophage 는 **혈중 monocyte** 로 끊임없이 교체). monocyte 는 **혈액 안**에 있다 — 경구 전신약이 *직접* 닿는 구획 (진피 f_target~1e-4 벽 회피!). 그래서 들어올 monocyte 를 미리 reprogram 해 재포획 r 을 낮춘다. sim = `sim/n2_monocyte_trojan.hexa`.
> 정직 원칙 (@D d5/d6): 낙관 강제 금지. "혈액 접근성 우위"는 진짜이나 **속도(solo)·선택성·지속성**은 미해결.

---

## TL;DR

진피 안의 잡기 힘든 resident macrophage 와 싸우는 대신, 그것을 *교체할* 혈중 monocyte 를 편집한다. monocyte 는 혈액 = 경구약이 곧바로 닿는 구획(접근성 ~5000× 우위) → 재포획(r) 약화·payload 운반·림프 셔틀 phenotype 을 미리 심을 수 있다. 모델상 reprogram 된 교체세포가 resident pool 을 turnover(τ_rep~90일, Baranska) 하며 **r_eff 가 r0=0.95 → r_prog 로 점강** → k_eff↑. 그러나 N2 **단독**은 k_death 증폭기(CSF1R 펄스)가 없어 phi 가 작고 **多년** — N2 의 진짜 가치는 *속도가 아니라* "r↓ 레버를 접근 가능한 혈액 구획에서 **달성 가능하게** 만드는 공급원". 경구 monocyte reprogramming 선례: metformin(oxLDL trained immunity 차단)·LXR/statin류는 실재하나 **타투-표적 reprogramming 은 개념단계 🟠**. 1차 판정: 접근성 우위 🔵/🟢 · turnover 동역학 🔵 · 경구 *비표적* reprogram 제 실재 🟡 · *타투-표적* reprogram + solo efficacy 🟠.

---

## §1 왜 ADME 벽을 *옆으로 비껴가나* — 표적이 혈액에 있다

```
   기존 경로 (Path A·resident 표적)              N2 경로 (교체세포 표적)
   ════════════════════════════════              ════════════════════════════
   경구약 ──(BA F)──► 혈액                        경구약 ──(BA F)──► 혈액
                       │                                            │
            진피로 분포 f_target ~ 1e-4                    혈중 monocyte = *이미 여기*
                       │  ◄── 벽                           (f_target = F ≈ 0.3~0.9)
                       ▼                                            │ reprogram 됨
            resident macrophage (잡기 힘듦)                          │ 정상 homing
                                                                     ▼
                                                       진피 진입 = 새 recapturer
                                                       (이미 low-r phenotype)
   ════════════════════════════════              ════════════════════════════
   접근성 = 1e-4                                   접근성 = F (≈ 5000× 우위)
```

**정량 (sim §1, verbatim):** f_dermis = 1e-4, f_blood = F ≈ 0.5 → **accessibility gain ≈ 5000×**.

- 핵심: 경구 bioavailability 의 *정의* 자체가 "전신 **혈액** 도달 분율" — monocyte 는 그 혈액 안에 있다. 진피 깊숙이 분포할 필요 없이 표적이 약과 같은 구획에 산다.
- 그 다음 monocyte 가 **스스로 진피로 homing** 하며 우리가 심은 phenotype/cargo 를 운반 — "약을 진피로 보내는" 문제를 "세포가 진피로 가는" 생리에 외주.
- 근거: 하부 진피 macrophage 는 혈중 monocyte 보충으로 교체(Kolter/Wang 등 dermal turnover) · 2023 Lin et al. — **혈중 monocyte 가 모든 혈구 중 잉크 흡수에 *가장* 효율적** + monocyte 가 진피→내부장기로 잉크 운반 시사 → "incoming monocyte = recapturer" 가 인간 세포에서 실증.

---

## §2 reprogramming 레버 (혈중 monocyte 를 어떻게 편집하나)

각 레버를 k_eff = k_emig+(1−r)·k_death 항(주로 r↓, 일부 k_emig↑)에 매핑. 경구 실재성 정직 표기.

| # | 레버 | 기전 (monocyte 단계) | k_eff 효과 | 경구 선례 (실재) | 정직 등급 |
|---|---|---|---|---|---|
| **(a)** | **trained-immunity / 대사 reprogram** | metformin 이 oxLDL-유발 monocyte trained immunity(글리코분해·후성유전 재배선)를 *생체 내 차단* → polarization 이동 | r↓ (탐식·SR 발현 표현형 둔화) | **metformin (경구, FDA)** — in-vivo monocyte trained-response 차단 (Bekkering/Netea류) · statin 은 β-glucan trained immunity 차단(단 FH 환자 monocyte phenotype 미복원 = 불완전) | 🟡 (경구 monocyte 효과 실재 · 타투-색소 r↓ *미실측*) |
| **(b)** | **scavenger-receptor 다운 (in monocyte)** | MARCO/SR-A1(MSR1)=무른/음전하 색소 재포획의 dominant 수용체 — **MARCO 는 *순환 monocyte* 에도 발현**. monocyte 단계에서 SR 발현을 낮추면 진피 진입 후 재포획 r↓ | r↓ (BP1a 의 *올바른* 수용체 표적) | rhein←diacerein(경구 FDA, 최초 SR-A SM inhibitor) · LXR 작용제는 SR-A↓·cholesterol efflux↑ (단 임상 LXR 작용제 hepatic-lipid 부작용) | 🟠 (수용체는 monocyte 에 있음 · 경구 선택적 SR-down 제 부재 — BP1a 와 동일 gap) |
| **(c)** | **pro-emigratory programming (CCR7↑)** | monocyte/macrophage 의 CCR7 발현↑ → 색소 적재 후 afferent lymph 로 *나가게*. 죽상경화 regression 에서 CCR7↑ → plaque macrophage 유출↑ 선례 | k_emig↑ (색소를 림프로 셔틀-아웃) | miR-125b 차단 → CCR7↑ (전임상, 비경구) · 임상 직접 경구 CCR7-agonist **부재** (M4b 결론 정합) | 🟠 (기전 plausible · 경구약 부재) |
| **(d)** | **monocyte-hitchhiking payload 적재** | 순환 monocyte 표면/내부에 색소-분해 또는 림프-셔틀 NP("cellular backpack") 적재 → monocyte 가 진피로 운반 | r↓ 또는 색소 in-situ 처리 | 전임상 leukocyte/monocyte-hitchhiking NP delivery (Thno·Sci Adv) — 단 **i.v. 적재**가 표준, 경구 NP-적재 미성립 | 🟠 (전임상 · 경구 비호환) |

```
   safety↑·경구실재↑                                     기전강력·경구약부재↑
   (a) metformin 대사  ──  (b) SR-down  ──  (c) CCR7 emig  ──  (d) NP hitchhike
   경구 FDA 약 존재         수용체는 있음     기전 plausible      전임상·i.v. 적재
   ──────────────────────────────────────────────────────────────────────────────
   r↓ leverage 큼 = (b)(c)(d) ↔ 경구 실재성 = (a) 뿐  →  N2 의 핵심 trade-off
```

> 정직 (선택성 부재): 위 레버는 **모든 monocyte 를 reprogram** — 진피-homing subset 만 고르지 못함. "타투 부위로 갈 monocyte 만" 편집 불가 → 전신 면역(숙주방어·죽상경화·trained-immunity 손실) 효과 동반 (§4).

---

## §3 모델 매핑 — r_eff 가 pool turnover 로 점강

N2 는 r 을 *즉시* 0.95→낮추지 못한다. resident pool 이 reprogram 된 교체세포로 **turnover** 되며 점강:

```
   f_replaced(t) = 1 − exp(−t / τ_rep)              τ_rep ≈ 90d (Baranska renewal cycle)
   r_eff(t)      = r0·(1−f) + r_prog·f              r0=0.95(자연) · r_prog=0.50(reprogram 천장 가정)
   k_eff(t)      = k_emig + (1 − r_eff(t))·k_death  [🔵 closed-form · 단조 ∂k_eff/∂r<0]
```

### hexa-native recompute (verbatim · 🟢)
```
[2] r_eff(t) as dermal pool is replaced by reprogrammed monocytes (tau_rep)
  tau_rep = 90.0d (Baranska renewal cycle) ; r0=0.95 r_prog=0.5
  t(mo)  f_replaced   r_eff      k_eff(natural kd=0.05)
   1     0.286646  0.821009  0.0289495
   3     0.636993  0.663353  0.0368323
   6     0.868226  0.559298  0.0420351
  12     0.982674  0.507797  0.0446102

[3] fade timeline at fully-reprogrammed r_prog (canonical phi/n90, T=28d)
  case            k_death  r_prog  k_eff      phi        n90      months
  N2 solo         0.05     0.50    0.045  0.011187  204.674  188.516
  baseline(r0)    0.05     0.95    0.0225  0.00560921  409.348  377.031
  N2 + CSF1R-pulse 0.50    0.50    0.27  0.0652723  34.1124  31.4193
  N2(r0.30)+pulse 0.50    0.30    0.37  0.0883508  24.8928  22.9276
```

```
   N2 효과 = "r↓ 공급" (속도 아님)
   ───────────────────────────────────────────────────────────
   baseline r0.95           ██████████████████ ~377 mo (31 yr) 사실상 영구
   N2 solo  r0.50 (no pulse) █████████ ~189 mo (16 yr)  ← r 절반인데도 多년!
   N2 + CSF1R-pulse r0.50    ██ ~31 mo (2.6 yr)
   N2 + CSF1R-pulse r0.30    ██ ~23 mo (1.9 yr)
```

- **timescale**: 효과 onset = monocyte turnover(혈중 1~3일·Ly6Chi t½~20h) → 진피 pool 교체 τ_rep~90일. r_eff 는 ~3개월에 0.66, ~6개월에 0.56 으로 점강 (월별 표). 즉 **즉효 아님 — 수개월 ramp-up**.
- **핵심 발견 (정직)**: r 을 0.95→0.50 으로 절반 낮춰도 **N2 solo 는 ~16년** (k_death 자연 0.05 → phi=0.011 미미). r↓ 만으로는 k_eff 가 안 큰다 — 이는 cycle1/BP1 천장과 정확히 정합. N2 의 가치는 *그 r↓ 를 경구·혈액 경로로 **달성 가능**하게* 만든 것이지 속도를 푼 게 아님.
- **N2 + CSF1R-pulse(k_death=0.50)** = N2 가 low-r recapturer 를 *공급*하고 펄스가 k_death 를 키움 → ~2~2.6년. 즉 N2 는 **r-레버 공급원**으로 기존 k_death 레버(M9)·레이저(BP1d) 와 결합할 때 의미.

---

## §4 정직한 한계 (plainly stated)

| 한계 | 내용 | 등급 영향 |
|---|---|---|
| **선택성 (가장 큰 약점)** | monocyte subset-특이 reprogramming 불가 — **모든 순환 monocyte** 가 편집됨. 진피-homing monocyte 만 고를 방법 없음 → 전신 macrophage 표현형 전체 이동 (감염방어·죽상경화·조직수복 영향). MARCO/SR-A 전신 down = Listeria/HSV-1 취약·내독소쇼크 방어 손실 (BP1a 경고 동일). | 🟠 — 전신 면역효과가 결정 gate |
| **지속성** | fade 는 수개월~년. trained-immunity reprogram 은 후성유전적이나 *영구 아님* (monocyte 는 골수에서 끊임없이 새로 생성 → 비편집 monocyte 유입). **수개월 내내 지속 reprogram** 필요 = 만성 경구 노출 = 전신 risk↑. | timeline·safety honest |
| **r_prog 천장 미실측** | r_prog=0.50 은 *가정*. 경구 비표적 reprogram 제(metformin 등)가 실제로 dermal 색소 재포획 r 을 얼마나 낮추는지 **직접 측정값 없음** → r_prog 는 더 클(약효 작을) 수 있음. | 🟠 wet-lab |
| **속도 solo 부족** | §3: N2 solo(펄스 없음)=多년. 단독 monotherapy 로 의미 있는 fade 불가 — k_death 증폭(CSF1R) 또는 레이저 병용 필수. | "솔로로 빠름" claim 금지 |
| **타투-표적 경구 reprogram 제 부재** | metformin·statin·LXR류는 monocyte phenotype 을 *바꾸나* 표적은 죽상경화·대사. **타투 색소 재포획을 표적으로 한 경구 reprogram 제는 임상 부재 — 개념단계.** (a) 만 "경구 monocyte 효과 실재" 🟡, 나머지 🟠. | 🟠 concept-stage |
| **relocation ≠ destruction** | (c)(d) 경유 fade 도 색소를 림프절로 *옮길* 뿐 (track B 공통 한계). 분자 소거 아님. | efficacy 본질 한계 |

---

## §5 tier 판정 (per `hexa verify rubric` · positive 강제 금지)

| key claim | tier | 근거 |
|---|---|---|
| 재포획자 = 혈중 monocyte 유래 신규 macrophage (renewal) | 🟡 SUPPORTED-BY-CITATION | Baranska 2018 (PMID 29511065) · 하부 진피 monocyte 보충 |
| 혈중 monocyte 가 잉크를 가장 효율적으로 흡수 (recapturer 실증) | 🟡 SUPPORTED-BY-CITATION | Lin et al. *Immunology* 2024 (10.1111/imm.13714) |
| 접근성 gain = F / 1e-4 ≈ 5000× (혈액 = 경구약 도달 구획) | 🟢 SUPPORTED-NUMERICAL | bioavailability 정의(혈액 도달 분율) + Path-A 1e-4 anchor |
| r_eff(t)=r0(1−f)+r_prog·f · k_eff=k_emig+(1−r)k_death · ∂k_eff/∂r<0 | 🔵 SUPPORTED-FORMAL | 선형혼합 + 1차 ODE closed-form (단조성 자명) |
| §3 r_eff·n90·months recompute | 🟢 SUPPORTED-NUMERICAL | sim verbatim (baseline n90·CSF1R-pulse 값 cycle1 정합) |
| metformin 이 monocyte trained immunity 를 경구로 차단 | 🟡 SUPPORTED-BY-CITATION | oxLDL trained-immunity in-vivo metformin 차단 |
| MARCO 가 순환 monocyte 에도 발현 (monocyte-단계 SR-down 표적 가능) | 🟡 SUPPORTED-BY-CITATION | MARCO immune-checkpoint 리뷰 (PMC4292731) |
| r_prog 천장 (reprogram 이 실제 낮추는 r) · 타투-색소 효능 | 🟠 INSUFFICIENT/DEFERRED | 직접 미실측 (wet-lab gate) |
| 타투-표적 경구 monocyte reprogram 제 실재성 | 🟠 INSUFFICIENT/DEFERRED | 임상약 부재 — 개념단계 |
| monocyte subset-선택성 (전신효과 회피) | 🟠 INSUFFICIENT/DEFERRED | subset-특이 reprogram 불가 — §4 결정 gate |

```
   tier 분포:  🔵 1 · 🟢 2 · 🟡 4 · 🟠 3 · 🔴 0
   ──────────────────────────────────────────────────
   접근성 우위·turnover 동역학 = 닫힘 (🔵/🟢).  경구 *비표적* monocyte 효과 = 🟡 실재.
   타투-표적 reprogram·r_prog 효능·선택성 = 🟠 deferred (개념단계).
   → positive verdict 강제 안 함. "혈액 접근성은 진짜 우위(벽 회피)이나,
      속도는 solo 불가(k_death 병용 필요)·선택성/지속성 미해결."
```

---

## §6 verdict — 혈중 monocyte vs resident macrophage, 그리고 경구 reprogram 제

```
   접근성 (벽 회피)  :  blood monocyte ≫ resident  (~5000× — N2 의 진짜 강점)
   속도 (solo)       :  비김 — 둘 다 k_death 증폭 필요 (N2 solo ~16년)
   선택성/안전       :  blood monocyte < resident  (전신 monocyte 전부 편집 = 더 큰 systemic)
   ─────────────────────────────────────────────────────────────────────────
   ⇒ "표적 도달"은 N2 가 압승, "단독 efficacy/선택성"은 미해결.
```

- **표적 도달(ADME)** 만 보면 혈중 monocyte 가 resident 를 압도 — Path-A/BP1a 의 진피 1e-4 벽을 *구조적으로* 회피 (표적이 약과 같은 혈액 구획에 산다). 이것이 N2 의 진짜 신규성.
- **그러나** r↓ 만으로는 k_eff 가 안 커 N2 solo 는 多년 (모델 천장). N2 는 "빠른 단독 치료"가 아니라 **"r↓ 레버를 경구로 달성 가능하게 만드는 공급원"** — CSF1R-펄스(M9)·레이저(BP1d) 와 결합해야 ~2년대.
- **경구 reprogram 제**: monocyte phenotype 을 *바꾸는* 경구 약은 실재 (metformin = trained-immunity 차단, statin/LXR류 = SR-A·efflux 조절) 🟡. 그러나 **타투 색소 재포획을 표적으로 한 경구 reprogram 제는 없음 — 개념단계 🟠.** 가장 정직한 near-term = metformin류 비표적 reprogram 의 dermal-색소 r↓ β 실측 → BP1a 의 경구 SR-down lead 개발과 수렴.

⇒ N2 는 **falsified 아님 · 신규 각도 유효** (접근성 벽 회피는 first-principles 상 진짜). 단 device-free solo monotherapy = 多년, lead 가치는 *r-레버 공급원* + 병용. absorbed=false 유지.

---

## Sources
- Baranska et al. 2018, *J Exp Med* 215:1115 — tattoo macrophage capture–release–recapture · 영구성=monocyte renewal (rupress.org/jem/article/215/4/1115 · PMID 29511065)
- Lin et al. 2024, *Immunology* — 혈중 monocyte 가 잉크 흡수에 가장 효율적·진피→장기 운반 시사 (onlinelibrary.wiley.com/10.1111/imm.13714 · PMID 37964593)
- 인간 monocyte subset 수명/fate (Ly6Chi t½~20h·혈중 1–3일) — Patel et al. *J Exp Med* 2017 214:1913 (rupress.org/jem/article/214/7/1913)
- 하부 진피 macrophage 의 혈중 monocyte 보충 · dermal turnover compartment — dermis-resident resilience PMC11542019 · *J Exp Med* dermal CD14+ transient monocyte-derived (PMC4175180)
- metformin 이 oxLDL 유발 monocyte trained immunity 차단 / 대사 reprogram — *J Mol Med* 2020 (10.1007/s00109-020-01915-w) · trained-immunity 대사 리뷰 PMC11282170 · statin β-glucan trained immunity 차단 vs FH 미복원 (*Cell Metab* 2019 S1550-4131(19)30254-2)
- monocyte-hitchhiking / cellular-backpack NP delivery (전임상, i.v.) — *Theranostics* 7:751 (thno.org/v07p0751) · *Sci Adv* immune-cell shuttle (10.1126/sciadv.abf2400) · in-situ hitchhiking PMC10841869
- MARCO = 순환 monocyte 발현·면역 checkpoint — MARCO immune-checkpoint 리뷰 PMC4292731 · MARCO Wikipedia(circulating monocytes 발현)
- CCR7↑ → plaque macrophage 유출 (pro-emigratory 선례) — miR-125b 차단→CCR7↑ 죽상경화 감소 (medrxiv 2024.03.25.24304874)
- LXR 작용제 reverse cholesterol transport·SR-A/efflux 조절 — *PMC4107336* (LXR RCT) · LXR 죽상경화 리뷰 (mdpi 1422-0067/19/8/2307)
- bioavailability = 전신 혈액 도달 분율 (접근성 정의 anchor) — MSD Manual / ScienceDirect bioavailability overview
