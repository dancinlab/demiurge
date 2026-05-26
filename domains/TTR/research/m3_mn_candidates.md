# TTR-MN M3 — 활성성분 후보 ranking (first-principles)

> 출처: `moa_shortlist.md` (M2 · 5 family · 62 handles) + `off_target_safety.md` (M6 · TI 우선순위) + `arxiv_deep_research.md` (CeO₂ pH-switch · Cu-doped Fenton · PrOx nanozyme)
> milestone: TTR-MN.md "M3-MN 활성성분"
> scope: payload-agnostic (microneedle delivery — MW unbounded). M2의 62 handles 중 M6 TI 정합 후보를 first-principles ranking.

## TL;DR

5 family × top candidate ranking. 최상위 3:
1. **CeO₂ 나노자임** (F1 새 default · arxiv:2104.10994) — pH-switchable 산화환원 → M6 Col×Ox TI 갭 해결
2. **DyP peroxidase + DFO 듀얼** (F5+F3) — 유기/금속 입자 동시 표적
3. **AzoR + ascorbate cascade** (F5+F2) — azo (시장 60%) 분해

## Family priority recap (M6 → M3 적용)

| family | M6 priority | M3 적용 조건 |
|---|---|---|
| F5 enzymatic | ★★★ (size-selective · TI≥1) | top priority |
| F3 metal-coordination | ★★ (단백질 unaffected) | second |
| F2 electron transfer | ★ (산화 부산물 적음) | third |
| F1 ROS-generating | △ (조건부) | pH-switchable 나노자임만 (CeO₂ class) |
| F4 photoexcited | △ (조건부) | site-localized geometry만 (MN-tip 광원) |

## F5 enzymatic top 5

| # | name | UniProt | MW (kDa) | K_cat (s⁻¹) | K_m (mM) | pH opt | 표적 | score |
|---|---|---|---|---|---|---|---|---|
| 1 | DyP-type peroxidase (B. adusta) | needs lookup | ~50 | ~10² | 0.05-0.3 | 3.5-4.5 | 유기 dye + Cu-Pc | ★★★ |
| 2 | AzoR (azoreductase) | P41407 | 23 | ~10² | 0.1-0.5 | 7.0-8.0 | azo N=N | ★★★ |
| 3 | Laccase variant (fungal) | BRENDA 1.10.3.2 | 60-80 | 10¹-10² | 0.1-1.0 | 4.0-5.5 | phenolic + co-mediator azo | ★★ |
| 4 | Cytochrome P450 fungal (e.g., CYP63A2) | needs lookup | ~60 | 10⁻¹-10¹ | 변동 | 7.0 | 다양 (broad) | ★ |
| 5 | Plant horseradish peroxidase (HRP) | P00433 | 44 | 10² | 0.1 | 6-7 | phenolic 산화 | ★ |

## F3 metal-coordination top 5

| # | name | PubChem CID | MW (Da) | log K(Fe³⁺) | log K(Cr³⁺) | 표적 | score |
|---|---|---|---|---|---|---|---|
| 1 | Deferoxamine (DFO) | 2973 | 656 | ~30 | ~30 | Fe oxide · Cr₂O₃ | ★★★ |
| 2 | DTPA | 3053 | 393 | 28 | 22 | Fe oxide | ★★ |
| 3 | EDTA | 6049 | 292 | 25 | 23 | Fe oxide | ★★ |
| 4 | Pyochelin (siderophore) | needs lookup | 325 | ~25 | low | Fe 선택적 | ★ |
| 5 | Enterobactin | 34230 | 670 | ~52 (Fe³⁺) | low | Fe 선택성 최고 | ★★ |

## F2 electron transfer top 5

| # | name | PubChem CID | MW (Da) | E° (V) | 표적 | score |
|---|---|---|---|---|---|---|
| 1 | Ascorbate (Vitamin C) | 54670067 | 176 | +0.058 (단계) | azo + Fe³⁺/Cr³⁺ | ★★★ |
| 2 | Sodium dithionite | 24489 | 174 | -0.66 | azo (강) | ★ (강환원, 부산물 우려) |
| 3 | NADPH + recycle | 5884 | 744 | -0.32 | enzyme cofactor | ★★ (효소 페어) |
| 4 | Glutathione (GSH) | 124886 | 307 | -0.24 | 약환원 (S-S) | ★ |
| 5 | Hydroquinone | 785 | 110 | -0.04 (quinone/HQ) | 광-환원 보조 | △ (toxicity) |

## F1 pH-switchable 나노자임 (arxiv 새 발견 · M3 핵심 shift)

| # | name | size (nm) | pH switch | activity 종류 | 표적 | score |
|---|---|---|---|---|---|---|
| 1 | **CeO₂ NP** | 5-10 | pH 7.4 → antioxidant · pH 4-5 → Fenton-like | dual (oxidase + catalase + SOD-like) | broad pigment + 자기-제어 | ★★★ (arxiv:2104.10994) |
| 2 | Cu_xFe_{3-x}O_4 | 10-20 | constitutive Fenton | peroxidase-like | Fe oxide pigment 자기촉매 | ★★ (arxiv:2402.15338) |
| 3 | PrOx | 5-15 | pH-modulated | oxidase (K_m < 0.026 mM) | broad | ★★ (arxiv:2402.02505) |
| 4 | MnO₂ NP | 10-50 | pH 5-6 active | catalase + oxidase | ROS scavenger 보조 | ★ |
| 5 | V₂O₅ NP | 5-20 | pH dependent | haloperoxidase-like | 광선택성 | △ |

## F4 photoexcited (조건부 · MN-tip localized only)

| # | name | band gap (eV) | absorption edge (nm) | quantum yield | 표적 | score |
|---|---|---|---|---|---|---|
| 1 | TiO₂ NP (anatase) | 3.2 | 387 | 0.1-0.5 (¹O₂) | Cr₂O₃ band-gap matched · broad | ★★ |
| 2 | g-C₃N₄ | 2.7 | 460 | 0.05-0.2 | Cu-Pc Q-band 보조 | ★★ |
| 3 | ZnO NP | 3.3 | 376 | 0.05-0.1 | UV 영역 | ★ |
| 4 | Bi₂WO₆ | 2.7 | 460 | 0.1 | visible-light · 안정 | ★ |

## Top-3 overall ranked

### 🥇 1순위 — CeO₂ 나노자임 (F1 새 default)

- **arxiv:2104.10994** — DFT 기반 pH-driven Ce³⁺/Ce⁴⁺ ratio switch. pH 7.4 = Ce³⁺-rich antioxidant · pH 4-5 = Ce⁴⁺-rich Fenton-like.
- **선택성**: macrophage phagolysosome (pH 4-5)에서만 active → 진피 콜라겐 매트릭스 (pH 7.4) 보호. M6 Col×Ox 🔴 TI=10⁻⁹ 갭 정량 해결.
- **first-principles 근거**: BDE Ce-O ≈ 755 kJ/mol · Ce³⁺/Ce⁴⁺ E° = +1.72 V (산성) vs +0.34 V (중성).
- **risk**: 멜라닌 세포가 NP를 phagocytose 시 mel TI 추가 평가 필요 (M6 Mel×Ox 🔴 · arxiv 데이터 부재). M9 검증.
- **cost**: NP 합성 저비용 ($수십/g)

### 🥈 2순위 — DyP peroxidase + DFO 듀얼

- **DyP**: K_cat ~10² s⁻¹ · MW ~50 kDa · pH opt 3.5-4.5 (phagolysosome 정합) · 유기 dye + Cu-Pc 둘 다 (arxiv 한정 보고)
- **DFO**: PubChem 2973 · log K(Fe³⁺) ≈ 30 · log K(Cr³⁺) ≈ 30 · MW 656 Da
- **듀얼 attack**: DyP가 azo + 유기 매크로사이클, DFO가 Fe oxide + Cr₂O₃ surface coordination
- **risk**: 효소 immunogenicity (repeat dose · IgE) — humanized variant or 항원성 epitope 절제 필요. M9 면역검증.
- **cost**: recombinant DyP $$/mg (E. coli expression OK)

### 🥉 3순위 — AzoR + ascorbate cascade

- **AzoR**: UniProt P41407 · K_cat ~10² s⁻¹ · MW 23 kDa · 시장 60% (color ink) 표적
- **Ascorbate**: PubChem 54670067 · pH-stable · 단계적 reductive
- **cascade**: AzoR 1차 (NADPH cofactor) → ascorbate 2차 (radical scavenger · 부산물 quench)
- **표적**: azo N=N (M1 top cleavable bond BDE 167 kJ/mol)
- **risk**: aromatic amine byproduct (azo cleavage product · IARC group 1/2A class 일부) → M5 MD/QM 경로 정량 + M6 toxicokinetics 검증
- **cost**: AzoR 저비용 · ascorbate 매우 저비용

## Wall-region (Cu-Pc · Cr₂O₃) coverage

| pigment | strategy | first-principles 근거 | arxiv 인용 |
|---|---|---|---|
| Cu-Pc (구리 프탈로시아닌) | F4 site-localized: g-C₃N₄ visible-light + MN-tip waveguide | Q-band 670 nm absorbs · g-C₃N₄ band gap 2.7 eV (460 nm) overlap · MN-tip localizes (광역 melanocyte 노출 회피) | arxiv search 결과 부재 (PubMed 필요) |
| Cr₂O₃ (크롬 산화물) | F3 DFO surface coordination + F2 ascorbate reductive dissolution + F4 UV-A 365 nm | Cr³⁺ chelation log K + Cr³⁺/Cr²⁺ E° = -0.41 V + band gap 3.4 eV ≡ UV-A 365 nm photon energy 정확 매치 | arxiv:2405.11122 (band gap 3.4 eV 정량 확인) |

## External library call plan (M5 prerequisite)

- **PubChem PUG-REST**: `https://pubchem.ncbi.nlm.nih.gov/rest/pug/compound/cid/<CID>/property/CanonicalSMILES,MolecularWeight/JSON`
- **UniProt + AlphaFold**: `https://rest.uniprot.org/uniprotkb/<ID>.json` + `https://alphafold.ebi.ac.uk/files/AF-<ID>-F1-model_v4.pdb`
- **BRENDA**: K_cat lookup (SOAP API · token required for full data)
- **PDB**: `https://files.rcsb.org/download/<PDB_ID>.pdb` (azoreductase · DyP · laccase 결정구조 있는 것)

## M5-MN handoff

다음 milestone (M5-MN: MD/QM)이 받는 입력 list:
- candidate SMILES set (CeO₂ unit cell · DyP/AzoR/laccase enzyme model · DFO · ascorbate)
- 표적 pigment 분자 모델 (azo monomer · Cu-Pc 매크로사이클 · Cr₂O₃ unit cell · Fe₂O₃ unit cell)
- 시뮬 조건 (pH 4-5 phagolysosome · pH 7.4 진피 · 37°C · water box · NaCl 150 mM)
- 검증 outputs: 반응 자유에너지 ΔG · 활성화 에너지 Ea · 부산물 prediction

## Honest unknowns

- DyP UniProt ID 확정 (B. adusta · A. auricula variant 명세) — M5 PDB lookup 시 해소
- CeO₂ 멜라닌 세포 off-target 정량 — arxiv 부재, M9 in-vivo 검증 필수
- DyP의 Cu-Pc 실제 활성 (Roberts 2011 · Liers 2013 claim — PubMed 검증 권장 per arxiv §14)
- 효소 immunogenicity numeric (반복투여 IgE risk)
- aromatic amine byproduct toxicokinetics — M6 1순위 표적
- recombinant 효소 합성 cost magnitude (scale-dependent · M7-MN 검증)
- BRENDA K_cat 일부 missing (cross-reference UniProt 필요)
- F4 광원 MN-tip waveguide engineering 실현성 — M7-MN 합성/제형 검증

## 진행 상태

- ✅ 5 family × top 5 candidate ranking · top-3 overall surfaced
- ✅ wall-region (Cu-Pc · Cr₂O₃) breakthrough path 각 1+ 후보
- ✅ M5 input list · external API plan 정리
- next: M5-MN (MD/QM 시뮬) — Vina · OpenMM 적용 또는 hexa-native 포팅 (per `archive/session-notes/2026-05-24-ttr-external-port-candidates.md`)
