# RTSC AMBIENT-ROOM-T lens — Metastable / ambient-stable hydride route

> SSOT pass-criteria: `state/fb-geom-lambda/ROOMT_AMBIENT_PASS_CRITERIA.md` (bottleneck = TIER-1 #4: Tc ≥ 293 K AT 1 atm).
> Scope: arxiv+web only (d18). No commit / no ARCHITECTURE.json edit / no pod. Honest (d6, d_novel_only).
> Date: 2026-06-19.

## Question
Can a high-Tc superhydride (LaH10 ~250K, H3S ~200K — all needing 100-200 GPa) be RECOVERED/STABILIZED
to 1 atm metastably while keeping high Tc? That is the only way the hydride route clears the ambient gate.

---

## 1. DEMONSTRATED or PREDICTED 1-atm-metastable hydride retaining high Tc?

### (A) The high-pressure superhydrides DO NOT survive to 1 atm (experiment)
- **Al-stabilized hexagonal LaH10** (PMC10727841 / PubMed 38116091): Tc = **223 K at ~164 GPa**, 178 K at 146 GPa.
  Al-doping was a strategy to *stabilize a normally-inaccessible phase at lower pressure* — but the entire study
  lives in a **146–183 GPa window**. The paper provides **NO evidence the phase survives or stays superconducting
  on release to ambient.** → still pressure-locked.
- **Decompression / quench-recovery of La–H**: pressure-cycling recovers LaD₃ down to ~0.2 GPa and LaD below ~4 GPa,
  revealing irreversibility of H-migration — but the *high-Tc clathrate-H sublattice decomposes into H₂* on
  decompression. The clathrate cage (LaH₁₀) is **not what is recovered**; what survives is a low-H, low/non-SC phase.
- Lu-trihydride fcc high-P phase has been *structurally* stabilized at ambient (PMC11304239) — but this is the
  N-doped-lutetium-hydride lineage tied to the **retracted/disputed Dias room-T claim**; no verified ambient high-Tc.

### (B) PREDICTED ambient-metastable hydrides (first-principles) — the real candidates
These are computed to be **dynamically stable at 1 atm** as **metastable** (above-hull) phases. None measured yet.

| Compound | Predicted Tc @ 1 atm | Thermo (hull) | Dynamic (phonons) @1atm | Source |
|---|---|---|---|---|
| **Mg₂IrH₆** | ~160 K | metastable (above hull) | stable (claimed) | npj Comput Mater s41524-024-01214-9 / arXiv 2310.06804 family |
| **Li₂AuH₆** | ~140 K (paper) / 116 K Eliashberg, 91 K SCDFT (Gao) | **metastable, above hull (Fig 1b)** | **stable — "no imaginary phonon under ambient"** | arXiv 2501.12222 |
| **Li₂AgH₆** | 109 K Eliashberg / 83 K SCDFT | metastable | stable | Gao Nat Commun 2025 |
| **Mg₂XH₆ (X=Rh,Pd,Pt)** | 45–80 K; >100 K w/ e-doping of Pt | metastable | stable | npj Comput Mater (ML high-throughput) |
| **SrAuH₃** | ~ high-T (ambient) | — | stable | arXiv 2412.15488 |
| **RbPH₃** | ~100 K (needs ionic anharmonicity) | metastable | anharmonic-stabilized | arXiv 2411.03822 |
| **LiMgZr₂H₁₂** | 60.8 K | metastable | stable | arXiv 2602.03471 |

**Best high-Tc candidate = Mg₂IrH₆ (~160 K), with Li₂AuH₆ (~140 K) the best-characterized.**
Note the demiurge working tree already carries `exports/rtsc/decks/Mg2PtH6/` decks (this family is under active study here).

---

## 2. Thermodynamics & dynamics at 1 atm (pass-criteria gate #1 thermo, #2 dynamic)

- **#1 Thermodynamic stability (on hull):** **FAIL for all high-Tc candidates.** Every ambient-Tc>100K candidate is
  **metastable (above the convex hull)** — only kinetically trappable, NOT on-hull stable. Gao et al. (Nat Commun 2025,
  s41467-025-63702-w; arXiv via 2509/Nat Commun 16:8253) show this is *structural*: **compounds with predicted Tc
  above ~100 K are increasingly thermodynamically unstable.** Li₂AuH₆ sits ~38 meV/atom above the decomposition
  products (6LiH+5Au→Li₂AuH₆+4LiAu) — synthesis needs catalysts / rapid quench / encapsulation, none demonstrated.
- **#2 Dynamic stability (no imaginary phonons @1atm):** **PASS in DFT for the named candidates** (Li₂AuH₆: "no trace
  of imaginary phonon under ambient"; Mg₂IrH₆, RbPH₃ via anharmonicity). This is the genuine advance — these X₂YH₆
  cages are dynamically stable WITHOUT pressure (unlike LaH₁₀/CaH₆/YH₆ which need 100-170 GPa for dynamic stability).
- **The classic superhydrides (LaH10/H3S/CaH6) FAIL #2 at 1 atm** — they go dynamically unstable (imaginary phonons /
  H₂ molecularization) on decompression. They are pressure-locked.

So the ambient story splits: the *pressure-recovered* route (quench LaH10) fails #2; the *designed* X₂YH₆/cage route
passes #2 but fails #1 (metastable, unsynthesized) AND fails #4 (Tc < 293K).

---

## 3. Lighter-framework / "stiff cage, no pressure" hydrides

Yes — this is exactly the X₂YH₆ and B–C-clathrate design philosophy: replace the pressure-held H clathrate with a
**covalently/ionically pre-compressed stiff host** so no external pressure is needed:
- **Octahedral [XH₆] complex anions (Mg₂IrH₆, Li₂AuH₆, Li₂AgH₆):** stiff covalent M–H octahedra + van Hove
  singularity at E_F → high ω_log (Mg₂PtH₆ ω_log > 770 K) and decent λ at 1 atm.
- **Boron-carbon clathrates filled with hydride/cation:** KB₃C₃ (102.5 K, ambient, anharmonically stabilized),
  SrNH₄B₆C₆ (~85 K), XB₈C cages (Ca/Sr/Ba: 77/64/53 K) — H/B/C covalent cage replaces the H₂ cage; ambient dynamic-stable.
- **None reaches 293 K.** The covalent-cage trick buys *ambient dynamic stability*, not room-T Tc.

---

## 4. The decisive bottleneck — is the route pressure-locked?

**Gao, Flores-Livas et al., "The maximum Tc of conventional superconductors at ambient pressure", Nat Commun 16:8253
(2025) — s41467-025-63702-w** screened >20,000 metals' el-ph and found:
- ω_log **rarely exceeds 1800 K** in real compounds (vs theoretical ceiling ~3680 K) — an intrinsic λ↔ω_log trade-off.
- **Li₂AuH₆ / Li₂AgH₆ define the practical ceiling** (~100–120 K).
- Conclusion verbatim: *"achieving room-temperature conventional superconductivity at ambient pressure is extremely
  unlikely"* and *"fundamental physical laws do not strictly limit Tc beyond 100–120 K, but in practice … realization
  of such a compound is extremely unlikely."*

This is the same physics as the SSOT honest-meta: high Tc demands either huge pressure (superhydrides) OR an unstable
host. At 1 atm the dynamically-stable hosts top out near ~120–160 K (predicted), all metastable, none synthesized,
none measured — and the law-level ceiling for conventional ambient SC sits well below 293 K.

---

## Pass-criteria scorecard (TIER-1, applied to BEST candidate = Mg₂IrH₆ ~160K, and Li₂AuH₆ ~140K)

| Gate | Criterion | Mg₂IrH₆ / Li₂AuH₆ @ 1 atm | Verdict |
|---|---|---|---|
| #1 | Thermo stable (on hull / ΔHf<0) | **above hull, metastable only** (~38 meV/atom for Li₂AuH₆) | **FAIL** (kinetic-trap only, unsynthesized) |
| #2 | Dynamic stable (no imag. phonon @1atm) | DFT: no imaginary phonons | **PASS** (genuine advance) |
| #3 | Carrier channel N(E_F)>0, metallic | metallic, vHs at E_F | **PASS** |
| #4 | Tc ≥ 293 K @ 1 atm | **160 K / 140 K predicted** (ceiling ~120-160K) | **FAIL** (decisive bottleneck) |
| #5 | Magnetic/CDW non-preemption | not flagged competing | n/a (no measurement) |
| #6 | Novelty (d_novel_only) | NOVEL predictions, none measured | PASS-as-prediction |

Classic recovered superhydride (LaH10 quench): **#2 FAIL** (dynamically unstable at 1 atm) → worse.

---

## VERDICT

**CLOSED — the hydride route is fundamentally PRESSURE-LOCKED for the ROOM-T-AMBIENT gate (high Tc ⇔ high P).**

- Honest sub-result (NOT overclaimed): there IS real, recent first-principles progress on **ambient-DYNAMICALLY-STABLE**
  hydrides — the X₂YH₆ stiff-octahedron family (**Mg₂IrH₆ ~160 K, Li₂AuH₆ ~140 K**) and B–C clathrates clear gate **#2
  at 1 atm**, which the pressure-recovered superhydrides cannot. This is the route's only daylight.
- BUT they fail gate **#1** (all metastable/above-hull, none synthesized — Li₂AuH₆ ~38 meV/atom above products, needs
  quench/catalyst/encapsulation) and decisively fail gate **#4**: the **best predicted ambient Tc is ~160 K, far below
  293 K**, and a 2025 Nature Comm law-level survey (Gao et al.) puts the practical conventional ambient ceiling at
  **~100–120 K** and calls room-T ambient conventional SC **"extremely unlikely."**
- No DEMONSTRATED 1-atm metastable hydride retains high Tc; the 223 K Al-LaH10 result is at 164 GPa and shows no ambient
  survival. The disputed/retracted N-Lu-H lineage provides no verified ambient high-Tc.

**No named candidate passes #1–#4 all PASS.** Best honest standing = **🔴 CLOSED-pressure-locked for room-T**, with a
**🟡 GATED open sub-lane** at sub-room-T (≤160 K predicted) ambient metastable hydrides (Mg₂IrH₆ / Li₂AuH₆) — interesting
for the ~120-160 K regime but structurally incapable of 293 K @ 1 atm. The room-T ambient bottleneck (#4) is confirmed
shut for the hydride family by both candidate scorecard and law-level ceiling. Consistent with SSOT honest-meta and the
RTSC discovery-closing-formula (conventional room-T-ambient = closed; escape only via non-phonon / bond-Peierls, not hydrides).

## Sources (arXiv ids + journals)
- Gao et al., Max Tc of conventional SC at ambient pressure, Nat Commun 16:8253 (2025), s41467-025-63702-w (PMC12423309) — LAW-LEVEL CEILING.
- Li₂AuH₆ ~140 K ambient, metastable, dynamically stable: arXiv 2501.12222.
- Mg₂IrH₆ ~160 K / Mg₂XH₆ family, ML high-throughput: npj Comput Mater s41524-024-01214-9; arXiv 2310.06804; Cerqueira AdvFunctMater 2024 10.1002/adfm.202404043.
- X₂MH₆ e-phonon disentangle / doped TM-hydrides: arXiv 2604.04151; npj s41524-026-02040-x; arXiv 2503.04336.
- SrAuH₃ ambient: arXiv 2412.15488. RbPH₃ anharmonic ambient: arXiv 2411.03822. LiMgZr₂H₁₂ 60.8 K: arXiv 2602.03471.
- Hydride-filled B–C clathrate (SrNH₄B₆C₆ ~85 K, KB₃C₃ 102.5 K, XB₈C): Commun Phys s42005-024-01814-3.
- Al-stabilized hex-LaH10, 223 K @ 164 GPa (NOT ambient): PMC10727841 / PubMed 38116091.
- GNoME ambient-stable hydride search: Commun Phys s42005-026-02552-4.
- Feasible route to ambient hydride SC: arXiv 2310.07562.
