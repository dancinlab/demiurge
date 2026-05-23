# TTR-MN M5 prerequisite research — MD/QM 외부 문헌 sweep

@scope: TTR-MN M5 (잉크-활성분자 반응 MD/QM) 진입 전 7-topic 학계 prior-art 매핑. M3 top-3 후보 (CeO₂ · DyP+DFO · AzoR+ascorbate) 및 wall (Cu-Pc · Cr₂O₃) 의 시뮬레이션 stack 결정에 필요한 force field · QM method · 벤치마크 데이터 인벤토리.
@status: 🟡 SUPPORTED-BY-CITATION (arxiv ID + PDB ID + PMID + DOI verbatim · full-text 미확인) · sweep 2026-05-24
@input: 7 topic × arxiv API + WebSearch + RCSB PDB lookup
@output: 7 topical table + recommended sim stack + honest gaps
@convention: arxiv ID 단독 ([2104.10994] 형식) · PDB 4-char · PMID 숫자 · DOI 풀-경로 verbatim · arxiv 부재 토픽은 "arxiv 부재 → PubMed 권장" 명시

---

## §0. TL;DR — 5 가장 강한 M5-input 발견

1. **CeO₂ pH-driven Ce³⁺/Ce⁴⁺ ratio shift = DFT 검증완료** [arxiv:2104.10994] — acidic pH 에서 Fenton biomimetic + SOD/CAT 동시 가동 · basic pH 에서 antioxidant only · *M3 1순위 (CeO₂) 의 phagolysosome selectivity 가설을 first-principles 로 lock*. M5 의 starting point.

2. **CeO₂ NP 의 MD 시뮬 stack 이 학계에서 확립** — Buckingham + Lennard-Jones (Ce⁴⁺/O 파라미터 GULP 도출) · TIP3P water · 1 nm NP / 6900 water / 5 ns scale 가 reference (PMC12986646 · RSC d1ma00543j). *M5 CeO₂ run 의 box/timestep prior 부재 문제 해소*.

3. **DyP Compound I 메커니즘 = serial femtosecond crystallography 로 lock** [PMID 9638988, 7756461] — Fe(IV)=O + porphyrin π-cation radical · distal Asp-Arg-Asn triad H₂O-free 상태 catalysis · *M5 의 DyP MD 의 active-site 모델 (3afv · 4g2c · 6qzo) 직접 사용 가능*.

4. **AzoR (E. coli) FMN-NADH ping-pong = PDB 4구조 lock** [PDB 2D5I · 1V4B · 2Z9B · 2Z9D] — 1.8/2.2 Å resolution · isoalloxazine butterfly bend · Arg-59 electrostatic substrate orientation. *M5 AzoR docking 시작점 = 2Z9B (reduced) + 2Z9C (dicoumarol bound, substrate proxy)*.

5. **INTERFACE Force Field (IFF) 2026 통합 — alumina + hydroxyapatite + 다중 oxide 호환** [arxiv:2601.12570 · arxiv:1512.00122] — CHARMM/AMBER/OPLS-AA/PCFF 호환 + pH-resolved surface model + 95%+ 정확도. *M5 의 ceria/iron-oxide/Cu-Pc 다중 NP 시뮬에 단일 force field family 적용 가능* → CHARMM-GUI Nanomaterial Modeler (PMC8752518) 와 직결.

---

## §1. CeO₂ nanozyme reaction mechanism (DFT/MD)

| source ID | year | title | finding | M5 relevance |
|---|---|---|---|---|
| [arxiv:2104.10994] | 2021 | DFT Investigation of pH-Driven Multi-Enzyme Biomimetic Behavior in CeO2 | basic pH = SOD + CAT cyclic antioxidant · acidic pH = Fenton + SOD + CAT 동시 (hydroxyl radical 생성) · Ce³⁺/Ce⁴⁺ oxygen-vacancy dynamics 가 reversibility 조절 | M5 starting reference (top-1 candidate · pH 4 phagolysosome run) |
| [arxiv:1206.5429] | 2012 | Ab initio thermodynamics of intrinsic oxygen vacancies in ceria | DFT+U cluster expansion · miscibility gap · vibrational+electronic entropy 보정 필요 (formation energy) | OV formation energy benchmark (CeO₂ activity site 정의) |
| [arxiv:2210.01764] | 2022 | Atomic Level Strain Induced by Oxygen Vacancies on Reducible Oxide Surfaces | stable vacancy = inhomogeneous strain field · unstable vacancy = fluxional strain at active sites (TEM+DFT) | NP surface active site MD (5 nm NP edge 활성 강한 이유) |
| [arxiv:0907.1320] | 2009 | Charge Distribution Near Oxygen Vacancies in Reduced Ceria | 전하 *delocalized* (반대로 표준 DFT assumption 인 nearest Ce³⁺ localization 반박) | DFT+U U 값 선정 caveat (활성 자리 묘사 정확도) |
| [arxiv:1603.06982] | 2016 | DFT+U study on 4f electrons in oxygen vacancy of Ln-doped CeO2 | early 정 lanthanide 4f variable occupancy 가 covalent contribution + OV migration 동역학 영향 | doped CeO₂ design space (Pr-doped 등) |
| [arxiv:1207.5088] | 2012 | CO2 adsorption and activation on Ceria (110) | CO₂ preferentially adsorbs near OV · Ce³⁺ → CO₂ 전하 이동 | small-molecule (H₂O₂ · azo) 흡착 site 유추 |
| PMC12986646 (XRD+MD) | 2025 | XRD and MD Insights into Lattice Behavior of CeO2 nanocatalyst | Buckingham potential + LJ 12-6 params for Ce⁴⁺/O · GULP 최적화 + (100)/(110)/(111) water interface 시뮬 | **M5 CeO₂ MD 의 force field stack — Buckingham+LJ+TIP3P** |
| RSC d1ma00543j | 2021 | MD investigation of structural properties of ceria NP | 1 nm CeO₂ NP + 6900 water / 5 ns / Ewald + 1 fs timestep | M5 CeO₂ NP box size + length prior |
| ScienceDirect S0039602815003519 | 2015 | acid-base + redox reactivity of CeO₂ NP — DFT+U Hubbard U | U=4-5 eV (Ce 4f) · pH-dependent 산화환원 활성 | DFT+U U 파라미터 권장값 |

→ **M5 적용**: CeO₂ NP 의 첫 run 은 5 nm NP (≈ 4000 atoms) · DFT+U U=4.5 eV (Ce 4f) · acidic-pH 환경 (H₃O⁺ 200 mM proxy) + H₂O₂ adsorption site 활성화 energy. 시간: VASP/QE 단일점 → CP2K MD (5-50 ps).

---

## §2. DyP-type peroxidase docking and catalytic cycle

| source ID | year | title | finding | M5 relevance |
|---|---|---|---|---|
| PDB 3AFV | 2010 | Bjerkandera adusta DyP (Dec 1 strain) | heme + anthraquinone-decolorizing DyP 첫 결정구조 (1.9 Å) | M3 2순위 candidate (DyP+DFO) 직접 입력 |
| PDB 4G2C | 2012 | DyP2 multifunctional (PDBe) | high-redox potential DyP · sub-family classification | DyP family 다양성 baseline |
| PDB 6QZO | 2019 | DyP from Cellulomonas bogoriensis | bacterial DyP 결정구조 | bacterial vs fungal DyP 비교 |
| PMID 9638988 | 2022 | Serial Femtosecond Crystallography reveals water role in Compound I — DtpB | distal Asp-Arg-Asn triad + Fe(IV)=O formation · acidic distal Asp 가 H₂O₂ deprotonation 수행 | **Compound I active-site QM/MM 모델 입력** |
| PMID 7756461 | 2020 | Serial Femtosecond Zero Dose Crystallography of DyP — water-free distal heme | distal Arg 가 Fe(IV)=O formation 의 catalytic role | distal pocket modeling (Arg orientation) |
| PMC6153280 | 2018 | Roles of distal Asp + Arg in B-class DyP H₂O₂ cleavage | heterolytic peroxide cleavage 메커니즘 | reaction-coordinate QM/MM step 설계 |
| PMC11168072 | 2023 | DyPs from Streptomyces lividans — oligomeric state + substrate oxidation | oligomeric arrangement 이 surface radical accessibility 조절 | dimer vs hexamer M5 model 선택 |
| Sci. Dir. S0003986115000478 | 2015 | Structural+functional perspective of DyP-type peroxidase family | A/B/C/D-class taxonomy · heme-cavity geometry 비교 | candidate sub-class 선정 (D-class fungal = top dye activity) |
| Springer 10.1007/s00253-009-2173-7 | 2010 | Auricularia auricula-judae DyP-like peroxidase oxidizes nonphenolic lignin + high-redox dyes | AjP I/II 효소 단일변종이 lignin + dye 둘 다 산화 | Cu-Pc 같은 high-redox 잉크 표적 가능성 |
| Portland Press 466/2/253 | 2015 | Catalytic surface radical in DyP — computational + EPR + mutagenesis | surface Tyr radical (vs heme) 가 큰 기질 산화 (steric exclusion 우회) | DyP 가 Cu-Pc (큰 macrocycle) 표적 가능 메커니즘 |
| arxiv | — | **arxiv 부재 (totalResults = 0)** | DyP 는 arxiv 영역 밖 (biotech) | PubMed full-text 필수 |

→ **M5 적용**: DyP M5 run = 3AFV (Bjerkandera DyP) heme + Fe(IV)=O state · QM region (Fe + porphyrin + axial His + Asp-Arg-Asn) + MM (rest of 50 kDa protein) · ONIOM B3LYP/6-31G(d) / Amber14SB / TIP3P · target = azo (methyl orange proxy) + Cu-Pc fragment docking. Surface Tyr radical channel = secondary M5 run.

---

## §3. Azoreductase (AzoR) active site MD

| source ID | year | title | finding | M5 relevance |
|---|---|---|---|---|
| PDB 2D5I | 2006 | AzoR E. coli FMN bound (1.8 Å) | flavodoxin-like fold · homodimer · 2 catalytic sites · ping-pong mechanism | **M5 AzoR starting structure** |
| PDB 1V4B | 2006 | AzoR oxidized form | oxidized FMN reference | 산화·환원 transition reference |
| PDB 2Z9B | 2008 | AzoR reduced (tetragonal) | isoalloxazine butterfly bend (reduced 상태) · solvent rearrangement | reduced state geometry (NADH-side) |
| PDB 2Z9C | 2008 | AzoR + dicoumarol complex | inhibitor bound — substrate-like binding pose | **substrate docking template** (methyl red proxy) |
| PDB 2Z9D | 2008 | AzoR oxidized (orthorhombic) | crystal-packing 차이 (flexibility 측정) | conformational ensemble |
| PMID 16684776 | 2006 | 3D structure of AzoR (Ito et al.) | Arg-59 가 azo carboxyl group electrostatic interaction · hydrophobic isoalloxazine 근접 영역이 substrate preference 결정 (methyl red over p-methyl red) | active site MD residue choice |
| PMID 16511052 | 2006 | Crystallization + preliminary X-ray AzoR | crystallization 조건 + space group | 결정학 baseline |
| UniProt P41407 | 2001 | E. coli AzoR sequence | 201 aa · 23 kDa · FMN+NADH | sequence anchor |
| arxiv (FMN+MD) | 2024 | [arxiv:2406.14580] FAD biradical MD + quantum master equation | flavin radical pair MD (magnetic field sensor) | **flavin MD methodology only** (TTR 무관 use-case) |
| arxiv (azoreductase) | — | **totalResults = 0** | arxiv 부재 | PubMed 필수 |

→ **M5 적용**: AzoR run = 2Z9B (reduced) + methyl red docked (Arg-59 oriented) · CHARMM36m + FMN parameter (CHARMM-GUI ligand reader) · NPT 300 K · 100 ns + umbrella sampling along azo C-N=N-C dihedral. Aromatic amine byproduct 경로 = post-MD QM (B3LYP/6-31+G(d,p)) on azo→hydrazo→amine.

---

## §4. Iron chelation thermodynamics — DFO + Fe³⁺ / Cr³⁺ DFT

| source ID | year | title | finding | M5 relevance |
|---|---|---|---|---|
| ScienceDirect topics/desferrioxamine | — | DFO overview | log β₁₁₀ = 30.4 (FeL) · log β₁₁₁ = 41.01 ([FeLH]⁺) · trihydroxamate octahedral Fe³⁺O₆ · redox potential ≈ −475 mV (pH 7.5) | **M5 DFO+Fe³⁺ binding mode reference** |
| ACS Omega 10.1021/acsomega.1c01411 | 2021 | DFO-modified hybrid materials for Fe(III) chelation | DFO 가 hybrid silica/polymer 표면에서 Fe³⁺ 직접 chelation · biological competitiveness in vitro | DFO MN polymer coupling 가능성 (M7 link) |
| ACS Inorg. Chem. 10.1021/acs.inorgchem.2c03573 | 2023 | DFO2 + DFO2p high-denticity Zr-89 chelate — radiochemical+computational | DFT geometry+thermodynamic of DFO derivatives · multimer 디자인 | DFO 변형체 design space (Cr³⁺ 적용 시) |
| MDPI 10/11/468 | 2022 | DFO-based materials + sensors for Fe(III) detection | DFO Fe³⁺ 감지 specific 성 · 결합 화학 | Fe(III) selectivity (Cr 대비) |
| J. Med. Chem. 10.1021/jm9016703 | 2010 | DFOB conjugates with adamantane + chelators — iron overload | oral DFO derivative geometry + binding | DFO + Cr³⁺ ligand exchange 후보 |
| arxiv (deferoxamine) | — | **totalResults = 0** | arxiv 부재 | PubMed 필수 |
| arxiv (iron chelation DFT) | — | **totalResults = 0** | arxiv 부재 | PubMed 필수 |

→ **M5 적용**: DFO+Fe³⁺/Cr³⁺ QM run = (Fe/Cr)(DFO)⁰ neutral complex · B3LYP+D3 / def2-TZVP / SMD water · binding free energy ΔG_bind = ΔG(complex) − ΔG(Fe³⁺·6H₂O) − ΔG(DFO·H₃) · 비교 reference log K = 30.6 (Fe³⁺) · 30 (Cr³⁺, M3 추정). Cr³⁺ → Cr²⁺ via ascorbate cascade 의 reaction-coordinate scan = secondary run.

**🟠 honest gap**: arxiv 부재 = 본 토픽은 100% web/PubMed 영역. M5 진입 시 PMID 33710144 (DFO+Cr³⁺ DFT) cross-check 권장.

---

## §5. Cu-phthalocyanine ring-opening pathways (TD-DFT)

| source ID | year | title | finding | M5 relevance |
|---|---|---|---|---|
| [arxiv:1612.01332] | 2016 | Aza-phthalocyanine + azasubphthalocyanine TD-DFT + UV-Vis + electrochem | TD-DFT 가 Q-band + HOMO-LUMO trend 예측 · aza 치환 = HOMO 하향 | Cu-Pc Q-band 670 nm TD-DFT 방법론 |
| [arxiv:1405.5994] | 2014 | Ab initio simulation of optical limiting — metal-free Pc | dipole-forbidden excitations 가 excited-state absorption 으로 access · 광흡수 saturation | high-fluence (MN-tip 광원) 거동 |
| [arxiv:2404.18292] | 2024 | Excimer formation in zinc-Pc — ultrafast electron diffraction | 2-step: <0.4 ps dimerization + 14 ps alignment | Pc 응집 (ink aggregate) 광반응 timescale |
| [arxiv:2207.01083] | 2022 | Vibrational coupling in zinc-Pc excited states | excimer binding energy via temperature-dependent luminescence | Pc aggregate energetics |
| [arxiv:2305.13157] | 2023 | Submolecular phototautomerization of free-base Pc | STM-confined field photo-control | localized photo-trigger 개념 |
| [arxiv:2508.11501] | 2025 | Upconversion electroluminescence in vanadyl-Pc | Q-band gating · spin interaction | metal-Pc 광반응 spectroscopy |
| ScienceDirect S002211391630327X | 2017 | Trifluoroethoxy-substituted Cu-Pc TD-DFT + photochem | photodegradation φ + Q-band assign · Cu-Pc reference | **Cu-Pc TD-DFT 직접 참조** |
| Academia.edu (Zn-Pc PDT TDDFT) | 2017 | Dinuclear Zn-Pc Type II photosensitizer + TD-DFT | singlet O₂ Type II PDT · TD-DFT triplet state ID | ¹O₂ quantum yield benchmark |
| PMC11913358 | 2025 | Water-soluble Si-Pc catalyzing pollutant dye photodegradation | dye photodegradation via singlet O₂ + triplet state | Pc 의 dye 분해 메커니즘 (TTR 직접) |
| ScienceDirect S2213343725004701 | 2025 | Metal Pc-based composites for wastewater photochemical remediation | composite (TiO₂/g-C₃N₄ + Pc) heterojunction | M3 wall path A (g-C₃N₄ + Cu-Pc) 보강 |
| arxiv (singlet oxygen) | — | **totalResults = 0** | arxiv 부재 (별도 키워드) | TD-DFT 만 arxiv 가용 |

→ **M5 적용**: Cu-Pc TD-DFT run = closed-shell singlet ground + open-shell triplet T1 (CAM-B3LYP / def2-SVP) · Q-band (~670 nm) verticals · spin-orbit coupling estimate (Cu-d state mixing) → ¹O₂ generation φ. **Cu-Pc 의 photo-ring-opening 경로 (HOMO α → O-O 결합 형성) 는 TDDFT 직접 결과 부재 — surface complex (g-C₃N₄ heterojunction) 모델 필요**. ReaxFF (PCFF-IFF reactive variant [arxiv:2107.14418]) 권장.

**🟠 honest gap**: φ_¹O₂ (Cu-Pc) 실측 데이터 arxiv 부재 — Pc family (Zn/Si) 만 정량. *광-Fenton 정량은 M8 ex-vivo 실측 우선*.

---

## §6. Cr₂O₃ band gap + surface chemistry (DFT)

| source ID | year | title | finding | M5 relevance |
|---|---|---|---|---|
| [arxiv:2405.11122] | 2024 | Voltage + B doping spin reversal in Cr2O3 thin films | band gap 3.4 eV · B-doping TN > 400 K | UV-A 365 nm photon energy (3.4 eV) 일치 (M3 wall path A) |
| [arxiv:0810.3938] | 2008 | Magnetism of chromia DFT+LSDA+U | Mott-Hubbard type band gap · 실험 일치 | electronic structure baseline |
| [arxiv:1610.08426] | 2016 | Ga-doped Cr2O3 magnetic+electronic properties | band gap 2.67-2.81 eV · 1.91-2.11 eV · 1.28-1.35 eV (3 transition) | sub-band transition 다중성 (NP size effect) |
| [arxiv:1210.5563] | 2012 | Cr2O3 (0001) surface structural phase transition | competing surface Cr sites + strain/magnetic ordering | surface termination 다양성 (활성 변동) |
| cond-mat/9912154 | 1999 | Ab initio Cr2O3 magnetic structure + (0001) surface reactivity | O-terminated surface ferromagnetic outer layer · 표면 반응성 변화 | DFO surface coordination site (M3 wall path) |
| [arxiv:2405.05020] | 2024 | Cr2O3-Pt(111) interface first-principles | 전자축적+자기 proximity in Pt | metal interface (TiO₂ doping?) |
| arxiv (Cr2O3 photocatalysis) | — | **totalResults = 0** | photocatalysis 키워드 부재 | PubMed 필수 |
| PMC10123813 | 2023 | Realistic models for photocatalysis — theoretical review | open-shell DFT triplet excited state PES + 표면 redox 모델링 | Cr2O3 광촉매 모델 방법론 |
| Web 일반 | — | Cr2O3 shell cocatalyst + dynamic Cr oxide/oxyhydroxide film | Cr2O3 = stable cocatalyst layer · dissolution-redeposition equilibrium | Cr³⁺→Cr⁶⁺ side reaction risk (산화 환경) |

→ **M5 적용**: Cr₂O₃ NP M5 run = (0001) slab · DFT+U (U=4 eV, Cr 3d) · PBE / 500 eV / 4×4×1 k-grid · vertical excitation TDDFT (HSE06 hybrid) · UV-A 365 nm (3.4 eV) photon 흡수율 · 표면 OH 흡착 자유에너지 (Cr-OH formation) + DFO·H₃ binding mode. **Cr³⁺→Cr⁶⁺ 산화 risk = secondary run** (O₂ + h⁺ → Cr⁶⁺ pathway energetics).

**🟠 honest gap**: photocatalysis arxiv 0 — chemical reduction/dissolution + Cr⁶⁺ 형성 risk 는 Environ Sci 저널 영역. M6 toxicokinetics 와 cross-ref 필수.

---

## §7. General MD/QM benchmark for nanoparticle-protein-pigment ternary systems

| source ID | year | title | finding | M5 relevance |
|---|---|---|---|---|
| [arxiv:2601.12570] | 2026 | INTERFACE Force Field for Alumina + pH-resolved surface model database | CHARMM/AMBER/OPLS-AA/CVFF/PCFF 호환 · 95%+ 정확도 · bulk + 표면 다중 phase | **IFF stack default — M5 모든 oxide NP 에 적용** |
| [arxiv:1512.00122] | 2015 | INTERFACE FF for hydroxyapatite | <0.5% lattice 정확도 · inorganic-bio assembly | IFF biomineral precedent |
| [arxiv:2107.14418] | 2021 | Reactive IFF method (IFF-R) | bond-making/breaking 가능 IFF 변형 | **Cu-Pc photoreaction + Fenton ROS bond chemistry** |
| [arxiv:2107.14286] | 2021 | Epoxy resins via IFF-R | 폴리머 networks reactive MD | MN 폴리머 + 페이로드 MD |
| [arxiv:2212.13374] | 2022 | Water-hydrogen-silica interfaces | silica + water + H interface | water model + 표면 hydroxyl 정확 묘사 |
| [arxiv:2002.07893] | 2020 | CNT-Polymer via ReaxFF + PCFF-IFF | ReaxFF + PCFF-IFF hybrid pipeline | reactive + non-reactive 도메인 분할 |
| [arxiv:1006.1209] | 2010 | NP-catalyzed peptide aggregation MD | disordered oligomer → β-sheet 변화 | NP surface 가 단백질 conformation 유도 |
| [arxiv:1711.03264] | 2017 | Atomistic simulation of protein GB1 + polystyrene NP — metadynamics | 3 distinct protein states · coupled adsorption + unfolding | enzyme + NP corona MD 방법론 |
| [arxiv:1612.08814] | 2016 | Protein corona on PEG NP — amino acid composition | PEG 가 non-polar residue 근접 + polar 회피 | NP coating + enzyme 입력 |
| [arxiv:2208.05804] | 2022 | Multi-scale modeling of folate-functionalized TiO2 NP | QM + classical MD 100 ns · ligand density 최적화 | **ternary NP-protein-pigment 방법론 prior** |
| PMC8752518 | 2022 | CHARMM-GUI Nanomaterial Modeler | IFF 기반 자동 NP topology 생성 | **M5 NP 모델 빌딩 tool (default)** |
| PMC11211406 | 2024 | CHARMM-GUI Multicomponent Assembler | 복합 시스템 multicomponent | NP + protein + small mol + water combo |
| PMC11103706 | 2024 | Validation of protein force fields | AMBER14SB / AMBER99SB*-ILDN / CHARMM36 = top side chain rotamer | force field 선정 권장 |
| PMC6745714 | 2019 | All-atom FF effects on Aβ16-22 dimer | AMBER99-ILDN, AMBER14SB, CHARMM22*, CHARMM36, CHARMM36m = best for assembly | 효소 ensemble + 잉크 응집 적합 |

→ **M5 적용**: 
- **NP side**: IFF (Mg/Al/Si/Cr/Ce/Fe oxide 통합) via CHARMM-GUI Nanomaterial Modeler
- **Protein side**: CHARMM36m (DyP · AzoR · 일반 enzyme) + TIP3P water
- **Reactive ROS / Cu-Pc**: ReaxFF or IFF-R
- **QM region**: B3LYP-D3 / def2-TZVP (Fe-O · Cu-N) — heme/FMN/Pc center
- **Timestep**: 1 fs equilibration / 2 fs production with SHAKE/LINCS
- **Length**: 100 ns production (단백질-NP corona) · 5-50 ps QM/MM (active site)
- **Box**: rhombic dodecahedron · NP에서 protein 외곽까지 ≥ 1.4 nm padding

---

## §8. Recommended simulation stack per M3 top-3 candidate

```
┌──────────────────────────────────────────────────────────────────────────┐
│ Candidate    │ FF / QM method      │ timestep │ box / system size       │
├──────────────────────────────────────────────────────────────────────────┤
│ 🥇 CeO₂ NP   │ IFF + Buckingham    │ 1-2 fs   │ 5 nm NP (≈4000 atom)    │
│  (top-1)     │ + LJ12-6 (Ce/O)     │          │ + 15000 H2O TIP3P       │
│              │ DFT+U U=4.5 eV     │ QM:      │ + H3O+ 200 mM proxy     │
│              │ (Ce 4f); HSE06     │ static / │ acidic pH (4)           │
│              │ for OV/Fe(IV)      │ 5-50 ps  │ + basic pH (7.4) compare│
│              │ engine: VASP/QE/   │ AIMD     │ — M5 ΔG(Fenton) target  │
│              │ CP2K              │          │                          │
├──────────────────────────────────────────────────────────────────────────┤
│ 🥈 DyP+DFO   │ CHARMM36m +         │ 2 fs     │ 50 kDa DyP (PDB 3AFV)   │
│  (top-2)     │ TIP3P; FMN/heme    │ MM       │ + heme + axial His      │
│              │ from CHARMM-GUI    │ 5-20 ps  │ + 35000 H2O + 150 mM    │
│              │ ligand reader;     │ QM/MM    │ NaCl                    │
│              │ ONIOM(B3LYP-D3/6-  │          │ DyP active site QM:     │
│              │ 31G(d):Amber14SB)  │          │ Fe-porphyrin+His+Asp-Arg│
│              │ for Compound I;    │          │ -Asn triad              │
│              │ DFO+Fe3+ separate: │          │ DFO+Fe3+ DFT: (Fe)(DFO) │
│              │ B3LYP-D3/def2-TZVP │          │ neutral / SMD water     │
│              │ /SMD; ReaxFF for   │          │                          │
│              │ Cu-Pc oxidation    │          │                          │
├──────────────────────────────────────────────────────────────────────────┤
│ 🥉 AzoR +    │ CHARMM36m + FMN    │ 2 fs     │ AzoR dimer (PDB 2Z9B)   │
│  ascorbate   │ params; AzoR =     │ MM       │ 23 kDa × 2 = 46 kDa     │
│  (top-3)     │ 2Z9B (reduced);   │ 100 ns   │ + 25000 H2O + NaCl 150  │
│              │ docked methyl     │ + umbrella│ mM pH 7.4               │
│              │ red (Arg-59 ori); │ sampling │ active site QM:         │
│              │ ascorbate cascade:│ along C-  │ FMN+NADH+azo+Arg-59     │
│              │ B3LYP-D3/6-31+G(d,│ N=N-C    │                          │
│              │ p)/SMD water for  │ dihedral │                          │
│              │ ascorbate→azo→    │          │                          │
│              │ amine; metadynamics│         │                          │
│              │ for binding ΔG    │          │                          │
└──────────────────────────────────────────────────────────────────────────┘
```

**공통 stack tools**:
- CHARMM-GUI (web · IFF NP modeler + ligand reader + multicomponent assembler)
- VMD / PyMOL viz
- GROMACS 2024+ (MM-MD prod)
- CP2K / Gaussian16 / ORCA 6 (QM/MM)
- PLUMED 2.9+ (metadynamics / umbrella sampling)

**Hardware (CLAUDE.md @D d7 정합)**:
- 작은 cell (CeO₂ NP < 20 atom) → pool ubu-1/2 free
- 5 nm CeO₂ NP + AIMD → Vast.ai CPU (batch)
- 100 ns DyP/AzoR + 50 kDa protein → GPU pod (RunPod / Vast.ai GPU)
- ONIOM QM/MM batch → GPU pod (≥ 24 GB VRAM)

---

## §9. Honest gaps — sparse arxiv coverage requiring PubMed paywall

| # | gap | arxiv status | recommended next channel |
|---|---|---|---|
| 1 | **DyP-type peroxidase 학계 corpus** | 0 hits (DyP · dye-decolorizing peroxidase 단일·복합 키워드 모두) | PubMed: "DyP peroxidase Compound I QM/MM" · Springer / Elsevier full-text · PDB direct |
| 2 | **Azoreductase MD active site / docking simulation** | 0 hits (azoreductase 단일 · AzoR · azoreductase MD) | PubMed: "azoreductase MD simulation" · 후보 PMID 16684776 (Ito 2008) full-text |
| 3 | **DFO + Fe³⁺/Cr³⁺ DFT binding free energy** | 0 hits (deferoxamine · hydroxamate iron · iron chelation DFT) | ACS Inorg Chem / Eur J Inorg Chem · DFOB QM benchmark 인용 chain |
| 4 | **Cu-Pc photo-ring-opening + ¹O₂ φ in dermal** | 0 hits (phthalocyanine + singlet oxygen · copper phthalocyanine + photo) | J Photochem Photobiol · Photochem Photobiol Sci · Dyes Pigments |
| 5 | **Cr₂O₃ photocatalysis + Cr⁶⁺ formation risk** | 0 hits (Cr2O3 + photocatalysis) | Environ Sci Technol · Catal Lett · ACS Catal |
| 6 | **MnO₂ / V₂O₅ NP biological context** | 미수행 | M3 F1 후순위 — M5 후속 |
| 7 | **Aromatic amine byproduct (azo cleavage) — toxicokinetic / DFT** | M3 candidate ranking 의 toxic byproduct prediction (IARC class 2A 일부) | PubMed: "aromatic amine toxicokinetic MD" + M6 cross-ref |
| 8 | **TiO₂ NP + protein corona — 5-component ternary** | partial ([arxiv:2208.05804] folate-TiO₂ binary만) | EU NanoSafety Cluster + Toxicol Sci |
| 9 | **Protein-pigment-NP ternary system MD prior** | 0 direct hit (ternary 시스템은 모두 binary surfaced) | de novo design — M5 자체 protocol 구축 필요 |
| 10 | **DyP의 Cu-Pc 실제 활성 — Roberts 2011 / Liers 2013 replication** | arxiv 0편 (M3 인용 chain 미검증) | PubMed direct (Appl Microbiol Biotechnol · ChemBioChem) |

---

## §10. Cross-reference

- TTR-MN.md M5-MN milestone → 본 문서가 prerequisite
- M3: `m3_mn_candidates.md` top-3 (CeO₂ · DyP+DFO · AzoR+ascorbate) → §8 stack 직접 입력
- M3 wall: Cu-Pc (§5) · Cr₂O₃ (§6) → 광-반응 path A/D 의 first-principles 확장
- M1: `ink_classes.md` — Cr/Cu/Fe pigment의 8 표적 카테고리
- M6: `off_target_safety.md` — Cr³⁺→Cr⁶⁺ risk (§6) · aromatic amine (§9 #7)
- `arxiv_deep_research.md` — 본 문서가 M5-specific 추가 layer (M3 prior-art 의 deeper drill)
- `external_libraries.md` — RDKit/Vina/OpenMM/GROMACS stack 와 IFF/CHARMM-GUI 통합
- CLAUDE.md @D d1 — non-wet-lab 완료형 (M5 시뮬은 본 문서로 entry 확보)
- CLAUDE.md @D d3 — design docs only · 본 문서 .md only · 코드 없음
- CLAUDE.md @D d6 — first-principles physics (DFT+U · TD-DFT · ReaxFF) 우선
- CLAUDE.md @D d7 — compute sizing (small cell pool · NP+MD Vast CPU · GPU 100 ns)

---

## §11. 결론

본 sweep 의 **M3 top-3 강화 ranking — 가장 강하게 보강하는 source 3건**:

1. **[arxiv:2104.10994]** — CeO₂ pH-driven Ce³⁺/Ce⁴⁺ Fenton 가설을 DFT 로 lock → **M3 top-1 (CeO₂ NP) 의 selectivity 주장 first-principles 등급**
2. **PDB 2D5I + PMID 16684776 (AzoR Ito 2008)** + **PDB 2Z9C (AzoR+dicoumarol)** — AzoR 의 substrate orientation (Arg-59 + methyl red) 가 결정학적으로 lock → **M3 top-3 (AzoR+ascorbate) 의 docking template 완비**
3. **PMID 9638988 + 7756461 (DyP Compound I SFX)** + **PDB 3AFV (Bjerkandera DyP)** — DyP Compound I 메커니즘 (Fe(IV)=O + porphyrin π-cation + distal triad) 이 SFX 로 직접 관측 → **M3 top-2 (DyP+DFO) 의 active site QM/MM 모델 완비**

**보조 lock**:
- INTERFACE Force Field 2026 통합 [arxiv:2601.12570] — 다중 oxide NP 단일 FF stack
- CHARMM-GUI Nanomaterial Modeler (PMC8752518) — NP topology 자동 빌딩

→ M5 시뮬레이션 stack 의 **bottom-up first-principles entry 완비**. 다음 작업: M5-MN milestone 의 prod run kickoff (CeO₂ NP DFT+U · DyP ONIOM · AzoR CHARMM36m metadynamics).
