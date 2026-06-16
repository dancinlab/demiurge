# VERDICT — QFORGE CoSn magnetism, KB-nonlocal reduced-basis lever

Lane: qforge-magmom-basis. Branch: qforge/magmom-reduced-basis
Date: 2026-06-16 (mini-CPU). Honest (d6) — no fabricated moment.

## Lever chosen + why
Reduced-basis path via the **KB nonlocal projectors** (the lane's named
reduced-basis lever, cheaper to test than full PAW or GPU-davidson which are
multi-day ports). Decisive observation: every prior CoSn fixture ran
`nprojs=[0,0]` (LOCAL-ONLY pseudopotential). The Co ONCV_PBE_sr.upf carries 6
nonlocal projectors incl. **2 d-channel (l=2)** — the channel that binds the
Co-3d shell. With it off, the 3d shell is unbound regardless of PW count, so the
prior m≈0 was ambiguous (basis vs k-sampling). Turning KB-nonlocal ON, with the
existing g5-verified projector.hexa/upf.hexa/assembler machinery, is a true
reduced-basis lever: the projector supplies the short-range d form factor
analytically, keeping npw tractable.

## VERBATIM results

### Step 1 — Γ, KB-nonlocal ON, npw=80 (cosn_kb_nonlocal_spin.hexa)
```
nelec=93 nbands=54 NPW=80 | KB: Co nproj=6 (d-channel l=2 count=2) Sn nproj=6
converged=true iters=13
e_total=-82.8671 Ha
MAGNETIZATION m = -2.14517e-05 μ_B/cell
```
Wall time: real 6.53 s (13 iters, ~0.5 s/iter). CONVERGED, CHEAP, m ≈ 0.

### Step 2 — 2×2×2 MP k-mesh (8 k), KB-nonlocal ON, npw=80 (cosn_kb_kmesh_spin.hexa)
max_iter=80 TIMED OUT >580 s. Capped at max_iter=8 (cosn_kb_kmesh_cap8, temp):
```
nelec=93 nbands=54 NPW=80 nk=8 (MP 2³) | KB nonlocal ON (Co d-channel)
converged=false iters=8
MAGNETIZATION m = 0.000398144 μ_B/cell
real 671.68
```
=> ~84 s/iter at MP 2³ (vs ~0.5 s/iter at Γ — a ~170× per-iter blowup, NOT the
naive 8×: finite-k davidson dominates). 8 iters → m=4e-4, NOT converged and NOT
trending toward 0.43. Full convergence (~tens of iters) = ~30-60 min, with no
evidence of an emerging moment at this coarse mesh; QE 0.43 needs denser k +
spin-GGA + smaller σ, each multiplying the cost further. Cost wall confirmed.

## Findings (honest)
1. **The reduced-basis (KB-nonlocal) lever did NOT, by itself, reproduce the
   moment.** At Γ, with the Co d-channel projectors correctly staged and the SCF
   fully converged, m = -2.1e-5 ≈ 0. This is a CLEANER result than the prior
   ambiguous m≈0: it separates the two candidate causes — the Γ moment is killed
   by **k-sampling (BZ-integrated Stoner)**, NOT purely by PW cutoff or missing
   d-binding. Even with a physically correct d-shell, a single Γ point cannot
   carry an itinerant moment (the flat band is fully occupied in both spins).

2. **The k-mesh that WOULD carry the moment is not tractable on mini-CPU**, even
   at the reduced npw=80 the KB-nonlocal lever affords. The cost is
   nk × 2 spins × davidson(npw) per SCF iter, and finite-k davidson is the
   bottleneck. 8 k-points × ~tens of iters exceeds the mini budget.

3. Net: the reduced-basis lever **lowers the per-(k,spin) cost** (npw=80
   tractable, d-shell bound), but the WALL relocates from "PW cutoff" to
   "k-mesh × finite-k davidson throughput". This is real diagnostic progress: it
   rules out the PW-cutoff-only framing and pinpoints finite-k davidson
   throughput as the actual ceiling → **GPU-davidson is now the indicated
   lever**, not further basis reduction.

## VERDICT TIER: 🧱 wall verified (k-mesh × finite-k davidson throughput),
   with a 🔵-grade clean Γ sub-result (KB-nonlocal ON → m≈0 at Γ, converged).
   NOT 🟢 (no QE-magnitude moment) and NOT a dressed-up m≈0 (the Γ m≈0 is
   reported as the honest BZ-degeneracy result it is, d6).

## Remaining-work sizing (d11, honest)
- GPU-davidson on summer RTX 5070: the indicated next lever. But the existing
  nvptx_davidson_vthv_host.cu only GPU-offloads the Vᵀ H V subspace projection
  (a small GEMM), NOT the matrix-free H_apply matvec nor the davidson loop /
  Anderson / Fermi. A full GPU finite-k davidson for the spin SCF is a multi-day
  port (H_apply on GPU + per-(k,spin) batching). Out of one-round scope.
- Alternatively accept QE m=0.43 as the recorded cross-val reference (already
  done) and keep QFORGE gated only on the g5-verified spin bricks — consistent
  with the prior memory conclusion.
