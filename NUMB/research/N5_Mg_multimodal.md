# NUMB N5 — Mg²⁺-augmented multi-modal nerve block (envelope-expander)

> 🧊 **NUMB novel candidate N5 (per @D d11)**. hexa-LAC v1 (lid 7% + tet 7% eutectic + LA/EtOH CPE + epi 1:200k) 위에 **MgSO₄ 또는 Mg-glycinate** 를 multi-modal adjuvant 로 co-delivery → **required lidocaine MEC 가 r_mg ≈ 0.30 만큼 하향** → 동일 진피-block 깊이 유지하면서 lid 농도 7% → ~5% 로 derate → LAST 헤드룸 ~43% 추가 → **대면적 적응증(타투 제작 500-1000 cm²) 안전 envelope 진입**. 동시에 저농도 OTC SKU (2.5% lid + Mg) 의 *analgesia* coverage 확보.
>
> **honest tier verdict: 🟠 INSUFFICIENT/DEFERRED (concept GREEN, direct topical-MEC-shift 측정 부재)**. 메커니즘 + IV/perineural 시너지는 🟡 임상 정합 (Brill 2002 · 메타분석 21 RCT · NMDA voltage-block 정설), **그러나 *topical Mg + topical lido* 진피 시너지 직접 실측 = 부재**. 본 N5 = first-in-class 후보 (기존 OTC/Rx 에 Mg+LA combo 부재). **돌파 경로: small Phase-1 Franz-cell 또는 volunteer ED50 shift study** (1 측정으로 🟠 → 🟡 승격).
>
> sim = `NUMB/sim/n5_mg_multimodal.hexa` (verbatim 🟢 §3).

---

## 1. 메커니즘 — 왜 Mg²⁺ 가 lidocaine 의 *adjuvant* 인가

### 1.1 dual receptor-level synergy (🟡 임상 정합)

```
   nerve fiber  ────────[axon]────────────► to dorsal horn
                          │
              Na⁺-channel │  ← LIDOCAINE blocks (membrane phase, AP threshold↑)
                          │
              Ca²⁺-channel│  ← Mg²⁺ blocks N-type (PRESYNAPTIC, neurotransmitter
                          │     release↓ at terminal · Hypertension 2004)
                          ▼
                  synaptic terminal
                          │
              NMDA-R Ca²⁺ │  ← Mg²⁺ voltage-dependent block (CENTRAL +
                          ▼     peripheral · pain threshold↑ · PMC7468697)
                  dorsal horn neuron
```

| 메커니즘 | Mg²⁺ 작용 | 임상 효과 | 출처 |
|---|---|---|---|
| **NMDA-R Ca²⁺ flux block** | voltage-dependent · extracellular Mg blocks at resting; depolarization unblocks | central sensitization 억제 · 만성통증 임계↑ | Magnesium and Pain (PMC7468697) · Nature Neurosci 2026 (s41593-026-02283-3) |
| **N-type VGCC block (peripheral terminal)** | dose-dependent block of N-type (>L-type) | presynaptic NT release↓ → AP-threshold synergy | Hypertension 2004 (PMID 15477382 · Shimosawa) |
| **lidocaine Na⁺-channel block** (배경) | use-dependent · MEC ≈ 0.5-0.9% dermal | AP propagation 차단 | Yi 2017 · Lyles 2016 |

> **핵심**: 세 채널이 *직렬* (Na 차단 + Ca 차단 + NMDA gate) 로 작용 → 한 채널만으로 못 깬 threshold 를 두-세 채널 동시 약화로 깬다. lidocaine 단독 MEC 가 r_mg 만큼 *내려가는* 물리적 근거.

### 1.2 임상 evidence — IV / perineural 위주 (🟡)

| 연구 | 설정 | 효과 | 출처 |
|---|---|---|---|
| Brill 2002 | IV Mg neuropathic pain | sustained analgesia · 시조 정설 | Br J Anaesth 89:711 |
| Wadhwa 2020 (mastectomy) | lido+Mg IV vs Mg-only vs remi | morphine rescue 6.7% vs 70% vs 76.6% | EJA 37(3):e9 (PubMed 31977625) |
| Choi 2018 (FNB prehospital) | Mg adjuvant FNB | analgesia 개선 · local dose 감량 가능 | Hindawi PMR 2018:2926404 |
| Lim 2021 meta-analysis 21 RCT 1323명 | Mg peri-block adjuvant | **sensory block 지속 +114.6 min** (~1.9h) · postop 진통제 SMD −2.06 | PMID 34128482 |
| infraclavicular BPB | Mg+lido | onset 가속 · 지속 연장 | PMC7647732 |

> **route paradox 정직 기록**: perineural Mg 가 *local* 에서는 Na 차단을 약간 *attenuate* 한다는 보고 있음 (route-dependent · BMC Anesth 2026). 본 N5 의 **topical co-delivery** 는 *receptor-level* (NMDA + presynaptic Ca) synergy 를 노리는 것이지 *channel-level competitive* 효과가 아니므로 perineural 역설은 **적용되지 않음** (작용 부위·시간상수 다름). 단 이 구분은 honest gap (§4) 으로 명시.

---

## 2. r_mg 정량화 — *얼마나* MEC 가 내려가는가

### 2.1 직접 measurement 부재 → 임상 dose-sparing 으로 보수 추정

dermal-MEC 직접 측정 (lidocaine alone vs lidocaine+Mg) 실험은 **literature에 부재**. 대신 surgical opioid-sparing / local-dose-sparing 데이터 메타분석에서 *비례적* 등가 환산:

| evidence | observed effect | dermal-MEC 환산 r_mg |
|---|---|---|
| Wadhwa 2020 morphine rescue 6.7% vs 70% | rescue need ~10× ↓ | upper-bound (전신적, central+peripheral 통합) |
| Lim 2021 meta sensory block +114.6 min | 지속 ~1.9× ↑ (peripheral) | dose-equivalent ~25-40% ↓ |
| Choi 2018 FNB | "local dose 감량 가능" (qual) | qual support |
| supraclavicular BPB meta (PMC12639445) | dose-reduction estimate 20-35% | central trial range |

**채택**: r_mg ∈ {0.15, 0.30, 0.45} sweep · **central = 0.30** (surgical 25-40% 범위 중앙).

```
   r_mg scenarios (MEC reduction fraction)
   pessimistic  0.15  ████        topical penetration 약 · NMDA 기여 적음
   central      0.30  ████████    surgical opioid-sparing 25-40% 범주 정합
   optimistic   0.45  ████████████ full multi-modal NMDA+Ca + peripheral 동시
```

### 2.2 topical Mg²⁺ 의 SC 침투 — 정직한 보틀넥 (🟠)

Mg²⁺ = **2+ divalent cation** · MW 24 · pKa 비해당 · log P ≪ 0 → **고전적 Lipinski 위반** (SC lipophilic barrier 못 통과 in theory).

| 경로 | 침투 가능성 | 출처 |
|---|---|---|
| **hair follicle (transfollicular)** | ✓ 주 경로 — Mg ion 침투 confirmed, 농도·시간 의존 | Chandrasekaran 2016 (PMID 27624531) |
| transcellular | ✗ divalent charge block | (general SC physics) |
| paracellular w/ MgCl₂ liquid phase | ✓ 보조 — hyaluronan delivery에 MgCl₂ 1.5-3× 증진 | Sci Rep 2023 (PMC10319798) |
| LA+EtOH CPE 환경 (hexa-LAC v1) | △ enhanced (lipid fluidization → ion mobility ↑) | Lunter MD-inference |

> **합리적 가정**: hexa-LAC v1 의 LA+EtOH CPE 백본 + peel-film occlusion 환경에서 Mg²⁺ 가 hair follicle + LA-perturbed lipid 경로로 진피에 *부분적* 도달 → presynaptic Ca²⁺ block 효과 발현. **central r_mg=0.30 가정의 잠재적 약점은 여기서 발생** (Mg 농도가 진피에서 NMDA-block 임계 1-2 mM 에 도달하지 못할 가능성).

---

## 3. hexa-native recompute (verbatim · 🟢 · per @D g5)

```
=== NUMB N5 — Mg2+ multimodal envelope expansion ===

model: MEC_combo = MEC_alone * (1 - r_mg)
       lid_conc_new = MEC_combo / depth_factor   (keep C(200um)/MEC ratio = 1.0)
       k_LAST       = k0 * (lid_conc_new / lid_conc_old)
       Cmax(A)      = k_LAST * m_cream * A * lid_conc_new * 1000
       A_max        = C* / (k_LAST * m_cream * lid_conc_new * 1000)

[0] anchors:
  MEC lid alone (dermal nerve block) : 0.5 %
  hexa-LAC v1 lid concentration      : 7.0 %
  C(200um) v1 (lambda=60um, epi)     : 0.499 %  (= MEC alone)
  depth_factor (C(200um)/lid_conc)   : 0.0712857
  k_LAC v1 (ER3x + epi)              : 0.07995 ng/mL per mg

[1] Mg-induced MEC shift scenarios:
  r_mg = 0.15 (pessimistic)  -> MEC_combo = 0.425 %
  r_mg = 0.30 (central)      -> MEC_combo = 0.35 %
  r_mg = 0.45 (optimistic)   -> MEC_combo = 0.275 %

[2] required lidocaine concentration (depth-matched, lambda=60, +epi):
  v1 baseline                : 7.0 %
  r_mg 0.15 -> lid required  : 5.96192 %  (drop 14.8297 %)
  r_mg 0.30 -> lid required  : 4.90982 %  (drop 29.8597 %)
  r_mg 0.45 -> lid required  : 3.85772 %  (drop 44.8898 %)

[3] Cmax @ A=100 cm^2, 30-min apply, +epi:
  hexa-LAC v1 (7% lid)       : 18.3835 ng/mL  (margin 271.983x)
  N5 r_mg 0.15 (5.96% lid)   : 15.6573 ng/mL  (margin 319.34x)
  N5 r_mg 0.30 (4.91% lid)   : 12.8943 ng/mL  (margin 387.77x)
  N5 r_mg 0.45 (3.86% lid)   : 10.1312 ng/mL  (margin 493.525x)

[4] A_max (CNS-warn 5000 ng/mL, 30-min apply, +epi):
  hexa-LAC v1 (7% lid)       : 27198.3 cm^2
  N5 r_mg 0.15 (5.95% lid)   : 31934.0 cm^2  (+17.41 %)
  N5 r_mg 0.30 (4.90% lid)   : 38777.0 cm^2  (+42.57 %)
  N5 r_mg 0.45 (3.85% lid)   : 49352.5 cm^2  (+81.45 %)

[5] tattoo-creation @ A=500 cm^2 (full arm sleeve / back panel):
  hexa-LAC v1 (7%)           : 91.9176 ng/mL (margin 54.40x)
  N5 r_mg 0.30 (4.90%)       : 64.4713 ng/mL (margin 77.55x)
  --> N5 central removes the 400 cm^2 Pliaglis-eq cap by ~40% headroom

[6] OTC downscale check (2.5% lid + Mg, r_mg=0.30):
  C(200um) OTC     : 0.178214 %
  MEC_combo target : 0.35 %
  ratio C/MEC      : 0.509184 x
  --> 0.509 x of MEC -- analgesia / weak block (vaccine, blood-draw OK; tattoo NO)
```

### 3.1 envelope diagram (MEC shift → area headroom)

```
   plasma lidocaine Cmax @ 500 cm^2 vs lid concentration (30min, +epi)
   5000 ┤▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ CNS-warn (5 ug/mL)
   2500 ┤────────────────────────────────── 50% safety floor
        │
    131 ┤━━ pessimistic Mg (r=0.15, lid=5.96%)
     92 ┤━━ hexa-LAC v1 (lid=7%, baseline)
     64 ┤━━ N5 central (r=0.30, lid=4.90%)  ← 28% headroom recovery
     50 ┤━━ N5 optimistic (r=0.45, lid=3.85%) ← 45% headroom recovery
        └─→ Cmax (ng/mL)
        
   A_max envelope (CNS-warn, 30min, +epi)
   v1            ████████████████████ 27,198 cm² (theoretical)
   N5 r=0.15     ██████████████████████ 31,934 cm² (+17%)
   N5 r=0.30     ████████████████████████████ 38,777 cm² (+43%) ← 권장 라벨 ≤700 cm²
   N5 r=0.45     ███████████████████████████████████ 49,353 cm² (+81%)
   
   (현실 라벨은 Pliaglis-eq conservatism 으로 theoretical ÷ ~50 → v1=400, N5=~700)
```

### 3.2 적응증 매핑 — *어떤 indication 이 unlock 되는가*

| indication | typical A | hexa-LAC v1 (7%) | N5 (4.90% + Mg) | 변화 |
|---|---:|---|---|---|
| 백신 / IV access | 5-15 cm² | ✓ ✓ default | ✓ ✓ default | 동일 GREEN |
| filler / botox (얼굴) | 30-60 cm² | ✓ ✓ default | ✓ ✓ default | 동일 GREEN |
| laser hair (다리 일부) | 100-300 cm² | ✓ default | ✓ default | margin ↑ |
| **타투 제작 작은-중** | **100-400 cm²** | ✓ label edge (margin 68×) | ✓ ✓ comfort (margin 78× @500) | LAST headroom ↑43% |
| **타투 제작 sleeve** | **400-800 cm²** | △ split 필요 / 5+5% derate | **✓ single-session GREEN** | **이게 unlock 의 본질** |
| 타투 제작 back panel | 800-1500 cm² | ✗ split 필수 (multi-day) | △ split-필요 (single-day) | session 수 ↓ |
| **OTC 저농도 (2.5% lid + Mg)** | ≤30 cm² | (적용 불가, lid 너무 낮음) | ✓ analgesia (51% MEC) → 통증 *감소*, 완전 차단 아님 | 신규 SKU enable |

> **가장 크게 unlock 되는 적응증**: **타투 sleeve (400-800 cm² · single-session)**. 현존 hexa-LAC v1 은 Pliaglis-eq 보수 라벨 ≤400 cm² 이기 때문에 sleeve 는 *split or derate* 강제 — 시술 워크플로 깨짐. N5 central 은 *동일 보수율* 적용해도 ≤700 cm² 까지 single-session.

---

## 4. 정직한 gap (per @D d5/d6)

| gap | tier | 해소 경로 |
|---|---|---|
| **topical Mg + topical lido 의 dermal MEC-shift 직접 측정 부재** — 모든 r_mg 추정은 IV/perineural 데이터 환산 | **🟠 (가장 큰 gap)** | Phase 1 small Franz-cell ED50 shift study (lid alone vs lid+MgSO₄ 5%/10%) |
| Mg²⁺ topical 침투율 (divalent + SC barrier) — hair follicle 경로 confirmed but quantitative dermal-concentration data 부재 | 🟠 | tape-stripping 또는 dermal microdialysis 1점 측정 |
| MgSO₄ vs Mg-glycinate vs MgCl₂ — 어떤 salt 가 LA+EtOH eutectic 환경에서 안정 + 침투 최선인지 | 🟠 | A5-style ex-vivo 비교 (3 salt × Franz) |
| **MgSO₄ crystallization in cream** — 고농도(>5%) 시 supersaturation peel-film 안정성 위협, eutectic 깨질 위험 | 🟠 | 제형 stability shelf-life test |
| **perineural Mg paradox** (BMC Anesth 2026) — local 에서 Na 차단 *attenuate*; topical 적용 가능성 (penetration 후 nerve 부근에서 mimic) | 🟡 | receptor-level vs channel-level 작용 시간/농도 분리 — concept argument 만으로는 불충분, 측정 필요 |
| **clinical evidence topical Mg+LA**: 거의 부재 (대부분 preclinical 또는 systemic) | 🟠 | 본 candidate 자체가 첫 임상 grounding 후보 |
| pediatric Mg dose ceiling — IV Mg 는 hypotonia·resp depression 위험 | 🟡 | topical Mg 흡수율 낮아 systemic Mg 농도 비교적 안전, 라벨 conservative |
| MgSO₄ 자극 (mild) on broken/inflamed skin | 🟡 | "intact skin only" 표준 contraindication |

### 4.1 가장 큰 단일 gap

> 🚨 **#1 — direct topical Mg+lido dermal-MEC shift measurement = ABSENT**. 전 시뮬레이션이 IV/perineural 의 surgical opioid-sparing 25-40% 를 *비례 환산* 한 r_mg=0.30 에 매달려 있음. 만약 실제 dermal r_mg 가 ≤0.10 이면 (즉 Mg 가 SC 를 충분히 통과 못해 dermal Mg 농도 < NMDA-block 임계 ~0.5-1 mM) → envelope 확장 효과가 17% 이하로 떨어져 *practical benefit minimal*. **결정점 = 1 측정** (Phase 1 small study, Franz cell ED50 shift 또는 in-vivo volunteer pin-prick threshold).

---

## 5. 경쟁/선례 체크 — *first-in-class?*

| 제품 | 조성 | 카테고리 | Mg 포함? | LA 포함? |
|---|---|---|---|---|
| EMLA · Pliaglis · LMX | lid (+tet/prilo) | 토픽 마취 | ✗ | ✓ |
| MagnesiumFreeze (OTC) | MgCl₂ + arnica + boswellia + menthol | 근육통 cream | ✓ | ✗ (counter-irritant only) |
| Bayview MgCl₂ 10% cream | MgCl₂ 10% in cream base | 근육경련·eczema (compounded) | ✓ | ✗ |
| Mg-sulfate 욕염 (Epsom salt) | MgSO₄ 7H₂O | 일반 bath | ✓ | ✗ |
| compounded MgSO₄ + ketamine cream | (pain clinic only, FDA 미승인) | neuropathic | ✓ | △ ketamine, not lido |

> **결론**: **topical Mg + topical lidocaine combination — FDA 승인 제품 부재 · OTC monograph 등록 부재 · 주요 compounded 처방 부재**. N5 = **first-in-class topical Mg-LA combo**. 단 이것은 *novelty 동시에 regulatory headache* — 신규 combination 으로 505(b)(2) 또는 NDA 경로, OTC monograph 외 (lid + Mg 둘 다 모노그래프 외 결합) → 시간·비용 큰 path.

---

## 6. tier ledger + verdict

| claim | tier | 비고 |
|---|---|---|
| Mg NMDA-R Ca²⁺ block · voltage-dependent · presynaptic N-type VGCC block | 🟡 | 정설 · PMC7468697 · Hypertension 2004 |
| MEC = C_surf × depth_factor · MEC_combo = MEC_alone(1−r_mg) · A_max = C*/(k·m·c) | 🔵 closed-form |
| §3 hexa recompute (sim verbatim) | 🟢 | numerical |
| IV/perineural Mg+lido morphine-sparing 25-40% · sensory block +114min | 🟡 | Wadhwa 2020 · Lim 2021 meta |
| topical Mg SC 침투 via hair follicle 가능 (qualitative) | 🟡 | Chandrasekaran 2016 |
| **r_mg=0.30 for TOPICAL Mg+lido (dermal-MEC shift)** — IV/perineural→topical 환산 | **🟠** | Phase 1 측정 필요 |
| topical Mg+LA 시너지 임상 evidence | 🟠 | preclinical/systemic precedents only |
| MgSO₄ crystallization · stability · salt selection | 🟠 | A5-style stability test |

### N5 종합 verdict (per @D d5/d6)

> **🟠 INSUFFICIENT/DEFERRED concept — *envelope-expander 잠재력은 명확하나 directly-measured topical r_mg 없이는 라벨 결정 불가***.
>
> - **PRO**: 메커니즘 정합 (3-receptor 직렬 synergy) · IV/perineural 임상 strong · first-in-class novelty · 만약 r_mg≥0.30 면 sleeve indication unlock (+43% area headroom)
> - **CON**: topical Mg 침투 약함 (divalent) · 직접 dermal-MEC shift 측정 zero · perineural route-paradox 의 topical 적용 가능성 미해결
> - **돌파경로**: **Phase 1 small study, 단일 측정**: Franz cell 또는 volunteer pin-prick ED50 shift (lid 4% vs lid 4% + MgSO₄ 5%). 1 측정으로 🟠 → 🟡 (또는 🔴 reject).
> - **absorbed=false 유지** — wet-lab 1점 측정이 비-wet-lab 천장.

---

## Sources

- **Magnesium and Pain (mechanism review)** — Banerjee S, Jones S — *Magnesium in the CNS* — [PMC7468697](https://pmc.ncbi.nlm.nih.gov/articles/PMC7468697/)
- **NMDA Mg voltage-block (mechanism)** — *Nature Neuroscience* 2026 — [s41593-026-02283-3](https://www.nature.com/articles/s41593-026-02283-3) · [PMC12637613](https://pmc.ncbi.nlm.nih.gov/articles/PMC12637613/)
- **Mg blocks N-type VGCC at peripheral sympathetic terminals** — Shimosawa T et al. *Hypertension* 2004 — [PMID 15477382](https://pubmed.ncbi.nlm.nih.gov/15477382/) · [AHA Journals](https://www.ahajournals.org/doi/10.1161/01.HYP.0000146536.68208.84)
- **Brill 2002 — IV Mg for neuropathic pain (seed precedent)** — *Br J Anaesth* 89:711-4 — (cited in [Springer J Anesth 2014](https://link.springer.com/article/10.1007/s00540-013-1641-5))
- **Wadhwa 2020 — IV lido+Mg for mastectomy (morphine rescue 6.7% vs 70%)** — *Eur J Anaesthesiol* 37(3):e9 — [PubMed 31977625](https://pubmed.ncbi.nlm.nih.gov/31977625/) · [Journals LWW](https://journals.lww.com/ejanaesthesiology/abstract/2020/03000/synergistic_effect_of_the_association_between.9.aspx)
- **Lim 2021 meta-analysis (21 RCT, 1323 pts) — perineural Mg adjuvant, sensory block +114.6 min** — [PubMed 34128482](https://pubmed.ncbi.nlm.nih.gov/34128482/)
- **Supraclavicular BPB Mg adjuvant meta-analysis** — [PMC12639445](https://pmc.ncbi.nlm.nih.gov/articles/PMC12639445/)
- **Prehospital FNB + Mg adjuvant (local-dose-sparing)** — Choi 2018 *Pain Res Manag* — [PMC6304916](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6304916/) · [Hindawi 2018:2926404](https://www.hindawi.com/journals/prm/2018/2926404/)
- **Infraclavicular BPB Mg+lido (onset/duration)** — [PMC7647732](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7647732/)
- **Topical Mg permeation via hair follicles (human SC)** — Chandrasekaran et al. 2016 *Magnes Res* — [PubMed 27624531](https://pubmed.ncbi.nlm.nih.gov/27624531/)
- **MgCl₂-facilitated topical delivery (hyaluronan 1.5-3× boost)** — *Sci Rep* 2023 — [PMC10319798](https://pmc.ncbi.nlm.nih.gov/articles/PMC10319798/) · [Nature s41598-023-37718-5](https://www.nature.com/articles/s41598-023-37718-5)
- **Adjuvant LA peripheral block review (qualitative)** — *PLOS One* 2015 — [PMC4565585](https://pmc.ncbi.nlm.nih.gov/articles/PMC4565585/)
- **Curb Your Enthusiasm — adjuvant safety (none FDA approved)** — *ASRA News* 2020 — [asra.com 2020/11](https://asra.com/news-publications/asra-newsletter/newsletter-item/asra-news/2020/11/01/curb-your-enthusiasm-local-anesthetic-adjuvants-for-peripheral-nerve-blocks)
- **TTR-LAC inherited anchors** — `TTR-LAC/research/A2_A3_accel_depth.md` (MEC 0.5%, depth model) · `TTR-LAC/research/A4_candidate_LAST.md` (Pliaglis k=0.0533, LAST thresholds, hexa-LAC v1)
- (재현) `NUMB/sim/n5_mg_multimodal.hexa` — `hexa run NUMB/sim/n5_mg_multimodal.hexa`
