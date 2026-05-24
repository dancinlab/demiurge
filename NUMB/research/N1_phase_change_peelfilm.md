# NUMB N1 — phase-change peel-film: 체온-트리거 supersaturation 방출

> 🧊 **NUMB N1 (NOVEL 후보)** — 실온(20-25°C)에 metastable 한 PCM(phase-change matrix) peel-film 크림. 피부 접촉(32-34°C 표면 / 37°C 심부)으로 **2차 carrier 만 melt** → active(lid+tet)가 보조 co-solvent pool로 방출되며 **a=1(포화) → a>1(supersat)** 도약 → flux 증폭. 체온 = 무device 트리거 ("drug hand-warmer").
> sim = `NUMB/sim/n1_phase_change_peelfilm.hexa` (verbatim 🟢 §6).
> 핵심 honest gate: Pliaglis 가 이미 *peel + supersat* 이므로 **N1 의 진짜 novelty = "체온이 트리거인가"** (Pliaglis 는 *물 증발*만 사용).

---

## 1. 모델: Fick + 열역학 활동도

```
J = D_eff · K · a            (정상상태 flux; a = 약물 활동도, 포화=1)
t_lag = h² / (6 · D_eff)     (Crank slab lag; onset 지배)
C(z) = C_surf · a · exp(-z/λ)  (지수 감쇠, A1+A3 모델)
```

| 변수 | EMLA | Pliaglis | hexa-LAC v1 (A2+A3) | **N1 (제안)** |
|---|---|---|---|---|
| `a` (활동도) | 1 | 1 | 2 (peel-film supersat) | **5** (film × PCM-release 추가 2.5×) |
| `D_eff / D_base` | 1× | 3× (occlusion) | 20× (CPE+supersat) | 20× (변화 없음 — PCM는 D 아닌 a 레버) |
| 트리거 | 도포 | 물 증발 (실온) | 물 증발 (실온) | **체온 32-34°C** (PCM melt) |
| 활성층 phase | aq/oil emul | 건조 peel-film | 건조 peel-film | 건조 peel-film + 체온-melt sub-layer |

**핵심 통찰**: `a` (활동도)는 **steady-state flux** 만 곱한다. `t_lag = h²/(6D)` 는 **D-driven**, `a` 와 무관 → **N1 의 활동도 증폭은 onset 을 줄이지 못한다**. N1 의 이득 = **DEPTH (C(z) 단면 증폭) + DURATION (높은 J 가 더 오래 유지)** 에 한정.

---

## 2. 정직한 wall check — Pliaglis 가 이미 무엇을 하는가

```
   ┌─────────── Pliaglis (FDA, 2006) ────────────┐
   │ 1. lid+tet 7+7% eutectic mix (Tm ~18C)      │
   │    → 실온에서 *이미* 액상 oil = 포화 (a=1)   │
   │ 2. 크림에 HPC 폴리머 + 물                    │
   │    → 도포 후 물 *증발* (실온) → 단단한 peel  │
   │ 3. 일부 supersat 효과 (활동도 약간↑ 가능)    │
   └─────────────────────────────────────────────┘
   체온 트리거 ✗ — 모든 단계가 *실온 + 시간*에서 일어남
```

- Pliaglis 의 "phase change" = **물 증발 → 폴리머 film 형성** (실온, 시간 의존). 체온 무관.
- Pliaglis 의 active 자체는 eutectic Tm ~18°C 라 **실온에서 이미 액상** — 체온이 추가로 녹일 게 없음.
- **N1 의 novelty 후보**: lid+tet 와 *별개로 존재하는 SECONDARY carrier* (Tm 32-35°C) 가 체온으로 melt → 그 안에 담겼던 active 가 *2차 co-solvent pool* 로 방출 → 그 pool 에서 **supersat 상태 (a>1)** → flux ↑.
- 즉 N1 = **이중-phase 아키텍처** (matrix metastable → 체온 release). Pliaglis ⊂ N1 의 1층 등가, **N1 의 2층(PCM)이 새것**.

---

## 3. PCM carrier 후보 (Tm 표 — 32-37°C 윈도우)

| 클래스 | 후보 | Tm (°C) | 윈도우? | 비고 |
|---|---|---|---|---|
| 지방 알코올 | cetyl alcohol | 49.3 | ✗ 너무 높음 | 표준 emulsifier — 윈도우 밖 |
| 지방 알코올 | stearyl alcohol | 59.8 | ✗ 너무 높음 | 표준 — 윈도우 밖 |
| PEG | PEG-1000 | 37-40 | △ 경계 | 심부만 melt 가능, 표면 부족 |
| PEG | PEG-1500/4000 | 44-53 | ✗ 너무 높음 | 윈도우 밖 |
| **지방산 eutectic** | **capric (C10) + palmitic (C16)** | **32.17** | **✓ 표면 트리거** | Sharma 2013 latent 153 J/g |
| **지방산 eutectic** | **lauric (C12) + myristic (C14) 66:34** | **34.28** | **✓ 따뜻한 표면** | Sari 2009 latent 166.8 J/g |
| 지방산 eutectic | myristic + stearic 70:30 | 35.0 | ✓ 심부 트리거 | latent ~169 J/g |
| 지방산 eutectic | lauric + stearic 4:1 | 39.0 | △ 경계 | 심부 only |
| 폴리머 (LCST) | PNIPAM (homo) | 32.0 | ✓ coil→globule | melt 아닌 *상전이*; biocompat 의문 |
| 폴리머 (LCST) | PNIPAM-coNIPMAM | 32-39 | ✓ 튜닝가능 | 공중합 비율로 Tm 조절 |

**선정**: **capric+palmitic (32.17°C)** = 표면 트리거 best (skin surface 32-34°C 면 fully melt). **lauric+myristic (34.28°C)** = 보다 보수 (체온 평형 후 melt; "오동작 방지" 강함). 폴리머 PNIPAM 은 *coil→globule* 이지 결정 melt 아니라 latent heat 부담 적지만 **장기 biocompat 데이터 부족 + tattoo/laser 임상 부재** → 1차 후보는 fatty-acid eutectic.

---

## 4. 이중-phase 아키텍처 ASCII

```
   실온 (20-25°C) — STORAGE                체온 접촉 (32-34°C) — RELEASE
   ┌──────────────────────────────┐         ┌──────────────────────────────┐
   │ ░░░░ HPC peel-film 폴리머 ░░░ │         │ ░░░░ HPC peel (물 증발 시작) │
   │ ▓▓ capric+palmitic ▓▓ SOLID  │  →  T↑  │ ▓▓→▓→ ░ ░ CARRIER MELTING ░  │
   │ ▓▓ lid+tet 결정 가둠 ▓▓      │         │ ▓→░ lid+tet 액상 방출 ░░░░░░ │
   │ ░ EtOH/PG/물 (co-solvent) ░  │         │ ░░ 액상 active + co-solvent  │
   │ active 활동도 a ≈ 1 (안전)    │         │  → SUPERSAT POOL  a ≈ 5      │
   └──────────────────────────────┘         └──────────────────────────────┘
        SC (각질층) ──── 10-20μm                  SC ──── 흡수 시작 (a×J 증폭)
```

**왜 안전 (실온 metastable)**: 결정형 capric+palmitic 안에 lid+tet 가 분산 → 활동도 1 미만 → **저장 중 화학 분해 / 결정화 risk ↓**. 체온 접촉 시에만 carrier melt → 액상 transient 에서 supersat → SC 흡수.

---

## 5. flux 정량 비교 — hexa recompute (verbatim · 🟢 · per @D g5)

```
=== NUMB N1 — phase-change peel-film: body-heat-triggered supersaturation ===

[2] thermodynamic-activity model: J = D_eff * K * a; baseline a=1 (saturated)
  Pliaglis baseline   a_pl = 1.0   (lid+tet eutectic liquid; saturated in oil)
  hexa-LAC v1 (TTR-LAC) a_hl = 2.0 (peel-film supersat per A2+A3 Sec 5 estimate)
  N1 design target    a_n1 = 3.0-5.0  (Davis 2002 cap: degree-of-sat linear 2-5x)
  -> a_total(N1) realistic ceiling = 5.0 (Davis 2002, Pellanda 2025 review)
  -> NEW factor N1 adds OVER hexa-LAC v1 = 5.0/2.0 = 2.5x activity multiplier

[3] flux + onset recompute — (h=10um, D_base=1e-10 cm^2/s)
  baseline (no boost, a=1)  t_lag=27.7778 min  onset=55.5556 min
  Pliaglis        D_eff=3e-10  a=1.0  onset(min)=18.5185  flux~3e-10
  hexa-LAC v1     D_eff=2e-09  a=2.0  onset(min)=2.77778  flux~4e-09
  N1 (proposed)   D_eff=2e-09  a=5.0  onset(min)=2.77778  flux~1e-08

  KEY: a (supersat) multiplies STEADY-STATE flux, NOT t_lag.
       => N1 does NOT shorten onset further once D is already boosted.
       => N1 amplifies steady-state amount delivered per unit time
       =>   which raises DEPTH penetration (C(z) profile) + DURATION margin.

[4] depth gain at 200um (free nerve endings) — lambda=60um, C_surf=14% lido-eq
  Pliaglis(a=1)   C(200um)=0.4998 %lido    C/MEC(0.5%) = 0.9996
  hexa-LAC(a=2)   C(200um)=0.9996 %lido    C/MEC(0.5%) = 1.9992
  N1(a=5)         C(200um)=2.499 %lido    C/MEC(0.5%) = 4.998
  -> dermal block margin: Pliaglis 1.0x MEC (marginal), hexa-LAC 2.0x (safe), N1 5.0x (deep margin)

[5] release kinetics gate — does PCM melt FAST enough at skin contact?
  skin-contact thermal equilibration time (1mm film) ~ tau = L^2 / (pi^2 * alpha_thermal)
    L = 1mm, alpha_cream ~ 1.4e-3 cm^2/s ; tau_thermal ~ 0.72 s
  PCM melt latent heat: lauric+myristic ~166 J/g, 1mm film ~ 0.1 g/cm^2
    Q_needed = 16.6 J/cm^2
  body-heat flux (skin surface) ~ 5-10 mW/cm^2
    -> full melt time = 16600 mJ / 10 mJ/s = 1660 s = 28 min  (LATENT-HEAT BOTTLENECK)
  -> CRITICAL: full melt of 1mm PCM film takes ~28min from body heat alone
     => N1 must use THIN PCM-only sub-layer (~100um, 2.8min melt) OR sparse-PCM dispersion

=== verdict: N1 GENUINELY NOVEL vs Pliaglis on mechanism (body-T trigger vs water-evap) ===
=== N1 adds 2.5x activity multiplier (5/2) over hexa-LAC v1 -> DEPTH+DURATION, NOT onset ===
=== latent-heat melt time (28min @ 1mm) is the new internal wall; thin sub-layer fixes ===
```

---

## 6. release timeline ASCII (1mm PCM 가정 vs 100μm sub-layer)

```
   N1 두 시나리오:

   [A] 1mm 전체 PCM matrix (단순) — LATENT-HEAT WALL
   t=0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 28 min
       │←─── PCM 부분 melt (체온 누적) ───→│
                                              │← melt 완료 a=5 도달
       hexa-LAC v1 (a=2) 이미 onset (~3min) 통과 → N1 의 a 증폭이 *너무 늦음*
       ⇒ 실효 성능 = hexa-LAC v1 와 동일 (PCM 이득 못 살림)

   [B] 100μm PCM sub-layer + 900μm 일반 peel-film — FIX
   t=0 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 28 min
       │←─ 2.8min ─→│
       │← PCM melt 완료 a=5 활성화                  │← duration 끝
       hexa-LAC v1 onset (~3min) 와 거의 동시 → a 증폭이 *steady-state* 단계 적용
       ⇒ DEPTH gain 5× MEC, DURATION 연장
```

---

## 7. 정직한 novelty 평가 — N1 vs Pliaglis vs hexa-LAC v1

| 차원 | Pliaglis | hexa-LAC v1 (A2+A3) | **N1 (제안)** | novelty? |
|---|---|---|---|---|
| eutectic lid+tet | ✓ (7+7%, Tm 18C) | ✓ 상속 | ✓ 상속 | ✗ 동일 |
| peel-film (HPC) | ✓ 물 증발 | ✓ 물 증발 | ✓ 물 증발 (+ PCM) | ✗ 동일 |
| 활동도 a | 1 | 2 (film supersat) | 5 (film × PCM-release) | **✓ 신규 (2.5×)** |
| 트리거 | 도포 + 시간 | 도포 + 시간 | **체온 32-35°C** | **✓ 신규 mechanism** |
| 2차 carrier (PCM) | ✗ | ✗ | **✓ capric+palmitic / lauric+myristic** | **✓ 신규 성분** |
| D-boost | 3× (occlusion) | 20× (CPE) | 20× (CPE 상속) | ✗ 동일 |
| onset | 30 min | ~3-11 min | **~3-11 min** (변화 없음) | ✗ N1 은 onset 미개선 |
| C(200μm)/MEC | 1.0× | 2.0× | **5.0×** | **✓ 진정한 진보** |
| duration 마진 | 11h | ~11h | 더 길게 + 더 깊게 | △ 정량화 필요 |

> **honest verdict**: **N1 은 Pliaglis 의 incremental tweak 이 아니다**. 메커니즘 축이 다르다 — Pliaglis = *water-evap* (실온 시간 의존), N1 = *body-T melt* (트리거 명확). 그러나 **novelty 의 형태가 "onset 단축"이 아니라 "depth/duration 증폭"** 임을 정직히 인정. **a 는 1/t_lag 와 곱해지지 않는다** — 이 점이 단순 "더 빠른 마취" 마케팅을 차단.
>
> N1 의 진짜 의의는 **NUMB G3 (소아 LAST 스케일링) + G4 (저농도 OTC)** 와의 정합성: 활동도 증폭으로 **C_surf 를 낮춰도 같은 depth 달성** 가능 → **저농도 OTC SKU (lid 2.5+tet 2.5)** 도 a=5 면 hexa-LAC v1 (a=2, 14% surface) 의 depth 와 동등 → **LAST 엔벨로프를 안전 쪽으로 이동**. **이게 진짜 novelty의 활용처**.

---

## 8. 잔여 wall (honest @D d6)

| # | wall | 설명 | 해소 경로 |
|---|---|---|---|
| W1 | latent-heat melt 28min | 1mm 전 PCM 시 a=5 발동이 너무 늦음 | 100μm sub-layer / sparse-PCM dispersion (Sec 6 [B]) |
| W2 | sustained supersat crystallization | a>3 면 분 단위 결정 nucleation | PVP-K30 / HPC 항-nucleant + 짧은 사용 시간 |
| W3 | PCM + lid+tet + EtOH/PG miscibility | 4-성분 phase diagram 미검증 | Franz cell ex-vivo + DSC 검증 (비-wet-lab 한계 도달) |
| W4 | onset 미개선 | a 는 1/t_lag 와 곱해지지 않음 — N1 의 한계 | 솔직 인정; novelty 는 depth/duration 축 |
| W5 | LAST 안전 — 2.5× dermal flux = 2.5× systemic | A4 envelope 재계산 필요 | sim a4_LAST_safety 재실행 + 면적 cap 재정의 |
| W6 | PCM-active 결정형 lid+tet 가둠 stability | 저장 중 active 분해 / 결정 변형 가능 | DSC + XRD 가속 stability (3mo at 40°C/75%RH) |

**가장 큰 wall**: **W1 (latent-heat 28min)** — physical first-principles 계산이 PCM-1mm 시 *너무 느림* 을 보임. 100μm sub-layer 로 해소 가능하나 *제조 복잡성* (multi-layer cream extrusion) 이 trade-off. 비-wet-lab grounding 한계 = Franz cell 4-성분 miscibility 측정.

---

## 9. tier ledger

| claim | tier |
|---|---|
| Fick `J=D·K·a` · `t_lag=h²/6D` · 활동도가 steady-state flux 만 곱함 | 🔵 closed-form |
| §5 hexa recompute (verbatim) | 🟢 numerical |
| Pliaglis = water-evap peel + eutectic Tm 18°C · capric+palmitic Tm 32.17°C · lauric+myristic 66:34 Tm 34.28°C · PNIPAM LCST 32°C · supersat 5× cap (Davis 2002) | 🟡 문헌 |
| PCM + eutectic active + EtOH/PG 4-성분 miscibility · in-vivo a 유지율 · 100μm sub-layer 제조성 | 🟠 (Franz cell + DSC) |
| N1 의 임상 우월성 (vs Pliaglis 실제 환자) | 🔴 (oracle 부재) |

> **N1 verdict**: 🟠 **plausibly-novel-on-mechanism · onset-축에서는 미개선** — 활동도 a=5 도달이 *steady-state* 단계에 적용되어 **depth (5× MEC at 200μm) + duration** 만 증폭. Pliaglis 가 *water-evap* 만 사용하는 반면 N1 은 *body-T PCM melt* 라는 **orthogonal trigger** 를 추가 → mechanism 차원에서 novel. 그러나 **onset 가속 NUMB G1 목표에는 기여하지 않음** → NUMB 가치는 **G3 (소아 저용량) + G4 (OTC 저농도) 에서 depth 보전** 측면. wet-lab 게이트 = Franz cell + DSC. absorbed=false (NUMB N 트랙 신규).

---

## Sources

- **Pliaglis FDA label (021717)** — lid 7% + tet 7% eutectic cream, phase-changing peel, 30 min apply / 11h analgesia — [accessdata.fda.gov/drugsatfda_docs/label/2006/021717lbl.pdf](https://www.accessdata.fda.gov/drugsatfda_docs/label/2006/021717lbl.pdf) · [dailymed.nlm.nih.gov](https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=8a1b2553-ce65-4557-b33d-cb3dd2a307fa)
- **Pliaglis phase-change mechanism** — Crescita Therapeutics / Galderma proprietary Peel technology, water-evap → HPC film hardening — [crescitatherapeutics.com/pliaglis](https://www.crescitatherapeutics.com/pliaglis) · [practicaldermatology.com Pliaglis approval](https://practicaldermatology.com/news/20121022-nuvo_and_galderma_win_fda_approval_for_topical_peel/2459699/)
- **lid+tet eutectic Tm ~18°C** — Yang & Grant 2003 (*J Pharm Sci*) two-phase melt characterization · Lopes-Aguiar 2015 (*Mol Pharm*) hydrogen-bonding stability — [PMC 4444629](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4444629/) · [researchgate 11935770](https://www.researchgate.net/publication/11935770)
- **supersaturation 5× cap + skin penetration** — Davis & Hadgraft 2002 (*Pharm Res* 19:1097) deg-of-sat linear flux · Pellanda 2015 (*Curr Pharm Des* 21) review — [pubmed.ncbi.nlm.nih.gov/25925122](https://pubmed.ncbi.nlm.nih.gov/25925122/) · [PMC 6637090 medicated foams thermodynamic activity](https://pmc.ncbi.nlm.nih.gov/articles/PMC6637090/)
- **capric+palmitic eutectic Tm 32.17°C, latent 153 J/g** — Sharma et al. 2013 *Solar Energy Mater* — [researchgate 257008451](https://www.researchgate.net/publication/257008451)
- **lauric+myristic 66:34 eutectic Tm 34.28°C, latent 166.8 J/g** — Sari & Kaygusuz 2002 *Renewable Energy* · ACS Omega 2022 lauric eutectic — [PMC 9096936](https://pmc.ncbi.nlm.nih.gov/articles/PMC9096936/)
- **fatty acid eutectic PCM for NIR drug release (lauric+stearic 4:1 Tm 39°C, latent 167 J/g)** — Chen et al. 2018 *Polymers* — [PMC 5795622](https://pmc.ncbi.nlm.nih.gov/articles/PMC5795622/)
- **fatty acid PCM in drug microcapsules (Tm tunable 32-39°C)** — Karaipekli & Sari 2025 *BMC Chemistry* — [bmcchem.biomedcentral.com 10.1186/s13065-025-01406-4](https://bmcchem.biomedcentral.com/articles/10.1186/s13065-025-01406-4) · ternary fatty-acid eutectic phase diagrams — [PMC 12843165](https://pmc.ncbi.nlm.nih.gov/articles/PMC12843165/)
- **PEG Tm vs MW** (PEG-1000 ~37-40°C, PEG-3000/4000 ~53°C) — ACS Omega 2025 PEG-water domain size — [pubs.acs.org/doi/10.1021/acsomega.5c07236](https://pubs.acs.org/doi/10.1021/acsomega.5c07236)
- **cetyl alcohol Tm 49.3°C, stearyl 59.8°C** — Schulz et al. 2018 *J Nanotechnol* SLN raw materials — [scholars.direct/ant-1-005](https://scholars.direct/Articles/nanotechnology/ant-1-005.php) · [chemicalbook 67762-27-0](https://www.chemicalbook.com/ChemicalProductProperty_EN_CB6296155.htm)
- **PNIPAM LCST 32°C, copolymer tunable 32-39°C** — Schild 1992 / Liang 2016 thermoresponsive on-demand transdermal — [pubmed 26952404](https://pubmed.ncbi.nlm.nih.gov/26952404/) · [PMC 6681499 stimuli-responsive review](https://pmc.ncbi.nlm.nih.gov/articles/PMC6681499/)
- **PCM for controlled drug release (general framework)** — Bhattacharya 2022 *Frontiers Bioeng* cancer PCM — [PMC 9510677](https://pmc.ncbi.nlm.nih.gov/articles/PMC9510677/) · Choi 2020 *Polymers* PCM controlled release — [PMC 7473464](https://pmc.ncbi.nlm.nih.gov/articles/PMC7473464/)
- **heat enhances lidocaine topical** (Synera, warm steam) — Saeki 2004 *Anesth Analg* — [pubmed 15041584](https://pubmed.ncbi.nlm.nih.gov/15041584/) · iron-gold NP hyperthermia LA — [PMC 7697341](https://pmc.ncbi.nlm.nih.gov/articles/PMC7697341/)
- **inherited from TTR-LAC** — A1 (`t_lag = h²/6D` baseline) · A2+A3 (D-boost 20× + λ=60μm) · A5 (Franz waterfall MD→in-vivo) · A4 (LAST envelope)
- (재현) `NUMB/sim/n1_phase_change_peelfilm.hexa` — `hexa run NUMB/sim/n1_phase_change_peelfilm.hexa`
