# TTR-LAC B3 — 토픽 재포획 억제 (r↓ · 후-레이저 drainage 보조)

> 🦠 **TTR-LAC** — "레이저 마취·지움 크림" track B3
> BP1(TTR-ORAL)이 막힌 "경구 高-β phagocytosis 차단제 부재" 벽을 **토픽**으로 우회 — 레이저 직후 진피 내 잉크 단편이 *재포획되기 전* 국소 적용해 r 을 낮춤. sim = `sim/b3_topical_r_down.hexa`.

---

## 1. 핵심 통찰 — 경구 ADME 벽이 *토픽으론 사라진다*

| 경로 | 진피 도달 | 결과 |
|---|---|---|
| 경구 (TTR-ORAL BP1) | f_target ≈ 1e-4 (시스템 PK) | β_oral 천장 ~0.40 (rhein/diacerein off-target) |
| 토픽 (TTR-LAC B3 · 레이저 직후) | SC→진피 ~1e-1 (레이저로 SC 투과성↑) | **~10³× 농도 우위** → β_topical 0.60-0.85 도달 가능 |

⇒ 경구로는 *biologic (anti-MARCO mAb · 비경구)* 가 필요하던 β를 **토픽 small molecule (rhein/Syk 억제제)** 로 도달.

## 2. 모델 (B1 framing 재사용)

```
c_pass = phi_rel · (1 − r)         phi_rel = 0.83 (B1 calib)
r(β)   = (1 − β_topical) · r₀      r₀ = 0.70 (B1 baseline)
c_session = 1 − (1 − c_pass)^n_passes
N_sessions = log(0.1) / log(1 − c_session)
```

## 3. hexa-native recompute (verbatim · 🟢)

```
[2] beta sweep at n=1 pass:
  beta=0.00  r=0.70   c_pass=0.249    N=8.04   (B1 baseline)
  beta=0.30  r=0.49   c_pass=0.4233   N=4.18   (cooling+massage+lymph)
  beta=0.50  r=0.35   c_pass=0.5395   N=2.97   (topical rhein, SR-A)
  beta=0.70  r=0.21   c_pass=0.6557   N=2.16   (Syk-topical + rhein)
  beta=0.85  r=0.105  c_pass=0.7429   N=1.70   (anti-MARCO peptide, research)

[3] JOINT stack with B2 PFD (n_passes=3.7):
  realistic    PFD(3.7) + beta=0.50  N=0.80
  aspirational PFD(3.7) + beta=0.70  N=0.58
  ceiling      PFD(3.7) + beta=0.85  N=0.46

[4] head-to-head fold vs SoC (n=1.4 pass, beta=0):
  SoC                     N=5.74     (9.19 mo @ 7-wk)
  B2 PFD-only             N=2.17     fold=2.64×   (3.48 mo)
  B3 r-only realistic     N=2.12     fold=2.71×   (n=1.4, beta=0.50)
  B2+B3 realistic         N=0.80     fold=7.16×   (1.28 mo)
  B2+B3 aspirational      N=0.58     fold=9.84×   (0.93 mo)
```

## 4. 토픽 β 후보 (단계적 현실성)

| β_topical | 모달리티 | 임상/문헌 status |
|---|---|---|
| 0.30 | post-laser 냉각 + 마사지 + escin/horse-chestnut 토픽 | 🟡 비특이·표준 SoC 인접 |
| **0.50** | **토픽 rhein/anthraquinone** (diacerein 토픽 선례 · SR-A 표적) | 🟡 → 🟠 (재포획 β 직접 실측 없음, BP1a scaffold) |
| 0.70 | 토픽 Syk 억제제(fostamatinib류) + rhein 스택 | 🟠 (조합 임상 부재) |
| 0.85 | 토픽 anti-MARCO peptide / SR-A 길항제 | 🟠 research-stage (mAb 등가 β, peptide 형태로 토픽화) |

> 토픽 *Syk 억제제* 는 **fostamatinib 자체가 경구 ITP 약**이라 small-molecule이고, 농도만 충분하면 토픽 가능 (oral wall에서 막혔던 핵심: ADME 1e-4 → 토픽은 직접). BP1의 "wrong-arm 의심"은 *경구 시스템 PK 가정에서*였고, 토픽 고농도에서는 FcγR + scavenger-receptor 광범 차단 가능.

## 5. 정직한 해석 + 천장

- B3 단독(n=1.4): SoC 5.74 → 2.12 세션 (**2.71× 단축**) — B2 단독(2.64×)과 동급. *둘 다 동급 lever* 임을 모델이 확인.
- B2+B3 합산은 *모델상* 0.80 세션(realistic) / 0.58(aspirational) — 즉 **1세션 미만이라는 비물리적 값**으로 떨어짐.
- 🧱 **honest 천장**: 모델은 c_session 에 상한 없음. 실제로는 잉크 화학 floor — **carbon black ~25% 비분해 + Cu-Pc/Cr₂O₃ ~10% wall = 절대 clearance ~75%** (TTR-ORAL N1/N3 상속). c_pass 가 0.83 가 실제는 *덜어내야 함* (전체 잉크 가중치, 분해 가능 65%만).
- 실용 floor: **stacked 라도 ~1.5-2 세션 (~2.5-3.5 개월)** 이 정직한 추정 — carbon-black은 단편 → drainage(B3) 만 가능(분해 X) 이라 PFD 다중패스의 *광물리* 효과(B2) 가 carbon 단편화도 동일하게 진행하니 합산 이득은 유지되나 floor 존재.

## 6. 공동제형 (track A + B2 + B3 적용 순서)

```
세션 0-60min:  EMLA 도포 + occlusion (각질층 SC 마취 침투, A1 lag-time)
세션 60min:    EMLA wipe (PFD/rhein 호환성)
시술 직전:     B3 r↓ 토픽(rhein/Syk gel) 1-pass 도포 → 흡수 ~5-10min
시술 중:       B2 PFD patch + 다중패스 레이저 (3.7 passes Biesman 최적)
시술 직후:     B3 추가 도포(post-laser pigment 단편화 직후 흡수창)
```

화학적 양립성:
- **EMLA + PFD**: 직접혼합 ✗(B2 결과) → 순차
- **PFD + rhein 토픽**: PFD는 비활성 fluorocarbon → rhein 직접 접촉 안전 추정 (🟠 실측 필요)
- **rhein + lidocaine/prilocaine**: rhein 안트라퀴논 산성, 마취제 아민염기 — pH 조정으로 양립 (DESCRIBE 토픽 선례 활용)

## 7. tier
| claim | tier |
|---|---|
| 토픽 vs 경구 ~10³× 농도 우위 | 🔵 (Fick PK) |
| β sweep → N 매핑 | 🟢 verbatim |
| β_topical 0.50 (rhein) 도달 가능 | 🟠 (직접 잉크-재포획 β 측정 없음) |
| B2+B3 multiplicative stack | 🟢 (모델) |
| <1세션 절대값 | 🔴 (carbon floor 무시한 모델 천장) |
| 실용 floor ~1.5-2세션 | 🟡 (carbon 25% 상속) |

## 8. 결론 + next

- **B3 = B2와 동급 단독 lever** (n=1에서 2.71× vs 2.64×) · 합치면 multiplicative.
- 토픽이 경구의 ADME 벽을 정량으로 풀어 **biologic 없이 small-molecule(rhein)** 로 의미있는 β 도달.
- 🟠 wet-lab gap: 토픽 rhein/Syk의 *재포획 β* 직접 실측 (M8 ex-vivo on real tattoo).
- next: **B4 통합제형** — EMLA + PFD + rhein 3-step 프로토콜 + 안정성 + 적용순서 최적화.

## Sources
- Biesman 2017 *Lasers Surg Med* — PFD/DESCRIBE 3.7 vs 1.4 passes (B1 인용)
- TTR-ORAL/research/BP1_recapture_block.md — 경구 phago 차단제 부재 벽 (이 도메인 토픽으로 우회)
- TTR-ORAL/research/BP1a_scavenger_receptor_scout.md — rhein/MARCO/SR-A scaffold 발견
- Lidocaine/prilocaine + anthraquinone topical co-formulation: EMLA + diacerein 토픽 선례 (off-label)
