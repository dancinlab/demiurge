# TTR-ORAL — M9 심화: 실측-grounded W3 recovery re-gate (track B)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> 목표: W3 의 핵심 measurable(τ_rec 독성 회복시간)을 **실제 문헌 측정값으로 grounding** → 검증된 M5/M6 모델에 넣고 verdict 재계산. 가정(🟠) → 문헌-bounded(🟡). sim = `sim/m9_lit_grounded_recovery.hexa`.

---

## 1. 문헌 실측값 (🟡 SUPPORTED-BY-CITATION)

| 파라미터 | 실측값 | 출처 |
|---|---|---|
| τ_rec (CSF1R macrophage 재증식) | depletion ~1주 · 회복시작 ~1주 후 · 조직 macrophage 완전회복 **3-4주** · 일부 "perdure"(부분) | PLX5622/pexidartinib (PNAS 2020 · Diabetologia 2023) |
| 자연 capture-release 사이클 | **~90 일** (재포획) · 영구성=macrophage *renewal* (monocyte 보충) | Baranska 2018 (J Exp Med) |
| dermal macrophage 이주 (자극 시) | 수 시간 내 draining LN 이동 · nerve-associated subset 빠른 monocyte 교체 | J Immunol 1998 · PMC11542019 |
| 자연 fade | capture-release-recapture 중 색소 림프 drainage (느림) | Baranska 2018 · ScienceDaily |

⇒ **τ_rec ≈ 14-28 일** (중앙값 21일) · 단 (a) microglia/peritoneal/tissue macrophage 측정값 (dermal tattoo-laden 특이값 아님) · (b) 부분회복("perdure") → η 상한치 경향.

---

## 2. 모델 (M5/M6 위에 grounding)

```
recovery efficiency:  eta = 1 − exp(−t_off / tau_rec)        t_off = T − on
safety break-even:    eta* = 3 / (0.8 · (T/on))              (balanced 3-lever · TI≥3 · M6 re-gate)
PASS if eta ≥ eta*
```

## 3. hexa-native recompute (verbatim · 🟢 · per @D g5)

```
[1] recovery efficiency eta by pulse period T (on=3d):
  tau_rec=14d : T=21d eta=0.723547 T=28d eta=0.832323 T=42d eta=0.938315
  tau_rec=21d : T=21d eta=0.575627 T=28d eta=0.695924 T=42d eta=0.843882
  tau_rec=28d : T=21d eta=0.474212 T=28d eta=0.590516 T=42d eta=0.751635

[2] safety break-even eta* (balanced, TI>=3) by T:
  T=14d eta*=0.803571
  T=21d eta*=0.535714
  T=28d eta*=0.401786
  T=42d eta*=0.267857

[3] PASS test (tau_rec=21d central estimate · eta >= eta* ?):
  T=14d: eta=0.40774 eta*=0.803571 pass=-0.395831
  T=21d: eta=0.575627 eta*=0.535714 pass=0.0399129
  T=28d: eta=0.695924 eta*=0.401786 pass=0.294138

[4] fade timeline t_90 = n90 * T  (n90=14.17 · event-driven phi):
  T=14d (biweekly): 6.52566 months  (FAST but eta<eta* = unsafe)
  T=21d (3-week)  : 9.78849 months  (safe margin thin)
  T=28d (4-week)  : 13.0513 months  (safe comfortable)
  T=42d (6-week)  : 19.577 months  (very safe · slow)

[5] natural cycle anchor (Baranska): 90d/cycle -> n90*90d = 41.9507 months if unpulsed-rate
```

## 4. 정직한 발견 (@D d6 — 낙관 강제 금지)

```
   펄스 간격 T 의 speed ↔ safety 트레이드오프 (τ_rec=21d)
   T=14d  ███ 6.5mo  η0.41 < η*0.80  ✗ UNSAFE  ← 옛 "7개월" 낙관치는 회복 실패
   T=21d  █████ 9.8mo  η0.58 > η*0.54 ✓ thin
   T=28d  ███████ 13mo  η0.70 > η*0.40 ✓ 편안
   T=42d  ██████████ 20mo  η0.84 > η*0.27 ✓ 매우안전·느림
```

- **격주(T=14d) 7개월 일정은 실측 τ_rec 하에서 안전 실패** — 회복(η=0.41)이 안전 문턱(η*=0.80)을 못 넘음. M5 의 낙관 추정이 grounding 으로 **정직하게 상향 수정**됨.
- **현실 sweet spot: T ≈ 3-4주 펄스 → ~10-13개월** skin clearance, η(0.58-0.70) > η*(0.40-0.54) 안전 만족.
- 자연 무펄스 rate 면 ~42개월 (Baranska 90일 사이클 정합) — 펄스가 ~3-4× 단축.

## 5. tier + verdict 갱신

| claim | tier |
|---|---|
| η = 1−exp(−t_off/τ_rec) · η* 식 | 🔵 closed-form |
| §1-4 recompute | 🟢 verbatim |
| τ_rec 14-28d · 90d 사이클 · 이주 동역학 | 🟡 문헌 (PLX5622 · Baranska) |
| dermal tattoo-laden 특이 τ_rec · per-pulse φ 절대값 · "perdure" η haircut | 🟠 (M9 in-vivo 실측) |
| grounded thesis | ⚪ fence (verbatim 별도) |

> **W3 verdict 갱신**: "🟠 assumed" → **"🟡 literature-bounded · plausibly-GO at 3-4wk spacing"**. 문헌 τ_rec 가 모델에 들어가 window 가 *현실 숫자에서 열림*을 보임 (단 3-4주 간격 · ~10-13개월, 격주 7개월 아님). 그러나 dermal-특이 τ_rec + 효능 φ 의 *직접 실측* 은 여전히 M9 in-vivo (🟠) — absorbed=false 유지.

## 6. M9 in-vivo 가 좁혀야 할 단 2개 측정
1. **dermal tattoo-laden macrophage 특이 τ_rec** (문헌은 비-dermal · "perdure" 보정 필요).
2. **per-pulse φ** (펄스 1회당 실제 잉크 release 분율 · ex-vivo M8 → in-vivo M9).

⇒ 비-wet-lab grounding 으로 W3 를 "막연한 NO-GO" → "3-4주 펄스면 plausibly-GO, 2개 숫자만 실측 남음"까지 좁힘.

---

## Sources
- Baranska et al. 2018, *J Exp Med* — tattoo macrophage capture-release-recapture (rupress.org/jem/article/215/4/1115)
- CSF1R inhibition (PLX5622) hematopoiesis/macrophage — *PNAS* 2020 (pnas.org/doi/10.1073/pnas.1922788117) · *Diabetologia* 2023 (PMC10627931)
- Dermal macrophage→LN trafficking — *J Immunol* 1998 · dermis-resident resilience PMC11542019
