# Light-Element Kagome Flat-Band Superconductor — Named Candidate Design

> 🪶 FB-GEOM-LAMBDA · sc-channel · OPEN-NOVEL room-T target
> Goal: an SOC/Chern-isolated flat band at E_F on a **light-atom** kagome net with high quantum metric
> ⟨g⟩≈2–3 AND a light-atom bond phonon Ω≈120–200 meV → geometric 2D-BKT Tc 290–680 K.
> No-go gate (arXiv:2604.04719): route Tc via **quasi-2D geometric stiffness D_s**, NOT λ-enhancement —
> the Peotta–Törmä geometric superfluid weight is real and load-bearing in flat bands, but it is NOT a
> universal Tc predictor; the lever must be D_s (geometry × pairing), not a bigger λ.
> Date: 2026-06-19 · web + reasoning only (NO pod, NO ARCHITECTURE.json edit, NO commit).

---

## 0. Design logic (why these axes)

A geometric-channel room-T target needs FOUR things at once. Light elements help three of them:

| Axis | Requirement | Why light element |
|------|-------------|-------------------|
| Isolated flat band | gap above & below FB at E_F so it carries the physics | needs a gap-opener (SOC or breathing) |
| High ⟨g⟩ (quantum metric) | ⟨g⟩≈2–3 → large geometric D_s | kagome line-graph FB is generically high-⟨g⟩ when fragile/Chern |
| Light Ω bond phonon | Ω≈120–200 meV sets the pairing/glue scale | C–C (≈200 meV), B–B (≈140 meV), C≡C (≈250 meV), B–N (≈170 meV) are the only nets that reach this |
| Carrier/SC channel | a real pairing interaction + carriers at FB | needs metallic FB at E_F (doping) + e-ph or attractive U |

The geometric route means D_s ∝ ⟨g⟩ · Δ (gap), so the FB must be **partially filled and metallic**, and the
gap-opener must NOT push it to a trivial insulator — a *fragile/Chern* gap (nonzero quantum metric lower
bound C ≤ ⟨g⟩) is what we want, exactly the regime the no-go paper says is necessary-but-not-sufficient.

---

## 1. Named light-element kagome candidates (sourced status)

### A. hP8-B trilayer kagome borophene  ★ (and bilayer-kagome borophene, BK-B)
- **Structure**: hP8-B = two AA-stacked **boron kagome** layers + a honeycomb interlayer (tri-layer borophene).
  BK-borophene = bilayer kagome lattice with multiple van Hove singularities (conventional VHS + higher-order HOVHS) near E_F.
- **Flat band / FB-near-E_F**: kagome flat band + Dirac-like cone; anisotropic e-ph couples the Dirac band and the **flat band**. VHS/HOVHS tunable to E_F by doping.
- **Light Ω**: highest phonon ≈ **34 THz ≈ 140 meV** (B–B in-plane stiffness) — *directly inside* the 120–200 meV target window. σ-bond electrons of the kagome layer couple to in-plane modes.
- **Status**: **HYPOTHETICAL / DFT-predicted.** hP8-B Tc≈35.6 K (highest of any 2D elemental). BK-B Tc≈11 K → 30 K when VHS doped to E_F.
  - Sources: arXiv:2406.18165 (BK-borophene SC prediction); arXiv:2307.07137 / Adv. Sci. (BK-B multiple VHS); ScienceDirect S2542529323001803 (hP8-B Dirac kagome+honeycomb).
- **Gap-opener**: none intrinsic to isolate the FB — the FB is *entangled* with Dirac/σ bands (this is the weakness; the SC there is conventional λ-driven, the route the no-go paper warns against).

### B. Aza-[3]triangulene covalent kagome lattice (A[3]T COF)  ★ SYNTHESIZED
- **Structure**: diatomic kagome lattice of aza-[3]triangulene nodes joined by cumulenic linkers; metal-free **C/N** π-conjugated COF, on-surface synthesized on Au(111). D3h ground state.
- **Flat band**: TWO **phase-frustration-induced non-trivial flat bands** from a sixfold-degenerate set of edge-localized Wannier functions; confirmed **near E_F** by STS (destructive-interference localization on pore circumference). Explicitly *non-trivial* (fragile/topological) FBs — the high-⟨g⟩ signature we want.
- **Light Ω**: pure C/N skeleton (sp2 C–C/C–N) → bond modes ≈ 150–200 meV.
- **Status**: **EXPERIMENTALLY SYNTHESIZED (2026)** — Nature Materials 41563-026-02528-3 / arXiv:2510.16126. This is the *only candidate already made* and the only one with measured FB-near-E_F.
- **Gap-opener**: orbital-phase frustration itself gaps/isolates the nontrivial FBs (no SOC needed). Weakness: COF on Au is near charge-neutral/insulating-correlated (excitonic-insulator tendency in the [4]triangulene cousin) → needs gating/doping to make the FB metallic, and substrate screening kills 2D BKT stiffness. No SC reported.

### C. 2D "graphene-kagome" CP-net carbon allotrope (line-graph carbon)
- **Structure**: pure sp2 carbon, cyclopropatriene-like (CP) triangles between dodecagonal pores; 6 C/cell, a≈5.21 Å, ~97% porosity. Line-graph-of-honeycomb → ideal **kagome flat band**.
- **Flat band**: kagome FB **at E_F**, DOS dominated by pz (~91%); Dirac point at K offset from E_F. FB and Dirac touch (line-graph touching) — NOT isolated as-is.
- **Light Ω**: all-C sp2 → C–C stretch ≈ 180–200 meV (graphene-grade), the *highest* Ω of the metallic set.
- **Status**: **HYPOTHETICAL** (DFT, PMC7494512). No synthesis.
- **Gap-opener**: needs a breathing distortion (alternating CP triangle size) or SOC (tiny in C) to lift the FB–Dirac touching → fragile gap.

### D. Carbon-kagome-lattice family (CKL, arXiv:1601.01043)
- **Structure**: 3D carbon nets; thinnest 2D slab = benzene-ring kagome. Flat band + Dirac near E_F; hole-doping spin-splits the FB (strong correlation).
- **Light Ω**: benzene C–C ≈ 200 meV.
- **Status**: **HYPOTHETICAL** (DFT). FB **not isolated** (coexists with Dirac), no Tc estimate. Authors only *speculate* SC.
- Weaker than A–C for the geometric route (entangled FB, mostly 3D).

### E. Triangulene / [4]triangulene kagome & aza-triangulene cousins
- Synthesized COFs with FB pairs (excitonic-insulator ground state, Kavli/Berkeley; RSC D4NR00910J). Same family as B but insulating/excitonic → poor SC channel. Listed for completeness.

### Other scanned, set aside
- Sumanene monolayer kagome (arXiv:2311.07273): semiconducting, FB present but gapped far from E_F → no carrier channel.
- Cyclacene/graphdiyne-organometallic kagome: flat+Dirac but **metal-bearing** (violates light/metal-free) or FB off E_F.
- MOF-kagome Chern flat band (PMC6760139): has the Chern/⟨g⟩ we want but is metal-organic (heavy metal node) → fails light-element constraint.

---

## 2. Ranking — (isolated FB ✓) × (⟨g⟩ high) × (light Ω) × (carrier/SC channel)

| Rank | Candidate | Isolated FB | ⟨g⟩ likely | Light Ω | SC channel | Net |
|------|-----------|-------------|-----------|---------|-----------|-----|
| **#1** | **hP8-B / BK-B boron kagome** | △ (VHS/FB tunable, partly entangled) | ◯ (kagome FB) | ✓✓ 140 meV B–B | ✓✓ metallic, e-ph + VHS, Tc up to 35 K shown | **Highest** — only one with a *demonstrated metallic FB + carriers + real e-ph* AND light Ω. |
| **#2** | **Aza-[3]triangulene COF** | ✓✓ (nontrivial FB, STS-confirmed isolated near E_F) | ✓✓ (explicitly non-trivial/fragile FB) | ✓ ~180 meV C/N | △ (insulating-correlated; needs gating) | **Best geometry, made; weak carrier channel.** The high-⟨g⟩ + isolated-FB winner. |
| **#3** | **2D graphene-kagome CP-net** | △ (needs breathing/SOC to un-touch) | ◯ (line-graph FB) | ✓✓ 200 meV C–C | ◯ (metallic FB at E_F, all-C) | Strongest Ω + clean line-graph FB; hypothetical + un-isolated as-is. |

**Top pick rationale.** No single material is a clean win on all four axes — the honest tension is
*isolated-high-⟨g⟩ FB* (COF, but insulating) vs *metallic carrier channel + real e-ph* (borophene, but entangled FB).
#1 hP8-B/BK-B is chosen because it is the **only candidate that already carries a metallic flat band at E_F,
real carriers, a demonstrated phonon glue, AND a light-Ω (140 meV) bond mode** — i.e. the only one where the
geometric-stiffness route can actually be *computed* (you need a metal to have D_s at all). The COF (#2) is the
*purer geometry* but you must first dope it metallic; it is the better long-shot for ⟨g⟩≈2–3 but the worse
near-term compute. The recommended program runs **#1 as the compute anchor and #2 as the high-⟨g⟩ stretch.**

---

## 3. Design-deck spec for #1 — BK-B / hP8-B boron kagome (geometric-route variant)

**Design intent (NOVEL angle, not a reproduction):** the published BK-B/hP8-B papers report *conventional
λ-driven* Tc (11–35 K). Our NOVEL target is different: push the **flat band to partial filling at E_F**, isolate
it with a **breathing-kagome distortion** (so it is fragile/Chern with a nonzero ⟨g⟩ lower bound), and evaluate
the **geometric superfluid stiffness D_s** and its 2D-BKT Tc — the no-go-compliant route the original papers did
*not* take. The deliverable is Δ(D_s-route Tc) vs the λ-route Tc, OR a closed-negative ruling that the boron-kagome
FB cannot reach the geometric regime.

### Structure
- **Lattice**: 2D bilayer kagome borophene (BK-B), space group ~P6/mmm (hexagonal); start from arXiv:2307.07137 / 2406.18165 relaxed cell.
- **Lattice constant**: a ≈ 2.9–3.0 Å (boron kagome) — confirm by vc-relax.
- **Atoms/cell**: BK-B ≈ 6 B (2 kagome sublayers × 3); hP8-B variant = 8 B (2 kagome + honeycomb interlayer).
- **Vacuum**: ≥15 Å out-of-plane (2D slab).

### Gap-opener (the design move)
- **Breathing-kagome distortion**: alternate up/down B–B bond lengths in the kagome triangles (δ ≈ 2–5%) to open a gap between the FB and the touching Dirac/σ band → **isolated fragile FB** with quantum-metric lower bound. Sweep δ.
- (B SOC is negligible — breathing, not SOC, is the realistic light-atom gap-opener here. This is the key honest correction to "SOC-isolated" for light elements.)

### Target filling
- Dope the FB to **partial filling at E_F** (electron or hole, ~0.1–0.3 e/cell via field-effect / gate-charge in the slab), aligning E_F with the kagome FB (not the VHS — VHS is the λ-route; FB is the geometric route).

### Bond phonon
- Target the **in-plane B–B kagome stretch ≈ 140 meV (≈34 THz)** as the pairing/glue mode and as the Ω anchor for the BKT estimate.

### What DFT/Wannier would compute (the real ⟨g⟩ + e-ph)
1. **vc-relax + scf** (QE/QFORGE, PBE, ecutwfc ~60–80 Ry, dense k 16×16×1) — relaxed breathing cell per δ.
2. **bands + Wannier90** on the isolated FB (after breathing gap opens): disentangle the single FB manifold → maximally-localized Wannier functions.
3. **Quantum metric ⟨g⟩**: integrate the FB Berry curvature + quantum metric tensor g_μν(k) over the BZ from the Wannier/Bloch states → **real ⟨g⟩** (target: is it ≈2–3?). Also the metric lower bound vs Chern/fragile index.
4. **Geometric superfluid weight D_s**: D_s^geom = (e²/ħ²)·Δ·∫ g_μν(k) d²k (flat-band Peotta–Törmä form), with Δ from a pairing estimate; compare to conventional D_s^conv (≈0 for flat band). → **2D-BKT Tc = (π/2)·D_s/k_B**.
5. **DFPT el-ph** (ph.x / QFORGE DFPT): λ, ω_log, the 140 meV B–B mode's contribution, a²F(ω) → Allen-Dynes λ-route Tc as the *baseline to beat / the no-go control*.
6. **Δ-deliverable**: geometric-route Tc(D_s, ⟨g⟩) vs λ-route Tc(a²F) at the same filling — does geometry buy room-T, or does the no-go bind (D_s too small)?

### Compute sizing (d7/d11)
- 6–8 atom cell, 2D → SMALL. d7 → **pool free (summer / ubu) or QFORGE-native GPU davidson**, NOT a paid GPU pod. DFPT el-ph per-q is the cost driver (memo: el-ph scratch can be >40 G/q — use ≥100 G disk host).
- All decks via `hexa deck` (d_deck_always): breathing vc-relax + scf + ph + Wannier; d16 1-iter dry-run FREE before any fire; d6 dynamic-stability precheck (matdyn 0 imaginary modes) on the *breathing* cell before el-ph.

---

## 4. Synthesizability — honest flag (d6)

| Candidate | Made? | Honest status |
|-----------|-------|---------------|
| Aza-[3]triangulene kagome COF (#2) | **YES — synthesized** | On-surface (Au(111)), 2026 Nature Materials / arXiv:2510.16126. FB-near-E_F **measured by STS**. The *only* candidate with experimental FB-at-E_F. BUT: on metallic substrate (screens 2D stiffness), correlated-insulating/excitonic tendency → SC **not** demonstrated; would need free-standing + doping. |
| BK-B / hP8-B boron kagome (#1) | **NO — hypothetical** | DFT-predicted only. Free-standing 2D borophenes are made (on Ag/Cu), but the *bilayer/trilayer kagome* polymorph is unsynthesized; dynamical stability of the **breathing** variant is unverified (must pass matdiff precheck). |
| Graphene-kagome CP-net (#3) | **NO — hypothetical** | DFT only (PMC7494512). No synthesis route reported. |
| CKL family (#4) | **NO — hypothetical** | DFT only (arXiv:1601.01043). |

**Bottom line (no overclaim):** the *exact target* — a metallic, isolated, high-⟨g⟩, light-atom kagome FB
superconductor with room-T geometric BKT Tc — is **NOT named in the literature and NOT synthesized.** It remains
a genuine OPEN-NOVEL design. Of the parts: the FB-at-E_F geometry **exists and is made** (aza-triangulene COF),
and a light-Ω metallic boron-kagome FB **exists in DFT** (BK-B). The novelty is the *combination* + the
*geometric-stiffness route* (no-go-compliant) that neither literature line has computed. The room-T claim is
**unverified prediction** until step-3/4 returns a real ⟨g⟩ and a D_s-route Tc — do not present 290–680 K as a
result before that compute.

---

## Sources
- Bilayer kagome borophene SC: https://arxiv.org/abs/2406.18165 · https://onlinelibrary.wiley.com/doi/10.1002/smtd.202402203
- BK-B multiple VHS: https://arxiv.org/pdf/2307.07137 · https://advanced.onlinelibrary.wiley.com/doi/full/10.1002/advs.202305059
- hP8-B Dirac kagome+honeycomb (Tc 35.6 K, 34 THz): https://www.sciencedirect.com/science/article/abs/pii/S2542529323001803
- Aza-triangulene kagome COF (synthesized, FB near E_F): https://www.nature.com/articles/s41563-026-02528-3 · https://arxiv.org/abs/2510.16126
- Carbon-kagome-lattice family (CKL): https://arxiv.org/abs/1601.01043
- Graphene-kagome CP-net carbon allotrope: https://pmc.ncbi.nlm.nih.gov/articles/PMC7494512/
- Quantum-metric no-go (route via geometry, not λ): https://arxiv.org/abs/2604.04719
- Quantum metric / geometric superfluid weight (Peotta–Törmä form): https://arxiv.org/pdf/2409.12254 · https://arxiv.org/pdf/2505.09249
- Triangulene excitonic-insulator kagome (cousin): https://kavli.berkeley.edu/publications/evidence-excitonic-insulator-ground-state-triangulene-kagome-lattice
