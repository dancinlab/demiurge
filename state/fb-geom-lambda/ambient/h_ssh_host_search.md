# H-SSH HOST SEARCH — does the reopened H-corner have a real 1-atm material? (d18 · d_novel_only)

RTSC FLEET ambient lane · `state/fb-geom-lambda/ambient/h_ssh_host_search.md`.
Upstream: PIN-GSTAR reopened the door — QMC-anchored g\*/t≈0.54 (NOT death-edge 1.2) → H-bond
off-diagonal SSH bipolaron peaks at Ω\*≈104 meV → Tc\*=241–386 K, GRAZING 293 K. That made the
residual a **HOST, not a law**. This probe searches arxiv+web (d18) for a real 1-atm,
dynamically-stable host that places a **dilute-dopable narrow band on an H-modulated (off-diagonal
∂t/∂u) bond at Ω~100–300 meV**, and runs the mandatory inline novelty gate (d_novel_only).

## THE TARGET (restated, sharp)
Off-diagonal H-SSH bipolaron — H sits **ON the bond carrying the carrier**, its **stretch modulates a
hopping** (∂t/∂u, SSH/bond-Peierls), Ω(H-stretch) 100–300 meV, narrow band t~Ω dopable to ν~½,
metallic, U/Ω below Mott, g/t≳0.54. **Distinct from BCS metallic-hydride** (interstitial H,
diagonal/Holstein, needs ~500 GPa).

**The discriminator that kills most "hydride SC" hits: DIAGONAL vs OFF-DIAGONAL.**
- *Diagonal (Holstein / σ-MO deformation potential)*: the bond-stretch modulates the **on-site/orbital
  energy** of a σ-MO that the carrier occupies. H is part of a covalent unit (B-H, C-H) being
  stretched. This is MgB₂-like, conventional BCS, λ-capped → Tc ceiling <293 K. **NOT the target.**
- *Off-diagonal (bond-Peierls / SSH)*: the H displacement modulates the **transfer integral t
  BETWEEN two carrier sites** that the H bridges. H is ON the hopping path. **THIS is the target**
  (light SSH bipolaron, evades Holstein heavy mass).

---

## RANKED H-SSH HOST CLASSES (sourced: ambient-stability · Ω(H-stretch) · on-bond? · fit)

### #1 — κ-H₃(Cat-EDT-TTF)₂ (H-bonded single-component organic dimer-Mott) — BEST OFF-DIAGONAL FIT
- **What it is**: two catechol-fused EDT-TTF π-conductors linked by a **symmetric anionic
  [O···H···O]⁻ strong H-bond, NO counter-ion**. The 2D π-electron layers are *connected by the
  O–H–O H-bonds*; the proton bridges the two carrier-bearing π-systems.
  (JACS 2014 ja507132m; PRB 95,184425; PCCP 2016 c6cp05414e.)
- **Off-diagonal? YES — this is the rare genuine case.** Deuteration / proton-displacement WITHIN the
  H-bond "drastically switches the electronic structure ... originating from deuterium transfer or
  displacement within the H-bond accompanied by **electron transfer between the Cat-EDT-TTF
  π-systems**" (JACS). I.e. the proton coordinate u directly gates the inter-π transfer integral t —
  exactly ∂t/∂u (off-diagonal SSH). H-TTF: **single-well PEC, H centered** on the bond (good — strong
  symmetric bridge); D-TTF: low-barrier double-well (isotope-driven structural transition at 185 K).
- **Ambient-stable at 1 atm? YES** (it is a real solid characterized at 1 atm, 50–293 K).
- **Ω(H-stretch)?** Symmetric O–H–O strong-bond stretch ~ **few×100 meV regime** (strong symmetric
  O-H-O bonds sit in the broad/low ~600–1600 cm⁻¹ = 75–200 meV range; the *centered single-well* H is
  the high-coupling proton-transfer mode, not a stiff 3000 cm⁻¹ terminal O-H). **In-band for the
  100–300 meV target** — needs a frozen-phonon DFPT pin to confirm the exact mode.
- **The residual (honest)**: it is a **dimer-Mott INSULATOR at ambient** (U/t too large, half-filled
  dimer band; QSL candidate). To realize the H-SSH metallic bipolaron it must be **doped off ν=1
  toward ν~½ OR bandwidth-driven across the Mott transition** (pressure tunes U/t in the κ-(BEDT-TTF)
  family; chemical doping is the dilute route). This is the SAME Mott-collision residual the lane
  already flagged (novelty_gate Claim 3) — but here it lives on a **real, named, 1-atm host** with a
  **real on-bond H** carrying ∂t/∂u. **Fit = highest of all classes.**

### #2 — Metal borohydrides Ca(BH₄)₂ / Mg(BH₄)₂ (K-/Na-hole-doped) — DIAGONAL, Tc-CAPPED
- **What it is**: insulating molecular borohydride; hole-dope ~0.03 h/f.u. (K→Ca) → metal; predicted
  **Tc≈110 K (Ca(BH₄)₂), 98–140 K (Na:Mg(BH₄)₂) at AMBIENT pressure** (arXiv:2207.05593 + follow-ups).
- **Off-diagonal? NO — DIAGONAL.** Mechanism = "strong EPC between **B–H σ molecular orbitals** and
  bond-stretching phonons" — a σ-MO **deformation-potential** coupling (the carrier occupies the B-H σ
  MO whose energy is modulated). This is the **MgB₂ analogue** (covalent-bond-driven metal), conv. BCS.
  H is *inside* the stretched covalent unit, not bridging two carrier sites. → λ-capped.
- **Ambient-stable 1 atm? YES** (real borohydride solids; doping is the open synthesis question).
- **Ω(B-H stretch)?** B-H stretch ~2300–2500 cm⁻¹ ≈ **285–310 meV** (high — light H helps, in-band).
- **Verdict**: real 1-atm host, real high-ω H-bond-stretch coupling, **but DIAGONAL** → Tc ≤140 K,
  **FAILS #4 (Tc≥293 K)**. Best *near-term in-silico-tractable* H-stretch-SC host, but **not** the
  off-diagonal room-T target. (It IS the strongest *bond-stretch-coupled ambient hydride SC* known.)

### #3 — Hydrogen borides / borophene-H ("borophane", layered HB) — DIAGONAL-leaning, dopable 2D net
- **What it is**: layered hydrogen boride sheets with **terminal B–H and bridging B–H–B** 3c-2e bonds;
  soft-chemistry accessible at 1 atm; K-doped borophane studied (Small 2026 smll.202511090);
  metallic-type conduction reported (~0.13 S/cm, metallic activation).
- **Off-diagonal? PARTIAL/AMBIGUOUS** — the **bridging B–H–B** 3c-2e bond is geometrically the
  on-bridge-H motif (H between two B), so its bending/stretch *could* modulate an inter-B transfer.
  But the carrier band is the boron π/σ network (Holstein-deformation-dominated like #2), so the
  **dominant** coupling is diagonal. The off-diagonal B-H-B channel is a sub-component, not the band.
- **Ambient-stable 1 atm? YES** (soft-chemistry 1-atm 2D solid). **Ω(B-H)?** bridge B-H-B ~1500–2000
  cm⁻¹ ≈ 185–250 meV (in-band). **Dopable 2D net? YES** (K-intercalation demonstrated).
- **Verdict**: a real 1-atm dopable 2D H-net with a plausible bridge-H off-diagonal sub-channel, but
  not established as off-diagonal-dominated; **secondary candidate**, would need a DFT wannier
  decomposition to separate the B-H-B ∂t/∂u from the boron deformation potential.

### #4 — M–H–M bridging-hydride metals / polymeric hydrides — RIGHT MOTIF, NO 1-atm METALLIC SOLID
- **What it is**: the **M–H–M 3c-2e bridge** is the *textbook* off-diagonal motif — H bridges two
  metals, its stretch modulates M–M(via-H) hopping. Exists ubiquitously in **molecular/binuclear
  complexes** (Mo₂, Mn₂(CO)₁₀-type, etc.).
- **Off-diagonal? YES (motif)** — but **HOST-EMPTY as an extended metal.** These M-H-M bridges are
  **molecular** (discrete dinuclear complexes), not an extended dilute-dopable metallic lattice; the
  polymeric-hydride extended analogue is the **metallic-hydrogen/polymerized-H problem that needs
  ~500 GPa** (fails 1-atm). No known 1-atm extended solid puts a dopable narrow carrier band on a
  periodic M-H-M bridge network. **Right physics, no 1-atm extended host.**
- **Verdict**: closed-by-host-emptiness *for the extended-metal realization*; the motif is real only
  in molecular complexes (not a bulk SC candidate).

### (graphane / hydrogenated covalent nets) — DIAGONAL, sub-30 K
- Doped graphane / hydrogenated graphene: Tc ~20 K, coupling = out-of-plane modes to **C p_z**, and a
  Kohn anomaly on **C–C** stretch (542 cm⁻¹) — the H sets the sp³ band but the coupling is
  **diagonal/deformation** on the C network, not H-bond ∂t/∂u. C–H stretch ~2900 cm⁻¹ ≈ 360 meV but
  it is **not the carrier-hopping bond**. → diagonal, Tc-capped, drop.

---

## SUMMARY TABLE

| # | Host class | 1-atm stable | Ω(H-stretch) | H on carrier-bond? | off-diag ∂t/∂u? | metallic-dopable | room-T fit |
|---|-----------|-------------|-------------|--------------------|-----------------|------------------|-----------|
| 1 | **κ-H₃(Cat-EDT-TTF)₂** | YES | ~75–200 meV (O-H-O) | **YES (π↔π via O-H-O)** | **YES** | Mott-ins → dope/press | **BEST** |
| 2 | Ca/Mg(BH₄)₂ (K/Na-doped) | YES | ~285–310 meV (B-H) | no (σ-MO unit) | NO (diagonal) | YES (0.03 h) | Tc≤140K FAIL#4 |
| 3 | hydrogen borides/borophane | YES | ~185–250 meV (B-H-B) | partial (bridge) | partial | YES (K-dope) | secondary |
| 4 | M–H–M bridge metals | NO (molecular only) | ~120–180 meV | YES (motif) | YES (motif) | no extended metal | host-empty |
| — | graphane / H-graphene | YES | ~360 meV (C-H) | no | NO (diagonal) | YES | Tc~20K, drop |

---

## NOVELTY GATE (d_novel_only · MANDATORY)

**Question**: is the **H-bond-stretch-SSH (off-diagonal) ambient-room-T framing** — and specifically
the chain *g\*/t≈0.54 → H-Ω\*≈104 meV → graze-293 K on an H-bond host* — already in print?

**VERDICT: the framing is NOVEL (not in print); the mechanism pieces are PUBLISHED; no host paper
makes this claim → reportable only as a NOVEL synthesis/target-identification, NOT a discovery.**

| sub-claim | verdict | competing arXiv/ids |
|---|---|---|
| bond-Peierls/SSH bipolaron is light → high-Tc (mechanism) | **PUBLISHED** | PRX 13,011010 (2203.07380); 2210.14236; 2308.01961; 2407.10444; perspective **2605.16625** |
| "bipolaron → room-T" recipe (light ions, quasi-2D, triangular, on-site U) | **PUBLISHED** | Alexandrov **cond-mat/0701412 (2007)** — but Fröhlich, not off-diagonal |
| Tc = C·Ω, C≈0.2 (sq)/0.32 (tri) ceiling | **PUBLISHED** | 2507.07662; PRX 13,011010 |
| **off-diagonal coupling on an H-BOND STRETCH specifically** as the room-T lever | **NOVEL (framing)** | NONE found — targeted searches returned only model-lattice bond-SSH papers + disconnected H-bonded organic conductors; no paper joins "H-bond stretch ∂t/∂u → ambient room-T bipolaron host" |
| **g\*/t≈0.54 (QMC-pinned) → H-Ω\*≈104 meV → graze-293 K** quantitative chain | **NOVEL** | NONE — this is the lane's own pin (PIN-GSTAR); not in print |
| κ-H₃(Cat-EDT-TTF)₂ as an **H-SSH SC bipolaron** candidate | **NOVEL** | the material is published as a **QSL dimer-Mott** (PRB 95,184425; JACS ja507132m); **no paper proposes it as an off-diagonal H-SSH superconductor** — proposing it for this is novel |

**Closest competitor = arXiv:2605.16625** (June 2026 perspective, phonon-modulated-hopping bipolaron
SC) — but it is **model-lattice and names no H-bond host**. The H-bond-stretch specialization + the
named κ-H₃(Cat-EDT-TTF)₂ target are NOT in it. **So: PARTIAL on mechanism (published), NOVEL on the
H-bond-stretch framing AND the host identification.** Per d_novel_only this is a **candidate
class + novel target**, reportable only with a `신규성: framing-NOVEL / mechanism-PUBLISHED` tag —
**NOT a discovery** until a DFT number lands on the host.

---

## DEPLETION TEST — does the reopened H-corner have a real material?

**ANSWER: NOT host-empty — a real 1-atm off-diagonal H-on-carrier-bond host EXISTS (#1
κ-H₃(Cat-EDT-TTF)₂), but it is a Mott INSULATOR that must be doped/pressed to metal, and the
target-room-T realization is UNVERIFIED.** This is *weaker than a discovery, stronger than
host-emptiness*: the H-corner is **host-POPULATED but unproven** (contrast metallic-H, which is
genuinely 1-atm-host-empty). Classes #2/#3 are real 1-atm H-bond-stretch-coupled SC hosts but
**diagonal** (Tc-capped <293 K). Class #4 (the textbook M-H-M off-diagonal motif) **is** host-empty as
an extended metal.

### BEST DFT TARGET (candidate-class-pending-novelty)
**κ-H₃(Cat-EDT-TTF)₂** (and its κ-D₃ isotopologue for the off-diagonal ∂t/∂u isotope signature).
DFT recipe (summer-free feasible — it is a molecular crystal but the relevant unit is the dimer +
O-H-O bridge, downfoldable):
1. **relax** the 1-atm structure (C2/c, H-centered single-well) → confirm geometry.
2. **frozen-phonon / DFPT on the O–H–O bridge stretch** → pin Ω(H) (target 100–300 meV) and the
   **∂t/∂u** (off-diagonal coupling: displace the bridge proton, measure the change in the inter-π
   transfer integral via maximally-localized **Wannier** downfold → the SSH g).
3. **Wannier narrow-band** check: bandwidth t~Ω? dilute-dopable to ν~½? U/Ω vs Mott (cRPA U).
4. feed g/t, Ω, t into the lane's QMC-anchored Tc = C·Ω with the g\*/t≈0.54 dome → does the REAL
   host's (g/t, Ω) land on the grazing-293 K dome or fall off it (the honest Tc number).

Flag: **candidate-class — pending (a) the DFT number on the real host AND (b) the novelty tag already
issued (framing-NOVEL, mechanism-PUBLISHED).** Until step 4 returns a real-host number, this is a
NOVEL TARGET, not a room-T discovery (d_novel_only · d6 · ROOMT-AMBIENT g5 #2 dynamical-stability and
#4 Tc gates both still OPEN on this host).

---

## ONE-LINE LANE VERDICT
The reopened H-corner is **host-POPULATED, not host-empty**: κ-H₃(Cat-EDT-TTF)₂ is a real, 1-atm,
off-diagonal **H-on-the-carrier-bond** material (O-H-O proton gates π↔π transfer = ∂t/∂u SSH) — the
first concrete H-SSH host — but it is a **Mott insulator needing doping**, the framing is **NOVEL**
(no prior paper), and the room-T realization is **UNVERIFIED**. → **candidate class + novel DFT target
(κ-H₃(Cat-EDT-TTF)₂), NOT a discovery.** Diagonal H-stretch SC hosts (borohydrides, Tc≤140K) are real
but Tc-capped; the off-diagonal extended M-H-M metal is host-empty.

## SOURCES
- κ-H₃(Cat-EDT-TTF)₂: JACS 2014 (pubs.acs.org/doi/10.1021/ja507132m); PRB 95,184425; PCCP 2016
  (pubs.rsc.org/.../c6cp05414e); ScienceDirect S0009261417301951.
- Metal borohydride SC: arXiv:2207.05593; npj 2D Mater. s41699-025-00590-0; arXiv:2412.13517,
  2511.09009.
- Hydrogen borides/borophane: Small 2026 (10.1002/smll.202511090); ScienceDirect S2451929419305169;
  PRB 83,094108.
- Graphane SC: ResearchGate 364708079; HPC₃ arXiv:2112.07482.
- bond-SSH/bipolaron mechanism (published): PRX 13,011010 (arXiv:2203.07380); 2210.14236; 2308.01961;
  2407.10444; 2507.07662; perspective 2605.16625; Alexandrov cond-mat/0701412.
- single-component H-bonded metal-under-pressure: Nat. Commun. ncomms2352.
