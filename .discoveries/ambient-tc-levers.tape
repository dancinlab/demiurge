@V := "discovery" :: ambient-tc-levers [active]
  id      = "ambient-tc-levers-20260616"
  date    = "2026-06-16"
  domain  = "RTSC"
  host    = "mini (FREE local physics-reasoning scoping; NO pods rented, NO DFT fired)"
  seed    = "AMBIENT-PRESSURE room-temp SC hunt — branch OFF the flat-band-at-E_F kagome family (LaRu3Si2/LaOs3Si2 are λ-REFERENCE only: heavy atoms → low ω_log → conventional-Tc ceiling ~tens-of-K). Two independent levers: A=light-atom (ω_log↑) at ambient; B=flat-band correlation (non-phonon pairing, Tc not ω_log-bound)."
  method  = "pure first-principles BCS/Eliashberg reasoning + repo-internal knowledge (RTSC_LEDGER, flatband-at-ef-candidates, rtsc.candidates.md, QFORGE migration-gate). NO arXiv/web pull (c15). Ranked by (plausibility × cheapness-to-test)."
  honesty = "c9/c16 — negative=result; no fabricated numbers; unknowns marked unknown; lit-needs flagged [needs-lit-confirm·deferred]."

# ════════════════════════════════════════════════════════════════════════════
# FRAMING — why two levers, and what's already KNOWN/walled
# ════════════════════════════════════════════════════════════════════════════
# Tc_AD = (ω_log/1.2)·exp[−1.04(1+λ)/(λ−μ*(1+0.62λ))].  Two handles:
#   ω_log = phonon scale ≈ √(k/M)  → light atoms (H,Li,Be,B,C,N) + stiff covalent
#           bonds = high ω_log.  HEAVY-atom flat-band kagome (Ru101/Os190/Si28)
#           caps Tc at tens-of-K EVEN with big λ.  (LaRu3Si2 real Tc=7K confirms.)
#   λ     = el-ph coupling, boosted by N(E_F) (flat-band-at-E_F).
# KNOWN WALLS (do not re-derive):
#   W1  flat-band DOS too high → MAGNETISM/CDW not SC. The campaign's d7=winner /
#       d8=overshoot magnetic bracket (CoSn m=0.43; RbOs2O6 robust 3-5uB PBE;
#       CsV3Sb5 has CDW) IS this wall.  Any high-DOS pick must clear nspin=2 m<0.5.
#   W2  hydrides reach 200K+ but need MEGABAR (LaH10 250GPa, CaH6 170GPa, YH10
#       227K@250GPa, H3S). NOT ambient → out of scope as room-temp-AT-AMBIENT;
#       kept only as the pressure-bound contrast. Quench-to-ambient (A33) = metastable
#       gamble, structure not lit-verified.
#   W3  MgB2 already reproduced in-repo: λ≈0.99, ω_log≈723K, Tc_AD≈49K(μ*0.10).
#       = the LIGHT-ATOM (B sp²) ambient benchmark. Lever A's job: beat its ω_log×λ
#       product without triggering W1 or needing pressure.
#   W4  QFORGE/QE engine is DFPT-Eliashberg only (phonon-mediated). Lever B's
#       correlation pairing is INVISIBLE to it — needs DMFT/RPA+cRPA/flat-band MF
#       (NOT in the stack today). Lever B is METHOD-LIMITED for us right now (honest).

# ════════════════════════════════════════════════════════════════════════════
# LEVER A — LIGHT-ATOM (ω_log↑) flat-band/high-DOS at AMBIENT pressure
# phonon-mediated → TESTABLE by the canonical QE/QFORGE DFPT engine (the win)
# ════════════════════════════════════════════════════════════════════════════

@A A1 := "doped/intercalated covalent-metallic sp² boron-carbon framework (MgB2-beyond)" :: candidate [active]
  motif       = "MgB2-type sp² honeycomb light-element layers, electron/hole-tuned so a σ-band vHs (high-DOS, near-flat near zone edge) sits AT E_F. Members: Li-doped graphane/graphite intercalation (LiC2/CaC6-light analogues), B-C-N honeycomb (BC3, BC2N), Mg(1-x)Li/Na-xB2 hole-tuning, MgB2 biaxial-strain σ-band lift."
  stoich      = "Mg(1-x)NaxB2, LiBC (hole-doped Li1-xBC), BC3, CaC6 (light-cation graphite-intercalate)"
  why         = "B/C are light (M=11,12) → ω_log stays high like MgB2's 723K; the sp² σ-bond is the STIFFEST known light-atom bond (drives MgB2's coupling). Hole-doping LiBC empties the σ band to give an MgB2-like deformation potential with HIGHER σ-DOS at E_F → λ↑ at unchanged-high ω_log. This is the one lever where high-DOS does NOT trigger W1 magnetism (sp² σ electrons are bonding, not localized d/f — no Stoner)."
  killer_risk = "(a) hole-doped LiBC is dynamically UNSTABLE in many lit reports [needs-lit-confirm·deferred] — must check phonons (no imaginary modes). (b) dopant may go interstitial / not rigid-band. (c) σ-DOS gain may not beat MgB2 enough to clear room-temp (most predictions land <100K — honest ceiling: this family historically tops out double-digit-to-~100K, NOT 300K)."
  cheap_gate  = "QE scf+bands+projwfc on hole-doped LiBC (or Mg0.5Na0.5B2 supercell) → measure σ-band dE from E_F + N(E_F) vs MgB2 baseline; THEN a Γ-point phonon (or 2³q) dynamical-stability screen (any imaginary mode = killed)."
  cost_class  = "FREE-POOL — 3-6 atom cells, ambient, scf+bands+small-q DFPT all fit ubu/summer free-pool or vast CPU batch (same class as the in-repo MgB2 3-atom run). NO GPU."
  rank        = "A-1 (highest plausibility×cheapness: directly extends the repo's already-reproduced MgB2 anchor; identical engine/deck/cost; W1-immune by orbital character)."

@A A2 := "light-element line-graph lattice (B-/C-/Li- kagome or pyrochlore) — flat band from geometry, light atoms for ω_log" :: candidate [active]
  motif       = "Take the campaign's PROVEN flat-band-at-E_F line-graph geometry (kagome=line-graph of honeycomb; pyrochlore=3D) but build it from LIGHT atoms so ω_log isn't capped. Boron kagome layers, carbon kagome/Lieb nets (graphenylene-like), Li-on-kagome electride. This is exactly the in-repo wild-card A37 'Kagome-H3 / flat-band+H+frustration' made ambient and concrete."
  stoich      = "B-kagome (e.g. a borophene polymorph with kagome sublattice), C-based kagome net (graphenylene/biphenylene family), Li3X kagome electride, 'Kagome-H3' (H/B frustrated net)"
  why         = "marries BOTH handles in one lattice: line-graph geometry → flat band → λ↑; light atoms → ω_log↑. The heavy-atom kagome family (LaRu3Si2) already PROVES the flat-band-boosts-λ half works; swapping Ru101→B11/C12 lifts the ω_log ceiling ~3× (√(190/11)≈4× for Os). If a B/C kagome is metallic with FB-at-E_F, it is the cleanest 'both levers at once' shot."
  killer_risk = "(a) light-element line-graph nets are usually SEMICONDUCTING or not synthesizable as bulk (graphenylene is a wide-gap insulator; borophene kagome may not be the ground-state polymorph) → 'not metallic' / 'needs fabrication, not ambient bulk' is the dominant killer. (b) flat band of pure-p-orbital light atom may be too narrow → re-enters W1 (magnetism/charge order) OR Jahn-Teller distorts away. (c) most are metastable, not ambient-stable [needs-lit-confirm·deferred]."
  cheap_gate  = "QE scf+bands on a candidate light-kagome cell (start with a 3-atom boron-kagome or a known C-kagome net) → IS IT METALLIC and is a flat band within |dE|<0.1eV of E_F? (a pure free screen — bands only, no DFPT). If metallic+FB-at-E_F → nspin=2 m-check → only then DFPT λ."
  cost_class  = "FREE-POOL — bands-only screen on ≤6-atom cells is trivially free-pool; this is a band-structure triage before any phonon cost. NO GPU."
  rank        = "A-2 (highest UPSIDE — only candidate that combines both handles in one structure — but lower plausibility: 'metallic ambient-bulk light-kagome' is the hard, partly-unverified part; the bands-only gate is so cheap it's worth firing regardless)."

@A A3 := "light-electride / clathrate cage metal (interstitial-anion flat band, light framework)" :: candidate [active]
  motif       = "Electrides where the loosely-bound interstitial 'anionic electron' forms a narrow (flat-ish) band at E_F, hosted in a LIGHT framework (Li/Be/B/C/N cage or layer). Examples: light-cation electrides (LiH-based / Be-N electride), light clathrate cages (sp³ C/Si-light clathrate, Mg/Ca-in-cage), C/B-N clathrate."
  stoich      = "Li-N / Be-N electride (e.g. Be2N-electride class), light sp³ clathrate (C34/C46-type carbon clathrate doped), 'Mackay LaBe6H12' (in-repo B11) repositioned as a light Be-H cage"
  why         = "the interstitial-electron flat band gives high N(E_F) DECOUPLED from any d/f shell → sidesteps W1 Stoner magnetism by construction (the DOS is free-electron-like interstitial, not localized). A LIGHT cage keeps ω_log high. The in-repo LaCoSi NOVEL probe (electride FB +33meV) is the heavy-atom proof-of-concept; the light-framework version is the ambient-room-temp aim."
  killer_risk = "(a) electride anionic-electron bands are typically LOW-DOS / dispersive (not truly flat) → λ gain modest. (b) clathrate light cages (carbon clathrate) are HIGH-PRESSURE-synthesized or metastable → re-enters W2/ambient-stability question [needs-lit-confirm·deferred]. (c) electron correlation in the interstitial band may need beyond-DFPT (touches Lever B)."
  cheap_gate  = "QE scf+bands+(ELF/charge-density) on a small light-electride cell → is the interstitial band at E_F and how flat (bandwidth)? + N(E_F). Bands+ELF only = free."
  rank        = "A-3 (distinct W1-immune mechanism + fresh family, but lower plausibility: light electride flat bands are usually not flat ENOUGH and cage stability is shaky; good diversification, not the lead)."

@A A4 := "metallic-hydrogen-LITE: covalent N/C-H or B-H ambient framework (light without megabar)" :: candidate [active]
  motif       = "Capture some of the hydride ω_log WITHOUT megabar pressure by chemically pre-compressing H into a covalent ambient framework: C-H / N-H / B-H molecular-crystal or framework metals where H-derived high-frequency modes survive at 1 atm. In-repo B03 H2B2, B12 BeB2Hx, A19 BeB2N2Hx, R3 pnictogen-H."
  stoich      = "H2B2, BeB2Hx, C-H framework (doped polyacene/graphane-metal), N-H framework"
  why         = "H is the lightest atom → highest possible ω_log; the entire hydride success rests on it. The ambient gambit is to use chemical (covalent-bond) pre-compression instead of mechanical pressure to keep H-modes stiff and the system metallic at 1 atm."
  killer_risk = "DOMINANT and well-evidenced: ambient C-H/N-H/B-H frameworks are almost always INSULATORS or molecular (not metallic) — that's exactly WHY hydrides need pressure to metallize. 'not metallic at ambient' is the near-certain killer. This is the lowest-plausibility lever-A branch (honest: likely a known dead-end at ambient; W2 is the wall it keeps hitting)."
  cheap_gate  = "QE scf on H2B2 / BeB2Hx at 1 atm (0 GPa) → metallic? N(E_F)>0? If insulating → killed immediately (free, single scf)."
  rank        = "A-4 (lowest — included for completeness; high chance of a fast honest negative. The cheap gate is a 1-scf metallicity check, so it's cheap to RULE OUT)."

# ════════════════════════════════════════════════════════════════════════════
# LEVER B — FLAT-BAND CORRELATION (non-phonon pairing; Tc not ω_log-bound)
# pairing scale = U / J / bandwidth, NOT phonons → DFPT-Eliashberg does NOT test it.
# HONEST: this lever is METHOD-LIMITED for us NOW (no DMFT/cRPA/flat-band-MF in stack).
# ════════════════════════════════════════════════════════════════════════════

@B B1 := "isolated flat-band intermetallic at E_F (quench-the-bandwidth → U≫W superconductivity)" :: candidate [active]
  motif       = "A near-dispersionless band exactly at E_F in a real ambient bulk crystal (the kagome/pyrochlore/Laves family the campaign ALREADY mapped: CaNi2, CsTi3Bi5, Sc2Ir4-xSix). When bandwidth W → 0, the SC scale is set by the interaction U/J and band TOPOLOGY (quantum-metric/Berry), NOT by ω_log — so Tc is NOT phonon-capped."
  why_correl  = "flat-band SC: the pair condensation energy ∝ interaction × quantum geometric tensor (not ω_log·exp(−1/λ)). For an ideal flat band Tc can scale LINEARLY with interaction (no exponential BCS suppression) → in principle escapes the ω_log ceiling that sinks heavy-atom phonon SC."
  what_tests  = "NOT DFPT. The real tools: (i) flat-band mean-field / BCS-with-quantum-metric (analytic, tractable LOCALLY — closed-form once you have the Bloch wavefns + quantum-metric from a tight-binding/Wannier fit); (ii) cRPA for the on-site U of the flat band (needs build-out); (iii) DMFT for the correlated solution (NOT in stack); (iv) exact-diag of a flat-band Hubbard toy (tractable LOCALLY for small clusters)."
  killer_risk = "(a) W1 again — a flat band at E_F with strong U is the textbook MAGNETIC/Mott state (flat-band ferromagnetism, Lieb's theorem); SC is the SUBDOMINANT instability and needs fine-tuning. (b) our engine CANNOT compute the SC Tc here — DFPT gives λ=0-relevance; we can only compute the INGREDIENTS (flatness, quantum metric, U), not the verdict. (c) quantum-metric SC is a frontier theory; mapping ingredients→Tc is not a settled recipe [needs-lit-confirm·deferred]."
  cheap_gate  = "FREE-LOCAL & method-honest: from a QE/Wannier band of an existing campaign candidate (CaNi2 or CsTi3Bi5 — already in flatband-at-ef tape), extract the flat-band bandwidth W and the quantum-metric integral (Berry/quantum-geometry of the isolated flat band). A small flat-band Hubbard exact-diag toy (the hexa autograd/flame stack can host a tiny ED) gives a qualitative U/W pairing-vs-magnetism phase point. This is a LOCAL toy/analysis, not a production Tc."
  cost_class  = "FREE-LOCAL (analysis on existing bands + tiny ED toy) for the INGREDIENTS. A real correlated Tc verdict = NEEDS BUILD-OUT (cRPA/DMFT not in stack) — honestly out of reach now."
  rank        = "B-1 (best of Lever B: reuses bands the campaign already computes; the ingredient-extraction is genuinely free-local; but the Tc verdict itself is method-blocked — this is a SCOPING/ingredient gate, not a closure gate)."

@B B2 := "moiré / twisted-bilayer flat band (magic-angle-graphene-class)" :: candidate [active]
  motif       = "Twist-engineered flat bands (magic-angle TBG and relatives). In-repo A21-A24 (TBL-YH3, TBL-LaH3, graphene+H, CNT-H)."
  why_correl  = "magic-angle flat band → correlated SC at the band-filling sweet spot; pairing is interaction-driven (the canonical correlation-flat-band SC). Tc not ω_log-bound."
  killer_risk = "OUT OF AMBIENT-BULK SCOPE (already flagged in flatband-at-ef tape): a twisted bilayer is a FABRICATED device (twist angle, gating), NOT an ambient bulk crystal — the campaign's no-cooling thesis is bulk-material. Also Tc is LOW (~1-3K in TBG). And the moiré supercell is HUGE (thousands of atoms) → DFT-intractable; only continuum/tight-binding models apply."
  what_tests  = "continuum Bistritzer-MacDonald + Hubbard mean-field / RPA on the moiré band (model-level, NOT DFT). Tractable as a toy model only."
  cheap_gate  = "NONE that advances the bulk-ambient campaign — would be a model-toy exercise. Recommend NOT firing (scope mismatch)."
  cost_class  = "N/A for our engine (supercell DFT-intractable; model-only)."
  rank        = "B-2 (de-prioritized: scope mismatch (not bulk-ambient) + low Tc + engine-intractable. Documented to mark the boundary, not to pursue.)"

@B B3 := "heavy-fermion / near-quantum-critical correlated SC (f-electron flat band)" :: candidate [active]
  motif       = "f-electron heavy-fermion compounds where a renormalized flat (heavy) band at E_F gives correlation-driven (often unconventional/d-wave) SC near a magnetic QCP. The campaign already brushes this (CeRu2 in flatband-at-ef tape, Ce-4f weak-mag risk)."
  why_correl  = "pairing glue = magnetic/valence fluctuations (J), not phonons → Tc set by the Kondo/RKKY scale, ω_log-irrelevant. Genuinely non-phonon."
  killer_risk = "(a) Tc historically LOW (heavy-fermion SC is ~1-2K, mK-scale) — wrong end of the temperature axis for a room-temp hunt. (b) needs DMFT/DMFT+DFT (NOT in stack) — the f-electron correlation is the whole physics and DFT alone fails it. (c) W1: these sit NEXT TO magnetism by definition. (d) [needs-lit-confirm·deferred] on any specific ambient high-Tc f-electron lead — none known."
  what_tests  = "DFT+DMFT (LDA+DMFT) — build-out, not in stack. cRPA for J. Not locally tractable today."
  cheap_gate  = "NONE cheap/free that gives a room-temp-relevant answer (DMFT build-out required). Honest: out of reach + wrong Tc regime."
  rank        = "B-3 (lowest: low-Tc regime + DMFT-blocked + magnetism-adjacent. A correlation-pairing reference, not a room-temp candidate — analogous to how heavy-atom kagome is a λ-reference.)"

# ════════════════════════════════════════════════════════════════════════════
# RANKED SUMMARY + RECOMMENDED NEXT FREE/CHEAP FIRE
# ════════════════════════════════════════════════════════════════════════════
@D ranking := "(plausibility × cheapness-to-test) ordering" :: pick [active]
  leverA_top3 = "A-1 doped-LiBC / Mg(Na)B2 (extend reproduced MgB2 anchor; W1-immune sp²; FREE-POOL scf+bands+small-q) > A-2 light-element kagome/Lieb (both handles in ONE lattice = highest upside; FREE-POOL bands-only triage) > A-3 light electride/clathrate (fresh W1-immune mechanism; FREE-POOL bands+ELF)."
  leverB_top3 = "B-1 isolated flat-band-at-E_F (reuses campaign bands; ingredient-extraction FREE-LOCAL, but Tc verdict METHOD-BLOCKED) > B-3 heavy-fermion f-band (non-phonon reference, low-Tc + DMFT-blocked) > B-2 moiré/TBG (scope-mismatch, not bulk-ambient)."
  best_cheap_fire_A = "A-2 light-element kagome BANDS-ONLY metallicity+flat-band-at-E_F screen — single FREE-POOL scf+bands on a ≤6-atom B-kagome (or known C-kagome net) cell; PASS = metallic AND |dE|<0.1eV. It is the cheapest possible test of the single highest-upside idea (both ω_log + λ handles in one structure). If it's an insulator/non-flat, killed for ~$0. (A-1 LiBC is the safer/higher-plausibility runner-up and is ALSO free-pool — fire both in parallel per d_parallel_first; A-1 reuses the existing MgB2 deck so it's nearly zero marginal setup.)"
  best_cheap_fire_B = "B-1 ingredient extraction on a band the campaign ALREADY has (CaNi2 or CsTi3Bi5 from flatband-at-ef-candidates tape): compute flat-band bandwidth W + quantum-metric of the isolated FB + tiny flat-band-Hubbard ED toy locally (hexa autograd/flame). FREE-LOCAL, no pod. HONEST CAVEAT: yields INGREDIENTS only (flatness, geometry, U/W phase tendency) — NOT a correlated Tc; a real Lever-B Tc needs cRPA/DMFT build-out (not in stack). So fire it to SCOPE the lever, not to close it."
  free_vs_paid = "ALL Lever-A cheap gates (A1-A4) are FREE-POOL-gateable (≤6-atom ambient cells; scf+bands±small-q DFPT — same class as the reproduced 3-atom MgB2 run; per d7 small-cell = pool-free, NO GPU). DFPT λ on a PASS escalates to vast q×irr GRID (d_qforge_parallel) — still small-cell, CPU-batch, no GPU needed. Lever-B B-1 ingredient gate is FREE-LOCAL (analysis + tiny ED). Lever-B Tc VERDICT (B-1/B-3) needs cRPA/DMFT build-out = NOT a pod-rent, a STACK build-out (out of scope now). B-2 moiré is DFT-intractable (huge supercell) → model-only, not pod-gateable."

@D the_single_pick := "one recommended next FREE fire" :: pick [active]
  pick   = "FIRE (free-pool, parallel per d_parallel_first): A-1 hole-doped LiBC scf+bands+small-q (reuses MgB2 deck, highest plausibility, W1-immune) AND A-2 light-kagome bands-only metallicity screen (highest upside, cheapest possible). Both ≤6-atom ambient, free-pool/vast-CPU, NO GPU. If you can only fire ONE: A-1 LiBC — it directly extends the repo's already-reproduced MgB2 anchor (λ≈0.99/ω_log 723K) with near-zero marginal setup and the cleanest path to beating MgB2's ω_log×λ without W1 magnetism."
  honest = "HONEST CEILING (c9): Lever A is phonon-bound — even the best light-atom ambient family historically tops out far below 300K (MgB2 39K; doped-graphene/LiBC predictions <~100K). The room-temp prize most plausibly lives in Lever B (ω_log-unbound correlation SC) — but Lever B is METHOD-BLOCKED for us today (no DMFT/cRPA/flat-band-MF in the QE/QFORGE stack). So the honest near-term move is: harvest Lever A's free phonon-mediated gains (concrete, testable now) WHILE flagging the Lever-B method build-out (cRPA/DMFT or quantum-metric flat-band MF) as the real long-pole for ambient room-temp. Do NOT present Lever A as a room-temp path it cannot reach."
