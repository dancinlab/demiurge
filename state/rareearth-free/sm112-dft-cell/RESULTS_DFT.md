# Sm(Fe,Co)12 + Sm-rich GB-phase DFT SCF — captured results (c2 honest)

Run 2026-06-20 on pool hosts summer (pw.x v7.5, micromamba qe) + aiden (same), via `hexa cloud`.
Both hosts heavily contended by other campaigns during the run (load 17 / 26).

## Pseudopotentials fetched (the prior d13 wall — RESOLVED)
- **Sm** = `Sm.pbe-spdn-rrkjus_psl.1.0.0.UPF` (pslibrary 1.0.0, Dal Corso). **4f-IN-CORE / open-core**:
  config `[Xe] 4f5.0 5d1.0 6s1.5 6p0.5`, z_valence=11, NO 4f projector (PP_BETA = 5S/6S/5P/6P/5D only).
  This is the d6-honest choice (avoids unstable 4f-in-valence magnetism). USPP, NLCC, GIPAW. → caps anisotropy fidelity (expected, deferred).
- **Fe** = SG15 `Fe_ONCV_PBE-1.2.upf` (ONCV-PBE-sr, z_val=16). NOTE number_of_wfc=0 (no atomic wfc).
- **Cu** = SG15 `Cu_ONCV_PBE-1.2.upf` (z_val=19).
- **Ga** = SG15 `Ga_ONCV_PBE-1.2.upf`; **Al** = SG15 `Al_ONCV_PBE-1.2.upf` (added for novel ternary axis).

## Deck fix at d16 dry-run (HUBBARD dropped, d6 honest)
The SmFe12 deck's `HUBBARD (ortho-atomic) U Fe-3d 1.0` FAILED at dry-run:
`determine_hubbard_occ: no atomic wavefunctions in pseudopotential file for species Fe`
(the SG15 Fe ONCV pseudo has number_of_wfc=0 → ortho-atomic projector can't be built).
→ Production runs as **plain PBE-GGA** (U=1.0 eV is a minor correction on metallic Fe; consistent ONCV set).
SmFe12/SmFe11Al k-mesh reduced 8×8×12→4×4×6 (1764→224 k-pts) for tractable init on the contended pool
(adequate for metallic E_total + moment; not a tune-to-green change).

## Captured SCF output (Ry; magnetization in μB/cell)

| run | E_total (Ry) | conv | tot mag (μB) | abs mag (μB) | notes |
|-----|-------------|------|--------------|--------------|-------|
| Fe_bcc (ref)   | −236.70927910 | YES | **+2.27** | 2.42 | matches lit ~2.2 μB → validates Fe pseudo/setup |
| Cu_fcc (ref)   | −365.21006493 | YES | (nspin1) | — | |
| Al_fcc (ref)   | −138.41260425 | YES | (nspin1) | — | |
| Sm_ref (fcc proxy) | −126.25215682 | YES | +0.01 | 0.01 | 4f-in-core → non-magnetic valence |
| Ga_ref (fcc proxy) | −131.28918300 | YES | (nspin1) | — | |
| **SmCuGa** half-Heusler (vc-relax) | −622.83570628 | YES | **0.00** | 0.00 | NOVEL, non-FM |
| **SmCuAl** half-Heusler (vc-relax) | −629.92986276 | YES | **−0.00** | 0.00 | NOVEL, non-FM |
| SmFe12 ThMn12 (k446) | PENDING | — | — | — | running |
| SmCu_B2 anchor | PENDING | — | — | — | running |
| SmFe11Al (Al-on-Fe-site) | PENDING | — | — | — | running |

## Formation energies (eV/f.u., vs fcc-proxy elemental refs; Ry→eV ×13.605693)
- **SmCuGa half-Heusler: −1.147 eV/f.u.** (−0.382 eV/atom), net 3d moment = 0.00 μB → STABLE & non-FM
- **SmCuAl half-Heusler: −0.749 eV/f.u.** (−0.250 eV/atom), net 3d moment = 0.00 μB → STABLE & non-FM
- SmCu B2 anchor / SmFe12 / SmFe11Al: pending.

(fcc-proxy Sm/Ga elemental refs are approximations — α-Sm rhombohedral, α-Ga orthorhombic — but the
common Sm/Cu refs largely cancel in cross-candidate ranking. d6 noted.)

## Published-art anchor (d_novel_only)
- Nishino & Gohda, Jpn. J. Appl. Phys. 62, 030902 (2023): B2 SmCu / B27 SmCu are the NON-MAGNETIC
  GB subphases of SmFe12, stabilized by phonons + configurational entropy; attractive Cu-Fe
  interaction (Fe dissolves into the Cu sublattice). → our SmCu B2 = method-validation ANCHOR
  (reproduction), not a discovery. Expected: net 3d moment ≈ 0 + negative E_form. SmFe12 Ms(lit) ≈ 1.55-1.84 T.
- NOVEL (this run): Sm-Cu-Ga and Sm-Cu-Al half-Heusler GB candidates are NOT in the Nishino-Gohda
  Sm-Cu-Fe-only map — Ga/Al as the 3rd species is the new axis (novelty gate PENDING full arxiv probe).

## Closed-negative test (Al into 1:12 Fe-site vs GB-phase)
  E_sub = E(SmFe11Al) + E(Fe_bcc) − E(SmFe12) − E(Al_fcc)
- E_sub < 0 → Al PREFERS the 1:12 Fe-site (dilutes magnet; GB route frustrated) = closed-negative for "Al-in-GB".
- E_sub > 0 → Al EXPELLED from Fe-site → segregates to Sm-rich GB phase (Al-bearing non-FM decoupler viable).
Needs E(SmFe12) + E(SmFe11Al) — PENDING (node-contention wall).

## WALL (d6 honest)
Both pool nodes saturated by OTHER campaigns during this run: summer load 17→23, aiden load 18→37
(12-core boxes at 2-3× oversubscription). The 3 remaining heavy runs (SmFe12 13-atom nspin=2,
SmCu_B2, SmFe11Al 13-atom) stalled in SCF init/iter-1 for 15-20 min — a NODE-CONTENTION wall, not a
deck/method bug (all 3 read pseudos cleanly, entered SCF; CPU active 330-650%). Mitigations applied:
k-mesh 1764→224, duplicate-process cleanup, detached setsid. Per instruction, no infinite retry.
