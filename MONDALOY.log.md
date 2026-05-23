# MONDALOY — historical log

Spec at [`./MONDALOY.md`](./MONDALOY.md). Entries below preserve the
session-by-session evolution; the spec file holds only the current
confirmed state.

## Log

- **2026-05-23 KST** — **§9.7 Wet-lab handoff prep EXECUTED — cockpit
  gate-product for `demiurge-SX500-RE-c1`.** The non-wet-lab pipeline's
  final manifest: c1 composition table (wt% target + tolerance + at%
  derived: Al 5.0 wt% = **10.13 at%** confirms Giggins-Pettit region-III
  with margin), raw-material purity minima (S ≤ 5 / P ≤ 10 / O ≤ 30
  wppm — reactive-element-effect ceilings), two synthesis protocol stubs
  (route A: VIM + investment-cast polycrystalline coupon, 2-3 wk; route
  B: gas-atomise + LPBF + HIP, 4-6 wk), four characterisation stubs
  (TGA k_p @1100C · γ′ vol frac SEM/SAXS · thermal-cycle scale adhesion
  · XRD/EBSD TCP screen), 10-point reproducibility checklist, and
  wet-lab partner shortlist (Cambridge UTC · Ohio State CHTM · MPIE ·
  ORNL MDF · Haynes Intl). `provisional=true` · `absorbed=false` ·
  `simulation-only-prediction` — this is the *manifest*, not a
  measurement. d6 absolute: SX500 itself stays `absorbed=false`
  permanently in demiurge; any future `absorbed=true` flip permitted
  only on the analog reference (Haynes-214 / René-N5 class) as a
  separate exports/ record. d2 breakthrough on the printability wall
  surfaced *now*: if route B hot-cracks, re-run §9.6 with lower (Al+Ti)
  loading → candidate **c2** (concrete path, not concession). Record:
  `exports/material_discovery/sx500_mondaloy_candidate_c1_wetlab_handoff_20260523.json`.
  D1 clean-room satisfied (protocols pinned to Reed 2006 + Pollock 2006
  + Haynes 214 datasheet — public alumina-former practice, no SX500
  process disclosure).
- **2026-05-22 KST** — **§9.6 §7 forward funnel EXECUTED → single
  candidate `demiurge-SX500-RE-c1`.** Collapsed the §9.4 envelope to one
  composition via public superalloy-design rules (no proprietary
  Thermo-Calc TCNI this session — analytically-tractable funnel):
  Giggins-Pettit Ni-Cr-Al oxidation map (Al 5.0 wt% + Cr 20 wt% →
  region III continuous α-Al₂O₃) · γ′/printability window (Al+Ti 6.5
  → ~35-40 % γ′, AM-processable) · PHACOMP TCP avoidance (Cr≤20,
  Mo 3.5) · reactive-element effect (Hf 0.3 + Y 0.05). Candidate
  wt%: Ni bal 57.6 · Cr 20 · Al 5 · Co 12 · Mo 3.5 · Ti 1.5 · Hf 0.3
  · Y 0.05 · C 0.05 · B 0.005. Estimated: γ′ 35-40 %, α-Al₂O₃
  parabolic k_p ~1e-13–1e-12, ρ ~8.3 g/cm³, n=6 principal = Ni·Cr·
  Al·Co·Mo·Ti. Record: `exports/material_discovery/sx500_mondaloy_
  candidate_c1_20260522.json`. d6: open candidate, not SX500 itself,
  `absorbed=false`. Next rigor: pycalphad phase-equilibrium + DFT
  scale-adhesion.
- **2026-05-22 KST** — **§9 Reverse-engineering EXECUTED** (this
  session). Patent forensics: USPTO/Google-Patents assignee "Space
  Exploration Technologies" class C22C19/05 → **zero SX500 patents** —
  SpaceX protects SX500 as a trade secret (no patent disclosure), an
  informative null result. Analog brackets compiled (Inconel 625/718
  chromia-formers · René N5 alumina-former) — SX500 triangulated
  *between* them. Decisive physics: ox-rich 810 bar + coating-free →
  Cr₂O₃ volatilises >1300 K → SX500 **must be α-Al₂O₃-forming** → Al
  far above stock-Inconel ≤0.8 wt% + reactive element (Hf/Y/Zr).
  **Deliverable**: a reverse-engineered open SX500-class composition
  envelope (Ni 55-62 · Cr 16-22 · Al 3.5-6.0 · Co 8-15 · Mo 2-6 · Ti
  1-3 · Hf 0.1-0.5 · Y/Zr 0.01-0.1 wt%; n=6 elements = Ni·Cr·Al·Co·
  Mo·Ti). Record: `exports/material_discovery/sx500_mondaloy_reverse_
  engineered_envelope_20260522.json`. d6 boundary held — inference not
  SX500 itself, `absorbed=false`, `simulation-only-prediction`; d2
  breakthrough = open functionally-equivalent alloy bypasses the
  trade-secret wall. D1 clean-room satisfied (patent reading + public
  datasheets + thermodynamics — no trade-secret extraction).
- **2026-05-22 KST** — **§7 Design ideas + §8 Reverse-engineering ideas
  added** (arxiv + web deep-research). Naming resolved: the publicly-
  disclosed SpaceX alloy is **SX500** (SX250→SX300→SX500 lineage,
  ~810 bar hot-O₂, "modern Inconel-derivative", cast + 3D-printed) —
  "MondAloy" is the upstream `hexa-space` draft label; same target.
  §7 = a concrete 7-verb forward design pass (CALPHAD funnel mirroring
  the published 779,625→12 precedent · DFT O-vacancy + scale-adhesion ·
  physics-descriptor ML creep arxiv:2212.06755 · CNN-LSTM oxidation ·
  printability gate); biggest design lever = an α-Al₂O₃-forming
  (reactive-element-stabilised) scale beats Cr₂O₃ in ox-rich because
  Cr₂O₃ volatilises as CrO₃/CrO₂(OH)₂ above ~1300 K. §8 = clean-room
  reverse-engineering (constraint triangulation · USPTO/Espacenet
  patent forensics on assignee "Space Exploration Technologies" CPC
  C22C19/05 · oxide-scale colour forensics on public Raptor-3 photos ·
  process-of-elimination via the §7 forward pipeline · analog
  benchmarking vs Inconel 625/718 · Haynes 282 · René N5 + declassified
  RD-170/180 · ML inverse design via MATAI arxiv:2511.10108 /
  arxiv:1803.03039 / arxiv:2108.12019). d6 boundary held: RE yields a
  spec-matching *candidate*, never SX500 itself; d2 breakthrough = an
  open functionally-equivalent alloy sidesteps the trade-secret wall.
  Sources: teslarati/nextbigfuture/fabbaloo (SX500 public surface) ·
  RD-170 grokipedia/astronautix · USPTO oxidation-resistant-coating
  patents · ScienceDirect Ni-superalloy computational-design papers.
- **2026-05-22 KST** — **demiurge `MONDALOY.md` domain doc opened.**
  Located the upstream draft `hexa-space/mondaloy/mondaloy.md`
  (combustion-resistant superalloy verb, operations group 16/16,
  drafted 2026-05-07). Promoted to a demiurge materials-domain doc as
  the sibling of `RTSC.md`/`NUCLEAR.md`: MondAloy = SpaceX-proprietary
  Ni-base combustion-resistant superalloy (Raptor 3 combustion chamber
  + ox-rich preburner lining). Composition is a SpaceX trade secret —
  demiurge doc is framed as a *discovery-target / bounding* exercise
  (§3 CALPHAD + DFT pipeline that needs no proprietary data; §4 d2
  breakthrough framing — bound the class, inverse-design a candidate,
  or measure a public analog). The upstream n=6 lattice mapping
  (σ·φ = n·τ = 24) is recorded in §5 explicitly as numerology /
  count-coincidence — **out of scope** for any `absorbed`/gate
  decision (d6/d7, same carve-out RTSC.md applies to hexa-atlas n6
  "Tc 300K"). `absorbed=false` · no measured oracle · no `exports/`
  record emitted yet.

- **2026-05-07 KST** (upstream, hexa-space) — `hexa-space/mondaloy/`
  drafted: `mondaloy.md` (v1.0.0 SPEC_ONLY) + `verify_mondaloy.hexa`
  (n=6 count-lattice invariant calculator · sentinel
  `__HEXA_MONDALOY_VERIFY__ PASS`). Upstream §4 explicitly states the
  verify script "does NOT model thermomechanical behavior" — count
  lattice only. `@canonical: pending-upstream`.
