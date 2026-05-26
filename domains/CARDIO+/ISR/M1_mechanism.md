# M1 — ISR 4-axis 기전 매핑

> 마일스톤 M1 산출물 · current-state · no history.
> 출처 = literature + OCT/IVUS atlas → 🟡 SUPPORTED-BY-CITATION.

---

## 1. ISR (In-Stent Restenosis) 정의

스텐트 시술 후 stent 내경 또는 5 mm proximal/distal에서 **재협착 > 50% diameter 감소**. 임상 ISR = 재협착 + 허혈 증상 / FFR ≤ 0.80.

빈도 (PCI 후 1년):
- BMS (bare-metal): 20-30%
- 1st-gen DES (sirolimus · paclitaxel): 5-10%
- **2nd-gen DES (everolimus · zotarolimus)**: **3-8%** (current standard)
- DCB (drug-coated balloon, ISR 치료): 10-15%

→ 2nd-gen DES 시대에도 잔여 5-8% — 절대 환자 수로는 큼.

---

## 2. 시간 축 — early vs late ISR

```
PCI 시술
  │
  │   ── 0–1개월 ──     평활근 증식 시작 (early phase)
  │   ── 1–6개월 ──     neointimal hyperplasia peak ◀── 1세대 DES sirolimus가 억제
  │   ── 6–12개월 ──    early restenosis 확정
  │
  │   ── 1–3년 ──       endothelial 회복 / strut coverage
  │
  │   ── 3–10년 ──      neoatherosclerosis ◀── 2세대 DES의 새로운 적
  │                     (foam cell · 칼슘화 · 신생 plaque rupture)
  │
  ↓
```

→ **1st gen 시대**: neointimal hyperplasia가 주범
→ **2nd gen 시대**: 6-8년 후 **neoatherosclerosis**가 주범 — late-stent failure 패러다임 시프트.

---

## 3. 4-axis 기전 분해

| axis | 풀이 | 시점 | OCT/IVUS finding | 약물 표적 가능성 |
|---|---|---|---|---|
| **NH** | Neointimal Hyperplasia | 1-6m | homogeneous high-signal · 두꺼운 intima | sirolimus 등 mTOR (current DES) |
| **NA** | Neoatherosclerosis | 3-10y | lipid pool · thin-cap · 신생 fibroatheroma · 칼슘 | **표적 부재 → d2 wall** |
| **SF** | Stent Fracture | any | strut gap · 불연속 | 디바이스 (M5 BRS) |
| **US** | Uncovered Strut / Malapposition | any | strut 노출 · gap | imaging 가이드 시술 |

---

## 4. NH 메커니즘 (sirolimus가 잡는 부분)

```
스텐트 손상 → 평활근(VSMC) dedifferentiation → 증식 (G1→S) → 신생 intima
   │              │                            │
   │              ↓                            ↓
   │         contractile → synthetic     mTOR · CDK4/6 · Cyclin D
   │                                     ◀── sirolimus block
   ↓
   염증: macrophage · PDGF · TGF-β
```

표적: mTOR (sirolimus · everolimus · zotarolimus) — 모두 동일 경로 → **약리적 단일 표적 의존** = M3 신규 표적 필요성 근거.

---

## 5. NA 메커니즘 (현재 표적 부재 — d2 wall)

```
endothelial 회복 X / 기능장애
       │
       ↓
ox-LDL 침투 → macrophage 식세포 → foam cell ━━┓
       │                                       ┃
       ↓                                       ┃
SMC migration (intima 내) → matrix             ┃
       │                                       ↓
       ↓                              신생 fibroatheroma
microvessel angiogenesis ── 출혈 ── thin-cap → rupture
                                                       │
                                                       ↓
                                              **late stent thrombosis · ACS**
```

| 후보 표적 (M3 short-list 입력) | 메커니즘 가설 |
|---|---|
| **YAP/TAZ** (Hippo) | VSMC phenotype switching · 신생 intima |
| **HIF-1α** | 저산소 → SMC 증식 + 신생혈관 |
| **ROCK1/2** | VSMC contractility · 염증 |
| **BET (BRD4)** | foam cell · NLRP3 inflammasome |
| **PCSK9 local** | ox-LDL 침착 — 시스템 PCSK9i 효과 검증 |
| **GLP-1R agonist local** | 항-염증 + endothelial 회복 |

---

## 6. BMS vs DES 세대별 ISR rate

| 디바이스 | 약물 | 1y ISR | 5y ISR | 비고 |
|---|---|---|---|---|
| BMS | — | 20-30% | 25-35% | 대부분 NH |
| 1st-gen DES (Cypher) | sirolimus | 5-8% | 10-15% | NH ↓ but late thrombosis · NA |
| 1st-gen DES (Taxus) | paclitaxel | 8-10% | 12-18% | NH ↓ but delayed healing |
| **2nd-gen DES (Xience)** | everolimus | **3-5%** | **5-8%** | current standard · NA dominant |
| **2nd-gen DES (Resolute)** | zotarolimus | **4-6%** | **6-10%** | current standard |
| Orsiro / Synergy (bioabsorbable polymer) | sirolimus | 3-5% | 5-8% | polymer 흡수 |

---

## 7. ISR 패턴 분류 (Mehran 1999)

| 패턴 | 위치 | 길이 | 예후 |
|---|---|---|---|
| I (focal) | stent edge / focal | ≤ 10 mm | 양호 (DCB 효과) |
| II (diffuse intra-stent) | stent 내부 | > 10 mm | 중등도 |
| III (proliferative) | stent 넘어 확장 | > 10 mm + edge | 불량 |
| IV (totally occluded) | 완전 폐색 | — | 가장 불량 |

→ DCB 효과는 I/II에서 우수, III/IV는 재-DES 필요 — M5 DCB milestone 입력.

---

## 8. 한국인 ISR registry hooks (M8 입력)

| 출처 | 데이터 |
|---|---|
| K-DES | 2nd-gen DES vs DCB ISR 처치 |
| EXCELLENT / RESET | Korean DES RCT |
| HOST-IDEA / HOST-REDUCE | de-escalation + ISR endpoint |
| GRAND-DES | retrospective ISR 패턴 |

---

## 9. 참고문헌

- Otsuka F et al. (2014) *Eur Heart J* 35:1538 — neoatherosclerosis 정립
- Joner M et al. (2006) *JACC* 48:193 — DES delayed healing
- Park SJ et al. (2012) *JACC* 59:2051 — Korean DES outcome
- Byrne RA et al. (2015) *Eur Heart J* 36:3320 — ISR management review
- Stefanini GG, Holmes DR (2013) *NEJM* 368:254 — DES review
- Mehran R et al. (1999) *Circulation* 100:1872 — ISR pattern classification
- Nakazawa G et al. (2011) *JACC* 57:1314 — neoatherosclerosis 빈도
- Kuramitsu S et al. (2021) *EuroIntervention* 17:e1280 — late DES failure

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| ISR 정의 (재협착 > 50%) | 🟡 SUPPORTED-BY-CITATION | guideline |
| 4-axis 분류 | 🟡 SUPPORTED-BY-CITATION | Otsuka 2014 + OCT atlas |
| 세대별 ISR rate | 🟡 SUPPORTED-BY-CITATION | meta-analysis |
| NA → late thrombosis 인과 | 🟡 SUPPORTED-BY-CITATION | Nakazawa 2011 (autopsy) |
| 신규 표적 (M3) 효능 | 🟠 INSUFFICIENT/DEFERRED | 전임상만 — M3에서 ranking |

🔑 핵심 통찰:
- 2nd-gen DES 시대 **잔여 wall = neoatherosclerosis** (3-10년 시점)
- 현행 DES는 모두 mTOR — **단일 표적 의존** → M3 비-mTOR 신규 표적 필수
