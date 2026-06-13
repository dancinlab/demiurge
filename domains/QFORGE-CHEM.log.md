# QFORGE-CHEM — append-only round log

Reconstructed (2026-06-13) from the verified hexa-lang commit ladder on branch `qforge-chem-r4-dimer`
(rounds r1-r4, each g5-gated). Implementation home (d3): `hexa-lang stdlib/qforge/chem/`. Design SSOT:
`hexa-lang drafts/qforge-chem-round1-design.md`.

---

## round-1 — NEB / CI-NEB reaction-path mechanics brick (hexa-lang #3126)
image chain + spring force + perpendicular projection. Improved tangent (Henkelman-Jónsson 2000,
upwind energy-weighted → kinked-band/corner-cutting removed) + climbing-image (Henkelman-Uberuaga-
Jónsson 2000, top-image parallel-force sign flip → saddle climb). `neb.hexa`. g5 PASS —
Müller-Brown 2D (minima 3 + saddle 2, analytic stationary points) + LEPS H₃ verify reference.

## round-2 — NEB-SCF wiring
reaction-path image energy wired to the SCF core (`scf_etot` reuse, d19). `neb_scf.hexa`.

## round-3 — TS-Hessian via materials qforge_phonons reuse (d19)
saddle 1-negative-eigenvalue + imaginary frequency. The Γ-point Hessian IS the materials phonon
engine reused at the TS coordinate (one call), not new code. `ts_hessian.hexa`. g5 32/32 PASS.

## round-4 — dimer / eigenvector-following TS search
endpoint-free saddle via minimum-mode following; R3 imaginary-mode init acceleration. The lowest
Hessian eigenmode the dimer/MMF needs is exactly what DFPT linear-response yields → the DFPT-reuse
line extends to single-ended TS search. `dimer.hexa`. g5 PASS.

---

## depletion judgment (round-4)

chem scale reaction-path mechanics is SEALED: NEB → CI-NEB → TS-Hessian → dimer/eigenvector-
following. All anchors are analytic stationary-point benches (Müller-Brown 2D, LEPS H₃) plus the
DFPT-reuse identity (TS-Hessian = materials qforge_phonons at the TS coordinate). The remaining
frontier is NOT a new method-class: real high-level-QM / experimental reaction barriers require
feeding MOLSCF/atoms correlated energies (CASSCF / CCSD(T)) into the path images + an experimental-
barrier data-swap — an energy-source integration, not a new path brick. The TS-Hessian DFPT reuse
is the chem-scale evidence of the "one engine, six scales" thesis.
