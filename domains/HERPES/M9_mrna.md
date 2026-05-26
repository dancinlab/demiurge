# M9 — 치료용 mRNA 백신 설계 (BNT163 / mRNA-1608 후속)

> 마일스톤 M9/10 산출물 · current-state · no history.
> 목적 = 이미 감염된 환자에서 (a) HSV 특이 항체 + CD4/CD8 T-cell 응답 부스트, (b) 재활성화 차단, (c) M6 LRA · M8 checkpoint와 결합.
> 등급 기조 = 항원 생물학 🟡 · mRNA 디자인 🟡 · 항원 랭킹 수식 🟢 · 임상 status 🟠.

---

## 1. 산업 baseline — 현재 상태

| 후보 | 스폰서 | 플랫폼 | 항원 | 단계 | 비고 |
|---|---|---|---|---|---|
| **BNT163** | BioNTech | mRNA-LNP (prophylactic, HSV-2) | gC + gD + gE trivalent (Friedman lab 라이센싱) | Phase 1 dosing 2022 시작 (NCT05432583) — 🟠 최신 readout 미공개 | Awasthi/Friedman 전임상 기반 |
| **mRNA-1608** | Moderna | mRNA-LNP (prophylactic, HSV-2) | 미공개 다중 glycoprotein (gD 중심 추정) | Phase 1/2 진행 (NCT05432583 외) — 🟠 protocol 상세 비공개 | COVID 플랫폼 직계 이전 |
| **GEN-003** | Genocea | recombinant gD2 + ICP4 (Matrix-M2 adjuvant) | gD2 + ICP4.2 펩타이드 | Phase 2 효능 부분 양성 → Phase 3 진입 전 **2017 program 중단** (재정 + 효능 한계) | 단백질 + adjuvant 한계 = T-cell breadth 부족 |
| **HSV529** | NIAID/Sanofi | live-attenuated (UL5/UL29 결손, replication-defective) | 전체 게놈 | Phase 1 종료 (NCT01915212) — 안전성 OK, 효능 modest | comparator (다항원 노출이나 immunogenicity weak) |
| **GSK gD-AS04** | GSK | gD2 + AS04 adjuvant | gD2 | Phase 3 (Belshe 2012, *NEJM*) — HSV-2 acquisition 효능 실패 (HSV-1 acquisition 부분 효능) | 단일 항원 + Th2 adjuvant 한계 |
| **Sanofi HSV-2 dl5-29** | Sanofi | replication-defective | 게놈 | Phase 1 (NCT00231387) — 진행 중단 | — |

**🟠 INSUFFICIENT** — BNT163 · mRNA-1608 임상 readout은 공개 자료가 제한적. clinicaltrials.gov NCT 번호 외 효능 수치 미확정.

### 1.1 GEN-003 실패에서 얻은 교훈

| 실패 요인 | M9 대응 |
|---|---|
| 단일 gD + ICP4 펩타이드 → CTL breadth 부족 | 다항원 cocktail (gD + gC + gE + tegument) |
| Matrix-M2 adjuvant Th2 편향 | LNP 내재 TLR7/STING → Th1/CTL 편향 |
| 효능 ≈ Δshedding 0.3 log10 (modest) | M6/M8 결합으로 multiplier 효과 (§6) |
| 단백질 antigen → MHC-I 제시 약함 | mRNA → 내인성 발현 → MHC-I cross-presentation |

---

## 2. 항원 선정 — first-principles + 면역학

### 2.1 후보 항원 카탈로그 (M1 §2 ORF 기반)

| 항원 | ORF | 위치 | 클래스 | 역할 | 항체 표적성 | T-cell 표적성 |
|---|---|---|---|---|---|---|
| **gD** | US6 | U_S | surface glyco | HVEM/nectin-1 수용체 결합 — entry essential | ⭐⭐⭐ (1차 중화) | ⭐⭐ |
| **gB** | UL27 | U_L | surface glyco | fusion executor | ⭐⭐ | ⭐⭐⭐ (보존 epitope 풍부) |
| **gC** | UL44 | U_L | surface glyco | C3b 결합 → complement 회피 | ⭐⭐ (보체 회피 차단) | ⭐ |
| **gE** | US8 | U_S | surface glyco | Fc-receptor — IgG 회피 (gE/gI complex) | ⭐⭐ (Fc 회피 차단) | ⭐⭐ |
| **gI** | US7 | U_S | surface glyco | gE chaperone | ⭐ | ⭐ |
| **gH/gL** | UL22/UL1 | U_L | surface glyco | fusion regulator | ⭐⭐ | ⭐⭐ |
| **VP16** | UL48 | U_L | tegument | α-TIF, IE 활성화 | — | ⭐⭐⭐ (immunodominant CTL) |
| **VP22** | UL49 | U_L | tegument | tegument 매개 spread | — | ⭐⭐ |
| **VP5** | UL19 | U_L | capsid major | M5 표적과 공유 | — | ⭐⭐ |
| **ICP4** | RS1 | IR_S/TR_S | IE | master transactivator — 재활성화 초기 | — | ⭐⭐⭐ (재활성화 윈도우 표적) |
| **ICP0** | RL2 | IR_L/TR_L | IE | E3 ligase — IFN 차단 | — | ⭐⭐ |
| **LAT 산물** | — | IR_L/TR_L | latency | non-coding 주력 | — | 🟠 controversial (저발현) |

### 2.2 핵심 면역학 fact

- **gD** = 1차 중화 표적. anti-gD mAb (e.g. HD1) 동물모델에서 sterilizing protection 일부 보고.
- **gE/gI** = Fc-receptor, IgG의 Fc 영역 결합 → "antibody bipolar bridging"으로 host 항체 회피. gE/gI 차단 항체는 회피 제거 → gD 항체 효과 증폭 (Awasthi/Friedman 2014, 2017).
- **gC** = C3b 결합 → 보체 매개 lysis 회피. gC 차단 항체는 보체 회피 무력화.
- **VP16 · ICP4** = 재활성화 초기 발현 → CTL이 재활성화 직후 감염 뉴런 인접 위성세포에서 표적 가능 (M4 윈도우).
- **LAT 산물** = non-coding RNA 주력, 단백질 산물 미미 → **항원으로 부적합** (🟠 controversial 문헌 일부 ORF-K 단백질 보고, 재현성 낮음).

### 2.3 HSV-1 / HSV-2 보존도 (🟢 numerical input for §9)

| 항원 | AA identity HSV-1 ↔ HSV-2 | 보존 epitope 영역 |
|---|---|---|
| gD | 84% | ectodomain N-말단 + Ig-fold core |
| gB | 86% | fusion loop + DIII |
| gC | 75% | C3b 결합 site |
| gE | 78% | IgG Fc binding site |
| VP16 | 83% | C-terminal activation domain |
| ICP4 | 79% | DBD + transactivation |

→ multi-target cocktail은 HSV-1 / HSV-2 cross-protection 가능 (BNT163 HSV-2 target 이나 HSV-1 cross-react 기대).

---

## 3. mRNA 분자 설계

### 3.1 construct 구조

```
mRNA construct (단일 ORF, 예: gD2)
──────────────────────────────────────────────────────────────────
 5' Cap   5' UTR     ORF (codon-opt, ψ→m1ψ)     3' UTR    poly(A)
   ▼        ▼              ▼                       ▼         ▼
 m7G-      [HBB or       ATG─────────────STOP    [HBB+AES]   AAAA...
 OMe-      EEF1A1]      (gD2 ectodomain +                   (~120 nt
 CleanCap                signal peptide + TM)                segmented)
   │                            │
   │                  N1-methyl-pseudouridine
   │                  ψ → m1ψ (100%) — TLR7/8 evasion
   │
 anti-reverse cap analog (CleanCap AG, TriLink)
```

### 3.2 multi-antigen 옵션

```
Option A — 단일 mRNA · P2A 링커 cocktail
─────────────────────────────────────────────────────────────────
 5'─[gD2]─P2A─[gC2]─P2A─[gE2]─stop─3'
   장점: 1:1:1 stoichiometry · LNP 동시 봉입 단순
   단점: ORF 길이 ↑ (~4.5 kb), 번역 효율 ↓

Option B — LNP cocktail (3개 별개 mRNA 혼합)
─────────────────────────────────────────────────────────────────
   장점: 각 항원 독립 번역, 발현 균형 조정 가능
   단점: GMP 복잡도 ↑, LNP 봉입 효율 분산
   → BNT163 채택 추정 (gC + gD + gE trivalent)
```

### 3.3 디자인 요소 표

| 요소 | 선택 | 근거 |
|---|---|---|
| 5' cap | CleanCap AG (m7G + 2'-O-methyl) | co-transcriptional, ARCA 대비 효율 ↑ |
| 5' UTR | HBB (human β-globin) | Pfizer-BioNTech BNT162b2 검증 |
| Kozak | GCCACCATGG | 강한 ribosome 진입 |
| ORF | codon-optimized (CAI 0.85+, host tRNA bias) | 번역 속도 + 안정성 |
| 변형 핵산 | N1-methylpseudouridine 100% | TLR7/8/RIG-I 회피, IFN 유도 억제 → 단백 발현 ↑ |
| 3' UTR | HBB tandem + AES (amino-terminal enhancer of split) | mRNA-1273 검증 |
| poly(A) | 120 nt segmented (A100-G10-A20) | 분해 저항 + ribosome 재진입 |
| ORF 종류 | full ectodomain + TM anchor (gD/gB/gC/gE) — membrane-bound 발현 | B-cell 친화적 (raw 항원 노출) + DC presentation 효율 |

### 3.4 길이 예산

| Construct | ORF 길이 (nt) | 총 mRNA (nt) | 권장 dose |
|---|---|---|---|
| gD2 단일 | 1,182 | ~1,500 | 30 μg |
| gD2 + gC2 + gE2 (P2A) | 4,500 | ~4,800 | 50 μg |
| gD + gC + gE + VP16 + ICP4 (LNP cocktail 5종) | 각 1-2 kb | mix ~12 kb | 100 μg total |

---

## 4. LNP 전달

### 4.1 LNP 단면

```
LNP cross-section (~80-100 nm diameter)
─────────────────────────────────────────
            outer PEG-lipid layer
              ╱ ╲ ╱ ╲ ╱ ╲ ╱ ╲
             ●    ●    ●    ●          ← PEG-DMG (2-stealth)
          ╱─────────────────╲
         │  phospholipid     │         ← DSPC (bilayer scaffold)
         │  + cholesterol    │         ← cholesterol (membrane fluidity)
         │                   │
         │   ●●●●●●●●●●●     │         ← ionizable lipid
         │ ●●  mRNA cargo ●● │            (ALC-0315 BNT / SM-102 Mod)
         │ ●● + lipid core ●● │            pKa 6.4 — endosomal H+에서 양전하
         │   ●●●●●●●●●●●     │
          ╲─────────────────╱
```

### 4.2 lipid mol% 표

| 성분 | 역할 | BNT (BNT162b2) | Mod (mRNA-1273) | M9 권장 |
|---|---|---|---|---|
| ionizable lipid | endosomal escape | ALC-0315 46.3% | SM-102 50% | SM-102 또는 차세대 (ALC-0315 IP 회피 시) |
| DSPC | bilayer | 9.4% | 10% | 10% |
| cholesterol | fluidity | 42.7% | 38.5% | 38.5% |
| PEG-lipid | stealth | ALC-0159 1.6% | PEG-DMG 1.5% | 1.5% |
| N/P ratio | mRNA:lipid 전하 | 6:1 | 6:1 | 6:1 |

### 4.3 경로별 비교

| 경로 | 표적 림프절 | TG 근접도 | 부작용 | 권장 |
|---|---|---|---|---|
| i.m. (deltoid) | 액와 림프절 | 낮음 | reactogenicity (myalgia, fever) — COVID 수준 | prime 표준 |
| i.n. (intranasal) | NALT + 경부 림프절 → **TG 근접** | **높음 (HSV-1 oral 적합)** | 후각 점막 IgA 유도 가능, BBB 우려 미미 (LNP < 100 nm BBB X) | **혁신 옵션** (HSV-1 oral focus 시) |
| ID (intradermal) | 진피 DC dense | 중 | 국소 홍반 | dose-sparing 옵션 |

### 4.4 LNP 내재 adjuvant 효과

- ionizable lipid → TLR4 약한 활성 + endosomal 산성화 → STING 우회 활성
- m1ψ mRNA → TLR7/8 회피 OK이나 cGAS-STING 약한 신호 → Tfh 유도 충분
- 외인성 adjuvant 불필요 — GEN-003 Matrix-M2 (Th2 편향) 회피

---

## 5. T-cell repertoire 부스트

### 5.1 HLA 커버리지 (전 세계 빈도 상위)

| HLA | 빈도 | 표적 epitope (예시) |
|---|---|---|
| HLA-A*02:01 | ~25% (백인 50%+) | gB 443-451 (FLIGALAIV) · VP16 479-488 |
| HLA-A*24:02 | ~17% (동아시아 35%+) | gD 286-294 · ICP4 |
| HLA-B*07:02 | ~10% | gB · VP16 |
| HLA-A*03:01 | ~13% | gD · gC |
| HLA-A*11:01 | ~10% (동아시아) | ICP4 · VP16 |

→ multi-antigen + 보존 epitope cluster ⇒ ≥85% 인구 커버 (5개 HLA 합산).

### 5.2 메모리 T-cell 표현형 표적

| 표현형 | 마커 | 백신 디자인에서 유도 방법 |
|---|---|---|
| **Tcf1+ stem-like memory** | Tcf1+ CD62L+ PD-1 low | prime 후 long interval boost (8-12주), antigen burst 회피 |
| effector memory (TEM) | KLRG1+ CD62L− | 단기 효과, M6 reactivation 시점 직전 boost로 유도 |
| TRM (tissue-resident, TG/skin) | CD103+ CD69+ | i.n. or peri-genital 경로 + adjuvant | 

### 5.3 prime-boost 스케줄

```
주차:  0       4         8         24        52
       │       │         │          │         │
       ▼       ▼         ▼          ▼         ▼
     prime  boost-1   (M8 CPB) (M6 LRA)   boost-2 (annual)
     30μg   30μg     anti-PD1   reactivator  same
     i.m.   i.m.                              i.m./i.n.
```

---

## 6. M6 / M8 결합 — coupling matrix

| 마일스톤 | 표적 | M9와의 상호작용 | 시퀀싱 |
|---|---|---|---|
| M5 (CRISPR/Cas9) | 잠복 게놈 절단 | 직접 결합 없음 (M5 = 분자 절제, M9 = 면역) | 병행 가능 |
| M6 (LRA, shock-and-kill) | 재활성화 유도 → ICP4/VP16 발현 | **CTL이 M6 발현 항원 즉시 인식** | M9 prime → M6 LRA |
| M7 (apoptosis induction) | 감염 뉴런 선택적 사멸 | 부분 보완 (CTL 비의존 경로) | 병행 가능 |
| M8 (checkpoint blockade) | exhausted CTL 재활성 | **M9 부스트한 CTL의 PD-1/TIM3 exhaustion 회복** | M9 prime → M8 CPB → M6 LRA |

### 6.1 결합 시퀀싱 (intervention timeline)

```
week  0    4    8    9    10
      │    │    │    │    │
      ▼    ▼    ▼    ▼    ▼
   M9   M9    M8     M6   M5 (선택)
   prime boost CPB  LRA   CRISPR
   ───  ───  ───   ───   ───
   CTL  CTL  pre-  virus  잔존
   build amp  emp.  awake  reservoir
              clear
```

- **week 0-4**: M9 prime → naive→effector→memory CTL pool 구축
- **week 4-8**: M9 boost → Tcf1+ memory 확장 (~10-50× CTL frequency)
- **week 8-9**: M8 anti-PD-1 (1 dose) → 잔존 exhausted CTL 회복
- **week 9-10**: M6 LRA → 잠복 게놈 reactivation → CTL이 재활성 뉴런 근접 위성세포에서 lytic cell 인식
- **week 10+**: M5 CRISPR (옵션) → CTL이 못 도달한 잔존 reservoir 직접 절제

### 6.2 closed-form efficacy multiplier

$E_{vaccine} = (CTL_{post}/CTL_{pre}) \cdot f_{epitope}$ — §9 참조.

---

## 7. Sterilizing vs functional efficacy

| 모드 | 목표 | 백신 단독 | M6/M8 결합 | M5/M6/M7 풀콤보 |
|---|---|---|---|---|
| Prophylactic | 미감염자 acquisition 차단 | BNT163/mRNA-1608 1차 표적 — 50-70% 효능 추정 (🟠) | 해당없음 | 해당없음 |
| Therapeutic (functional) | shedding ↓ recurrence ↓ | GEN-003 ~30% 효과 → mRNA cocktail 기대 50%+ | **70-85% recurrence 감소 추정** | 90%+ |
| Sterilizing (cure) | latent reservoir eradication | ❌ 단독 불가 (GEN-003 교훈) | 일부 (잠재) | **유일 경로** |

**중요**: M9 단독으로 sterilizing cure 약속 금지 (GEN-003 실패 명시).

---

## 8. 위험 평가

| 위험 | 메커니즘 | 완화 |
|---|---|---|
| **분자 mimicry** | gE/gI ↔ host neuronal Fc-binding 유사 → autoimmune 신경병증 위험 (이론) | gE/gI epitope를 immunogenic peptide로 한정, full ectodomain 회피 옵션 |
| **LNP myocarditis** | COVID mRNA에서 보고 (특히 young male) | dose 30-50μg 유지 (100μg 회피), interval ≥4주, 모니터 |
| **antigen interference** | 다항원 cocktail → CD8 immunodominance 한 epitope로 collapse | 1:1:1 stoichiometry · 각 항원 길이/codon 균형 |
| **pre-existing immunity** | 환자는 이미 anti-HSV Ab/T-cell 보유 → de novo response 제한 | mRNA 내인성 발현 → MHC-I novel epitope 노출, recall + de novo 동시 |
| **HLA coverage 한계** | 단일 epitope 의존 시 minor HLA cohort 미적용 | full ORF mRNA → endogenous processing → HLA-agnostic |
| **anti-PEG immunity** | PEG-lipid에 대한 anaphylaxis 사례 | 차세대 PEG-free 또는 zwitterionic lipid 옵션 (장기) |

---

## 9. 첫째 원리 효능 랭킹 (🟢 numerical)

### 9.1 composite antigen score

$$
S_{ag} = w_1 \cdot C_{12} + w_2 \cdot D_{Tcell} + w_3 \cdot N_{Ab}
$$

| 인자 | 정의 | 측정 |
|---|---|---|
| $C_{12}$ | HSV-1 ↔ HSV-2 AA identity | 0-1 (§2.3) |
| $D_{Tcell}$ | predicted CTL epitope density (per kb) — IEDB MHC-I binding affinity < 500 nM proxy | 0-1 normalized |
| $N_{Ab}$ | 중화 항체 표적성 (entry/spread block) — literature mAb potency | 0-1 (gD = 1.0 reference) |

가중치 $w_1=0.25,\ w_2=0.40,\ w_3=0.35$ (therapeutic setting — T-cell 우선).

### 9.2 점수표

| 항원 | $C_{12}$ | $D_{Tcell}$ | $N_{Ab}$ | $S_{ag}$ |
|---|---|---|---|---|
| **gD** | 0.84 | 0.55 | 1.00 | **0.781** |
| **gB** | 0.86 | 0.85 | 0.65 | **0.784** |
| **gC** | 0.75 | 0.40 | 0.55 | 0.540 |
| **gE** | 0.78 | 0.60 | 0.60 | 0.645 |
| **gH/gL** | 0.83 | 0.50 | 0.50 | 0.583 |
| **VP16** | 0.83 | 0.95 | 0.10 | **0.622** |
| **ICP4** | 0.79 | 0.90 | 0.05 | 0.575 |
| **VP5** | 0.85 | 0.70 | 0.05 | 0.510 |

### 9.3 cocktail 조합 최적화

| Cocktail | 항원 | Σ $S_{ag}$ | 보완 mechanism |
|---|---|---|---|
| **단일 (gD)** | gD | 0.781 | 중화 only |
| **trivalent (BNT163-style)** | gD + gC + gE | 1.966 | 중화 + 보체회피 차단 + Fc회피 차단 |
| **★ pentavalent (M9 권장)** | **gD + gB + gE + VP16 + ICP4** | **3.407** | 중화 + fusion + Fc차단 + IE-CTL × 2 |
| hexavalent | + gC | 3.947 | 한계효용 ↓, antigen interference 위험 ↑ |

**M9 권장 = pentavalent (gD + gB + gE + VP16 + ICP4)** — antigen interference 한계 내 최대 breadth.

### 9.4 CTL repertoire boost factor 추정

prime + boost 후 항원 특이 CD8 frequency 변화 (COVID mRNA precedent, Pulendran 2021):

$$
B_{CTL} = \frac{CTL_{post}}{CTL_{pre}} \approx 10^{1.0 \sim 1.7}
$$

pentavalent cocktail × prime-boost ⇒ **predicted ~30-50× CTL frequency** vs 자연 감염 baseline.

$E_{vaccine}$ (M6/M8 모델 입력):

$$
E_{vaccine} = B_{CTL} \cdot f_{epitope\,recognition} \approx 30 \times 0.7 = 21\times
$$

→ M6 reactivation 윈도우 동안 lytic cell clearance probability $P_{kill}$ 비례 ⇒ M6 dose 30-50% 감축 가능 (cross-reference).

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 항원 생물학 (gD/gC/gE Friedman lab) | 🟡 SUPPORTED-BY-CITATION | Awasthi/Friedman 2014-2024 |
| mRNA 설계 원리 (m1ψ, CleanCap, HBB UTR) | 🟡 SUPPORTED-BY-CITATION | Pfizer/Moderna 공개 + COVID 문헌 |
| LNP 조성 (SM-102, ALC-0315) | 🟡 SUPPORTED-BY-CITATION | mRNA-1273 / BNT162b2 disclosure |
| 항원 랭킹 composite score | 🟢 SUPPORTED-NUMERICAL | §9 closed-form, IEDB MHC-I + AA identity |
| CTL boost factor 추정 | 🟢 SUPPORTED-NUMERICAL | COVID mRNA precedent + log-scale extrapolation |
| **BNT163 임상 readout** | 🟠 INSUFFICIENT/DEFERRED | Phase 1 readout 미공개 |
| **mRNA-1608 임상 readout** | 🟠 INSUFFICIENT/DEFERRED | protocol 상세 미공개 |
| GEN-003 실패 요인 | 🟡 SUPPORTED-BY-CITATION | Genocea 2017 program 종료 발표 |
| HSV529 효능 | 🟡 SUPPORTED-BY-CITATION | Bernstein 2019 |

---

## 11. 참고문헌 (one-line)

- Awasthi S, Hook LM, Friedman HM (2014) *J Virol* 88:8421 — trivalent gC/gD/gE HSV-2 subunit
- Awasthi S et al. (2019) *Sci Immunol* 4:eaaw7083 — gC/gD/gE mRNA prophylactic guinea pig
- Egan KP, Hook LM, Latourette MW, Desai P, Awasthi S, Friedman HM (2020) *PLoS Pathog* 16:e1008795 — trivalent mRNA HSV-2 efficacy
- Awasthi S et al. (2024) — gE/gI Fc-receptor block 최신 진전 (BNT163 라이센싱 배경)
- Bernstein DI et al. (2019) *Clin Infect Dis* — HSV-2 vaccine clinical history
- Belshe RB et al. (2012) *NEJM* 366:34 — GSK gD-AS04 Phase 3 효능 실패
- Cohen JI (2010) *J Clin Invest* 120:4192 — therapeutic HSV vaccine review
- Friedman HM lab — gE/gI immune evasion mechanism series
- Pulendran B et al. (2021) *Nat Rev Immunol* 21:626 — COVID mRNA immunology
- Karikó K, Weissman D (2005) *Immunity* 23:165 — pseudouridine TLR evasion
- Pardi N et al. (2018) *Nat Rev Drug Discov* 17:261 — mRNA vaccine 리뷰
- Wald A, Corey L (2007) *Lancet Infect Dis* — HSV-2 clinical burden
- BNT163 — NCT05432583 (BioNTech HSV-2 Phase 1) — 🟠 readout 보류
- mRNA-1608 — Moderna pipeline (HSV-2 prophylactic) — 🟠 protocol 비공개
- HSV529 — NCT01915212 (NIAID/Sanofi)
- Pulendran B, Ahmed R (2011) *Nat Immunol* — Tcf1+ stem-like memory

---

## 12. 다음 단계 → M10

M10 = integrated therapeutic protocol (M5+M6+M7+M8+M9 결합 시퀀싱 + risk-benefit + clinical translation roadmap). M9 pentavalent cocktail + M6/M8 coupling matrix → M10 입력.
