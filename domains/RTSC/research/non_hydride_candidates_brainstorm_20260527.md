# Non-hydride RTSC family — brainstorm + Tc / DFT-feasibility table

> **kind**: tier-2 STRATEGY landscape doc · /gap full F8 (landscape) 응답
> **date**: 2026-05-27 KST · **domain**: RTSC · **/gap diagnosis**: hydride-only space biased (9 H₃X + clathrate + X₂MH₆ ternary), non-hydride RTSC frontier 미탐색
> **trigger evidence**: BETE-NET rel_err A15(Nb₃Al/V₃Ga) 21.7-35% · Hydride 90%+ (RTSC.log §9 family-wide d7 wall) → **non-hydride frontier 가 ML-trustworthy 영역**
> **governance**: d6 (first-principles · ML 단독 베팅 금지) · g3 (no LLM self-judge) · g63 (honest closed-negative) · R4 (absorbed=false 영구)

---

## 0. 정직 경계 (HONEST scope, 작업 전 명시)

- **non-hydride frontier 가 hydride 보다 fertile 인지 미증명**. BETE-NET 21% rel_err 도 90%+ 대비 *상대적* — absolute Tc accuracy 보장 아님.
- **Tc > 200K non-hydride 후보는 본 brainstorm 시점에서 0건**. 모든 후보의 measured Tc < 165K (Hg-1223 cuprate ambient ceiling).
- 본 doc 의 가설: "ML-trustworthy 영역에서 cross-tool consistency 와 첫-원리 anchor 를 더 견고히 확보 → hydride frontier 의 d7 wall 해소에 역수입" — N5 → N6 funnel 의 *parallel verify lane*, RTSC absorbed=true 직결 아님.
- d6 plateau 강제 금지 — 본 doc 의 후보 모두 simulation-tier. measured oracle 없이는 absorbed=false 영구.

---

## 1. Brainstorm — 5-7 non-hydride family (1-pass 발산)

발산 후 즉시 DFT-feasibility + Tc 가능성 + 본 도메인 기여도 3-axis 평가. **체크안한 후보** (e.g. Bi₂Sr₂CaCu₂O₈ BSCCO single-crystal) 도 candidate pool 에 잔여 — 후속 amend 가능.

### 1.1 발산 풀 (raw)

1. **A15 family** — Nb₃Sn (measured 18.7K, 8 atoms) · Nb₃Al (measured 18K, 8 atoms) · V₃Ga (measured 16.5K, 8 atoms) · Nb₃Ge (measured 23K, 8 atoms)
2. **MgB₂ + derivatives** — 순수 MgB₂ (measured 39K, 2 atoms) · C-doped MgB₂ (Tc 36-39K) · Sc-substituted ScB₂ (Tc ~1.5K, low) · Be-substituted Mg(B,Be)₂ (theoretical Tc enhancement)
3. **HTS Cuprate** — YBa₂Cu₃O₇ (measured 93K, ~13 atoms) · Hg-1223 (HgBa₂Ca₂Cu₃O₈, measured **134K** ambient · **164K @ 30 GPa**) · Bi-2212 BSCCO (measured 85K)
4. **FeSC (iron-based)** — FeSe monolayer / SrTiO₃ (measured ~65-100K, 5 atoms primitive + substrate) · LiFeAs (measured 18K, 4 atoms) · LaFeAsO (measured 26K with F-doping)
5. **2D layered** — twisted bilayer graphene (TBG, measured ~1.7K, magic angle θ=1.1°, **단위셀 11K+ atoms**) · NbSe₂ monolayer (measured ~7K) · 1T'-MoTe₂ (Tc ~0.1K, low)
6. **비전통 (heavy-fermion · doped C₆₀ · apex-Cl)** — Rb₃C₆₀ (measured 28K) · K₃C₆₀ (measured 19K) · Sr₂CuO₃Cl (apex-Cl cuprate, lit Tc <40K) · UTe₂ heavy-fermion (measured 1.6K, 미관련)
7. **Topological / Weyl SC** — CuxBi₂Se₃ (measured 3.8K) · doped PbTaSe₂ (Tc ~2.5K) — 모두 low Tc, RTSC 본 도메인 직접기여도 낮음

### 1.2 evaluated table

| family | 후보 | Tc measured (K) | atoms / primitive | DFT-feasibility (pool free?) | BETE-NET trust | RTSC 기여도 | verdict |
|---|---|---|---|---|---|---|---|
| **A15** | **Nb₃Al** | 18.0 | **8** | ✓ ubu-1 free (d7) — 8×8×8 k feasible | **✓ ~22% rel_err (A15 family)** | **anchor for cross-tool consistency** — closed-form recompute + BETE-NET retro-comparison | **🟢 PILOT 1 SELECTED** |
| A15 | Nb₃Sn | 18.7 | 8 | ✓ | ✓ | already measured/known (M7 §3.2 covered) | 보류 (Nb₃Al 후속 candidate) |
| A15 | V₃Ga | 16.5 | 8 | ✓ | ✓ ~35% rel_err | secondary anchor | 보류 |
| A15 | Nb₃Ge | 23 | 8 | ✓ | (untested) | high Tc end of A15 | 보류 (Nb₃Al 후) |
| **MgB₂** | **pure MgB₂** | **39.0** | **2** | **✓ very cheap — 2-atom primitive, <1h SCF** | partial (BETE-NET coverage) | **ambient·light·measured benchmark · 39K 직접 reproduce → V3 numerical recompute anchor 확장** | **🟢 PILOT 2 SELECTED** |
| MgB₂ derivative | C-doped MgB₂ (B₀.₈C₀.₂) | 36-39 | 2 (VCA) or larger | △ supercell needed (~32 atoms) | partial | derivative — first 순수 baseline 후 | 보류 |
| **HTS Cuprate** | YBa₂Cu₃O₇ (YBCO) | 93 | 13 | △ ubu-1 marginal (d-electron · LDA+U) | △ Hubbard-U 필요 | high-Tc anchor but DFT-cost prohibitive | 후속 (별 cohort) |
| HTS Cuprate | Hg-1223 ambient | 134 | 15 | △ pool marginal | △ | highest ambient Tc cuprate · **압력 의존성 측정-grade anchor 후보** | 후속 (priority 2) |
| FeSC | FeSe monolayer | 65-100 | 5 + substrate | △ substrate (SrTiO₃) 필요 → 10+ atoms heteroint. | partial | substrate-dependence DFT 어려움 | 후속 |
| FeSC | LiFeAs | 18 | 4 | ✓ | partial | bulk single-crystal · DFT 친화 | 후속 |
| 2D | TBG magic-angle | ~1.7 | 11000+ | ✗ moiré supercell prohibitive | ✗ | low Tc + huge cell | 제외 |
| 2D | NbSe₂ monolayer | 7 | 3 (1H) / 6 (1T) | ✓ small cell | partial | low Tc, RTSC 직접기여도 약함 | 보류 |
| Doped C₆₀ | Rb₃C₆₀ | 28 | 63 | △ 60-atom cluster prohibitive single-pod | (untested) | molecular SC · 별개 mechanism | 후속 |
| Cuprate variant | Sr₂CuO₃Cl | <40 | 7 | ✓ | (untested) | apex-Cl substitution probe | 보류 |
| Heavy-fermion / Weyl | UTe₂ / CuxBi₂Se₃ | <4 | varies | varies | (untested) | low Tc, off-scope | 제외 |

→ **Pilot selection rule**: (1) measured Tc ≥ 18K (anchor 가치) · (2) atoms/primitive ≤ 8 (pool free, d7) · (3) BETE-NET coverage 명시 (cross-tool consistency).
→ **선정**: **Nb₃Al (A15, 8 atoms, 18K)** + **pure MgB₂ (2 atoms, 39K)**.

---

## 2. Pilot 선정 근거 (deck-spec rationale)

### 2.1 Nb₃Al (A15) — Pilot #1

- **Tc anchor**: measured 18.0 K (Bardeen-Cooper-Schrieffer regime, λ ≈ 0.84, ω_log ≈ 230 K, μ\*=0.13 표준).
- **DFT-feasibility (d7)**: 8 atoms primitive (Pm-3n space group #223, A15 prototype Nb₆Al₂ in conventional cell, 1/4 = 8 atoms in primitive · Nb at 6c (1/4,0,1/2) + Al at 2a (0,0,0)). 80 Ry ecutwfc · 8³ k · 4³ q feasible on ubu-1 (-np 6, ETA ~4h SCF + ~10h ph.x el-ph).
- **BETE-NET trust**: A15 family BETE-NET predictions Nb₃Al/V₃Ga 의 rel_err 21.7-35% (RTSC.log §9 g4-family d7-wall closure record 가 hydride 90%+ 대비) → ML-trustworthy 영역. **cross-tool consistency test 가능**.
- **본 도메인 기여**: V3 numerical recompute ledger 의 hydride-편향(10/10) 을 **A15 baseline 1개 추가** → 미래 BETE-NET retro-comparison + AD Tc 재산정 anchor.
- **falsifier (pre-register)**: F-N6 ledger 와 별개 — `decks/nb3al/README.md` 안에 spec.

### 2.2 pure MgB₂ — Pilot #2

- **Tc anchor**: measured 39.0 K (Bogdanov 2001, Akimitsu) — historically *intermediate-Tc surprise* (BCS double-gap σ + π band).
- **DFT-feasibility (d7)**: **2 atoms primitive** (P6/mmm, AlB₂ prototype, a=3.086Å c=3.524Å) — 가장 저비용 metallic-SC benchmark. 60 Ry ecutwfc · 12³ k · 6³ q feasible on ubu-1 (-np 6, ETA SCF ~30min + ph.x ~6h total).
- **BETE-NET trust**: MgB₂ 는 BETE-NET 학습셋 *내* (ambient, light) → 직접 reproduce 가능 — **cross-tool consistency baseline**.
- **본 도메인 기여**: V3 ledger 의 hydride-편향 + ambient(0 GPa) 안 든 anchor 부재를 한 번에 해소. h3cl(140K)/h3o(191K novel) hydride ladder 의 *ambient counterpoint* — "ω_log=460K @ ambient" 직접 비교.
- **falsifier (pre-register)**: Allen-Dynes Tc(μ\*=0.13) recompute 가 39.0 ± 5K 범위 내면 🟢 ambient anchor lock; 범위 밖이면 pseudopotential / Coulomb pseudopotential parameter scrutiny.

---

## 3. d7 sizing pre-rent verification

| pilot | atoms/prim | ecutwfc (Ry) | k-mesh | q-mesh | est. wall (ubu-1 -np 6) | pool free? (d7) |
|---|---|---|---|---|---|---|
| Nb₃Al (A15) | 8 | 80 | 8³ | 4³ | SCF ~4h + ph.x ~10h ≈ 14h | ✓ |
| MgB₂ pure | 2 | 60 | 12³ | 6³ | SCF ~30min + ph.x ~6h ≈ 6.5h | ✓ |

→ 두 pilot 모두 **pool free 가능 (d7 small-cell)**. paid rent 불필요. d11 pre-feasibility OK. d16 syntax dry-run 은 dispatch 직전 별 cohort.

---

## 4. 보류 후보 (next-amend pool)

- Nb₃Sn (이미 industry mature · A15 secondary anchor 가능)
- Nb₃Ge (highest A15 Tc · BETE-NET coverage 미확인)
- Hg-1223 ambient (134K · DFT cost 의 LDA+U Hubbard-U gating 후 시도 가능)
- YBa₂Cu₃O₇ (93K · 동일 LDA+U gating)
- LiFeAs (18K · 4 atoms · feasible · FeSC anchor)
- C-doped MgB₂ (supercell · ~32 atoms · paid rent 영역)

→ 본 doc 의 selected pilot 2개 land 후 N6 다음 batch (F-N6-3 SSCHA · F-N6-4 h3br pressure-scan) 와 병행 가능.

---

## 5. Cross-reference

- `RTSC.md` milestone (post-amend) — Non-hydride RTSC family pilot (Nb₃Al, MgB₂) — BETE-NET trustworthy frontier 검증
- `domains/RTSC/falsifiers/F-N6.md` — same-cycle ledger (cation-VEC funnel falsifier 4종, 본 doc 와 페어)
- `domains/RTSC/verify/V3_numerical_recompute.md` — Allen-Dynes recompute ledger 의 hydride-편향 (10/10) — 본 pilot 결과의 land 위치
- `decks/nb3al/` (이 cycle) — Pilot #1 spec
- `decks/mgb2_pure/` (이 cycle) — Pilot #2 spec
