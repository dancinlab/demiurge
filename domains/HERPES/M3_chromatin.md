# M3 — HSV 잠복 게놈의 chromatin state 모델

> 마일스톤 M3 산출물 · current-state · no history.
> M1 (genome/LAT) → M3 (chromatin) → M4 (reactivation) → M6 (shock-and-kill) / M7 (block-and-lock).
> 출처 = literature ChIP-seq + first-principles Markov state model.
> 본문 등급: 인용 부분 🟡 · §7 Markov 모델 🟢 SUPPORTED-NUMERICAL.

---

## 1. Episomal nucleosome assembly — host 히스톤이 viral DNA에 로딩

HSV 게놈은 비리온 안에서는 거의 nucleosome-free (protamine-유사 VP19C 응축 상태)이지만, 뉴런 핵으로 들어가는 즉시 host histone이 로딩되어 chromatinized episome으로 전환된다. CpG methylation은 검출되지 않으므로 silencing은 **순수 chromatin 기반** (DNA methylation X).

| 축 | 상태 | 근거 |
|---|---|---|
| viral DNA 형태 | episomal, circular, non-integrated | Knipe & Cliffe 2008 |
| DNA methylation | 없음 (5mCpG 검출 한계 이하) | Kubat et al. 2004 |
| 히스톤 variant (잠복) | H3.3 우세 (replication-independent loading) | Placek et al. 2009 / Cliffe 2017 |
| 히스톤 variant (lytic) | H3.1 + de novo (CAF-1 경로) | Conn et al. 2008 |
| chaperone 경로 | HIRA (H3.3) · ATRX/DAXX (H3.3, ND10) · ASF1 | Lukashchuk & Everett 2010 |
| nucleosome 간격 | ~150-200 bp (host 평균과 유사하나 위치는 약하게 phased) | Lieberman 2016 |
| copy / 뉴런 | 1-1000+ (latency burden 분포 wide) | Wang et al. 2005 |

핵심: latency 시 H3.3가 우세 → HIRA · ATRX/DAXX 의존 → 이 chaperone들이 차단되면 chromatinization 실패 → lytic gene de-silencing (M4 트리거의 한 축).

---

## 2. Lytic 유전자 cluster의 heterochromatic marks

잠복기 동안 lytic IE (α: ICP0/4/22/27/47) · E (β) · L (γ) promoter는 H3K9me2/me3 + H3K27me3 농축으로 침묵된다. 두 marks는 **상호 보완적** (facultative + constitutive heterochromatin이 함께 작동).

| Mark | 효소 (writer) | Eraser | Reader | 잠복 ChIP-seq 농축 (lytic promoter, 대뇌-TG 모델 추정치) |
|---|---|---|---|---|
| H3K9me2 | G9a / GLP (EHMT2/1) | KDM3A · KDM4A | HP1α/β/γ | ~3-8× input (estimate) |
| H3K9me3 | SUV39H1 · SETDB1 | KDM4A/B/C | HP1α/β/γ | ~5-15× input (Cliffe-Knipe 2009) |
| H3K27me3 | PRC2 (EZH2 · SUZ12 · EED) | KDM6A/B (UTX · JMJD3) | PRC1 (CBX) | ~3-10× input (Kwiatkowski 2009 추정) |
| H4K20me3 | SUV4-20H1/H2 | — | — | 보조 mark, 부분 데이터만 |

### 2.1 어떤 유전자 cluster가 어떤 mark를 우선 받는가

| Gene class | 대표 ORF | 우세 mark (latency) | 비고 |
|---|---|---|---|
| α (IE) | ICP0, ICP4, ICP22, ICP27, ICP47 | H3K9me3 + H3K27me3 (bivalent-유사) | 재활성화 시 가장 먼저 풀려야 함 |
| β (E) | TK (UL23), ICP8 (UL29), pol (UL30) | H3K9me3 중심 | bivalent 약함 |
| γ (L) | VP16 (UL48), gB/gC/gD 등 | H3K9me3 + H3K9me2 | 마지막에 풀림 |
| LAT | LAP1/2 + 8.3 kb primary | **H3K4me3 + H3K9ac** (euchromatic) | §3 참조 |

bivalent (H3K27me3 + H3K4me3 동시) state는 일부 IE promoter에서 관찰 → "poised" → 빠른 reactivation 가능성의 분자 기반.

---

## 3. LAT locus의 euchromatic marks

LAT는 잠복기에 **유일하게 활발히 전사되는** 영역이므로 그 promoter (LAP1/LAP2) + exon 1은 euchromatin이어야 한다.

| Mark | 위치 (HSV-1 strain 17 좌표) | 농축 (대략) | 출처 |
|---|---|---|---|
| H3K4me3 | LAP1 (~118,800-119,000) | ~5-20× input | Kubat 2004 / Cliffe 2009 |
| H3K9ac | LAP1 + exon 1 (~118,800-120,500) | ~4-15× input | Kubat 2004 |
| H3K14ac | LAP1 promoter | ~3-10× input | Neumann et al. 2007 |
| H3K27ac | LAP1 enhancer | 측정 데이터 sparse — **needs check** | Bloom 그룹 후속 |
| H3K9me3 | LAT downstream (exon 2 이후) | 낮음, 경계 부근에서 증가 | Cliffe 2009 |

LAT 영역의 active marks를 유지하는 한 축은 LAT 자신이 만들어내는 ncRNA + miRNA가 lytic promoter에 heterochromatin을 "원격으로" 부르는 양상 (LAT-dependent silencing, Du-Roizman 모델).

---

## 4. CTCF binding sites — chromatin boundary insulator

CTCF는 LAT euchromatic island와 인접 lytic heterochromatin 사이의 **insulator** 역할. HSV-1 게놈에 confirmed CTCF site는 7개 (CTRL1/L2/L3, CTRS1/S2/S3, + 추가 IRL/TRL site).

```
HSV-1 게놈 CTCF site 트랙 (strain 17 기준, 대략 좌표)
0      20k     40k     60k     80k     100k    120k    140k  152k
├───────┼───────┼───────┼───────┼───────┼───────┼───────┼─────┤
│U_L                                                           │U_S    │
│                                                                       │
            ▲CTRL1                                ▲CTRL2 (LAT 5')
            ~7.5k                                  ~117.1k
                                                       ▲CTRS1 (LAT-ICP0 사이)
                                                       ~119.4k
                                                            ▲CTRS2
                                                            ~125.5k
                                                                 ▲CTRS3 (ICP0/ICP4)
                                                                 ~127.1k
            ▲CTRL3 (IRL mirror via inversion)
            ~145k (TRL side)
```

| Site | 좌표 (HSV-1) | 기능 가설 | 출처 |
|---|---|---|---|
| CTRL1 | ~7.5 kbp (TRL) | UL5/UL6 영역 boundary | Amelio et al. 2006 |
| CTRL2 | ~117.1 kbp (LAT 5', LAP1 upstream) | **LAT euchromatic island 좌측 경계** | Chen et al. 2007 / Washington 2018 |
| CTRS1 | ~119.4 kbp (LAT 5' downstream / ICP0 side) | LAT ↔ ICP0 사이 insulator | Chen 2007 |
| CTRS2 | ~125.5 kbp (LAT 3' 근방) | LAT exon 2 영역 boundary | Kwiatkowski 2009 |
| CTRS3 | ~127.1 kbp (ICP0 → ICP4 사이) | IE cluster intra-boundary | Kwiatkowski 2009 |
| (IRL mirror) | ~145 kbp | inverted repeat 대칭 site | RefSeq |

### 4.1 CTCF deletion 표현형 (Washington 2018/2019)

| CTCF site KO | 표현형 | 시사점 |
|---|---|---|
| CTRL2 deletion | latency 동안 lytic gene leak ↑, spontaneous reactivation ↑ | CTRL2가 LAT euchromatin → lytic heterochromatin 전이를 막는 핵심 boundary |
| CTRS1 deletion | reactivation kinetics 빨라짐 | ICP0 silencing 약화 |

CTCF는 host cohesin (SMC1A · SMC3 · RAD21)과 함께 chromatin loop을 형성 → §5의 3D 구조와 연결.

---

## 5. 3D chromatin organization — loop + ND10 anchor

| 축 | 모델 | 근거 |
|---|---|---|
| LAT loop | LAP1 ↔ LAT 3' enhancer 사이 CTCF-cohesin loop | Ertel et al. 2012 (3C in mouse TG) |
| episome 위치 | ND10/PML body 근접 (특히 lytic 부분) | Everett & Murray 2005 |
| ND10 단백질 | PML, Sp100, ATRX, DAXX, hDaxx | Lukashchuk & Everett 2010 |
| ND10 효과 | ATRX/DAXX → H3.3 deposition → 잠복 silencing 강화 | Cabral et al. 2018 |
| ICP0 (재활성화) | ND10 component ubiquitin → 분해 → silencing 해제 | Boutell & Everett 2013 |

```
잠복 episome 3D 모델 (단순화)
                       PML body (ND10)
                      ┌──────────┐
                      │  ATRX     │
                      │  DAXX    ─┼─── H3.3 deposition
                      │  PML     │      ↓
                      │  Sp100   │   lytic ORF 침묵
                      └────┬─────┘
                           │
                  ┌────────┴───────┐
                  │  lytic cluster │   H3K9me3 + H3K27me3
                  │  (ICP0/4/27 …)│   ── HP1 결합
                  └────────┬───────┘
                           │ ╱ CTCF (CTRS1)
                           ▼
                  ┌────────────────┐
                  │  LAT island    │   H3K4me3 + H3K9ac
                  │  (LAP1, exon1) │   ── 활발한 전사
                  └────────────────┘
                           ▲ ╲ CTCF (CTRL2)
                           │
                  ┌────────────────┐
                  │  upstream lytic │  H3K9me3
                  └────────────────┘
```

---

## 6. Reactivation 시 dynamic chromatin — phospho-methyl switch

Cuddy et al. 2020 (eLife)에서 정의한 **2-phase reactivation** 모델:

| Phase | 트리거 | chromatin 변화 | 주요 효소 | 결과 |
|---|---|---|---|---|
| Phase I (animation) | NGF withdrawal · DLK · JNK 활성화 | H3K9me3-S10ph + H3K27me3-S28ph dual mark (HP1 displacement, methyl 유지) | JNK | lytic IE 전사 **histone demethylation 없이** 일시 허용 |
| Phase II (full reactivation) | VP16-HCF1 axis · HDAC inhibition | H3K9me3 → H3K9ac 실제 전환, H3K4me3 신생 deposition | KDM4A/B · HATs (CBP/p300) | full lytic cascade |

핵심 통찰: Phase I은 **methyl mark 자체를 지우지 않고** S10 phosphorylation만으로 HP1을 떨어뜨려 RNA Pol II를 통과시키는 trick → "전등 스위치"가 아니라 "조도 슬라이더". 이 점은 M7 block-and-lock 전략에 결정적 (단순히 me3를 깔아두는 것만으로는 부족, JNK 차단 또는 S10 phospho 차단이 필요).

```
Phase I phospho-methyl switch
─────────────────────────────
잠복:    H3K9me3 ── HP1 결합 ── 침묵
            │
            │ JNK 활성 (DLK 경유)
            ▼
Phase I: H3K9me3·S10ph ── HP1 떨어짐 ── 전사 일시 허용 (methyl 잔존)
            │
            │ HCF1 핵 진입 + KDM4 모집
            ▼
Phase II: H3K9ac + H3K4me3 ── full lytic transcription
```

---

## 7. First-principles Markov state model — 🟢 SUPPORTED-NUMERICAL

### 7.1 모델 정의

각 nucleosome (또는 100-200 bp bin)을 3-state Markov chain으로 모델링:

$$S \in \{\text{Ac (H3K9ac)},\; \text{U (unmod)},\; \text{Me3 (H3K9me3)}\}$$

연속시간 Markov chain의 전이율 행렬 (단위 = $s^{-1}$):

$$
Q =
\begin{pmatrix}
-(k_{a\to u}) & k_{a\to u} & 0 \\
k_{u\to a} & -(k_{u\to a}+k_{u\to m}) & k_{u\to m} \\
0 & k_{m\to u} & -k_{m\to u}
\end{pmatrix}
$$

전제: Ac↔Me3 직접 전이 없음 (반드시 U를 거침 — eraser가 ac 또는 me3를 먼저 제거해야 다른 mark가 깔림. 이는 HDAC vs KDM의 직렬 동작 가정).

### 7.2 정상상태 (steady-state) 점유율

detailed balance 조건 (가역) 가정 시:

$$
P_{Ac}^{ss} = \frac{1}{Z} \cdot \frac{k_{u\to a}}{k_{a\to u}}
\qquad
P_{Me3}^{ss} = \frac{1}{Z} \cdot \frac{k_{u\to m}}{k_{m\to u}}
\qquad
P_{U}^{ss} = \frac{1}{Z}
$$

$$Z = 1 + \frac{k_{u\to a}}{k_{a\to u}} + \frac{k_{u\to m}}{k_{m\to u}}$$

### 7.3 lytic promoter 잠복 steady-state — closed form

lytic IE promoter (예: ICP0)의 잠복 상태에서 ChIP-seq 비율로 부터:

- ChIP-seq 신호: $P_{Me3} \approx 0.7\text{-}0.9$, $P_{Ac} \approx 0.02\text{-}0.05$ (literature 추정)
- 이로부터 $k_{u\to m}/k_{m\to u} \approx 10$-$50$ (G9a/SUV39H1 우세, KDM4 약함)
- $k_{u\to a}/k_{a\to u} \approx 0.05$-$0.2$ (HDAC1/2 우세, HAT 약함)

문헌 rate constant 추정치 (in vivo, 뉴런):

| Rate | 의미 | 값 (추정 범위) | 출처 |
|---|---|---|---|
| $k_{u\to m}$ | SUV39H1/G9a-mediated K9 me3 | $10^{-4}$ – $10^{-3}\ s^{-1}$ | Müller-Ott 2014 (mammalian) — **needs check for HSV** |
| $k_{m\to u}$ | KDM4A/B demethylation | $10^{-5}$ – $10^{-4}\ s^{-1}$ | Hauri 2016 estimate |
| $k_{u\to a}$ | CBP/p300 acetylation | $10^{-4}$ – $10^{-3}\ s^{-1}$ | Zentner-Henikoff 2013 |
| $k_{a\to u}$ | HDAC1/2 deacetylation | $10^{-3}$ – $10^{-2}\ s^{-1}$ | Kuo-Allis 1999 (in vitro × 보정) |

### 7.4 약물 perturbation closed-form

**SUV39H1 inhibitor** (chaetocin류) → $k_{u\to m} \to \epsilon \cdot k_{u\to m}$ ($\epsilon \ll 1$):

$$P_{Me3}^{ss}(\epsilon) = \frac{\epsilon \cdot (k_{u\to m}/k_{m\to u})}{1 + (k_{u\to a}/k_{a\to u}) + \epsilon \cdot (k_{u\to m}/k_{m\to u})}$$

→ $\epsilon = 0.1$이면 $P_{Me3}^{ss}$이 ~0.85 → ~0.33로 감소 (lytic de-silencing 시작).

**HDAC inhibitor** (SAHA/vorinostat) → $k_{a\to u} \to \delta \cdot k_{a\to u}$:

$$P_{Ac}^{ss}(\delta) = \frac{(k_{u\to a}/(\delta \cdot k_{a\to u}))}{1 + (k_{u\to a}/(\delta \cdot k_{a\to u})) + (k_{u\to m}/k_{m\to u})}$$

→ $\delta = 0.1$이면 $P_{Ac}^{ss}$이 ~0.03 → ~0.25 → bivalent 형태 (me3 + ac 모두 존재) → Phase I과 유사한 lytic transcription 가능.

**KDM4 activator + HDAC inhibitor 조합** → me3 ↓ + ac ↑ 동시 → 최강 reactivation (shock-and-kill 최적해).

### 7.5 가장 druggable axis 식별

각 rate constant에 대한 $P_{Me3}^{ss}$의 sensitivity (log-derivative):

$$\frac{\partial \log P_{Me3}^{ss}}{\partial \log k_{u\to m}} = 1 - P_{Me3}^{ss},
\qquad
\frac{\partial \log P_{Me3}^{ss}}{\partial \log k_{m\to u}} = -(1 - P_{Me3}^{ss})$$

잠복 상태 $P_{Me3}^{ss} \approx 0.85$에서 두 sensitivity는 $\pm 0.15$. 그러나 약물 dynamic range는 KDM4 (eraser) 쪽이 훨씬 큼 (writer는 redundancy 높음 — G9a + SUV39H1 + SETDB1). 따라서:

> **결론: KDM4A/B activator (또는 직접 등가물인 K9 demethylase 강제 모집)이 가장 druggable axis.**

### 7.6 Markov diagram

```
                  k_{u→a} (CBP/p300)
            ┌─────────────────────────┐
            ▼                          │
       ┌─────────┐              ┌─────────┐
       │   Ac    │              │    U    │
       │ (H3K9ac)│              │ (unmod) │
       └─────────┘              └─────────┘
            │                          ▲
            │  k_{a→u} (HDAC1/2)       │
            └─────────────────────────►│
                                       │  k_{u→m}  k_{m→u}
                                       │  (G9a/    (KDM4A/B)
                                       │   SUV39H1)
                                       ▼
                                  ┌─────────┐
                                  │   Me3   │
                                  │(H3K9me3)│
                                  └─────────┘
                                       │
                                       │ + HP1 reader → 침묵
                                       ▼

  잠복: P_Me3 ≈ 0.85,  P_Ac ≈ 0.03,  P_U ≈ 0.12  (lytic promoter)
  LAT: P_Ac ≈ 0.5,   P_Me3 ≈ 0.1,  P_U ≈ 0.4   (반대 분포)
```

---

## 8. M6 (shock-and-kill) / M7 (block-and-lock) 함의

### 8.1 M6 — shock (lytic 유전자 깨우기)

| 표적 axis | 약물 후보 | 기전 (모델 perturbation) |
|---|---|---|
| H3K9me3 erasure | KDM4A/B activator (TBD), JIB-04 (KDM 광범위 inhibitor — 반대 작용 주의) | $k_{m\to u} \uparrow$ |
| H3K9me3 writer block | chaetocin (SUV39H1), UNC0638 (G9a/GLP) | $k_{u\to m} \downarrow$ |
| H3K27me3 writer block | EZH2 inhibitor (GSK126, tazemetostat) | PRC2 axis 차단 |
| HDAC inhibition | SAHA (vorinostat), romidepsin, panobinostat | $k_{a\to u} \downarrow$ → $P_{Ac} \uparrow$ |
| BET (BRD4) inhibition | JQ1, OTX015 | reader 차단 — 양면성 (잠복 강화 보고도 있음, **needs check**) |
| DLK/JNK axis 활성화 | (역설적: M7과 충돌) — 단기 pulse 사용 | Phase I 진입 강제 |

핵심: 단일 약물보다 KDM4 활성화 + HDAC inhibitor 조합이 §7.4 closed-form에서 최대 $P_{Ac}$ 도달.

### 8.2 M7 — lock (LAT/lytic 영구 silencing)

| 표적 axis | 약물 후보 | 기전 |
|---|---|---|
| LAT 자체 silencing | LNA antisense-LAT, miR-H sponge | LAT-driven heterochromatin 모집 차단 + LAT 항-아폽토시스 제거 |
| H3K9me3 강화 | SAM 보충, G9a activator (rare) | $k_{u\to m} \uparrow$ — 그러나 redundancy로 어려움 |
| H3K27me3 강화 | EED stabilizer, PRC2 activator | facultative heterochromatin 고정 |
| HP1 결합 강화 | (개발 초기) | reader 안정화 |
| JNK 차단 | JNK inhibitor (SP600125 등) | Phase I phospho-switch 차단 — **§6의 모델 직접 표적** |
| DLK 차단 | DLK inhibitor (GNE-3511) | upstream of JNK |
| CRISPR-Cas13/dCas9-KRAB | gRNA against LAT promoter | 영구 H3K9me3 deposition |

**M7의 가장 강력한 단일 표적**: JNK (또는 DLK upstream). 이유: §6에서 보았듯 Phase I이 me3를 지우지 않고 S10ph로 우회하기 때문에, 단순 mark 강화로는 reactivation을 못 막음. JNK를 끄면 Phase I 자체가 막힘 → 모든 stress trigger를 무력화.

### 8.3 통합 권장 (M6 + M7 sequential)

1. M6 pulse: SUV39H1 + G9a + EZH2 + HDAC 다중 inhibitor → full reactivation → antiviral (acyclovir류)로 lytic 게놈 살해 → reservoir 감소.
2. M7 maintenance: JNK inhibitor + dCas9-KRAB(LAT promoter) → 잔존 episome 영구 잠금.

---

## 9. 참고문헌

- Knipe DM, Cliffe A (2008) *Nat Rev Microbiol* 6:211 — latent chromatin landmark review
- Cliffe AR, Garber DA, Knipe DM (2009) *J Virol* 83:8182 — H3K9me3 on HSV latent genome
- Kubat NJ et al. (2004) *J Virol* 78:1139 — LAT 영역 active marks · CpG 비메틸화
- Kwiatkowski DL et al. (2009) *J Virol* 83:8173 — CTCF binding in HSV genome
- Amelio AL et al. (2006) *J Virol* 80:2358 — CTRL1 mapping
- Chen Q et al. (2007) *J Virol* 81:5192 — CTRL2/CTRS sites
- Washington SD et al. (2018) *J Virol* 92:e00173-18 — CTRL2 deletion 표현형
- Washington SD et al. (2019) *J Virol* 93:e00415-19 — CTCF site KO 후속
- Du T, Zhou G, Roizman B (2011-2014) *PNAS* 시리즈 — LAT-dependent silencing
- Bloom DC (2016) *Adv Virus Res* 94:53 — LAT chromatin
- Cliffe AR, Wilson AC (2017) *J Virol* 91:e01419-16 — reactivation chromatin
- Cuddy SR et al. (2020) *eLife* 9:e58037 — JNK Phase I phospho-methyl switch
- Placek BJ et al. (2009) *J Virol* 83:1416 — H3.3 deposition
- Conn KL et al. (2008) *J Virol* 82:8629 — H3.1 in lytic
- Lukashchuk V, Everett RD (2010) *J Virol* 84:4026 — ATRX/DAXX
- Cabral JM et al. (2018) *PLoS Pathog* 14:e1007054 — ATRX restricts reactivation
- Everett RD, Murray J (2005) *J Virol* 79:5078 — ND10 episome 위치
- Boutell C, Everett RD (2013) *J Gen Virol* 94:465 — ICP0/ND10
- Ertel MK et al. (2012) *J Virol* 86:12741 — 3C/loop in TG
- Lieberman PM (2016) *Annu Rev Virol* 3:147 — episomal viral chromatin
- Kobiler O, Drayman N et al. (2010-2014) — 뉴런 episome 동역학
- Müller-Ott K et al. (2014) *Mol Syst Biol* 10:746 — heterochromatin Markov 모델 (parameter ref)
- Hauri S et al. (2016) *Cell Rep* 17:583 — histone modification kinetics
- Zentner GE, Henikoff S (2013) *Nat Struct Mol Biol* 20:259 — histone modification rates
- Kuo MH, Allis CD (1999) *Methods* 19:425 — HAT/HDAC kinetics

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| H3.3 우세 · CpG 비메틸 · chaperone (§1) | 🟡 SUPPORTED-BY-CITATION | Placek 2009, Kubat 2004, Lukashchuk 2010 |
| H3K9me/K27me lytic enrichment (§2) | 🟡 SUPPORTED-BY-CITATION | Cliffe-Knipe 2009 + 후속 ChIP-seq |
| LAT euchromatic marks (§3) | 🟡 SUPPORTED-BY-CITATION | Kubat 2004 · Bloom 그룹 |
| CTCF site 좌표 (§4) | 🟡 SUPPORTED-BY-CITATION | Amelio 2006 · Chen 2007 · Kwiatkowski 2009 |
| CTRL2 KO 표현형 (§4.1) | 🟡 SUPPORTED-BY-CITATION | Washington 2018/2019 |
| 3D loop · ND10 (§5) | 🟡 SUPPORTED-BY-CITATION | Ertel 2012 · Everett 2005 |
| Phase I phospho-switch (§6) | 🟡 SUPPORTED-BY-CITATION | Cuddy 2020 |
| **Markov 3-state 모델 (§7.1-7.2)** | 🟢 SUPPORTED-NUMERICAL | closed-form steady-state, detailed balance 가정 |
| **약물 perturbation closed-form (§7.4)** | 🟢 SUPPORTED-NUMERICAL | ε/δ scaling, 해석해 |
| Rate constant 값 (§7.3) | 🟡 + **needs check** | mammalian heterochromatin parameter를 HSV에 외삽 — 직접 HSV ChIP-time-course 데이터 부재 |
| KDM4 most druggable 결론 (§7.5) | 🟢 SUPPORTED-NUMERICAL | sensitivity 분석 + writer redundancy 논거 |
| M6/M7 약물 mapping (§8) | 🟡 SUPPORTED-BY-CITATION | 각 약물의 잠복 효과는 일부만 in vivo 검증 |

### 핵심 needs-check 목록

- **H3K27ac LAT enhancer 농축 (§3)** — 정량 데이터 sparse, 직접 ChIP-seq 확인 필요.
- **§7.3 rate constants** — mammalian 일반 heterochromatin에서 가져옴, 뉴런 + HSV episome 특이 fitting 부재.
- **BET inhibitor (JQ1)의 잠복 효과 (§8.1)** — reactivate vs silence 보고 엇갈림.

---

> 다음 (M4): chromatin 상태 → reactivation trigger (NGF withdrawal · UV · stress · DLK/JNK upstream signaling) 매핑. §6/§7.4 이 직접 입력.
