@V := "discovery" :: rtsc-caauh3-dft-elph [active]
  date    = "2026-05-30"
  seed    = "Ca-substituted SrAuH3 cubic perovskite-hydride (lighter/smaller A-site) — tune Au-H octahedral mechanism to higher Tc / lower P"
  domain  = "RTSC"
  verdict-tier-target = "DFT el-ph harvest -> Allen-Dynes Tc (TERMINAL, this repo)"

# TERMINAL VERDICT — closed-negative (g63 · d_paper_negative_ok)
@F f1 := "cubic Pm-3m CaAuH3 is DYNAMICALLY UNSTABLE at ~23 GPa" :: closed-negative [active]
  q_grid  = "4x4x4 COMPLETE 10/10 IBZ, star weights 1,6,3,12,12,3,8,12,6,1 sum=64 (full BZ)"
  imag    = "4/10 q soft: R-point(-0.5,-0.5,-0.5) -324cm-1 x3 octahedral rotation; -293, -261, -25 cm-1 elsewhere"
  lambda  = "full-BZ verbatim lambda=-2.08 (NEGATIVE, soft-mode divergence) -> no valid Tc; real-mode-only lambda=0.92"
  Tc      = "real-mode (if-stabilized) Allen-Dynes Tc=20.3K (mu*0.10)/17.1K (mu*0.13) — weak-coupling LOW-Tc; both hexa-verified GREEN"
  status  = "TERMINAL — cubic phase NOT a superconductor (unstable) AND low real-mode lambda; high-Tc/RTSC hypothesis FALSIFIED on 2 axes"
  pressure = "el-ph cell ~23 GPa (scf START cell, celldm patch did not apply); vc-relax converged 5 GPa — both high-P, not ambient"
  record  = "exports/material_discovery/rtsc_caauh3_dft_elph_20260530.json"

# breakthrough paths (d2 — never concede)
@X n1 := "follow soft eigenvectors to a distorted (tilted) phase + re-run el-ph" :: novel [active]
  rationale = "R-point octahedral-rotation soft mode = condense into tetragonal/orthorhombic tilted perovskite (true ground state) -> may be dyn-stable with different lambda"
  target  = "DFT el-ph on the distorted phase: is the TRUE structure stable, and is its Tc higher?"
  tier    = "speculation-fenced until DFT"

@X n2 := "pressure sweep — stiffen the R-point soft mode" :: novel [active]
  rationale = "higher P often stiffens octahedral-tilt soft modes; re-run at the 5-GPa relaxed cell AND at >23 GPa to find a dyn-stable window"
  target  = "DFT el-ph P-scan: locate dyn-stable pressure for cubic CaAuH3 (if any) + its Tc"
  tier    = "speculation-fenced until DFT"

@X n3 := "full-relativistic Au SOC cross-check" :: novel [active]
  rationale = "Au is 5d; scalar baseline omits SOC which can reshape Fermi surface + soft-mode landscape near Ef"
  target  = "lspinorb=.true. el-ph: does SOC change stability / lambda?"
  tier    = "speculation-fenced until DFT"
