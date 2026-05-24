# TTR-ORAL — Path B 심층: 경구 macrophage 이주 가속 (생리적 fade 가속)

> milestone: TTR-ORAL.md M3-ORAL · breakthrough path **B** deep-dive (overview = `oral_feasibility_scope.md` §3-B)
> base: Baranska et al. 2018 (*J Exp Med* 215:1115, PMID 29511065) — capture–release–recapture cycle
> 정직 원칙 (@D d5/d6): "잉크 파괴"가 아닌 **림프절 재배치 (relocation)**. fade 이지 erase 아님. "된다"를 압력으로 강제하지 않음.

## TL;DR

잉크를 화학적으로 분해하지 않는다. 진피 macrophage 의 **emigration (림프 이주)** 을 경구 면역조절로 올리거나 **recapture (재포획)** 를 내려, capture–release–recapture 정상상태를 net clearance 쪽으로 기울인다. 내인성 경로라 전신(경구) 투여와 본질적 호환 — Path A 의 반응성 화학 site-specificity wall 을 회피. 그러나 (a) 잉크는 배출 림프절로 옮겨질 뿐 (림프절 착색 잔존) (b) 완전 소거 아닌 점진 fade (c) 수주–수개월 (d) 전신 면역조절 risk. 1차 판정: 기전 closed-form 🔵, 속도상수 numerical 🟢 (literature-anchored), 임상 efficacy 🟠 deferred.

---

## §1 capture–release–recapture — 왜 잉크가 제자리에 머무나 (Baranska 2018)

```
   진피 정상상태 (steady state · net 이동 ≈ 0)
   ════════════════════════════════════════════
         ┌──── macrophage M_a (잉크 보유) ────┐
         │                                    │
    [capture]                            [death / apoptosis]
         │                                    │
         │                                    ▼
   유리 색소 ◓ ◄──────[release]──────── 죽은 M_a 가 ◓ 방출
   (extracellular pigment)                    │
         │                                    │
         └──────────[RECAPTURE]───────────────┘
              이웃/신규 macrophage M_b 가
              방출된 ◓ 를 즉시 재탐식
              → 같은 자리에서 다시 고정
   ════════════════════════════════════════════
   순효과: macrophage 는 죽고 새로 와도, ◓ 는 "공간적으로" 안 움직임 → 영구성
```

Baranska 의 핵심 실험적 발견 (pulse-chase + macrophage 고갈):
- 진피 잉크는 **개별 macrophage 가 아니라 색소가** 영구적 — 세포는 회전(turnover)하나 색소는 자리 보존.
- macrophage 일시 고갈(예: CSF1R 차단 · DT-mediated) 후 재증식 시에도 색소는 신규 macrophage 에 재포획되어 **위치 유지** (단, 이 고갈→재증식 window 가 레이저 제거의 효율을 올린다고 시사 — 유리 색소 상태에서 외부 개입 용이).

→ **breakthrough 지점**: 영구성을 만드는 단계는 *recapture* (4번 화살표). 이 화살표를 약화하거나, 색소를 든 macrophage 가 재포획 경쟁이 일어나기 전에 **림프로 emigrate** 하도록 만들면 정상상태가 깨진다.

```
   개입 후 (recapture↓ 또는 emigration↑)
   ════════════════════════════════════════════
   유리 색소 ◓ ── (recapture 약함) ──► 미포획 색소 일부
                                        │
   M_a (잉크 보유) ──[emigration↑]──► 배출 림프절(dLN)로 이동 ──► 진피에서 제거
   ════════════════════════════════════════════
   순효과: ◓ 가 진피 → dLN 으로 net flux → 타투 부위 fade (림프절로 relocation)
```

---

## §2 1차 동역학 모델 — ink clearance kinetics

진피 타투 부위 잉크 보유량 N(t) (색소 질량 또는 잉크-load macrophage 수). 세 흐름:

```
   dN/dt = − k_emig · N          (① 림프 이주 = 유일한 진짜 제거 경로)
           − k_death · N + k_recap · k_death · N   (② 사멸 후 재포획: 거의 상쇄)
```

정상상태에서 사멸(release)된 색소의 분율 r = recapture 확률 (Baranska: r ≈ 1 에 매우 가까움 → 영구성). 재포획되지 않은 (1−r) 분율만 자유 색소로 남아 미세하게 dLN 으로 배수. 이를 한 개의 **유효 청소 상수 k_eff** 로 묶으면:

```
   dN/dt = − k_eff · N ,      k_eff = k_emig + (1 − r) · k_death
   ──────────────────────────────────────────────────────────
   N(t) = N₀ · e^(− k_eff · t)
   fade 반감기:  t½ = ln2 / k_eff          [🔵 closed-form]
```

- **k_emig** ↑ (macrophage 가 색소를 들고 dLN 으로 직접 이주) → k_eff ↑ → t½ ↓
- **r** ↓ (recapture 효율 저하 → (1−r) ↑) → k_eff ↑ → t½ ↓
- 자연 fade 의 k_eff 가 작은 이유: k_emig 작음 + r ≈ 1 (recapture 가 거의 모든 release 를 회수)

### §2.1 order-of-magnitude — 자연 vs 가속

자연 타투 fade 는 수년–평생(거의 영구). 임상 관찰상 의미 있는 자연 fade 반감기 t½ ≈ 수년 (보수적으로 5–10 년). 이를 k_eff 로:

| 시나리오 | t½ | k_eff (day⁻¹) | 가정 |
|---|---|---|---|
| 자연 (개입 없음) | ~7 년 | ~2.7×10⁻⁴ | k_emig 미미 · r ≈ 0.99+ |
| emigration 3× boost (S1P/CCR7) | ~2.3 년 | ~8×10⁻⁴ | k_emig 만 3× |
| recapture 차단 (r: 0.99→0.95) + emig 3× | ~10–14 mo | ~1.7×10⁻³ | (1−r) 5× ↑ + emig 3× |
| 적극 (depletion→repopulation window + emig boost) | ~4–7 mo | ~3–5×10⁻³ | r→0.9, emig 5× |

> 정직 표기: 위 숫자는 **literature-anchored order-of-magnitude** (Baranska 의 r≈1 정성 + S1P egress 3-5× rate Cyster 2003). 인간 타투 k_emig 의 직접 측정값은 없음 → t½ 절대값은 🟠 deferred, **상대 단축 비율(ratio)** 만 🟢. 압력으로 "수개월"을 단정하지 않음.

핵심 정성 결론: **r 을 1 에서 조금만 떨어뜨려도 k_eff 가 크게 변한다** — 자연 fade 의 rate-limiting 은 emigration 의 절대 크기가 아니라 **recapture 가 release 를 거의 100% 회수**한다는 점. 따라서 가장 leverage 큰 노브는 *recapture 차단* 또는 *재포획 경쟁 전 emigration*.

```
   t½(개입) / t½(자연) = k_eff(자연) / k_eff(개입)
   ──────────────────────────────────────────────
   예) k_eff 6× 상승 → t½ 7년 → ~14개월 (≈ 1/6)
   timeline: 영구 → 수개월–1년 (fade 시작은 더 빠름, 시각적 onset ≠ 90% clearance)
```

---

## §3 경구 면역조절 레버 (≥3 · mechanism + precedent + 전신 safety)

각 레버를 k_eff 항(k_emig↑ 또는 r↓)에 매핑.

| # | 레버 | 표적 / 분자 | k_eff 효과 | 선례 | 전신 safety 함의 |
|---|---|---|---|---|---|
| **(a)** | macrophage turnover 조절 (CSF1R) | CSF1R 차단 (pexidartinib/PLX 계) · 또는 CSF1 조절 | r↓ — 재포획할 macrophage pool 일시 감소 → 자유 색소 비율↑, 재증식 window 에 dLN 배수 | Baranska: macrophage 고갈→재증식이 색소 재분포 관여 · pexidartinib FDA 승인(TGCT) | **높음** — 전신 macrophage/Kupffer/osteoclast 고갈 → 감염·간효소·골대사 risk. transient·저용량 필수 |
| **(b)** | 림프 emigration 축 (CCR7/CCL21) | CCR7 agonism · CCL21 gradient 강화 (또는 S1P1 modulation) | k_emig↑ — 잉크-load macrophage 가 afferent lymph 로 이주 가속 | CCR7/CCL21 = DC·macrophage→dLN 이주 정설 (Förster 2008) · S1P egress 3-5× (Cyster 2003) | **중–높음** — S1P modulator(fingolimod류)는 전신 림프구 감소·서맥·황반부종 black box. CCR7 직접 agonist 는 임상약 부재 → 🟠 |
| **(c)** | depletion→repopulation timing | clodronate-liposome 류 / CSF1R pulse 후 **재증식 window** | r↓ (window 중 색소 자유 상태) · 외부 보조 개입(레이저) 시너지 | Baranska 명시적 시사: 고갈 후 레이저 제거 효율↑ | (a) 와 동일 risk + timing 의존 — pulse 설계 정밀도 요구 |
| **(d)** | lymphangiogenesis / lymph-flow 지원 | VEGF-C 축 · 림프관 밀도/유속↑ (간접: 운동·온열·압박이 lymph flow↑) | k_emig 의 sink 강화 (dLN 으로의 배수 용량↑) | 림프부종 연구의 VEGF-C 기반 lymphangiogenesis · 림프 마사지로 drainage↑ | 비약물(운동·압박)은 **safety 최상** · VEGF-C 약물은 혈관신생·종양 promotion 우려 🟠 |

### §3.1 경구 호환성 순위 (이 track 의 핵심 평가축)

```
   safety↑·oral-native↑                                 risk↑·정밀도 요구↑
   (d) lymph-flow 지원  ──  (b) CCR7/S1P  ──  (a) CSF1R turnover  ──  (c) depletion pulse
   비약물 가능              경구약 존재         FDA약 있으나 전신독성    timing 정밀 + 외부보조
   ────────────────────────────────────────────────────────────────────────────────
   leverage(k_eff↑)는 (a)(c) 가 큼 ↔ safety 는 (d)(b) 가 우수  →  trade-off
```

> 정직 caveat (전신): 위 레버 모두 **부위 특이성이 없다** — 경구 면역조절은 전신 macrophage/림프계 전체에 작용. "타투 부위 macrophage 만 이주 가속"은 불가. 따라서 site-specificity wall 을 *회피*하는 게 아니라 **"전신 효과를 감내 가능한 수준으로 낮추되 진피 fade 를 얻는 therapeutic window 가 존재하나"** 로 질문이 바뀜 (M6-ORAL 전신 안전이 결정 gate).

---

## §4 정직한 caveat (plainly stated)

| caveat | 내용 | 등급 영향 |
|---|---|---|
| **relocation ≠ destruction** | 잉크는 진피 → 배출 림프절로 *옮겨질* 뿐. **dLN 착색 잔존** (자연 타투의 림프절 색소 침착과 동일 현상, 가속판). 잉크 분자는 사라지지 않음. | efficacy 의 본질적 한계 — "erase" claim 금지 |
| **fade, not erase** | 점진적 옅어짐. 완전 소거(90%+) 도달 여부·시간 불확실. 시각적 onset ≠ full clearance. | 🟠 |
| **slow** | 수주–수개월–년. §2 ratio 가 6× 라도 절대 t½ 가 크면 여전히 길다. | timeline honest |
| **전신 면역조절 risk** | (a)(c) macrophage 고갈은 감염 감수성·Kupffer·osteoclast 영향. (b) S1P modulator 는 림프구감소·심장·황반. **acute·저용량·transient** 로 제한해야 함. | M6-ORAL gate |
| **개인차** | macrophage turnover·림프 유속은 부위·연령·잉크 종류(입자크기) 의존 → fade rate 변동 큼. | numerical 불확실 |
| **하이브리드 시너지** | (c) depletion window 는 레이저 등 외부 개입과 결합 시 가장 강함 — 순수 경구 단독 효과는 약할 수 있음. | path A 와 경계 흐림 |

---

## §5 tier 판정 (per `hexa verify rubric` · 정직 · positive 강제 금지)

| key claim | tier | 근거 |
|---|---|---|
| capture–release–recapture 가 영구성을 만든다 | 🟡 SUPPORTED-BY-CITATION | Baranska 2018 (PMID 29511065) 직접 실험 |
| dN/dt = −k_eff·N → N(t)=N₀e^(−k_eff t), t½=ln2/k_eff | 🔵 SUPPORTED-FORMAL | 1차 ODE closed-form (해석해 자명) |
| r↓ 또는 k_emig↑ 가 t½ 를 단축한다 | 🔵 SUPPORTED-FORMAL | k_eff = k_emig+(1−r)k_death 의 단조성 (∂t½/∂k_emig < 0) |
| 상대 단축 ratio (3×–6× boost) 추정 | 🟢 SUPPORTED-NUMERICAL | S1P egress 3-5× (Cyster 2003) · Baranska r≈1 정성 → ratio numerical |
| 인간 타투 t½ 절대값 (자연 ~7년 → 가속 수개월) | 🟠 INSUFFICIENT/DEFERRED | k_emig·r 인간 직접 측정값 부재 — 절대값은 wet-lab gate (M8/M9-ORAL) |
| 경구 CCR7 agonist / lymph-emigration 약물의 실재성·dose | 🟠 INSUFFICIENT/DEFERRED | CCR7 직접 agonist 임상약 부재 · S1P 류는 black-box safety |
| 전신 면역조절 therapeutic window 존재 여부 | 🟠 INSUFFICIENT/DEFERRED | M6-ORAL 전신 안전 분석에 의존 (이 track 의 결정 gate) |
| relocation→dLN 착색 잔존 (efficacy 한계) | 🟡 SUPPORTED-BY-CITATION | 자연 타투 림프절 색소 침착 = 확립 사실 |

```
   tier 분포:  🔵 2  ·  🟢 1  ·  🟡 2  ·  🟠 3  ·  🔴 0
   ──────────────────────────────────────────────────
   기전·동역학 = 닫힘(🔵/🟡).  속도 ratio = 🟢.
   임상 efficacy·oral 약물 실재성·전신 window = 🟠 deferred.
   → positive verdict 강제 안 함. "기전은 first-principles 상 닫히나,
      경구 efficacy/safety 는 미해결 (가장 oral-native 하나 느림·relocation 한계)"
```

---

## §6 진행 상태 + 다음 (M5/M6-ORAL 입력)

- ✅ capture–release–recapture ASCII + recapture 차단 = breakthrough 지점 식별
- ✅ 1차 kinetic 모델 (k_eff = k_emig+(1−r)k_death · t½=ln2/k_eff) closed-form
- ✅ order-of-magnitude timeline (ratio 🟢 · 절대값 🟠)
- ✅ 4 레버 (a CSF1R · b CCR7/S1P · c depletion-pulse · d lymph-flow) mechanism+precedent+safety
- ✅ relocation/fade/slow/전신risk caveat 명시
- ✅ tier ledger (🔵2·🟢1·🟡2·🟠3) — positive 강제 없음
- next:
  - M5-ORAL — macrophage trafficking PK/PD 시뮬 (k_emig 민감도 · r 차단 정도별 t½ 곡면)
  - M6-ORAL — **전신 면역조절 안전성 (이 track 의 결정 gate)** — (a)(c) macrophage 고갈 전신 독성 정량
  - V2 — t½=ln2/k_eff · ∂t½/∂k_emig<0 단조성 → `hexa verify --expr` + atlas register
