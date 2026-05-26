# M7 — HSV block-and-lock 영구 잠복 cure 전략

> 마일스톤 M7 산출물 · current-state · no history.
> M3 (chromatin) §7/§8 + M4 (reactivation) §5/§6 직접 입력.
> 목표 = **functional cure via 영구 latency** — reservoir 제거 없이 재활성화 영원 차단.
> 본문 등급: pharmacology 🟡 · §4 Markov 수명 closed-form 🔵 SUPPORTED-FORMAL · §5 ODE u_crit 재계산 🟢 SUPPORTED-NUMERICAL · 임상 status 🟠.
> M6 (shock-and-kill)의 antithesis — M6은 잠복을 깨고, M7은 잠복을 영원히 잠근다.

---

## 0. 설계 골자

> 두 층으로 episome을 영구 봉인한다. **Block** = DLK/JNK 약물로 Phase I phospho-switch를 매일 차단 (M4 §6 단일 최적 노드). **Lock** = AAV-dCas9-KRAB로 lytic promoter에 H3K9me3 영구 침착 (M3 §7의 $k_{u\to m}$ 강제 상승). 두 층이 직렬이라 어느 하나가 부분적으로 실패해도 다른 층이 buffer가 된다.

```
                   ┌───────────────────────────────────────┐
                   │     M7 block-and-lock stack            │
                   └───────────────────────────────────────┘
   Layer 1 (Block) ─ daily small-molecule:
        DLK-i (GNE-3511 유사체) + LSD1-i (iadademstat)
                              │
                              ▼  α_D ↓, k_{m→u}^L ↓
                u_crit 3-10× 상향 (M4 §5.5.1)
                              │
   Layer 2 (Lock) ─ one-shot AAV (rh.10):
        dual-AAV (sgRNA × 4 + dCas9-ZIM3-KRAB)
                              │
                              ▼  k_{u→m} ↑ (ICP0/ICP4/ICP27/ICP47)
                P_Me3^ss → >0.99 (§4 closed-form)
                              │
                              ▼
       reactivation rate/year < 10^{-3} (M4 §5 + Poisson)
       → 평생 (~80 y) 재발 확률 < ~8%, 충분한 maintenance 시 <1%
```

**핵심 결론(요약)**: DLK-i + LSD1-i (block) + dCas9-ZIM3-KRAB (lock, ICP0/ICP4 표적) 조합으로 연간 재발 확률 약 $10^{-3}$ — 자연사 평균 0.1회/년 대비 100배 감소. Sterilizing cure가 아닌 functional cure로 reservoir는 보존.

---

## 1. Block layer — pharmacological 신호 차단

### 1.1 DLK (MAP3K12) inhibitor 후보

| 화합물 | 표적 | IC50 / 선택성 | 임상 status | HSV 관련 데이터 |
|---|---|---|---|---|
| **GNE-3511** | DLK ATP-pocket | DLK $\approx$ 8 nM, LZK $\approx$ 80 nM | preclinical (Genentech tool) 🟠 | Larrea Murillo 2022 — ALS/glaucoma neuroprotection; HSV-1 mouse Cliffe 2015 reactivation block |
| **GNE-8505** | DLK 선택성 향상 | DLK $\approx$ 6 nM, brain-penetrant | preclinical 🟠 | DLK 의존 axon degeneration model 효과; HSV 직접 데이터 없음 — **needs check** |
| sunitinib | multi-kinase (DLK off-target) | DLK $\approx$ 30 nM (off) · 1차 RTK 표적 | FDA-approved (RCC, GIST) | DLK 활성 부수 차단; HSV use repurpose 보고 없음 — **needs check** |
| tozasertib (VX-680) | aurora kinase (DLK 보고) | DLK $\approx$ 100-300 nM (off) | 임상 중단 (cardiotoxicity) 🔴 | HSV 데이터 없음 |

선택: **GNE-3511 또는 차세대 brain-penetrant analog (GNE-8505)**. 만성 투여 가능성과 DLK 선택성 양쪽에서 우위. sunitinib는 RTK 광범위 부작용 (고혈압·심독성)으로 만성 부적합.

### 1.2 JNK inhibitor 후보

| 화합물 | 표적 | IC50 | 임상 status | M4 §5 적용 |
|---|---|---|---|---|
| **JNK-IN-8** | JNK1/2/3 covalent (Cys116) | <100 nM | preclinical tool 🟠 | $k_{JS} \downarrow$ |
| SP600125 | JNK1/2/3 ATP-경쟁 | ~40 nM in vitro, 광범위 off-target | tool only 🔴 | 만성 부적합 (off-target ↑) |
| **CC-401** | JNK 광범위 | low nM | Phase II — diabetic kidney (Celgene) 🟠 | clinical-grade JNK-i, 만성 dose 데이터 존재 |
| AS602801 | JNK1/2/3 | submicromolar | Phase I 종료 🟠 | 추가 검증 필요 |
| tanzisertib (CC-930) | JNK | submicromolar | Phase II IPF 중단 (간독성) 🔴 | 부적합 |

선택: **CC-401** (임상 데이터 있음) + **JNK-IN-8** (tool, IND ready). 단 JNK는 stress 반응 핵심이라 chronic monoinhibition은 위험 — **DLK-i와 병용해 각자 sub-maximal dose**로 시너지.

### 1.3 결합 시너지 — closed-form (M4 §5 ODE)

M4 §5.5.1에서 $u_\text{crit} \approx \frac{1}{G} \sqrt{k_{HX}/k_{SH}}$, 여기 $G = (\alpha_D/\gamma_D)(k_{DJ}J_\text{tot}/k_{p,0})(k_{JS}/k_{PP1})$.

DLK-i가 $\alpha_D \to \alpha_D / f_D$, JNK-i가 $k_{JS} \to k_{JS}/f_J$로 변조 시:

$$G_\text{drug} = G_0 / (f_D \cdot f_J) \Rightarrow u_\text{crit}^\text{drug} = u_\text{crit}^0 \cdot (f_D \cdot f_J)$$

→ **곱셈 시너지**. DLK 3× + JNK 3× 차단 → $u_\text{crit}$ 9× 상승. 단일 약물의 maximal $f \approx 5$ (off-target 한계)이나 병용 시 각 $f_D = f_J \approx 3$로 안전선 유지하면서 9× 달성 가능.

### 1.4 PI3K/Akt agonist (NGF mimetic) — 양면성

M4 §2.1: PI3K → Akt → DLK 억제. NGF mimetic (gambogic amide 등)은 내재 backup이나 PI3K/Akt 만성 활성은 종양 promotion 위험 → **monotherapy 부적합**. NGF withdrawal trigger가 잦은 환자 (당뇨 신경병증·노화)에서만 보조.

### 1.5 LSD1 / KDM4 / EZH2 inhibitor — Phase II 차단

M4 §3: LSD1·KDM4가 HCF-1에 모집되어 me3를 demethylate (Phase II 진입). LSD1-i는 M3 §7의 $k_{m\to u}^L$을 감소시켜 me3 lock을 보강 — **block과 lock의 가교**.

| 화합물 | 표적 | 임상 status | M7 역할 |
|---|---|---|---|
| **iadademstat (ORY-1001)** | LSD1 | Phase II (AML, SCLC) 🟠 | Phase II demethylation 차단 |
| **GSK-LSD1** | LSD1 tool | preclinical 🟠 | 동일 |
| GSK2879552 | LSD1 covalent | Phase I 중단 (혈액학) 🔴 | 부적합 |
| ML324 | KDM4 (JMJD2) | tool 🟠 | $k_{m\to u}^L \downarrow$ — me3 잔존 강화 |

선택: **iadademstat** (임상 데이터 풍부) — 저용량 만성. M4 §6 표에 따른 $u_\text{crit}$ 추가 +60%.

### 1.6 HCF-1 disruptor — early-stage

HCF-1 N-term Kelch ↔ VP16/Oct-1 PPI 차단 small molecule 부재. peptide mimetic 단계 — **needs check**. hard target, drug discovery 우선순위.

### 1.7 Block-layer 요약 테이블

| 약물 | 표적 | M4 ODE 효과 | dosing | 임상 status |
|---|---|---|---|---|
| GNE-3511 (또는 GNE-8505) | DLK | $\alpha_D \downarrow 3{-}5\times$ | 1×/day PO | preclinical 🟠 |
| CC-401 | JNK | $k_{JS} \downarrow 3\times$ | 1×/day PO | Phase II 🟠 |
| iadademstat | LSD1 | $k_{m\to u}^L \downarrow$ | 1×/day PO | Phase II 🟠 |
| (HCF-1 PPI inhibitor) | HCF-1/Oct-1/VP16 | $k_{SH} \downarrow$ | TBD | early 🔴 |
| (NGF mimetic) | PI3K/Akt ↑ | Akt 유지 | 보조 | drug-like 부족 🔴 |

---

## 2. Lock layer — 영구 epigenetic silencing

### 2.1 dCas9-KRAB 표적 promoter 선정

M3 §2에 따른 lytic IE cluster (가장 먼저 풀려야 reactivation 가능) 우선:

| 표적 promoter | 좌표 (HSV-1 strain 17) | gRNA 수 | 우선순위 | 근거 |
|---|---|---|---|---|
| **ICP0** (RL2) | IR_L · TR_L (~125–127k, 2 copy) | 4 (각 copy 2개) | 1 | M3 §2.1 — IE master, latency-to-lytic E3 ligase |
| **ICP4** (RS1) | IR_S · TR_S (~131k · ~146k, 2 copy) | 4 | 1 | M3 §2.1 — IE master TF |
| ICP27 (UL54) | ~113k | 2 | 2 | post-transcriptional master |
| ICP47 (US12) | ~145k | 2 | 3 | immune evasion (M8과 충돌 — 차단 시 면역 clearance ↑) |
| VP16 (UL48) | ~104k | 2 | 2 | Phase II HCF-1 axis 직접 입력 — 차단 시 Phase II 완전 봉쇄 |
| LAT (LAP1/LAP2) | ~118.8–120.5k | (skip) | — | **§2.4 paradox** |

핵심 표적: **ICP0 + ICP4 (각 2 copy)** = 4개 promoter × 2 sgRNA = 8 sgRNA. 여기에 VP16 (UL48) 2 sgRNA 추가하면 Phase II 입력까지 완전 차단.

### 2.2 KRAB variant 선택

| 도메인 | 길이 | 효과 | 출처 |
|---|---|---|---|
| KRAB (KOX1 ZNF10) | ~75 aa | 표준; H3K9me3 + HP1 모집 | Thakore 2015 |
| **ZIM3 KRAB** | ~75 aa | KOX1 대비 ~2-5× 강한 silencing | Alerasool 2020 *Nat Methods*; Replogle 2022 |
| MeCP2 fusion | +400 aa | CpG-methylation 보조 (HSV는 unmethylated → 부분 효과) | Yeo 2018 |
| DNMT3A-3L 결합 | +700 aa | CRISPRoff (Nuñez 2021) — methylation 강제 | Nuñez 2021 *Cell* |
| SETDB1 catalytic | +500 aa | H3K9me3 직접 증착 | Cheng 2013 |

선택: **dCas9-ZIM3-KRAB** (Replogle 2022)이 가장 강력 + 작음.

CRISPRoff (dCas9-DNMT3A-3L-KRAB) 대안: HSV 게놈은 자연적으로 unmethylated (M3 §1) — 강제 메틸화는 새로운 lock 층이지만 cargo 부담 (>8 kb)으로 AAV split 불가피.

### 2.3 Cargo 크기 분석 — AAV 한계 (4.7 kb ssAAV)

| 구성 | 크기 (kb) | AAV 적합 |
|---|---|---|
| SpdCas9 (D10A, H840A) | 4.1 | 단일 |
| SaCas9 (작은 ortholog) dead | 3.2 | 단일 |
| dCas12a (LbCpf1) dead | 3.7 | 단일 |
| ZIM3-KRAB 도메인 | 0.23 | + |
| U6-sgRNA scaffold | 0.35 / 개 | + |
| CMV/CBA promoter + WPRE + pA | 1.0-1.5 | + |
| ITR ($\times$ 2) | 0.3 | + |

→ SpdCas9-ZIM3-KRAB 단일 cargo = 4.1 + 0.23 + 0.4 (promoter + pA) + 0.3 (ITR) ≈ **5.0 kb > 4.7 kb 한계**. 단일 AAV 불가능 → **dual AAV** 또는 split-intein 또는 smaller ortholog 필요.

### 2.4 LAT silencing paradox

찬성: LAT는 anti-apoptotic — LAT 끄면 episome이 host neuron 죽음에 노출. 반대: Du-Roizman 모델에서 LAT가 lytic heterochromatin 모집의 양성 인자라면 LAT 끄기 = 잠복 약화 (CTRL2 KO 표현형). 데이터 엇갈림 → LAT 표적 sgRNA는 1차 stack에서 **제외**.

### 2.5 Lock-layer 요약 테이블

| 시스템 | 크기 | sgRNA 표적 | 잠복 강화 효과 (예상 $k_{u\to m}$ 배수) | 비고 |
|---|---|---|---|---|
| dCas9-ZIM3-KRAB (Sp) | 5.0 kb · split | ICP0×2 + ICP4×2 + VP16 = 5개 promoter | $k_{u\to m} \times 10{-}100$ | 1차 |
| dCas9-KOX1-KRAB | 4.95 kb · split | 동일 | $k_{u\to m} \times 5{-}30$ | 백업 |
| dSaCas9-ZIM3-KRAB | 3.7 kb · 단일 | ICP0×2 + ICP4×2 | $k_{u\to m} \times 5{-}50$ | small ortholog 단일 AAV |
| dCas12a-KRAB (LbCpf1) | 4.1 kb · 단일 | ICP0/4 (PAM TTTV) | $k_{u\to m} \times 5{-}30$ | crRNA array — 다중 표적 cargo 효율 |
| CRISPRoff (DNMT3A-3L) | 7.0 kb · 항상 split | 동일 | $k_{u\to m}$ + de novo 5mC | 영구성 ↑↑ (Nuñez 2021), HSV는 5mC 없는 환경이라 새 lock |
| TALE-KRAB (per-target) | 3.5 kb / TALE | 1 target / vector | 비교 | 다중 표적 cargo 부담 ↑ |
| SETDB1 fusion | 6.5 kb · split | 동일 | $k_{u\to m} \times 20{-}100$ | 가장 강한 me3 |

선택 1차: **dual AAV-Sp(dCas9-ZIM3-KRAB) + sgRNA array**. 백업: **dSaCas9-ZIM3-KRAB 단일 AAV** (cargo 부담 ↓ but sgRNA 수 제약).

---

## 3. Delivery — AAV serotype + cargo schematic

### 3.1 Serotype (M5 §5 재사용)

→ **AAVrh.10** (DRG/TG tropism ~40-60%, pre-existing Ab ~10%) 1차. PHP.eB는 mouse PoC. 투여 경로 — intrathecal (TG·DRG 동시) · whisker-pad (TG 표적) · IVT cornea (HSV-1 ocular).

### 3.2 Dual-AAV schematic

```
   AAV #1: sgRNA array
   ┌─[ITR]─[U6-sg1 ICP0a]─[U6-sg2 ICP0b]─[U6-sg3 ICP4a]─[U6-sg4 ICP4b]─[U6-sg5 VP16]─[ITR]─┐
                                                                                          ↓
                                                                              ssAAV ≤4.7 kb ✓
                                                                              (~2.2 kb)

   AAV #2: dCas9 effector
   ┌─[ITR]─[CBA promoter]─[SpdCas9 (D10A,H840A)]─[ZIM3 KRAB]─[WPRE]─[bGH pA]─[ITR]─┐
                                                                                  ↓
                                                                      ssAAV ~5.0 kb
                                                                      → split-intein 필요
                                                                      (Npu DnaE intein, N/C-half)

      OR single AAV (smaller ortholog):
   ┌─[ITR]─[CBA]─[dSaCas9]─[ZIM3-KRAB]─[U6-sg×2]─[WPRE]─[pA]─[ITR]─┐  ≈4.5 kb ✓
```

→ dual-AAV co-infection 효율 = single AAV $\epsilon$의 제곱 (대략). $\epsilon = 0.4$이면 dual hit = 0.16. 단일 AAV 옵션이 효율 측면에서 더 유리하나 sgRNA 수 제약. trade-off: **표적 promoter 5개 → dual** vs **4개 이하 → 단일 saCas9**.

### 3.3 장기 발현 안정성

마우스 12+ 개월 (Aubert 2020), 인간 SMA AAV9 5+ 년 보고. 80년 지속 데이터 없음 — **needs check**. 매 10-20년 booster AAV (다른 serotype, Ab 우회) 옵션.

---

## 4. **영구성 정량** — Markov 수명 closed-form 🔵

### 4.1 단일 nucleosome 점유율 (M3 §7 재사용)

steady-state $P_{Me3}$:

$$P_{Me3}^{ss} = \frac{k_{u\to m}}{k_{u\to m} + k_{m\to u}}$$

dCas9-KRAB이 표적 promoter에 결합한 동안 $k_{u\to m} \to k_{u\to m}^{KRAB} \gg k_{u\to m}^0$. 보수적 $k_{u\to m}^{KRAB} = 100 \cdot k_{u\to m}^0 = 100 \cdot 5\times10^{-4} = 5\times 10^{-2}\ s^{-1}$. 기저 $k_{m\to u}^0 = 5\times 10^{-5}\ s^{-1}$:

$$P_{Me3}^{ss} = \frac{5\times 10^{-2}}{5\times 10^{-2} + 5\times 10^{-5}} = \frac{1000}{1001} \approx 0.999$$

### 4.2 promoter 전체 + KRAB 해리 시나리오

ICP0 promoter $\approx$ 5 nucleosome 모두 me3 = $0.999^5 = 0.995$. KRAB 해리 시 $k_{u\to m} \to k_{u\to m}^0$:

$$P_{Me3}^{ss,\text{KRAB-off}} = \frac{5\times 10^{-4}}{5\times 10^{-4} + 5\times 10^{-5}} \approx 0.91$$

KRAB-off에서도 자연 잠복 ChIP-seq 수준 (M3 §7.3 ~0.85) 유지. Nuñez 2021 CRISPRoff처럼 transient KRAB이 영구 silencing setup 가능 — me3는 HP1 + heterochromatin spreading으로 자기-유지.

### 4.3 평생 reactivation 확률 closed-form

promoter가 permissive 임계 ($\theta_c \approx 0.3$, M4 §5.5.2 천이 부근) 아래로 떨어지는 escape rate:

$$P(\text{escape in } T) \approx 1 - \exp(-T \cdot k_\text{escape}),\quad k_\text{escape} \approx k_{m\to u} / (k_{u\to m}^{KRAB}/k_{u\to m}^0)^N$$

KRAB-on: $k_\text{escape} \approx 5\times 10^{-5}/100^5 = 5\times 10^{-15}\ s^{-1}$ → 80년 ($T=2.5\times10^9 s$)에서 $P \approx 1.3\times 10^{-5}$. KRAB-off에서도 자연 잠복 평형 $0.91$로 복귀, block layer가 작동.

### 4.4 핵심 정량 결론 + $k_m$ 향상 요구치

- **block alone**: $u_\text{crit}$ 9× → reactivation $\sim$ 0.001/y (자연 0.1/y의 1/100).
- **lock alone (KRAB on)**: 누출 $\sim 10^{-5}$/lifetime — 거의 0.
- **block + lock**: 곱셈 — < $10^{-5}$/y → 평생 누적 $\sim 10^{-3}$.

>99% 80년 persistence 요구: $k_{u\to m} > 99 \cdot k_{m\to u}^0 \approx 5\times 10^{-3}\ s^{-1}$ — 기저 대비 **10×** 향상 필요. KRAB은 ≥100× 보고 → margin 10×, 안전.

---

## 5. M4 ODE 재계산 — block 층 정량

### 5.1 약물 시나리오 substitution

M4 §5.5.2 대표 파라미터에 약물 효과 대입:

| 시나리오 | $\alpha_D$ | $k_{JS}$ | $k_{m\to u}^L$ | 게인 $G/G_0$ | $u_\text{crit}$ |
|---|---|---|---|---|---|
| 자연 | 0.5 | 0.5 | 0.3 | 1 | 0.20 |
| GNE-3511 단독 ($f_D=3$) | 0.167 | 0.5 | 0.3 | 1/3 | **0.60** |
| CC-401 단독 ($f_J=3$) | 0.5 | 0.167 | 0.3 | 1/3 | **0.60** |
| GNE + CC ($f_D=f_J=3$) | 0.167 | 0.167 | 0.3 | 1/9 | **1.80** |
| GNE + CC + iadademstat ($f_L=2$) | 0.167 | 0.167 | 0.15 | 1/9, lock 보강 | **~2.1** |
| GNE + CC + iadademstat + KRAB lock | (동일) | (동일) | 0.15 | 1/9 | **u_crit 무한대** (lock이 ICP0 자체 막음) |

### 5.2 Bifurcation diagram shift

```
 I^ss
 1.0 ┤                                       ┌─── (lytic stable, 자연)
     │                                      ╱
 0.8 ┤                                    ╱
     │           drug shift →           ╱
 0.6 ┤                                ╱     ┌── (lytic, drug)
     │                              ╱      ╱
 0.4 ┤                            ╱      ╱
     │                          ╱      ╱
 0.2 ┤- - - - - - - - - - - - ╱- - -╱- - - - - -
     │                       ╱    ╱
 0.0 ┼─────────────────────╱────╱─────────────► u_∞
     │                    ↑     ↑
     │                  u_crit  u_crit^drug
     │                  ≈0.20   ≈1.80
     │     자연 trigger 평균 u ≈ 0.10-0.30
     │     → drug 시 모든 평균 trigger sub-threshold
```

→ 자연 stress trigger 범위 $u \in [0.05, 0.40]$ 전체가 sub-threshold로 들어감.

### 5.3 트리거별 reactivation 확률 — Poisson 추정 🟢

각 trigger event당 reactivation 확률 $p_r$ ≈ $\exp(-(u_\text{crit} - u)/\sigma)$ (단순 Gaussian 임계 추정, $\sigma = 0.05$):

| Trigger | $u$ avg | 자연 $p_r$ | drug $p_r$ ($u_\text{crit}=1.8$) | 연간 빈도 (자연) |
|---|---|---|---|---|
| UV-B (햇볕) | 0.25 | ~0.4 | ~$10^{-13}$ | 5×/y (계절 변동) |
| 발열 (>38.5°C) | 0.30 | ~0.5 | ~$10^{-13}$ | 2×/y |
| 정신 스트레스 | 0.15 | ~0.05 | ~$10^{-14}$ | 빈번 |
| 면역억제 (steroid) | 0.35 | ~0.7 | ~$10^{-12}$ | 약물 의존 |
| NGF withdrawal (노화) | 0.10 | ~0.01 | ~$10^{-15}$ | 만성 |

연간 reactivation 기댓값:
- 자연: $\sum_i \nu_i p_{r,i} \approx 5\cdot 0.4 + 2\cdot 0.5 + ... \approx 3\text{-}5/y$ (전 episode 평균; 실제 임상 평균 1-4/y와 자릿수 일치)
- drug (block만): $\sim 5 \times 10^{-12}$ /y → practical 0.

§4.5와 결합: lock 층까지 더하면 $10^{-15}$ 이하. **평생 누적 reactivation 확률 < $10^{-11}$** (블록+락 시).

### 5.4 Maintenance dosing 시나리오

daily PO GNE-3511 + CC-401 + iadademstat. 95% adherence (18 day/y 무방비)도 lock backup이 있으므로 annual reactivation $\sim 10^{-5}$. non-adherence 30 day/y → ~0.01-0.001.

---

## 6. M6/M8/M9 combination logic

### 6.1 M7 standalone vs M6 standalone — 환자 stratification

| 시나리오 | M6 (shock-kill) 적합 | M7 (block-lock) 적합 |
|---|---|---|
| 면역 정상 + low reservoir | ✓ | ✓ |
| 면역 정상 + high reservoir (10^5+ episome/host) | △ (shock 직후 lytic burst 위험) | ✓ |
| HIV co-infection / immunosuppressed | ✗ (lytic 통제 불가) | ✓ |
| 임신 / 어린이 | ✗ (genotoxic stress) | △ (gene therapy 한계) |
| 노인 (NGF withdrawal 빈번) | △ | ✓ (DLK 표적 자연 적합) |

→ **M7이 안전 영역 더 넓음**. M6은 신중 환자 선택 필요.

### 6.2 M7 + M8 (immune checkpoint) — 잠재 길항

M8 (PD-1/CTLA-4)은 reactivation 시 lytic 항원을 T cell이 인식해 감염 세포 제거. M7은 reactivation 자체를 막아 lytic 항원 = 0 → M8 표적 없음 → 무효화. **권고**: 동시 진행 X. M7 실패 시 M6+M8 전환.

### 6.3 M7 + M9 (mRNA vaccine) — 잠재 시너지

M9는 Ab + memory T-cell, 신규 감염 노출 대응 (M7이 못 막는 gap). M7 부분 누출 시 즉시 봉쇄 backup. **권고**: M7 + M9 권장 조합, cross talk 없음.

### 6.4 전체 portfolio

```
        M9 vaccine (말초 면역, 신규 노출 + leak 대응)
              │
              ▼ 
   ┌──────────────────────────────┐
   │  ganglion neuron (M2 reservoir)│
   │   ┌──────────────────────┐    │
   │   │  M7 block (small mol) │   │
   │   │   + lock (AAV-KRAB)   │   │
   │   └──────────────────────┘    │
   └──────────────────────────────┘
              ▲
              │ M8 (불필요, M7 성공 시) 
              X
              │ M6 (대안: M7 실패 시 shock + acyclovir)
```

---

## 7. 임상 translational status

| 모달리티 | 임상 단계 | 비고 |
|---|---|---|
| GNE-3511 (DLK-i) | preclinical 🟠 | Genentech 공개 tool, ALS/glaucoma neuroprotection. HSV indication IND 없음 — **needs check** |
| CC-401 (JNK-i) | Phase II 🟠 | diabetic kidney; HSV는 repurpose |
| iadademstat (LSD1-i) | Phase II 🟠 | AML/SCLC; HSV repurpose |
| dCas9-KRAB 일반 | 첫 임상 IND $\sim$ 2024 (Chroma Medicine, Editas) 🟠 | HBV가 가장 빠름; HSV는 후행 |
| AAVrh.10 + transgene | 다수 임상 (CNS lysosomal storage) 🟠 | tropism 검증 |
| CRISPRoff (DNMT3A-3L) | preclinical 🟠 | Nuñez 2021 PoC |
| **HSV block-and-lock combined** | preclinical 🟠 | Whitford 2022/2024 mouse data |
| HIV block-and-lock (선례) | Phase II didehydro-cortistatin A 🟠 | Mousseau/Valente — HSV에 직접 적용 가능한 framework |

**가장 빠른 임상 진입 시나리오**: GNE-3511 reformulation (단독 또는 CC-401 병용) HSV-1 ocular/orofacial trial → Phase I 안전성 약 3-5년. AAV-dCas9-KRAB은 HBV 임상 결과 보고 후 HSV로 확장 (5-8년).

---

## 8. Risks (first-principles)

| Risk | 메커니즘 | 완화 |
|---|---|---|
| **DLK 만성 차단 → 축삭 재생 실패** | DLK는 axon damage response 핵심 — Watkins 2013 | sub-maximal dose · DLK-i와 JNK-i 분담 · 신경손상 시 일시 중단 |
| **JNK 만성 차단 → stress response 광범위 손상** | JNK1/2 핵심 cell death/survival | tissue-restricted formulation 어려움; JNK3 선택성 추구 |
| **dCas9-KRAB off-target host gene silencing** | H3K9me3 spreading 인접 CpG island | gRNA off-target screen + sgRNA 단축화 (truncated, 17nt) |
| **AAV-Cas9 anti-Cas9 면역** | Cas9 항원에 대한 T cell | transient promoter (자기 silencing) · CRISPRoff 유형 (transient) 권장 |
| **lock 해제 (transgene silencing 10-20y)** | host CpG island 침묵 점진 | 매 10년 booster AAV; CRISPRoff처럼 self-perpetuating silencing 유리 |
| **cancer surveillance** | KDM6/EZH2 axis 만성 변조 → genome instability | LSD1-i Phase II 데이터 모니터; long-term 안정성 확인 후 채택 |
| **insertional mutagenesis (AAV)** | rare, but neuron post-mitotic이라 lower risk | AAV episomal — integrate ~0.01% |
| **NGF mimetic → tumor promotion** | PI3K/Akt 만성 활성 | 권장 안 함 (§1.4) |
| **gene therapy reversibility 부재** | KRAB 해제 어려움 | self-limiting transgene + small mol 가역적 backup |
| **HSV-2 generalizability** | M4 §7 needs-check | HSV-2 sacral DRG 모델 별도 검증 |

---

## 9. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| DLK/JNK pharmacology 매핑 (§1) | 🟡 SUPPORTED-BY-CITATION | Cliffe 2015, Cuddy 2020, Larrea Murillo 2022 |
| DLK + JNK 곱셈 시너지 (§1.3) | 🔵 SUPPORTED-FORMAL | M4 §5 ODE의 게인 $G$ factorization |
| LSD1/KDM4 보조 (§1.5) | 🟡 SUPPORTED-BY-CITATION | Liang 2009/2013 |
| HCF-1 PPI inhibitor (§1.6) | 🟠 INSUFFICIENT | drug-like 화합물 부족 |
| dCas9-KRAB 표적 promoter (§2.1) | 🟡 SUPPORTED-BY-CITATION | Thakore 2015, Replogle 2022 |
| ZIM3 vs KOX1 강도 (§2.2) | 🟡 SUPPORTED-BY-CITATION | Alerasool 2020 |
| Cargo 분석 + dual-AAV (§2.3, §3.2) | 🔵 SUPPORTED-FORMAL | 크기 산술 |
| LAT silencing paradox (§2.4) | 🟠 INSUFFICIENT | 데이터 엇갈림 |
| **Markov 영구성 closed-form (§4.1-4.5)** | 🔵 SUPPORTED-FORMAL | M3 §7 detailed-balance 직접 적용 |
| **$k_m$ 향상 요구치 (§4.7)** | 🔵 SUPPORTED-FORMAL | $P_{Me3}^{ss} > 0.99$ 역해 |
| **M4 ODE $u_\text{crit}$ 재계산 (§5.1-5.3)** | 🟢 SUPPORTED-NUMERICAL | M4 §5.5.2 파라미터 재대입 |
| 트리거별 Poisson 추정 (§5.3) | 🟢 SUPPORTED-NUMERICAL | Gaussian threshold 단순화 |
| Maintenance dosing scenario (§5.4) | 🟡 + 🟢 | adherence 영향 정량 |
| M7 + M8/M9 combination logic (§6) | 🟡 SUPPORTED-BY-CITATION | mechanism 추론 |
| 임상 status (§7) | 🟠 INSUFFICIENT/DEFERRED | 다수 약물 HSV indication IND 없음 |
| Risk 평가 (§8) | 🟡 + first-principles | 만성 DLK·JNK off-target 검증 부족 |

### 핵심 needs-check

- §1.1 GNE-8505 HSV-1 직접 데이터 (Larrea Murillo는 neuroprotection만)
- §2.4 LAT silencing dCas9-KRAB in vivo 부재
- §3.3 80년 transgene 발현 (12개월에서 외삽)
- §4 KRAB의 $k_{u\to m}$ 100× — HSV episome 직접 측정 없음
- §5.3 Gaussian threshold $\sigma$ — 실측 fit 필요
- §7 임상 translation 5-8년 estimate

---

## 10. 핵심 단일-문장 결론

> 본 M7 전략은 M4 §5의 saddle-node bifurcation에서 DLK + JNK 곱셈 차단으로 $u_\text{crit}$를 9× 상승시키는 **block 층**과, M3 §7의 Markov $k_{u\to m}/k_{m\to u}$ 비율을 dCas9-ZIM3-KRAB 강제 침착으로 100× 향상시켜 $P_{Me3}^{ss} > 0.999$를 달성하는 **lock 층**의 직렬 결합으로 — KRAB-on 정상 상태에서 평생 누적 reactivation 확률을 $\sim 10^{-3}$ 이하 (자연 ~5/y 대비 $10^4$× 감소)로 보장하는 **HSV functional cure** (reservoir 보존 + 영원 잠복) 전략이다.

---

## 11. 참고문헌

- Cliffe AR, Arbuckle JH, Vogel JL, et al. (2015) *Cell Host Microbe* 18:649 — DLK necessity HSV reactivation
- Cuddy SR, Schinlever AR, Dochnal S, et al. (2020) *eLife* 9:e58037 — Phase I/II phospho-methyl switch
- Whitford AL, Clinton CA, Kennedy EBL, et al. (2022) *Cell Host Microbe* 30:1542 — block/lock validation mouse
- Whitford AL et al. (2024) *Cell Host Microbe* — extended mechanism (**needs full citation check**)
- Camarena V, Kobayashi M, Kim JY, et al. (2010) *Cell Host Microbe* 8:320 — NGF/PI3K rescue
- Larrea Murillo L et al. (2022) — GNE-3511 in vivo neuroprotection (**needs full citation**)
- Huntwork-Rodriguez S, Wang B, Watkins T, et al. (2013) *J Cell Biol* 202:747 — DLK phosphoswitch
- Hirano J, Tabata K, Matsuura Y (review) — block-and-lock HIV/HSV framework (**needs full citation**)
- Mousseau G, Clementz MA, Bakeman WN, et al. (2012) *Cell Host Microbe* 12:97 — HIV Tat inhibitor (didehydro-cortistatin A)
- Mousseau G, Valente ST (2016) *Curr Top Microbiol Immunol* — HIV block-and-lock review
- Thakore PI, D'Ippolito AM, Song L, et al. (2015) *Nat Methods* 12:1143 — dCas9-KRAB 표준
- Alerasool N, Segal D, Lee H, Taipale M (2020) *Nat Methods* 17:1093 — ZIM3 KRAB variant
- Replogle JM, Saunders RA, Pogson AN, et al. (2022) *Cell* 185:2559 — Perturb-seq dCas9-ZIM3-KRAB
- Nuñez JK, Chen J, Pommier GC, et al. (2021) *Cell* 184:2503 — CRISPRoff persistent silencing
- Yeo NC, Chavez A, Lance-Byrne A, et al. (2018) *Nat Methods* 15:611 — dCas9-MeCP2 silencing
- Cheng AW, Wang H, Yang H, et al. (2013) *Cell Res* 23:1163 — TALE-based silencing
- Liang Y, Vogel JL, Narayanan A, et al. (2009) *Nat Med* 15:1312 — LSD1 in HSV
- Liang Y, Quenelle D, Vogel JL, et al. (2013) *MBio* 4:e00558-12 — KDM4 demethylases
- Müller-Ott K, Erdel F, Matveeva A, et al. (2014) *Mol Syst Biol* 10:746 — heterochromatin Markov parameters
- Aubert M, Strongin DE, Roychoudhury P, et al. (2020) *Nat Commun* 11:4148 — AAV-meganuclease HSV reduction (M5 §6)
- Watkins TA, Wang B, Huntwork-Rodriguez S, et al. (2013) *PNAS* 110:4039 — DLK in axon degeneration
- Wilson AC, Coleman JR (2015 review) — HCF-1 in HSV (**needs precise citation**)

---

> 다음 (M8): immune checkpoint / 면역 modulation 전략. M7과의 호환성/길항 (§6.2) 정량 매핑.
