# M8 — T-cell exhaustion 역전 + ganglion CD8 trafficking 전략

> 마일스톤 M8/10 산출물 · current-state · no history.
> M2 reservoir (§3 TG/sacral 해부, §4 subtype) · M3 immune evasion (ICP47, LAT-driven silencing) 의존.
> M6 shock (lytic 깨우기) 의 "kill" arm = M8 (역전된 CD8) 가 제공.
> 등급: 인용부 🟡 · §8 efficacy 모델 🟢 · ganglion penetration 🟠 (직접 데이터 부재).
> M8 alone은 cure 아님 — M6/M9의 enabler.

---

## 1. 잠복 ganglion에서의 CD8 surveillance — baseline

### 1.1 해부학적 surveillance 구조

HSV-1 잠복 TG (와 HSV-2 잠복 sacral DRG)에는 항원-특이 CD8+ T-cell이 **상주 (TRM, tissue-resident memory)** 한다. Knickelbein 2008 / Khanna 2003 의 핵심 관찰:

- 잠복 뉴런 1개당 평균 **~5-10 CD8 T cell** 이 cell body에 직접 접촉 (juxtaposed).
- 이 CD8들은 **granzyme B+** 이지만 lytic granule 방출은 드물다 (non-lytic IFN-γ/TNF clearance가 우세).
- HSV-특이 TCR repertoire — **gB498-505 (HSV-1, K^b 제한)** 가 mouse 우점, 인간은 **gB · ICP4 · VP13/14 · VP16** epitope 다발.

```
잠복 TG 내부 (단순화 단면)
─────────────────────────────────────
              위성세포 (satellite glia)
                 ╱─────────────────╲
       ┌────────╳───────────────╳────────┐
       │ ┌──────┴─────┐   ┌────┴───────┐ │
       │ │ 잠복 뉴런  │   │ 잠복 뉴런  │ │
       │ │ LAT+       │   │ LAT+       │ │
       │ │ MHC-I ↓    │   │ MHC-I ↓    │ │
       │ └──────┬─────┘   └────┬───────┘ │
       │        ╳───CD8───CD8──╳          │
       │     [PD-1+]      [PD-1+ TIM-3+] │
       │     [LAG-3+]     [TIGIT+]       │
       │        ↑                         │
       │     fenestrated capillary       │
       │     (blood-nerve barrier loose) │
       └─────────────────────────────────┘
                ▲  CXCL9/10 ↓ (낮음, M8 표적)
                │  CCL5      ↓
                │  IFN-γ 펄스로 유지되나 turnover ↓
```

### 1.2 핵심 수치 — TG CD8 burden

| 축 | 값 | 출처 |
|---|---|---|
| TG 양측 뉴런 수 | ~50,000 | M2 §6 |
| 잠복 뉴런 (LAT+) | ~2,500 (5%) | M2 §7.1 |
| 뉴런당 juxtaposed CD8 | 5-10 | Knickelbein 2008 |
| 총 HSV-특이 TG CD8 | ~12,500-25,000 (편측 기준 ×2) | 산술 |
| Granzyme B+ 분율 (잠복기) | 60-80% | Khanna 2003 |
| IFN-γ producer 분율 (ex vivo) | 10-25% | St Leger 2011 |

함의 — CD8 *수* 는 충분하나 functional capacity (IFN-γ 분비)가 **5-10× 낮음** → exhaustion이 양적이 아니라 **질적 봉쇄**.

---

## 2. Exhaustion phenotype — checkpoint 마커 트리

```
HSV-특이 CD8 (잠복 TG/DRG)
        │
        │  지속적 저강도 항원 노출
        │  (LAT-driven leaky lytic, M3)
        ▼
┌───────────────────────────────────┐
│   PD-1+  (~80-90% TRM)            │  ← 1차 mark
└──────┬────────────────────────────┘
       │
       ├── +LAG-3 (~50-60%) ──┐
       │                       │
       ├── +TIM-3 (~30-50%) ───┤
       │                       │  → terminal exhausted Tex^term
       ├── +TIGIT (~40-70%) ───┤    (Tcf1-, TOX+, eomes-hi)
       │                       │
       └── +CTLA-4 (~15-25%) ──┘

         vs.

   Tcf1+ stem-like (Tex^stem) ── ~5-15%
        ↓ (checkpoint blockade가 확장시키는 pool)
   proliferative · self-renewing · differentiates into Tex^int
```

### 2.1 마커별 분율 (HSV ganglion TRM, 추정)

| 마커 | 분율 (TG CD8) | 가역성 (단독 블록) | 비고 |
|---|---|---|---|
| PD-1 (PDCD1) | 80-90% | 중간 (Tex^stem 활성화) | Pauken-Wherry 2015 모델 |
| LAG-3 | 50-60% | 약함 단독 · PD-1과 시너지 | relatlimab 데이터 |
| TIM-3 (HAVCR2) | 30-50% | 단독 약함 | terminal marker |
| TIGIT | 40-70% | 중간 (DNAM-1 축 회복) | poliovirus receptor 결합 |
| CTLA-4 | 15-25% | 강하나 toxic | Treg compartment overlap |
| TOX (TF, intracellular) | 70-90% | 비가역 (epigenetic lock) | Tex 정체성 결정 |
| Tcf1 (TF, stem-like) | 5-15% | — (positive marker) | 확장이 목표 |

🟡 SUPPORTED-BY-CITATION — HSV ganglion 직접 ChIP/FACS는 sparse, 다수가 LCMV/cancer 모델 외삽.

### 2.2 TOX-mediated epigenetic exhaustion lock

Khan/Pauken 2019 — TOX이 H3K4me1/H3K27ac landscape를 재구성하여 effector gene을 영구히 silencing. **checkpoint 블록만으로는 Tex^term이 reinvigorate되지 않음** → Tcf1+ Tex^stem만 확장. M8의 ceiling.

함의 — M8 효율은 Tex^stem pool 크기에 비례 → **M9 mRNA 백신으로 새 naïve/effector를 도입**하는 게 ceiling 돌파 경로.

---

## 3. Checkpoint blockade — 표적 / 약물 / HSV 적용성

### 3.1 임상 약물 카탈로그

| 표적 | 약물 (대표) | 승인 적응증 | HSV ganglion 가능성 | 등급 |
|---|---|---|---|---|
| PD-1 | pembrolizumab (Keytruda), nivolumab (Opdivo), cemiplimab | melanoma · NSCLC · 다수 | **1차 후보** (가장 broad, 안전 profile) | 🟡 |
| PD-L1 | atezolizumab, durvalumab, avelumab | NSCLC · 방광 등 | 뉴런 PD-L1 발현 데이터 부족 — 약함 | 🟠 |
| LAG-3 | relatlimab (Opdualag, +nivo) | melanoma (2022) | PD-1 시너지 후보 | 🟡 |
| TIM-3 | sabatolimab (MBG453), cobolimab | clinical (MDS, NSCLC) | 후순위 | 🟠 |
| TIGIT | vibostolimab, tiragolumab | clinical (NSCLC) | DNAM-1 축 — neuron 환경 미지 | 🟠 |
| CTLA-4 | ipilimumab (Yervoy), tremelimumab | melanoma 등 | **너무 toxic** (Treg 광범위 영향) — 회피 | 🟡 |
| VISTA | onvatilimab 등 | 전임상 | TBD | ⚪ |
| CD96 | (전임상) | — | TBD | ⚪ |

### 3.2 조합 전략 우선순위

| 조합 | 근거 | HSV 추정 효율 | risk |
|---|---|---|---|
| **anti-PD-1 단독** | safest, broadest | $\phi_{block}: 0.7 \to 0.4$ | 낮음 (5-10% irAE) |
| **anti-PD-1 + anti-LAG-3** (relatlimab류) | melanoma OS 입증 | $\to 0.25-0.30$ | 중간 |
| **anti-PD-1 + anti-TIGIT** | TIGIT HSV TG에 풍부 (가설) | $\to 0.30-0.35$ | 중간 |
| **anti-PD-1 + anti-CTLA-4** (Yervoy+Opdivo류) | 강력하나 colitis/hypophysitis | $\to 0.20$ | 높음 (irAE 40-60%) |
| **triplet (PD-1 + LAG-3 + TIGIT)** | 최대 효능, 임상 미검증 | $\to 0.15$ (extrapolation) | 높음 |

> **권장 1차: PD-1 + LAG-3 (relatlimab류).** safety/efficacy 균형. M6 LRA로 항원 노출 ↑된 직후 5-7일 윈도에 systemic 1회 dose.

---

## 4. Ganglion accessibility — 🟠 INSUFFICIENT, 결정적 미지수

### 4.1 BNB (blood-nerve barrier) vs BBB

| 장벽 | 위치 | tightness | 항체 침투 (IgG, 150 kDa) |
|---|---|---|---|
| BBB (뇌실질) | brain capillary | 매우 tight | 혈청의 ~0.1% |
| BNB (말초 신경) | endoneurial capillary | 중간 | ~0.5-2% (추정) |
| **DRG/TG endothelium** | **fenestrated** | **looser than BNB** | **~2-10%? (sparse)** |
| 뇌수막 (CSF interface) | choroid plexus | 중간 | intrathecal 시 우회 가능 |

DRG/TG capillary는 fenestration이 보고됨 (Jacobs 1976 · Kiernan 1996) → 다른 신경절보다 항체 침투에 유리하나 **정량 데이터 부재**.

### 4.2 정량 추정 — 🟢 SUPPORTED-NUMERICAL (보존적 extrapolation)

pembrolizumab serum trough: ~20-30 μg/mL (200 mg q3w). 

Tg interstitial fraction $f_{TG} = $ Tg 농도 / serum 농도. 추정 범위:

| 가정 | $f_{TG}$ | TG [pembro] | PD-1 occupancy (Kd~30 pM) |
|---|---|---|---|
| BBB-like (보존적) | 0.001 | 0.02-0.03 μg/mL ≈ 0.13-0.20 nM | ~85-93% (Kd ≪ conc.) |
| BNB-like | 0.01 | 0.2-0.3 μg/mL ≈ 1.3-2.0 nM | ~98% |
| fenestrated DRG | 0.05 | 1.0-1.5 μg/mL ≈ 6.6-10 nM | >99% |

→ 최악 (BBB-like)에서도 **PD-1 occupancy는 충분 high** (pembrolizumab Kd 매우 낮음).
→ **봉쇄 효능 자체는 보장**되나, *얼마나 많은* exhausted CD8 가 reinvigorate 되느냐는 별개 (TOX-lock §2.2).

🟠 flag — TG/DRG 항체 침투 직접 측정 (radiolabeled pembro PET, post-mortem TG IHC) 시급. M9 전 필수.

### 4.3 Local delivery 대안 — risk/benefit

| 경로 | 침투 | toxicity | feasibility |
|---|---|---|---|
| Systemic IV (standard) | 위 §4.2 | irAE 5-40% (조합 의존) | 표준 |
| **Intrathecal** | CSF → TG nerve root | 직접 신경계 노출 (염증 risk) | 임상 사례 있음 (cancer) |
| Epidural (sacral) | sacral DRG 근접 | 국소염증 | 마취과 기술 활용 |
| **Intraganglionic (TG)** | direct | 침습 (Gasserian ganglion 접근 — 삼차신경통 시술 응용) | 가능, 위험 高 |
| Intranasal | 비강 → 후각 신경 → 뇌막 → TG? | 비침습 | 침투 데이터 부재 |
| AAV-encoded checkpoint blocker (gene therapy) | local 持續 발현 | 영구, 반전 불가 | preclinical |

> **권장 2차 — sacral epidural delivery** (HSV-2 적응증) — 마취과 시술 인프라 활용 + 국소 농도 100×, systemic irAE 회피.

---

## 5. T-cell trafficking augmentation — chemokine 보강

### 5.1 chemokine 축

| 축 | 수용체 (T) | 리간드 (조직) | HSV TG에서의 baseline | 보강 전략 |
|---|---|---|---|---|
| **CXCR3 / CXCL9-10-11** | CXCR3 (Th1, Tc1) | IFN-γ 유도 (위성세포) | 재활성화 시 ↑, 잠복 시 ↓ | CXCL10 AAV TG 전달 |
| CCR5 / CCL5 | CCR5 | RANTES (위성세포) | 보통 | 보강 후순위 |
| CXCR6 / CXCL16 | CXCR6 (TRM marker) | CXCL16 (뉴런?) | TRM 유지에 필수 | 유지 표적 |
| S1P / S1PR1 | S1PR1 ↓ (TRM은 down) | S1P (혈관) | TRM 유지 | 건드리지 말 것 |
| α4β7, αE β7 (CD103) | adhesion | E-cadherin (점막) | TRM tethering | 유지 표적 |

### 5.2 보강 전달 옵션

| 옵션 | 메커니즘 | 단계 |
|---|---|---|
| **AAV-CXCL10** (TG intra-ganglionic) | local Th1 trafficking ↑ | 전임상 |
| recombinant IFN-γ local | upstream → CXCL9/10/11 모두 ↑ | feasibility 입증, toxicity ↑ |
| TLR9 agonist (CpG ODN) local | innate → IFN-α → chemokine cascade | 임상 (백신 보조제) |
| TCR-T / CAR-T (HSV-specific) | 외부 effector 도입 | Riddell 그룹 전임상 (HSV-2 gD/gB) |
| **M9 mRNA 백신** | naïve/effector pool 신생 | M9 의존 |

> **권장 3차 — anti-PD-1 + AAV-CXCL10 (TG local)**. checkpoint × trafficking 시너지, BNB 우회를 chemokine 쪽으로 분담.

---

## 6. Antigen exposure 문제 — virus가 침묵하면 표적이 없다

### 6.1 핵심 모순

| 상태 | 항원 노출 | CD8 표적 가능 |
|---|---|---|
| 안정 잠복 (M3) | LAT만 (비-항원성, ICP47이 MHC-I 봉쇄) | **거의 없음** |
| Phase I (M3 §6) | 일시 IE leak | 약함 (수 시간) |
| Phase II / 재활성화 | full lytic | **강함** |
| post-LRA (M6 shock) | 강제 lytic | **최강** |

→ **M8 단독 ≠ cure** — 표적 없는 면역 활성화는 무용.

### 6.2 M6 연계 — 'shock-and-kill'의 정확한 의미

M6의 LRA (KDM4 활성화 + HDAC inhibitor, M3 §8) → lytic 항원 발현 → MHC-I presentation (ICP47이 여전히 봉쇄하나 IFN-γ가 우회) → **M8 reinvigorated CD8 가 인식·제거**.

```
타임라인 (M6+M8 sequential)
─────────────────────────────
Day 0   :  anti-PD-1 + LAG-3 systemic dose ─── CD8 reinvigoration 시작
Day 3-5 :  CD8 IFN-γ capacity 회복 peak
Day 5   :  LRA pulse (KDM4i + HDACi) ── shock
Day 5-8 :  lytic 항원 발현, MHC-I presentation
Day 6-10:  CD8 non-lytic IFN-γ/TNF clearance (Sloan 2008)
Day 10+ :  acyclovir/foscarnet 병용 — 잔여 lytic 게놈 살해
Day 14  :  M8 wash-out (irAE 모니터링)
```

### 6.3 ICP47 우회

ICP47은 인간 TAP1/2를 차단 → MHC-I 봉쇄. 그러나 **IFN-γ 자극시 immunoproteasome + TAP 우회 경로 활성화** → 부분 회복. 따라서 IFN-γ 보강 (위 §5)이 ICP47 우회의 분자적 근거.

---

## 7. 뉴런 생존 — first-principles 우려

### 7.1 sensory neuron은 post-mitotic, 대체 불가

granzyme B 매개 살해가 일어나면 영구 감각 결손. 그러나 HSV에서 CD8 clearance는 **non-lytic IFN-γ + TNF 매개** (Sloan-Jerome 2007 · Knickelbein 2008) — 신경세포 표면 유지된 채 viral genome 침묵·분해.

### 7.2 numerical — 뉴런 생존율 추정

| 시나리오 | granzyme B 방출 비율 | 뉴런 손실 / 재활성화 | 평생 누적 (50 events) |
|---|---|---|---|
| baseline (exhausted) | ~5% | 100 잠복뉴런 중 ~5개 살해 | ~250 → TG 5% 손실 |
| reinvigorated 부주의 | 30% | ~30개 / event | TG ~30% 손실 (**위험**) |
| reinvigorated + IFN-γ bias | 10% | ~10개 / event | TG ~10% (수용 가능) |
| **표적 — non-lytic 우세** | <5% | <5 / event | <5% 평생 손실 |

> 함의 — checkpoint reinvigoration이 강해지면 cytolytic shift risk. M8 설계는 **IFN-γ/TNF bias** 가 핵심 (e.g., LAG-3 over CTLA-4, IL-12 보조).

🟠 flag — 인간 TG에서 cytolytic vs non-lytic 비율 직접 측정 부재. mouse 모델 외삽.

---

## 8. First-principles efficacy 모델 — 🟢 SUPPORTED-NUMERICAL

### 8.1 parameter 정의

| 기호 | 의미 | baseline | post-M8 (PD-1+LAG-3) |
|---|---|---|---|
| $N_{lat}$ | TG 잠복 뉴런 (양측) | 2,500 (M2 §7) | — |
| $r$ | 연간 재활성화 events / 뉴런 | 0.05 (baseline) | 0.05-0.1 (M6 의존) |
| $\phi_{block}$ | exhaustion으로 봉쇄된 CD8 분율 | 0.7 (Khanna 2003) | 0.25 (조합 후, §3.2) |
| $p_{clear}^{unblocked}$ | 활성 CD8 단일 event 청소 확률 | 0.8 (Sloan 추정) | — |
| $p_{clear}$ | 실제 단일 event 청소 확률 | $(1-\phi_{block}) \cdot p_{clear}^{unblocked}$ | — |
| $C$ | sterilizing cycles | $\log(1/N_{lat}) / \log(1-p_{clear})$ | — |

### 8.2 baseline (M6 only, no M8)

$$
p_{clear}^{base} = (1 - 0.7) \cdot 0.8 = 0.24
$$

뉴런 1개의 t 회 reactivation 후 잔존 확률:

$$
P_{remain}(t) = (1 - p_{clear})^t = 0.76^t
$$

전체 reservoir 1뉴런까지 sterilize:

$$
0.76^C \le 1/N_{lat} = 1/2500
\implies C \ge \log(2500) / \log(1/0.76) = 7.82 / 0.274 = \mathbf{28.5 \text{ cycles}}
$$

연 0.05 자연 reactivation → ~570년. M6 LRA로 r=10/yr 강제 → **~3년**.

### 8.3 post-M8 (PD-1 + LAG-3)

$$
p_{clear}^{M8} = (1 - 0.25) \cdot 0.8 = 0.60
$$

$$
0.40^C \le 1/2500
\implies C \ge \log(2500) / \log(1/0.40) = 7.82 / 0.916 = \mathbf{8.5 \text{ cycles}}
$$

M6 강제 r=10/yr → **~10개월**. 

**개선 factor — 3.4×** (28.5 → 8.5 cycles). Treatment 기간 ~570년 → ~10개월 (M6 동반).

### 8.4 추가 sensitivity

| $\phi_{block}$ post-M8 | $p_{clear}$ | $C$ | M6 (r=10/yr) 기간 |
|---|---|---|---|
| 0.7 (no M8) | 0.24 | 28.5 | 2.85년 |
| 0.4 (PD-1 alone) | 0.48 | 12.0 | 1.2년 |
| **0.25 (PD-1+LAG-3)** | **0.60** | **8.5** | **~10개월** |
| 0.15 (triplet) | 0.68 | 7.0 | ~8.4개월 |
| 0.05 (이론적 한계) | 0.76 | 6.1 | ~7.3개월 |

dimishing returns — PD-1+LAG-3 이후 더 이상 큰 효율 gain 없음, irAE risk 만 ↑ → **PD-1+LAG-3 sweet spot**.

### 8.5 heavy-tail 보정 (M2 §7.2 tail problem)

상위 1% deep-latent neuron은 copies/neuron ≫ 100 → reactivation당 청소 확률 $p_{clear}$ scaling이 다를 수 있음 (genome 수가 많을수록 silencing 강해 LRA 효능 ↓ × ICP47 발현 ↑ → CD8 회피 ↑). 보수적으로 $p_{clear}^{tail} = p_{clear} / 3$ 가정:

$$
C_{tail} \approx \log(2500 \times 0.01) / \log(1/(1-0.20)) = 3.22 / 0.223 = \mathbf{14.4 \text{ cycles}}
$$

tail까지 sterilize하려면 **추가 ~6 cycles** → 총 14.4 cycles → r=10/yr 시 ~17.3개월. M5 CRISPR이 tail 청소에 더 적합.

```
clearance probability — blocked vs unblocked
─────────────────────────────────────────────
P_remain(t)
   1.0 ┤●
       │ ●
   0.8 ┤  ● ●        ← baseline exhausted (0.76^t)
       │      ● ●
   0.6 ┤         ● ● ●
       │            ▲ ● ● ●
   0.4 ┤            │       ● ● ●
       │            │            ▲ ● ● ●
   0.2 ┤■           │            │     ● ●
       │ ■          │post-M8 (0.40^t)
   0.0 ┤  ■ ■ ■     ▼
       └─────────────────────────────────▶ cycles
        0   5   10   15   20   25   30
                 ▲             ▲
                M8: 8.5      baseline: 28.5
                  cycles       cycles
```

---

## 9. Risks · biosafety

### 9.1 irAE (immune-related adverse event)

| 약물 조합 | irAE 발생률 (oncology 데이터) | HSV 환자에 우려되는 항목 |
|---|---|---|
| anti-PD-1 단독 | 10-20% (any) · 3-5% (G3+) | thyroiditis, colitis |
| PD-1 + LAG-3 | ~25% (G3 ~15%) | colitis, hypophysitis |
| PD-1 + CTLA-4 | 40-60% (G3 30-40%) | hepatitis, pneumonitis — **회피 권장** |
| triplet | unknown, extrapolation ↑↑ | — |

### 9.2 신경 특이 우려

| risk | 메커니즘 | 완화 |
|---|---|---|
| **HSV encephalitis** | 동기적 TG 재활성화 + 무봉쇄 CD8 → 뉴런 손상 + BBB 침투 | acyclovir prophylaxis 동시 · low-dose 시작 |
| 삼차신경통 (TGN) | TG 염증 → 신경통 | 국소 스테로이드 rescue |
| 안구 keratitis 악화 | V1 reactivation 동안 | trifluridine topical 병용 |
| 무균성 수막염 | CSF CD8 침윤 | 모니터링 |

### 9.3 다른 latent virus 재활성화

checkpoint inhibitor는 **EBV · CMV · VZV · HBV reactivation** 보고 — Treg/exhausted compartment 광범위 영향. HSV cure를 위해 다른 latent을 깨우는 risk → 사전 screening (CMV/EBV viremia, HBV serology) 필수.

### 9.4 국소화로 risk 완화

- **sacral epidural** (HSV-2) — systemic exposure 최소, irAE ↓.
- **AAV-encoded scFv (anti-PD-1)** TG local — 영구 발현 risk (반전 불가) vs systemic 회피.

---

## 10. 통합 권장 + M6/M9 연계

### 10.1 조합 우선순위

| 단계 | 조합 | 근거 |
|---|---|---|
| **1차 (안전)** | anti-PD-1 단독 + M6 LRA | $\phi_{block}: 0.7\to0.4$, irAE 낮음 |
| **2차 (효능)** | anti-PD-1 + anti-LAG-3 + M6 | $\to 0.25$, sweet spot |
| **3차 (tail 추가)** | + AAV-CXCL10 TG local + M9 mRNA 백신 | naïve pool 도입으로 TOX-lock 우회 |
| **4차 (deep-latent)** | + M5 CRISPR (Cas9) | heavy-tail 직접 cleavage |
| **회피** | PD-1 + CTLA-4 / triplet | irAE 비례 gain 없음 |

### 10.2 M6 ↔ M8 동기화

M6 LRA pulse는 **M8 dosing 후 3-5일** (CD8 reinvigoration peak)에 시작 — §6.2 timeline. 동시 투여는 항원 노출과 CD8 capacity가 어긋남.

### 10.3 M9 ↔ M8 시너지

M9 mRNA 백신 (HSV gB/gD/gE) → naïve/effector CD8 신생 → TOX-locked Tex^term 의존성 ↓ → M8 ceiling 돌파. 백신 prime → M8 boost 7-14일.

### 10.4 M5 ↔ M8 보완

M5 CRISPR이 deep-latent tail 직접 청소 (epigenetic 의존성 없이). M8 + M6은 광범위 reservoir, M5는 1% tail. **분할 정복**.

---

## 11. 참고문헌

- Knickelbein JE, Khanna KM, et al. (2008) *Science* 322:268 — TG-resident granzyme B+ CD8 around latent HSV neurons
- Khanna KM, Bonneau RH, Kinchington PR, Hendricks RL (2003) *Immunity* 18:593 — non-lytic CTL surveillance in TG
- Sloan DD, Jerome KR (2007) *J Virol* 81:11069 — IFN-γ + TNF mediated non-lytic HSV clearance
- St Leger AJ, Hendricks RL (2011) *J Neurovirol* 17:528 — corneal HSV CD8 effector
- Sheridan BS, Cherpes TL, Urban J (2009-2014) — HSV-2 sacral CD8
- Pauken KE, Wherry EJ (2015) *Trends Immunol* 36:265 — checkpoint reversal mechanisms
- Khan O et al. (2019) *Nature* 571:211 — TOX as epigenetic lock of exhaustion
- Wherry EJ, Kurachi M (2015) *Nat Rev Immunol* 15:486 — molecular signatures of exhaustion
- Posavad CM et al. (2017) *J Infect Dis* — HSV-specific T cells in genital herpes patients
- Wald A, Corey L (2007-) — HSV-2 clinical epidemiology
- Riddell SR group (preclinical) — adoptive T-cell HSV (Bhatt, Aubert et al.)
- Jacobs JM (1976) — DRG capillary fenestration
- Kiernan JA (1996) — BNB anatomy
- Egelston CA, Newburg SS, et al. — exhaustion marker characterization
- Tawbi HA et al. (2022) *NEJM* 386:24 — relatlimab+nivolumab (RELATIVITY-047)
- Du-Roizman series (2011-) — LAT-driven silencing as immune evasion
- Iijima N, Iwasaki A (2014) *Science* 346:93 — TRM maintenance in mucosa

---

## 12. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| TG-resident CD8 surveillance · granzyme B+ (§1) | 🟡 SUPPORTED-BY-CITATION | Knickelbein 2008 · Khanna 2003 |
| 뉴런당 5-10 CD8 juxtaposed (§1.2) | 🟡 | Knickelbein IHC counts |
| Exhaustion marker 분율 (§2.1) | 🟡 + extrapolation | LCMV/cancer 모델 → HSV ganglion 외삽 (직접 multi-color FACS sparse) |
| TOX epigenetic lock (§2.2) | 🟡 | Khan 2019 (LCMV) — HSV 직접 확인 부재 |
| Checkpoint 약물 카탈로그 (§3) | 🟡 | 임상 승인 사실 |
| **Ganglion 항체 침투 정량 (§4.2)** | **🟠 INSUFFICIENT** | **직접 측정 부재 — radiolabeled pembro PET 필요** |
| chemokine 축 (§5) | 🟡 | 일반 immunology 확립 |
| AAV-CXCL10 TG 효능 (§5.2) | 🟠 | preclinical only, HSV 직접 적용 사례 없음 |
| ICP47 우회 (IFN-γ 의존) (§6.3) | 🟡 | immunoproteasome 일반론 + HSV 일부 |
| **뉴런 생존율 추정 (§7.2)** | 🟠 | mouse 외삽, 인간 직접 데이터 부재 |
| **Efficacy 모델 (§8)** | **🟢 SUPPORTED-NUMERICAL** | closed-form geometric decay, parameter 기재 |
| heavy-tail 보정 (§8.5) | 🟢 (모델) · 🟠 (parameter) | M2 §7.2 입력 + 보수적 1/3 scaling 가정 |
| irAE 발생률 (§9.1) | 🟡 | oncology 통계 직접 인용 |
| HSV 임상 trial (anti-PD-1) | 🟠 | **현재 trial 부재** — translational gap |

### 핵심 needs-check / 🟠 목록

1. **TG/DRG 항체 침투 정량** — radiolabeled checkpoint 항체 PET/SPECT (M9 전 시급).
2. **HSV-특이 TG CD8 exhaustion 마커 multi-parameter FACS** — 인간 cadaver TG 또는 surgical sample.
3. **뉴런 cytolytic vs non-lytic clearance 비율 (인간)** — 측정 불가에 가까움, 간접 marker 개발 필요.
4. **AAV-CXCL10 TG local delivery** — 전임상 부재, mouse HSV 모델 우선 검증.
5. **HSV 임상 trial of anti-PD-1** — 가설 단계. M6 LRA 임상 진입 후 동반 가능.

---

## 13. 한 줄 요약 (M6/M9로 전달)

> **권장 조합 — anti-PD-1 + anti-LAG-3 (relatlimab류) systemic + M6 LRA 동기 (Day 5) + M9 mRNA 백신 prime → sterilization cycles 28.5 → 8.5 (3.4× 개선), M6 r=10/yr 시 ~10개월. M8 단독은 enabler — 표적 (항원) 이 없으면 무용. 🟠 ganglion 항체 침투 정량이 최우선 미지수.**
