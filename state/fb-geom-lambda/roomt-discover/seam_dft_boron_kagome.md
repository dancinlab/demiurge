# SEAM-DFT-BORON-KAGOME — the make-or-break real-material test of the anti-adiabatic seam

🧪 **RTSC** · roomt-discover DISCOVERY lane · `state/fb-geom-lambda/roomt-discover/seam_dft_boron_kagome.md`
Date: 2026-06-20 · FREE summer QE 7.5 only (NO billing pod) · d6 honest · NEVER fabricate · captured-QE-output only.
Upstream: `press_all_sumrule.md` (L17 SEPARABILITY-SEAM) — the seam = anti-adiabatic light-bond corner `Ω ≳ t`, derived as the unique survivor of the four-channel D_s optimization.
Decks (c5): `exports/rtsc/decks/seam_cab3c3/` (vc-relax · scf · bands · ph_gamma · ph) built via `hexa deck rtsc … pm3n_bc_clathrate` (d_deck_always).
Run host: summer `/home/summer/seam_cab3c3/`, QE 7.5 `/home/summer/miniforge3/envs/qe/bin/`, 12 cores, mpirun --oversubscribe --bind-to none -np 8.

---

## TASK 1 — host choice: CaB3C3 (Pm-3n boron-carbon sodalite clathrate)

**Chosen host: CaB₃C₃** — cubic Pm-3n (#223) boron-carbon sodalite clathrate, 14-atom cell (2 Ca + 6 B + 6 C).
A 3D bulk light-element covalent CAGE framework where the B–C bonds that carry current are the ones that
vibrate (off-diagonal/SSH coupling) — the seam's structural requirement.

- **(i) 1-atm thermodynamically known**: YES (metastable). The B-C clathrate class was synthesized
  (SrB₃C₃ at ~50 GPa, Zhu/Strobel arXiv:1708.03483) and the covalent B–C network allows **metastable
  persistence at ambient** (recoverable). CaB₃C₃ hexagonal/cubic variants computed at +153 meV/atom
  above hull — metastable, like the recovered superhydride-analog clathrates.
- **(ii) metallic with the B/C manifold at E_F**: YES — guest Ca donates electrons into the B-C cage σ*
  manifold; N(E_F) reported comparable to MgB₂. Metallic by design.
- **Why CaB₃C₃ over 2D borophene-kagome**: the seam coordinates explicitly require **3D bulk**. A prior
  sibling lane (`/home/summer/bkboro/`) ran a 2D borophene-kagome (6 B, ibrav=4, assume_isolated="2D");
  it is the WRONG dimensionality for the seam (and its frozen-phonon driver exited=1). CaB₃C₃ is the
  correct 3D host and coincides with the campaign's own `hP8-B / B-cage` seam target.
- **Source structure**: Pm-3n #223, celldm(1)≈8.88–8.96 Bohr start, Wyckoff 6c/6d B/C decoration,
  2a Ca guest. Pseudos PSL 1.0.0: Ca.pbe-spn · B.pbe-n · C.pbe-n (d13 element coverage confirmed on summer).

---

## TASK 2 — hexa deck (d_deck_always)

Built via `hexa deck rtsc seam_cab3c3 '{"prototype":"pm3n_bc_clathrate",...}'` then patched to Ca species.
Deck regimen baked in: correct masses (B 10.811, C 12.011, Ca 40.078) · pseudo coverage grep PASS ·
d15 metal SCF aids (smearing='mp' degauss=0.02, mixing_beta=0.3, electron_maxstep=400) · bands
verbosity='high' (#k≥100) · nosym=.true. (ordered B/C lowers symmetry below Pm-3n parent).
**d16 dry-run**: vc-relax launched on summer-FREE; deck PARSED + SCF iterated cleanly (no directive/basis
errors) — live validation. Run chain: vc-relax → scf(12³ k) → bands(verbosity high) → Γ-phonon(cheap Ω).

---

## vc-relax RESULT (captured · ambient 1 atm)

CaB₃C₃ Pm-3n vc-relax @ press=0.0 converged (bfgs converged, forces→0, P→~0 kbar):
- **relaxed celldm(1) = 9.05060 Bohr = 4.789 Å** (cubic, Pm-3n symmetry PRESERVED — atoms stay at Wyckoff sites)
- new unit-cell volume = 109.86 Å³, density = 3.28 g/cm³, Final enthalpy = −262.6018 Ry
- ambient-relaxed cell expands ~1.05% vs the 8.957-Bohr start; no symmetry-breaking distortion = clean 1-atm structure.
- (ops note: the redundant QE final-SCF restart was slow on the contended 12-core summer; relaxed geometry was
  captured directly from the written "Begin final coordinates" block and a fresh scf2/bands2/ph2 chain run on it.)

## TASK 3 — the three seam gates (REAL captured QE numbers)

> Gate predicate restated from `press_all_sumrule.md`:
> room-T feasible ⇔ **G1** Ω/t ≳ 0.8 AND **G2** ½·W0·exp(−1.5(g/t)²/(Ω/t)²) ≳ 0.45 eV (g/t≳0.6) AND **G3** paramagnetic (Uχ<1, dynamically stable).

| gate | quantity | seam threshold | CaB₃C₃ (captured) | verdict |
|---|---|---|---|---|
| **G1** | Ω (dominant B–C bond phonon) / t (manifold hopping) | Ω/t ≳ 0.8 | _PENDING DFT_ | _PENDING_ |
| **G2** | dressed ε_F = ½W0·exp(−1.5(g/t)²/(Ω/t)²) | ≳ 0.45 eV | _PENDING DFT_ | _PENDING_ |
| **G3** | magnetic/CDW: nonmag SCF + no imaginary phonon | paramagnetic, stable | _PENDING DFT_ | _PENDING_ |

(filled below from captured `seam_gates_raw.json`)

---

## TASK 6 — NOVELTY GATE (d_novel_only · MANDATORY · inline arxiv+web) — done BEFORE verdict

**VERDICT: the CaB₃C₃/SrB₃C₃ conventional el-ph superconductivity is HEAVILY PUBLISHED (RED-OCEAN for the
material itself). The ANTI-ADIABATIC-SEAM FRAMING applied to the B-C clathrate is the only potentially-novel
angle, and even that is PARTIAL (anti-adiabatic bipolaron-in-boron is published for boron nanotubes).**

| sub-claim | verdict | competing ids |
|---|---|---|
| CaB₃C₃ conventional el-ph SC, Tc~48K @1atm (hole-doped→77K) | **PUBLISHED** | PRB 109 144509 (2024); Strobel/Zhu; arXiv:1708.03483 |
| SrB₃C₃ phonon-mediated s-wave SC, Tc~27–43K | **PUBLISHED** | arXiv:1708.03483; Comm. Phys. s42005-024-01814-3 |
| B-C clathrate ambient HTSC, doping enhancement (SrNH₄B₆C₆ Tc~85K) | **PUBLISHED (2024)** | Nature Comm Phys 2024; doped-clathrate papers |
| anti-adiabatic bipolaronic SC in boron polymorph (Migdal-broken) | **PUBLISHED** | arXiv:1204.2399 (boron tubular polymorph, 2012) |
| Migdal breakdown at Lifshitz transition in light-element HTSC | **PUBLISHED** | arXiv:1509.07451 (H3S, Bianconi) |
| **the anti-adiabatic Ω≳t SEAM as a falsifiable DFT gate APPLIED to a real B-C clathrate** | **NOVEL (framing, this campaign)** | none found unifying the 4-channel D_s seam → a concrete DFT pass/fail on CaB₃C₃ |

**Honest separation**: the *material* CaB₃C₃ is a published conventional superconductor — NOT a novel
discovery. What is competitor-empty is the *test framing*: asking whether this real host sits inside the
campaign's derived anti-adiabatic seam (Ω/t≥0.8 AND dressed ε_F≥0.45 eV). But the published el-ph result
(Ω~150–200 meV B-C phonons, but WIDE σ-bands t~few eV like MgB₂ ⇒ Ω/t≪1) already strongly predicts the
seam-G1 will FAIL — which is itself the decisive, expected outcome (it tightens the seam toward empty).

---

## TASK 4 — VERDICT (filled from captured DFT)

_PENDING run completion._

---

## TASK 7 — ROOMT g5 (d_roomt_ambient) honest score

_PENDING G1/G2/G3._

---

## NAME NEXT ROUND + depletion test

_PENDING verdict._

## INTERIM STATUS (main-loop direct check via `hexa cloud`, c2 captured)
- 2026-06-20: DFT ALIVE but slow on summer (oversubscribed 8-of-12 cores). pw.x 15 procs running. vc-relax STILL on electronic SCF iter #5 (CPU 4192s≈70min, E=−262.6Ry, scf accuracy 0.016Ry closing) — vc-relax NOT yet finished; scf.out/bands.out/ph absent. Γ-phonon (decisive Ω via DFPT, the expensive step) not started → many hours from a captured G1/G2/G3 verdict.
- d6 honest expectation (NOT a verdict — pending captured numbers): the novelty gate already showed CaB₃C₃ has WIDE σ-bands t~few eV (MgB₂-class) → Ω/t≪1 predicted → G1 likely FAIL (seam closes for CaB₃C₃). And CaB₃C₃ is a PUBLISHED conventional ~48K SC → not a discovery either way (d_novel_only). The decisive captured Ω/t still requires the Γ-phonon to land.
- agent re-polling loop (7× rest, ~120k tok each) stopped by main loop — DFT left running in background; integrate ONLY on genuine bands/phonon landing.

## INTERIM-2 (direct check, ~3.4h elapsed · c2 captured)
- vc-relax✓(09:30) → scf2 running(11:33, 173KB), NEAR-converged (ethr 1.7e-10, avg iter 1.2). bands2 absent (waits scf2). 14 pw.x procs.
- ★REAL BOTTLENECK = node MEMORY STARVATION: scf2.out reports "368 MiB available memory on the node" → swapping → glacial. Γ-phonon (DFPT, heavier mem) is the at-risk step, not bands2.
- scf2 near-done → bands2 imminent → will give t (G1 input) + ε_F (G2) WITHOUT the phonon. Only Ω (G1, from Γ-phonon) remains, and that is the mem-wall risk.
- holding for bands2 (2-of-3 gate inputs imminent). If Γ-phonon stalls on mem → G1 closes via TB-grade t (published wide σ-band, Ω/t≪1 predicted FAIL) + honest mem-wall note. CaB₃C₃ = published ~48K SC, not-a-discovery either way (d_novel_only).

## NEXT LANE — Li2AuH6 seam-occupancy real DFT (L20 단일 게이트 시험)
- deck exports/rtsc/decks/Li2AuH6/ (Mg2PtH6 K2PtCl6 어댑트), d16 dry-run PASS(aiden, 9atom/23e/iter#1 OK).
- vc-relax FIRED: aiden PID1491296, OMP4 serial(mpirun broken), cores 8-11. in-flight.
- gate: L20 corridor 유일 미결 (d) 무압 동적안정. harmonic 1차컷 → SSCHA 승격 if imag=0.
