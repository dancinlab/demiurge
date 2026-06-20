🔬 RTSC SUCCESS-MODEL · GaM4X8 lacunar-spinel family lens
NAME: family-lens · alias: "which real GaM4X8 member runs hottest, and what's the ceiling"

Date 2026-06-19 · pure mini/python (numpy/scipy) + arxiv/web grounding · NO pod · NO cost.
Solver = validated SSH bond-bipolaron exact-diag (`../bond-bipolaron/solver.py`).
Lens driver = `family_lens.py` · raw = `family_lens_results.json`.
Builds on the verified success model: Ge:GaNb4Se8 (45 K onset anchor) → Ge:GaNb4S8 (~60 K).

## Mechanism (verified, carried forward)
GaM4X8 = cluster-Mott insulators (one unpaired e⁻ in the M4 molecular t2 orbital).
Under pressure / Ge-filling they go Mott→metal→SC, with SC tied to a SOFTENING M–X
**bond** phonon that modulates the inter-cluster hopping = off-diagonal / SSH (Peierls)
e-ph = the LIGHT-bipolaron escape channel. Gain of the success model: a higher S-bond
phonon Ω (lighter S anion) at slightly weaker λ_off, net higher Tc. Solver anchors
Ge:GaNb4Se8 → 45 K, every other member is a RELATIVE prediction off that anchor.

## The five lever lenses (≥3 evaluated, each a distinct knob)

### 1. ANION lens — S / Se / Te / O?(none) / mixed   [Ω ~ √(k/μ_MX)]
- **Pure-S wins.** Nb-S Ω ≈ 46.8 meV vs Nb-Se 35.0 vs Nb-Te 31.2 → **Ge:GaNb4S8 Tc ≈ 60 K** (1.34× the Se anchor), Te worse (40 K).
- **S is the lightest VIABLE anion — HARD ceiling.** Web/arxiv: **NO oxide lacunar spinel GaM4O8 exists** (family is exclusively chalcogenide S/Se; Pocha/Johrendt JACS 2005). The O analog is the only knob past S and it is structurally UNREALIZED. No mixed-S/Se lacunar spinel reported either.
- Real structures: GaNb4S8 SC ~4 K @23 GPa, GaNb4Se8 2.9 K @13 GPa (JACS 2005); the 45 K is the Ge-doped Se preprint (arXiv:2510.12452, 2025).
- **VERDICT: pure-S is the anion optimum; ceiling Ω(Nb-S)≈47 meV.**

### 2. A-SITE lens — Ga / Al / Ge / In / vacancy   [filling + bond stiffness k]
- A-site valence sets cluster electron count (Ga³⁺ vs Ge⁴⁺ shift filling by 1 e⁻/cluster). Ge is itself used as the A-site dopant (the filling lever, lens 3).
- **Al is lighter and would stiffen k** → if Al-stiffen k by +25% the model gives Ge:AlNb4S8 ≈ 67 K. BUT: **AlNb4S8 / AlV4S8 / InM4X8 are NOT published lacunar spinels** — speculative, NO DATA. Do not bank.
- **VERDICT: A-site stiffening is a genuine NOVEL whitespace but UNREALIZED; Ga is the only confirmed A-site for the SC members. Capped by non-existence.**

### 3. FILLING lens — Ge-doping n=1→1+x   [sets operating point t/Ω]
- Solver scan of Tc/Ω vs t/Ω (g/Ω=1, converged Nb=8): Tc/Ω rises monotonically with t/Ω (0.051 @0.5 → 0.105 @1.0 → **0.142 @1.30** → 0.183 @1.60) while the pair de-compacts (|Δb|/t: 3.10→1.46→**1.10**→0.55).
- **Compact-pair sweet spot = t/Ω ≈ 1.30** (|Δb|/t=1.10, last point with |Δb|≥t in this converged 1D solve), Tc/Ω = 0.142 → a **1.35× boost** over the t/Ω=1 anchor point.
- HONESTY (d6): R2's 2D solve (Nb=3) put the compact edge at t/Ω≲1; this converged 1D solve holds it to 1.30. The t/Ω=1.30 sweet spot is the **optimistic edge** — it requires Ge-doping to actually land the band at t/Ω≈1.3 while the pair stays compact. The **robust** filling point is t/Ω=1 (the verified-model anchor).
- **VERDICT: filling is the real high-Tc route (not pressure); optimal filling adds ≤1.35×, capped where the pair de-compacts.**

### 4. PRESSURE lens — P softens the M–X bond phonon
- Pressure RAISES g (stronger soft-mode coupling) but LOWERS Ω — the two fight. The Ω drop directly cuts the Tc prefactor.
- Real pressure family tops out at **~5.8 K (GaTa4Se8 @ 11.5 GPa)**; GaNb4Se8 2.9 K, GaNb4S8 ~4 K (Abd-Elmeguid PRL 2004 / JACS 2005). No documented Tc-dome above this.
- **VERDICT: pressure is the metallization trigger, NOT the high-Tc lever; capped at single-digit K. The Ge-filling (ambient) route dominates it by ~10×.**

### 5. CLUSTER lens — Nb4(4d) / Ta4(5d) / V4(3d) / Mo4
- **Only Nb4(4d) and Ta4(5d) are nonmagnetic** (confirmed). Ta is heavier → lower Ω: Ge:GaTa4S8 ≈ 56 K < Ge:GaNb4S8 60 K. 5d gives more SOC but no Tc gain in this phonon-prefactor channel.
- **V4 (3d) is magnetic + Jahn-Teller (GaV4S8/Se8 = Néel-skyrmion multiferroic hosts) → RULED OUT** (would give 66 K from light V, but magnetism kills the nonmagnetic-bipolaron channel).
- **Mo4 EXISTS (GaMo4S8/Se8) but is also skyrmion/multiferroic — NOT a superconductor** → the heavier-electron-count cluster lever is closed.
- **VERDICT: Nb is the optimal cluster (nonmagnetic + lightest of the nonmagnetic M); the lighter-but-magnetic V/Mo are RULED OUT.**

## Solver-projected top combo
Best lever stack = **anion(S) × cluster(Nb) × filling(sweet-spot t/Ω≈1.3)**:

| member | Ω(meV) | Tc/Ω | **Tc (K)** | nonmag | real struct |
|---|---|---|---|---|---|
| Ge:GaNb4Se8 (anchor) | 35.0 | 0.105 | 45 | ✅ | ✅ (45K onset, 1 batch) |
| **Ge:GaNb4S8** (anion, t/Ω=1) | 46.8 | 0.105 | **60** | ✅ | ✅ (S structure exists) |
| Ge:GaTa4S8 (5d cluster) | 43.8 | 0.105 | 56 | ✅ | ✅ |
| **Ge:GaNb4S8\*** (S + sweet-fill t/Ω≈1.3) | 46.8 | 0.142 | **81** | ✅ | ✅ (optimistic filling edge) |
| Ge:AlNb4S8? (Al-stiffen) | 52.4 | 0.105 | 67 | ✅ | ❌ unpublished — NO DATA |
| Ge:GaV4S8 / Ge:GaMo4S8 | 51.6 / 46.6 | — | (66/60) | ❌ | magnetic/skyrmion — RULED OUT |

## BEST FAMILY MEMBER
**Ge:GaNb4S8** — the pure-sulfide Nb-cluster member:
- **Robust prediction: Tc ≈ 60 K** (t/Ω=1 anchor point, conservative filling) — 1.34× the 45 K Se anchor, purely from Ω(Nb-S)/Ω(Nb-Se)=1.34.
- **Optimistic ceiling: Tc ≈ 81 K** IF Ge-filling lands the compact-pair sweet spot t/Ω≈1.3 (1.34×anion × 1.35×filling). This is the family's realistic best.

## FAMILY CEILING (honest, d6) — which levers are CAPPED
- **Anion CAPPED at S**: no lighter chalcogen exists in this structure; the oxide GaM4O8 (only escape past S) is UNREALIZED. Ω ceiling ≈ 47 meV (Nb-S).
- **Cluster CAPPED at Nb**: V4/Mo4 (lighter or different filling) are magnetic/skyrmion → RULED OUT; Ta is nonmagnetic but heavier (lower Ω). Nb is the optimal nonmagnetic M.
- **A-site CAPPED by non-existence**: Al-stiffen would give ~67 K but no AlM4X8 lacunar spinel is published — speculative whitespace, not bankable.
- **Filling CAPPED by pair de-compaction**: Tc/Ω plateaus at the |Δb|≈t edge (t/Ω≈1.3); doping past it breaks the compact pair. Adds at most ~1.35×.
- **Pressure CAPPED at single-digit K**: softening Ω fights raising g; real ceiling ~5.8 K. Filling, not pressure, is the high-Tc route.

→ **The single best member is Ge:GaNb4S8, ~60 K robust / ~81 K optimistic ceiling. The GaM4X8 family is FUNDAMENTALLY CAPPED below ~80–85 K** by the Nb-S bond-phonon budget (Ω≈47 meV) × the compact-pair filling edge (Tc/Ω≈0.14). No lever inside the family reaches 100 K: you'd need a lighter (oxide) anion that doesn't exist, or a lighter nonmagnetic cluster that doesn't exist.

## DEPLETION TEST
- **Best member**: Ge:GaNb4S8 (pure-sulfide Nb cluster, Ge-filling doped).
- **Predicted Tc**: ~60 K robust (t/Ω=1) → ~81 K optimistic (sweet-spot filling).
- **Family ceiling**: ~80–85 K — Nb-S Ω(~47 meV) × Tc/Ω(~0.14) is the hard wall; no in-family lever (anion/cluster/A-site/pressure/filling) crosses 100 K.
- **Deciding test**: the SAME DFPT as the success model — compute the actual Nb-S bond-phonon Ω AND the off-diagonal ∂t/∂u coupling for Ge:GaNb4S8 (dynamic-stability precheck first, d6/d_deck_always). That fixes whether the real (Ω, g, t/Ω) lands the 60 K anchor or the 81 K sweet spot — and confirms the pair stays compact + nonmagnetic at the doping that hits t/Ω≈1.3.

## VERIFY BAR (c2/d6) — met
5 lever lenses evaluated with sourced reasoning (arxiv/web: JACS 2005, PRL 2004, npj QM 2020, arXiv:2510.12452/2006.04782/2003.06358) + solver Tc per member. Best member named (Ge:GaNb4S8, 60→81 K). Family ceiling explicit (~80–85 K). Honest about capped levers (anion=S floor, no oxide; cluster=Nb, V/Mo magnetic; A-site unpublished; pressure single-digit K; filling de-compaction). NO commit, NO ARCHITECTURE.json edit, NO pod.

## Reuse / provenance
- reused[]: `../bond-bipolaron/solver.py` (validated SSH bond-bipolaron exact-diag, g5 PASS R2); `../discovery/ganb4se8_family_model.py` Ω(M,X) table + 45 K anchor + SCALE.
- provides[]: multi-lever lens projection of the GaM4X8 family Tc ceiling + best real member (Ge:GaNb4S8) + capped-lever map.
