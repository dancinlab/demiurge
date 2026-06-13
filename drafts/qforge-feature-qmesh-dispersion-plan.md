---
slug: qforge-feature-qmesh-dispersion
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated · NATIVE CPU (no pod)
domain: QFORGE-FEATURE (demiurge) — metallic-wall breadth brick (a) real q-mesh dispersion
---

## task brief
The CaH6 cross-val (PR#2485) computes a REAL |g| but the λ is tiny (0.000115 vs QE 4.376) because the
el-ph sum is too NARROW — the fixture hardcodes a single Einstein ω₀=1236.4 K. Breadth brick (a):
replace that with a REAL q-mesh phonon dispersion ω(q,ν) by wiring the existing
qforge_force_constant → qforge_dynmat → qforge_phonons chain over a qforge_mp_grid q-mesh (using the
brick-1 ∂V_loc/∂u #2480 bare-ΔV as the force-constant input), then re-run the CaH6 xval with real
dispersion → a broader λ. Honest residual on the remaining breadth items (off-diag |g_mn|, N(E_F),
screened ΔV) stays explicit.

## locked decisions
- @L1 (complete): build a real q-mesh dispersion driver in stdlib/qforge (e.g. realcell_qmesh.hexa) — qforge_mp_grid q-mesh → per-q qforge_force_constant (via dvloc_du #2480) → qforge_dynmat → qforge_phonons → real ω(q,ν) array, replacing the single hardcoded Einstein ω₀. assert:file stdlib/qforge/realcell_qmesh.hexa
- @L2 (complete): re-run the CaH6 xval feeding the real ω(q,ν) into the realcell_phonon |g| path (#2485) → metallic_a2f (#2476) → broader λ. Report the REAL λ + rel-ε vs 4.376 VERBATIM.
- @L3 (complete · g5): selftest — acoustic sum-rule ω(Γ)=0 over the real q-mesh · Hermiticity of D(q) · ω(q,ν) real/stable · the dispersion is NON-trivial (differs from the single-Einstein). Paste VERBATIM.
- @L4 (safe): NATIVE CPU only (CaH6 7 atoms; nice'd to avoid CPU starvation — the PR#2485 run was killed exit 144 by concurrent jobs, so `nice -n 19` the xval). NO pod ops; live gate pods 38943553·38922322 untouched.
- @L5 (complete · d6 HONESTY): brick (a) of 4 breadth items — broadens the phonon sum, does NOT by itself close 1%. The remaining 3 (off-diag |g_mn| · real N(E_F)+k-mesh · screened ΔV_scf) stay explicit. Report the real λ AS-IS; do NOT force 4.376.
- @L6 (std): g4 <200 lines, 1 concern, stacked PR, self-merge on green. demiurge QFORGE-FEATURE.md metallic line → updated breadth state (brick a DONE · 3 remaining), cite PR.

## next-action checklist
- [ ] worktree off origin/main (`~/core/hexa-lang-qmesh-disp`); HEAD = origin/main (7e5fbb02b or newer)
- [ ] read realcell_phonon.hexa (#2485) + dvloc_du (#2480) + force_constant/dynmat/phonons + mp_grid to fix the compose seam
- [ ] build realcell_qmesh.hexa (mp_grid → per-q force_constant → dynmat → phonons → ω(q,ν))
- [ ] g5 selftest VERBATIM (ω(Γ)=0 sum-rule · Hermiticity · non-trivial-vs-Einstein)
- [ ] re-run CaH6 xval (nice'd) with real dispersion → REAL λ + rel-ε vs 4.376 VERBATIM
- [ ] PR <200 lines + g5 + self-merge; demiurge QFORGE-FEATURE.md breadth update, explicit-path commit
- [ ] ship

## completion criteria
- realcell_qmesh.hexa lands + g5 PASS · CaH6 xval re-run with real q-mesh dispersion → broader REAL λ reported VERBATIM with honest residual (3 breadth items remain). Zero fabrication toward 4.376.

## guards
- g8: pod ops via hexa cloud only; gate pods 38943553·38922322 READ-ONLY (native-CPU task).
- d6/g63: brick (a)/4 — honest partial, broader-but-not-closed is the valid deliverable.
- d9: isolated worktree · explicit paths · separate hexa-lang PR + demiurge commit.
- Sibling agents: a5cf752 owns assembler.hexa (GPU bench), the PROCESS agent owns telemetry_rollup.hexa. Stage only realcell_qmesh.hexa + its test + the demiurge doc.
- plan-guard "without/forced/fabricat" false-positives EXPECTED; consistent with migration-plan @L4/@L5.
