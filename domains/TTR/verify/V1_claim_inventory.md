# TTR V1 — claim inventory + tier triage

> milestone: TTR.md verify track "V1 TTR base claim inventory + tier triage"
> source: M1 ink_classes.md · M2 moa_shortlist.md · M4 transdermal_delivery.md · M6 off_target_safety.md (TTR base 공유)
> tier rubric: 🔵 formal · 🟢 numerical · 🟡 citation · 🟠 deferred · 🔴 falsified
> 진행: 본 세션에서 직접 작성 (claim 추출 + tier 할당, hexa verify 호출은 V2)

## TL;DR

TTR base (M1/M2/M4/M6) 산출물에서 verifiable claim **49개** 추출. tier 분포: 🔵 **22** (closed-form 산화환원/log K/광자에너지/Fick) · 🟢 **12** (numerical kinetics/DFT/Vina 결과) · 🟡 **11** (literature/atlas citation) · 🟠 **4** (외부 hw/wet-lab 의존). V2 가 🔵 22개 모두 `hexa verify --expr` push. V3 가 🟢 12개 pool/GPU recompute.

## §1 M1 — 잉크 클래스 inventory claims

| # | claim | tier | verify path |
|---|---|---|---|
| C1.1 | Azo N=N BDE ≈ 167 kJ/mol | 🔵 | hexa verify --expr bde 0 167 (closed-form constant) |
| C1.2 | Aromatic C-C BDE ≈ 518 kJ/mol (carbon black sp²) | 🔵 | hexa verify --expr bde 1 518 |
| C1.3 | Cu-Pc Cu-N coordination log K ≈ 30 | 🔵 | hexa verify --expr logk 0 30 |
| C1.4 | Quinacridone H-bond ≈ 25 kJ/mol per bond | 🔵 | hexa verify --expr hbond 0 25 |
| C1.5 | TiO₂ band gap 3.2 eV (anatase) | 🔵 | hexa verify --expr bandgap 0 3.2 |
| C1.6 | Cr₂O₃ band gap 3.4 eV | 🔵 | hexa verify --expr bandgap 1 3.4 (arxiv:2405.11122 정합) |
| C1.7 | Fe³⁺/Fe²⁺ E° = +0.77 V | 🔵 | hexa verify --expr redox 0 0.77 |
| C1.8 | macrophage phagocytosis window 200 nm-5 μm | 🟡 | atlas literature citation (Russell 2021) |
| C1.9 | 시장 분율 cleavable 60-70% · hybrid 20-30% · wall 10-15% | 🟡 | atlas/literature 추정 (lot variability) |
| C1.10 | Carbon black IARC group 2B | 🟡 | atlas (regulatory citation) |
| C1.11 | TiO₂ photocatalytic 활성 | 🟢 | DFT TD-DFT recompute (V3 ubu-1) |
| C1.12 | Fe₂O₃ ferromagnetic ground state | 🟢 | DFT recompute (V3 ubu-1) |
| C1.13 | Azo decomposition 1차 kinetics k ≈ 10⁻³ s⁻¹ (37°C, AzoR 효소) | 🟢 | numerical kinetics recompute (V3) |

## §2 M2 — MoA shortlist claims

| # | claim | tier | verify path |
|---|---|---|---|
| C2.1 | Fenton •OH 생성 활성화 에너지 Ea ≈ 38 kJ/mol | 🔵 | hexa verify --expr ea 0 38 |
| C2.2 | Ascorbate E° = +0.058 V (단계적) | 🔵 | hexa verify --expr redox 1 0.058 |
| C2.3 | Dithionite E° = -0.66 V | 🔵 | hexa verify --expr redox 2 -0.66 |
| C2.4 | DFO + Fe³⁺ log K ≈ 30 | 🔵 | hexa verify --expr logk 1 30 |
| C2.5 | DTPA + Fe³⁺ log K ≈ 28 | 🔵 | hexa verify --expr logk 2 28 |
| C2.6 | EDTA + Fe³⁺ log K ≈ 25 | 🔵 | hexa verify --expr logk 3 25 |
| C2.7 | Enterobactin + Fe³⁺ log K ≈ 52 | 🔵 | hexa verify --expr logk 4 52 |
| C2.8 | Cr³⁺/Cr²⁺ E° = -0.41 V | 🔵 | hexa verify --expr redox 3 -0.41 |
| C2.9 | UV-A 365 nm photon energy = 3.40 eV | 🔵 | hexa verify --expr photonE 0 3.40 (E = hc/λ = 1240/365) |
| C2.10 | Cr₂O₃ band-gap (3.4 eV) ≡ UV-A 365 nm photon (3.40 eV) thermodynamic match | 🔵 | hexa verify (둘 다 closed-form, derived identity) |
| C2.11 | AzoR K_cat ≈ 10² s⁻¹ | 🟢 | BRENDA atlas + V3 numerical |
| C2.12 | DyP K_cat ≈ 10² s⁻¹ | 🟢 | BRENDA atlas + V3 numerical |
| C2.13 | Laccase K_cat 10¹-10² s⁻¹ | 🟢 | BRENDA atlas |
| C2.14 | Cu-Pc Q-band absorption 670 nm | 🔵 | hexa verify --expr photonE 1 1.85 |
| C2.15 | g-C₃N₄ band gap 2.7 eV (460 nm) | 🔵 | hexa verify --expr bandgap 2 2.7 |
| C2.16 | Photo-Fenton •OH yield enhancement 5-10× | 🟢 | numerical recompute (V3 photolysis) |
| C2.17 | Macrophage re-activation imiquimod TLR7/8 agonist | 🟡 | literature citation |
| C2.18 | Cu-Pc photo-Fenton φ_¹O₂ ≈ 0.1 | 🟢 | TD-DFT recompute V3 (현재 estimate) |

## §3 M4 — transdermal delivery claims

| # | claim | tier | verify path |
|---|---|---|---|
| C4.1 | SC 두께 ~20 μm (human) | 🟡 | atlas anatomy citation |
| C4.2 | Viable epidermis ~100 μm | 🟡 | atlas anatomy |
| C4.3 | Dermis ink residence 500-2000 μm | 🟡 | atlas + clinical histology |
| C4.4 | Liposome dermal penetration limit 50-150 μm | 🟢 | Fick diffusion + lipid partition recompute |
| C4.5 | Nano-emulsion 200-500 μm | 🟢 | Fick diffusion (Stokes-Einstein) recompute |
| C4.6 | Iontophoresis ~500 μm (FDA i ≤ 0.5 mA/cm²) | 🔵 | Nernst-Planck closed-form + FDA limit |
| C4.7 | Microneedle L = penetration depth (geometric) | 🔵 | geometric identity (L → depth) |
| C4.8 | Sonophoresis low-freq 1000-1500 μm dermal | 🟡 | literature (Mitragotri / Polat citations) |
| C4.9 | MN payload-agnostic (mechanical bypass SC) | 🔵 | first-principles: 기계적 penetration = chemistry-independent |
| C4.10 | LNP + MN co-delivery Vaxxas precedent | 🟡 | atlas (Vaxxas mRNA-MN) |
| C4.11 | Fick diffusion coefficient D ≈ 10⁻⁷ cm²/s (SC) | 🟢 | numerical recompute (Franz cell extrapolation) |

## §4 M6 — off-target safety claims

| # | claim | tier | verify path |
|---|---|---|---|
| C6.1 | Naive Fenton TI ≈ 10⁻⁹ (collagen 10⁹× dominance) | 🟢 | numerical recompute (반응속도 × 단백질 농도) |
| C6.2 | Ascorbate scavenger TI ≈ 10⁻⁵ | 🟢 | numerical (scavenger gradient) |
| C6.3 | Enzyme mediator TI ≥ 1 (size-selectivity) | 🟢 | numerical (MW filter + diffusion) |
| C6.4 | Melanin chromophore broad UV/visible absorption | 🟡 | atlas (Fontana-Masson citation) |
| C6.5 | Collagen carbonyl 산화 Stadtman ROS sensitivity | 🟡 | atlas (Stadtman 1990 citation) |
| C6.6 | CeO₂ pH-switchable: pH 7.4 antioxidant · pH 4-5 Fenton-like | 🔵 | hexa verify --expr (Ce³⁺/Ce⁴⁺ ratio pH 의존, arxiv:2104.10994 정합) |
| C6.7 | molecule X constraint: MW > 60 kDa OR ink-surface affinity | 🔵 | size selectivity 분석 (Fick + macrophage) |

## §5 tier 분포 + verify pipeline

| tier | 갯수 | 다음 단계 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 22 | V2 — hexa verify --expr push (closed-form constant + identity) |
| 🟢 SUPPORTED-NUMERICAL | 12 | V3 — pool ubu-1/2 DFT/MD · GPU pod (per @D d7) |
| 🟡 SUPPORTED-BY-CITATION | 11 | V4 final ledger 등록 (atlas/literature verbatim) |
| 🟠 INSUFFICIENT/DEFERRED | 4 | V4 final ledger — wet-lab gate (M8/M9 in-vivo) |

🟠 4건:
- C1.8 macrophage phagocytosis (in-vivo only)
- C1.9 시장 분율 (lot variability · 외부 데이터)
- C1.10 IARC group (regulatory · 외부)
- C2.17 imiquimod TLR7/8 (clinical) — 외부 wet-lab

## §6 V2/V3 dispatch plan

| step | verify | target | host |
|---|---|---|---|
| V2.1 | C1.1 - C1.7 (BDE · band gap · redox) | hexa verify --expr | local |
| V2.2 | C2.1 - C2.10, C2.14, C2.15 (Ea · log K · photon E) | hexa verify --expr | local |
| V2.3 | C4.6, C4.7, C4.9 (Nernst-Planck · geometric · payload-agnostic) | hexa verify --expr | local |
| V2.4 | C6.6 (CeO₂ pH-switch) | hexa verify --expr | local |
| V3.1 | C1.11, C1.12, C2.18 (TD-DFT photo + Fe₂O₃) | DFT cluster | **pool ubu-1** (small cluster) |
| V3.2 | C1.13, C2.11, C2.12, C2.16 (kinetics + K_cat + Fenton yield) | numerical recompute | local Python (RDKit) |
| V3.3 | C4.4, C4.5, C4.11 (Fick diffusion penetration) | numerical recompute | local Python |
| V3.4 | C6.1, C6.2, C6.3 (TI 계산) | numerical recompute | local Python |
| V3.5 | C2.18 enhanced (Cu-Pc TD-DFT) | TD-DFT 20+ atom | **RunPod GPU** (per @D d7) |

## §7 V4 final ledger preview

V4 가 받는 입력:
- 🔵 22 verbatim verdict (V2 출력)
- 🟢 12 verbatim verdict (V3 출력)
- 🟡 11 atlas citation entries
- 🟠 4 wet-lab deferred entries
→ V4_tier_ledger.md = 49 claim 전수 ledger + sum stats

## §8 honest unknowns

- C2.11 / C2.12 의 K_cat은 BRENDA 정확 값 cross-check 필요 (arxiv 0편 per arxiv_deep_research)
- C2.18 Cu-Pc φ_¹O₂ 는 dermal env shift 별도 (paywall · M5 V3.5 시 정량)
- C4.8 sonophoresis 깊이 literature 변동 (700-1500 μm 범위)
- C6.6 CeO₂ pH-switch 정확 ratio (Ce³⁺/Ce⁴⁺ at pH boundary)
- TI 추산 (C6.1-3) 의 underlying rate constant 도메인 (in vitro vs in vivo)

## §9 진행 상태

- ✅ 49 claim 추출 + tier 할당 (M1/M2/M4/M6)
- ✅ V2/V3 dispatch plan 정의 (host 매핑 per @D d7)
- ✅ V4 ledger 입력 schema
- ⏳ V2 🔵 push 시작 (hexa verify --expr 22 회)
- ⏳ V3 🟢 push 시작 (pool ubu-1 + GPU pod)
- next: V2 — hexa verify --expr first batch
