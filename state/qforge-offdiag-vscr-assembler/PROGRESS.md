# QFORGE off-diagonal V_scr(G_a-G_b) el-ph vertex assembler — WIP checkpoint

status: STARTED 2026-06-09T21:16:15Z
base: hexa-lang branch qforge-3d-realspace-scf @ /Users/mini/dancinlab/.wt-qforge-3d-scf (commit f11ba8b30)

## root (rtsc.log.md 2026-06-09/10)
DIAGONAL-only assembler: qforge_vscr_diag_from_v3d collapses V_scr(r) -> V_bar (spatial avg, G=0).
off-diag witness already present: qforge_v3d_offdiag_rms (V_scr 5.56, V_xc 0.69).
el-ph vertex today uses dvbare columns (independent-particle) + band-offdiag g_mn (elph_offdiag.hexa).

## lever
real-space el-ph vertex g = integral psi*_{k+q}(r) . dVscr(r) . psi_k(r) dr
built on scf_pw_realspace 3-D rho(r) cube (scatter->ifft3->psi(r); Vscr(r) cube).

## next
- implement elph_vscr_realspace.hexa (full V_scr(r), not V_bar)
- g5 selftest
- CaH6 n=645 lambda re-measure vs QE 4.376 verbatim
