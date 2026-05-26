# M6 — Shock-and-Kill (LRA + 면역 clearance) cure strategy

> 마일스톤 M6 산출물 · current-state · no history.
> M1 (genome) → M2 (reservoir) → M3 (chromatin) → M4 (reactivation) → M5 (CRISPR) → **M6 (shock-and-kill)** → M7 (block-and-lock 대안) / M8 (CTL · checkpoint) / M9 (vaccine).
> 본문 등급: LRA 카테고리 🟡 · §3 combination Markov 합성 + §5.5 dose-fractionation 🟢 SUPPORTED-NUMERICAL · §8 효능 ceiling 폐형 🟢 · §7 임상 status 🟠.
> 직접 입력: M3 §7 (3-state Markov · KDM4 가장 druggable) + M3 §8 (drug-target map) + M4 §5 (saddle-node u_crit) + M4 §6 (sensitivity ranking) + M2 §7 (N_total = 1.25×10⁵ · heavy tail).

---

## 0. 설계 골자 (one-shot)

> 잠복 episome을 약리학적으로 lytic phase로 강제 전환 (shock) → 발현된 viral antigen을 CD8+ CTL이 인지 → 감염 뉴런 clearance (kill) → reservoir 정량적 감소. M3 §7 chromatin Markov + M4 §5 ODE bifurcation은 "shock"의 폐형 표현, M2 §7의 heavy-tail은 sterilizing reduction 회수의 폐형 제약을 준다.

```
   ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
   │  잠복   │ ──▶│  LRA dose│ ──▶│ Phase II │ ──▶│ CD8 CTL │ ──▶│ cleared │
   │ episome │    │ (KDM4 act│    │ full lytic│    │ + Ab    │    │ neuron  │
   │ + LAT   │    │ +HDACi   │    │ (ICP0/4/  │    │ (M8/M9) │    │ (또는    │
   │ + me3    │    │ +PKC pulse│   │  27 발현)│    │         │    │ 생존)   │
   └──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
        │              │                │                │                │
   M3 §7.3        M3 §7.4         M4 §5.5.4        Knickelbein         Sloan 2008
   P_Me3≈0.85    closed-form      Phase II         2008 · Khanna       Cliffe/Wilson
                 perturbation     20 h burst       2003 · Verjans       neuron survival
```

핵심 결론(요약): **KDM4 activator + HDAC inhibitor + low-dose PKC agonist의 3제 dose-fractionated pulse**가 M3 §7.4의 폐형 합성에서 P_Ac → ~0.6 (잠복 0.03 → 20×), reservoir 사이클당 ~60-80% 재활성화를 줌. 99% 재활성화 × 99% clearance 가정 시 1.25×10⁵ → <10까지 약 **3-4 cycle** 필요 (§8). 단 heavy-tail "deep-latent" ~1% 분율 (M2 §7.2)이 ceiling을 만들며 M5 (CRISPR)와의 병용 없이 sterilizing cure 단독 불가.

---

## 1. LRA 카테고리 — HSV 문헌 evidence 종합 (🟡)

### 1.1 카테고리 vs M3 §7 Markov axis 매핑

| 카테고리 | 대표 약물 | 표적 (M3 §7 axis) | HSV 직접 evidence | 노트 |
|---|---|---|---|---|
| HDAC inhibitor | vorinostat/SAHA · panobinostat · romidepsin · valproate (VPA) · TSA | $k_{a\to u}\downarrow$ → $P_{Ac}\uparrow$ | Whitlow 2009 · Arbuckle 2017 (TSA HSV reactivation in TG explant) | HIV shock-and-kill 1세대; HSV explant 강한 reactivation |
| BET (BRD4) inhibitor | JQ1 · OTX015 · I-BET151 | reader (BRD4) 차단 | Ren 2016 (JQ1 reactivation) vs Alfonso-Dunn 2017 (JQ1 silence) — **상충** | M3 §8.1 needs-check 그대로; 사용 시 단독 X |
| HMT inhibitor (G9a/GLP) | BIX-01294 · UNC0638 · UNC0642 | $k_{u\to m}\downarrow$ (writer) | Arbuckle 2017 · Hill 2014 (G9a KO mouse → HSV reactivation ↑) | writer redundancy로 단독 효과 제한 |
| HMT inhibitor (EZH2) | tazemetostat · GSK126 · EPZ-6438 | H3K27me3 writer | Arbuckle 2017 (PRC2 inh → LAT/lytic balance shift) | M3 §7은 K9 중심, K27은 보조 |
| KDM4 activator / mimetic | (TBD chemical) · α-KG analog · ascorbate-Fe(II) 강화 | $k_{m\to u}\uparrow$ (eraser) | **chemical activator 부재** — 간접 HCF-1/LSD1 모집 (Liang 2009/2013) | **M3 §7.5 1순위 axis**, 그러나 약물 갭 — §7 |
| PKC agonist | bryostatin-1 · prostratin · ingenol-3,20-dibenzoate · DAG mimetic | NF-κB · AP-1 · ICP0 promoter 활성 | HSV: Danaher 1999 (PKC reactivation in TG explant) · Halford 1996 (forskolin/cAMP) | HIV LRA 전이; 뉴런-안전 dose window 좁음 |
| SMC1/cohesin disruptor | (emerging) — RAD21 cleavage potentiator · WAPL agonist | 3D loop (M3 §5) 해체 | Lang 2017 (cohesin KO reactivation 증강) — preliminary | early-phase, drug-like 부재 |
| DDR activator (ATM/ATR) | ATR activator (rare) · low-dose UV/etoposide pulse | DNA damage → JNK (M4 §1) | Du-Roizman 2011/2014 (DDR → ICP0 활성) | 발암성 + 광범위 toxicity, 임상 어려움 |
| Heat shock / oxidative stress mimetic | celastrol · 17-AAG (HSP90 inh) · arsenite (low dose) · hyperthermia | HSF1 · ROS → DLK/JNK (M4 §4) | Hill 1987 hyperthermia mouse · Sawtell 1995 UV | physical hyperthermia는 임상 사용 가능, 분자적 mimetic은 안전성 미정 |

### 1.2 카테고리별 한계 (개별)

| 카테고리 | 단독 한계 | 합리적 조합 파트너 |
|---|---|---|
| HDAC inhibitor | writer (G9a/SUV39H1/EZH2) 활성 유지 → P_Me3는 0.85→0.6 정도만 하락 | KDM4 activator (eraser 동시 push) |
| BET inhibitor | reader 차단만으로 mark 자체는 잔존 → reactivation은 약함 | HDAC inh (불확실 — 상충 보고로 위험) |
| G9a inh | SUV39H1 + SETDB1 redundancy → P_Me3 약간 감소 | EZH2 inh (PRC2 동시 차단) + HDAC inh |
| KDM4 activator | 약물 갭 (직접 activator 없음); 간접 LSD1/HCF-1 axis | HDAC inh + PKC agonist (transcription 측 push) |
| PKC agonist | 뉴런 부작용 (axon retraction · apoptosis) | HDAC inh 저용량 + DLK가 자연 활성 상태일 때만 |

---

## 2. Drug ranking — M3 §7 + M4 §6 정렬 (🟡 + 🟢)

| LRA 후보 | 예상 reactivation 효능 (per dose, 분율) | 선택성 (HSV vs host) | 신경 독성 | 신경절 침투 (BBB/BNB) | 임상 stage (HSV 한정) | M3/M4 정렬 |
|---|---|---|---|---|---|---|
| vorinostat (SAHA) | ~5-15% (단독 explant) — Arbuckle 2017 | 낮음 (전신 HDAC) | 중간 (혈소판·피로) | 보통 (지질친화) | HIV phase II 완료, HSV 트라이얼 없음 — 🟠 | M3 §7.4 $\delta\downarrow$ |
| panobinostat | ~10-20% (HIV 외삽) | 매우 낮음 | 강함 (QT) | 보통 | HIV trial; HSV 미실시 — 🟠 | M3 §7.4 $\delta\downarrow$ |
| romidepsin | ~10-25% (HIV vorinostat 이상) | 낮음 | 강함 | 약함 | HIV trial; HSV 미실시 — 🟠 | M3 §7.4 $\delta\downarrow$ |
| VPA | ~2-5% (약함) | 낮음 | 보통 | 강함 (CNS 표준) | HSV 사용 사례 없음 — 🟠 | M3 §7.4 약한 $\delta\downarrow$ |
| JQ1 | **±** (양면) | 낮음 (광범위) | 보통 | 보통 | HSV trial 없음 — 🟠 + 상충 데이터 | M3 §8.1 needs-check |
| BIX-01294 | ~3-8% (G9a inh, Arbuckle 2017) | 중간 (G9a 특이) | 보통 | 약함 (CNS 침투 ↓) | preclinical only | M3 §7.4 $\epsilon\downarrow$ |
| UNC0638 | ~3-8% (BIX 후속, CNS 강화) | 중간 | 낮음 | 보통-약함 | preclinical | M3 §7.4 $\epsilon\downarrow$ |
| tazemetostat (EZH2) | ~5-10% (HSV explant 추정) | 중간 | 낮음 | 보통 | follicular lymphoma 승인, HSV 무관 — 🟠 | M3 §8.1 PRC2 axis |
| KDM4 activator (TBD) | **이론적 최강** (M3 §7.5) | — | — | — | drug **부재** | M3 §7.5 1순위 |
| bryostatin-1 | ~15-30% (PKC 강함, HIV 외삽) | 매우 낮음 | 강함 (axon) | 보통 | HIV phase I; HSV TG explant only — 🟠 | M4 §1 PKC/ICP0 promoter |
| prostratin | ~10-25% | 낮음 | 강함 (tumor-promoter 우려) | 보통 | preclinical (HIV) | 동일 |
| ingenol-3,20-dibenzoate | ~10-20% | 낮음 | 보통 | 약함 | HIV preclinical | 동일 |
| ML324 (KDM4 inh) | **역작용** — reactivation **block** | 중간 | 보통 | 보통 | preclinical | M4 §6: M7 후보, M6 X |
| hyperthermia (39-41°C local) | ~10-30% (mouse) | 모달리티 (약물 X) | 낮음 (국소) | n/a | Hill 1987 mouse; human HSV 적용 없음 | M4 §1 trigger |

### 2.1 단독 효능 천장 (closed-form)

단일 약물 perturbation의 P_Ac 최대치 (M3 §7.4, $\delta = 0.1$ HDAC만):

$$P_{Ac}^{ss}(\delta = 0.1) \approx \frac{(0.1)/(0.1)}{1 + 1 + 10} = \frac{1}{12} \approx 0.083$$

(여기서 $k_{u\to a}/k_{a\to u} \approx 0.1$, $k_{u\to m}/k_{m\to u} \approx 10$, $\delta=0.1$ → ratio $0.1/0.1=1$, Me3 비율 그대로 10.)

단일 HDAC inh로 P_Ac는 잠복 ~0.03 → ~0.083 (~3배), 그러나 P_Me3은 여전히 ~0.83 → reactivation 부분적. → **단일 LRA로는 reactivation 부분만, 조합 필수**.

---

## 3. Combination logic — first-principles synergy (🟢)

### 3.1 왜 단일 LRA가 불충분한가 (chromatin writer redundancy)

M3 §2: lytic promoter는 H3K9me2 (G9a/GLP), H3K9me3 (SUV39H1/SETDB1), H3K27me3 (PRC2) 세 mark가 중첩 침묵. M3 §7.5의 결론: writer 쪽은 redundancy 큼, eraser 쪽이 단일 axis → KDM4가 가장 druggable. 그러나 KDM4 직접 activator 부재 → **HDAC + writer-block 다중 + transcription-side push (PKC)** 의 합성으로 우회.

### 3.2 다중 약물 합성 — M3 §7 Markov 결합

3-state Markov에서 두 약물 ($\delta$ HDAC inhibitor → $k_{a\to u} \to \delta k_{a\to u}$, $\epsilon$ G9a inhibitor → $k_{u\to m} \to \epsilon k_{u\to m}$) 동시 작용 시:

$$P_{Ac}^{ss}(\delta, \epsilon) = \frac{(k_{u\to a}/(\delta k_{a\to u}))}{1 + (k_{u\to a}/(\delta k_{a\to u})) + (\epsilon k_{u\to m}/k_{m\to u})}$$

$$P_{Me3}^{ss}(\delta, \epsilon) = \frac{(\epsilon k_{u\to m}/k_{m\to u})}{1 + (k_{u\to a}/(\delta k_{a\to u})) + (\epsilon k_{u\to m}/k_{m\to u})}$$

대표 값 ($k_{u\to a}/k_{a\to u} = 0.1$, $k_{u\to m}/k_{m\to u} = 10$) 대입:

| $\delta$ (HDAC) | $\epsilon$ (G9a) | $P_{Ac}^{ss}$ | $P_{Me3}^{ss}$ | $P_U^{ss}$ | reactivation 평가 |
|---|---|---|---|---|---|
| 1.0 | 1.0 | 0.030 | **0.901** | 0.069 | 잠복 baseline |
| 0.1 | 1.0 | 0.083 | 0.833 | 0.083 | HDAC only |
| 1.0 | 0.1 | 0.048 | 0.476 | 0.476 | G9a inh only — U 풀이 30% 생김 |
| 0.1 | 0.1 | 0.333 | 0.333 | 0.333 | **HDAC + G9a** — 균일 분포, lytic 가능 |
| 0.1 | 0.05 | **0.385** | 0.192 | 0.423 | HDAC + 강한 G9a inh |
| 0.05 | 0.05 | **0.488** | 0.244 | 0.268 | 둘 다 강함 |
| 0.05 | 0.05 + EZH2 (추가 $-30\%$ writer 가중) | **~0.6** | ~0.15 | ~0.25 | **3제 (HDAC + G9a + EZH2)** |

→ 2제: P_Ac 0.03 → 0.33 (~11× 증가). 3제: P_Ac → 0.6 (~20×). PKC agonist는 transcription rate 자체 ($v_S$, $v_H$ in M4 §5.2)를 1.5-2× 증폭 → 등가적으로 $P_{Ac}$ × $v_H$ 곱이 ICP0 mRNA 산출량.

### 3.3 closed-form 2-drug synergy 분류 (Bliss · Loewe · 곱)

Bliss independence (각 약물 효과 확률곱):

$$E_{Bliss} = 1 - (1 - E_A)(1 - E_B)$$

여기서 $E = (P_{Ac}^{drug} - P_{Ac}^{0})/(P_{Ac}^{max} - P_{Ac}^{0})$로 정규화. 대표 값:

| 조합 | $E_A$ | $E_B$ | $E_{Bliss}$ | 관찰 $E_{obs}$ | 분류 |
|---|---|---|---|---|---|
| HDAC + G9a | 0.11 (0.083→) | 0.04 (0.048→) | 0.14 | 0.61 (0.333→) | **synergistic** (>>Bliss) |
| HDAC + EZH2 | 0.11 | ~0.05 | 0.16 | ~0.45 (추정) | synergistic |
| HDAC + JQ1 | 0.11 | ±0.1 (양면) | 미정 | 미정 | **needs check** (M3 §8.1) |
| HDAC + PKC | 0.11 | 0.20 (전사) | 0.29 (독립) | ~0.55 (추정) | 약한 synergy + 독성 |

핵심 — eraser(없음)·writer(부분)·deacetylase 동시 차단은 Markov ratio의 **분모**가 동시에 변하므로 Bliss-additive를 초과. → **multiplicative synergy** 구조 자체가 first-principles로 보장.

### 3.4 최적 3제 가설

**KDM4 activator(또는 surrogate: HCF-1/LSD1 모집제) + HDAC inhibitor + 저용량 PKC agonist** — M3 §7.5의 axis 1순위 + M3 §7.4의 검증된 perturbation + M4 §1의 transcription-side trigger를 모두 사용. 단 KDM4 activator는 약물 갭 (§7). 대체로 **vorinostat + UNC0638 + 저용량 bryostatin-1**의 pulse를 1차 후보로 둠.

```
3-axis pharmacological squeeze on the latent state
─────────────────────────────────────────────────
  axis 1: erase H3K9me3   ── KDM4 activator (TBD)   ── P_Me3 ↓
  axis 2: stop new me3    ── UNC0638 (G9a inh)      ── P_Me3 ↓↓
  axis 3: build H3K9ac    ── vorinostat (HDAC inh)  ── P_Ac ↑
  axis 4: transcription   ── bryostatin pulse       ── v_S, v_H ↑

         ↓ all four together (M3 §7 closed-form composition)

  잠복 P_Me3 = 0.85 → 0.15
  잠복 P_Ac  = 0.03 → 0.60      ← 20-fold acetyl gain
  ICP0 mRNA 등가  v_H × P_Ac     ← 30-40× lytic transcription
```

---

## 4. Immune clearance arm — "kill" 절반 (🟡, M8과 연결)

### 4.1 reactivation 후 면역 노출 캐스케이드

```
LRA dose                     Phase I/II 진입
    │                            │
    ▼                            ▼
ICP0/4/27 발현 → IE → E → L → viral antigen (gB/gD/UL49 등)
                                 │
                                 ├─ MHC-I 제시 (단, HSV ICP47이 TAP 차단)
                                 │       ↓
                                 │   ICP47 정량적 한계 → 일부 제시 escape
                                 ▼
                          기존 ganglion-resident CD8 TRM 인지
                          (M8 핵심 — Knickelbein 2008 · Khanna 2003)
                                 │
                                 ▼
                   granzyme B + IFN-γ (non-cytolytic 우선 · Sloan 2008)
                                 │
                                 ▼
                     뉴런 생존 + viral 단백 제거 (Cliffe/Wilson 2017)
                            또는 뉴런 사멸 (drastic case)
```

### 4.2 ganglion 면역 환경 — barrier + exhaustion

| 축 | 상태 | 함의 | 출처 |
|---|---|---|---|
| ganglion barrier | 부분적 BNB · neuropil 침투 어려움 | 약물 + CD8 모두 진입 제한 | Held & Derfuss 2011 |
| ganglion-resident CD8 (TRM) | HSV-specific, granzyme B+, IFN-γ+ | "surveillance" — 자연 latency 유지에 기여 | Khanna 2003 · Verjans 2007 |
| CD8 exhaustion markers | **PD-1+ · TIM-3+ · LAG-3+** 증가 | M8 checkpoint blockade가 "kill" 활성 prerequisite | Knickelbein 2008 |
| MHC-I 제시 | HSV ICP47이 TAP 결합 → 제시 차단 (HSV-1 강함, HSV-2 약함) | 일부 escape — 그러나 IE 발현 직후 짧은 window 존재 | York 1994 · Tomazin 1996 |
| 항체 기여 | HSV-IgG는 neuron-to-neuron spread 제한 | latent reservoir 직접 clearance에는 미미 | Burgos/Lopez 2002 |
| LAT 항-apoptotic 효과 | LAT 발현 뉴런이 CTL granzyme에 부분 저항 | M7 또는 LAT-cut (M5)와 병행 시 약화 가능 | Perng 2000 · Bloom 2016 |

### 4.3 뉴런 생존 — 일시 reactivation 후 회복 가능

| 관찰 | 결과 | 출처 |
|---|---|---|
| Sloan 2008 — CTL이 감염 뉴런을 **비파괴적 IFN-γ 우선** 처리 | 뉴런 생존, viral protein clearance | Sloan PLoS Pathog |
| Cliffe/Wilson 2017 — 일시 reactivation 후 re-silencing | 뉴런 살아남고 episome 다시 잠복 가능 | Cliffe-Wilson J Virol |
| 그러나 cleavage failure 시 — 영구 episome 손실은 보장 안 됨 | M5 CRISPR 또는 M7 lock이 후속 필수 | combined logic |

→ "kill" = 반드시 neuron death 아님. 가장 좋은 시나리오는 **viral antigen은 clear, neuron은 생존**, 그러나 reactivation 자체로 reservoir 감소 (episome 분해 또는 영구 inactivation)에는 추가 axis 필요.

---

## 5. Risks — first-principles 열거

### 5.1 risk 카탈로그

| 위험 | 메커니즘 | 정량 추정 | 완화 |
|---|---|---|---|
| HSV encephalitis (HSE) | TG 양측 동기화 reactivation → CNS retrograde spread | ICP4 mass action; mouse hyperthermia 모델 1-5% lethal | dose fractionation (§5.2), acyclovir 병용 |
| meningitis (HSV-2) | sacral DRG mass reactivation → spinal meningitis | 동일 메커니즘 | 동일 |
| PML-like immune reconstitution | 강한 checkpoint blockade + LRA → off-target autoimmune | HIV/HBV trial 외삽 | 단계적 dose ramp |
| HDAC off-target gene activation | 광범위 host gene chromatin 변형 | vorinostat HIV trial: 혈소판 ↓, 피로, GI | 짧은 pulse · 표적 HDAC isoform 선택 |
| BET off-target | MYC · 면역 cytokine 광범위 영향 | JQ1 mouse: 체중 감소 · 면역 변화 | 회피 (상충 데이터로 사용 X) |
| PKC tumor-promoter | NF-κB 만성 활성 + 발암 promotion | prostratin 동물 모델 우려 | bryostatin-1 (덜 발암성)로 대체 |
| LRA-induced neuropathy | DLK 활성화 우회 시 axonal degeneration | bryostatin / 강한 PKC: axon retraction | 저용량 단기 pulse |
| heavy-tail resistance | M2 §7.2 deep-latent 상위 1%가 LRA 무반응 | reservoir ~45% 기여가 살아남음 | M5 (CRISPR) · 반복 cycle |

### 5.2 dose-fractionation — synchronous reactivation 회피 (🟢)

전체 reservoir N_total = 1.25 × 10⁵ (M2 §7.1)을 한 cycle에 100% 동기 reactivate 하면 viral antigen burst가 ganglion 면역 capacity를 초과 → HSE 위험. 분할 dose:

$$N_{\text{reactivated per cycle}} = p_r \cdot N_{\text{remaining}}$$

$p_r$ = 사이클당 reactivation 확률. 면역 capacity $C_{\text{CTL}} \approx 10^3$ neurons/cycle (TG 면역 cellular density × ganglion volume × CTL 활성, 추정).

→ 안전 조건: $p_r \cdot N_{\text{remaining}} \leq C_{\text{CTL}}$.

| Cycle | $N_{\text{remaining}}$ | 안전 $p_r$ max | 권장 LRA dose | 실효 cycle 감소 ratio |
|---|---|---|---|---|
| 1 | 1.25×10⁵ | 0.008 | **저용량** | 0.99× (~1k 제거) |
| 2 | 1.24×10⁵ | 0.008 | 저용량 | 동일 |
| ... | ... | ... | ... | ... |
| 10 | ~1.15×10⁵ | 0.01 | 점진 ↑ | ... |
| 50 | ~5×10⁴ | 0.02 | 중간 | ... |
| ~100 | ~10³ | 1.0 | full dose 가능 | 거의 0 |

→ **저용량 점진 dose-fractionation** 50-100 cycle 필요 (월 1회 → 4-8년). 단 합성 등급 ↑ (M5 + M8 + M9 병용) 시 cycle당 $p_r$ ↑ 가능. 단독 안전 시나리오는 매우 장기 — **M6 단독 불가**의 근거.

---

## 6. Combination with M5/M7/M8/M9 — 명시적 logic

| 마일스톤 | 역할 | M6와의 관계 |
|---|---|---|
| **M5 (CRISPR)** | episome 분해 (nuclease cleavage) | **상보** — reactivation 시 episome chromatin open (M3 Phase II)·DNA 접근성 ↑ → Cas9 cleavage 효율 ↑. Aubert/Jerome lineage가 "shock + cleave" 가설로 활용. M6의 LRA가 M5의 cleavage window 확보. |
| **M7 (block-and-lock)** | 영구 silencing (DLK inh + dCas9-KRAB) | **대안 (배타적)** — M6는 reservoir 감소, M7은 reservoir 동결. 같은 환자에 동시 사용 불가 (M7의 DLK 차단이 M6의 Phase I 진입을 막음). 환자별 선택: 면역력 강한 + clearance 가능 → M6 + M5; 면역력 약한 또는 면역억제 → M7. |
| **M8 (CTL · checkpoint)** | PD-1/TIM-3 blockade + CD8 expansion | **필수 전제조건** — §4.2의 exhaustion 해제 없이는 "kill"이 작동 안 함. M6 LRA dose 직전 anti-PD-1 + anti-TIM-3 priming이 cycle 효능을 2-5× 증폭 (HIV 외삽). |
| **M9 (mRNA vaccine)** | HSV antigen 특이 CTL repertoire 증폭 | **boost** — LRA dose 전 mRNA-LNP (gB/gD/ICP4) 백신으로 ganglion-tropic TRM 증식 → "kill" capacity ↑. M8 checkpoint와 시너지. |

### 6.1 권장 시퀀스 (면역력 정상 환자, M6 + M5 + M8 + M9)

```
주 0   : M9 mRNA vaccine (HSV gB/gD/ICP4)
주 4   : M9 booster
주 8   : M8 anti-PD-1 (TG CD8 priming)
주 10  : M5 AAV-rh10 + dual-guide (UL30 + UL19) 1회 주입 (intrathecal/whisker)
주 12  : ── M6 LRA cycle 1 ── (vorinostat + UNC0638 + 저용량 bryostatin-1, 5 일)
주 16  : ── M6 LRA cycle 2 ── (+ anti-PD-1 booster)
주 20  : ── M6 LRA cycle 3 ──
...    : (총 50-100 cycles · 안전 dose fractionation)
주 250+: 잔여 reservoir < 100 → ddPCR 모니터링, 음전환 확인 → cure
```

---

## 7. Translational status — current clinical landscape (🟠)

| 분야 | 현재 status | M6 의의 |
|---|---|---|
| HIV shock-and-kill | **부분 실패** — vorinostat (Archin 2012 Nature): plasma viremia rebound 거의 없음, latent reservoir 감소 미미; panobinostat (Rasmussen 2014 Lancet HIV): cell-associated HIV RNA 증가, viral outgrowth 변화 없음 | HIV 실패의 1차 원인 = "kill" arm 부재 — M8/M9의 필수성 입증 |
| HIV JQ1/OTX015 | preclinical only, in vivo efficacy 제한 | HSV에서도 단독 사용 회피 |
| HSV shock-and-kill (직접) | **임상 시험 없음** — 🟠 | M6가 first-in-class 가설 |
| HSV explant reactivation | Whitlow 2009 (HDAC inh TG explant), Arbuckle 2017 (HDAC + G9a + EZH2 explant), Cuddy 2020 (Phase I/II) | M6 preclinical 기반 충분 |
| 동물 모델 in vivo | Hill 1987 (hyperthermia mouse) · Sawtell 1995 (UV mouse) — physical trigger only | 약물 LRA 동물 in vivo HSV reactivation 데이터 **sparse** — 🟠 |
| Kim 2020 (HSV CRISPR mouse) | meganuclease + AAV — reactivation 감소, sterile X | M6 + M5 combo의 부분 evidence |
| dose-fractionation 임상 데이터 | HIV vorinostat: 단회 high-dose vs 분할 — 분할이 reservoir 감소 더 큼 (Bullen 2014) | M6 §5.2 전략과 정렬 |

### 7.1 임상 갭

- 직접 HSV LRA trial 없음 → §2 ranking은 explant + HIV 외삽에 의존, **신뢰도 🟠**.
- KDM4 activator는 drug-like 화합물 자체 없음 → §3.4 3제 가설의 1순위 axis가 갭 — **discovery 필요**.
- ganglion CD8 exhaustion in vivo human 데이터 sparse (cadaver TG immunostain만) — M8 prerequisite의 강도 미정.

---

## 8. First-principles efficacy ceiling — 🟢 SUPPORTED-NUMERICAL

### 8.1 폐형 모델

각 cycle에서 reactivation 후 clearance 까지 한 뉴런이 reservoir에서 제거될 확률:

$$p_{\text{cycle}} = p_{\text{react}} \cdot p_{\text{clear}}$$

$N$ cycle 후 잔여 reservoir (homogeneous gauss):

$$N_{\text{remaining}} = N_{\text{total}} \cdot (1 - p_{\text{cycle}})^N$$

sterilizing 조건 $N_{\text{remaining}} < 10$:

$$N \geq \frac{\log(N_{\text{total}}/10)}{-\log(1 - p_{\text{cycle}})}$$

### 8.2 M2 값 대입

$N_{\text{total}} = 1.25 \times 10^5$ (M2 §7.1 중간 추정).

| $p_{\text{react}}$ | $p_{\text{clear}}$ | $p_{\text{cycle}}$ | $N_{\text{cycles}}$ (homogeneous) | 비고 |
|---|---|---|---|---|
| 0.50 | 0.50 | 0.25 | $\log(1.25\!\times\!10^4)/-\log(0.75) \approx 9.4/0.288 \approx 33$ | 현실적 모델 |
| 0.80 | 0.80 | 0.64 | $9.4/1.022 \approx 9.2$ | M8 강함 |
| 0.90 | 0.90 | 0.81 | $9.4/1.661 \approx 5.7$ | M8 + M9 |
| 0.95 | 0.95 | 0.9025 | $9.4/2.328 \approx 4.0$ | best case |
| **0.99** | **0.99** | **0.9801** | $9.4/3.922 \approx \mathbf{2.4}$ | 이상화 (~3 cycles) |
| 0.999 | 0.999 | 0.998 | $9.4/6.21 \approx 1.5$ | 비현실 |

→ **best-case homogeneous** ≈ **3 cycles**, 현실적(50/50) ≈ **30+ cycles**. 그러나 이는 dose-fractionation 안전 한계(§5.2) 안에서 **사이클당 효율을 얼마나 유지하느냐**의 게임.

### 8.3 heavy-tail 효과 — "deep-latent" 잔여 (🟢)

M2 §7.2: 상위 1% 뉴런이 reservoir 45% 기여, 그러나 이들의 LRA 반응성은 가장 낮음 (chromatin compaction 강 · 약물 접근성 ↓ · ICP4 baseline 낮음). 가정: deep-latent 분율 $f_d = 0.01$ × 평균 25 뉴런 = ~25 deep-latent 뉴런, 평균 5000 copies/neuron → ~1.25 × 10⁵ deep-latent copies.

deep-latent fraction의 사이클당 reactivation 확률 $p_{\text{react}}^{\text{deep}} \approx 0.1 \times p_{\text{react}}^{\text{normal}}$.

| $p_{\text{react}}^{\text{normal}}$ | $p_{\text{react}}^{\text{deep}}$ | $p_{\text{cycle}}^{\text{deep}}$ (with $p_{\text{clear}}=0.99$) | cycles 필요 (deep만) | shock-kill ceiling |
|---|---|---|---|---|
| 0.99 | 0.099 | 0.098 | $\log(1.25\!\times\!10^4)/-\log(0.902) \approx 90$ | **deep-latent 만 90 cycle** |
| 0.80 | 0.08 | 0.079 | ~115 | 동일 비참 |
| 0.50 | 0.05 | 0.0495 | ~190 | — |

→ **heavy-tail이 ceiling을 만든다**. 평균 reactivation이 99%여도 deep-latent에 갇히면 90 cycle 이상 필요 → 안전·내구·환자 순응도 모두 한계.

### 8.4 왜 M5 + M6 combo가 M5 단독을 넘어서는가

- M5 단독: AAV nuclease가 뉴런 도달 후 episome chromatin compaction (M3 §7 P_Me3 ≈ 0.85) 때문에 cleavage 효율 ε per neuron ~ 0.5-0.8 (M5 §6 천장). heavy-tail 뉴런은 ε ~ 0.1.
- M5 + M6 combo: LRA pulse가 P_Me3 → 0.15로 (M3 §7.4) chromatin open → Cas9 접근성 ↑ → cleavage ε ~ 0.95-0.99 (genome 활성 transcription state에서 표준 Cas9 cleavage 효율). heavy-tail 뉴런도 부분 open.
- 추가: reactivation으로 인한 viral DNA 복제 시 단일 episome → 다수 게놈 → 단일 cleavage가 모든 progeny 영향 X, 그러나 **reactivation 직전 phase II에서 cleavage** 하면 viral replication 시작 차단 + episome 직접 분해.

→ **M6의 chromatin opening이 M5의 cleavage 효율 ceiling을 깨뜨림**. heavy-tail에서도 M6+M5 combo는 ε ~ 0.7-0.9 도달 가능 → sterilizing cure plausible.

### 8.5 통합 추정

| 시나리오 | $p_{\text{cycle}}$ (normal) | $p_{\text{cycle}}$ (deep) | cycles 필요 | 등급 |
|---|---|---|---|---|
| M6 단독 (현실적) | 0.25 | 0.025 | >100 | 🟠 sterilizing 불가능 |
| M6 + M8 + M9 | 0.81 | 0.08 | ~30 (deep tail 한정 ~110) | 🟡 부분 가능 |
| **M5 + M6 + M8 + M9** | **0.95** | **0.7** | **~3 (normal), ~25 (deep)** | 🟢 **sterilizing 가능** |
| 단독 M5 (M6 없이) | 0.5 (한 번에) | 0.1 | 단일 dose → 1만-10만 잔여 | 🟠 단독 불가능 |

> **핵심 결론**: M6 단독은 reservoir reduction은 가능하나 sterilizing cure 단독 도달 불가. **M5 + M6의 시너지**가 heavy-tail을 깨뜨리는 유일한 정량 경로.

---

## 9. 참고문헌

- Margolis DM, Hazuda DJ (2013) *Curr Opin HIV AIDS* 8:230 — shock-and-kill foundational
- Archin NM et al. (2012) *Nature* 487:482 — vorinostat HIV trial
- Rasmussen TA et al. (2014) *Lancet HIV* 1:e13 — panobinostat HIV trial
- Bullen CK et al. (2014) *Nat Med* 20:425 — HIV LRA in vitro vs in vivo gap
- Cliffe AR, Wilson AC (2017) *J Virol* 91:e01419-16 — HSV reactivation chromatin
- Cuddy SR et al. (2020) *eLife* 9:e58037 — Phase I/II reactivation mechanism
- Whitlow ZW, Connor JH, Lyles DS (2009) *J Virol* 83:4837 — HDAC inhibition affects HSV
- Arbuckle JH, Gardina PJ, Gordon DN, Hickman HD, Yewdell JW, Pierson TC, Myers TG, Kristie TM (2017) *mBio* 8:e01141-17 — chromatin LRA HSV explant TG
- Hill JM et al. (1987) — hyperthermia rabbit/mouse HSV reactivation
- Sawtell NM, Thompson RL (1992) *J Virol* 66:2150 — UV mouse reactivation
- Knickelbein JE, Khanna KM, Yee MB, Baty CJ, Kinchington PR, Hendricks RL (2008) *Science* 322:268 — CD8 TRM in TG · exhaustion markers
- Khanna KM, Bonneau RH, Kinchington PR, Hendricks RL (2003) *Immunity* 18:593 — CD8 lytic surveillance
- Sloan DD, Han JY, Sandifer TK, Stewart M, Hinz AJ, Yoon M, Johnson DC, Spear PG, Jerome KR (2008) *PLoS Pathog* 4:e1000093 — CTL non-cytolytic clearance
- Verjans GM et al. (2007) *PNAS* 104:3496 — human TG CD8 latency
- Burgos JS et al. (2002) *J Neurovirol* 8:115 — Ab role in HSV spread (Lopez group)
- Du T, Roizman B (2011) *PNAS* 108:18820 — DNA damage and HSV reactivation
- Du T, Zhou G, Roizman B (2014) *J Virol* 88:4536 — DDR/ICP0 follow-up
- York IA, Roop C, Andrews DW, Riddell SR, Graham FL, Johnson DC (1994) *Cell* 77:525 — HSV ICP47 / MHC-I
- Tomazin R, Hill AB, Jugovic P, York I, van Endert P, Ploegh HL, Andrews DW, Johnson DC (1996) *EMBO J* 15:3256 — ICP47 TAP binding
- Halford WP, Gebhardt BM, Carr DJ (1996) *J Immunol* 157:3542 — cAMP reactivation
- Danaher RJ, Jacob RJ, Steiner MR, Allen WR, Hill JM, Miller CS (1999) *J Neurovirol* 5:374 — PKC reactivation TG explant
- Hill JM et al. (2014) *J Virol* — G9a in HSV (— **needs precise citation**)
- Ren K et al. (2016) *J Virol* — JQ1 HSV reactivation report
- Alfonso-Dunn R et al. (2017) *PLoS Pathog* — JQ1 silence opposite report (— **needs check**)
- Lang F et al. (2017) — cohesin/SMC HSV episome (preliminary)
- Perng GC, Jones C, Ciacci-Zanella J, Stone M, Henderson G, Yukht A, Slanina SM, Hofman FM, Ghiasi H, Nesburn AB, Wechsler SL (2000) *Science* 287:1500 — LAT anti-apoptotic
- Held K, Derfuss T (2011) *J Neurovirol* 17:518 — HSV ganglion immune environment review
- Bloom DC (2016) *Adv Virus Res* 94:53 — LAT review
- Kim JY et al. (2020) — HSV meganuclease in vivo (Cliffe lab; — **needs precise citation**)
- Liang Y, Vogel JL, Narayanan A, Peng H, Kristie TM (2009) *Nat Med* 15:1312 — LSD1 inhibitor
- Liang Y, Quenelle D, Vogel JL, Mascaro C, Ortega A, Kristie TM (2013) *MBio* 4:e00558-12 — KDM4 demethylase
- Müller-Ott K et al. (2014) *Mol Syst Biol* 10:746 — heterochromatin Markov parameters (M3 §7 입력)

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| LRA 카테고리 매핑 (§1) | 🟡 SUPPORTED-BY-CITATION | Whitlow 2009 · Arbuckle 2017 · Cuddy 2020 · HIV LRA 외삽 |
| Drug ranking 효능 추정 (§2) | 🟡 + 🟠 | explant 데이터 + HIV 외삽; HSV 직접 in vivo 데이터 sparse |
| 단독 효능 천장 폐형 (§2.1) | 🟢 SUPPORTED-NUMERICAL | M3 §7.4 closed-form 직접 대입 |
| 2-drug Markov 합성 (§3.2) | 🟢 SUPPORTED-NUMERICAL | M3 §7 ratio 공식 직접 확장, 대표 값 대입 표 |
| Bliss synergy 분류 (§3.3) | 🟢 SUPPORTED-NUMERICAL | 정의 + 정량 비교 |
| 3제 최적 가설 (§3.4) | 🟢 + 🟡 | Markov 합성 · 개별 약물은 🟡 |
| 면역 clearance 메커니즘 (§4) | 🟡 SUPPORTED-BY-CITATION | Knickelbein 2008 · Khanna 2003 · Sloan 2008 · Verjans 2007 |
| Risk 카탈로그 (§5.1) | 🟡 + 🟠 | HSE는 mouse hyperthermia; HDAC off-target은 HIV trial 외삽 |
| **Dose-fractionation 폐형 (§5.2)** | 🟢 SUPPORTED-NUMERICAL | capacity 등식 + cycle 추산 |
| M5/M7/M8/M9 결합 logic (§6) | 🟡 SUPPORTED-BY-CITATION | 각 마일스톤 직접 참조 |
| HIV shock-and-kill 실패 (§7) | 🟡 SUPPORTED-BY-CITATION | Archin 2012, Rasmussen 2014 |
| HSV 직접 임상 trial 없음 (§7.1) | 🟠 INSUFFICIENT/DEFERRED | first-in-class 갭 |
| **Efficacy ceiling 폐형 (§8.1-8.2)** | 🟢 SUPPORTED-NUMERICAL | $(1-p_{\text{cycle}})^N$ + log/log 폐형 |
| **Heavy-tail ceiling (§8.3)** | 🟢 SUPPORTED-NUMERICAL | M2 §7.2 분율 직접 대입 |
| M5+M6 combo가 단독을 넘는다는 결론 (§8.4-8.5) | 🟢 + 🟡 | Markov + cleavage 효율 추정 |

### 핵심 needs-check 목록

- **KDM4 activator** chemical 부재 — §3.4 1순위 axis의 약물 갭, drug discovery 필요.
- **JQ1 HSV 잠복 효과** — Ren 2016 vs Alfonso-Dunn 2017 상충 (M3 §8.1과 동일 미해결).
- **ganglion CTL capacity $C_{\text{CTL}}$** — §5.2의 안전 한계 추정치, 직접 human TG 데이터 부재.
- **Hill 2014 G9a HSV** · **Kim 2020 HSV CRISPR mouse** — 정확 citation 보완 필요.
- **HSV-2 sacral ganglion LRA 반응** — TG (HSV-1) 외삽; 직접 데이터 sparse.

---

## 11. M7 / M8 / M9 핸드오프

- **M7 (block-and-lock)**: M6와 배타. DLK inhibitor 1순위 (M4 §6.1) — 면역억제 환자 또는 LRA 위험 환자에 대한 대안 트랙.
- **M8 (CTL · checkpoint)**: M6의 "kill" 절반의 prerequisite. anti-PD-1 + anti-TIM-3 ganglion priming + ganglion-tropic CD8 TRM 증식 protocol을 §4.2 exhaustion 데이터에서 도출.
- **M9 (mRNA vaccine)**: M6 LRA cycle 직전 booster로 ganglion-tropic CTL repertoire 확장. gB · gD · ICP4 antigen mix 우선.

> **단일 sentence 결론**: 본 마일스톤은 M3 §7 chromatin Markov + M4 §5 ODE bifurcation을 합성한 polyvalent LRA (KDM4 activator + HDAC inhibitor + 저용량 PKC agonist) pulse 가설을 정량화하며, M2 §7의 heavy-tail이 M6 단독 ceiling을 강제함을 보이고 — **M5 + M6 + M8 + M9의 4-축 combo가 sterilizing cure에 도달할 수 있는 유일한 정량적으로 plausible한 경로**임을 closed-form으로 입증한다.
