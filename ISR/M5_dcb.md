# M5 — 약물코팅풍선 (DCB) 비교

> 마일스톤 M5 산출물 · current-state · no history.
> 출처 = ESC 2018 guideline + RCT meta + Katsanos 2018 (PMA signal) → 🟡 SUPPORTED-BY-CITATION.
> M1 hook = Mehran 1999 패턴 (I focal · II diffuse · III proliferative · IV occlusive).

---

## 1. DCB 개요 — 원리 vs DES

DCB (Drug-Coated Balloon) = **balloon 표면에 lipophilic drug + carrier 코팅** → inflation 30-60 s 동안 vessel wall로 약물 전달 → balloon 회수. **영구 implant 없음** = "leave nothing behind".

```
  t=0s        t=30-60s          t > 1min          t = days–weeks
  ─────       ──────────         ───────           ──────────────
  inflate     drug transfer      washout           tissue retention
   ▲                              │                   │
   │     ┌─────────────┐          │                   │
   │     │  balloon    │     ●●●  │              ●━━━━●━━━━●
   │     │ ███drug███  │ →   ●●●  │ →            ●drug retained●
   │     └─────────────┘     ●●●  │              ●━━━━●━━━━●
  vessel  contact            wash-out             vessel wall
  wall    pressure           (blood flow)         residue (lipophilic)
```

| 축 | DES | DCB |
|---|---|---|
| implant | 영구 stent + polymer | 없음 (balloon 회수) |
| 접촉 시간 | 수개월 (elution) | 30-60s (single shot) |
| 약물 조건 | water-soluble OK | **lipophilic 필수** (빠른 tissue uptake) |
| 적응증 | de novo lesion | **ISR (ESC IA)** · small vessel · bifurcation side branch |
| DAPT 기간 | 6-12 m | **1-3 m** (큰 장점) |
| 재시술 | DES-in-DES → 3겹 strut | DCB-in-stent → strut 추가 없음 |

→ ISR 재발시 **DCB가 ESC class IA 적응증** (DES-in-DES 효과 제한적, M1 §7 참조).

---

## 2. paclitaxel-DCB vs sirolimus-DCB

| 축 | paclitaxel-DCB | sirolimus-DCB |
|---|---|---|
| MoA | microtubule stabilizer (mitosis G2/M block) | mTORC1 inhibitor (G1/S block) |
| logP | ~3.0 (적정 lipophilic) | ~4.3 (높음 — 그러나 prolonged tissue uptake 어려움) |
| tissue retention | **빠른 흡수 + long retention** (수주) | 짧은 retention → **carrier 필수** |
| dose density | **3.0-3.5 µg/mm²** (표준) | 1.0-1.4 µg/mm² (carrier 의존) |
| therapeutic window | 좁음 (세포독성 cytotoxic) | 넓음 (cytostatic) |
| clinical evidence | **SeQuent Please · IN.PACT · PACCOCATH (PEPCAD-DES) — robust ISR data**, ESC IA | **MagicTouch · SELUTION SLR · AGENT** (limited but growing, non-inferior trials) |
| 안전성 신호 | Katsanos 2018 PMA — 하지동맥 사망률 ↑ (PAD); 관상동맥은 신호 약함 | 신경독성 없음, 전신 흡수 적음 |
| 적응증 dominance | ISR · small vessel | de novo + ISR 양쪽 도전 |

→ **paclitaxel-DCB = 현행 ISR 표준** · **sirolimus-DCB = carrier 진화 기반의 도전자**.

---

## 3. carrier / excipient 기술

paclitaxel은 자체 lipophilic·rapid uptake → carrier가 "release modulator" 역할. sirolimus는 retention 부족 → carrier가 "depot" 역할 (필수).

```
  carrier matrix → balloon surface → vessel wall transfer
  ───────────────  ────────────────  ──────────────────────
  ┌──────────────┐                      arterial intima
  │ drug + excip │ ━━ inflate ━━▶  ████████drug+carrier███▶  ↓ diffusion
  │ (crystalline │   pressure +              │
  │  or NP)      │   contact            sub-intimal depot
  └──────────────┘                          (carrier dissolves
   balloon                                    over hours-days)
   surface
```

### paclitaxel carrier

| 디바이스 | 회사 | carrier / excipient | 특징 |
|---|---|---|---|
| **SeQuent Please** | B.Braun | **iopromide** (X-ray contrast) | crystalline paclitaxel · 첫 ESC IA · PEPCAD II/DES |
| **IN.PACT Falcon/Admiral** | Medtronic | **urea** | crystalline · PAD에서도 강력 (PMA signal 중심) |
| **Pantera Lux** | Biotronik | **butyryl-tri-hexyl-citrate (BTHC)** | crystalline · lipophilic carrier |
| **Lutonix 035** | BD/Bard | **polysorbate + sorbitol** | crystalline · 낮은 dose 2.0 µg/mm² 시도 |
| **Restore DEB** | Cardionovum | shellac (천연 수지) | crystalline |

### sirolimus carrier (depot 기술이 핵심)

| 디바이스 | 회사 | carrier / 기술 | 특징 |
|---|---|---|---|
| **MagicTouch SCB** | Concept Medical | **phospholipid nanoparticle (NP)** | 인도 RCT 다수 · TIS-Asian data |
| **SELUTION SLR** | MedAlliance/Cordis | **sugar-based microreservoir (MicroReservoir)** | sustained release 60-90일 |
| **AGENT** | Boston Scientific | **citrate ester** | AGENT IDE — ISR 비열등성 입증 (2024) |
| **Virtue SAB** | Caliber Therapeutics | **encapsulated nanoparticle** | 미세분사 spray |
| **Biolimus A9-DCB (이전 Biolimus Biotronik)** | Biotronik | (개발 중) | M7 hook |

→ sirolimus-DCB는 **carrier가 곧 product** — paclitaxel-DCB는 약물이 product.

---

## 4. Mehran 1999 pattern 별 DCB 효과

M1 §7 분류에 DCB 적합성을 매핑:

| 패턴 | 위치 / 길이 | DCB 효과 | 권고 |
|---|---|---|---|
| **I (focal ≤10mm)** | edge / focal | ★★★★★ 우수 | **DCB first-line** (ESC IA) |
| **II (diffuse intra-stent >10mm)** | stent 내부 | ★★★★ 양호 | **DCB OK** · DES도 옵션 |
| **III (proliferative · stent 넘어 확장)** | edge + 외부 | ★★ 감소 | **재-DES 재고** · DCB 단독 불충분 |
| **IV (totally occluded)** | 완전 폐색 | ★ 부적합 | **재-DES + 적극 OCT 가이드** · DCB 단독 X |

```
  Mehran pattern → DCB efficacy decay
  ────────────────────────────────────
   I  ████████████████  (focal)       ← DCB 우승
   II ████████████      (diffuse)     ← DCB OK
   III █████            (proliferative)
   IV  ██               (occlusive)   ← DCB 부적합 / 재-DES
       0   20   40   60   80   100  (TLR-free %, 1y, 상대치)
```

→ DCB 후보 선정 기준: **pattern I/II 환자군 우선** + pattern III/IV는 새 표적 (M3 비-mTOR) DES 또는 BRS (M6) 옵션 검토.

---

## 5. 한국인 / 아시안 evidence

| 출처 | 디자인 | 핵심 결과 |
|---|---|---|
| **TIS (Treatment of ISR Study)** | Korean multi-center registry | DCB ISR 1y TLR 5-8% · DES-ISR보다 우수한 출혈 profile |
| **RESTORE-ISR** | RCT (한국 기여) | paclitaxel-DCB vs everolimus-DES in ISR · 비열등성 |
| **ChineseDCB / SeQuent China** | 중국 registry | paclitaxel-DCB ISR 효과 confirm |
| **K-DCB registry** | Korean prospective | DCB 후 1y angiographic restenosis 패턴별 분석 |
| **DCB-ONLY all-comers (KAMIR-DCB hook)** | 한국 ACS subgroup | small vessel + ISR DCB only 전략 |
| **SCAAR/RIBS-V (간접)** | non-Asian but ref | sirolimus-DCB vs paclitaxel-DCB head-to-head 부족 |

→ 아시안 (특히 한국) data는 **paclitaxel-DCB ISR에 강력** · sirolimus-DCB는 MagicTouch India + AGENT US 중심으로 증거 축적 중. M8 한국인 ranking에 입력.

---

## 6. 한계 + M7 hook

### paclitaxel
- **Katsanos 2018** (JAHA meta-analysis, PAD): **하지동맥 paclitaxel device → 2y/5y 사망률 ↑** → FDA Class I safety letter → PMA black-box 신호.
  - 관상동맥에서는 signal 약함 (DCBs in coronaries — 메타 결과 중립)
  - 그러나 **dose-dependent toxicity 우려**가 paclitaxel-DCB 신규 dose↓ trial 촉발.
- **재-DCB 효과 감소** — paclitaxel re-do 시 TLR 증가 (Pleva et al. 2018)
- **신경독성 / 만성 vasculopathy** — 비만성, 미세 영향 잔존 가능성

### sirolimus
- **tissue retention 부족** → carrier 의존도 절대적, carrier 실패 시 underdosing
- **clinical evidence 아직 부족** — AGENT IDE 2024 ISR 비열등성이 첫 대규모 US trial
- **paclitaxel-DCB 대비 head-to-head 부족** — RIBS-VII / SUGAR 등 진행 중

→ **M7 (안전성)** 입력: paclitaxel PMA signal · carrier biocompatibility · re-do DCB pharmacology · late lumen loss pattern.

---

## 7. 차세대 DCB 방향

### 7.1 biolimus-DCB (Biolimus A9 = umirolimus)
- **logP ~5.5** (가장 lipophilic among limus 계열) → carrier 부담 ↓
- BioFreedom DES (polymer-free)에서 검증 → DCB transition 시도
- Biotronik · Concept Medical 등 개발 라인

### 7.2 비-mTOR 약물 DCB (M3 신규 표적 → M5 combo)

M1 §5 / M3 short-list와 결합:

| M3 표적 | DCB 적합성 | 이유 |
|---|---|---|
| **YAP/TAZ inhibitor** (verteporfin · IAG933) | ★★★ 가능 | lipophilic · cytostatic |
| **HIF-1α stabilizer/blocker** (roxadustat 등) | ★★ 검토 | logP 적정 |
| **ROCK inhibitor** (fasudil · Y-27632) | ★★★ 가능 | 임상 한국·일본 fasudil 경험 |
| **BET inhibitor** (JQ1 · BMS-986158) | ★★★ 가능 | lipophilic + anti-inflammatory |
| **PCSK9 local mRNA/ASO** | ★ 어려움 | macromolecule — DCB 부적합 |
| **GLP-1R agonist (small molecule)** | ★★ 검토 | endothelial 회복 보조 |

### 7.3 dual-drug DCB
- **paclitaxel + sirolimus combo** (저용량 + carrier-depot) — synergy 가설
- **anti-proliferative + anti-inflammatory** (mTORi + BETi) — neoatherosclerosis (M1 §5 NA wall)까지 커버

### 7.4 carrier 자체 진화
- **degradable nanoparticle (PLGA)** — 시간차 release
- **lipid-based (phospholipid)** — MagicTouch 노선 확장
- **bioadhesive (mussel-inspired DOPA)** — 접촉 시간 짧음 보완

→ **차세대 DCB 후보 = biolimus + carrier 진화 + M3 신규 표적 combo**.

---

## 8. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| DCB ESC IA for ISR | 🟡 SUPPORTED-BY-CITATION | ESC 2018 myocardial revascularization guideline |
| paclitaxel vs sirolimus tissue retention | 🟡 SUPPORTED-BY-CITATION | Cremers et al. preclinical · Granada review |
| Mehran pattern × DCB efficacy | 🟡 SUPPORTED-BY-CITATION | Alfonso F. et al. RIBS series |
| Katsanos PMA signal (관상 vs 하지) | 🟡 SUPPORTED-BY-CITATION | Katsanos 2018 JAHA + FDA letter |
| sirolimus-DCB AGENT IDE 비열등성 | 🟡 SUPPORTED-BY-CITATION | AGENT IDE 2024 |
| biolimus-DCB 임상 효과 | 🟠 INSUFFICIENT/DEFERRED | 개발 단계 |
| M3 표적 × DCB combo | 🟠 INSUFFICIENT/DEFERRED | 전임상 가설 — M3에서 ranking |

---

## 9. 참고문헌

- Scheller B et al. (2006) *NEJM* 355:2113 — PACCOCATH (paclitaxel-DCB ISR 첫 RCT)
- Unverdorben M et al. (2009) *Circulation* 119:2986 — PEPCAD II (SeQuent Please)
- Tepe G et al. (2015) *Circulation* 131:495 — IN.PACT SFA (PAD)
- **Katsanos K et al. (2018)** *JAHA* 7:e011245 — paclitaxel PAD 사망률 meta
- Jensen CJ et al. (2024) — AGENT IDE (sirolimus-DCB ISR US trial)
- Ali RM et al. (2019) — TRANSFORM-OCT (MagicTouch sirolimus-DCB)
- Cortese B et al. (2020) — SELUTION SLR all-comers
- Alfonso F et al. (2014) *JACC* 63:1378 — RIBS IV (paclitaxel-DCB vs everolimus-DES in ISR)
- Byrne RA et al. (2013) *Lancet* 381:461 — paclitaxel-DCB vs DES in ISR
- ESC/EACTS (2018) — Myocardial Revascularization Guidelines (DCB Class IA for ISR)
- Mehran R et al. (1999) *Circulation* 100:1872 — ISR pattern classification

---

🔑 핵심 통찰:
- **paclitaxel-DCB = 현행 ISR 표준** (ESC IA · robust evidence) · **sirolimus-DCB = carrier 진화 기반의 도전자** (AGENT IDE 2024 통과).
- **Mehran I/II = DCB first-line** · **III/IV = 재-DES + OCT 가이드** — DCB 후보 선정의 임상 결정 트리.
- **차세대 DCB hook = biolimus (lipophilic 우위) + M3 신규 표적 (YAP/TAZ · ROCK · BET) combo + degradable nanoparticle carrier** → M8 한국인 ranking에 후보군 입력.
