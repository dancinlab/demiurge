# TTR-ORAL — 경구 타투 제거 feasibility scope (M1-ORAL)

> 질문: **"먹어서" 타투를 지울 수 있나?** (알약/음료 등 경구 섭취 · 바늘 없음 · 도포 없음)
> 정직 원칙 (@D d5/d6): "된다"를 압력으로 강제하지 않음. 3 track 중 가장 어려운 길임을 명시하고, 그럼에도 @D d2 에 따라 돌파 경로를 제시.

---

## 1. 왜 타투는 영구적인가 (TTR base M1 흡수)

```
표피 (epidermis)  ~100 μm   ┌─────────────────┐  ← 자연 탈락, 잉크 여기 없음
                            │ · · · · · · · · │
진피 (dermis)  500-2000 μm  │  ◓ ◓   ◓  ◓ ◓   │  ← 잉크 거주 지대
                            │ macrophage 가    │
                            │ 잉크(◓) 탐식·고정 │
피하 (subcutis)             └─────────────────┘
```

- 잉크 입자: 40-300 nm 응집체 (carbon black · 유기 안료 · 금속 산화물)
- 진피 macrophage 가 탐식 → 세포 내 고정
- **capture–release–recapture 사이클** (Baranska et al. 2018, *J Exp Med*):
  macrophage 사멸 → 색소 방출 → 이웃/신규 macrophage 즉시 재포획 → **제자리 영구 고정**
- 일부 잉크는 배출 림프절로 이동 (타투 림프절 착색 = 자연 fade 의 느린 경로)

---

## 2. 경구 track 의 핵심 wall — 부위 특이성 (site-specificity)

세 track 의 본질적 차이:

| 축 | TTR-CREAM (바름) | TTR-MN (붙임) | **TTR-ORAL (먹음)** |
|---|---|---|---|
| 도달 경로 | 피부 위 → SC 투과 | 바늘 → 진피 직접 | 위장관 → 혈류 → **전신** |
| 작용 부위 | 국소 (도포 면적) | 국소 (패치 면적) | **전신 (whole-body)** |
| 부위 특이성 | 높음 | 매우 높음 | **본질적으로 없음** ← wall |
| 전신 독성 risk | 낮음 | 낮음 | **최대** |

> 핵심: 잉크를 녹이려면 산화·효소 절단 등 **반응성 화학**이 필요. 이를 전신 투여해 어디서나 활성화되면 모든 조직(피부·간·신경·혈관)을 공격. 타투는 ~10-100 cm² 국소인데 약은 60-70 kg 전신에 퍼짐 → **"전신 약을 어떻게 타투에서만 작동시키나"가 풀어야 할 벽.**

### ADME 정량 직관 (M2-ORAL 에서 정식화)
경구 dose → GI 흡수(F_abs) → 간 first-pass(F_g·F_h) → 전신 혈중 → 진피 모세혈관 분배 → 잉크 든 macrophage 도달.
진피는 혈류가 풍부하나, 잉크 든 macrophage 표적 농도는 전신 분포 부피에 희석됨. 표적 도달 분율은 작고, 그 작은 분율을 키우려 dose 를 올리면 전신 노출(독성)이 비례 상승 → **therapeutic window 가 좁다.**

---

## 3. 돌파 경로 (@D d2 — 벽 앞에서 포기 금지 · 구체 경로 ≥ 3)

### ⭐ A) Pro-drug + 외부 국소 활성화 (spatial gating) — 최우선
- 불활성 **pro-drug** 를 경구 → 전신에 무해하게 분포
- **타투 피부 패치에만** 외부 trigger 국소 적용 → 그 자리에서만 활성형 전환:
  - 빛 (photo-uncaging · caged compound)
  - 집속 초음파 / 온열 (sonodynamic · thermal uncaging)
  - **잉크 자체를 광증감제로** — 기존 레이저가 잉크에 흡수 → 국소 열/ROS → 인접 pro-drug 활성화 (잉크가 있는 곳에서만 반응 ⇒ 자기 표적화)
- whole-body → localized 전환으로 부위 특이성 wall 정면 돌파
- 선례: 5-ALA → PpIX 광역학치료(PDT) pro-drug, caged 화합물군
- 정직 caveat: 외부 trigger 가 필요하므로 "순수 경구"가 아닌 **hybrid** (먹는 약 + 시술). 그래도 침습/도포 없이 "먹는 약 + 빛 쪼임"이면 사용자 체감은 경구 중심.

### ⭐ B) Macrophage 이주 가속 — 가장 "경구다운" 생리적 경로
- 잉크를 *분해*하지 않음. 대신 진피 macrophage turnover + 림프 trafficking 을 경구 면역조절로 자극 → macrophage 가 잉크를 배출 림프절로 운반·청소 (자연 fade 의 가속판)
- 내인성 청소 경로를 쓰므로 전신 투여와 본질적으로 호환
- 선례: Baranska 2018 — macrophage 일시 고갈/재증식이 색소 재분포에 관여, 레이저 제거 보조 가능성 시사
- 정직 caveat: 잉크 **파괴가 아닌 림프절 재배치** (림프절 착색 잔존) · 완전 소거 아닌 점진적 fade · 느림. 안전성은 면역조절 전신 효과 의존.

### C) Lymphatic-targeted lipid formulation
- 경구 지질기반 제형 (chylomicron-hitchhiking) → 장 림프관 경유 → 전신 림프계. 잉크 함유 림프와 동선 일부 겹침.
- 정밀도 A < · 표적화 약함. lymphatic 경로 PK 가 M5-ORAL 시뮬 대상.

### D) Ink-homing 경구 흡수 나노입자
- 잉크 표면 화학(carbon/melanin 친화)에 결합하도록 functionalize 한 경구 흡수 NP → 잉크 밀집부 수동 축적
- 투기적: **경구 NP bioavailability 자체가 2차 wall** (위장관 통과·흡수율 낮음)

---

## 4. 정직한 1차 판정 (per @D d5/d6)

- "직접 잉크 분해 경구약" (전신 활성 반응성 화학): **🟠 INSUFFICIENT** — 부위 특이성 wall + 전신 독성으로 therapeutic window 미확보 (현 시점 calc path 미정)
- 신뢰 가능한 경구 경로:
  - A) pro-drug + 외부 활성화 → **가장 유망** (단, hybrid)
  - B) macrophage 이주 가속 → **가장 oral-native** (단, 재배치·fade 한계)
- 결론: 경구 track 은 3 track 중 가장 어렵고 위험. 그러나 A/B 두 경로는 first-principles 상 닫히지 않음 → M2 (ADME 정량) · M3 (돌파경로 정식화) · M6 (전신 안전) 으로 진행해 honest absorbed 또는 honest 🟠 closure 까지 driven.

---

## 다음 (M2-ORAL 입력)
- 경구 BA fraction · 진피 도달 농도 PBPK closed-form (V2 → `hexa verify --expr`)
- A 경로 pro-drug photo-uncaging 양자수율 후보 (M5 TDDFT)
- B 경로 macrophage clearance 1차 kinetics 모델
