# QFORGE from-scratch lane — ambient light-hydride — UPSTREAM BLOCKER (handoff to hexa-lang)

## Status: BLOCKED (honest, d6). QE production lane is the live reference (advancing).

The coordinator-requested QFORGE from-scratch λ lane for the ambient candidates
(AcBeH8 FCC, CaB3C3/LaB3C3 SC) is blocked by a geometry-parser gap + a live
concurrent-edit collision in the shared compile home `~/.hx/src`.

## Root cause 1 — qpw_parse_geometry supports ONLY ibrav=3 (BCC-primitive)
`stdlib/qforge/pw_frontend.hexa` `qpw_parse_geometry` rejects every non-BCC cell:
- AcBeH8 = ibrav=2 (FCC) → rejected
- CaB3C3 / LaB3C3 = ibrav=1 (simple cubic) → rejected
The CaH6/LaH10/YH6 hydride family is all BCC-prim, so this never surfaced before;
the AMBIENT clathrate family (BeH8 FCC, MB3C3 SC) needs ibrav 1 & 2.

## The fix IS verified correct (it briefly survived one compile)
When applied, the parse test returned (EXACT, no tuning):
```
PARSE_OK ibrav=2(FCC) a=10.0151 omega=251.134
a1=-5.00755,0.0,5.00755          # = (a/2)(-1,0,1) ✓
b2=0.627371,0.627371,0.627371    # = (2π/a)(1,1,1) ✓
```
Ω=251.134 = a³/4 = 1004.5/4 ✓ (FCC primitive volume). Geometry math is correct.

## PATCH (qpw_parse_geometry, branch on ibrav)
```hexa
if ibrav != 3 && ibrav != 2 && ibrav != 1 {
    return _qpw_geom_err(bad, "NAMED-REMAINING: ibrav=" + to_string(ibrav)
        + " unsupported (FULL: ibrav=1 SC, 2 FCC, 3 BCC-primitive cubic). ...")
}
// ... after celldm/ntyp/nat parse:
let ha = 0.5 * a
let tpa = _QPW_2PI / a
let mut omega = 0.0
let mut a1 = [] ; let mut a2 = [] ; let mut a3 = []
let mut b1 = [] ; let mut b2 = [] ; let mut b3 = []
if ibrav == 3 {            // BCC-primitive (unchanged)
    omega = a*a*a*0.5
    a1=[ha,ha,ha]; a2=[-ha,ha,ha]; a3=[-ha,-ha,ha]
    b1=[0.0,tpa,tpa]; b2=[-tpa,0.0,tpa]; b3=[-tpa,-tpa,0.0]
} else if ibrav == 2 {     // FCC
    omega = a*a*a*0.25
    a1=[-ha,0.0,ha]; a2=[0.0,ha,ha]; a3=[-ha,ha,0.0]
    b1=[-tpa,-tpa,tpa]; b2=[tpa,tpa,tpa]; b3=[-tpa,tpa,-tpa]
} else {                   // SC (ibrav==1)
    omega = a*a*a
    a1=[a,0.0,0.0]; a2=[0.0,a,0.0]; a3=[0.0,0.0,a]
    b1=[tpa,0.0,0.0]; b2=[0.0,tpa,0.0]; b3=[0.0,0.0,tpa]
}
```

## Root cause 2 — two pre-existing WIP gaps in the same tree (also need fixing)
1. `qforge_scf_pw_h_multi_smeared_rs3d` is CALLED (pw_frontend.hexa:629, behind
   `if QPW_RS3D`) but NEVER DEFINED → whole module fails to compile.
   FIX: add a wrapper in scf_pw.hexa that routes the rs3d arg-list (gmiller, no
   nx/ny/nz) to the verified spectral `qforge_scf_pw_h_multi_smeared` (nx=ny=1,
   nz=n). RS3D real-space cube is the WIP piece; spectral fallback is honest.
2. `qpwfft_ktf2_from_density` / `qpwfft_enable_tf` (defined in screening_pwfft.hexa,
   used in pw_frontend.hexa:1122/1139) are undeclared at C-link UNLESS the ENTRY
   module explicitly `use "stdlib/qforge/screening_pwfft"` — a transitive-import
   flatten gap (pw_frontend imports it but the symbol isn't emitted for callers
   that reach line 1122). Workaround: entry imports screening_pwfft directly.

## Root cause 3 (operational) — concurrent-edit collision in ~/.hx/src
The fix to `~/.hx/src/stdlib/qforge/pw_frontend.hexa` was reverted repeatedly
within seconds by a concurrent process (another agent editing the same qforge
files — scf_pw.hexa gained an unrelated +413-line change mid-session). Per d3/d9
(one canonical home, no shared-index contention) the fix must be merged from a
CLEAN dev clone via PR, NOT hand-applied to the contended live install.

## Decision (d_qforge_fix): long fix → QE production continues as the reference.
QE el-ph/stability is the production reference and is advancing on all 3 pods.
QFORGE-fs is recorded as honestly blocked; the patch above lands via hexa-lang PR.
Once merged + reinstalled, rerun: hexa run scripts/scratch/ambient_wave/qforge_fs/run_acbeh8_fs.hexa
(deck + pseudos already staged at scripts/scratch/ambient_wave/qforge_fs/AcBeH8_deck/).
