# TTR-ORAL — BP1d: 레이저 + 경구 fade-보조 병용 (세션 수 단축)

> 🦠 **TTR-ORAL** — "면역세포 택배"
> BP1 deep-dive 가 **가장 credible near-term** 으로 지목한 **BP1d (레이저-병용)** 정량.
> 핵심 가설: 레이저가 색소 **단편화+방출**(고 per-session release)을 담당하고, 경구 보조제는
> 재포획 **r↓** (drainage↑ · 약한 phagocytosis 둔화) → 세션당 클리어런스 c 상승 → **세션 수 감소**.
> sim = `sim/bp1d_laser.hexa`. @D d6 — 낙관 강제 금지(베이스라인을 문헌 6-10세션에 캘리브레이션).

---

## 1. 표준 레이저 제거 — 기전 · 문헌 수치 (🟡)

| 항목 | 문헌값 | 출처 |
|---|---|---|
| 기전 | Q-switched / picosecond **광음향 단편화** (photoacoustic) — 색소를 더 작은 입자로 파쇄 | PMC4411594 · MDPI 2021 |
| 완전제거 세션 수 | **6-10 세션** (90%+ 클리어런스), **6-8주 간격** | allenmedicalaesthetics · MDPI |
| pico 클리어런스 | **2세션 후 평균 61%** · 40%가 >75% 개선 · 완전제거는 ~30%만 | PMC11322294 |
| 세션당 클리어런스(역산) | 90%까지 ~8세션 ⇒ 세션당 유효 **~25-30%** | (lit 6-10에서 캘리브레이션) |
| **병목** | 방출 단편이 인접/신규 macrophage 에 **재포획**(re-phagocytosis) — **경구 모델과 동일한 r 단계** | **Baranska 2018 (JEM)** |
| 간격 효과 | **긴 간격일수록 클리어런스↑** (림프 배출에 시간 필요) | ResearchGate 2024 · mikemurphyblog |
| R20 (4-pass) | 1세션 다중패스 = 단일패스보다 우월 (3개월 후 특히) | astanzalaser · ScienceDirect |

### Baranska 의 직접 제안 (BP1d 의 lit 근거)
> *"Tattoo removal can be likely improved by combining laser surgery with the **transient ablation
> of the macrophages** present in the tattoo area"* — 단편이 즉시 재포획되지 않으면 **림프로 배출**될
> 확률↑. ⇒ **레이저(release) + recapture 차단(r↓)** 시너지는 원저자가 직접 지목한 경로. (JEM 2018)

```
표준 레이저 1세션 사이클 (r0 ≈ 0.70, 표준진료가 이미 부분 배출 실현)
  ●●●●●●●●  잉크 덩어리
     │ 레이저 펄스 (광음향 단편화)
     ▼
  · · · · · ·  작은 단편 방출 (phi_rel ≈ 0.83 파쇄/방출)
     │
     ├─ (1-r)=0.30 → 림프 배출 ✓ 클리어 (세션당 c≈0.25)
     └─    r =0.70 → macrophage 재포획 ✗ 잔류 (다음 세션 대기)
  ⇒ 90%까지 ~8세션
```

---

## 2. 시너지 모델 — r↓ 가 세션당 클리어런스 c 를 올린다

```
per-session clearance:  c(r) = phi_rel · (1 − r)
    phi_rel = 세션당 단편화/방출 분율 (레이저가 결정 · 캘리브레이션 0.83)
    (1 − r) = 방출 색소 중 재포획을 피해 배출되는 분율 (경구 보조제가 r↓로 올림)
sessions-to-90%:  N = log(0.1) / log(1 − c)
```

- **레이저** = release 이벤트 제공 (phi_rel 고정 · 고방출). **경구 보조** = r↓ (drainage↑ / 약한 둔화).
- 캘리브레이션(정직): 표준진료는 6-8주 간격에 림프 배출이 이미 부분 작동 → 레이저-베이스라인
  유효 재포획 **r0_laser ≈ 0.70** (resting-skin 경구 모델의 0.95 아님 — 단편은 작고 간격에 배출됨).
  r0=0.70 이 ~8세션이 되도록 phi_rel=0.83 캘리브레이션 → 문헌 6-10세션 정합.

---

## 3. hexa-native recompute (verbatim · 🟢)

```
=== TTR-ORAL BP1d: laser + oral r-down -> sessions-to-90%-clearance ===

phi_rel (per-session release fraction) =0.83
c(r) = phi_rel*(1-r) ; N = log(0.1)/log(1-c)
calibration: r0_laser=0.70 -> ~8 sessions (lit standard 6-10)

r(recapture)   1-r      c(per-session)   N_sessions   note
  0.70        0.3  0.249  8.04117  STANDARD laser (no adjunct, calibrated)
  0.60        0.4  0.332  5.707  weak oral assist
  0.50        0.5  0.415  4.29472  moderate (Baranska transient-ablation)
  0.40        0.6  0.498  3.34117  strong oral assist
  0.30        0.7  0.581  2.647  very aggressive r-down

[reduction] standard r=0.70 -> N =8.04117 sessions
            oral r=0.50     -> N =4.29472 sessions
            absolute cut    =3.74645 sessions
            fold speedup    =1.87234x fewer sessions

[timeline @ 7-week spacing] months = N * 1.6
  standard r=0.70 :12.8659 months
  oral r=0.50     :6.87155 months
  oral r=0.40     :5.34587 months

=== vs oral monotherapy ~2-6 yr (no laser release): laser+adjunct = a few mo ===
```

---

## 4. 정직한 발견 — 세션 수 단축곡선

```
   r (재포획)    N_sessions (90% 클리어)        포지션
   0.70 표준  ████████ 8.0세션 (~12.9mo)      레이저 단독 (baseline)
   0.60       ██████ 5.7세션 (~9.1mo)         약한 경구 보조
   0.50       ████ 4.3세션 (~6.9mo)           중간 (Baranska 천장)
   0.40       ███ 3.3세션 (~5.3mo)            강한 경구 보조
   0.30       ███ 2.6세션 (~4.2mo)            매우 공격적 (이론적)
```

- ✅ **r 0.70→0.50 (현실적 보조 목표) → 세션 8.0 → 4.3 = ~3.7세션 감소 (1.9× 단축)**.
  타임라인 ~12.9개월 → ~6.9개월. **r↓ 가 BP1과 동일하게 dominant lever** 임을 병용에서도 확정.
- ✅ **레이저의 결정적 이점**: 경구 단독은 release 이벤트가 자연 capture-release(~90일 느림)뿐
  → 多年. 레이저가 **고방출**(phi_rel≈0.83)을 한 번에 제공 → 같은 r↓ 가 **多年이 아닌 수개월**로.
- ⚠ **정직한 경고 — 경구 r↓ agent 격차는 BP1과 동일**:
  - 무른(inert) 잉크 단편 재포획 = **scavenger-receptor(MARCO/SR-A) + actin-의존 일반 phagocytosis**
    (FcγR/항체 매개 아님). fostamatinib(경구 Syk) 의 잉크-β 는 낮을 가능성(wrong arm) — BP1 결론 동일.
  - **drainage↑ 경로**가 더 깨끗한 lever: 림프흐름↑ → effective r↓ (잉크 수용체 무관). 단 강력 경구
    림프촉진제는 임상 미확립(🟠).
  - **Imiquimod** (국소 면역활성제) human RCT = **음성** (clearance 3.2 vs 위약 2.9, NS · ineffective 결론).
    ⇒ 국소 보조의 직접 전례는 실패 — 경구 r↓ 보조도 **실측 전 과신 금지**. (Dermatol Surg 2007)
- ⚠ **모델 한계**: phi_rel·r 은 캘리브레이션 파라미터(절대값 미실측) · c(r) 선형 1차근사 · 세션당
  r 이 잔여 잉크 깊이/색에 의존하는 비균질성 미반영. 단축 *비율*(1.9×)은 phi_rel 에 둔감(견고).

---

## 5. tier + verdict

| claim | tier |
|---|---|
| c(r)·N recompute | 🟢 verbatim |
| 표준 6-10세션 · pico 61%/2세션 · 6-8주 간격 | 🟡 문헌 (MDPI · PMC11322294) |
| 재포획 = 동일 r 병목 · Baranska "laser + transient ablation" 제안 | 🟡 Baranska 2018 JEM |
| 긴 간격 → 클리어↑ · R20 다중패스 | 🟡 문헌 (ResearchGate · astanza) |
| r 0.70→0.50 → 8.0→4.3세션 (1.9× 단축) | 🔵/🟢 (모델 · lit-캘리브레이션) |
| 경구 r↓ agent 高-β (scavenger-receptor) · drainage↑ 경구제 | 🟠 (agent 부재 · imiquimod 전례 음성) |

> **BP1d verdict (정직한 포지셔닝)**:
> - **레이저-병용이 가장 credible near-term 제품** ✅ — 이유: ① 레이저가 release 병목을 즉시 해결
>   (경구 단독의 多年 → 수개월), ② r↓ 보조는 **세션 수를 절반(8→4)** 으로 줄이는 명확한 부가가치
>   ("같은 결과를 절반의 시술·기간·비용으로"), ③ Baranska 원저자가 직접 지목한 경로 = 기전 신뢰.
> - **단, 약효의 핵심 미해결 = 경구 r↓ agent** 는 BP1과 동일 격차(scavenger-receptor 길항 / 강력
>   경구 림프촉진제 임상 미확립) + **국소 보조(imiquimod) human 전례는 음성** → 효능 *크기*는 🟠 미실측.
> - 정직한 한 줄: **"수년 경구 단독 monotherapy" 보다 "레이저 + 경구 보조로 세션 절반" 이 훨씬
>   현실적인 진입 제품.** 단 r↓ 보조의 실효 β 는 wet-lab 으로 확정해야 함. absorbed=false 유지.

### 권고 (near-term product)
**예 — 레이저-병용(BP1d)이 추천 near-term 제품.** 경구 단독(多年)은 lead 가 아니라 장기 비전.
1차 임상가설: **드레이니지-부스트 경구 보조 + 표준 pico 레이저 → 세션 8→4 (~13mo→~7mo)**, 1차
엔드포인트 = 90% 클리어 세션 수. imiquimod 음성 전례를 감안해 r↓ 메커니즘은 receptor-무관
drainage↑ 우선 (잉크 scavenger-receptor wrong-arm 회피).

---

## Sources
- Q-switched laser-tissue interaction (photoacoustic fragmentation) — *PMC* 4411594 (pmc.ncbi.nlm.nih.gov/articles/PMC4411594)
- Picosecond QS Nd:YAG, 2세션 61% 클리어 · skin type IV — *PMC* 11322294 (pmc.ncbi.nlm.nih.gov/articles/PMC11322294)
- Picosecond 1064/532nm single-center experience (세션 수) — *MDPI Appl Sci* 11(20):9712 (mdpi.com/2076-3417/11/20/9712)
- Baranska et al. 2018, *J Exp Med* — capture-release-recapture · "combine laser + transient macrophage ablation" 제안 (rupress.org/jem/article/215/4/1115) · ScienceDaily 2018-03-06
- 긴 간격 → 클리어런스↑ (12-patient case series) — ResearchGate 382870895 · mikemurphyblog 2024-08-04
- R20 method (4-pass 단일세션) — astanzalaser.com · *J Am Acad Dermatol* (ScienceDirect S0190962211008152)
- Imiquimod adjuvant human RCT (음성, 3.2 vs 2.9 NS) — *Dermatol Surg* 2007 (journals.lww.com) · dermatologytimes.com
