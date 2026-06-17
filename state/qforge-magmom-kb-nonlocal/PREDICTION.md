# FROZEN PREDICTION — QFORGE CoSn magnetism, KB-nonlocal lever (d6, written BEFORE compute)

Lane: qforge-magmom-basis. Round: KB-nonlocal reduced-basis lever.
Date frozen: 2026-06-16 (mini, before any SCF run)
Branch: qforge/magmom-reduced-basis

## Context / gap
QFORGE-LSDA spin engine (mode d) is g5-PASS, but the real-cell CoSn moment is
PW-compute-walled: at the only tractable basis (npw≈80) the Co-3d shell is
under-resolved → spurious m≈0; npw≥120 is intractable on mini-CPU. QE-PBE
k-mesh reference = m = 0.43 μ_B/cell.

## The observation driving this round
ALL existing CoSn fixtures (cosn_kagome_spin / cosn_gga_gamma / cosn_kmesh*_spin)
run with `nprojs=[0,0]` — i.e. LOCAL-ONLY pseudopotential, the nonlocal KB
projectors DISABLED. The Co ONCV_PBE_sr.upf carries 6 nonlocal projectors,
INCLUDING 2 d-channel (l=2) projectors (verified: angular_momentum="2" ×2).
The d-channel KB projector is precisely what binds/localizes the Co-3d shell.
With it OFF, the 3d states are essentially unbound regardless of PW count, so
m≈0 is unsurprising and is NOT a clean basis-only refutation.

The projector machinery (projector.hexa qforge_vnl_block, l up to 2; upf.hexa
betas/ls/dij parse; assembler qforge_assemble_h_multi KB staging) is COMPLETE
and g5-verified. The fixtures simply never wired it in. This is a reduced-basis
lever: projector-bound d-states need far less PW resolution than free PW
d-states (the projector supplies the short-range form factor analytically).

## PREDICTION (falsifiable, committed before compute)
Step: CoSn Γ LSDA spin SCF at a tractable npw (≈80) with KB nonlocal projectors
TURNED ON for both species (Co 6-proj incl. d-channel, Sn projectors).

H1 (the lever works fully): moment appears AND reproduces QE sign+magnitude
    (m ∈ [0.3, 0.55] μ_B). → 🟢. **I judge this UNLIKELY at Γ-only** because the
    Stoner moment is BZ-integrated (the Γ flat band is fully occupied both spins).

H2 (partial — most likely, ~55%): turning KB-nonlocal ON produces a NON-ZERO
    moment at tractable npw where local-only gave m≈0, i.e. it moves the needle
    (the d-channel now binds), but the magnitude is off / needs k-mesh to match
    0.43. → 🟠. A non-zero moment at tractable cost = real progress on the wall.

H3 (wall holds): even with KB-nonlocal ON, Γ-only m≈0 (Stoner needs k-mesh that
    is itself intractable with projectors at npw making the per-iter cost worse).
    → 🧱 verified-terminal for the Γ reduced-basis sub-lever; names k-mesh+GPU as
    the remaining path. A clean wall is a valid result (d6).

My honest point estimate: H2 or H3. I do NOT expect to hit QE 0.43 at Γ this
round. I will NOT dress a still-zero m as success, and I will NOT force 0.43.

## Cost sizing (d11)
KB-nonlocal ADDS cost: qforge_vnl_block is O(npw²·nproj) dense, built once per
(k) in the cached bare-H. At Γ (nk=1), npw≈80, this is tractable (the bare-H is
built once; the SCF loop reuses it). So Γ + KB-nonlocal is expected ~tens of s —
tractable on mini-CPU. k-mesh × KB-nonlocal × npw≥120 remains intractable.
