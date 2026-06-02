# RARE-EARTH+ALTERNATIVE — 희토류 대체 6트랙 로드맵 (메타도메인)

> **구조 사이블링**: [`RARE-EARTH+ALTERNATIVE.tape`](RARE-EARTH+ALTERNATIVE.tape)
>
> **메타도메인** (governance #4): "희토류" ∩ "대체" — 두 조건이 동시 성립할 때만 본 파일에 진입
>
> **상위/측위 도메인**:
> - 원소 가족 → [`RARE-EARTH.md`](RARE-EARTH.md)
> - 자석 verb → [`MAGNETIC-MATERIALS.md`](MAGNETIC-MATERIALS.md)
> - 재활용 → [`RECYCLING.md`](RECYCLING.md) / [`HEXA-RECYCLE.md`](HEXA-RECYCLE.md)
> - 광물 우산 → [`CRITICAL-MINERAL.md`](CRITICAL-MINERAL.md)
> - 후보 시드 → [`NOVEL.md`](NOVEL.md) §3.5 `hxm-mag-*`

---

## 1. 6트랙 요약

| # | 트랙 | 접근 | 성능 천장 | hxm-mag-* 시드 |
|---|---|---|---|---|
| 1 | NdFeB 재활용 | 습식제련 (hydromet) | 모빌리티 자석 수요 ≤40% offset (10년) | (공정 트랙 → RECYCLING.md, 시드 없음) |
| 2 | 고밀도 페라이트 | SrFe₁₂O₁₉ Co/La 도핑 | (BH)max ~5-6 MGOe 상용, ~9 MGOe 이론 | `hxm-mag-ferrhd-001` |
| 3 | Mn-Al-C τ-phase | L1₀ 메타스테이블 합성 | 12 MGOe lab thin-film, 6 MGOe 소결 | `hxm-mag-mnalc-001` |
| 4a | Beeson C16 고엔트로피 보라이드 | 5-원소 3d TM + B, Fe/Co easy-axis (thin-film) | NdFeB 근접, 보자력 2배+ vs 이/삼원 | `hxm-mag-boride-001` |
| 4b | arxiv:2507.01849 binary intermetallics | DFT HT 스크리닝 | Mn₂Sb 예측 Tc=2270K, K=1.57 MJ/m³ (최강) | `hxm-mag-mn2sb-001` |
| 5 | NdFeB Dy/Tb→Ce/La 치환 | Grain boundary 공학 | Dy/Tb ≥50% 감축 + 150°C 보자력 유지 | `hxm-mag-lowdy-001` |
| 6 | AI/ML 자석 발굴 | NEMAD 67k DB + ML 분류 | 62 FM 후보 Tc>500K; FeCo₂Ge 선정 | `hxm-mag-aifound-001` |

---

## 2. 트랙별 상세

### 2.1 TRACK 1 — NdFeB 재활용 (process)

- **접근**: EoL NdFeB(HDD / EV 모터 / 풍력 nacelle) 습식제련 leach + 선택적 침전
- **천장**: 향후 10년 모빌리티 자석 수요 ~40% offset ceiling (Climate Change News 2026-05)
- **블로커**: 상용 규모 경제성 미확정; ROW 수거 logistics 분산
- **EoL 피드스톡 타이밍**:
  - 글로벌 HDD ~75 kt/yr (현재 — SSD 대체로 축소 중)
  - EV 모터 wave 시작 ~2030+ (차량 15년 수명)
  - 풍력 nacelle wave ~2035+ (자산 20년 수명)
- **anchors**: arxiv:2506.22569 (Toward Sustainable REE Production), arxiv:2504.10495 (phosphogypsum 회수)
- **본 NOVEL 비편입 사유**: 공정 트랙 (de-novo material 아님) → NOVEL.md §0 scope boundary

### 2.2 TRACK 2 — 고밀도 페라이트 (`hxm-mag-ferrhd-001`)

- **접근**: SrFe₁₂O₁₉ / BaFe₁₂O₁₉ M-type hexaferrite, Co/La/Mn 공도핑
- **원가**: 산화철 + Sr/Ba 탄산염 — **REE-FREE**, 원료가 ~10× 저렴 vs NdFeB
- **성능**: (BH)max ~5 MGOe 상용 Sr-페라이트 vs NdFeB ~50 MGOe → 동일 자속 위해 10× 부피/질량
- **적합 envelope**: 저원가 EV (200kW 이하), 산업 모터, 마이크로 자석, 자기 분리
- **anchor**: ACS Sust. Chem. Eng. (2024) — LCA of REE-free magnets
- **falsifier**: F-MAG-6: (BH)max < 6 MGOe OR Hc decay > 15% after 1000 h @ 200°C → FAIL

### 2.3 TRACK 3 — Mn-Al-C τ-phase (`hxm-mag-mnalc-001`)

- **접근**: Mn₅₅Al₄₄C₁ 정렬 L1₀ τ-phase (REE-free, Co-free)
- **성능**: (BH)max ~7-12 MGOe lab-scale, Hc ~0.3 T, Tc ~340°C
- **상태**: 1960년대 Koch 발견; 2020+ 기계화학(mechanochem) 합성으로 부흥
- **블로커**: τ-phase 메타스테이빌리티 — 생성 윈도우 좁음, 열사이클링에 demixing
- **falsifier**: F-MAG-5: 소결 (BH)max < 6 MGOe OR τ-phase 분율 < 80% after 100 thermal cycles → FAIL

### 2.4 TRACK 4 — REE-free 보라이드 + binary intermetallics

두 출처를 명확히 구분 (오해 방지):

**(a) Beeson C16 고엔트로피 보라이드** (`hxm-mag-boride-001`)
- **구조**: C16 = tetragonal **I4/mcm (No.140)**, CuAl₂-type, M₂B 화학량론 (B 33%)
- **조성**: quinary 3d-TM = **Fe · Co · Ni · Mn · Cr** + B. 논문 명시 박막 = **(FeCoNiMn)₂B** 50 nm, 격자상수 a=5.05 Å, c=4.25 Å
- **핵심 메커니즘**: (Fe₁₋ₓCoₓ)₂B에서 Fe/Co 혼합비로 easy-plane → easy-axis 전환. x=0.3에서 K₁≈410 kJ/m³ @RT. 이원/삼원 TM 보라이드 대비 **보자력 2배+**
- **DFT 이방성**: ~1×10⁷ erg/cm³ (≈1 MJ/m³)
- **형태**: **thin-film** (combinatorial sputtering, 1회 ~50 샘플 — Liu's lab). bulk-scale 미실증
- **출처**: Beeson·Yin·Liu, *Advanced Materials* (2025), DOI 10.1002/adma.202516135 (peer-reviewed; PubMed 41431427)
- **MP cross-ref (2026-05-17)**: C16 endmember 4종이 MP에서 모두 I4/mcm 확인 — Fe₂B `mp-1915` (FM, E_hull=0), Co₂B `mp-493` (FM), Ni₂B `mp-2536` (NM), Mn₂B `mp-20318` (AFM). disordered quinary 조성은 MP 단일 record 부재.
- **CHGNet 실계산 (2026-05-18)**: MP record가 없으므로 ubu-1(RTX 5070 GPU)에서 (FeCoNiMn)₂B C16 ordered approximant를 CHGNet 0.4.2로 relax — 안정 (a 5.05→5.02 Å), \|magmom\| 0.64 μB/atom 보유 (Fe₂B 대조 1.32). → `boride-001` **DESIGN → SIM-NNP 승급** (`_absorption_bridge/universal_ff/predictions/hxm-mag-boride-001.json`). CHGNet은 FM/AFM·K₁ 미해상 → F-MAG-4 UNVERIFIED 유지
- **caveat**: thin-film K₁ ≠ bulk magnet (BH)max (`@F f1`)
- **falsifier**: F-MAG-4: thin-film K₁ < 1.0 MJ/m³ at 300 K OR bulk-scale 합성 미실증 → FAIL

**(b) arxiv:2507.01849 binary intermetallics** (`hxm-mag-mn2sb-001`)
- DFT HT 스크리닝 → 10 binary 후보 (FeSn, CrSb, **Mn₂Sb**, FeB, FeNi, Fe2P, Fe3Ga, FeGe, **ZnFe**, **Fe8N**)
- **Mn₂Sb**: 예측 Ms=1.76 T, K=1.57 MJ/m³, Tc=**2270 K** (10중 최강)
- ZnFe + Fe8N은 노블 후보로 highlight
- **MP 검증 (2026-05-17)**: `mp-20664` — P4/nmm tetragonal, FM ordering, E_hull=0 (안정), M_tot=15.16 μB. arxiv의 "Mn₂Sb tetragonal"이 P4/nmm 다형체와 정확 일치 (metastable `mp-6912` P6₃/mmc, `mp-1008875` F-43m은 아님). → `hxm-mag-mn2sb-001` **DESIGN → SIM-DFT 승급**
- **honesty**: SIM-DFT는 MP의 DFT 자성 ordering + formation energy cross-ref만 의미. Tc / (BH)max는 여전히 UNVERIFIED (MP에 Tc 필드 없음; Tc=2270K는 별도 DFT 예측)
- **falsifier**: F-MAG-9: 측정 K < 0.8 MJ/m³ OR Tc < 600 K → FAIL

**중요 정정 (2026-05-17)**: 초기 web search summary가 Mn₂MoB₄ / Mn₂WB₄를 arxiv:2507.01849 boride 후보로 추정했으나, arxiv 원문 직접 fetch 결과 해당 화합물은 최종 10 후보 어디에도 없음. 잘못된 출처 결합이 [`RARE-EARTH+ALTERNATIVE.tape`](RARE-EARTH+ALTERNATIVE.tape) 첫 draft에 들어갔다가 2026-05-17 수정됨.

### 2.5 TRACK 5 — NdFeB 저-Dy/Tb (`hxm-mag-lowdy-001`)

- **접근**: 고가 HREE (Dy, Tb)를 저렴/풍부 LREE (Ce, La)로 grain boundary에서 치환
- **목표**: 150°C 이상 열보자력 유지하면서 HREE 함량 ≥50% 감축
- **트레이드오프**: Ce/La 첨가는 포화자화 감소 → grain refinement + GB diffusion으로 보상
- **상태**: Toyota / Daido + Hitachi Metals가 50-80% Dy 감축 프로토타입 모터 자석 발표
- **anchors**: PMC PMC11595260 (Securing REE PMs); arxiv:2312.02475 (ML 보자력 예측)
- **falsifier**: F-MAG-7: 150°C에서 Hc 손실 > 15% vs 상용 NdFeB baseline → FAIL

### 2.6 TRACK 6 — AI / ML 자석 발굴 (`hxm-mag-aifound-001` = FeCo₂Ge)

- **접근**: MAGNDATA · NEMAD · MP · GNoME에서 graph-NN + descriptor 스크리닝
- **증거**: NEMAD (67,573 entries, 90% 분류 정확도); Table 4 스크린 → **62 FM 후보 Tc>500K**, 22%가 600K 초과
- **NEMAD Table 4 상위 REE-free 후보** (3-모델 Ensemble-NN / XGBoost / RF 예측 Tc, K):

  | 화합물 | Ensemble-NN | XGBoost | RF |
  |---|---|---|---|
  | Ga₃Fe₄Co₈Si | 1151 | 1157 | 1010 |
  | FeCo₂Ge | 1051 | 1068 | 999 |
  | GaFe₂Co₄Si | 1042 | 1013 | 1007 |
  | Fe₃Co₃Si₂ | 1042 | 939 | 913 |
  | MnCo₂Si | 823 | 991 | 662 |

- **선정**: `hxm-mag-aifound-001` → **FeCo₂Ge** (Heusler-like). 단순 조성 + 3-모델 Tc 합의(999/1051/1068 K)가 quinary Ga-Fe-Co-Si보다 합성 타깃으로 명확
- **MP 검증 (2026-05-17)**: `mp-22300` — Fm-3m **full Heusler**, FM ordering, E_hull=0 (안정), M_tot=6.0 μB. → `hxm-mag-aifound-001` **DESIGN → SIM-DFT 승급**
- **상태**: SIM-DFT (MP DFT cross-ref); 다른 Table 4 후보는 계산 단계, 실험 검증율 ≤5%
- **caveat**: AI 예측 ≠ 측정값 (`@F f2`). NEMAD Tc는 ML 회귀(R²=0.87, MAE=56K)이지 측정 아님. SIM-DFT는 MP의 ordering+E_hull cross-ref만 의미하며 Tc는 여전히 UNVERIFIED
- **anchors**: arxiv:2409.15675 (NEMAD, Nat. Commun. 16 9415 (2025)), arxiv:2509.05909 (ML 자기 order 분류), arxiv:2507.01913 (구조 기반 ML)
- **falsifier**: F-MAG-8: 실측 Tc < 600 K OR 단상 순도 > 90% 합성 불가 → FAIL

---

## 3. 거버넌스

### 3.1 무엇이 대체로 인정되나 (`@D g1_substitution_defined`)

다음 중 ≥1 성립 시에만 본 파일에 등재:
- (a) 자성상에서 ≥1 REE 원소 제거 (TRACK 2/3/4)
- (b) 동일 envelope에서 Dy/Tb ≥50% 감축 (TRACK 5)
- (c) virgin REE를 secondary feedstock으로 >25% 대체 (TRACK 1)
- (d) MP / GNoME / OMat24 등 기존 DB에 미수록 후보 발굴 (TRACK 6, 단 신규성 성립 시)

마케팅성 substitution(예: AlNiCo for niche industrial)은 정량 envelope-match 없이는 비편입.

### 3.2 실물리 ceiling (`@D g2_real_limits_first`)

성능 천장은 실제 자기물리에 의해 bound:
- **NdFeB (BH)max 이론 최대**: ~64 MGOe (Stoner-Wohlfarth single-domain, 100% 이론 밀도 + 완벽 정렬)
- **Brown's coercivity inequality**: Hc/Hk 관계
- **anisotropy field**: H_K = 2K₁/μ₀M_s

n=6 격자 적합으로 천장이 결정되는 것 아님 (`@D g2`).

### 3.3 arxiv 증거 freeze (`@D g3_arxiv_freeze`)

본 파일의 arxiv 인용은 2025-04 → 2026-05 문헌 wave에 고정. 신규 문헌은 새 `@X` entry로 추가(기존 entry silent 재작성 금지).

---

## 4. 금지 패턴

| ID | 패턴 | 룰 |
|---|---|---|
| `@F f1_lab_mm_strength_claim` | lab-mm 성능 ≠ 생산 grade | 매 성능 클레임에 (lab-mm \| pilot \| production) 태그 필수 |
| `@F f2_ai_prediction_as_measurement` | DFT / ML 예측 ≠ 측정 | `SIM-DFT` / `SIM-NNP` / `SIM-PROXY` 태그 후 promotion |
| `@F f3_recycling_silver_bullet` | 재활용이 신규 채굴을 0화하지 못함 | 향후 10년 ≤40% ceiling (EoL wave 타이밍) |
| `@F f4_quinary_boride_overclaim` | 보라이드 출처 구별 필수 | Beeson Adv. Mater. (peer-reviewed) ≠ arxiv (DFT-only); Mn₂MoB₄ 인용 시 paper-level reference 필요 |

---

## 5. 신소재 후보 시드 (NOVEL.md §3.5)

| ID | target | track | status | falsifier |
|---|---|---|---|---|
| `hxm-mag-boride-001` | (FeCoNiMnCr)₂B C16 (Fe/Co thin-film) | 4a | **SIM-NNP** (CHGNet, ubu-1) | F-MAG-4: thin-film K₁ < 1.0 MJ/m³ at 300 K OR bulk-scale 합성 미실증 |
| `hxm-mag-mn2sb-001` | Mn₂Sb tetragonal | 4b | **SIM-DFT** (mp-20664) | F-MAG-9: 측정 K < 0.8 MJ/m³ OR Tc < 600 K |
| `hxm-mag-mnalc-001` | MnAl τ-phase | 3 | **SIM-DFT** (mp-771) | F-MAG-5: 소결 (BH)max < 6 MGOe OR τ-phase 분율 < 80% after 100 cycles |
| `hxm-mag-ferrhd-001` | SrFe₁₂O₁₉ Co/La-doped | 2 | DESIGN (mp-3742 metastable) | F-MAG-6: (BH)max < 6 MGOe OR Hc decay > 15% after 1000 h @ 200°C |
| `hxm-mag-lowdy-001` | (Nd,Ce,La)₂Fe₁₄B | 5 | **SIM-DFT** (mp-5182 base) | F-MAG-7: 150°C에서 Hc 손실 > 15% |
| `hxm-mag-aifound-001` | FeCo₂Ge (Heusler-like, NEMAD) | 6 | **SIM-DFT** (mp-22300) | F-MAG-8: 실측 Tc < 600 K OR 단상 합성 불가 |
| `hxm-mag-gfcs-001` | Ga₃Fe₄Co₈Si (NEMAD 최고 Tc) | 6 | **SIM-DFT** (mp-1225352) | F-MAG-10: 실측 Tc < 700 K OR 단상 합성 불가 |
| `hxm-mag-znfe-001` | ZnFe tetragonal | 4b | DESIGN (mp-1215473 metastable) | F-MAG-11: 측정 κ < 0.5 OR 단상 합성 불가 |

**§3.5 roster 11개** (8 seeded-by-this-domain + 3 pre-existing cross-ref'd: `refree-001`↔mp-555 SIM-DFT, `tetra-001`↔mp-2213 SIM-DFT, `mnbi-001`↔mp-568382 DESIGN). 승급 규칙: MP record에 자성 ordering 확인 + **E_hull ≤ 0.01 eV/atom**이면 DESIGN→SIM-DFT (구조 안정성 proxy일 뿐, Tc/(BH)max/Hc는 전부 UNVERIFIED — `@F f2`). 최종: **7 SIM-DFT + 4 DESIGN**. wet-lab 검증은 [`CLOSURE_RESIDUAL_BACKLOG.md`](CLOSURE_RESIDUAL_BACKLOG.md) §C-MET에 등재.

---

## 6. 참고 문헌 (요약)

| ref | 역할 |
|---|---|
| [arxiv:2507.01849](https://arxiv.org/abs/2507.01849) | DFT HT REE-free PM — Mn₂Sb / ZnFe / Fe8N + 7개 binary |
| [arxiv:2506.22569](https://arxiv.org/abs/2506.22569) | NdFeB 재활용 TEA + LCA + 사회영향 |
| [arxiv:2504.10495](https://arxiv.org/abs/2504.10495) | Phosphogypsum REE 회수 |
| [arxiv:2504.07007](https://arxiv.org/abs/2504.07007) | ML 광물화 인사이트 |
| [arxiv:2509.05909](https://arxiv.org/abs/2509.05909) | ML 자기 order 분류 |
| [arxiv:2507.01913](https://arxiv.org/abs/2507.01913) | 구조 기반 ML 자기 ordering |
| [arxiv:2409.15675](https://arxiv.org/abs/2409.15675) | NEMAD 67k 자성 화합물 DB |
| [arxiv:2312.02475](https://arxiv.org/abs/2312.02475) | ML 보자력 예측 |
| [arxiv:2605.02926](https://arxiv.org/abs/2605.02926) | 지정학 critical mineral resilience (QCCM) |
| [arxiv:2508.00556](https://arxiv.org/abs/2508.00556) | REE 산업 시스템 무역 리스크 |
| [arxiv:2506.11645](https://arxiv.org/abs/2506.11645) | REE 공급 분단 비운동 억제 |
| [arxiv:2512.20317](https://arxiv.org/abs/2512.20317) | 인도 critical minerals 맥락 |
| [arxiv:2405.01128](https://arxiv.org/abs/2405.01128) | REE-기반 magnetocaloric H₂ 액화 |
| [PMC11595260](https://pmc.ncbi.nlm.nih.gov/articles/PMC11595260/) | Securing REE PM (Dy/Tb 최소화) |
| ACS Sust. Chem. Eng. (2024) | LCA — ferrite + Mn-Al-C |
| Beeson, *Adv. Mater.* (2025), DOI 10.1002/adma.202516135 | C16 high-entropy boride (peer-reviewed) |
| [Climate Change News 2026-05-05](https://www.climatechangenews.com/2026/05/05/the-energy-transition-has-a-rare-earth-problem-these-startups-are-solving-it/) | 재활용 40% ceiling + 스타트업 풍경 |
| [phys.org 2026-01](https://phys.org/news/2026-01-class-strong-magnets-earth-abundant.html) | Georgetown 보라이드 발표 (press) |
| [ScienceDaily 2026-02](https://www.sciencedaily.com/releases/2026/02/260218031611.htm) | AI 자석 발표 (press, NEMAD 매칭) |
