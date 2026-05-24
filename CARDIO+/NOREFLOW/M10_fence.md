# M10 — ⚪ honest fence (V1 subset · NOREFLOW SPECULATION-FENCED 영역 분류)

> 마일스톤 M10 산출물 · current-state · no history.
> 출처 = V1 master inventory §6 subset 추출 → ⚪ SPECULATION-FENCED 항목 단독 deep declaration.
> 목적 = "본질적 closed-form 미가능 영역"을 honest 명시 — 효능 가설 강제 산식 변환을 방지.

---

## 1. ⚪ SPECULATION-FENCED 정의 (g5 rubric verbatim)

```
⚪ SPECULATION-FENCED — 본질적 closed-form 미가능 영역의 가설/권고/가치판단
  · metaphor (비유)
  · 미래 trial readout 의존 (prognostic)
  · 가중치/우선순위의 가치판단 (subjective scoring)
  · 가설적 권고 (effect-size 미정 path 추천)
  · future infrastructure / consortium 제안
  
  → 시뮬레이션·산식·meta-regression으로 환원 불가
  → "honest 명시"로 절차적 정직성 확보 (산식 forcing 금지)
```

**대비**:
- 🟡 SUPPORTED-BY-CITATION = peer-review 1차 출처 carry 가능
- 🟠 INSUFFICIENT/DEFERRED = wet-lab/임상 readout 후 검증 가능 (deferred → 🟡/🟢/🔵 가능)
- ⚪ SPECULATION-FENCED = **본질적으로 검증 불가** (closed-form 자체 미가능 / 가치판단)

---

## 2. fence 적용 기준

### 2.1 본질적 closed-form 미가능 5 카테고리

| # | 카테고리 | NOREFLOW 사례 | 산식화 불가 이유 |
|---|---|---|---|
| **C1** | **metaphor (비유)** | M2 "재관류 첫 5분 lethal window는 차에서 안전벨트 매기" | 비유는 직관 전달만, 산식 = mPTP open prob ODE (별도 🔵) |
| **C2** | **가설적 권고 (path recommendation)** | M7 §4 3-path "신호 강도 ★★/★★★" · Trial-A/B/C 효과 가설 | path별 effect-size 미래 임상 readout에 의존 |
| **C3** | **subjective tier 분류 (가중치 자의성)** | M6 Tier-A/B/C · M7 5-axis 30/20/25/15/10 | 효능 vs safety vs 한국 vs 단계 가중치는 가치판단 |
| **C4** | **prognostic 진술 (외부 사건 인과)** | M8 "한국 first-in-class 기회" · M7 "글로벌 가이드라인 영향" | "기회/영향" = 인과 외삽 (미래 timing · 경쟁자 행동 의존) |
| **C5** | **future infrastructure / trial readout** | HORIZON · OCEAN(a) · NICORADENO-MVO · UPFRONT-STEMI readout | 미래 임상 결과 — 현 시점 비검증 |

### 2.2 fence 결정 흐름

```
claim
   │
   ▼
산식 / identity / closed-form 변환 가능?
   ├── YES → 🔵 (atlas register 가능) 또는 🟢 (시뮬레이션 재현)
   └── NO  → 다음 질문
              │
              ▼
            citation으로 carry 가능?
              ├── YES → 🟡
              └── NO  → 다음 질문
                         │
                         ▼
                       wet-lab/임상 readout 후 검증 가능?
                         ├── YES → 🟠 (deferred)
                         └── NO  → ⚪ fence
                                   (본질적 검증 불가)
```

---

## 3. NOREFLOW ⚪ fence 영역 표 (9 items + 6 metaphor sub-items)

### 3.1 핵심 9 fence claim (V1 §6에서 추출)

| # | source | claim | 카테고리 | fence 이유 |
|---|---|---|---|---|
| **F1** | M6 §6 | Tier-A/B/C 분류 (효능+safety 균형 자의적) | C3 | 효능 가중치 vs safety 가중치 = 가치판단 |
| **F2** | M7 §1 | 5-axis 가중치 30/20/25/15/10 | C3 | 5축 상대 중요도 = 가치판단 (Monte Carlo robustness는 🟢 별개) |
| **F3** | M7 §4 | 3-path 권고 신호 강도 ★★/★★★ | C2 | path별 outcome 미래 임상 의존 (effect-size 미정) |
| **F4** | M7 §5.2 | Trial-B NMN-PRECON 효과 가설 (NAD+ → IRI ↓) | C2, C5 | future trial readout · pilot 진행 전 |
| **F5** | M7 §5.3 | Trial-C DERWIRE-PRECLIN frontier 가치 (drug-eluting wire) | C2, C5 | preclinical · sponsor 부재 · 가설 |
| **F6** | M7 §6 | Gate-1/2/3 decision gates trajectory (2027-2028) | C5 | prospective trajectory · 행동 결정 |
| **F7** | M8 §5 | 한국 IMR-guided RCT "first-in-class 기회" | C4 | prognostic ("기회" = 인과 외삽) |
| **F8** | M9 §7 | 신규 d2 path (STING inh · 다축 차단 · PPARα reposition · ALDH2 personalized) | C2 | preclinical 단계 · IRI 임상 0건 · 가설 |
| **F9** | M9 §8 | RFC 신규 endpoint (T1 mapping · DT-CMR · HOST-IRI consortium) | C5 | future infrastructure 제안 (실현 미정) |

### 3.2 metaphor sub-items (C1 카테고리 6)

문서 본문에 자연스럽게 사용된 비유 표현 — 산식화 강제하지 않음.

| # | source | metaphor | 사용 의도 (산식 별도 존재) |
|---|---|---|---|
| **M1** | M2 §1 | "재관류 첫 5-10분이 lethal window" — 시간 개념을 "window/창"으로 비유 | 직관 전달 / mPTP open prob ODE는 🔵 별개 |
| **M2** | M1 §1 | "epicardial 동맥은 뚫렸는데 하류 심근 관류는 회복 안 되는" — 큰 길 vs 골목 비유 | 직관 / TIMI3 + MBG≤1 산식은 🔵 별개 |
| **M3** | M3 §5 | "small Ph2 (positive) → large Ph3 (neutral)" 깔때기 비유 | 직관 / meta-regression은 🟢 별개 |
| **M4** | M4 §6 | "diamond" trade-off ASCII (IC+synced 꼭대기, IV systemic 바닥) | 시각화 / Cmax ratio 산식은 🔵 별개 |
| **M5** | M9 §3 | "다축 cell-death" (apoptosis · necrosis · pyroptosis · ferroptosis · necroptosis fan) | 분류 도식 / 각 축 개별 메커니즘은 🟡 carry |
| **M6** | M7 §4 | "d2 wall" 자체 — 4건 RCT neutral을 "벽"으로 비유 | 도메인 d2 governance 비유 / 4 trial 데이터는 🟡 |

→ metaphor는 문서 가독성 자산 · 산식화 강제하지 않음 (산식은 별도 🔵/🟢에서 보유).

---

## 4. fence 영역별 honest declaration

### 4.1 F1 — Tier-A/B/C 분류 (M6 §6)

> Tier-A (adenosine IC · nicorandil · MTP-131) 추천은 효능과 safety **둘 다 우수한 약물**을 손꼽았다는 합의 진술이다.
> 그러나 "효능과 safety 사이의 trade-off 가중치"는 가치판단 — Tier-B → Tier-A 경계 (NTP · verapamil cusp at 3.95)는 가중치 0.05 perturbation으로도 뒤바뀐다.
> Monte Carlo robustness는 🟢 도달 (M12/V3) — 그러나 가중치 자체는 ⚪ fence.

### 4.2 F2 — 5-axis 가중치 30/20/25/15/10 (M7 §1)

> efficacy 30% · delivery 20% · safety 25% · korea 15% · phase 10% — 본 가중치는 NOREFLOW @goal ("PCI 직후 차단 + IRI 보호 후보 short-list")에 맞춰 NOREFLOW 도메인이 선택한 가치 우선순위다.
> 다른 도메인 (예: 만성 secondary prevention · 비용 효과)에서는 다른 가중치가 합리적 — 본 가중치 자체에 "객관적 정당성"을 주장하지 않는다.
> Monte Carlo 1000-run robustness (🟢) → top 후보 안정성 검증 가능 · but baseline 가중치 = ⚪ fence.

### 4.3 F3 — 3-path 권고 신호 강도 ★★/★★★ (M7 §4)

> Path A (NIM811 + NAD+/NMN) ★★ · Path B (nicorandil + adenosine + IMR-guided) ★★★ · Path C (drug-eluting catheter) ★★ — 본 별점은 **현 단계 가용 evidence 강도 + 한국 capacity + 단계 risk 종합**한 NOREFLOW 도메인 판단이다.
> 각 path별 실제 outcome (NMN → IRI ↓ %, nicorandil+adenosine → MVO ↓ %, drug-eluting → infarct ↓ %) 은 미래 임상 readout에 의존 — 신호 강도 ★ 수 자체는 ⚪ fence.

### 4.4 F4 — Trial-B NMN-PRECON 효과 가설 (M7 §5.2)

> "NAD+ supplement 7일 precondition → SIRT3 활성 → CypD K166 deacetyl → mPTP threshold ↑ → IRI ↓" — 본 인과 사슬은 전임상 mechanism + supplement gray-zone activity 가설.
> NMN dose-response · human ischemic time 효과는 임상 데이터 없음 (한국 IRB-light pilot 진행 전).
> Trial-B readout (Gate-1, 2027 Q4) **전까지는 ⚪ fence** — readout 후 🟢 (positive surrogate) 또는 🔴 (null) 분기.

### 4.5 F5 — Trial-C DERWIRE-PRECLIN frontier 가치 (M7 §5.3)

> Drug-eluting reperfusion catheter (NIM811-PLGA coated wire · paclitaxel DCB 변형 · MTP-131 microemulsion) = M2 §4 Path B 본격 path.
> 가치 = lethal window (5분) 안에서 drug delivery + balloon inflation 동기화로 PK gap 해결.
> 그러나 현재 단계: Wu 2015 preclinical prototype · 동물 in-vivo 데이터 부분적 · sponsor 부재.
> "잠재력 ★★★"는 **이론적 path 가치** — 실현은 동물 capacity + 디바이스 제조 + IND + Ph1 후. ⚪ fence.

### 4.6 F6 — Gate-1/2/3 decision gates trajectory (M7 §6)

> 2026 Q2 ~ 2028 Q4 timeline + Gate-1 (NMN interim) · Gate-2 (Trial-A primary) · Gate-3 (animal readout).
> 본 trajectory는 NOREFLOW 도메인이 제시한 **prospective 행동 계획** — 실제 enrollment 속도, IRB timing, MOU 체결, funding 결정은 외부 사건에 의존.
> "decision gates" 시점 자체가 ⚪ fence — 의사결정 자체가 prospective.

### 4.7 F7 — 한국 IMR-guided RCT "first-in-class 기회" (M8 §5)

> "글로벌 IMR-guided cause-stratified RCT 부재 + 한국 ~10개 IMR 기관 capacity → first-in-class 기회".
> 본 진술의 두 사실 (글로벌 부재 + 한국 capacity)은 🟡 (citation + 학회 등록).
> "기회" 자체는 prognostic — "한국이 진입하면 글로벌 영향력 확보 가능"은 인과 외삽 (timing · 경쟁자 · funding · readout 모두 의존).
> ⚪ fence — 인과 외삽 부분만.

### 4.8 F8 — 신규 d2 path (STING inh · 다축 차단 · PPARα · ALDH2 personalized) (M9 §7)

> M9 §7 신규 d2 path 4종:
> (1) 다축 cell-death 동시차단 (mPTP + ferroptosis + necroptosis)
> (2) STING inhibitor IRI window (H-151 · C-176 pre-PCI IV)
> (3) PPARα activator fenofibrate IRI reposition
> (4) ALDH2*2 genotype-personalized BH4 / sapropterin
> 모두 preclinical 단계 · IRI 임상 0건 · 가설 path.
> 각 path별 mechanism은 🟡 (M9 §3 mechanism evidence) · "임상 적용 가능성"은 ⚪ fence.

### 4.9 F9 — RFC 신규 endpoint (T1 mapping · DT-CMR · HOST-IRI consortium) (M9 §8)

> RFC 5종:
> (1) T1 mapping native + ECV (LGE 한계 보완)
> (2) DT-CMR (myocardial fiber disarray)
> (3) Post-PCI HF risk ML model
> (4) HOST-IRI consortium (Korean multi-center)
> (5) IMR + CFR 결합 PCI 가이드
> 본 RFC는 NOREFLOW 도메인 제안 — 실현은 학회 합의 · funding · 인프라 빌드.
> 5년 plan **제안** 자체가 ⚪ fence — RFC adoption은 외부 행동에 의존.

---

## 5. NOT-fenced 영역 (∼citation 또는 closed-form 보유)

⚪ fence와 혼동되기 쉬운 NOREFLOW claim 중 **NOT-fenced** 명시 — 산식 또는 1차 출처 보유.

| claim | source | 등급 | NOT-fence 이유 |
|---|---|---|---|
| M1 4-cause framework (DE · VS · ED · IR) | M1 §2 | 🟡 | Niccoli 2009 *EHJ* primary carry (framework consensus) |
| M2 후보 list (14 candidate · 5 family) | M2 §2 | 🟡 | inventory factual carry |
| M2 d2 wall 4-trial neutral (CIRCUS · CYCLE · EMBRACE · MITOCARE) | M2 §3 | 🟡 | NEJM/JACC/EHJ primary carry (사실) |
| M3 REOPEN-AMI MVO 14% vs 35% | M3 §2.1 | 🟡 | JACC primary carry |
| M4 5-tier delivery 분류 | M4 §1 | 🟡 | Niccoli 2016 review carry |
| M5 IMR cutoff > 40 U | M5 §2.1 | 🟡 → 🔵 | Fearon 2003 closed-form (M11/V2 atlas) |
| M5 CMR infarct size = validated surrogate | M5 §4 | 🟡 → 🟢 | Stone 2016 n=2632 patient-pool (M12/V3 Cox recompute) |
| M6 5-domain safety classification | M6 §1 | 🟡 | pharmacovigilance carry |
| M6 CIRCUS safety = placebo (단회 IV) | M6 §2 | 🟡 | NEJM safety primary carry |
| M6 nicorandil ulcer 0.5-2% long-term | M6 §3 | 🟡 | ENABLE pharmacovigilance carry |
| M7 Tier-A 3약물 임상 시나리오 (24mg adenosine · pre-PCI nicorandil · MTP-131 1h infusion) | M7 §3.1 | 🟡 | guideline + RCT 시나리오 carry (시나리오 자체는 fact) |
| M8 KAMIR-NIH n>20,000 · IMR capacity 10 기관 | M8 §1, §4 | 🟡 | Sim 2017 + 학회 carry |
| M9 EMPACT-MI HR 0.90 NS (acute SGLT2i 가설 falsify) | M9 §2 | 🔴 | NEJM 2024 primary carry — falsified |
| M9 CLEAR SYNERGY HR 0.99 NS (acute colchicine falsify) | M9 §2 | 🔴 | TCT 2024 primary carry — falsified |
| M9 Korean nicorandil 6mo neutral · CHIPS-PCI 6mo neutral | M9 §5 | 🔴 | Heart 2023 · Lancet 2023 primary carry — falsified |

→ **NOT-fenced 영역은 V1 §2 master 표에서 🟡/🟢/🔵/🔴 등급으로 분류 — M10 fence와 분리.**

---

## 6. g5 grade 표 (M10 자체 검증)

| 항목 | 등급 | 근거 |
|---|---|---|
| ⚪ rubric 정의 (§1) | 🟡 | NOREFLOW.md `## verify` schema verbatim |
| fence 적용 기준 C1-C5 (§2) | 🟡 | NOREFLOW 도메인 분류 합의 (V1 master subset) |
| 9 핵심 fence claim 추출 (§3.1) | 🟡 | V1 §6 verbatim subset |
| 6 metaphor 식별 (§3.2) | 🟡 | M1-M9 본문 추출 |
| 9 honest declaration (§4) | ⚪ | declaration 자체는 절차 — fence subject가 ⚪ |
| NOT-fenced 영역 (§5) | 🟡 | citation 보유 fact |
| metaphor 비-fence ruling | 🟡 | NOREFLOW 도메인 결정 (metaphor 자산화) |

### 6.1 분포 요약

```
M10 ⚪ fence 영역 9 핵심 + 6 metaphor sub-item = 15 항목

   카테고리        count
   ─────────────────────
   C1 metaphor      6
   C2 hypothetical  4 (F3 · F4 · F5 · F8)
   C3 subjective    2 (F1 · F2)
   C4 prognostic    1 (F7)
   C5 future infra  2 (F6 · F9)
                   ──
                   15
```

### 6.2 V1 inventory 흡수 효과

| 효과 | 값 |
|---|---|
| V1 master 72 claims 중 ⚪ 후보 | 9 (12.5%) |
| 추가 metaphor sub-item | 6 (산식 강제 방지) |
| 잘못된 산식 강제 방지 | ★★★ — Trial-B/C effect-size · 5-axis 가중치 절대값 등 |
| 절차적 정직성 (honest verdict) | ★★★ — "본질적 검증 불가" 영역 명시 |

---

## 7. M10 산출 요약

- **9 핵심 ⚪ fence claim** + **6 metaphor sub-item** = 15 항목 honest declared.
- **카테고리 분포**: C1 metaphor 6 · C2 hypothetical 4 · C3 subjective 2 · C4 prognostic 1 · C5 future infra 2.
- **NOT-fenced 명시**: 14 claim — citation 또는 closed-form 보유 (산식 강제 방지의 역방향 안전장치).
- **V1 흡수**: V1 §6 9 항목 verbatim + metaphor 6 식별 + NOT-fenced 14 분리.
- **g5 grade**: rubric 정의·기준·추출은 🟡, declaration 자체는 ⚪ (절차적 정직성).

→ 다음 단계: V2 (🔵 push) · V3 (🟢 push)에서 M10 fence 영역을 절대 산식 강제 변환하지 않음. V4 final tier ledger에서 9 fence + 6 metaphor가 honest line으로 명시 기록.
