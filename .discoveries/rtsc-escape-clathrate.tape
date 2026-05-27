@V := "discovery" :: rtsc-escape-clathrate [active]
  date    = "2026-05-27"
  seed    = "m-sign ESCAPE zone (lambda>2.5) + high omega_log + pressure<50GPa, grounded by arxiv"
  domain  = "RTSC"
  mechanism = "chemical precompression: light M binds H -> MHx precompressor units -> metallization pressure drops; interstitial excess electrons in metal framework form anionic H cage (Coulomb precompression)"

# arxiv-grounded findings (verdict-tier-target = DFT el-ph harvest in this repo)
@F f1 := "ysbh6 = published candidate, NOT blind shot" :: grounded [active]
  arxiv   = "2512.19901v1 (Causse/Pickard 2025-12)"
  claim   = "cubic Pm-3 YSbH6: Tc=118K@50GPa, dyn-stable 20-120GPa, metastable (26meV/atom above hull @120GPa)"
  status  = "RUNNING in this repo (vast, dyn=4) — our DFT reproduces this paper; min_freq -6.4 mild-soft consistent w/ dyn-stability"
  target  = "harvest -> compare Tc vs lit 118K@50GPa (cross-tool-consistency g5)"

@F f2 := "M-Be-H precompressor family PROVEN (AcBeH8)" :: grounded [active]
  arxiv   = "2411.19028v2 (Gao/Botti/Marques/Li 2024)"
  claim   = "fcc AcBeH8 dyn-stable down to 10GPa, Tc=181K; Be-H bonds = chemical precompressor enabling near-ambient stability"
  status  = "Ac radioactive -> deprioritize; labeh8 (La-Be-H, OUR measured m=+0.359) = non-radioactive sibling confirmed"
  target  = "NOVEL non-radioactive members below"

# NOVEL probe candidates (not yet in literature found -> high discovery value, d18)
@X n1 := "ScBeH8 — ESCAPE + high omega_log (reasoned breakthrough)" :: novel [active]
  rationale = "Be precompressor (low P, AcBeH8-proven) + Sc lightest cage core (mass 45 < Y 89 < La 139) -> omega_log boost. labeh8 taught: m>0 ESCAPE but omega_log 589K low capped Tc@117K. Sc lifts omega_log."
  target  = "DFT el-ph: predict m>0 ESCAPE AND omega_log >> labeh8 589K -> Tc breakthrough candidate"
  tier    = "speculation-fenced until DFT"

@X n2 := "YBeH8 — direct labeh8 Y-analog, sister YH10-family test" :: novel [active]
  rationale = "Y core + Be cage; sister session predicted YH10-family closest to ambient 293K. La<->Y chemical 자매."
  target  = "DFT el-ph: m-sign + Tc + dyn-stability @<50GPa"
  tier    = "speculation-fenced until DFT"

@X n3 := "CaBeH8 — lightest non-radioactive M-Be-H" :: novel [active]
  rationale = "Ca (mass 40) + Be cage; cheapest precompression, possibly lowest P"
  tier    = "speculation-fenced until DFT"

# literature-backed lower-pressure binaries
@F f3 := "CeH9 — low-pressure superhydride (measured)" :: grounded [active]
  arxiv   = "2007.02073 + 2102.12077"
  claim   = "synthesized 80-100GPa (<< LaH10/YH6); Ce 4f delocalized -> enhanced chemical precompression; measured ~100K"
  target  = "DFT el-ph reproduce + m-sign placement"

@F f4 := "Y2CdH18 / Y2InH18 / Ca2SnH18 — new clathrate family" :: grounded [active]
  arxiv   = "2411.11674 (Zhu/Qi 2024)"
  claim   = "P-3m1 hydrogen clathrate cages, Tc>110K (>liquid N2), meta-stable high-P"
  target  = "screen for <50GPa stability + m-sign ESCAPE"

@X n4 := "Li2MgH16 — highest predicted Tc anchor" :: known [active]
  ref     = "Sun et al 2019"
  claim   = "Tc=473K@250GPa (highest predicted) — deep ESCAPE m-axis extreme, but high-P"
  tier    = "m-axis positive-end anchor"

# dispatch priority for next /micro-exp wave (low-P + ESCAPE + non-radioactive first)
@D prio := "wave-2 dispatch order" :: plan [active]
  do = "1) ScBeH8 (reasoned: ESCAPE+omega boost) · 2) YBeH8 (YH10-family test) · 3) CaBeH8 · 4) CeH9 (lit low-P) · 5) LaBH8 (B-cage low-P)"
  do = "all M-Be-H share Be.pbe + H.pbe pseudos (already staged on ysbh6 pod for labeh8 lineage); Sc/Y/Ca/Ce pseudos = PSlibrary wget"
  dont = "Ac/Th/U/actinide (radioactive) · Li2MgH16 first (250GPa high-P, deprioritize vs <50GPa milestone)"

# ── 장바구니 (brainstorm cart — user-curated backlog, draw next waves from here) ──
# method = "math <-> physics same-formula cross-pollination": find where an RTSC equation
#          secretly equals an equation from another field -> import that field's machinery.

@X cart_frontiers := "4 strategic frontiers (user: all)" :: cart [active]
  f1 = "ESCAPE x high-omega_log corner — is it accessible? (labeh8 lesson: lighter cage, H-content tuning)"
  f2 = "ESCAPE<->omega_log trade-off = the wall? first-principles d2 analysis (closed-neg or breakthrough)"
  f3 = "ambient metastable recovery — quench high-P phase to 1atm kinetic stability (the real 293K@1atm goal)"
  f4 = "non-hydride / unconventional — escape phonon-SC limits (cuprate/FeSC, covalent metal)"

@X cart_xform_r1 := "same-formula ideas round-1 (4)" :: cart [active]
  x1 = "Cooper instability = RG flow -> m-sign = RG separatrix -> scan marginal-ESCAPE band m=+0.03~0.1 (YH6/YH9/ScH9)"
  x2 = "ternary doping = Ricci-flow surgery -> identify best-binary's specific soft phonon mode -> cap it chemically (Be in M-Be-H = surgery cap; targeted C/Si-S-H)"
  x3 = "omega_log max = optimal transport -> descriptor 'alpha2F H-mode fraction' on EXISTING data (compute 0); m-sign(x) x H-mode-frac(y) 2D map to aim 293K corner"
  x4 = "high-entropy stabilization = Perelman entropy monotonicity -> (La,Y,Ca,Sc)H10 multi-cation low-P metastable"

@X cart_xform_r2 := "same-formula ideas round-2 (5)" :: cart [active]
  x5 = "BEC-BCS crossover = unified gap eqn -> deep-ESCAPE (high lambda) may enter BEC regime where Allen-Dynes OVERESTIMATES Tc (phase-coherence-limited); honesty check for high-lambda candidates"
  x6 = "soft-mode -> 0 = pitchfork/fold bifurcation (catastrophe theory) -> m-sign separatrix IS a bifurcation; marginal materials critically sensitive (refines x1)"
  x7 = "light-H fast phonon = Born-Oppenheimer breakdown -> Berry/geometric phase + non-adiabatic corrections (this is what SSCHA/anharmonic captures); gauge-holonomy lens"
  x8 = "Tc landscape = tropical variety (min-plus) -> TRAPPED/ESCAPE boundary = tropical hypersurface; candidates = lattice points near tropical vertices (see RTSC/walls/tropical_isocontour.md)"
  x9 = "CDW vs SC competition = reaction-diffusion / Turing linear stability -> screen candidates for competing charge-density-wave that steals the Fermi surface"

@X cart_xform_r3 := "same-formula ideas round-3 (4) — near depletion" :: cart [active]
  x10 = "Lifshitz transition = persistent homology -> auto-detect band-topology jump in a pressure scan -> that P = lambda spike (apply to labeh8/h3br pscan data, compute 0)"
  x11 = "metastability lifetime = Kramers escape (Fokker-Planck), same as reaction-rate theory -> compute 1atm kinetic barrier dE -> lifetime ~ exp(dE/kT) -> RECOVERABILITY verdict; turns frontier-f3 (ambient metastable) from hope into a calc (THE 293K@1atm attack)"
  x12 = "thin-film/2D hydride = BKT (Kosterlitz-Thouless) vortex unbinding -> use BKT Tc not 3D; strained-film route"
  x13 = "lambda-gradient design = Hellmann-Feynman / eigenvalue perturbation -> dlambda/d(structure) from existing DFPT -> steepest-ascent distortion to raise lambda"

@X cart_xform_r4 := "same-formula ideas round-4 (4) — gems mixed in" :: cart [active]
  x14 = "unconventional SC = AdS/CFT holographic superconductor (Hartnoll-Herzog-Horowitz) -> universal Tc/E_F bound to check candidates against (frontier f4)"
  x18 = "H zero-point energy = Casimir/QFT vacuum mode-sum -> ZPE correction SIGN as screening descriptor: which structures are ZPE-STABILIZED (classically unstable, quantum-saved) = quantum-nuclear RTSC candidates (this is what SSCHA does); deep + actionable"
  x15 = "multifractal SC at mobility edge = random-matrix critical statistics (Feigelman-Ioffe) -> disorder-as-KNOB: tune alloy disorder to Anderson transition to ENHANCE Tc (exploit, not avoid, disorder) — genuinely new route for doped/solid-solution hydrides"
  x19 = "dynamical stability = Lyapunov stability + feedback control -> rigorous frame for x2 surgery: which dopant feedback caps an unstable mode at min cost"

@X cart_xform_r5 := "same-formula ideas round-5 (3) — depletion edge, weak" :: cart [active]
  x22 = "synthesis pathway = Pontryagin optimal control -> design the (P,T) trajectory to a target phase, not just the endpoint"
  x23 = "polymorph landscape = spin-glass / Morse theory -> near-degenerate polymorphs = glassy basins, search best-SC basin"
  x24 = "Meissner effect = Anderson-Higgs mechanism (photon mass = Higgs) -> famous insight, no new chemistry"

@D cart_status := "DEPLETED at round-5 (24 ideas: 4 frontiers + 20 same-formula)" :: meta [active]
  do = "round-6 = tensor-networks / Riemann-zeta / free-probability = all duplicate or methodology, ZERO new chemistry insight -> genuine depletion (g63: depletion is a valid stop)"
  do = "TOP actionable compute-0 (on existing/incoming 7-job data): x3 (alpha2F H-mode fraction) · x10 (Lifshitz persistent-homology) · x11 (Kramers recoverability — THE 293K@1atm attack) · x13 (lambda-gradient) · x18 (ZPE-stabilized screen)"
  do = "TOP new-route needing fresh DFT: x15 (disorder-knob multifractal) · x2 (targeted soft-mode surgery ternary)"
  dont = "force round-6 to extend the list"
