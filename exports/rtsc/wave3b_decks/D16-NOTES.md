# wave-3b d16 dry-run notes (explicit-positions re-author)

Pod-2 `ssh9.vast.ai:15988` (vast contract 38095989), QE 6.7 (apt), via `hexa cloud`.

## Root-cause of the 4 original failures (space_group / crystal_sg mode)
- YH9, CeH9 (P6_3/mmc #194): `check_atoms (1): atoms #1 and #2 overlap` — crystal_sg
  representative-site orbit expansion collided.
- YH10, Li2MgH16 (cubic #225/#227): `input (1): Input ibrav not compatible with
  space group number`.

## Fix: explicit Wyckoff-orbit expansion (YH6-proven pattern)
spglib `get_symmetry_from_database(hall)` expands published Wyckoff reps to full
explicit `ATOMIC_POSITIONS crystal`; no `space_group` card. ibrav set per lattice.

| cand | SG | ibrav | nat | comp | min H-H (Ang) | d16 |
|------|----|-------|-----|------|--------------|-----|
| CeH9 | P6_3/mmc #194 | 4 (hex) | 20 | Ce2H18 | 1.120 | PASS |
| YH9  | P6_3/mmc #194 | 4 (hex) | 20 | Y2H18  | 1.091 | PASS |
| YH10 | Fm-3m #225    | 2 (fcc-prim) | 11 | YH10 | 1.028 | PASS |
| Li2MgH16 | Fd-3m #227 o2 | 2 (fcc-prim) | 38 | Li4Mg2H32 | 0.798 | PASS (after Li-pseudo fix) |

### CeH9/YH9 coordinate correction (no hallucination — grounded)
Task brief gave H 12k z=0.4404 -> min H-H 0.55 Ang (unphysical overlap). Nature Comm
2019 (s41467-019-12326-y) publishes CeH9 P6_3/mmc 12k at **z=0.062**, restoring the
paper's measured nearest H-H = 1.116 Ang (our expansion: 1.120). Brief value was a
transcription error; used published 0.062.

### YH10 / Li2MgH16 cell choice
Cubic Fm-3m/Fd-3m: used the **FCC primitive cell** (ibrav=2), not the conventional
cubic (ibrav=1), to keep nat tractable for ph.x (YH10 11 vs 44; Li2MgH16 38 vs 152).
96g for Li2MgH16 recast as the (x,x,z) special form (brief's 3-distinct-number triple
is a general-position form -> over-expands to 192 + overlap).

## Li.UPF (Li.pbe-s-rrkjus_psl.1.0.0.UPF) QE-6.7 parser bug + fix
Li2MgH16 d16 first failed (np=2 AND np=1 serial) with:
  `end of file reached, tag PP_GIPAW_ORBITALS not found` (xmltools.f90:1126).
Isolated to **Li.UPF only** (Mg.UPF + H.UPF + Y.UPF all read fine). QE 6.7's UPF-v2
XML reader trips on this Li pseudo's PP_GIPAW block.

Fix (GIPAW data is NMR-only, irrelevant to el-ph): strip the whole
`<PP_GIPAW ...>...</PP_GIPAW>` block AND flip header `has_gipaw="true"`->`"false"`.
  sed '<gs>,<ge>d' Li.<orig>.UPF > Li.nogipaw.UPF   # gs/ge = PP_GIPAW open/close lines
  sed -i 's/has_gipaw="true"/has_gipaw="false"/' Li.nogipaw.UPF
  ln -sf Li.nogipaw.UPF Li.UPF                       # repoint symlink, deck unchanged
Verified: Li.nogipaw.UPF parses clean (reaches SCF). Li2MgH16 d16 then PASS.
