# Checkerboard-lattice flat-band gate-check deck (Os-O)

Lane: `rtsc-topology` round 2. Graph-topology flat-band generator (triangulation v4),
THEOREM-1 line-graph track. Mirrors the proven Lieb deck (`summer:~/sib_work/lieb_oso2/`)
exactly — same QE recipe, same screen-first protocol, same parse gate.

## Topology

- **Lattice**: checkerboard = **line graph of the 2D square lattice** L(square).
  It is the 2D pyrochlore (the planar cousin of kagome = L(honeycomb)).
- **Flat-band mechanism**: theorem-1 line-graph flat band; compact localized states
  (CLS) on the square plaquettes; flat band at -2t (tight-binding adjacency spectrum).
- **Realization chosen**: the line-graph sites sit at the **bond midpoints** of the
  square lattice → two Os sublattices at the edge centers `(1/2,0,0)` & `(0,1/2,0)`.
  O ligands at the corner `(0,0,0)` and cell center `(1/2,1/2,0)` bridge the Os net
  and supply the crossed-plaquette (alternating-diagonal) coupling that distinguishes
  the checkerboard from a plain square net. 4 atoms / cell (2 Os + 2 O).

## Element choice rationale

- **Os (5d)** on the checkerboard sites: a non-magnetic-prone heavy 5d transition
  metal — the same logic that made the kagome/Lieb Os-O decks pass the magnetism
  axis (broad 5d band, strong SOC, low Stoner factor vs 3d Co/Fe). Reuses the
  verified `Os_ONCV_PBE_sr.upf` SG15 pseudo from `~/sib_work/laru3si2/pseudo/`
  (= the LaOs3Si2 kagome winner's pseudo) — no new fetch.
- **O (2p)** light ligand: bridges the Os net into a planar oxide. Reuses
  `O_ONCV_PBE_sr.upf` from the Lieb deck — no fetch.

## Geometry

- `ibrav = 6` (tetragonal P), `celldm(1) = 7.18 bohr` (a ≈ 3.80 Å, from Os-O ≈ 1.9 Å,
  a = 2·Os-O), `celldm(3) = 3.68` → large c vacuum (c ≈ 14 Å) for a 2D monolayer.
- Identical cell + cutoffs to the Lieb deck so the two line-graph/bipartite screens
  are directly comparable: `ecutwfc=80`, `ecutrho=320`, `12×12×1` k-mesh,
  `nspin=2`, MP smearing `degauss=0.02`, `conv_thr=1e-8`, `mixing_beta=0.3`.
- Screen-first: **scf + bands only, NO vc-relax** (vc-relax only on a GREEN result,
  same screen→promote pattern as the kagome/Lieb siblings).

## Gate definition (two orthogonal screens)

1. **ΔE ~ 0 (flat band at E_F)**: `parse_flatband.py` extracts per-k eigenvalues
   over the Γ-X-M-Γ in-plane path, finds the flattest band (bandwidth < 0.6 eV)
   within 1.5 eV of E_F, reports `ΔE = E_flat - E_F`.
   - PASS/GREEN: |ΔE| < 0.10 eV · INCONCLUSIVE/ORANGE: 0.10 ≤ |ΔE| ≤ 0.20 ·
     FALSIFY/RED: |ΔE| > 0.20 eV.
2. **non-magnetic (m < 0.5)**: `absolute magnetization` from `scf.out`.
   - PASS: m < 0.5 µB · FAIL: m ≥ 0.5 (the axis that killed pyrochlore RbOs2O6).

GREEN = BOTH axes pass → promote to vc-relax then DFPT λ/Tc.

## Honest caveat (🟠)

Idealized fixed geometry (Os-O = 1.9 Å assumed, no relaxation) → the ΔE is
**approximate**. This is a 1st-pass topology DESIGN gate (does the line-graph flat
band land at E_F for a non-magnetic 5d realization?), **NOT a room-temperature
prediction**. A GREEN result is a promote signal, not a closed claim; a RED/orange
result falsifies this idealized realization, not the checkerboard topology in general.

## Files (on summer)

`~/sib_work/checkerboard_oso2/` : `scf.in` · `bands.in` · `parse_flatband.py` ·
`pseudo/{Os,O}_ONCV_PBE_sr.upf`. Fire: `/tmp/checkerboard_fire.sh` (guarded,
self-logs to `~/checkerboard.log`).

## Queue / machine-load guard

summer has only 6 cores and is running LaOs3Si2 vc-relax; the Lieb gate is queued
behind it. The fire script polls (30 s, up to ~6 h) until **vc-relax DONE** AND
**Lieb Os-O DONE** AND `pgrep -x pw.x == 0`, then runs — third in the queue
(vc-relax → Lieb → checkerboard). No oversubscribe.
