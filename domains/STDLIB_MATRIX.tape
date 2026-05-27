# STDLIB_MATRIX.tape — domain × verb × external stdlib porting index
# demiurge pointer manifest (d3) · stdlib SSOT lives in ~/core/hexa-lang/stdlib
# Status legend: 🟢 real-compute (hexa libm closed-form) · 📋 scaffold (target-carrier)
#                ⏳ porting · ⚪ unwired · ⏭ honest-skip planned

@V := "stdlib-matrix" :: index
  version    = "1.0"
  origin     = "2026-05-28 (PR #0 of 8-step web-gui plan)"
  cells      = "20 frontier × 7 verb = 140 · 40 real-compute · 100 scaffold"
  next_tier  = "SYSTEM Top-3 mobility/space/robotics + 14 honest-skip"

# ── 🔬 ATOM (입자·양자 단위) ─────────────────────────────────────────────────
@D qubit :: domain [active]
  category   = "🔬 ATOM"
  analyze    = "🟢 Koch2007 transmon f01 (hexa libm sqrt) | target = scqubits"
  verify     = "🟢 QuTiP-eq T1/T2 closed-form          | target = QuTiP"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D antimatter :: domain [active]
  category   = "🔬 ATOM"
  analyze    = "🟢 PDG/CPT mass-charge parity (hexa)   | target = Geant4 + PDG api"
  verify     = "🟢 CPT identity closed-form            | target = Geant4 G4Em"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D fusion :: domain [active]
  category   = "🔬 ATOM"
  analyze    = "🟢 Lawson criterion n·T·τ (hexa)       | target = openMHD / TRIQS"
  verify     = "🟢 ignition margin closed-form         | target = openMHD"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

# ── 🧱 MATTER (벌크 물질·박막) ───────────────────────────────────────────────
@D perovskite :: domain [active]
  category   = "🧱 MATTER"
  analyze    = "🟢 Goldschmidt t=0.9115 (hexa sqrt)    | target = pymatgen / Materials-Project"
  verify     = "🟢 Shockley-Queisser drift-diffusion   | target = SCAPS-1D"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D graphene :: domain [active]
  category   = "🧱 MATTER"
  analyze    = "🟢 Wallace tight-binding a/√3 + vF     | target = pymatgen + kwant"
  verify     = "🟢 Landauer G₀=77.48μS (NIST match)    | target = kwant transport"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D rtsc :: domain [active]
  category   = "🧱 MATTER"
  analyze    = "🟢 Tc_BSL=767.9K vs Tc_AD=158.1K       | target = QE el-ph + Eliashberg"
  verify     = "🟢 McMillan Tc=28.30K (hexa exp)       | target = QE el-ph"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D metamaterial :: domain [active]
  category   = "🧱 MATTER"
  analyze    = "🟢 Pendry 1/√LC resonator              | target = openEMS"
  verify     = "🟢 Veselago n=−1 closed-form           | target = openEMS"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D aerogel :: domain [active]
  category   = "🧱 MATTER"
  analyze    = "🟢 Maxwell-Eucken k_eff                | target = openFOAM thermal"
  verify     = "🟢 thermal conductivity closed-form    | target = openFOAM"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D memristor :: domain [active]
  category   = "🧱 MATTER"
  analyze    = "🟢 Strukov state-equation              | target = ngspice + ReRAM model"
  verify     = "🟢 ROFF/RON ratio closed-form          | target = ngspice"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D spintronic :: domain [active]
  category   = "🧱 MATTER"
  analyze    = "🟢 Julliere TMR=66.67% (hexa)          | target = OOMMF micromagnetic"
  verify     = "🟢 λ_sf=316nm spin-diffusion           | target = OOMMF"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

# ── 🪪 CHIP (회로·광 디바이스) ──────────────────────────────────────────────
@D neuromorphic :: domain [active]
  category   = "🪪 CHIP"
  analyze    = "🟢 LIF τ=RC neuron model               | target = brian2 / NEST"
  verify     = "🟢 spike-rate closed-form              | target = NEST"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D photonic :: domain [active]
  category   = "🪪 CHIP"
  analyze    = "🟢 ring resonator Q-factor             | target = openEMS / lumerical-alt"
  verify     = "🟢 FSR + finesse closed-form           | target = openEMS"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

# ── 🧬 BIO (유전·단백·세포) ─────────────────────────────────────────────────
@D gene-edit :: domain [active]
  category   = "🧬 BIO"
  analyze    = "🟢 CFD CRISPR specificity              | target = CRISPResso2 + cas-offinder"
  verify     = "🟢 off-target probability closed-form  | target = CRISPResso2"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D rna-therapy :: domain [active]
  category   = "🧬 BIO"
  analyze    = "🟢 duplex ΔG (hexa exp)                | target = ViennaRNA"
  verify     = "🟢 Tm melting closed-form              | target = ViennaRNA"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D organoid :: domain [active]
  category   = "🧬 BIO"
  analyze    = "🟢 viability + fold-change             | target = CellProfiler"
  verify     = "🟢 growth-rate closed-form             | target = CellProfiler"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D protein-fold :: domain [active]
  category   = "🧬 BIO"
  analyze    = "🟢 RMSD closed-form                    | target = ColabFold + openMM"
  verify     = "🟢 SASA solvent-accessible             | target = openMM"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

# ── ⚗️ CHEM (반응·촉매·흡착) ────────────────────────────────────────────────
@D electrocat :: domain [active]
  category   = "⚗️ CHEM"
  analyze    = "🟢 CHE-HER overpotential               | target = ASE + VASP"
  verify     = "🟢 Tafel slope closed-form             | target = ASE"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D photoredox :: domain [active]
  category   = "⚗️ CHEM"
  analyze    = "🟢 Rehm-Weller ΔG_ET                   | target = Gaussian + GaussSum"
  verify     = "🟢 quantum-yield closed-form           | target = Gaussian"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D co2-capture :: domain [active]
  category   = "⚗️ CHEM"
  analyze    = "🟢 Langmuir isotherm                   | target = pymatgen + EMSOL"
  verify     = "🟢 DAC W_min=19.36 kJ/mol (hexa log)   | target = EMSOL · Lackner"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

@D green-nh3 :: domain [active]
  category   = "⚗️ CHEM"
  analyze    = "🟢 Gibbs ΔG closed-form (hexa)         | target = ASE thermochem"
  verify     = "🟢 ammonia synthesis yield             | target = ASE"
  scaffold   = "📋 specify · structure · design · synthesize · handoff"

# ── SYSTEM 카테고리 폐기 (2026-05-28 사용자 결정) ───────────────────────────
# 5 카테고리 × 20 도메인만 유지 — ATOM · MATTER · CHIP · BIO · CHEMISTRY

# ── summary roll-up ────────────────────────────────────────────────────────
@I rollup_summary := "porting-counts" :: index [active]
  real_compute_cells = 40    # analyze 20 + verify 20
  scaffold_cells     = 100   # spec·str·des·synth·handoff × 20
  total_cells        = 140   # 20 domain × 7 verb
  porting_complete   = "40 / 140 = 28.6%"
  next_porting_wave  = "scqubits + QuTiP (qubit) → pymatgen (perovskite/graphene) → ViennaRNA (rna-therapy)"
