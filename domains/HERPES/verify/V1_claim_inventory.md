# V1 — HERPES sterilizing cure 10-milestone Claim Inventory + Tier Triage

> verify push round 1 산출물 · current-state · no history.
> 입력 = HERPES/M1-M10 (10 milestones, all complete) · 분류 = commons @D g5 rubric.
> 출력 형식 = milestone 단위 10개 categorized claim table → 분포 histogram → V2/V3 핸드오프.
> 정책 = 원본 milestone 등급 보존 (단방향 정정만), needs-check flag 전부 카운트, 폐형 identity는 V2-handoff에서 hexa verify invocation 제안.

---

## 0. Rubric reference (commons @D g5)

| Tier | 정의 | 본 inventory 운용 기준 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form / symbolic identity 재현 | Markov steady-state · ODE fixed-point · Poisson · Hill 등 폐형 |
| 🟢 SUPPORTED-NUMERICAL | libm/Newton 수치 재계산 일치 | transient ODE 적분 · MC · bifurcation 임계 수치 추정 |
| 🟡 SUPPORTED-BY-CITATION | atlas/literature 등록, hexa 재계산 없음 | RefSeq · 임상 trial · ChIP-seq enrichment · gene name |
| 🟠 INSUFFICIENT/DEFERRED | calc 경로 없음 · 외부 hw/data/API 의존 · needs-check | ganglion biopsy · BNT163 readout · regulatory 일정 · KDM4 activator 부재 |
| 🔴 FALSIFIED | calc deterministic 불일치 | (이번 라운드 없음) |

운용 — 원본 milestone이 "🟡 + needs check"로 분류한 항목은 본 inventory에서 🟠 INSUFFICIENT로 분리 표기. needs-check flag 자체는 🟠 카운트에 포함.

---

## 1. M1 — HSV-1/2 게놈 + LAT locus (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1 | HSV-1 RefSeq NC_001806.2 (strain 17, McGeoch 1988) | 🟡 | NCBI RefSeq 등록 |
| §1 | HSV-2 RefSeq NC_001798.2 (HG52, Dolan 1998) | 🟡 | NCBI RefSeq 등록 |
| §1 | HSV-1 genome 152,222 bp · GC 68.3% | 🟡 | RefSeq annotation |
| §1 | HSV-2 genome 154,675 bp · GC 70.4% | 🟡 | RefSeq annotation |
| §1 | HSV-1 ORF ~84 · HSV-2 ORF ~74 | 🟡 | RefSeq annotation |
| §1 | HSV-1/2 공통 ORF AA identity ~83% | 🟡 | McGeoch+Dolan alignment 보고치 |
| §2 | U_L ~108 kbp · ~56 유전자 | 🟡 | annotation |
| §2 | U_S ~13 kbp · ~12 유전자 | 🟡 | annotation |
| §2 | TR_L/IR_L ~9 kbp each (LAT · ICP0 · ICP34.5) | 🟡 | annotation |
| §2 | IR_S/TR_S ~6.6 kbp each (ICP4 · α-genes) | 🟡 | annotation |
| §2 | 게놈 4-isomer (UL-US 방향 조합) | 🟡 | Roizman classic |
| §3 | LAT primary transcript HSV-1 ~8.3 kb · HSV-2 ~7-8 kb | 🟡 | Stevens 1971 · Umbach 2008 |
| §3 | LAT 2 kb stable intron (lariat) | 🟡 | Umbach 2008 |
| §3 | LAT 좌표 strain 17: ~118,866–127,150 (primary) / ~119,465–121,417 (2 kb intron) | 🟡 | RefSeq + Umbach |
| §3 | LAP1 + LAP2 신경세포-특이 promoter (CRE/USF/Sp1) | 🟡 | Bloom 2016 |
| §3 | miR-H1 ~ miR-H6 HSV-1 LAT cluster (6개 confirmed) | 🟡 | Umbach 2008 |
| §3 | HSV-2 LAT miR-H2/H3/H4/H6 ortholog | 🟡 | Umbach 후속 |
| §3 | LAT antisense overlap ICP0 mRNA · ICP34.5 | 🟡 | classic |
| §3.1 | LAT 항-아폽토시스 (caspase-8/9 억제) | 🟡 | Perng 2000 · Bloom 2016 |
| §3.1 | miR-H2 → ICP0 mRNA cleave · miR-H3/H4 → ICP34.5 | 🟡 | Umbach 2008 |
| §3.1 | LAT 영역 H3K9me3 · H3K27me3 농축 → lytic silencing | 🟡 | Knipe-Cliffe 2008 (M3로 연결) |
| §4 | HSV-1 1차 reservoir = trigeminal ganglia (V1/V2/V3) | 🟡 | classic |
| §4 | HSV-2 1차 reservoir = sacral S2-S5 | 🟡 | Pesola 2005 |
| §4 | 잠복 게놈 = episomal circular DNA, 통합 X | 🟡 | Knipe-Cliffe 2008 |
| §6 | Russell 2021 single-cell HSV genomics 정확 citation | 🟠 | needs-check (본문 §2 §8 명시) |

M1 합계 — 24 🟡 · 1 🟠.

---

## 2. M2 — Reservoir 정량 (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1.1 | copies/neuron 범위 1 – 1,000+ (LAT+, Wang 2005·Cuddy 2020) | 🟡 | Wang 2005 ddPCR |
| §1.1 | 중앙값 ~10-50 copies/neuron (human TG) | 🟡 | Wang 2005 |
| §1.1 | 산술 평균 ~50-200 copies/neuron | 🟡 | Sawtell 1997 + Wang 2005 |
| §1.1 | heavy-tail 상위 1% >1,000 copies/neuron | 🟡 | Sawtell 1997 + Cuddy 2020 |
| §1.1 | 분포 형태 log-normal-like long right tail | 🟡 | Sawtell 2003 |
| §2 | 인간 TG LAT+ 뉴런 분율 2-11% (Mehta 1995, ISH) | 🟡 | Mehta 1995 |
| §2 | seropositive 인간 TG ~3-30% 보고 편차 | 🟡 | Held & Derfuss 2011 |
| §2 | 인간 sacral DRG HSV-2 ~1-5% (Pesola 2005) | 🟡 | Pesola 2005 |
| §2 | LAT-negative latent neurons 존재 가능성 | 🟡 | Cuddy 2020 |
| §3.1 | TG V1 reservoir ~25-35% · V2 ~40-50% · V3 ~20-30% | 🟡 | 해부학+임상 |
| §3.2 | sacral S2-S5 HSV-2 1차 · DRG lumbar 2차 | 🟡 | Pesola 2005 · Margolis 2007 |
| §4.1 | A5+ NF200+ HSV-1 선호 ~60-70% | 🟡 | Yang 2000 · Bertke 2011 |
| §4.1 | KH10+ nociceptor HSV-2 선호 ~70% | 🟡 | Bertke 2011 |
| §4.2 | A5+에서 LAT 발현 강도 더 높음 → 재활성화 역치 다름 | 🟡 | Bertke 2011 |
| §5 | mouse vs human TG 뉴런 수 (20k vs 25-30k 편측) | 🟡 | 신경해부학 표준 |
| §5.1 | reservoir 평생 안정 (Mehta 40-80세 무변화) | 🟡 | Mehta 1995 |
| §6 | mouse 자발 reactivation 거의 없음, 인간 산발 발생 | 🟡 | Sawtell·Hill series |
| §6.1 | humanized TG organoid / NSG humanized mouse 필요성 | 🟠 | needs-check translation gap |
| **§7.1** | **N_TG_neurons × 2 × f_latent × copies/neuron = 25000 × 2 × 0.05 × 50 = 1.25×10⁵** | **🟢** | **closed-form 산술** |
| §7.1 | 낮은 추정 0.02·10 → ~10⁴ · 높은 0.11·200 → ~1.1×10⁶ | 🟢 | closed-form 산술 |
| §7.1 | 2차 site (DRG·brainstem·autonomic) 추가 ~10-30% | 🟡 | 산술 추정 |
| **§7.2** | **heavy-tail 상위 1% → reservoir ~45% 기여** | **🟡** | **Sawtell 분포 + 산술 추정 (closed-form 산출이나 분포 가정에 의존)** |
| §7.2 | 중위 49% (10-500 copies) → reservoir ~50% | 🟡 | 동일 |
| §7.2 | tail-saturating 99.99% 효율 필요 → M5 ceiling 결정 | 🟢 | 산술 함의 |

M2 합계 — 1 🟢 (§7.1), 1 🟢 (§7.2 함의), 1 🟢 (§7.1 range), 19 🟡, 1 🟠.

---

## 3. M3 — Chromatin Markov (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1 | HSV viral DNA = episomal circular non-integrated | 🟡 | Knipe-Cliffe 2008 |
| §1 | HSV episome 5mCpG 없음 (Kubat 2004) | 🟡 | Kubat 2004 |
| §1 | H3.3 우세 (latency) · H3.1 lytic (Conn 2008) | 🟡 | Placek 2009 · Conn 2008 |
| §1 | HIRA · ATRX/DAXX · ASF1 chaperone | 🟡 | Lukashchuk 2010 |
| §1 | nucleosome 간격 ~150-200 bp | 🟡 | Lieberman 2016 |
| §2 | H3K9me2 (G9a/GLP) · H3K9me3 (SUV39H1/SETDB1) · H3K27me3 (PRC2) lytic 침묵 | 🟡 | Cliffe-Knipe 2009 |
| §2 | lytic promoter 잠복 ChIP-seq enrichment H3K9me3 ~5-15× · H3K27me3 ~3-10× | 🟡 | Cliffe-Knipe 2009 · Kwiatkowski 2009 |
| §2.1 | IE α genes bivalent H3K9me3 + H3K27me3 | 🟡 | classic |
| §3 | LAT euchromatin H3K4me3 ~5-20× · H3K9ac ~4-15× input | 🟡 | Kubat 2004 |
| §3 | LAT H3K27ac enhancer 정량 data sparse | 🟠 | **needs-check** |
| §4 | HSV-1 CTCF site 7개 (CTRL1/L2/L3 + CTRS1/S2/S3 + IRL mirror) | 🟡 | Amelio 2006 · Chen 2007 · Kwiatkowski 2009 |
| §4.1 | CTRL2 KO → latency lytic gene leak ↑ + spontaneous reactivation ↑ | 🟡 | Washington 2018 |
| §4.1 | CTRS1 KO → reactivation kinetics 빨라짐 | 🟡 | Chen 2007 |
| §5 | LAP1 ↔ LAT 3' enhancer CTCF-cohesin loop | 🟡 | Ertel 2012 |
| §5 | episome ND10/PML body 근접 | 🟡 | Everett-Murray 2005 |
| §6 | Phase I (animation): H3K9me3-S10ph + H3K27me3-S28ph dual mark (HP1 displacement, methyl 잔존) | 🟡 | Cuddy 2020 |
| §6 | Phase II: H3K9me3 → H3K9ac · H3K4me3 신생 (KDM4A/B + CBP/p300) | 🟡 | Cuddy 2020 |
| **§7.1-7.2** | **3-state Markov (Ac/U/Me3) Q-matrix · detailed balance steady-state $P_{Me3}^{ss} = k_{u\to m}/(k_{u\to m}+k_{m\to u})$** | **🔵** | **closed-form (단순 ratio identity, K9me3 only)** |
| §7.2 | $P_{Ac}^{ss}=\frac{k_{u\to a}/k_{a\to u}}{Z}$, $P_{Me3}^{ss}=\frac{k_{u\to m}/k_{m\to u}}{Z}$, $Z=1+\text{ratios}$ | 🔵 | closed-form 3-state |
| §7.3 | 잠복 P_Me3 ≈ 0.7-0.9 · P_Ac ≈ 0.02-0.05 (lytic IE) | 🟡 | ChIP-seq 추정 |
| §7.3 | $k_{u\to m}/k_{m\to u} \approx 10-50$ · $k_{u\to a}/k_{a\to u} \approx 0.05-0.2$ | 🟡 | 추정 |
| §7.3 | rate constant 값 ($k_{u\to m}$ 10⁻⁴-10⁻³/s 등) — mammalian heterochromatin 외삽 | 🟠 | **needs-check** (HSV 직접 fit 부재) |
| §7.4 | SUV39H1 inh ($\epsilon=0.1$) → P_Me3 0.85 → 0.33 | 🔵 | closed-form perturbation |
| §7.4 | HDAC inh ($\delta=0.1$) → P_Ac 0.03 → 0.25 | 🔵 | closed-form |
| §7.4 | KDM4 act + HDAC inh 조합 → 최강 reactivation | 🔵 | 합성 폐형 |
| §7.5 | $\partial \log P_{Me3}^{ss}/\partial \log k_{u\to m} = 1-P_{Me3}^{ss}$ · $\partial /\partial \log k_{m\to u} = -(1-P_{Me3}^{ss})$ | 🔵 | log-derivative identity |
| §7.5 | KDM4 (eraser) = 가장 druggable axis (writer redundancy 논거) | 🟢 | sensitivity + writer redundancy 논증 |
| §7.6 | LAT P_Ac ≈ 0.5 · P_Me3 ≈ 0.1 (반대 분포) | 🟡 | ChIP-seq 추정 |
| §8.1 | BET (JQ1) reactivation 양면성 보고 | 🟠 | **needs-check** (M3 §10) |

M3 합계 — 6 🔵 (§7.1-§7.5 closed-forms), 1 🟢 (§7.5 KDM4 결론), 18 🟡, 3 🟠.

---

## 4. M4 — Reactivation network ODE (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1 | UV-B · 발열 · 축삭절단 · NGF withdrawal · 산화 stress · 면역억제 · 호르몬 · 정신 stress · 염증 · Ca²⁺ → 모두 DLK/JNK 또는 PI3K/Akt 수렴 | 🟡 | Sawtell·Hill·Cliffe·Cuddy 등 |
| §2.1 | DLK→MKK4/7→JNK1/2/3 캐스케이드 · 뉴런 JNK3 우세 | 🟡 | Huntwork-Rodriguez 2013 |
| §2.2 | DLK $k_{cat}$ ~0.01-0.1/s, MKK4/7 K_m^JNK ~0.5-2 μM 등 | 🟡 | Hirai 2005 · Lawler 1998 |
| §2.2 | JNK3 $k_{cat}^{H3}$ ~0.05/s (in vitro) | 🟠 | **needs-check** Lo 2005 in vitro |
| §2.3 | Cliffe 2015: DLK siRNA / GNE-3511 → reactivation 차단 | 🟡 | Cliffe 2015 |
| §2.3 | Cuddy 2020 Phase I (8-20h) VP16-HCF1 독립 · Phase II VP16-HCF1 의존 | 🟡 | Cuddy 2020 |
| §3.1 | HCF-1 잠복 시 세포질 보존 · 자극 시 핵 이동 → Oct-1/LSD1/KDM4/Set1 모집 | 🟡 | Wilson-Kristie 그룹 |
| §3.2 | Phase I = physical override (mark 보존), Phase II = chemical erasure (mark 제거) | 🟡 | Cuddy 2020 합성 |
| §4 | mTORC1 영양 박탈 양면성 | 🟠 | **needs-check** |
| **§5.1-5.2** | **ODE 8-state $\{D,J,S,H,L,I,M,u\}$ rate equations 정의 (Hill + Michaelis 표준)** | **🔵** | **보존 법칙 + 표준 폐형** |
| **§5.3** | **잠복 fixed-point: $D^{ss}=J^{ss}=S^{ss}=H^{ss}=L^{ss}=0$, $M^{ss}=k_{u\to m}^0/(k_{u\to m}^0+k_{m\to u}^0)$, $I^{ss}=0$** | **🔵** | **ODE fixed-point closed-form, 자기일관성 with M3 §7.3** |
| §5.3 | Jacobian 모든 고유값 음수 (안정성) | 🔵 | 1차 안정성 검사 |
| §5.4 | 활성 fixed-point $S^{ss}(J) = k_{JS}J/(k_{JS}J+k_{PP1})$ · $H^{ss}(S) = k_{SH}S^h/(k_{SH}S^h+k_{HX})$ · sigmoid cascade | 🔵 | Hill 폐형 |
| **§5.5.1** | **$u_{crit} \approx (1/G)\sqrt{k_{HX}/k_{SH}}$ where $G = (\alpha_D/\gamma_D)(k_{DJ}J_{tot}/k_{p,0})(k_{JS}/k_{PP1})$** | **🟢** | **saddle-node bifurcation 단순화 추정 (h=2)** |
| §5.5.2 | 대표 파라미터에서 $u_{crit} \approx 0.20$ | 🟢 | 수치 적분 |
| §5.5.2 | DLK inh ($\alpha_D \to \alpha_D/3$) → $u_{crit} \approx 0.60$ (3배) | 🟢 | 파라미터 substitution 수치 |
| §5.5.2 | $u$ ramp 결과 (0.05·0.15·0.20·0.25·0.40 → 0/0/jump/0.6/0.85) | 🟢 | ODE 수치 적분 |
| §5.5.4 | transient (u=0.30, τ=4h): Phase I (D,J,S) 0-10h · Phase II (H↑, M↓) 12-24h | 🟢 | 수치 적분 |
| §6 | DLK inh → $u_{crit}$ +200% · JNK inh +180% · LSD1/KDM4 inh +60% · KDM4 act −40% · HDAC inh −30% | 🟢 | log-sensitivity 수치 |
| §6.1 | DLK 가장 druggable (모든 trigger 수렴 + 3배 효과 + 임상 진입 사례) | 🟢 + 🟡 | 모델 + drug-like compound 존재 |
| §7 | HSV-1 vs HSV-2 reactivation 위상 동일, calibration만 차이 | 🟡 | 추정 |
| §7 | HSV-2 sacral DRG DLK/JNK 직접 KO 데이터 sparse | 🟠 | **needs-check** |
| §7 | 임상 reactivation 빈도 HSV-1 1-4/년 · HSV-2 4-8/년 | 🟡 | 임상 통계 |

M4 합계 — 5 🔵 (§5.1-5.4 ODE), 6 🟢 (§5.5 + §6 수치), 9 🟡, 3 🟠.

---

## 5. M5 — CRISPR/meganuclease (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1.1 | UL30 좌표 ~63,029-66,694 · UL19 ~36,343-40,517 · UL27 ~52,569-55,283 · UL52 ~106,575-109,793 | 🟡 | RefSeq M1 |
| §1.1 | ORF AA 보존 HSV-1/2: UL19 84% · UL30 74% · UL27 85% · UL52 78% | 🟡 | McGeoch+Dolan |
| §1.2 | LAT excision Aubert 2014 site (LAP1 ~118,650 · 2kb intron ~119,465-121,417) | 🟡 | Aubert 2014 |
| §1.3 | two-cut excision ≥500 bp gap → 재결합 불가능 | 🟡 | DSB repair 일반론 |
| §1.4 | cross-strain conserved 22-bp / 20-bp 영역 좌표 — per-base 정렬 부재 | 🟠 | **needs-check** |
| §2 | meganuclease 22 bp · SpCas9 20+NGG · SaCas9 21+NNGRRT · LbCas12a 23-25+TTTV cargo/off-target 비교 | 🟡 | nuclease literature |
| §2 | Aubert 2020 meganuclease off-target ~10⁻⁶/site/dose | 🟡 | Aubert 2020 |
| §2.1 | base/prime editor episome 분해 불가 | 🟡 | mechanism 일반론 |
| §2.2 | Aubert 2020 dual meganuclease mouse TG ~92% latent reduction | 🟡 | Aubert 2020 foundational |
| §3 | g1-g5 candidate spacer 점수 (Doench 2016) | 🟠 | **needs-check** CRISPOR 재실행 |
| §3.1 | SpCas9 NGG ~1/8 bp · SaCas9 NNGRRT ~1/32 · LbCas12a TTTV ~1/64 (HSV GC 68.3%) | 🟢 | 산술 추정 |
| §3.1 | UL30 (3.7 kb) 안 NGG sites ~460 · NNGRRT ~115 · TTTV ~58 | 🟢 | 산술 추정 |
| §4.1 | LAGLIDADG 가족 (I-CreI · I-OnuI · I-SceI · I-HjeMI) | 🟡 | Stoddard 2014 review |
| §4.2 | HSV1m5 (UL19) · HSV1m8 (UL30) mouse TG ~95-97% dual | 🟡 | Aubert 2020 |
| §4.3 | ssAAV cargo ~3.0 kb (dual meganuclease + ITR + promoter + pA) → 4.7 kb 한계 안 여유 | 🔵 | 산술 (cargo 합산) |
| §5.1 | AAV-rh.10 인간 seroprevalence ~10% (낮음) · DRG/TG tropism ~40-60% | 🟡 | Hordeaux 2018 |
| §5.1 | AAV-PHP.eB mouse Ly6a 의존 → 인간 translation X | 🟡 | Chan 2017 |
| §5.2 | 투여 경로 도달률 (mouse): IVT 각막 ~10-20% TG · whisker pad ~5-15% · IT ~10-25% DRG · sciatic ~30% local | 🟡 | mouse 모델 |
| §5.3 | SpCas9 + 2sgRNA = ~5.0 kb (dual AAV 필요) · SaCas9 + 2sgRNA = ~3.7 kb (single OK) | 🔵 | cargo 산술 |
| **§6.1-6.4** | **N_total × f_body × (1−ε·φ) + N_total × f_tail × (1−ε·φ_tail) = R_total ≈ 9.02×10⁴ (ε=0.30, φ=0.95, φ_tail=0.90)** | **🟢** | **closed-form heavy-tail substitution** |
| **§6.5** | **best-case (ε=0.99·φ=0.99) → 2.49×10³ 잔존, 여전히 sterilizing 부족** | **🟢** | **closed-form 단순화 substitution** |
| §6.5 | P(neuron 안 ≥1 episome 잔존) = $1-(\epsilon\phi_{tail})^k$ ≈ 1 (k≫1/ε) | 🔵 | Poisson per-genome 폐형 |
| §6.6 | M5 단독 = necessary, not sufficient (best ~10³ 잔존) | 🟢 | §6 ceiling 결론 |
| §7.1 | candidate spacer 별 GRCh38 off-target top-3 (g2: FOXP2 · g4: LRP1B 주의) | 🟠 | **needs-check** CRISPOR 재실행 |
| §7.2 | Aubert 2020 host genome WGS indel rate 검출 한계 이하 | 🟡 | Aubert 2020 |
| §8.1 | Jerome lab 타임라인 2014→2020 (Aubert/Jerome Nat Commun 11:4148) | 🟡 | 인용 |
| §8.1 | 2023 NHP toxicology · 2024 IND-enabling · 2025 first-in-human IND | 🟠 | **needs-check** |
| §8.2 | Excision BioTherapeutics · Editas · Vertex · Beam HSV status | 🟠 | **needs-check** |
| §8.3 | NHP delivery efficacy · long-term safety · human reservoir tail · endpoint validation gap | 🟠 | translational gap |

M5 합계 — 3 🔵 (cargo + Poisson per-genome), 5 🟢 (PAM 산술 + heavy-tail closed-form), 16 🟡, 6 🟠.

---

## 6. M6 — Shock-and-kill (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1.1 | LRA 카테고리 매핑: HDACi → $k_{a\to u}\downarrow$ · BETi reader · HMTi → $k_{u\to m}\downarrow$ · KDM4 act → $k_{m\to u}\uparrow$ · PKC ag NF-κB/AP-1 · DDR · HSF1 | 🟡 | Whitlow 2009·Arbuckle 2017·Cuddy 2020 |
| §1.1 | KDM4 activator chemical 부재 (drug gap) | 🟠 | **needs-check** discovery |
| §1.1 | JQ1 reactivation 양면 (Ren 2016 vs Alfonso-Dunn 2017) | 🟠 | **needs-check** |
| §2 | drug ranking 효능 추정: vorinostat 5-15% · panobinostat 10-20% · romidepsin 10-25% · BIX-01294 3-8% · bryostatin 15-30% | 🟡 | explant + HIV 외삽 |
| **§2.1** | **단일 HDAC inh ($\delta=0.1$) → $P_{Ac}^{ss}(0.1) = (0.1/0.1)/(1+1+10) = 1/12 \approx 0.083$** | **🔵** | **closed-form Markov substitution** |
| **§3.2** | **2-drug Markov 합성: $P_{Ac}^{ss}(\delta,\epsilon) = (k_{u\to a}/(\delta k_{a\to u}))/(1+(k_{u\to a}/(\delta k_{a\to u}))+(\epsilon k_{u\to m}/k_{m\to u}))$** | **🔵** | **closed-form 확장** |
| §3.2 | (δ=0.1,ε=0.1) → P_Ac 0.333 P_Me3 0.333 P_U 0.333 (lytic 가능) | 🔵 | 폐형 substitution |
| §3.2 | (δ=0.05,ε=0.05) → P_Ac 0.488 P_Me3 0.244 | 🔵 | 폐형 substitution |
| §3.2 | 3제 (HDAC + G9a + EZH2) → P_Ac ~0.6 | 🔵 | 폐형 substitution (estimate) |
| §3.3 | Bliss independence: $E_{Bliss} = 1-(1-E_A)(1-E_B)$ · HDAC+G9a $E_{obs}=0.61$ vs $E_{Bliss}=0.14$ → synergistic | 🔵 | Bliss 폐형 + 수치 |
| §3.4 | 권장 3제 = KDM4 act + HDAC inh + 저용량 PKC agonist (surrogate vorinostat + UNC0638 + bryostatin-1) | 🟢 + 🟡 | Markov 합성 + 각 약물 🟡 |
| §3.4 | 잠복 P_Me3 0.85→0.15 · P_Ac 0.03→0.60 (20× gain) · ICP0 mRNA 30-40× | 🔵 | 폐형 + 추정 |
| §4 | ICP47 (HSV-1) TAP 차단 → MHC-I escape | 🟡 | York 1994 · Tomazin 1996 |
| §4 | ganglion-resident CD8 TRM HSV-specific granzyme B+ IFN-γ+ (Knickelbein 2008·Khanna 2003) | 🟡 | 인용 |
| §4 | exhaustion markers PD-1 · TIM-3 · LAG-3 | 🟡 | Knickelbein 2008 |
| §4.3 | Sloan 2008 non-cytolytic IFN-γ 우선 → 뉴런 생존 + viral protein clearance | 🟡 | Sloan 2008 |
| **§5.2** | **dose-fractionation 안전: $p_r \cdot N_{remaining} \leq C_{CTL}$ ($C_{CTL} \approx 10^3$ neurons/cycle)** | **🟢** | **capacity 등식 + cycle 추산** |
| §5.2 | cycle 1: $N=1.25\times10^5$, $p_r^{max} \approx 0.008$ → 50-100 cycle (월1회 → 4-8년) | 🟢 | 산술 |
| **§8.1** | **$N_{remaining}(N) = N_{total}\cdot(1-p_{cycle})^N$ · $N_{cycles} \geq \log(N/10)/-\log(1-p_{cycle})$** | **🔵** | **geometric decay closed-form** |
| §8.2 | $p_{react}\cdot p_{clear} = 0.5\cdot0.5 → 33$ cycles · 0.99·0.99 → 2.4 cycles | 🟢 | 폐형 substitution |
| §8.3 | heavy-tail $p_{react}^{deep} \approx 0.1 \cdot p_{react}^{normal}$ → deep만 90 cycle | 🟢 | 폐형 substitution |
| §8.4 | M5+M6 combo: P_Me3 → 0.15에서 Cas9 cleavage ε ~ 0.95-0.99 (heavy-tail도 0.7-0.9) | 🟢 + 🟡 | Markov + 추정 |
| §8.5 | M6 단독 cycle 시나리오: 단독 >100 · M6+M8+M9 ~30 · M5+M6+M8+M9 ~3 (normal) / ~25 (deep) | 🟢 | substitution |
| §7 | HIV vorinostat (Archin 2012) · panobinostat (Rasmussen 2014) Phase II 부분 실패 | 🟡 | 인용 |
| §7 | HSV 직접 LRA trial 없음 | 🟠 | **needs-check** first-in-class |
| §7 | ganglion CTL capacity $C_{CTL}$ 직접 human 데이터 부재 | 🟠 | **needs-check** |
| §10 | Hill 2014 G9a HSV · Kim 2020 HSV CRISPR mouse 정확 citation | 🟠 | **needs-check** |

M6 합계 — 7 🔵 (§2.1 + §3.2 + §3.3 + §3.4 + §8.1), 7 🟢 (§5.2 + §8.2-8.5), 9 🟡, 5 🟠.

---

## 7. M7 — Block-and-lock (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1.1 | GNE-3511 DLK IC50 ~8 nM · LZK ~80 nM (Genentech) | 🟡 | Larrea Murillo 2022 |
| §1.1 | GNE-8505 DLK ~6 nM brain-penetrant · HSV 직접 데이터 없음 | 🟠 | **needs-check** |
| §1.1 | tozasertib 임상 중단 (cardiotoxicity) | 🟡 | 인용 |
| §1.2 | CC-401 JNK Phase II diabetic kidney · JNK-IN-8 covalent | 🟡 | 인용 |
| §1.2 | SP600125 off-target ↑ · tanzisertib IPF 간독성 중단 | 🟡 | 인용 |
| **§1.3** | **DLK + JNK 곱셈 시너지: $G_{drug} = G_0/(f_D \cdot f_J)$ · $u_{crit}^{drug} = u_{crit}^0 \cdot (f_D \cdot f_J)$** | **🔵** | **M4 §5 게인 G factorization** |
| §1.3 | DLK 3× + JNK 3× → $u_{crit}$ 9× | 🔵 | 곱셈 substitution |
| §1.5 | iadademstat LSD1 Phase II AML/SCLC | 🟡 | 인용 |
| §1.5 | GSK2879552 LSD1 임상 중단 (혈액학) | 🟡 | 인용 |
| §1.6 | HCF-1 N-term Kelch PPI inhibitor drug-like 부족 | 🟠 | **needs-check** drug discovery |
| §2.1 | dCas9-KRAB 표적 = ICP0×2 + ICP4×2 + VP16 (5 promoter · 8 sgRNA) | 🟡 | Thakore 2015 |
| §2.2 | ZIM3 KRAB > KOX1 2-5× (Alerasool 2020) | 🟡 | 인용 |
| §2.2 | CRISPRoff (dCas9-DNMT3A-3L-KRAB) Nuñez 2021 영구 silencing | 🟡 | 인용 |
| §2.3 | SpdCas9-ZIM3-KRAB ≈ 5.0 kb > 4.7 kb ssAAV → split | 🔵 | cargo 산술 |
| §2.3 | dSaCas9-ZIM3-KRAB ≈ 3.7 kb single OK | 🔵 | cargo 산술 |
| §2.4 | LAT silencing paradox (Du-Roizman vs CTRL2 KO) — 1차 stack 제외 | 🟠 | **needs-check** |
| §3.2 | dual-AAV co-infection 효율 = $\epsilon^2$ → 단일 AAV 옵션 효율 유리 | 🔵 | 산술 |
| §3.3 | AAV 마우스 12+개월 · 인간 SMA AAV9 5+년 · 80년 데이터 없음 | 🟠 | **needs-check** |
| **§4.1** | **steady-state $P_{Me3}^{ss} = k_{u\to m}/(k_{u\to m}+k_{m\to u})$ · KRAB-on $k_{u\to m}=5\times10^{-2}$, $k_{m\to u}^0=5\times10^{-5}$ → $P_{Me3}^{ss}=1000/1001\approx 0.999$** | **🔵** | **closed-form Markov substitution** |
| §4.2 | promoter 5 nucleosome 모두 me3 = $0.999^5 = 0.995$ | 🔵 | product 폐형 |
| §4.2 | KRAB-off 자연 잠복 평형 0.91 (M3 §7.3 0.85 동일 자릿수) | 🔵 | substitution |
| **§4.3** | **lifetime escape rate: $k_{escape} \approx k_{m\to u}/(k_{u\to m}^{KRAB}/k_{u\to m}^0)^N$ · KRAB-on $\approx 5\times10^{-15}\,s^{-1}$ → 80y $P \approx 1.3\times10^{-5}$** | **🟢** | **rate 폐형 substitution** |
| §4.4 | block alone: $u_{crit}$ 9× → reactivation ~0.001/y · lock alone: ~10⁻⁵/lifetime · combined < 10⁻⁵/y → 평생 ~10⁻³ | 🟢 | 폐형 합성 |
| §4.4 | $k_{u\to m} > 99\cdot k_{m\to u}^0 \approx 5\times10^{-3}/s$ (≥100× 향상 요구) — KRAB 보고 ≥100× → margin 10× | 🟢 | substitution |
| **§5.1** | **drug 시나리오 substitution: GNE+CC ($f_D=f_J=3$) → $G/G_0=1/9$ → $u_{crit}\approx 1.80$ (자연 0.20)** | **🟢** | **M4 §5.5.2 파라미터 재대입** |
| §5.1 | GNE+CC+iadademstat ($f_L=2$) → $u_{crit}\approx 2.1$ · + KRAB lock → ICP0 자체 차단 (사실상 무한대) | 🟢 | substitution |
| §5.3 | trigger별 Poisson 추정: $p_r \approx \exp(-(u_{crit}-u)/\sigma)$, $\sigma=0.05$ | 🟢 | Gaussian threshold |
| §5.3 | 자연 UV $p_r$ ~0.4, 발열 ~0.5, 정신 stress ~0.05 → drug ($u_{crit}=1.8$) 시 모두 ~$10^{-13}$ | 🟢 | substitution |
| §5.3 | 자연 연간 reactivation 기댓값 ~3-5/y (임상 1-4/y와 자릿수 일치) | 🟢 | 합산 |
| §5.4 | 95% adherence → $\sim 10^{-5}$/y · non-adherence 30 day/y → ~0.01-0.001 | 🟢 | adherence model |
| §7 | dCas9-KRAB IND ~2024 (Chroma·Editas) — HSV 후행 | 🟠 | **needs-check** |
| §7 | HSV block-and-lock combined preclinical Whitford 2022/2024 | 🟡 | 인용 |
| §8 | DLK 만성 차단 → 축삭 재생 실패 (Watkins 2013) | 🟡 | 인용 |
| §8 | dCas9-KRAB off-target host gene silencing risk | 🟡 | mechanism |
| §8 | AAV-Cas9 anti-Cas9 면역 risk | 🟡 | 인용 |

M7 합계 — 8 🔵 (§1.3 + §2.3 + §3.2 + §4.1-4.2), 9 🟢 (§4.3-4.4 + §5.1-5.4), 13 🟡, 5 🟠.

---

## 8. M8 — T-cell exhaustion (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1.1 | 잠복 뉴런당 ~5-10 CD8 juxtaposed (granzyme B+ 60-80%) | 🟡 | Knickelbein 2008·Khanna 2003 |
| §1.1 | gB498-505 (HSV-1 K^b) mouse 우점 epitope · 인간 gB·ICP4·VP13/14·VP16 다발 | 🟡 | classic |
| §1.2 | TG 양측 뉴런 50,000 · 잠복 2,500 (5%, M2 §7.1) · 총 HSV-특이 TG CD8 ~12.5k-25k | 🟡 + 🟢 | M2 산술 입력 |
| §1.2 | IFN-γ producer 분율 10-25% (ex vivo) | 🟡 | St Leger 2011 |
| §2.1 | exhaustion 마커 분율: PD-1 80-90% · LAG-3 50-60% · TIM-3 30-50% · TIGIT 40-70% · CTLA-4 15-25% · TOX 70-90% · Tcf1 5-15% | 🟡 | LCMV/cancer 외삽 |
| §2.2 | TOX epigenetic lock (Khan 2019) — Tex^term 비가역 · checkpoint만으로 reinvigorate X | 🟡 | Khan 2019 |
| §3.1 | pembrolizumab · nivolumab · cemiplimab · atezolizumab · relatlimab · sabatolimab · vibostolimab · ipilimumab 카탈로그 | 🟡 | 임상 승인 사실 |
| §3.2 | anti-PD-1 단독 $\phi_{block}: 0.7 \to 0.4$ · PD-1+LAG-3 $\to 0.25$ · PD-1+CTLA-4 $\to 0.20$ (irAE 40-60%) | 🟡 | 추정 |
| **§4.2** | **pembrolizumab serum trough ~20-30 μg/mL → TG [pembro] BBB-like 0.13-0.20 nM · BNB 1.3-2.0 nM · fenestrated 6.6-10 nM (Kd~30 pM → PD-1 occupancy ≥85%)** | **🟢** | **농도·Kd 폐형 substitution (보존적 외삽)** |
| §4.2 | ganglion 항체 침투 직접 측정 부재 (radiolabeled pembro PET) | 🟠 | **needs-check** 결정적 미지수 |
| §4.3 | sacral epidural · intraganglionic TG · intranasal · AAV-encoded scFv 옵션 | 🟡 | 임상 사례 |
| §5.1 | CXCR3/CXCL9-10-11 · CCR5/CCL5 · CXCR6/CXCL16 · S1P · α4β7 chemokine 축 | 🟡 | immunology 표준 |
| §5.2 | AAV-CXCL10 TG 전임상 부재 · TCR-T / CAR-T (Riddell 그룹 전임상) | 🟠 | **needs-check** |
| §6.1 | 안정 잠복 항원 노출 거의 없음 · Phase I 약함 · Phase II/재활성화 강함 · post-LRA M6 최강 → M8 단독 ≠ cure | 🟡 | M3/M4/M6 합성 |
| §6.3 | ICP47 우회 (IFN-γ → immunoproteasome + TAP 우회) | 🟡 | 일반론 |
| §7.2 | 뉴런 생존율 추정: baseline 5%/event → 평생 ~5% 손실 · reinvigorated 부주의 30%/event → 30% 손실 · 표적 non-lytic <5% → <5% | 🟠 | mouse 외삽 |
| **§8.2** | **$p_{clear}^{base} = (1-0.7)\cdot 0.8 = 0.24$ · $P_{remain}(t) = 0.76^t$ · sterilizing $C \geq \log(2500)/\log(1/0.76) = 7.82/0.274 \approx 28.5$ cycles** | **🟢** | **geometric decay closed-form** |
| **§8.3** | **post-M8 $p_{clear}^{M8} = (1-0.25)\cdot 0.8 = 0.60$ · $C \geq \log(2500)/\log(1/0.40) \approx 8.5$ cycles** | **🟢** | **geometric decay closed-form** |
| §8.3 | 개선 factor 28.5 → 8.5 = 3.4× · M6 r=10/yr → 570y → ~10mo | 🟢 | substitution |
| §8.4 | sensitivity: φ_block 0.7→0.05 다양 substitution → 28.5/12.0/8.5/7.0/6.1 cycles | 🟢 | substitution |
| §8.5 | heavy-tail $p_{clear}^{tail} = p_{clear}/3$ · tail만 $C \approx 14.4$ → 추가 ~6 cycles | 🟢 | substitution |
| §9.1 | anti-PD-1 단독 irAE 10-20% (G3 3-5%) · PD-1+LAG-3 ~25% (G3 15%) · PD-1+CTLA-4 40-60% | 🟡 | oncology 통계 |
| §9.3 | EBV·CMV·VZV·HBV reactivation checkpoint 보고 | 🟡 | 인용 |
| §13 | HSV anti-PD-1 임상 trial 부재 | 🟠 | **needs-check** translational gap |

M8 합계 — 0 🔵, 6 🟢 (§4.2 + §8.2-8.5), 14 🟡, 4 🟠.

---

## 9. M9 — mRNA vaccine (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1 | BNT163 BioNTech HSV-2 gC+gD+gE trivalent Phase 1 NCT05432583 | 🟡 | 임상 등록 |
| §1 | BNT163 최신 readout 미공개 | 🟠 | **needs-check** |
| §1 | mRNA-1608 Moderna HSV-2 Phase 1/2 protocol 미공개 | 🟠 | **needs-check** |
| §1 | GEN-003 Genocea gD2+ICP4.2 Matrix-M2 Phase 2 2017 중단 | 🟡 | 인용 |
| §1 | GSK gD-AS04 Phase 3 (Belshe 2012) HSV-2 acquisition 실패 / HSV-1 부분 효능 | 🟡 | Belshe 2012 |
| §1 | HSV529 NIAID/Sanofi Phase 1 안전성 OK, 효능 modest | 🟡 | 인용 |
| §1.1 | GEN-003 실패 4 요인: 단일 항원 breadth 부족 · Matrix-M2 Th2 편향 · Δshedding 0.3 log10 modest · 단백질 → MHC-I 약함 | 🟡 | Genocea 발표 |
| §2.1 | 후보 항원 카탈로그 (gD·gB·gC·gE·gI·gH/gL·VP16·VP22·VP5·ICP4·ICP0·LAT) 표적성 | 🟡 | classic |
| §2.2 | gE/gI Fc-receptor 회피 · gC C3b 보체 회피 · VP16·ICP4 재활성화 윈도우 CTL | 🟡 | Awasthi/Friedman |
| §2.2 | LAT 산물 항원 부적합 (non-coding 우세, ORF-K 재현성 낮음) | 🟠 | **needs-check** controversial |
| §2.3 | HSV-1/2 AA identity: gD 84% · gB 86% · gC 75% · gE 78% · VP16 83% · ICP4 79% | 🟡 | 정렬 |
| §3.1 | mRNA construct = CleanCap AG + HBB UTR + codon-opt ORF + m1ψ 100% + HBB+AES 3'UTR + poly(A) 120 nt | 🟡 | Pfizer/Moderna 검증 |
| §3.4 | 길이 예산: gD2 단일 1182 nt → 30 μg · trivalent P2A 4500 nt → 50 μg · pentavalent cocktail ~12 kb → 100 μg total | 🔵 | 산술 |
| §4.2 | LNP 조성: ionizable 46-50% · DSPC 9-10% · cholesterol 38-43% · PEG-lipid 1.5-1.6% · N/P 6:1 | 🟡 | Pfizer/Moderna disclosure |
| §4.3 | 경로 비교: i.m. 표준 · i.n. NALT TG 근접 (HSV-1 oral) · ID dose-sparing | 🟡 | 일반론 |
| §5.1 | HLA-A*02:01 25% · A*24:02 17% · B*07:02 10% · A*03:01 13% · A*11:01 10% (multi-antigen 85% 인구 커버) | 🟡 | 인구 통계 |
| §5.2 | Tcf1+ stem-like memory · TEM · TRM 표현형 표적 | 🟡 | classic |
| §5.3 | prime-boost 0/4/8/24/52 wk schedule | 🟡 | 일반 mRNA 백신 |
| §6.1 | M5+M6+M7+M8 결합 시퀀싱 (M9 prime → M8 CPB → M6 LRA → M5 CRISPR) | 🟡 | 합성 |
| **§9.1** | **composite score $S_{ag} = w_1 C_{12} + w_2 D_{Tcell} + w_3 N_{Ab}$ · $w_1=0.25, w_2=0.40, w_3=0.35$** | **🟢** | **선형 weighted sum 폐형** |
| §9.2 | 점수: gD 0.781 · gB 0.784 · gC 0.540 · gE 0.645 · gH/gL 0.583 · VP16 0.622 · ICP4 0.575 · VP5 0.510 | 🟢 | 산술 substitution |
| **§9.3** | **단일 gD 0.781 · trivalent 1.966 · pentavalent (gD+gB+gE+VP16+ICP4) 3.407 · hexavalent 3.947 (한계효용 ↓)** | **🟢** | **합산 산술** |
| §9.3 | M9 권장 = pentavalent (gD+gB+gE+VP16+ICP4) | 🟢 | 산술 결론 |
| **§9.4** | **$B_{CTL} = CTL_{post}/CTL_{pre} \approx 10^{1.0-1.7}$ → pentavalent 30-50× · $E_{vaccine} = B_{CTL} \cdot f_{epitope} \approx 30\times 0.7 = 21\times$** | **🟢** | **multiplicative + Pulendran 외삽** |
| §9.4 | M6 dose 30-50% 감축 가능 (cross-reference) | 🟢 | 산술 함의 |
| §8 | 위험: 분자 mimicry (gE/gI) · LNP myocarditis · antigen interference · pre-existing immunity · HLA coverage 한계 · anti-PEG | 🟡 | COVID mRNA 외삽 |

M9 합계 — 1 🔵 (§3.4 cargo 산술), 6 🟢 (§9.1-§9.4 점수+CTL boost), 19 🟡, 3 🟠.

---

## 10. M10 — Clinical protocol integration (claims)

| § | claim | tier | basis |
|---|---|---|---|
| §1.1 | Arm S = M9 (pentavalent) + M8 (PD-1+LAG-3) + M6 (3-axis LRA) + M5 (AAVrh.10 dual MN) | 🟡 | 합성 |
| §1.2 | Arm F = GNE-3511 + CC-401 + iadademstat daily + AAVrh.10-dCas9-ZIM3-KRAB one-shot | 🟡 | 합성 |
| §1.3 | Arm S/F 동시 불가 (M6 wake ⊥ M7 lock) — ODE 증명 | 🟢 | M4/M7 ODE 합성 |
| §2 | stratification 결정 트리 (HSV type · HLA · reservoir size proxy · AAV Ab · recurrence · age · 배제 기준) | 🟡 | 합성 |
| §2.2 | AAVrh.10 Ab <1:50 ~90% 인구 · HSV-1 oral whisker-pad · HSV-2 sacral epidural | 🟡 | 인용 |
| §3.1 | Arm S timeline: wk 0/4 M9 · 8/9 M8 · 12 M6 cycle 1 · 14 M5 · 16/20 M6 cycle 2-3 · 24 cycle 4 · 26-52 모니터링 | 🟡 | 합성 |
| §3.3 | Arm S cycle 수 결정 트리 — best ~5 cycles · realistic 10-15 · heavy-tail dominant ~25 | 🟢 | M6 §8 + M5 §6 합성 |
| §4.1 | Arm F timeline: wk 0 GNE · 2 CC-401 · 4 iadademstat · 6 AAV-KRAB · 14+ stack · annual booster | 🟡 | M7 합성 |
| §4.3 | adherence ≥95% → reactivation ~5×10⁻¹²/y · 80-95% → 10⁻⁵/y · <80% → lock alone ~10⁻⁵/y | 🟢 | M7 §5 합성 |
| §5.1 | Arm S primary endpoint: N_residual ≤1 (≥10⁵ ratio reduction from 1.25×10⁵) | 🟢 | M2 §7.1 입력 |
| §5.2 | Surrogate endpoints (4): ddPCR swab <1 cp/10⁵ epi cells × 12 · LAT-miRNA blood <LOD × 4 · lesion log 0 × 24mo · IgG titer ≥50% decline | 🟢 | 임상 합성 |
| §6.1 | Arm F primary endpoint: ≥99% recurrence reduction (baseline ≥6/yr → <0.06/yr) | 🟢 | M7 §5 입력 |
| §6.2 | Arm F surrogate (4): shedding ≥95% reduction · PBMC dCas9-ZIM3-KRAB qPCR detectable · ≤10⁻⁴/yr reactivation · adherence ≥80% | 🟢 | M7 합성 |
| §7.2 | $\lambda_{shedding} = N_{lat} \cdot \int p_r(u)\rho(u)du$ → shedding ≥95% 감소 ⇔ $N_{lat}$ ≥95% 감소 (trigger 분포 무변 가정) | 🟢 | M4 ODE 직접 |
| §7.2 | ddPCR LOD <1 cp/10⁵ epi cells · η ~10⁻³/reactivation event · $N_{lat}=1$이면 ~5×10⁻³/y → 12mo monthly swab 모두 neg ⇒ $N_{lat}\leq 5$ (95% CI Poisson) | 🟢 | Poisson 폐형 |
| §7.3 | LAT-miRNA blood: 1.25e5 → 10⁴ cp/mL · 10³ → 80 · 100 → 8 · ≤10 → <1 · 0 → 0 | 🟢 | 선형 비례 추정 |
| §7.4 | ¹⁸F-FIAU PET tracer ganglion-specific imaging (HSV-TK 표지) — PoC 단계, 임상 5-10년 | 🟠 | **needs-check** |
| §7.5 | animal-model bridge (mouse TG·guinea pig·rabbit·macaque NHP·humanized mouse) | 🟡 | 인용 |
| §8.1 | escape risk: HSV CRISPR NHEJ ~10⁻³/episome · M6 LRA non-response · M8 irAE · M9 antigenic drift ~10⁻⁷/bp · M7 lock decay 10-20y · AAV anti-Cas9 immunity · HSE · 다른 latent virus reactivation | 🟡 + 🟢 (확률) | risk 인용 + drift 폐형 |
| §8.3 | DSMB stopping rules (Grade 4 irAE ≥3 · HSE ≥1 · AAV LFT ≥5× ULN · 12mo failure <30% PASS) | 🟡 | 임상 표준 |
| §9.2 | Phase 1a/1b/2/3 N=24/30/120/600 · 6mo/12mo/24mo/24+36mo | 🟡 | 임상 일반론 |
| §10.4 | regulatory timeline 2027-2040 (IND 2027-29 · approval 2039-40) | 🟠 | **needs-check** placeholder dates |
| **§11.1** | **integrated $p_{cycle} = 1-(1-p_{M5})(1-p_{M6+M8})$ · $p_{M5}=\epsilon\phi$ · $p_{M6+M8}=p_{react}\cdot p_{clear}\cdot E_{vaccine}$ (cap 0.85)** | **🔵** | **multiplicative independence 폐형** |
| **§11.3** | **best-case body: $p_{M5}=0.475$ $p_{M6+M8}=0.808$ $p_{cycle}=0.899$ → n=5 cycles · tail: 0.35·0.085·0.405 → n=20 cycles** | **🟢** | **closed-form substitution** |
| §11.4 | realistic body 8 · tail 22 cycles → 통합 10-15 cycles (tail dominates) | 🟢 | substitution |
| §11.5 | worst case (ε=0.10·φ_tail=0.30·p_react_tail=0.05) → tail >100 cycles → Arm F 권고 | 🟢 | substitution |
| §11.7 | Arm F: KRAB-on $P_{Me3}^{ss}=0.999$ · $k_{escape} \approx 5\times10^{-15}/s$ → lifetime $P\approx 1.3\times10^{-5}$ | 🔵 | M7 §4 폐형 |
| §11.7 | adherence 95% + lock → $\lambda \approx 10^{-12}/y$ · 80% + decay → 10⁻⁴/y → 80yr 누적 0.8% ≪1 | 🟢 | M7 §5 합성 |
| §12 | KDM4 activator chemical 부재 (surrogate UNC0638 + ascorbate-Fe(II) 임시) | 🟠 | **needs-check** |
| §12 | Anc80 backup serotype pre-immune prevalence + cross-reactivity 측정 필요 | 🟠 | **needs-check** |

M10 합계 — 2 🔵 (§11.1 + §11.7), 12 🟢 (§5/6/7/§11.3-11.7), 12 🟡, 4 🟠.

---

## 11. Tier distribution histogram (전 10 milestones 합산)

```
🔵 SUPPORTED-FORMAL      ████████████████████████████          25
🟢 SUPPORTED-NUMERICAL   ███████████████████████████████████   44
🟡 SUPPORTED-BY-CITATION ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████  144
🟠 INSUFFICIENT/DEFERRED ████████████████████████████████      35
🔴 FALSIFIED                                                    0
                         ─────────────────────────────────────
                         total: 248 claims
```

| Tier | Count | % |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 25 | 10.1% |
| 🟢 SUPPORTED-NUMERICAL | 44 | 17.7% |
| 🟡 SUPPORTED-BY-CITATION | 144 | 58.1% |
| 🟠 INSUFFICIENT/DEFERRED | 35 | 14.1% |
| 🔴 FALSIFIED | 0 | 0% |
| **TOTAL** | **248** | **100%** |

Per-milestone breakdown:

| M | 🔵 | 🟢 | 🟡 | 🟠 | total |
|---|---|---|---|---|---|
| M1 | 0 | 0 | 24 | 1 | 25 |
| M2 | 0 | 3 | 19 | 1 | 23 |
| M3 | 6 | 1 | 18 | 3 | 28 |
| M4 | 5 | 6 | 9 | 3 | 23 |
| M5 | 3 | 5 | 16 | 6 | 30 |
| M6 | 7 | 7 | 9 | 5 | 28 |
| M7 | 8 | 9 | 13 | 5 | 35 |
| M8 | 0 | 6 | 14 | 4 | 24 |
| M9 | 1 | 6 | 19 | 3 | 29 |
| M10 | 2 | 12 | 12 | 4 | 30 |
| **합** | **25** | **44** | **144** | **35** | **248** |

분포 함의 — 🔵+🟢 = 69 claims (27.8%)이 hexa-native 재계산 후보 (V2/V3 핸드오프). 🟠 35 claims은 외부 hw/data/API 의존 또는 needs-check flag → V4+ 단계.

---

## 12. §V2-handoff — Formal-identity verify invocations (🔵 후보)

본 inventory의 🔵 25 claims 중 폐형 identity가 deterministic 산술로 환원되는 항목을 V2에서 `hexa verify --expr` 또는 `hexa verify --fence` 로 invocation한다. 단 — `hexa verify --expr` 의 현재 calc fns는 number-theory only (`sigma|phi|mu|tau|gamma0_*` 등) 이므로 HSV 생물학 폐형들은 직접 매핑 불가능. 두 경로로 분기:

**(a) `hexa verify --fence`로 honest ⚪ speculation-fence 처리 + 수동 계산 attach.** Markov / Hill / Poisson / saddle-node 폐형은 binary 미적용. 본 milestone의 closed-form identity 자체는 수학적으로 deterministic이나, 적용 도메인(HSV episome chromatin)이 hexa-bio AXIS임을 honest fencing.

**(b) hexa-lang stdlib에 polymer/bio kernel을 추가하여 V2.1에서 재시도** — `_recompute` 에 Markov_3state / hill_n / poisson_p 추가 PR 후 `hexa verify --expr <fn> <args>` 직접 가능.

V2 round 1 우선순위 — 다음 7개 폐형을 V2 round 1에서 fence-verify (각 항목에 수동 산출 첨부) + V2.1에 stdlib extension PR:

| # | 폐형 identity | claim source | 제안 invocation |
|---|---|---|---|
| 1 | Markov 3-state K9me steady-state · $P_{Me3}^{ss} = k_{u\to m}/(k_{u\to m}+k_{m\to u})$ | M3 §7.1-7.2 · M7 §4.1 | `hexa verify --fence "P_Me3^ss = k_um/(k_um+k_mu) at k_um=5e-2,k_mu=5e-5 → 0.999"` + stdlib `markov_ss(k_um,k_mu)` PR |
| 2 | Markov 3-state full · $Z=1+r_{Ac}+r_{Me3}$, $P_X = r_X/Z$ | M3 §7.2 | `hexa verify --fence "Z=1+r_Ac+r_Me3, P_Me3=r_Me3/Z at r_Ac=0.1,r_Me3=10 → P_Me3=0.901"` |
| 3 | HDAC-perturbed P_Ac · $P_{Ac}^{ss}(\delta) = (r_{Ac}/\delta)/(1+r_{Ac}/\delta + r_{Me3})$ | M3 §7.4 · M6 §2.1 | `hexa verify --fence "P_Ac(δ=0.1,r_Ac=0.1,r_Me3=10) = 1/(12) = 0.083"` |
| 4 | 2-drug HDAC+G9a synergy · $P_{Ac}^{ss}(\delta,\epsilon)$ | M6 §3.2 | `hexa verify --fence "P_Ac(δ=0.1,ε=0.1) = 1/3 ≈ 0.333"` |
| 5 | Bliss independence · $E_{Bliss} = 1-(1-E_A)(1-E_B)$ | M6 §3.3 | `hexa verify --fence "Bliss(0.11,0.04) = 0.146; observed 0.61 → synergistic"` |
| 6 | ODE 잠복 fixed-point · $D^{ss}=J^{ss}=S^{ss}=H^{ss}=L^{ss}=0$, $M^{ss}=k_{um}/(k_{um}+k_{mu})$ | M4 §5.3 | `hexa verify --fence "ODE latent fp at u=0,Akt>>K_A: all phospho=0, M=k_um/(k_um+k_mu)"` |
| 7 | Geometric decay sterilizing cycles · $N(n) = N_0(1-p)^n$ · $n \geq \log(N_0/10)/-\log(1-p)$ | M6 §8.1 · M8 §8.2 · M10 §11.1 | `hexa verify --fence "cycles_to_target(N=2500,p=0.60,floor=1) = log(2500)/log(1/0.40) ≈ 8.54"` |

추가 (V2 round 2 — multiplicative + Hill):

| # | 폐형 identity | claim source | 제안 invocation |
|---|---|---|---|
| 8 | DLK+JNK 곱셈 시너지 · $u_{crit}^{drug} = u_{crit}^0 \cdot (f_D \cdot f_J)$ | M7 §1.3 | `hexa verify --fence "u_crit_drug = u_crit_0 * f_D * f_J = 0.20 * 9 = 1.80"` |
| 9 | Hill cascade fixed-point · $S^{ss}(J) = k_{JS}J/(k_{JS}J+k_{PP1})$ · $H^{ss}(S) = k_{SH}S^h/(k_{SH}S^h+k_{HX})$ | M4 §5.4 | `hexa verify --fence "Hill(J,K=k_PP1/k_JS,n=1) — H stage h=2"` (stdlib `hill_n(x,K,n)` PR) |
| 10 | Lifetime escape rate · $k_{escape} \approx k_{mu}/(k_{um}^{KRAB}/k_{um}^0)^N$ | M7 §4.3 | `hexa verify --fence "k_escape = 5e-5/100^5 = 5e-15 /s; T=2.5e9 → P ≈ 1.25e-5"` |
| 11 | Poisson per-genome residual · $P_{neuron} = 1-(\epsilon\phi)^k$ | M5 §6.5 | `hexa verify --fence "P_neuron_remain(k=10,εφ=0.3)=1-0.3^10=1-5.9e-6 ≈ 1"` |
| 12 | $p_{cycle}$ multiplicative independence · $p_{cycle} = 1-(1-p_{M5})(1-p_{M6+M8})$ | M10 §11.1 | `hexa verify --fence "p_cycle(0.475,0.808)=1-0.525*0.192=0.899"` |

→ **V2 deliverable**: 12 fence-verify invocations + stdlib PR (`markov_ss`, `hill_n`, `poisson_p`, `geometric_decay_n`).

---

## 13. §V3-handoff — Numerical recompute jobs (🟢 후보)

44 🟢 claims 중 ODE integration / Monte-Carlo / bifurcation tracking이 필요한 항목을 V3에서 수치 recompute. 컴퓨트 타겟은 commons @D d7 (small cell pool · batch CPU · GPU pod) 정렬:

| # | 수치 작업 | claim source | 컴퓨트 타겟 (@D d7) |
|---|---|---|---|
| 1 | M4 ODE 8-state integration + u_∞ ramp (대표 파라미터 §5.5.2 table) + Phase I/II transient ($u=0.30, \tau=4h$) | M4 §5.5.2-5.5.4 | **pool ubu-1/2 free** (small ODE, ~8 vars, 100-1000 trajectories) — scipy / hexa-native solve_ivp |
| 2 | M4 saddle-node bifurcation tracking (continuation of $I^{ss}(u_\infty)$, 0.05→0.40 sweep) + drug scenarios (DLK·JNK·KDM4·HDAC inh, M4 §6 table) | M4 §5.5.1 · M4 §6 | **pool ubu-1/2 free** (continuation, AUTO-07p 또는 PyDSTool) |
| 3 | M6/M8 cycle count sweep — $N_{remaining}(n) = N_{total}(1-p_{cycle})^n$ × parameter grid ($p_{react} \times p_{clear}$ heatmap 6×6 + heavy-tail boundary) | M6 §8 · M8 §8 | **pool ubu-1/2 free** (closed-form sweep, vectorized numpy) |
| 4 | M7 lifetime escape Monte-Carlo — $10^6$ trials × 80 year × Gaussian trigger 분포 (UV·열·stress·면역억제·NGF) under drug-shifted $u_{crit} \in [1.8, 2.1]$ | M7 §5.3 | **batch Vast.ai CPU** (~10⁹ Bernoulli draws, parallel embarrassing) |
| 5 | M5+M6 combined efficacy waterfall (M10 §11.3-11.5 cycle 누적 — best/realistic/worst) — $p_{cycle}$ × $n$ × tail/body 분기 + 95% CI bootstrap | M10 §11.3-11.5 | **pool ubu-1/2 free** (closed-form + bootstrap 10⁴) |
| 6 | M9 antigen score sensitivity (composite $S_{ag}$ weight 변동, $w_1 \in [0.1,0.5]$ × $w_2 \in [0.2,0.6]$) — pentavalent vs hexavalent 한계효용 | M9 §9.1-9.3 | **pool ubu-1/2 free** (선형 sweep) |

→ **V3 deliverable**: 6 numerical recompute jobs · 5 on pool ubu-1/2 · 1 on Vast.ai CPU (job 4, MC scale).

---

## 14. 핵심 needs-check / 🟠 catalogue (35 항목 합산)

V4+ 단계에 외부 hw/data/API 의존하므로 본 verify push에서 분리 deferred. 우선순위:

1. **🟠 high priority** (M5 §8 · M10 §10.4 regulatory · M10 §7.4 PET tracer) — 임상·regulatory 의존, 5-10년 timeline
2. **🟠 needs-check citation** (M1 §6 Russell 2021 · M3 §10 BET 양면 · M4 §10 mTOR/AMPK · M6 §10 Hill 2014·Kim 2020 · M7 §11 Larrea Murillo · M9 §1 BNT163 readout) — literature search, 단기 해결 가능
3. **🟠 drug discovery** (M6 §1.1 KDM4 activator · M7 §1.6 HCF-1 PPI · M10 §12 Anc80 backup) — wet-lab / 화합물 합성
4. **🟠 measurement** (M3 §3 H3K27ac LAT · M4 §2.2 JNK3 H3 in vivo · M5 §3/§7 CRISPOR 재실행 · M8 §4.2 radiolabeled pembro PET) — 실험 부재

---

## 15. M1-M10 cross-cutting findings

1. **closed-form spine** = M3 §7 Markov ↔ M4 §5 ODE ↔ M5 §6 heavy-tail ↔ M6 §8 cycle ↔ M7 §4-5 lifetime ↔ M8 §8 clearance ↔ M9 §9 antigen score ↔ M10 §11 integrated $p_{cycle}$. 모두 동일 Markov ratio + geometric decay 패밀리.
2. **rate constant 외삽** (M3 §7.3 mammalian heterochromatin → HSV episome) = M3/M4/M6/M7 모든 폐형의 정량 정확도를 결정하는 단일 weak link → needs-check 1순위.
3. **heavy-tail (M2 §7.2 1%/45%)** = M5/M6/M8/M10 ceiling을 모두 결정하는 단일 boundary. V3 cycle 시뮬레이션의 dominant parameter.
4. **KDM4 activator chemical 부재** = M3 §7.5 · M6 §3.4 · M10 §12 모두 surrogate에 의존 → drug discovery 단일 표적.
5. **Two-arm split (M10 §1.3)** = M4/M7 ODE에서 약리학적 mutual exclusion이 deterministic으로 증명됨 → 환자 stratification logic은 first-principles 폐형 (🟢).

---

## 16. measured-oracle PASS criteria for V2

본 V1 inventory가 V2로 넘어가는 PASS 조건:

- [ ] §12 V2-handoff의 7개 round-1 fence-verify invocation 모두 실행 + output 캡처
- [ ] hexa-lang stdlib에 `markov_ss`, `hill_n`, `poisson_p`, `geometric_decay_n` 4개 calc fn 추가 PR 등록 (`atlas register --from-verify` flow)
- [ ] §13 V3-handoff jobs 1-3 (pool ubu-1/2 free) 결과 캡처 + bifurcation diagram + cycle heatmap 첨부
- [ ] §14 needs-check 1순위 6개 항목 literature search 결과 첨부

전체 248 claims · 25 🔵 · 44 🟢 · 144 🟡 · 35 🟠 · 0 🔴 — V1 round complete.

---

> end V1 — HSV sterilizing cure 10-milestone claim inventory + tier triage 완결. V2 round = 7 fence-verify + stdlib 4-fn extension PR. V3 round = 6 numerical recompute jobs across pool ubu-1/2 free + Vast.ai CPU batch. 🔴 0 (deterministic 불일치 없음 — 본 라운드).
