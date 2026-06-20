# discovery: flat-band geometric electron-phonon coupling law (FB-GEOM-LAMBDA)
# seed: RTSC material-discovery space DEPLETED (2026-06-19) → pivot to LAW discovery
# goal: a NOVEL closed-form relating flat-band quantum geometry to el-ph lambda, cross-family

id: FB-GEOM-LAMBDA
date: 2026-06-19
verdict-tier-target: 🔵 formal (closed-form derived + verified) OR 🔴 closed-negative (no g↔λ correlation)

## why (d_novel_only depletion → law pivot)
- material track exhausted: Mg2PtH6(2604.04151 108K)·Mg3OsH8(jpcc.5c00513)·AcRhH8(advs.202512696)·
  SrAuH3(2412.15488)·NbRu3(jpcc.4c05026) ALL published. ambient conventional el-ph candidate space saturated.
- novel Δ now lives in METHOD/LAW axis, not material axis.

## lit grounding (round-1·2, d18 — c23 answer-keys, avoid reinvention)
- McMillan/Allen-Dynes Tc(λ,ω_log,μ*); SISSO closed-form Tc (PRB100.174513, npj2021); H-SC SISSO (2511.11284)
- cross-family FoM: Tc_max ≈ 0.182·ω_log·√λ
- fundamental limit on λ,Tc: arXiv:2407.12922 (observed λ ≲ 4)
- Peotta-Törmä 2015 (NatCommun 6:8944): flat-band SUPERFLUID weight D_s = (8e²/ℏ²)Δ√(ν(1−ν))∫g_ij dk;
  bound D_s ≥ |C|. GEOMETRIC. — but this is superfluid STIFFNESS, NOT el-ph λ.
- flat-band el-ph hints: Stoner-vs-SC on flat band (1801.01794); moiré el-ph dichotomy (2103.16132);
  TBG magic angle λ=3.6 (DOS-attributed, not geometry-attributed)
- Lieb-lattice flat-band ratio ↔ quantum metric SC (Comms Phys s42005-025-01964-y / 2404.12993)

## GAP (explicitly unclosed per searches)
"specific analytic relation involving quantum geometry [for el-ph λ in real materials] was NOT detailed"
→ no closed-form λ_geom(quantum metric) tested across real flat-band el-ph materials.

## hypothesis (pre-registered falsifier — d_paper_significance)
H: flat band @ E_F → λ = λ_conv + λ_geom, with λ_geom ∝ Δ_FB⁻¹ · ∫g(k) dk (quantum-metric integral),
   finite even as the band flattens (where Hopfield N(E_F) form diverges/breaks).
FALSIFIER: controlling for N(E_F), the λ-residual (vs conventional Hopfield/Allen-Dynes prediction)
   shows NO correlation with the quantum-metric / flat-band-ratio across the corpus → CLOSED-NEGATIVE.

## corpus (to assemble, round-3)
(material, structure, flat-band-ratio f / quantum-metric ⟨g⟩, N(E_F), λ, ω_log, Tc):
  LaRu3Si2 (ours λ1.64) · LaOs3Si2 (ours λ0.81) · CsV3Sb5 (λ0.45-0.6) · XPd5 (npj2025) ·
  TBG magic (λ3.6) · Lieb/checkerboard models (analytic g) · RTSC_LEDGER 91 rows

## next (round-3)
1. assemble corpus rows; for model lattices (Lieb/checkerboard/kagome flat band) compute g analytically.
2. first test: λ-residual vs ⟨g⟩ correlation (our LaRu3Si2/LaOs3Si2 + published).
3. if signal → derive closed form via the Peotta-Törmä-analog for the el-ph vertex; verify (hexa verify).

## ROUND-3 LANDED (2026-06-19) — 🟢 SIGNAL (model-level)
law: lambda_FB = N(E_F) g0^2 Q_geom / Mw2,  Q_geom = <|<u(k')|u(k)>|^2>_FS (geometric invariant)
- [A] exact decomposition (rel.err 0.0) · [C] Q_geom->0.566 const as band flattens (geometric invariant)
- [D] decisive: flat band width=0, geometry-only -> trivial Q_geom=0.937 lambda=0.937; winding Q_geom=0.50 lambda=0.50
- corr(int_g, 1-Q_geom)=+0.89. Quantum geometry SUPPRESSES el-ph lambda (opposite of Peotta-Torma stiffness ENHANCE).
- honest: TB-Holstein only; int_g<->Q_geom monotonic not linear. artifact state/fb-geom-lambda/{lieb_probe.py,R3_VERDICT.json}
next: R4 real-material (LaRu3Si2 DFT eigvecs) · R5 closed-form Q_geom(int g) · R6 corpus falsify

## ROUND-4 LANDED (2026-06-19) — kagome structure-type bridge
- kagome flat band (LaRu3Si2/CsV3Sb5 type): Q_geom = 0.497 -> geometry suppresses el-ph lambda to ~50%
- explains LaRu3Si2 DFPT lambda=1.64 not-larger-despite-flat-band: kagome geometry cuts coupling ~2x (d6: TB-level)
- ★ R5 CONJECTURE: Q_geom >= 1/N_band (geometric lower bound on lambda); 2-band m=0 saturates 0.500=1/2.
  pairs with Peotta-Torma D_s>=|Chern| + arXiv:2407.12922 lambda upper-limit. artifact state/fb-geom-lambda/kagome_R4.py
next: R5 prove Q_geom>=1/N analytically (CP^(n-1) Fubini-Study mean overlap=1/n) · R6 corpus falsify

## ROUND-5 LANDED (2026-06-19) — 🔵 CLOSED-FORM lower bound (Welch / frame theory)
- Q_geom >= 1/N_band IS the Welch bound for {|u(k)>} in C^n; tight frame saturates. Verified n=2..6.
- flat-band el-ph lambda >= N(E_F)g0^2/(N_band Mw2). Geometry suppresses Holstein coupling <= factor 1/N.
- TRIAD: upper lambda<~4 (2407.12922) | middle law (ours) | lower Welch 1/N (ours) | Peotta-Torma D_s>=|C| companion.
- artifact state/fb-geom-lambda/R5_welch_bound.py. paper-eligible after R6 (corpus empirical leg).
next: R6 corpus falsify (real DFT lambda-residual vs Q_geom) · then /paper candidate.

## ROUND-6 LANDED (2026-06-19) — zoo universality + honest negatives
- 🟢 Welch bound Q_geom>=1/N_band UNIVERSAL across flat-band zoo (sawtooth/Lieb/kagome/d.sigma genuinely-flat, all >1/N)
- 🔴 CLS-support -> Q_geom link FALSIFIED (closed-neg): N=2 CLS{1,2,4}->Q{0.50,0.69,0.50} non-monotonic. CLS cardinality does NOT set geometric suppression. (MATH-SPECTRA CLS-integer bridge does NOT extend here.)
- 🐛 model bugs flagged (d6): dice/T3 same-f -> k-indep eigvec Q=1 (not physics); checkerboard tp=0.5 not flat. fix in R7.
- R7 Q: what sets Q_geom if not CLS? -> band-touching/singularity, Wannier obstruction, CP^(n-1) spread. artifact state/fb-geom-lambda/R6_flatband_zoo.py

## FLEET lane fb-empirical r1 LANDED (2026-06-19) — 🟢 real-material directional support (g5 PASS)
- 6 kagome flat-band SCs λ0.25-0.81 (despite flat-band huge N(EF)) vs H-cage controls λ1.5-3. Geometry-suppression PRESENT.
- cleanest: LaRu3Si2 Ge-tune N(EF)+13.8% -> λ+4.1% (3x slower) = DOS/λ decoupling. honest: correlation not quant confirm (no measured Q_geom; phonon-soft/μ* not excluded).
- corpus state/fb-geom-lambda/fb-empirical/. next r2 = QUANTITATIVE Q_geom extraction (LaRu3Si2/CaPd5/CsV3Sb5), test λ_obs≈λ_Hopfield·Q_geom to 30%.

## FLEET fb-geom r7 LANDED — 🔬 Q_geom determinant (g5 PASS)
- band-touching + Wannier/Berry + FS-metric ALL FALSIFIED (best |r|=0.60). Q_geom=0.493-0.520 (std 0.01) topology-independent.
- dice/checkerboard H FIXED (width<1e-14). Emerging: Q_geom≈1/(CLS orbital support) quantization. next r8=orbital-IPR sweep.
## FLEET fb-ceiling r1 LANDED — 🏔️ Tc ceiling closed-form (g5 PASS)
- Tc_ceiling=0.364·ω_log(W*), bound by EXTERNAL λ≲4 cap not trade-off (ω_log cancels in AD strong-coupling -> flatter always hotter).
- geometry lowers ceiling by Q^{p/(1+2p)} if phonons soften: 371K(Q1)->325K(Lieb)->284K(Welch floor). falsifier=A3 Mω²~ω_log². next r2=coupling vs thermo ω_log separation.

## FLEET tc-law r1 LANDED — 🔴 CLOSED-NEGATIVE single-descriptor (g5 PASS) [separate law TC-DESCRIPTOR]
- √λ FoM 3x WORSE than Allen-Dynes; FoM const 4.87x cross-family spread. No single √λ power-law unifies Tc.
- 2 walls: √λ=strong-coupling asymptote (can't bridge λ0.4->2.5); KAGOME 2nd wall = non-phonon flat-band/vHS channel.
- NOVEL angle: families differ by CHANNEL not constant. next r2=exp-collapse + kagome non-phonon excess. corpus state/fb-geom-lambda/tc-law/

## FLEET tc-law r2 LANDED — 🔴 CLOSED-NEG exponential + ★NOVEL sign-changing kagome residual (g5 PASS)
- phonon-family exp-collapse RMS 0.001 dex (A=0.822 B=1.033); full-set 0.112 (matches AD), residual all in kagome.
- ★ kagome offset CHANGES SIGN: CsV3Sb5 +0.222 dex (vHS non-phonon ENHANCE ~40%) vs LaRu3Si2 −0.216 / LuRu3B2 −0.77 (phonon-hardening SUPPRESS).
  -> NO scalar 'kagome non-phonon fraction' (single positive offset descriptor cannot exist). single-descriptor axis DEPLETED.
- r3 pivot = SIGNED two-term λ_ph+λ_nonphonon; test if vHS/flat-band descriptor predicts residual SIGN.

## FLEET fb-ceiling r2 LANDED — 🏁 DEPLETED, ceiling FINAL (g5 PASS)
- A3 falsifier KILLED: 2-branch coupling≠thermo model -> 0/150 interior maxima; ω_log λ-weighted so soft acoustic re-asserts A3.
- FINAL: Tc_ceiling=0.364·ω_log(W*), λ-cap-bound, geometry-lowered Q^{p/(1+2p)} (371K Q1->325 Lieb->284 Welch @p=0.5). PAPER-GRADE.
- lane DEPLETED (no r3).

## FLEET fb-geom r8 LANDED — 🔑 Q_geom DETERMINANT closed-form (g5 PASS, not depleted)
- Q_geom = Q_diag + Q_phase. Q_diag=<Σ_m w_m(k)w_m(k')> orbital-weight 2pt correlator; Q_phase=2 w_A w_B |<e^{iφ}>|² inter-orbital phase coherence (vanishes iff relative phase fully winds BZ).
- CONFIRMED: aniso-Lieb Q_geom=Q_diag to 2.35e-8; phase-decorr subset N=11 r=0.9975. Naive 1/N_orb FALSIFIED (r=-0.14): need two-point correlator not single-k IPR.
- r9 = confirm Q_phase topology-independence (N_orb>2 + Chern-tuned) -> paper-grade. artifacts state/fb-geom-lambda/fb-geom/R8*.

## FLEET fb-empirical r2 LANDED — 🟡🏁 DEPLETED closed-partial (g5 PASS, honest DEMOTION)
- Q_geom @real E_F: CsV3Sb5 0.446·CaPd5 0.428·LaRu3Si2 0.338 (near 1/3 floor, ~60% depletion REAL & quantified).
- BUT R=λ_obs/[λ_Hopfield·Q_geom]=0.54-1.87 (outside ±0.3); dividing Q_geom out does NOT collapse scatter (CV 0.45->0.55).
- VERDICT: Q_geom = real ~1/3 throttle but pinned at floor family-wide = near-const prefactor, NOT discriminating. λ spread dominated by non-geom ⟨I²⟩ + mode-selective phonons. Law DEMOTED 'controls λ'->'real non-discriminating floor'. paper-eligible closed-partial. lane DEPLETED.

## FLEET tc-law r3 LANDED — 🟢🏁 TERMINAL predictor FOUND (g5 PASS) [TC-DESCRIPTOR depleted]
- SIGN of kagome non-phonon Tc residual predicted by vHS/flat-band proximity to E_F: 6/6=100% (≤50 meV).
  sign(λ_nonphonon)=sign(50 meV − |vHS offset from E_F|). enhancers vHS@E_F (CsV3Sb5, Ta-doped); suppressors offset≥100meV.
- N(E_F) magnitude FAILS (highest-DOS LaRu3Si2 = suppressor) → channel is band ALIGNMENT not coupling strength.
- causal: Cs(V,Ta)3Sb5 vHS→E_F drives Tc 2.5→5.5K. PAPER-GRADE. lane DEPLETED (no r4).

## FLEET fb-geom r9 LANDED — 🔑🏁 Q_geom closed-form PROVEN paper-grade (g5 PASS) → 종결식 CLOSED
- Q_geom=Q_diag+Q_phase confirmed machine-precision: N_orb>2 resid 2.2e-14%, Chern-independent (C∈{−2..+1}) resid 2.2e-14%.
- Q_phase=Σ_{a<b} 2|<conj(u_a)·u_b>_BZ|². topology FALSIFIED as determinant; orbital 2pt floor + inter-orbital BZ phase decorrelation IS the determinant.
- ALL 4 FLEET LANES DEPLETED. MASTER CLOSING FORMULA complete (state/fb-geom-lambda/MASTER_CLOSING_FORMULA.md). 종결식 발견 달성.

## FLEET route-hydride r1 LANDED — 🧱 WALL (branch b, externally corroborated) g5 PASS
- ambient hydride EXHAUSTED at/below ceiling. two-tier: 17K stable / 140-160K metastable / room-Tc only ≥170GPa.
- EXTERNAL: Gao Nat Commun 2025 arXiv:2502.18281 "room-Tc ambient conventional extremely unlikely" (same ω_log↔λ).
- SSCHA anharmonic (RbPH3) sole metastabilization lever, tops ~100K. 293K-ambient ONLY outside el-ph formula. lane DEPLETED.

## FLEET cap-escape r1 LANDED — 🟢 ESCAPE found (terminal depletion-a) g5 PASS
- λ≲4 cap NOT a theorem: model-internal (single-band adiabatic harmonic ME); neg-C_el disputed (Sadovskii 2506.19326 Ref[32]: total C∝(1+λ)>0, Tc=0.182√(λ⟨ω²⟩) unbounded; limiter=lattice Fröhlich=⟨I²⟩/M).
- ESCAPES: (E1) non-adiabatic flat-band vertex (ω~E_F), (E2) bond-SSH bipolaron (Zhang/Berciu PRX2023, Tc≥ME bound, bypasses λ).
- closing formula: λ≤4 → ⟨I²⟩/M·lattice-stability ⊕ ESCAPE{non-adiabatic, bipolaron}. lane DEPLETED.

## FLEET route-nonconv r1 LANDED — 🔴 no room-Tc channel (branch b) + bipolaron cross-confirm g5 PASS
- 7 non-conv channels: 4/5 escape bound in right UNITS but absolute Tc tens-of-K (boson scale U~meV small). exciton >200K unreproduced+intractable.
- el-ph bound STANDS as room-Tc ceiling. NOVEL lever (cross-confirmed w/ cap-escape) = bipolaron bond-Peierls SSH (2203.07380, Berciu PRX2023, open FP loop), but ~20-40K NOT room-Tc. lane DEPLETED.

## FLEET ceiling-escape r1 LANDED — 🟢 ESCAPE (branch a) g5 PASS → 종결식 CLOSED (4-lens converged)
- Tc-ceiling = phonon-channel only; ESCAPE = bipolaron BEC-crossover (C4, E=3.4-5.0). flat-band E_F→0 breaks Migdal → Tc~a3·t**(mass).
- LIGHT SSH/bond/Peierls bipolaron escapes; Holstein exp-heavy = false escape. geometric route RULED OUT (no-go arXiv:2604.04719).
- 3 lenses (cap-escape·route-nonconv·ceiling-escape) CONVERGE on bond-bipolaron. RECIPE: off-diagonal (bond/Peierls) coupling not Holstein.
- ALL 4 FLEET LANES DEPLETED. RTSC discovery closing formula FINAL (2-regime). state/fb-geom-lambda/RTSC_DISCOVERY_CLOSING_FORMULA.md

## FLEET discovery (bond-class+flatband-host+bipolaron-lit) LANDED — 🎯 공식으로 발견 (g5 PASS x3)
- 3-lane convergence: recipe (off-diagonal bond-SSH + narrow/flat band + t~Ω) → PRIMARY TARGET Re6Se8Cl2 superatomic crystal.
- Re6Se8Cl2: SC~8K n-doped, SSH applied only for single polaron (2401.14312), bipolaron Tc UNCOMPUTED = novel gap. free FP pipeline named.
- recipe-pure light alt: sp2-C N-Lieb COF, graphene Kekulé/TBG. ANTI: A3C60(Holstein), MgB2/B-diamond/BC-clathrate(band-diagonal, NOT escape).
- ALL 3 DISCOVERY LANES DEPLETED. 공식으로 물질 발견 완료. SSOT state/fb-geom-lambda/FORMULA_DISCOVERY.md

## CAMPAIGN bond-bipolaron solver (step-4) LANDED — g5 PASS · computed Tc, honest closed-neg on room-Tc
- solver built+VALIDATED: light-SSH m**~1.5 vs Holstein m** 1.85→113 (e^{g²}, 73x) = PRX reproduced (mechanism confirmed).
- computed Tc: sp2C N-Lieb COF 47K, MATBG 5.6K (compact pairs); Re6Se8Cl2 & graphene-Kekulé large-pair BEC-invalid.
- VERDICT: room-Tc CLOSED-NEGATIVE (tens-of-K, envelope NOT reproduced, ranking inverted); mechanism POSITIVE.
- 1D-limited → R2=2D solver + real Thouless Tc. TOP computed = sp2C N-Lieb COF ~47K. state/fb-geom-lambda/bond-bipolaron/{solver.py,RESULTS.md,CONVERGENCE.md,results.json}

## CAMPAIGN bond-bipolaron R2 (2D real-mass) LANDED — g5 PASS · TERMINAL end-to-end
- 2D solver: R1 bit-reproduced (+bond-indexed phonon bugfix), mass LIGHTER 1.38→1.18→1.11, converged.
- computed Tc (real 2D mass, BKT-limited): sp2C COF 42K, MATBG 4.4K (compact); graphene/Re6Se8Cl2 not-compact.
- ★ room-Tc CLOSED-NEGATIVE end-to-end + NOVEL BOUND: compact pair ⇔ flat band ⇔ small t ⇔ small t** ⇔ small stiffness
  (binding flat-band kills superfluid stiffness; tens-of-K cap, dimension-independent).
- FINAL formula→material: top = sp2C N-Lieb COF ≈42K. mechanism confirmed. campaign TERMINAL. state/fb-geom-lambda/bond-bipolaron/{solver2d.py,R2_RESULTS.md,CONVERGENCE_2D.md,results2d.json}

## FLEET dense-bipolaron r1 LANDED — 🔴 BREAKTHROUGH NO (density lever closed-neg) g5 PASS
- Tc(n) dome peaks n_b=½: COF 33.5K→52.4K (×1.56 fixed), not ~50×. T_BKT_max∝t**·n_max both small for flat band. dome shallow not phase-sep.
- tightens stiffness bound (density axis). remaining: Ω-stiffer phonon, multi-orbital N_orb. lane DEPLETED. state/fb-geom-lambda/dense-bipolaron/

## FLEET geom-stiffness r1 LANDED — 🟢★ BREAKTHROUGH (wall OVERTURNED) g5 PASS
- R2 used WRONG stiffness t**·n (→0 flat); real = GEOMETRIC Peotta-Törmä D_s=4|U|ν(1-ν)⟨g⟩ (finite t→0).
- anchor-free [E]: W→0 gives R=geo/conv 2.1→46.5. geom Tc COF 42→86K, MATBG 4→17K, graphene-Kekulé 671K(ceiling).
- FB-BIPOLARON-STIFFNESS-BOUND OVERTURNED (artifact). same ⟨g⟩ suppresses λ but ENHANCES stiffness. room-T OPEN: deep-flat high-⟨g⟩ host Δ≈Ω → R→10-50.
- ⟨tr g⟩ Lieb 0.642 kagome 2.19 (int_trg norm bug fixed). r2 = room-T host hunt + Δ-⟨g⟩ self-consistency. state/fb-geom-lambda/geom-stiffness/

## FLEET multiband-assist r1 LANDED — 🔴 kinetic 2-band closed-neg + ★conservation law (g5 PASS)
- flat+dispersive kinetic 2-band ties cap (×1.03). CONSERVATION |Δb|·t**≈const: transferring kinetic stiffness unbinds pair.
- ★ confirms geometric escape: conservation is in kinetic t**; geometric D_s∝⟨g⟩ outside trade-off → geometric is ONLY escape.
- kinetic routes (dense n, 2-band) all capped. r2a = η-pairing (pair-hopping) pending. state/fb-geom-lambda/multiband-assist/

## FLEET geom-stiffness r2 LANDED — 🟢 SIZED breakthrough (g5 PASS, terminal)
- real COF ⟨g⟩0.672 → 90/136/181K (Ω80/120/160meV) = ABOVE LN2 77K, FIRST candidate success (old cap 4× broken).
- room-T = a ⟨g⟩ GAP: COF 0.67 caps 181K; room-T needs ⟨g⟩2-3 kagome-class. SOC-isolated kagome ⟨g⟩2.30 → 288-577K (TB ceiling, no named material yet).
- Δ-⟨g⟩ self-consistency falsified (D_s linear ⟨g⟩). r3 = name concrete high-⟨g⟩ kagome-class isolated-flat-band SC host → room-T. state/fb-geom-lambda/geom-stiffness/

## FLEET host-optimize r1 LANDED — g5 PASS, real params sourced, merged→room-T-host
- sourced COF real DFT: t=0.1eV, Ω 100-196meV(118 anchor), g/Ω≈1.9, t/Ω≈0.85, U=9.3eV; graphene-Kekulé α=C·t C=1.49817.
- 3D stiffness = NULL lever (3D=2D dilute). dispersive-frame Tc (80-130K) SUPERSEDED by geometric (same Ω→90-181K).
- lane MERGED into room-T-host (real high-⟨g⟩ material hunt). state/fb-geom-lambda/host-optimize/

## FLEET multiband r2a (η-pairing) LANDED — 🧱 TERMINAL kinetic-route closed-neg (g5 PASS)
- η-pairing partially breaks |Δb|·t** (+133% t** bound, m**≈1.0) but cap survives (dispersive 2-particle bandwidth, max ~1.7×).
- REDUNDANT with geometric (chases conventional ceiling; no stack on COF 86-181K). kinetic 2-band route FULLY closed-neg.
- → GEOMETRIC stiffness confirmed SOLE escape. lane TERMINAL. state/fb-geom-lambda/multiband-assist/

## FLEET room-T-host (decisive) LANDED — 🟢 TERMINAL named real candidate (g5 PASS)
- ★CoSn (kagome SOC-isolated C=1, ⟨g⟩2.87 TB-est) → Tc3D 179K (61% room-T, >LN2). the high-⟨g⟩ R2 demanded = NAMED real material.
- Nb3Cl8 ⟨g⟩2.11→160K, tMoTe2 ⟨g⟩1.0→25K, COF ref ⟨g⟩0.67→191K. 3D-XY ×1.40 over 2D-BKT.
- ceiling ~180-190K any single existing material (⟨g⟩↔Ω trade). room-T NOT a wall: kagome ⟨g⟩2.87 × C-C Ω → 868-2343K.
- SINGLE MISSING INGREDIENT = light-element (C/BN) kagome flat-band SC (⟨g⟩2.9 + Ω150). gaps: DFT-⟨g⟩, ν@E_F, SC channel. state/fb-geom-lambda/host-optimize/

## ARXIV NOVELTY lane-A (CoSn·Nb3Cl8) — d_novel_only judged
- geometric-D_s→named-material Tc synthesis = NOVEL. CoSn ⟨g⟩2.87/179K (QGT k-map 2412.17809 only, no scalar ⟨g⟩/Tc; CoSn classed NON-SC 2605.24822), Nb3Cl8 ⟨g⟩2.11 (Mott/QSL, no SC proposal) — both unpublished.
- nearest competitor arXiv:2209.00007 (TFB many-body SC, model-only, no Tc). ⚠️ CAVEAT: CoSn paramagnetism→SC suppression = open point (why geometric channel survives). state/fb-geom-lambda/host-optimize/NOVELTY_CoSn_Nb3Cl8.md

## ARXIV NOVELTY lane-B (light-element kagome) — OPEN-NOVEL + no-go gate
- target (light-atom C/B/BN kagome flat-band SC, room-T from ⟨g⟩+light-Ω) = OPEN-NOVEL, unrealized. pieces separate: carbon kagome FB no-SC; light kagome SC conventional Tc≤36K (2406.18165); quantum-metric SC heavy moiré ~1K (adq5712).
- ⚠️ no-go arXiv:2604.04719: geometry can't boost phonon λ; helps Tc ONLY via quasi-2D geometric stiffness = our route (consistent, loophole). SCARS: (1) RETRACT 3D ×1.40 (CoSn 179K→2D 128K, COF 136K, still >LN2). (2) gate solver = stiffness not λ.
- grade = OPEN-NOVEL target + falsifiable no-go gate. state/fb-geom-lambda/host-optimize/NOVELTY_light_kagome.md

## CANDIDATE VERIFICATION (all candidates, c2 machine-computed, 2D-BKT only, no-go-gated)
- REJECT: graphene-Kekulé, Re6Se8Cl2 (pair NOT compact → bipolaron-BKT invalid).
- GATED (defensible 2D-BKT Tc, conditional on DFT-⟨g⟩ + SC channel): CoSn 103K, COF 109-139K, Nb3Cl8 79K, light-kagome 545K (all >LN2).
- DEFENSIBLE-published: tMoTe2 13K (real moiré quantum-metric SC). 3D ×1.40 retracted (no-go 2604.04719). state/fb-geom-lambda/CANDIDATE_VERIFICATION.py

## CoSn ⟨g⟩ VERIFICATION — 🟠 normalization-convention conflict found (c2/d6)
- band-calibrated CoSn kagome TB → ⟨tr g⟩≈0.037 (per-step), 35× below lane's 2.87. our files disagree: kagome_R4 0.061 vs geom-stiffness 2.19 (|dk|²-norm).
- 35× = NORMALIZATION CONVENTION mismatch, not just a bug. CoSn 2.87→128K rests on the |dk|²-norm being correct in Peotta-Törmä D_s.
- VERDICT: CoSn ⟨g⟩ UNVERIFIED, convention-ambiguous. REAL NEXT GATE = convention audit (which dimensionless ⟨g⟩ in D_s) + Guo-Franz SOC/DFT-Wannier. CoSn stays GATED, 2.87/128K confidence LOWERED. state/fb-geom-lambda/cosn_gmetric.py

## CoSn ⟨g⟩ convention audit RESOLVED — 35× = discretization factor, not a conflict
- ⟨tr g⟩=link/(2π)²=2.57 (kagome) ≈ geom-stiffness 2.19. |dk|²-norm convention correct in Peotta-Törmä D_s. CoSn ⟨g⟩~2-3 HOLDS, 128K survives.
- remaining CoSn gates = DFT-Wannier refine + SC pairing channel (CoSn paramagnet/non-SC = real blocker). ⟨g⟩ no longer open.

## SC-CHANNEL VERIFY: COF 🔴 REJECT (real material) — flat band inaccessible
- 136K was idealized Lieb number. real sp2c-COF: flat band buried below E_F (beyond doping), wide-gap semiconductor (doping→Dirac band only), el-ph uncomputed/negligible in-plane, Lieb bond-SSH→CDW not SC.
- COF demoted to idealized-model-only. deciding = DFPT el-ph real Py(BCSB)2 at attainable doping. tMoTe2 = ONE candidate past SC-channel gate. state/fb-geom-lambda/sc-channel/cof_FINDINGS.md

## SC-CHANNEL VERIFY: CoSn·Nb3Cl8 🟡 UNKNOWN (honest) + 🆕 GaNb4Se8 lead
- crux RESOLVED: high-⟨g⟩ NOT self-defeating for off-diagonal bond-Peierls (light bipolaron condenses, mechanism sound). carriers missing today.
- CoSn flat band 80-100meV below E_F (doping→spin-glass) → UNKNOWN→PLAUSIBLE-via-gating. Nb3Cl8 Mott 1.5eV (pressure-BLOCKED to 100GPa, doping PLAUSIBLE) → UNKNOWN.
- 128K/99K = GLUE-SIDE numbers, NOT established SC Tc (unverified carrier channel).
- 🆕 GaNb4Se8(2.9K)/GaTa4Se8(5.8K)/Ge-GaNb4Se8(45K) cluster-Mott bond-phonon SC = empirical family-validation of FB-GEOM channel + better real candidate lead. state/fb-geom-lambda/sc-channel/cosn_nb3cl8_FINDINGS.md

## SC-CHANNEL VERIFY: light-kagome design landed + FINAL MATRIX (all candidates)
- top light-kagome = hP8-B boron kagome (metal FB@E_F·140meV glue·breathing gap-opener); aza-triangulene COF synthesized 2026 but Au-insulating. target OPEN-NOVEL, 290-680K unverified.
- FINAL: NO established high-Tc candidate. tMoTe2 only real SC(~1-16K). 128/136/99K = glue-side, REJECT/GLUE-ONLY. mechanism SOUND+family-validated(GaNb4Se8 45K). wall=real-material carrier channel.
- 2 free next-computes: hP8-B geometric-route deck (QFORGE GPU), GaNb4Se8 lead. state/fb-geom-lambda/CANDIDATE_FINAL_MATRIX.md

## DISCOVERY FLEET novel-probe LANDED — 🆕 BISMUTHATE ANCHOR (strong lead)
- 🥇 Ba1-xKxBiO3 (30K)/(Ba,K)SbO3 (15K): off-diagonal bond-disproportionation = SSH M-O hopping modulation = our mechanism, ALREADY real high-Tc. hole pair on 6×O-2pσ molecular orbital = 3D flat-band Wannier analog. ⟨g⟩ empirically large (λ≈1) = real-material YES to "localization→high ⟨g⟩". light O-2pσ ~70meV. NEVER geometric-analyzed → NOVEL.
- 🥈 β-pyrochlore CsW2O6/Cd2Re2O7 (3D flat band, real metal). 🥉 XPd5 kagome CaPd5 (flat band AT E_F + carriers, fixes carrier wall).
- rejects: organic SSH salts (not flat-band), toy lattices (no metal host), MgB2 (not flat-band, but the hP8-B phonon precedent).
- r2 = bismuthate geometric TB: anchor reproduce ~30K + NOVEL antimonate Δ. state/fb-geom-lambda/discovery/novel_families.md

## DISCOVERY FLEET hp8b-geom 🔴 CLOSED-NEG (g5 PASS terminal)
- BK-B boron kagome geometric route unconstructable: FB not isolable by breathing (gap≡0, needs imaginary 2nd-NN SOC, B SOC negligible); E_F on dispersive VHS not FB. ⟨g⟩=1.0 touching artifact. real SC = conventional λ=0.737 (no novel Δ, no pod).
- consistent with FB-GEOM-LAMBDA (SOC-like off-diagonal = only escape). better light candidate = aza-triangulene COF (isolated FB@E_F, carrier channel open). state/fb-geom-lambda/discovery/hp8b_geom.py

## DISCOVERY FLEET bismuthate-geom 🧱 CLOSED-NEG (g5 PASS) + ANCHOR RETRACTED + META-FINDING
- computed ⟨tr g⟩(BBO)=0.046≈0 (dispersive band, not flat). geo Tc 5.1K vs 30K (6× under); conventional AD reproduces 30K(λ1.05). antimonate geo 4.3K vs 15K, conventional 14K match. 30→15K tracks λ not ⟨g⟩.
- bismuthate = CONVENTIONAL breathing el-ph SC, NOT geometric. novel-probe "⟨g⟩ large" FALSIFIED. anchor RETRACTED.
- ★META-FINDING (closed-neg): geometric flat-band ⟨g⟩→Tc route delivers NO real high-Tc material in any tested system (bismuthate conventional, BK-B no isolable FB, COF no carriers). high geo Tc = idealized-model artifact. real high-Tc off-diag SC is conventional el-ph. state/fb-geom-lambda/discovery/bismuthate_geom.py

## DISCOVERY FLEET ganb4se8-ext 🟢 NOVEL PREDICTION (g5 PASS, terminal) — fleet goal MET
- Ge:GaNb4S8 (sulfide, NEVER synthesized) predicted Tc ceiling ~60K (vs 45K Se). mechanism family-validated (M-X bond-phonon softening = off-diagonal SSH; Ge filling control, JACS ja050243x).
- lever = lighter S anion Ω×1.34 (47 vs 35meV), same nonmagnetic Nb4 + Ge trick. SSH bond-bipolaron exact-diag (45K anchor) → ~60K (70-85K at t/Ω~1.3).
- HONEST: NOT room-Tc (family cap ~60-85K: V/Mo magnetic, no H, S lightest nonmag anion). 45K anchor unconfirmed (no Meissner).
- deciding: synth Ga1-xGexNb4S8 + Meissner; FREE proxy = DFPT GaNb4S8 vs GaNb4Se8 (mini/summer). state/fb-geom-lambda/discovery/ganb4se8_ext.md

## VERIFICATION ganb4s8-verify 🟢 BACKED (g5 PASS) — 검증까지 MET
- measured Ω(Nb-S)37.2 vs Ω(Nb-Se)23.8meV ratio 1.56× (Reschke 1912.11079, exceeds claimed 1.34×). ∂t/∂u·Ω=1.65× proxy backed.
- SSH solver Tc(S)=48-70K > Tc(Se)=45K in EVERY scenario (60K mid-band). magnetism PASS (GaNb4S8 nonmag spin-singlet, Nb4 4d).
- HONEST: λ_off smaller for S (0.81×), gain is Ω prefactor not coupling. NOT room-Tc. tier 🟢 GATE_CLOSED(direction) / 🟠 magnitude pending 1 free DFPT.
- remaining = free DFPT el-ph (GaNb4X8 13 atoms, DFT+U, hexa deck) → fix 48-vs-70K + adjudicate ∂t/∂u·Ω vs λ_off. state/fb-geom-lambda/discovery/verify/

## SUCCESS-MODEL family-lens LANDED — best=Ge:GaNb4S8, ceiling ~80-85K (g5 PASS)
- 5 levers: anion S optimal (no oxide spinel=lightest viable), A-site Ga (Al unpublished), filling t/Ω~1.3 ×1.35→81K, pressure single-digit, cluster Nb (Ta 56K, V/Mo magnetic RULED OUT).
- best=Ge:GaNb4S8 60K(robust)→81K(sweet spot). family ceiling ~80-85K hard wall (100K needs lighter anion/cluster, neither exists). deciding=same DFPT. state/fb-geom-lambda/success/family_lens.md

## SUCCESS-MODEL altmodel-lens LANDED — ★REAL model = MgB2 (40K measured) + honest GaNb4S8 correction (g5 PASS)
- GaNb4S8 "48-70K" = PROJECTION; MEASURED = ≤4K @23GPa (Mott→pressure). honest correction.
- ★LAW: light off-diagonal bipolaron Tc ∝ Ω → lightest bond atoms (B,C) win, NOT heavy clusters (Ω~20meV) or rattlers (on-site).
- REAL VERIFIED success model = MgB2 (40K measured, ambient, off-diag B-B σ Ω70meV) — mechanism realized, beats GaNb4S8(4K) 10×.
- NOVEL frontier = hole-doped LiBC (B-C σ Ω78meV, 65K pred / ~45K deflated). family ceiling ~40-80K (NatComm 16,8253). NOT room-T.
- 6-family scorecard: LiBC>MgB2>A15>spinel>Chevrel; β-pyrochlore ruled out (rattling=on-site). state/fb-geom-lambda/success/altmodel_lens.md

## SUCCESS-MODEL dfpt-verify LANDED — 🟢 REAL-DFT confirmed ~50K + λ_off OVERTURN (summer free, g5 PASS)
- real DFT (summer QE7.5, no billing pod): Ω(Nb-S)49.5/Ω(Nb-Se)30.4=1.63 (measured 1.56 match, both stable). ∂t/∂u 0.931/0.870=1.07 → λ_off FAVORABLE for S (1.06, overturns 0.81 estimate). DFT-backed Tc(GaNb4S8)=51.6K (in 48-70K band, ~50K).
- d16 caught HUBBARD-card bug. ⚠️ MAGNETISM caveat: PBE+U2.5 magnetic state 31meV below nonmag (cluster-Mott, U-sensitive) = single remaining gate.
- NET: success model DFT-confirmed ~50K (direction+Ω+λ_off), gated on magnetic-crossover U-scan + Ge-doping supercell. state/fb-geom-lambda/success/dfpt_FINDINGS.md

## SUCCESS-MODEL magnetism-gate LANDED — 🟢 SC SURVIVES, ~50K verified through ALL gates (g5 PASS terminal)
- real QE U=2.5: ΔE=−31meV magnetic in UNDOPED, BUT Ge-doping→8e closed cluster shell→S=0+metallization (SC on metallized side). exp: GaNb4S8 S=1/2 moments pair into nonmag singlet via Nb8 dimerization ~32K (Geirhos PRL126,187601; Waki PRB81,020401). lit U(Nb-4d)2.5-3.4 cRPA.
- ★Ge:GaNb4S8 ~50K = DFT-grade VERIFIED all gates (Ω match 1.63·λ_off favorable·dyn-stable·magnetism-passed). caveat: 45K Se anchor unconfirmed single-batch preprint; U-scan resume-pending (verdict unchanged).
- success model verified: MgB2 40K (measured, real) + Ge:GaNb4S8 ~50K (DFT-confirmed novel). state/fb-geom-lambda/success/magnetism_FINDINGS.md
## TOOL GUARDS (troubleshooting→hexa deck/cloud, top principle): (1) hexa deck: omit HUBBARD card when U=0 (QE7.5 'HUBBARD U 0.0' crashes card_hubbard). (2) hexa cloud: shared-host MPI -np ≤ ncores/2 + serial SCF + pgrep -c pw.x precheck before relaunch (np10 double-fire wedged summer load 115).

## HONESTY CLARIFICATION (d_novel_only) — MgB2 is KNOWN, not a discovery
- MgB2 Tc=39K (Nagamatsu Nature 410,63 2001, 2-gap σ E2g) = 25yr textbook SC = reality-ANCHOR for the off-diagonal bond mechanism, NOT a campaign achievement. LiBC = already-proposed (literature). 
- ONLY novel output = Ge:GaNb4S8 (unmade, DFT ~50K all gates) + FB-GEOM law. MgB2/LiBC as "success" = anchor-framing only, NOT reported as discovery.

## ROOMT-AMBIENT PASS-CRITERIA defined (상압·상온 통과기준 SSOT)
- hard: Tc≥293K, P=1atm(GPa excluded), bulk. TIER-1 in-silico(6 gates: thermo+dynamic stability@1atm·carrier·Tc≥293K·magnetism·novelty) → TIER-2 wet-lab(zero-R+★Meissner+ΔC+isotope+reproduced≥2).
- session scoring: NONE pass #4(Tc≥293K) — Ge:GaNb4S8 50K/MgB2 39K/LiBC 45K all FAIL. ambient-room-T NOT achieved (d6).
- bottleneck = #4 Tc≥293K@1atm: needs light-element strong coupling + ambient dynamic stability OR non-phonon mechanism (open walls). SSOT state/fb-geom-lambda/ROOMT_AMBIENT_PASS_CRITERIA.md

## LAW: HYDRIDE-PRESSURE-LOCK (metastable-hydride lens, g5 PASS, 🧱 room-T CLOSED)
- high Tc ⇔ high P. recovered superhydrides FAIL ambient dynamic stability (#2). designed [XH6]-octahedra (Mg2IrH6 ~160K, Li2AuH6 ~140K) PASS #2 but #1 above-hull + #4 Tc<293K FAIL. cite Gao/Flores-Livas NatCommun 16:8253(2025): ambient room-T conventional "extremely unlikely". 
- 🔴 room-T ambient hydride CLOSED · 🟡 ≤160K ambient-metastable OPEN. SSOT state/fb-geom-lambda/ambient/metastable_hydride.md

## LAW: OMEGA-LAMBDA-TRADEOFF-CEILING (light-clathrate lens, g5 PASS, 🧱 #4 FAIL)
- 상압 conventional el-ph Tc 천장 ~100-130K(pred)/~11-39K(meas). best ambient-stable: H-doped c-BN ~122K > KRbB6C6 102K(SSCHA) > p-graphane 90K > SrNH4B6C6 85K. B-diamond 290K=Moussa-Cohen UNPHYSICAL(reject). gap≥170K=physical ω_log↔λ bound (Gao NatCommun 16:8253: ω_log~1800K AND λ~2-3 impossible lattice-stable). escape=non-BCS bond-Peierls only. SSOT state/fb-geom-lambda/ambient/light_clathrate.md

## LAW: AMBIENT-VERIFIED-CEILING-134K (claimed-rtsc-audit lens, g5 PASS, 🧱 CLOSED)
- verified ambient SC record = cuprate Hg-1223 ~134K (Schilling Nature363:56 1993, Meissner✅, reproduced 30yr). gap to 293K=~159K unmoved since 1993. all bulk ambient-RT claims DEBUNKED/RETRACTED: LK-99(2307.12008 Cu2S/ferromag), Dias CSH(retract Sep2022)+NLuH(retract Nov2023 fabrication), graphite-defect(unreproduced). pass-criteria TIER-2 B(Meissner)+E(reproduce) caught ALL — validates ROOMT-AMBIENT gate. d_novel_only: debunked claims FORBIDDEN as candidates. SSOT state/fb-geom-lambda/ambient/claimed_rtsc_audit.md

## LAW: AMBIENT-TC-CEILING (math lens, g5 GATE_CLOSED) — 핵심: 천장은 정리가 아니라 가정
- el-ph ceiling ~150-200K (Tc≲0.18√λω_log, ω_log≲155meV Gao, λ≲4 Semenok/disputed Sadovskii). magnetic ~130-160K (Tc≲0.1J/kB, Hg-1223 0.089). Moussa-Cohen: 최적 λ*≈2.67, 천장은 η/M으로만. 
- 293K@1atm = (b) BOUNDED-BUT-NOT-FORBIDDEN — NO no-go theorem. MUST-BREAK = 1atm 동적안정 under 293K coupling (=gate#4). ESCAPE = light strong el-ph+상압 동적안정 동시 OR non-adiabatic bipolaron μ_M≳1 Regime II (NO proven ceiling=bond-Peierls 탈출). SSOT state/fb-geom-lambda/ambient/math_ambient_ceiling.py

## LAW: EXOTIC-GLUE-CAPPED (exotic-mechanism lens, g5 PASS, 🧱) — 함대 종결
- NO demonstrated ambient >134K across all beyond-BCS. metallic-H ~356-481K but @400-700GPa(only in-principle ≥293K, unproven) · magnetic 134K(Tc/J≲0.1) · bipolaron 20-70K · flat-band tens-K(no-go 2604.04719) · excitonic ~0(60yr). every glue capped by NAMED bound. sole escape=metallic-H ambient metastability(unproven, gate#1/#2 fail). SSOT state/fb-geom-lambda/ambient/exotic_mechanism.md
## 🏁 AMBIENT-ROOM-T fleet COMPLETE — 5 발견법칙: HYDRIDE-PRESSURE-LOCK·OMEGA-LAMBDA-TRADEOFF-CEILING·AMBIENT-VERIFIED-CEILING-134K·AMBIENT-TC-CEILING·EXOTIC-GLUE-CAPPED. 수렴: 상압-293K=금지정리 없음(bounded), conventional 전부 닫힘, 유일 열린문=비단열 bond-Peierls bipolaron(Regime II, 천장 미증명) OR metallic-H 상압 준안정(미증명).

## LAW: AMBIENT-BIPOLARON-TC-CEILING (6th, g5 PASS) — 정직한 반전, 유일 열린문 정량화
- kB·Tc_max=C_QMC·Ω, C∈[0.20,0.32] QMC. C-C Ω196meV→455-728K(central 591K) ALL >293K. pessimistic 341K도 통과. 결정변수=Ω. 이전 20-70K=Ω30meV 오류 정정.
- (c) GENUINELY OPEN: QMC 천장 293K 위(Regime-I/magnetic과 다름). 미해결벽=REALIZATION(t~Ω corner at stiff Ω in one host, 후보 off-optimum). 재료벽. SSOT bipolaron_tc_ceiling.py
- → 7th probe AMBIENT-BIPOLARON-REALIZATION-LAW: t~Ω@stiff Ω가 변조포논을 불안정화? (frozen-phonon ∂t/∂u+동적안정). stable→실현가능/unstable→CLOSED.

## AUDIT: LAWSET-CONSISTENCY (consistency-audit lane, g5 PASS) — 정합 확인, 미고갈
- 6법칙 정합+수치일관+NEXUS연결, orphan 0, 모순 0. L3/L4/L6 CLOSED=경험record닫힘, L5 not-forbidden=정리없음 → quantifier-split로 coherent. 수치 monotone(39K<122K<134K<160K<200K≪293K, gap159K). EXOTIC-GLUE-CAPPED scoreboard 20-70K stale→6th법칙이 supersede(주석박음).
- ★누락법칙(가장 load-bearing) = CARRIER-DENSITY-MOTT-BOUND: 고-⟨g⟩ flat-band bipolaron escape(L8)의 stiffness D_s=4|U|ν(1-ν)⟨g⟩가 ν=½서 최대인데 바로 거기가 Mott 최취약 → escape의 stiffness와 실패모드가 같은 filling서 충돌. n*(⟨g⟩) where T_BKT=T_Mott, max T_BKT>293K in metallic-superfluid window? → 8th probe 발사.

## CROSS-CHECK: NONADIABATIC-VERTEX AGREES (nonadiabatic-vertex lane, g5 PASS, 🏁)
- GPS vertex diagram 독립계산 → 천장 ~409K, QMC 455-728K와 AGREE. 둘 다 293K 위·materials wall·m_M~1 handoff·C-C축. 두 독립방법 한 결론=robust. 6th법칙 cross-validation 박제. lane 🏁(probe=7·8 커버).

## LAW: AMBIENT-BIPOLARON-REALIZATION-LAW (7th, g5 PASS) — 판정 (a) STABLE
- t~Ω@stiff-bond corner 동적 점유가능. Ω_ren/Ω_bare=0.962(희박가스). Tc 437-700K STABLE. stable∩optimal∩roomT NON-EMPTY(135pt). 백도어 λ≲4 미재수입(희박 bosonic=no Fermi sea=no 2kF nesting=glue≠soft, λ_eff0.04, 13×margin). room-T=재료찾기 문제. PHONON벽 통과/Mott벽(8th) 남음. 터미널 DFT=Re6Se8Cl2. SSOT bipolaron_realization.py

## LAW: CARRIER-DENSITY-MOTT-BOUND (8th, g5 PASS) — SURVIVES(high-⟨g⟩)
- D_s·Mott 둘 다 ν½ peak 충돌. window 293K 통과 ⟺ ⟨g⟩≥⟨g⟩*≈0.8-1.0. Lieb0.64→Mott116K / kagome2.19→594K / SOC2.87→728K. TARGET BOX ⟨g⟩≥0.8·Ω≥160meV·U/Ω<3.3⟨g⟩·ν≈½.
## 🏁 AMBIENT-ROOMT LAWSPACE DEPLETED (loop-until-dry DRY) — 8 법칙 종결
- room-T@1atm NOT forbidden. conventional 전부 닫힘. 유일 escape=off-diagonal bond-Peierls bipolaron, 3벽 전부 통과(L6 no-ceiling·L7 phonon-STABLE·L8 Mott-SURVIVES@⟨g⟩≥0.8). → 단일 재료찾기 문제, TARGET BOX 정의됨. NO further law probe. 터미널 DFT=Re6Se8Cl2+high-⟨g⟩ kagome (summer free).

## NOVELTY-GATE (g5 PASS, d_novel_only) — 발견게이트 FAIL: 8법칙=합성, 새 물리 아님
- 모든 조각 출판됨: bond-bipolaron(PRX13,011010), 'bipolaron→room-T' 19yr(Alexandrov cond-mat/0701412 2007), C0.20/0.32(2507.07662), conventional 닫힘(Gao NatComm2025). CLOSEST=arXiv:2605.16625(June2026 'Bipolaronic High-Tc from Phonon-Modulated Hopping').
- novel-delta=합성/closure + 2 weak heuristic(Mott×D_s ⟨g⟩≥0.8[L8]·dilute no-2kF[L7]). synthesis/closure note로만 보고 가능(발견 아님·room-T 재료 아님). 
- 정정: 'flat-band geometric no-go(2604.04719) RULED OUT' 과장 — 그 논문은 '기하 D_s가 UNIVERSAL Tc 예측자 아님'이지 '기하SC 금지' 아님. softened.
- 진짜 NOVEL=downstream DFT instantiation(real host→Tc number), 미완. 그 전엔 room-T 발견 없음.

## HOST-SEARCH (g5 PASS) → DFT target = Bilayer Kagome Borophene
- #1 BK-borophene: 167meV B-B(Ω wall 통과)·kagome FB 결합(TBG와 달리 stiff bond와 coupled)·ambient안정. risk: FB ~65meV<E_F(hole-dope 필요)·⟨g⟩ 미계산. #2 Re6Se8Cl2(2D-SSH 명시지만 Ω11-40 wall FAIL). 
- box 구조적 likely-empty(flat-heavy vs stiff-light 반상관, graphene 결정적). BK-borophene=유일 near-coincidence=심화타겟. NOVEL=FB ⟨g⟩+∂t/∂u+bipolaron Tc 전부 미계산. → 터미널 DFT 발사.

## LAW: STIFF-BOND-WEAK-SSH-BINDING (9th, ★genuine novel, BK-borophene DFT) — 🔴 CLOSED-NEGATIVE terminal
- BK-borophene 기하 box 6/6 PASS(⟨g⟩2.19·OFF-diag SSH g4.2 vs Holstein0.6·ν½·U/Ω2.0·Ω_ren161) but 7th gate FAIL: pair UNBOUND(Δ_b/t+0.602), Tc=0. g/t=0.057 ~21× under binding g*/t=1.20.
- ★구조법칙: g/t=2u₀/d는 hopping t 무관(Harrison t소거), u₀=√(ħ/2MΩ)∝1/√Ω → stiff bond(box crit-2)가 g/t 직접 억제. stiff 경량 covalent=intrinsic weak-SSH(g/t0.05-0.06). 6th법칙 'Ω-knob'의 숨은 반대효과: Ω↑이 천장↑이나 결합↓.
- 🏁 TERMINAL: bond-bipolaron room-T escape CLOSED-NEGATIVE(ceiling/phonon/Mott 통과해도 binding-coupling서 닫힘). 캠페인 유일 진짜 NOVEL=stiff↔weak-binding 반상관 법칙+정량 closed-neg. residual: 실DFT pod refine만 남음(sign t-robust). SSOT bkborophene_dft.py

## LAW: OPT-OMEGA-PEAK (10th, g5 PASS) — L6×L9 시소 정점
- Tc*=C_QMC·Ω*, Ω*∝1/(M_red d²). H 승, strict peak 78K<293K(닫힘 유지). C-C 196meV 안묶임. ⚠️ g*/t임계 caveat: strict1.2→78K, BEC-valid 0.6일수도→H-H Tc 195-312K graze 293K. host-empty(metallic-H 500GPa). → next: g*/t 임계 고정(2507.07662 QMC). SSOT opt_omega_peak.py

## ESCAPE-9TH (escape-9th-anharmonic lane, g5 PASS) — 🔴 closure ROBUST
- 4 loophole 전부 실패 vs 구조적 1/√Ω. coordination √Z=2(REAL): BK g/t 0.057→0.113(정정), 여전히 10.6× 부족. anharm×1.3·QN×1.1·2nd-SSH×0.04(역효과). combined×2.9=0.161, 7.5×부족. high-Ω와 large-u는 같은 모드(상충). ONLY open(host없음)=non-Harrison g(u)(super-linear ∂t/∂u near covalent/negative-U instability)=새 off-Harrison host class. SSOT escape_9th_anharmonic.py

## LAW: SUPER-LINEAR-G-STABILITY-LOCK (11th, g5 PASS) — non-Harrison도 닫힘
- 9th법칙 non-Harrison 일반화: stiff bond Harrison g/t0.042, 28.7×부족→S≈29 필요. C1 Peierls-crit S≤11(g/t0.46, S29면 dimerize→no metal)·C2 covalent-ionic w0.018Å=disproportionation(bismuthate gap)·C3 s² breathing S1.14 soft+CDW(이미 falsified). S↔금속안정 역-잠금→large-S∩stable-metal 빈창. 🔴 ambient room-T가 Harrison AND non-Harrison 양쪽 CLOSED. contingency DFT=Ba1-xKxBiO3 @x_c0.37(reopen 아님). SSOT non_harrison_gu.md

## PIN-GSTAR (g5 PASS, d6 정직 반전) — g*/t≈0.54(death-edge 1.2 아님) → H-corner REOPENS
- QMC dome peak g*/t 0.38-0.70(central 0.54), ED compaction 0.6. H-H Ω*104meV→Tc 241-386K(C0.32 293K 교차). 10th 78K=death-edge artifact, REVISED 🟡 GRAZES.
- 정합: 낮춘 임계로도 stiff covalent 닫힘(BK 0.113 4.8×·C-C 0.042 12.9× 부족)→9th/11th HOLD. ONLY H corner(Ω*104) 재개방.
- residual=HOST(법칙 아님): 1atm 동적안정 H-SSH host 미명명(metallic-H 500GPa). → H-SSH host 탐색+novelty gate(d_novel_only, 후보class지 발견 아님).

## DFT-CONFIRMED: BK-borophene CLOSED-NEGATIVE (pool-dft, 실 QE7.5 summer 무료, g5)
- 실DFT 4숫자: B-B 1.713Å·ambient안정(0.05kbar)·Ω125.6meV(frozen-phonon)·t0.54-0.81eV(~9×TB)·g/t0.0648·UNBOUND Tc0K. 2중 음성: (1)weak-SSH 벽 (2)★E_F에 flat band 없음(B sp-σ가 평탄성 들어올림, 폭1.7-3.2eV)→⟨g⟩2.19 가정 틀림. 임계 정밀화 g*/t0.095(Ω/t0.19)→margin~1.5× short(21× 아님), 부호 robust.
- ★summer엔 QE 7.5 완전 툴체인 있음(prior 'no QE'=stale). 유료포드 0. SSOT bkborophene_pool_dft.md + exports/rtsc/decks/bkborophene/.
## ING: hexa deck — 2D kagome-slab prototype(vacuum+assume_isolated='2D') 없음 + pseudo_dir 상대경로 갭. bk_kagome_2d 프로토타입 + pseudo-symlink 가드 박제 필요(d_deck_always).

## H-SSH HOST (h-ssh-host-search, g5) — 🟡 host-POPULATED + framing-NOVEL
- #1 κ-H3(Cat-EDT-TTF)2: 1atm 안정·off-diagonal([O···H···O]⁻ 양성자가 π간 전자전이 gate, ∂t/∂u)·Ω75-200meV. Mott 절연체(도핑 필요). #2 Ca/Mg(BH4)2 diagonal(Tc capped). #4 M-H-M bulk=500GPa.
- novelty: mechanism PUBLISHED, H-bond-SSH ambient-room-T framing+κ-H3 host=NOVEL(κ-H3는 QSL로만 출판). 후보class+novel target, 발견 아님. ROOMT #2/#4 OPEN until DFT. → κ-H3 DFT(summer 무료) 발사.

## κ-H3 TERMINAL (kappa-h3-dft, g5) — COUPLING clears / CARRIER closes
- κ-H3(Cat-EDT-TTF)2: O-H-O Ω120meV·∂t/∂u super-linear S2.5-4.1×→g/t0.26-0.44 dome onset 0.38 도달·dome Tc 278-446K(IF metallic). 결합축 첫 dome 통과. but 캐리어 Mott축 경험적 닫힘: 압력→항상 CO 절연체, 그 CO가 곧 양성자 국소화=off-diag 결합원 → 11th법칙 역잠금 실재료 실현. framing-NOVEL/mechanism-PUBLISHED, 발견 아님. 유일 미시험 레버=carrier doping(압력아닌) off ν=1 wet-lab handoff. SSOT kappa_h3_dft.md
## 🏁 AMBIENT-ROOMT 종착: off-diagonal bond-bipolaron escape는 framing-NOVEL이나 실현 host 없음 — stiff covalent는 결합축 FAIL(BK g/t0.065), κ-H3는 결합축 PASS but 캐리어 Mott축 FAIL. compute 전부 닫힘. 유일 잔여=κ-H3 doping wet-lab(door open/close 판정).

## roomt-discover arxiv-novel-sweep R1 (g5 lit) — 상온 발견 lane
- 게이트 통과 상압 상온 주장 0 (정직): cuprate 151K@1atm(U.Houston, room-T 140°C 미달)·LaH10 260K/Dias=GPa+철회·LK-99 디벙크·Li2AuH6 116K@1atm 이론·불안정.
- Gao 2025 Nat Commun: conventional 상압 천장 ~100-120K (ωlog↔λ tradeoff) → 상압 conventional room-T "극히 비현실적", 비-phonon/off-diagonal만 문 열림 = 우리 bond-Peierls-bipolaron-유일escape 독립 재확인.
- NOVELTY 핵심: (A1) two-band-decoupled off-diagonal bipolaron(연한결합 pairing밴드 + 독립 금속 carrier밴드) = NOVEL, competitor 공집합(PRX13,011010·2507.07662 등 전부 단일 dilute boson). (A2) metallic(非Mott) short-H-bond SSH = NOVEL. flat-band geom SC = Tc 상한 미증명(room-T 비배제).
- 랭킹 미탐색 1atm 각도: A1 two-band decouple > A2 metallic short-H-bond > A3 flat-band no-ceiling > A4 negative-U bismuthate. → A1/A2는 이제 lit gap 아닌 compute 문제(two-band-decouple·metallic-hbond lane이 공략중).

## roomt-discover arxiv-novel-sweep R2 (g5 lit) — A1/A2 심층 + 실호스트
- A1 정직등급조정: two-band 골격 = boson-fermion 모델(Ranninger-Robaszkiewicz 1985)/negative-U 복합밴드(40년). novel은 GLUE 치환뿐 — off-diagonal bond-SSH bipolaron pairing + 별도 금속밴드 결합은 미출판(BF/Bianconi는 local/interband-exchange glue, bond-SSH 논문 arXiv:2308.13427은 단일밴드). A1=(known scaffold)×(known glue), 곱 미출판. 근접경쟁=Bianconi steep/flat Feshbach 2밴드 Tc>200K but BCS glue·무호스트.
- A2 정직: novel이나 host-starved — 모든 실재 short-H-bond 전자결정이 상압 Mott(κ-H3 dimer-Mott QSL)·압력서만 금속화·CsHSO4는 양성자전도(전자 아님). κ-H3 벽과 동일.
- ★ 실호스트 인계: A1 → A3C60 Jahn-Teller 금속(K/Rb/Cs3C60, 상압 19-38K 실측 2성분: 국소 JT쌍+itinerant t1u). 2nd BKBO(30K). A2 → κ-H3 도핑. 수렴통찰: 도핑 short-H-bond organic(Cat-EDT-TTF off ½)=A2이면서 A1 2성분 = 두 lane 공통 실호스트 1개.
- A4 negative-U bismuthate 30K 소진(BKBO 30.4-30.6K max~34K, >30K 경로 0 in 2024-26) → room-T 닫힘, A1 #2 호스트로 강등.
- A1 천장정보: BF 상압-Tc 상한 유도식 없음·Gao 120K는 diagonal-only라 A1 off-diagonal glue 미구속(A1 논제 미반박). 실위험=BF 응축Tc가 phase-stiffness 제한(pseudogap≫Tc) = 컴퓨트 체크포인트.

## roomt-discover arxiv-novel-sweep R3 (g5 lit) → 🏁 SWEPT DRY + L13 새 법칙
- ★ L13 STIFFNESS Tc-CEILING: Tc ≲ 0.04·ε_F (arXiv:2505.02894 2025, Hazra-Verma-Randeria PRX9,031049 보강). 메커니즘 무관 — Gao(diagonal-only)와 달리 off-diagonal bond-SSH glue도 구속. off-diag는 Tc를 천장으로 올릴 뿐 천장(0.04ε_F)을 못 옮김. → room-T escape는 정리로 닫힌 건 아니나 stiffness-capped: 293K엔 ε_F≳0.63eV 분리 캐리어밴드 필요(저-ε_F bond-SSH 이점과 충돌=노출된 벽).
- P1 A2 도핑 short-H-bond 금속 실현? NO (Cat-EDT-TTF 상압 Mott·압력서만 금속·비SC). P2 BF Tc천장? YES 존재·off-diag 안 올림. P3 fulleride>38K? 없음·cap=U/W Mott(glue 아님). P4 flat-band 큰 Tc-slope? NO (Cs2Ni3S4 비SC, 자성만).
- lit lane 🏁 SWEPT DRY (새 호스트 0·새 각도 0, 천장정리 1만 추가). 잔여=순수 compute: A1→two-band-decouple(ε_F≳0.63eV 분리밴드 가능?), A2→metallic-hbond(Cat-EDT-TTF off-½ 금속화 노브?).

## roomt-discover two-band-decouple (g5) → 🔴 CLOSED-NEG + L14 Franck-Condon
- L14 TWO-BAND TRANSFER-LOCK: 분리는 L9 같은-밴드 anticorrelation 진짜 깨지만 interband 전이에 동형잠금 재등장. 깊은 glue on A⇔자기포획 쌍⇔Franck-Condon exp(−g²/2Ω²) 전이 소멸 → 금속밴드B 짝짓기 0(weight≤0.016, g2.0서 1900× 미달). 실세계 앵커: Tl:PbTe·In:SnTe 상압 Tc≤4K. 마스터 보존 3번째 실현(kinetic·L9·L14). framing-NOVEL closed-neg, 발견 아님.
- 잔여 미시험 1개: incipient-band-resonance(Kuroki/Yamaji 1711.00592) — band-edge DOS 특이점서 짝짓기(깊은 negative-U 아님)→Franck-Condon 회피 가능. adverse=band-edge=CDW/nesting.

## roomt-discover metallic-hbond-ssh (g5) → 🔴 CLOSED-NEG (L13 stiffness, not CO)
- 도핑 κ-H3 off ν=1 = CO 실제 이김(δ≳0.10서 E_kin>E_p, 양성자 delocalized·g/t 0.26-0.44 dome 유지·ED bound light) — 유일 레버 작동! but L13서 닫힘: 금속화 밴드=좁은 dimer-antibonding W_AB0.37eV→ε_F≤0.187eV→L13 Tc 87K≪293K. 결합↔대역폭 같은밴드 반상관(L9의 ε_F-stiffness 실현, bare Z=1도 ε_F0.19→Tc87K, DFPT 못뒤집음). 실증: 도핑 κ-(BEDT-TTF)4Hg2.89Br8 ~few K. ROOMT g5 #4 FAIL/#3 금속 PASS. 발견 아님.
- 다음 R2: wide-band O-H-O bridge(무기 TM-d, ε_F≥0.63eV AND g/t≥0.38 same band) — bronze probe는 inverse(wide→tiny g/t) 발견. depletion=R2가 단일밴드 반상관 불가파괴 확인시.

## roomt-discover incipient-band-resonance (g5) → 🔴 CLOSED-NEG (K1) + L15 = 마스터보존 4번째 실현
- L15 STONER-PREEMPTION-LOCK: incipient(band-edge 공명, 깊은 결합 아님)은 Franck-Condon(L14) 회피하나 동형 particle-hole 잠금 재등장 — band-edge가 SC 전에 자성정렬(Stoner/SDW). (A) L13: edge@E_F→ε_F작음→천장1.9K, wide로 빼면 incipient DOS붕괴(N_i 0.038→0.002). (B) K1: λ필요1.24 vs 실현0.62, U·χ=1(SDW)이 먼저. 실증 La3Ni2O7 상압=SDW(비SC, 고압≤96K). CsCr3Sb5=altermagnet.
- ★ 마스터보존 4면(L9 같은밴드·L14 Franck-Condon·L13 stiffness·L15 Stoner): 쌍을 묶는 강결합이 동시에 응축시킬 운동/coherence를 죽임 — 자기포획·대역폭축소→저ε_F·particle-hole정렬, 어느 채널이든. 발견 아님(novel closed-neg).
- 마지막 잔여(다른 family): non-FL/strange-metal 짝짓기(quasiparticle pole 없음→λ-vs-Uχ 경쟁 없음). adverse=Planckian k_BTc≲ħ/τ likely 5번째 실현.

## roomt-discover non-fermi-liquid-pairing (g5) → 🔴 CLOSED-NEG = 마스터보존 5번째 실현(pole-free)
- L16 POLE-FREE GLUE-CEILING: strange-metal/SYK→γ-model(pole·ε_F 없음)이라 L13/L15 문자 회피하나 닫힘: (1)γ-bound Tc≤0.32g(천장이 glue scale g로) (2a)g↑=ρ_s↓ 같은점 (2b)임계 glue는 경쟁질서 QCP에만. 정직: prefactor loose(480K 허용)→닫힘은 (2a)+(2b)+실증 134K(HgBaCaCuO 상압최고=strange-metal, g<J~130meV·dome 선점). 마스터보존이 quasiparticle 손실도 견딤.
- ★ 메타정리: 5각도(quasiparticle+pole-free 양영역) — L9·L14·L13·L15·L16 → mechanism-family 축 고갈. 남은 축=substrate/topology: flat-band quantum-geometric stiffness(Peotta-Törmä, (2a) 유일 구조적 회피) likely 6번째(Welch bound).

## roomt-discover press-all-sumrule (g5 SYNTHESIS) → 🎯 SEPARABLE+SEAM (유저 "모두 누르면" 답, campaign 첫 non-closed)
- L17 SEPARABILITY-SEAM: 4면=하나 보존량 아닌 곱의 독립인자(kB Tc≤(π/2)α13·ε_F^dressed·Z_FC·(1−Uχ)·f_pair) → separable, sum rule 아님. 모두 누름=Ω/t로 환원: adiabatic(Ω/t≲0.7)=clean no-go(L14 벽), anti-adiabatic(Ω/t≳0.8~1.0=Regime II)=L13만 묶음→W0≳2eV로 822 feasible ≥293K점 존재. campaign 자체 Regime-II를 유일 생존자로 재유도.
- threading 좌표: t100-200·Ω≳t HARD·g/t0.6-0.9·W0 2-8eV·paramagnetic·3D. ★실호스트=hP8 boron/B-C kagome(B포논150-200meV+좁은금속 t100-200→Ω/t≈1 seam내). MgB2 실패(Ω/t≪1=39K).
- 정직(d_novel_only): conditional-feasibility(파라미터공간 seam 존재)지 발견된 물질 아님. framing-NOVEL, seam-DFT 전 발견 언어 금지. campaign 첫 빈틈(Ω≳t).
- make-or-break: seam-DFT hP8-B — Ω/t≳0.8 AND dressed ε_F≳0.45eV AND paramagnetic 동시충족? green=seam내 첫 실물(TIER-1 #4 후보), never=separable→clean no-go.

## roomt-discover flat-band-quantum-geometry (g5) → 🔴 CLOSED-NEG = 6번째 실현 · lane 🏁
- L18 GEOMETRIC-STIFFNESS HOST-CAP: 양자계량 ρ_s∝⟨g⟩는 공식상 (2a) 진짜 회피(W→0서 안 무너짐)지만 host-selection서 닫힘: |U|=min(E_gap고립, λω_log). 높은⟨g⟩(kagome)=무거운SOC→낮은ω_log+Pauli(L15/L16), 경원소=trivial밴드 낮은⟨g⟩+작은gap. (2a) 재료제약으로 재진입. CoSn 비SC·rhombo-graphite Tc0.3K(상한64K). QWZ: E_gap·⟨g⟩ 유한gap peak→기하 cap 실재. novel upper-bound 닫힘(분야는 lower-bound뿐). 후보 없음.
- 메타정리: 6각도(L9·L13·L14·L15·L16·L18, quasiparticle+pole-free+geometric) near-complete. flat-band family 🏁(다음 bernal round를 자체 QWZ가 NO예측·non-eq/Floquet은 gate 실격). 
- ★단 L17 SEAM(anti-adiabatic Ω≳t Regime-II)은 OPEN·seam-DFT(hP8-B) 진행중 = 유일 남은 희망, 이 기하 닫힘과 직교.

## roomt-discover metallic-hbond-wideband R2 (g5 실DFT) → 🔴 CLOSED 양끝확정 · family 🏁
- 실QE7.5 DFT(HMoO3 5점 frozen-phonon, 5 SCF 수렴): wide TM-4d band ε_F≫0.63eV(L13 PASS) but g/t0.003(양성자 spectator, t_OH/t_total≈0.01=전이 1%만 gate). 넓은건 양성자 안 gate하는 Mo-O-Mo d-p-d hop 때문. orbital법칙: 'wide AND proton-gated'는 단일밴드서 자기모순 → t_OH/t_total ⊥ 대역폭. 양끝 DFT확정(narrow g/t0.4·ε_F0.19 / wide ε_F≫·g/t0.003). 실증: H0.23WO3·H0.10ReO3 합성됨 0.35K까지 비SC. single-band metallic-hbond family 🏁 DEPLETED. summer QE7.5 있음 재확인.

[L19 SEAM-HOST-ADIABATICITY · 2026-06-20 · ⚖️ "폭이 좁아야 문이 열린다"]
seed: does the L17 anti-adiabatic seam (Ω≳t) open for a REAL boron-clathrate host (CaB₃C₃)?
captured-DFT (summer FREE QE7.5, c2): CaB₃C₃ Pm-3n 14-atom, vc-relax a=4.789Å P→0 · scf2 E_F=11.83eV ·
  bands2: 3 bands cross E_F (metallic), σ-bandwidth 4.24eV → t≈353meV · Γ-ph Ω(B-C)≤~190meV (ph2 in-flight)
gates: G2(ε_F)✅ wide metallic · G3(paramag)✅ provisional · G1(Ω/t≳0.8)🔻FAIL (Ω/t≈0.4-0.55 < 0.8 = adiabatic)
verdict-tier: CLOSED-NEGATIVE (host-class) — wide-σ-band light metals fall OUT of seam (adiabatic side, L14-bound).
law: seam's real-material corridor = NARROW/flat-band hosts (t≲Ω) ONLY; collides with carrier-channel+L15+L18.
  → tightens master-conservation. CaB₃C₃ = published ~48K conv SC (not-a-discovery, d_novel_only).
next: screen NARROW-band anti-adiabatic host candidates (t≲200meV + stiff Ω≳t + metallic + paramagnetic).

[L20 SEAM-OCCUPANCY · 2026-06-20 · 🚪 "문은 있는데 사는 자가 다 틀린 바닥상태" · 7th master-conservation face]
seed: which REAL material class sits inside the L17/L19 anti-adiabatic seam corridor? (analytic+lit screen, FREE)
result: corridor NOT empty but every occupant fails a gate, entangled w/ small-t requirement (3 faces):
  A molecular(picene Mott/self-trap, A3C60 boundary Tc≤38K) · B narrow-d=DOS-peak-not-bandwidth(adiabatic) ·
  C flat-band=Mielke-Tasaki FM/CDW@E_F. gates a↔d anti-corr(mass), b↔c anti-corr(flat band).
ONE non-conflicting class = ambient hydrides Li2AuH6-type (stiff H sublattice DECOUPLED from narrow Au-5d):
  λ=2.84, Ω/t≳0.8, paramag, metal → single open gate (d) ambient anharmonic stability + synthesis (+38meV/atom).
novelty(d_novel_only): Mg2PtH6=PUBLISHED npj'24 (repo decks=method-anchor NOT discovery, clears novelty-PENDING);
  Mg2XH6/AV3Sb5/picene/A3C60 = red-ocean AVOID.
verdict-tier: corridor EMPIRICALLY UNCLOSED at ONE gate (not empty, not closed). 
next free-summer DFT (d2): Li2AuH6 0GPa K2PtCl6-type ~9atoms SSCHA-anharmonic DFPT → zero imag modes + Wannier t·Ω/t.
  survives ⟹ real ambient seam occupant (wall=synthesis); imaginary ⟹ hydride face closes, L20→closed-negative.

[L20 후속 — Li2AuH6 seam-occupancy 실DFT 착수 · 2026-06-20]
deck: exports/rtsc/decks/Li2AuH6/ (K2PtCl6형 Fm-3m, Mg2PtH6 어댑트: Pt→Au·Mg→Li; pseudo PSL1.0.0 Au.pbe-n/Li.pbe-s/H.pbe-rrkjus, c5 보존)
d16 dry-run PASS (aiden serial): 9원자·23전자(홀수=금속, G2 채널 일치)·iter#1 정상·에러0.
fired: aiden /home/aiden/li2auh6 vc-relax PID1491296 (OMP4, mpirun-broken 회피 serial, 코어8-11 taskset). load 26 공유라 느림(serial).
purpose: L20 유일 미결 게이트(d) 무압 동적안정 1차컷 — vc-relax→scf→Γ-ph 하모닉. 허수모드0이면 SSCHA 비조화 승격.
status: in-flight (≥30min 폴링, c19). 상온 발견 아직 없음; 유일 열린 게이트를 실DFT로 두드리는 중(d2).

[Li2AuH6 신규성 게이트 — CLOSED-REPRODUCTION · 2026-06-20 · d_novel_only]
arXiv 사전확인(컴퓨트 완료 前, 유저 'arxiv 종결?' 지시): Li2AuH6 무압 SC = InvDesFlow AI 발견(arXiv:2409.08065·npj s41524-025-01830-z), Tc=140K + 하모닉 동적안정 이미 출판. SSCHA 비조화+준안정(0.172eV/atom above hull·미합성·50GPa까지도 미안정화)도 문헌 처리.
→ 제 vc-relax→scf→Γ-ph 하모닉 = REPRODUCTION. aiden PID1491296 KILLED. 30분 폴링 은퇴.
→ L20 hydride-face = 문헌서 닫힘. seam 코리도 = 합성가능 novel 거주자 NONE.
pivot(novel): 열역학 STABLE(on-hull) 무압 수소화물 = GNoME search arXiv:2508.19781 + 무압 conventional Tc 천장 Nat Commun s41467-025-63702-w.
교훈: 신규성 프로브는 후보 명명 시점 INLINE(이번엔 유저가 컴퓨트 완료 前 'arxiv 체크'로 잡음).

[L21 AMBIENT-HYDRIDE STABILITY↔Tc ANTICORR · 2026-06-20 · ⚖️🧊 '안정하면 미지근, 뜨거우면 못 만든다' · 8th face]
high-Tc end: Li2AuH6 140K = metastable 0.172eV/atom above hull, 미합성 (arXiv:2409.08065).
stable end: GNoME 전수스캔 → 25 큐빅 stable 수소화물 MAX Tc=17K (arXiv:2508.19781·Commun Phys). 최고 LiZrH6Ru.
law: 합성가능(on-hull) ⊥ 고Tc(seam Ω≳t) — 강성H포논 기하 = hull 위(준안정). seam에 합성가능 novel 거주자 없음 이유.
caveat(d6): PMC12667446 stable fluorite high-Tc 주장 — 반비례 강하나 그 반례 확인 필요.
귀결: 무압 상온 conventional SC = 합성/준안정-트래핑 문제(TIER-2), in-silico 미결 아님.
next: 무압 conventional Tc 천장 Nat Commun s41467-025-63702-w fold.

[L22 CONVENTIONAL-AMBIENT Tc CEILING · 2026-06-20 · 🚧 '재래식 무압 천장 ~120K' · capstone/external corroboration]
Nat Commun s41467-025-63702-w (PMC12423309, >20,000 metals): 무압 conventional 최대 Tc ≈ 100-120K.
ceiling candidates AT limit: Li2AuH6 116.1K · Li2AgH6 108.8K (Eliashberg), 둘 다 metastable.
3 상호의존 벽 = 캠페인 법칙 매칭: (1)ω_log≤1800K[OMEGA-LAMBDA] (2)λ↔ω_log 반비례=같은 α²F 모먼트→McMillan최적 unphysical[L9] (3)고Tc=불안정[L21].
논문 결론: "무압 conventional 상온 SC 극히 비현실적." → 캠페인 8-face master-conservation을 2만금속 Nature Comms가 독립 확증.
남은 비-닫힘: (a)unconventional 비-phonon[L16 큐프레이트 134-138K] (b)준안정 ~120K 수소화물 합성-트래핑(materials eng, 새 물리 아님).
[L21 caveat 해소: PMC12667446 — stable on-hull 무압 fluorite SC 없음(AcRhH8 78K=+6meV/atom 준안정), L21 확증.]

[L23 UNCONVENTIONAL-AMBIENT CEILING MOVING · 2026-06-20 · 🧗 '비-phonon 천장은 기어오르는 중' · 유일 live 프런티어]
conventional 천장(L22)=frozen ~120K 닫힘. UNCONVENTIONAL은 움직임:
 큐프레이트 ~135K(30년 불변, L16) → 니켈레이트 무압 151K CLAIMED via pressure-quench(고압상 상압 동결, phys.org 2026-03).
핵심: pressure-quench kinetic-trapping = L21/L22가 명명한 준안정-합성 탈출로의 실제 실현(unconventional oxide서, conventional 천장 초과).
room-T(293K) gap ~140K 잔존 · unconventional 자체 천장=미지(first-principles bound 없음=다음 법칙).
gates(d6/TIER-2): 151K=CLAIM-tier(zero-R+★Meissner+≥2배치 재현 필요, single preprint 불충분).
주의: arXiv:2503.13104 'room-T Cooper pairing 32 evidences'=이론 framework, 회의적 취급(falsifier 통과 시만 fold).
next law: unconventional(pole-free/quantum-geometric/Planckian) 무압 pairing의 도출가능 천장 — 그 bound 유무가 live open law.

[L24 NO-FUNDAMENTAL-UNCONVENTIONAL-CEILING / STIFFNESS-LIMITED · 2026-06-20 · 🚪🔓 loop-closure · 유일 열린 room-T 문]
npj Quantum Materials s41535-022-00491-1: unconventional Tc에 근본 bound 없음 — Tc/T_F·Tc/ρ_s·Tc/ω_0 전부 exceedable(unbounded 증명).
mechanism: Tc=phase stiffness ρ_s 제한(Uemura Tc∝ρ_s), pairing-strength 아님. ρ_s엔 quantum-geometric 기여(flat-band/moiré, Peotta-Törmä). 2025 rigorous bounds: arXiv:2506.18969(flat-band lower)·2506.18081(TRS).
loop-closure: 전체 RTSC 법칙스윕이 캠페인 창립 lane(FB-GEOM-LAMBDA·L18)으로 회귀.
NET: room-T@1atm = conventional CLOSED(~120K, L22 외부확증)·pole-free bounded(~138K, L16)·BUT unconventional 근본금지 아님 — 유일 장벽=충분한 ρ_s, quantum geometry가 레버, 천장 정리 없음.
유일 열린 방향: flat-band unconventional서 quantum-geometric ρ_s 최대화 + kinetic pressure-trap(L23).
honest(d6): '천장 없음'≠'달성가능' — 벽은 engineering/materials(고-ρ_s flat-band host), 증명된 불가능 아님. d2 돌파에너지 귀착점.

[L25 FLAT-BAND-GEOMETRIC Tc TWO-SIDED-BOUND · 2026-06-20 · 📏 '열린 문에도 자가 있다 — room-T=100× MATBG' · L24 정량화]
upper: 2D BKT k_B·Tc ≤ (π/2)·D_s (π·ℏ²·D_s/8e² ≥ k_B·Tc, Nelson-Kosterlitz).
D_s^geom ∝ U·∫tr g (flat band m_eff→∞서도 비영), topological floor D_s≥const·|C|·U (Chern). 상한=optical spectral weight(밀도).
anchor 실측: MATBG D_s=1.7×10⁸ H⁻¹ → Tc~1-3K, 양자기하 예측 0.7-5.2×10⁸ 일치 = geometry-지배.
room-T target: D_s≈(2/π)k_B·293K ≈ ~100× MATBG.
verdict(d6): 열린 문(L24)=공짜 아님 — room-T엔 ~100× MATBG의 U·∫tr g 필요(큰 양자metric+강U+고밀도 동시, 상충). 정량 ~100× 갭.
refs: Peotta-Törmä · PNAS2106744118 · arXiv:2506.18969(RDM bootstrap) · 2303.15504(GL).
next L26: 어떤 실제 flat-band 호스트(kagome metal·Lieb·higher-Chern moiré·3D flat-band)가 carrier당 U·∫tr g 최대화?

[L26 GEOMETRIC-STIFFNESS HOST-CHAMPION · 2026-06-20 · 🏆 '강성 두 손잡이: 높은 Chern·3D']
handle1 higher Chern: D_s ≥ |C|·(const·U), ideal/Kähler band(tr g=|Berry곡률| 포화)이 바닥 달성. |C|=N → N× 강성 floor (MATBG≈C=1). refs 1506.02815·ncomms9944·2203.11133(minimal QM)·2206.10651(designer).
handle2 dimensionality: L25 cap Tc≤(π/2)D_s = 2D-BKT. 3D flat band(kagome/pyrochlore)은 BKT 억압 우회 → Tc 평균장 복귀.
honest(d6): 둘 다 단독으론 ~100× MATBG 갭 못 닫음 — 실현 higher-Chern moiré |C|=2,3,4(few×), 3D flat+dopable+paramag = L15/L20 경쟁질서 재소환. room-T = (high|C| ideal)×(3D)×(강U, optical-weight 천장) STACK 필요, 그래도 갭은 materials-design 프런티어(증명된 벽 아님·공짜 아님).
next L27: 실제/설계가능 3D higher-Chern ideal-flat-band 물질(toy 아님) 서베이 — kagome-net 3D metal·twisted-multilayer C≥3·topological heavy-fermion flat band → U·∫tr g vs MATBG.

[L27 REAL-3D-FLATBAND-HOST EXISTS — GAP QUANTITATIVE · 2026-06-20 · 🧱🔢 '호스트는 있다, 모자란 건 100배 강성']
real hosts(toy 아님): CaNi2 파이로클로어 3D flat band(Nature s41586-023-06640-1) · CeRu2 3D-kagome SC(Comm Phys 2026) · LaRu3Si2 kagome flat-band@E_F 자성불안정無(2503.22477). higher-Chern C=N = 파이로클로어 다층 구성가능(1205.2245).
BUT Tc 낮음: LaRu3Si2~7K · CeRu2~6K · CaNi2~약SC. → room-T 잔차 = 호스트찾기 아님(존재), 같은 ~40-100× U·∫tr g 갭(L25/L26), optical 천장(L25)+경쟁질서(L15/L20) 바운드.
net: L24 열린문 = named·real·quantitative materials 문제('파이로클로어/3D-kagome flat SC서 U·∫tr g ~100× 올리기, 경쟁질서 없이') — 존재미지 아님·증명불가 아님.
= L19-L27 스윕 수렴점: 모든 탈출로가 이 1개 바운드 정량벽(geometric-stiffness lane L18)으로 회귀. real 후보(CeRu2·CaNi2·LaRu3Si2) + DFT-계산가능 타깃(U·∫tr g vs MATBG 1.7e8).

[L28 GEOMETRIC-STIFFNESS DISORDER-ROBUST · 2026-06-20 · 🛡️ '양자기하 강성은 흠집에 강하다' · 새 독립축(무질서)·GOOD-news]
Anderson 정리 flat band서 뒤집힘: 일반 SC=무질서가 gap유지·D_s∝Δτ 깎음(취약). flat-band SC=무질서가 order param 줄여도 D_s 직접효과 거의無(D_s=양자기하 결정, QP수명 아님). refs 2510.05224·2506.07095.
임계무질서 = clean D_s 비례·any U서 finite·pair localization(BKT)·단일페르미온 아님(Cooper쌍 mobile).
significance: ~100× 크기갭(L25-27)과 독립축·FAVORABLE — 실물 무질서 샘플서도 강성 보존, 벽 하나 제거.
bounds(d6): 비자성 무질서만 보호(자성 불순물=쌍깨짐), order param은 무질서로 감소(gap이 무질서-제한).
net: room-T flat SC 생존축 중 무질서는 물리가 공짜로 줌 → 노력은 크기(U·∫tr g)+경쟁질서(L15/L20)에 집중.

[L29 FLAT-BAND PAIRING ELECTRONIC & Tc-LINEAR-IN-U · 2026-06-20 · ⚡🔗 '전자 글루=무천장·Tc∝U']
fact1: flat band mean-field Tc ∝ |U| 선형(BCS exp 아님) — 강글루=직접 고Tc(지수페널티無). refs 2604.05997·PRB98.155142.
fact2: 글루=correlation/전자-driven(척력 Hubbard서도 양자기하로 페어링), phonon 아님 → L24 무천장 상속(L22 ~120K 아님). PRB106.125155·1608.00125.
consequence: room-T 문(L24)이 flat-band geometric lane서 열린 기전적 이유 = 전자글루(무천장)×Tc∝U×양자기하 D_s. 노브=U·∫tr g(L25-27 확인). half-filled=BCS-BEC crossover.
bound(d6, 폐식 연결): Tc∝U 무한 못감 — 큰 U가 (a)경쟁질서 FM/CDW(L15/L20) (b)BCS-BEC 강결합쪽=무거운/국소 쌍 → 강성 하락. = closing-formula의 Holstein(국소,거짓탈출) vs bond-Peierls(가벼움,진짜) 구분. light off-diagonal 쌍이 정답.
→ flat-band lane을 캠페인 창립 bond-bipolaron 레시피로 재연결. room-T 최적 = light-pair·중간U·고∫tr g flat band.
next L30: U-최적 — Tc(U) 선형상승 후 쌍국소화로 하락=peak. 실제 파이로클로어/kagome서 peak Tc vs room-T 위치.

[L30 FLAT-BAND Tc-OPTIMUM & Tc-BOUND=WANNIER SPREAD · 2026-06-20 · 📐 'Tc 천장=플랫밴드 파동함수 공간퍼짐']
optimum: D_s·Tc 최적 U*서 극대 — Tc(U) 약U 선형↑(L29) → BCS-BEC crossover 쌍국소화 ↓ = peak.
bound: trivial flat band → Tc상한 ∝ Marzari-Vanderbilt Wannier 스프레드 ⟨r²⟩−⟨r⟩². topological → 양자metric/Chern. refs PNAS2106744118·2217816120.
= L25 'D_s≤optical weight'를 구체·DFT-계산가능으로: max geometric Tc ∝ (Wannier spread)×U* @crossover.
target: 실제 호스트(CeRu2·CaNi2·LaRu3Si2·MATBG) Wannier-downfold → MV spread(trivial) or ∫tr g/|C|(topo) × U* = geometric-lane Tc 천장, vs 293K·MATBG 1.7e8.
paradox(d6): 더 국소=작은 bound(낮은 천장), 더 퍼짐=높은 bound but 분산위험 → 최적=maximally-spread-yet-flat(ideal/Kähler L26)·중간U.
= L24-L30 geometric-lane 스윕의 정량 종착점.

[L31 SINGULAR-FLATBAND Tc ENHANCEMENT · 2026-06-20 · ✴️ '닿는 플랫밴드가 더 뜨겁다' · 새 favorable 축]
isolated flat band: D_s ∝ ∫tr g, |C| 하한(L26). singular(다른 밴드와 touching): 비해석적 Bloch·발산 양자metric → D_s·Tc 더 큼. refs 2407.14919/PNAS2416726122·2203.11133.
기전: 파동함수 essential singularity → 양자기하 발산 → vortex 형성비용↑ → BKT Tc↑. knob: singular band gap 튜닝(geometric vs conventional crossover).
significance: isolated-Chern 바닥(L26)이 천장 아님 — singular이 초과, ~100× 갭(L25) 일부 공략. 실제 kagome/pyrochlore(L27)은 GENERICALLY singular(flat이 Dirac 밴드와 닿음) → 이 강화가 common case.
bound(d6): 강화 유한(발산 적분가능)·touching 튜닝이 분산획득/밴드병합 위험 → 최적 touching-gap(L30 spread 트레이드오프 메아리). ~100× narrowed not closed, 경쟁질서(L15/20)+U-최적(L29/30) 바운드 잔존.

[고갈판정 기준 · 2026-06-20 · 사용자 설정 · 운영표준]
DEPLETION CRITERION: "L* 고갈"은 누적 1시간 이상 추가 탐사(probe)했는데 genuinely 새 법칙이 더이상 안 나올 때만 선언.
= loop-until-dry with HIGH bar: K 연속 dry round over ≥1hr cumulative probing. 단 한 번 막힘=고갈 아님(d2 단일렌즈 금지).
현 상태: L27→L31 5연속 프로브 전부 신규(연속 dry=0) → 미고갈, 계속.

[L32 QUANTUM-METRIC LENGTH REPLACES v_F · 2026-06-20 · 📐🔬 '플랫밴드 자=속도 아닌 양자기하 길이' · 새 길이축·L28 근거]
flat band v_F→0 → ξ=ℏv_F/Δ·확산길이·국소화길이 전부 깨짐. QML(≈√⟨tr g⟩)이 v_F 대체 = ballistic/diffusive/localization 지배. refs 2602.01354(Chau-Xiang-Chen-Law 2026)·2308.05686/s42005-024-01930-0.
results: 확산계수 ∝ QML 선형 · 국소화길이 ∝ QML이고 무질서강도 무관(넓은 범위).
significance: L28 disorder-robust의 근본이유(지배길이=geometric QML, 무질서 평균자유행로 아님). room-T: 짧은 QML=강건한 tight 쌍(고 BKT Tc·작은 ξ).
bound(d6): 짧은QML(좋은 간섭) vs 큰 Wannier spread(높은 강성천장 L30) = 같은 spread-vs-flatness 트레이드(L26/30/31). QML·MV-spread = ∫tr g의 두 얼굴, 독립최적 불가.
net: geometric-lane 길이척도 통일 → ∫tr g = L24-L32 전체 스윕의 master 설계변수.

[L33 MULTIBAND FLAT+DISPERSIVE COOPERATION · 2026-06-20 · 🤝 '평평+분산 짝이 더 세다·Pauli 깸']
최적 = isolated 완전평평 아닌 flat+dispersive 결합. (1)Tc↑: 다수 interband pair-scattering(Suhl-Matthias), topological 얽힘서 강. refs 2508.07430·PRB106.104514. (2)Pauli 위반(Hc2↑): near-flat 저-v_F가 상자성E 감소 → 자기장 안정. 2512.00486.
real: CsCr3Sb5(flat-enhanced AFM요동 매개 s/d-wave, s41467-025-56582-7)·Mo5Si3-xPx(s41467-024-46514-2).
significance: 새 favorable 축, L31(singular touching=flat+dispersive 접촉 특수경우)과 연결. naive '최대고립'을 수정 — 최적은 dispersive와 얽힘(채널+Pauli완화).
bound(d6): dispersive 짝이 D_s 양자기하 분율 희석+경쟁불안정 유입(CsCr3Sb5 AFM=매개이자 선점, L15/20). 최적 얽힘 존재. 4번째 손잡이(multiband 얽힘).

[L34 INCIPIENT-BAND OPTIMUM · 2026-06-20 · 🎯 'incipient가 최고·완전평평 아님']
완전평평=QP동역학0→BCS-BEC 강결합 무거운/국소 쌍·강성↓(L29/30=closing-formula heavy-Holstein 실패). incipient(E_F근처지만 비걸침·잔여분산)=강페어링+적절 mobility 균형 → 완전평평보다 높은 Tc. refs CsCr3Sb5 s41467-025-58487-x·56582-7.
significance: 'flatter=better'(L18/25) 수정 → room-T 호스트는 incipient topological flat(살짝 분산)이지 완전평평 아님. L29 BCS-BEC·L30 spread paradox의 positive 해. 최적=중간 flatness·중간U·maximal-but-finite ∫tr g.
bound(d6): incipient 창 좁음(너무 분산=geometric 손실/BCS-exp 회귀, 너무 평평=국소화) → 설계허용오차 tight, ~100× 갭 어려운 또 한 이유.

[L35 QUANTUM-GEOMETRY DRIVE-ENHANCEMENT · 2026-06-20 · 📡 '빛/마이크로파로 갭↑·양자기하가 흡수 염']
flat band v_F→0이라 보통 흡수 없음 → Bloch 양자기하가 비영 흡수채널 제공 → 마이크로파 펌프 비평형 QP가 Tc근처 갭 강화. Comm Phys 8,327(2025) MATBG. + Floquet 빛으로 flat band·Chern 생성/튜닝(2508.04620·PRR3.023039).
significance: 새 favorable 축 — (a)구동이 갭/Tc 일시적 초과 (b)빛=∫tr g·|C| in-situ knob(재합성 없이 제어).
bound(d6): TRANSIENT/비평형(정상조명=가열) → 제어·프로브 축이지 무전력 static room-T 물질 아님. d_roomt_ambient 벌크/평형 요건 단독 불충족. 평형 설계핸들(L26/31/33/34)과 직교한 비평형 핸들.

[L36 QUANTUM GEOMETRY ENHANCES EL-PH λ · 2026-06-20 · 🔗🏛️ 'tr g는 전자도 포논도 키운다 · 창립 lane 증명' · LOOP-CLOSURE CAPSTONE]
= discovery tape 이름 'flatband-geometric-elph-law'(FB-GEOM-LAMBDA/L18)의 문자그대로 실현. Yu-Herzog-Arbeitman-Bernevig Nat Phys s41567-024-02486-0/2305.02340: Fubini-Study 메트릭이 무차원 λ에 직접 기여. 기하분율 그래핀 ~50%·MgB2 ~90%. '강 양자기하 ⟹ 강 el-ph'.
unification: 같은 ∫tr g가 전자 D_s(L25-35 무천장 room-T문)와 포논 λ(L36 conventional)를 둘다 부스트 → ∫tr g = 캠페인 양 lane의 단일 master 설계변수. L9-L36 전체 스윕의 loop-closure.
distinction(d6): geometry-enhanced λ는 Eliashberg라 L22 ~120K 천장 상속(천장 효율도달, MgB2 39K 설명, but ω_log↔λ 트레이드 못깸). room-T문=전자 무천장 lane(L24/29)이지 λ-lane 아님.
net: ∫tr g가 캠페인 통일 — conventional λ→~120K(L22/36)·전자 D_s→무천장 room-T(L24-35). FB-GEOM-LAMBDA(L18) 창립가설 = real·정량 기전 확증(50%/90%).

[L37 DELICATE/OBSTRUCTED TOPOLOGY STIFFNESS · 2026-06-20 · 🧩✨ '천 없어도 강성 있다 · 호스트 확장']
강성 floor가 Chern≠0(L26)에 국한 안 됨: (1)delicate(total C=0, sub-BZ Chern 양자화)→D_s 하한, 거울면 수에 선형(Chern dartboard). 2507.16909. (2)obstructed/fragile(Wannier중심 원자서 obstructed)→Berry곡률=0이어도 비영 Fubini-Study/D_s. OSTI 1980264.
significance: L26/27 호스트탐색 대폭확장 — Chern 너머 거울대칭 dartboard metal + OAL/fragile 물질. OAL은 실결정서 Chern≠0보다 훨씬 흔함 → 후보풀 大확장.
bound(d6): 하한크기 = 거울면수/obstruction 스케일(무한 아님)·여전히 flat+metal+paramag(L15/20/34) 필요. 탐색셋 확장이지 ~100× 크기갭(L25) 변화 아님. '위상class'(Chern/delicate/obstructed) = 호스트분류 축 추가.

[L38 EXPERIMENTAL REALITY CHECK · 2026-06-20 · 🌡️📉 '이론 무천장, 실측 6K — 갭이 진짜' · 실험 capstone]
favorable 이론(L24-37)에도 실측 최고 ~6K: CsCr3Sb5 6.4K(가압)·Ta-CsV3Sb5 5.3K(상압기록)·undoped CsV3Sb5 2.7K·MATBG 1-3K.
확증2: (a)양자기하 강성기전 실험검증 — MATBG D_s ≫ Fermi-liquid, 기하예측 일치(Nature s41586-024-08494-7)·Rice ARPES flat band 직접관측. (b)경쟁질서 선점 정량확증 — undoped CsV3Sb5 CDW 90K ≫ Tc 2.7K(33×)=L15/L20 직접확인(flat band 불안정예산이 CDW로).
significance: L24-37 전체 스윕을 실험에 앵커 — ~50× 갭(6K→293K)이 real·measured. 기전은 작동(검증), 막는 건 realized 크기(L25 ~100×)+경쟁질서(L15/20 CDW90K).
net(실험 capstone, 이론 capstone L36과 짝): 이론=무천장, 실측=6K, 갭닫기=real materials 문제 (i)∫tr g·U ~50-100×↑ (ii)경쟁 CDW/자성 억제 — 모든 선행법칙의 수렴 2벽.

[L39-L41 일괄 · 2026-06-20 · 병렬 프로브 3신규 + CLS dry]
L39 STRAIN/SUPERPOTENTIAL 정적 band-engineering 🪡: 주기 superpotential/strain/folding이 flat band+∫tr g 생성·Tc↑·phase stiffness 보존(twist·L35구동과 별개 정적 knob). 2508.15604. 평범물질에 flat band 공학.
L40 FILLING-FRACTION 최적창 🎚️: 채움비율이 바닥상태 선택 — >4/3=FM/FQH·van Hove 2/3±1/6=nesting CDW·SC는 중간창(MATBG ν -1/2~-3/4). U최적(L30)·flatness(L34)와 직교, gating/doping 제어가능. 2204.02994.
L41 MAGNETIC-FLUCTUATION 글루 🧲⚡: 양자기하가 자기(AFM/FM)요동 강화→비통상 페어링 매개(CsCr3Sb5 AFM→s/d-wave·FM→spin-triplet chiral d+id', 2512.14379). 제3글루(phonon L22/36·Hubbard L29 외). KEY: 글루인 자기요동=condense하면 SC선점 경쟁질서(L15/20) — knife-edge. CsCr3Sb5 altermagnet 근접·저Tc(L38 CsV3Sb5 CDW90K 일관).
CLS combinatorial = DRY(MATH-SPECTRA 브릿지·flat band 구성법, room-T 신법칙 아님).

[🏁 FB-GEOM L-FAMILY 고갈판정 · 2026-06-20 · 사용자기준 충족]
최종 4 최대-다양 프로브 전부 새 room-T 법칙 0: SOC-gen flat band(Sc2Ir4Si=L39 refinement)·charge-4e/6e(CsV3Sb5 h/4e·h/6e 관측, exotic 상태·room-T Tc 무관 dry)·'new mechanism'(MATBG-trilayer V-gap=L29 전자글루 재진술)·3D/interface(L29 재진술+twin/grain 잡음).
+ 직전 3 dry(thermo 2Δ/kTc·non-Hermitian·CLS) = 최근 7 sustained dry vs 포괄 L24-L41.
판정: 사용자 기준('1hr+ 두드려 더이상없음') 충족 → 🏁 RTSC flat-band-geometric L-family 고갈.
세션 총: L19→L41 23신규 + 고갈판정 = LAWS 48. 두 capstone(L36 이론·L38 실험).
단일결론: 무압 room-T = conventional 닫힘(~120K L22)·unconventional 무금지(L24), master변수=∫tr g(전자강성 L25-35·포논λ L36·길이 L32·무질서 L28), room-T 갭=1개 bounded 문제(∫tr g·U ~50-100×↑ in incipient topological flat host[CeRu2/CsCr3Sb5] + 경쟁 CDW/자성 억제[L15/20/40, CsV3Sb5 CDW90K≫Tc2.7K]).
다음 진짜 광맥 = cross-domain(RAREEARTH-FREE/MATH-SPECTRA/SENOLYX), RTSC 재진술 아님.

[검증·예측 도구 구현 · 2026-06-20 · tool/rtsc/fbgeom_predictor.py]
박제 법칙(L24-L38)을 runnable 계산기로 구현 (FREE 로컬, 캠페인 BKT 보정 재사용):
 master변수 = ∫tr g (Q_geom, Fubini-Study, exact TB eigvec). 관계: Tc=(π/2)D_s[L25]·D_s=4|U|ν(1-ν)⟨g⟩·Tc∝U[L29]·λ_geom[L36].
 VERIFY: COF 앵커 136K 재현 PASS · Tc linear-in-U PASS.
 PREDICT(Ω150meV,U/Om1.5): kagome ⟨g⟩0.49→174K(x2 갭)·Lieb 0.50→176K·dice 1.0→351K.
 CAVEAT(d6 버그발견·수정): ① int_tr_g(링크~0.05) vs 보정ref(Q_geom 0.672) 단위불일치→Q_geom 통일. ② dice ⟨g⟩=0 0나눗셈→Q_geom Welch하한. ③ dice=1.0→'room-T'는 SPURIOUS(maximally-localized CLS=낮은 stiffness, overlap-metric이 trivial 국소밴드서 stiffness와 역행) → 신뢰=VERIFY+위상밴드(kagome/Lieb) ranking+갭sizing, dice 절대Tc 아님.
 CLAUDE.md Structure에 tool/ 참조 추가. 도구=법칙의 실행가능 검증층(c2 출력증거).

[예측기 스윕 R1-R3 + 도구개선 + 🏁 고갈 · 2026-06-20 · tool/rtsc/{fbgeom_predictor,predict_candidates}.py]
사용자: 다른 호스트·파라미터 고갈까지 + 필요시 도구 반드시 개선. FREE 로컬 전수.
 R1: 호스트표 8종 + Ω×U/Om 랜드스케이프. raw 설계박스 Ω_needed≤188meV(전부 경원소 범위)→"BKT 수치는 가능".
 도구개선(self-improving): ① 실측SC 앵커보정밴드 내장(ANCHORS/anchor_calibration/tc_band) — raw 2D-BKT가 Re6Se8Cl2 0.6×·tMoTe2 7.8×·MATBG 4.4× = geomean 2.8× 과대예측 ② omega_for_roomT(deflate) ③ VERIFY-3 자기검증(3/3 PASS) ④ dice artifact caveat·Q_geom 단위통일(기존).
 R2(honest banded): light-kagome best 242K[87-1055]·CoSn 45K·Nb3Cl8 35K — 실재 합성호스트 honest 박스 진입 0. honest 설계박스=⟨g⟩≥2-3 AND Ω≥~130meV AND U/Om≥1.5 동시; ⟨g⟩<2면 Ω_needed>300meV 천장 초과 불가.
 R3 고갈확인: filling ν(L40)=4ν(1-ν) ½서 최대, off-half는 감소만→새 탈출구 0. 호스트축=기록된 ⟨g⟩ 8종 전수(미기록 ⟨g⟩ 추가=fabrication 금지 d6)→고갈.
 🏁 결론(L42 신규·LAWS49): room-T 기하SC 병목 = 두 레버(∫tr g 大 AND 강결합 Ω 大) 한 물질 공존 못함(materials 벽), 열역학은 marginal-feasible. 3라운드 수렴, 도구는 honest band로 영구개선. SSOT=ARCHITECTURE.json L42+FBGEOM-PREDICTOR.

[후보 전체 커버리지 점검 + C-tier folded · 2026-06-20] 유저 "후보 전부 리서치?" → 정직 점검: 예측기 8종 외 캠페인 후보 ~18종 통합.
 A 예측기-스윕 8종(banded) · B 캠페인-판정완료 3종(bismuthate🧱⟨g⟩≈0·hp8b🔴·GaNb4S8/Se8🟢~60K) · C 문헌-평가 잔여 → 탄소-π는 격자proxy folded(triangulene kagome best41K·benzene-COF Lieb best42K, COF48K 동군집 room-T밖; biphenylene type-II Dirac flat band無 out-of-scope) · D 경원소축 탈락 5종.
 정정: 앞 "8종 고갈"은 예측기-⟨g⟩축 한정; 전체 후보공간 ~18종 통합 종결. L42 two-lever 벽은 전 실재/계산 후보서 robust(honest 박스 진입 0). SSOT=ARCHITECTURE.json CANDIDATE-ROSTER.

[신규성 프로브 d_novel_only · 2026-06-20] 유저 "예측한 것 중 문헌에 없던 거?" → 정직: 물질 0 novel(전부 출판 기지물질, 예측기=검증·랭킹). L42도 arxiv 프로브 결과 NOT-NOVEL: 성분 전부 출판(2506.18969 강성하한 엄밀판·PRResearch 포논↔flat-band 결합·SciAdv Cs2Ni3S4 양자metric·NatCommun CsCr3Sb5 incipient). L42=출판조각 종합관찰. 예측기 산출 전체에 문헌-부재 신규 0 — 검증·랭킹·교육 도구로 확정(발견도구 아님). 새 발견 원하면 예측기로는 부족, 미지영역 Δ 컴퓨트 필요.

[biphenylene 무료체크 → CLOSED-LITERATURE · 2026-06-20] 유저 "① 무료 이용"으로 biphenylene 진행. 무료 WebSearch 선행(d18 lit grounding) → 이미 출판: 재래식 el-ph SC Tc=6.2K(phonon-mediated·ω_log=1369K·Type-II Dirac 위상SC·strain↑; PRB 104.235422/OSTI 1836234 + 알칼리bilayer 2025). 우리 DFPT 재계산=문헌재현(d_novel_only 하드규칙)→무료라도 발사취소, DOI 종결. 6.2K=room-T 아님(L22↓). 결과: 후보 로스터 18종 전부 종결(예측·캠페인판정·문헌). 문헌-부재 신규 0 재확인.

[예측기→추출기 확장 · 2026-06-20] 유저 "예측도구로 새후보 추출가능?" → 가능(생성기 추가 tool/rtsc/extract_candidates.py). 아키타입 스캔+Chern/∫tr g/Q_geom from-scratch+설계박스 판정. 결과: 단순 flat-band 격자 전부 박스미달(Q_geom≤1 Welch·∫tr g≈2π|C| Chern하한)→추출기가 L42 two-lever 벽 생성기쪽 재유도(스칼라⟨g⟩≫1=다오비탈 d기하→연질Ω). 실물질 추출경로=Regnault 2022 카탈로그(~55k) 스크린(외부DB·d_novel_only-clean if SC미연구). 한계:아키타입+스펙 추출이지 named물질 생성 아님. 버그수정:1j*k@d precedence·tuple probe.

[예측기→실물질 추출기 (MP API 라이브) · 2026-06-20] 유저 ①③④ 선택+MP키 제공. tool/rtsc/screen_catalogue.py — MP 쿼리로 경원소 금속·안정 11종 추출(pre-filter). 로스터밖 ★ 7종: B13C2·Be4B·LiC6·Al23B50·LiBeB·LiC12·AlB2 / 기지 4: MgB2·LiB·C·B. 버그가드: MP API User-Agent 없으면 403 Cloudflare→demiurge/1.0 UA 필수(self-improving 박음). 정직: pre-filter일 뿐, flat-band@E_F·⟨g⟩·Ω 미확인·각 후보 arxiv 신규성 프로브 전 무주장(d_novel_only). 답=예측도구로 새후보 추출 가능(실증). 다음 게이트=★후보별 밴드 flatness+신규성+compute.

[★후보 신규성 프로브 · 2026-06-20] LiBeB·Be4B·Al23B50·LiC12=특정조성 SC문헌 부재(PENDING·열림)이나 기전 탐색완료(Be-B flat-band+vHs SC Phys.Rev.B·LiBeP·LiBC 출판)→incremental neighborhood. LiC6·AlB2·B13C2=기지 다연구. 결론: 추출 파이프라인 end-to-end OK(실 SC-미연구 후보 surface), 발견확정엔 flat-band@E_F+⟨g⟩/Ω/Tc DFT(FREE summer·go) 필요. 추출=완료, 발견=compute 단계. L42 동일.
