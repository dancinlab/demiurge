# M2 — 현행 DES 약물 한계 (4종 limus)

> 마일스톤 M2 산출물 · current-state · no history.
> 출처 = pivotal RCT + PK literature + 한국인 registry → 🟡 SUPPORTED-BY-CITATION.
> M1 (`ISR/M1_mechanism.md`) 의 4-axis (NH · NA · SF · US) 어휘 그대로 사용.

---

## §1. 4종 약물 개요 표

| 약물 (generic) | 대표 brand · stent | 1G/2G | polymer | 도입년 | 비고 |
|---|---|---|---|---|---|
| **sirolimus** (rapamycin) | Cypher (Cordis) · Orsiro (Biotronik) · Synergy (BSC, sirolimus 변형) | 1G (Cypher) · 3G (bio-polymer Orsiro) | durable PEVA/PBMA (Cypher) → bioabsorbable PLLA (Orsiro) | 2003 | 원조 mTOR · NH 잡지만 late thrombosis 부각 |
| **everolimus** | Xience (Abbott) · Promus (BSC) · Synergy (BSC) | **2G** | durable fluoropolymer (Xience) · bioabsorbable PLGA (Synergy) | 2008 | current US/EU workhorse · 2G 표준 |
| **zotarolimus** | Endeavor (Medtronic) · Resolute (Medtronic) · Onyx (Medtronic) | 2G | BioLinx (hydrophilic) durable | 2008 (Endeavor) · 2010 (Resolute) | 빠른 elution (Endeavor) → 균등 elution (Resolute) |
| **biolimus A9** (umirolimus) | BioMatrix (Biosensors) · Nobori (Terumo) | 2G | **abluminal-only biodegradable PLA** (polymer 6-9m 흡수) | 2008 | polymer-free 컨셉 · LEADERS·NOBORI 검증 |

→ 모두 **rapamycin 유도체** (C28 알킬 치환만 다름) · 차이는 PK 와 polymer carrier 에 압축됨.

---

## §2. 분자 표적 — mTORC1 공통

4종 모두 동일 경로 — 세포내 **FKBP12** 와 결합 → FKBP12-약물 복합체가 **mTORC1 (mTOR + raptor)** 의 알로스테릭 부위에 결합 → S6K1 · 4E-BP1 인산화 차단 → G1→S 정지 → VSMC 증식 억제.

```
PCI 손상 → 성장인자 (PDGF · IGF-1)
              │
              ↓
        ┌────────────┐
        │  RTK       │  (cell surface)
        └────────────┘
              │
              ↓
            PI3K
              │  PIP2 → PIP3
              ↓
            AKT  ───── PTEN (off-switch)
              │
              ↓
           TSC1/2
              │  (off → on when AKT inhibits TSC2)
              ↓
            Rheb-GTP
              │
              ↓
       ╔══════════════╗     ◀──── FKBP12·[sirolimus / everolimus
       ║   mTORC1     ║              zotarolimus / biolimus A9]
       ║  (mTOR+raptor)║              ═══ 단일 차단 지점 ═══
       ╚══════════════╝
         │           │
         ↓           ↓
       S6K1       4E-BP1
         │           │
         ↓           ↓
      ribosome    cap-translation
         │           │
         └─────┬─────┘
               ↓
        VSMC G1 arrest (= NH 억제)
```

⚠ **단일 차단 지점** = escape pathway 없음 → §5(a) wall 의 분자 근거. mTORC2 · PI3K-AKT 우회 활성화 가능 (feedback loop).

---

## §3. PK / 약물학 차이 표

| 항목 | sirolimus | everolimus | zotarolimus | biolimus A9 |
|---|---|---|---|---|
| 분자량 (Da) | 914 | 958 | 967 | 986 |
| **logP (lipophilicity)** | 4.3 | 5.0 | **6.2** | **7.4** (최고) |
| FKBP12 Kd (nM) | 0.2 | 0.5 | 0.4 | 0.3 |
| IC50 VSMC 증식 (nM) | 1-2 | 1-3 | 2-5 | 0.5-1 |
| **혈중 t½** (경구) | ~62 h | ~30 h | ~9 h | ~30 h (국소) |
| 코팅 release t½ | 30-90d (Cypher) | 30-120d (Xience) | **14-21d** (Endeavor) · 60-180d (Resolute) | 30-90d (abluminal) |
| burst (24h 누적 %) | 20-30% | 10-20% | **>50%** (Endeavor) · 10% (Resolute) | <10% |
| residual @ 90d | 10-20% | 20-30% | <5% (Endeavor) | 20-40% |
| polymer | PEVA/PBMA durable | PVDF-HFP durable | BioLinx durable (hydrophilic) | **PLA biodegradable abluminal** |
| **tissue retention** (vessel wall) | 중 | 중-고 | **저** (washout 빠름) | **고** (lipophilic → membrane trap) |

핵심: **lipophilicity 와 release kinetics 가 가장 큰 차이**. zotarolimus(Endeavor) 는 너무 빨라 NH 재발, sirolimus/biolimus 는 오래 머물러 healing 지연.

---

## §4. 임상 효능 — LLL + TLR @ 12mo

| 약물 / stent | pivotal RCT | n | LLL @ 9-12mo (mm) | TLR @ 12mo (%) | late ST (1y, %) | 비고 |
|---|---|---|---|---|---|---|
| BMS (대조) | various meta | — | 0.80-1.00 | 12-20 | 0.5-1.0 | NH dominant |
| sirolimus / Cypher | **SIRIUS** (NEJM 2003) | 1058 | **0.17** | 4.1 | 0.6-1.4 | NH 극적 ↓ but late ST↑ |
| everolimus / Xience | **SPIRIT III/IV** (NEJM 2008/2010) | 1002 · 3687 | 0.16 | 4.6 | 0.2-0.4 | LST 가장 낮음 · 2G 표준 |
| zotarolimus / Endeavor | **ENDEAVOR III/IV** (JAMA 2008) | 436 · 1548 | **0.61** | 6.5 | 0.1 | LLL 높음 (빠른 elution) — 단 LST 낮음 |
| zotarolimus / Resolute | RESOLUTE-AC (Lancet 2010) | 1140 | 0.27 | 3.9 | 0.2 | 균등 release 로 LLL 회복 |
| biolimus A9 / BioMatrix | **LEADERS** (Lancet 2008) | 1707 | 0.20 | 5.4 | 0.2 | vs Cypher 비열등 · DAPT 단축 가능성 |
| biolimus A9 / Nobori | **NOBORI 1** (EuroInt 2009) | 363 | 0.11 | 3.3 | 0.1 | abluminal-only — 일본 주력 |
| sirolimus / Orsiro | BIOFLOW-V (Lancet 2017) | 1334 | 0.10 | 2.6 | 0.1 | bio-polymer 3G · 최저 LLL |

**한국인 registry hooks** (M8 입력):
- **K-DES** — 2G DES 실세계 ISR ~5-7%
- **EXCELLENT** (Park SJ 2012) — everolimus vs sirolimus, Korean 1786명, 비열등
- **HOST-REDUCE-POLYTECH-ACS** (Kim HS 2020) — Korean DAPT de-escalation, late event endpoint
- **RESET** (Park DW 2012) — Korean sirolimus vs zotarolimus
- **GRAND-DES** — 한국 retrospective registry, NA 패턴 관찰

→ 2G (everolimus · Resolute zotarolimus · biolimus) 모두 **LLL ~0.10-0.27, TLR 3-6%** 으로 수렴. 절대 절감 한계 도달.

---

## §5. 5가지 미해결 wall

### (a) 단일 표적 (mTOR) — escape pathway 없음
4종 모두 FKBP12 → mTORC1 단일 경로 (§2). mTORC2 · PI3K-AKT 우회 활성화 시 약물 무력화. resistance 메커니즘:
- S6K1 → IRS-1 feedback loop 해제로 AKT 재활성화
- autophagy bypass (mTOR-independent)
- VSMC 일부 subpopulation 의 본질적 mTOR-independent 증식

→ M3 비-mTOR 표적 (YAP/TAZ · HIF · ROCK · BET · Wnt) 의 분자 근거.

### (b) neoatherosclerosis 미해결 (3-10년 lipid plaque 형성)
mTOR 차단은 VSMC 증식만 잡음. NA = endothelial dysfunction + ox-LDL 침투 + foam cell + 신생 fibroatheroma — **lipid + 염증 축**. mTOR 약물은:
- foam cell 형성에 약효 (-)
- macrophage NLRP3 inflammasome 미영향
- neovascularization 미차단
- 오히려 endothelial 회복 지연 → NA 가속 가능성 (Otsuka 2014 autopsy)

→ M1 §5 의 **d2 wall** = 표적 부재. PCSK9 / GLP-1R / BET 등 lipid-염증 축 신규 표적 필요.

### (c) delayed healing → late stent thrombosis (DAPT 1년+ 강제)
mTOR 차단은 VSMC 뿐 아니라 **endothelial 회복도 지연**. uncovered strut (M1 §3 axis-US) 잔존 → 혈전형성 nidus → late ST (>30d) · very late ST (>1y).
- DAPT 12개월+ 강제 → 출혈 위험
- biolimus A9 abluminal-only · Synergy bioabsorbable PLGA 가 일부 해결 (1m DAPT 시도) 하지만 mTOR 자체의 endothelial 독성은 미해결

### (d) high-bleeding-risk (HBR) 환자 부적합
DAPT 강제 시간 → HBR 환자 (노인 · CKD · AF on OAC · prior bleed) 1-2% 연간 major bleed → 사망률 ↑.
- LEADERS-FREE (polymer-free biolimus A9, BioFreedom) 1m DAPT 시도 → ISR 약간 ↑
- 근본적으로 mTOR 약물은 healing 지연 → DAPT 단축 한계

→ **DAPT-free 가능 약물** = 신규 표적 필수 조건 (M3 screening).

### (e) ISR after DES 재발 시 옵션 부족 (DES-in-DES 효과 ↓)
DES-treated 혈관 재협착 시 같은 약물 재투여 효과 ↓ (resistance + tissue 포화):
- DES-in-DES TLR 15-25% @ 1y (de novo 5%의 3-5배)
- DCB (paclitaxel/sirolimus) 가 1차 옵션 — 하지만 NA 패턴엔 효과 ↓
- 옵션 = scoring balloon · cutting balloon · IVL · 마지막 CABG

→ M5 DCB · M6 BRS 의 입력 근거.

---

## §6. M3 hook — 왜 비-mTOR 신규 표적이 필요한가

4종 limus 모두 **FKBP12 → mTORC1 단일 분자 표적** 의존 (§2) — 30년간 같은 경로. 2G DES 시대에 LLL/TLR 절대 절감은 한계 (≈0.1mm / 3-5%) 도달했고, 잔여 wall은 분자 표적이 다른 곳에 있다. (b) NA — lipid·염증 축 (PCSK9 · BET · GLP-1R) · (c) delayed healing — endothelial 회복 보존하면서 VSMC만 선택 차단 (YAP/TAZ · ROCK selective) · (d) DAPT-free — 혈전 nidus 형성 안되는 healing-friendly 약물 · (e) DES-in-DES — 교차내성 없는 직교 표적. M3 에서 이 5개 축으로 비-mTOR 표적 inventory 를 구축한다.

---

## §7. 참고문헌

- Moses JW et al. (2003) *NEJM* 349:1315 — SIRIUS (sirolimus pivotal)
- Stone GW et al. (2010) *NEJM* 362:1663 — SPIRIT IV (everolimus)
- Leon MB et al. (2008) *JAMA* 299:1903 — ENDEAVOR IV (zotarolimus Endeavor)
- Serruys PW et al. (2010) *Lancet* 375:201 — RESOLUTE-AC
- Windecker S et al. (2008) *Lancet* 372:1163 — LEADERS (biolimus A9)
- Chevalier B et al. (2009) *EuroIntervention* 4:545 — NOBORI 1
- Kandzari DE et al. (2017) *Lancet* 390:1843 — BIOFLOW-V (Orsiro)
- Garg S, Serruys PW (2010) *JACC* 56:S1, S43 — limus PK 비교 review
- Otsuka F et al. (2014) *Eur Heart J* 35:1538 — NA + DES delayed healing
- Park SJ et al. (2012) *JACC* 59:2051 — EXCELLENT (Korean)
- Kim HS et al. (2020) *Lancet* 396:1079 — HOST-REDUCE-POLYTECH-ACS
- Urban P et al. (2015) *NEJM* 373:2038 — LEADERS-FREE (HBR · 1m DAPT)

---

## §8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 4종 mTORC1 공통 표적 | 🟡 SUPPORTED-BY-CITATION | Garg & Serruys 2010 |
| PK logP / IC50 값 | 🟡 SUPPORTED-BY-CITATION | review + FDA label |
| LLL / TLR pivotal RCT | 🟡 SUPPORTED-BY-CITATION | 위 RCT 인용 |
| NA → late ST 인과 | 🟡 SUPPORTED-BY-CITATION | Otsuka 2014 autopsy |
| escape pathway resistance | 🟠 INSUFFICIENT/DEFERRED | 전임상 + 가설 — M3 검증 필요 |
| 비-mTOR 신규 표적 효능 | 🟠 INSUFFICIENT/DEFERRED | M3 short-list 단계 |

🔑 핵심:
- 4종 limus = rapamycin 유도체 · **FKBP12 → mTORC1 단일 표적 의존** = escape resistance 분자 근거
- 2G DES LLL/TLR 한계 (≈0.1mm / 3-5%) → 잔여 wall (NA · delayed healing · HBR · DES-in-DES) 은 표적이 다른 곳
- M3 비-mTOR inventory = lipid·염증 (PCSK9·BET·GLP-1R) + healing-selective (YAP/TAZ·ROCK) + 직교내성
