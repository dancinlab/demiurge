# TTR-ORAL — d11b: 경구 lymphagogue 의 배출-부스트 D 실측-grounding

> 🦠 **TTR-ORAL** — "면역세포 택배"
> 목적: d11 의 새 dominant lever (`r = k_phago/(k_phago+k_drain)`, k_drain↑ 로 r↓) 에서
> **경구 lymphagogue 가 실제로 달성하는 배출-부스트 D** 를 문헌 실측값으로 pin.
> d11 은 D=5~19 를 가정했음 — 문헌은 그게 현실적인지 묻는다. sim = `sim/d11b_lymphagogue.hexa`.

---

## 0. 질문 한 줄

```
d11 모델:  D=19 → r 0.95→0.50 → 31개월    (배출 19× = phago 차단 0 으로 r 반토막)
   질문:  경구 lymphagogue 가 D=19 (=림프 배출 19×) 를 정말 내나?
```

---

## 1. 실측 lymphagogue 효과 (🟡 SUPPORTED-BY-CITATION)

| agent (경구/주사) | 측정계 | 실측 lymph-flow / pumping 변화 | → 환산 D |
|---|---|---|---|
| **Daflon (MPFF, diosmin 90%/hesperidin 10%)** IV | 개 흉관(thoracic duct) fistula, peak 10분 flow (Cotonat 1989) | **+191% / +171% / +91%** @ 12.5 / 6.25 / 3.125 mg/kg | x2.91 / x2.71 / x1.91 (IV·일시·peak 20-25분) |
| Daflon, 분리 소 장간막 림프관 (McHale/Hollywood 1994) | 자발수축 *빈도*↑ (intraluminal pulsatile pressure r=0.877) | 빈도 증가 — % 미보고, "사람의 tonic effect 에 근접" | 정성 (modest) |
| Daflon 경구, 사람 lymphoscintigraphy | colloid half-life·clearance | "개선" — 중증 림프부종서 migration speed 유의 개선 | modest (배수 아님) |
| **Coumarin / benzo-α-pyrone** (5,6-benzo-α-pyrone) | 동물 lymph flow | dose-dependent flow↑ (contractility·pumping 매개) — % 정량 빈약 | modest |
| **Escin / 마로니에(HCSE)** | 동물 흉관 lymph flow | dose-dependent 정맥+림프 flow↑ (정량 배수 미확립) | modest |
| benzopyrone 류 임상 effect | 사지 부종량 | 부종량 **연 -55%** · 팔 46%→26% (정상比) | 부종 결과지표지 flow 배수 아님 |
| (해부학적 ceiling) 림프 pump *예비능* | 사람 hyperthermia / 마우스 압력범위 | 수축빈도 **x4 (사람 stress) … x10 (마우스 압력전구간)** | 기계적 상한 — 약물 전달분 아님 |

핵심 정리:
- 배수(>2×)로 올라간 단 하나의 숫자 = **Daflon IV bolus 의 일시 peak (+91~191%)** — 초생리 IV 용량·20-25분만 지속·경구 sustained 아님.
- 경구·지속 투여의 사람 실측은 전부 **수십 % 수준의 부종/clearance 개선** — *배수* 보고 없음.
- 림프관 자체의 기계적 예비능(x4~x10)은 압력/운동 매개지 *경구 약물* 이 끌어내는 양이 아님.

⇒ **지속 경구 D ≈ 1.2–2.0x** (중앙 ~1.5x). 일시 IV peak ~2-3x 는 경구로 지속 불가.
   d11 의 D=5~19 는 **림프관 기계적 ceiling 가정에 가깝지, 경구 agent 가 내는 값이 아님.**

---

## 2. 정직한 평가 — D~5-19 는 경구로 안 나온다

```
   modeled D=19 ░░░░░░░░░░░░░░░░░░░  (배출 19×)  ← phago-차단-free 가정의 핵심
   modeled D=5  ░░░░░                (배출 5×)
   ─────────────── 경구 lymphagogue 실측 ceiling ───────────────
   IV peak ~2-3x ▓▓ (Daflon IV·일시·비지속)
   oral D~1.5   ▓                    ← 실측-현실 (지속 경구)
```

- d11 의 D=19 (31개월) 은 **경구 lymphagogue 단독으로는 도달 불가**. 정직하게: 경구 D 는 ~1.5x.
- 배출 lever 는 방향은 맞다(분모 k_drain↑ 로 r↓ 는 진짜) — 그러나 **단독으로는 약하다**.

---

## 3. hexa-native recompute (verbatim · 🟢 · per @D g5)

```
=== TTR-ORAL d11b: literature-realistic drainage boost D (oral lymphagogues) ===

[1] r(D) and timeline across the lit-realistic ORAL range (D=1..2) vs modeled aspiration (5,19):
  D     r=19/(19+D)   k_eff    phi        n90       months
  1.0   0.95  0.045  0.011187  204.674  188.516
  1.2   0.940594  0.049703  0.0123489  185.308  170.678
  1.5   0.926829  0.0565854  0.0140468  162.769  149.919
  2.0   0.904762  0.067619  0.0167627  136.209  125.456
  5.0*  0.791667  0.124167  0.0305648  74.1772  68.3211
  19*   0.5  0.27  0.0652723  34.1124  31.4193

  (* = modeled aspiration, NOT achievable by sustained oral lymphagogues per lit)

[2] honest delta: how much does a REALISTIC oral D move the timeline vs D=1?
  D=1.0 -> 188.516 mo
  D=1.2 -> 170.678 mo  (cut 17.8376 mo = 9.46215%)
  D=1.5 -> 149.919 mo  (cut 38.597 mo = 20.4741%)
  D=2.0 -> 125.456 mo  (cut 63.0598 mo = 33.4507%)

[3] drainage lever ALONE (realistic D=1.5) still needs the bolus s_sat partner:
    r_eff = r(D=1.5) * (1 - s_sat) ; r(D=1.5)=0.926829
  s_sat=0.0: r_eff=0.926829 months=149.919
  s_sat=0.4: r_eff=0.556098 months=35.0616
  s_sat=0.7: r_eff=0.278049 months=22.2671

=== verdict: oral D ~ 1.2-2.0x (real-direction, weak alone) — drainage MUST combine w/ s_sat / laser ===
```

---

## 4. d11 대조 — 현실 D 가 timeline 에 하는 일

```
   d11 가정    D=19  → 31개월   (배출 lever 단독으로 "걸린다"고 본 값)
   d11b 실측   D=1.5 → 150개월  (배출 단독 = 거의 안 움직임 · 12.5년)
                              ↑ d11 의 31개월은 5× 이상 낙관
```

- 배출 단독(실측 D=1.5): 188개월 → **150개월** (-20%). 여전히 >12년 — **timeline 거의 안 움직임**.
- 그러나 **같은 실측 D=1.5 + bolus 포화 s_sat=0.7** 면: **22개월** ([3] 참조).
  → 배출 lever 의 가치는 *단독* 이 아니라 **s_sat 와 곱(`r_eff = r·(1−s_sat)`)으로 들어갈 때** 나온다.
- 즉 d11 의 "둘을 합치면 ~19개월" 결론은 **D=19 가정에 의존하지 않고도** (D=1.5 만으로도) 거의 유지됨 —
  무거운 일은 **s_sat(동기화 bolus)** 가 하고, 배출은 보조. 31개월(D=19 단독)은 비현실 경로.

---

## 5. 정직한 verdict + tier

| claim | tier |
|---|---|
| r(D)·timeline·delta·r_eff recompute (§3) | 🟢 verbatim |
| `r = k_phago/(k_phago+k_drain)` · 배출↑ → r↓ 방향 | 🔵 closed-form |
| Daflon IV peak +91~191% (x1.9~2.9, 일시) · 빈도↑ · 사람 부종 -수십% | 🟡 문헌 (Cotonat · McHale · Olszewski · NEJM) |
| 림프 pump 예비능 x4~x10 (기계적, 약물분 아님) | 🟡 문헌 (Scallan · 마우스 압력) |
| **지속 경구 D ≈ 1.5x** (배수 아님) | 🟡 문헌-bounded (직접 dermal-tattoo lymph-flow 실측은 없음) |
| dermal tattoo-부위 특이 D · s_sat 절대값 | 🟠 (in-vivo 실측 — M9 통합) |

> **verdict**: 경구 lymphagogue 의 배출-부스트는 **실측-현실 D ≈ 1.2–2.0x (중앙 1.5x)** — d11 이 가정한
> **D=5~19 는 경구로 달성 불가** (그 배수는 IV 일시 peak 또는 림프관 기계적 ceiling 의 값).
> 배출 lever 는 **방향은 진짜지만 단독으로는 약함** (D=1.5 단독 → 150개월, 188개월서 -20%뿐).
> **결론: 배출(D)은 동기화-bolus(s_sat) 및/또는 레이저와 *반드시 병용*해야 의미가 있다.**
> D 를 부풀려선 안 됨 — d11 의 "둘 합쳐 ~19-22개월" 은 실측 D=1.5 에서도 s_sat 가 주도해 성립.
> absorbed=false (in-vivo dermal lymph-flow D + s_sat 직접 실측 미완).

## next
- s_sat (재탐식 포화) ex-vivo 측정 설계 — d11 의 무거운 lever 이므로 우선순위 상향 (M8 통합).
- dermal-부위 특이 lymph-flow D 실측 (문헌은 흉관/사지 부종 · dermal-tattoo 특이 아님).

---

## Sources
- Cotonat A, Cotonat J. *Lymphagogue and pulsatile activities of Daflon 500 mg on canine thoracic lymph duct.* Int Angiol 1989 (PMID 2632644) — peak flow +191%/+171%/+91% @ 12.5/6.25/3.125 mg/kg IV.
- McHale NG, Hollywood MA. *Control of lymphatic pumping: interest of Daflon 500 mg.* Phlebology 1994;9(s1):S23 (sagepub 10.1177/0268355594009001s08) — 분리 소 장간막 림프관 수축빈도↑.
- *A lymphatic function of Daflon 500 mg.* Int Angiol 1995 (PMID 8919263) — 빈도↑ in vitro · lymph flow↑ in vivo.
- Olszewski WL. *Clinical efficacy of MPFF in edema.* Angiology 2000 (PMID 10667640) · MPFF review Curr Vasc Pharmacol 2005 (PMID 15641940) — lymphoscintigraphy half-life/clearance 개선.
- Casley-Smith JR et al. *Treatment of lymphedema of the arms and legs with 5,6-benzo-[α]-pyrone.* NEJM 1993;329:1158 — 팔 46%→26% (정상比); benzo-pyrones Cochrane (PMC8407243) 연 -55%.
- Aesculus/HCSE veinotonic review (PMID 8135874; ScienceDirect Aesculus overview) — 동물 정맥+흉관 림프 flow dose-dependent↑.
- Scallan JP et al. *Lymphatic Vessel Pumping.* (PMID 31183835) — pressure-induced chronotropy; 마우스 popliteal 2→20 min⁻¹ (x10); 사람 hyperthermia x4 reserve.
