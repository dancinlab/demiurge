---
slug: qforge-feature-realcell-phonon
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated · NATIVE CPU (no pod)
domain: QFORGE-FEATURE (demiurge domains/) — real |g| brick 2/2, the metallic-wall closer attempt
---

## task brief
brick 1/2 (∂V_loc/∂u, PR#2480) just merged — the bare-perturbation provider now EXISTS. Build
brick 2/2: a real-cell phonon driver that wires the existing force_constant→dynmat→phonons chain
to the CaH6 PW cell using the dvloc_du(#2480) bare-ΔV provider → REAL ω(q,ν) + real |g| → feed
metallic_a2f (#2476) → REAL CaH6 λ. Then re-run the CaH6 cross-val with REAL physics (no stand-in)
and report the honest classification. This is the direct attempt to CLOSE the metallic wall.

## locked decisions
- @L1 (complete): build a real-cell phonon driver in stdlib/qforge (e.g. realcell_phonon.hexa) — for the CaH6 cell, use qforge_dvloc_du (#2480) as the dV_bare_provider into qforge_force_constant → qforge_dynmat → qforge_phonons over a qforge_mp_grid q-mesh → real ω(q,ν); pair with qforge_elph_g2 for real |g(q,ν)|² (NOT the stand-in constant). assert:file stdlib/qforge/realcell_phonon.hexa
- @L2 (complete): compose into metallic_a2f (#2476) → real multi-q α²F → real λ·ω_log. Reuse all verified bricks (dvloc_du · force_constant · dynmat · phonons · elph_g2 · metallic_a2f · L2 integrator) — d3/d19, 0-diff existing files.
- @L3 (complete · d6 HARD HONESTY): re-run the CaH6 cross-val with this REAL path; report the REAL QFORGE-NC λ + rel-ε vs QE 4.376 VERBATIM. Do NOT tune/force λ→4.376. Classify:
  (a) CLOSED — λ within 1% → metallic wall closed; flip qforge_migration_gate_test CaH6-NC to terminal (real, not L0-identity placeholder) + QFORGE-FEATURE.md metallic → DONE.
  (b) PARTIAL — a genuine matrix-element λ computed but outside 1%; report exact λ, rel-ε, and the concrete next knob (denser q · ecut · k-mesh · nonlocal |g| term · σ). NO forced close.
  (c) BLOCKED — a further real brick still missing; name it + the minimal next PR.
- @L4 (safe): NATIVE CPU (CaH6 7 atoms, small → local/pool, NOT a pod). NO pod ops; live gate pods 38943553·38922322 untouched. Reduce q-mesh/ecut if too heavy + SAY SO.
- @L5 (std): g5 — a selftest of the real-cell driver (e.g. real-cell ω(q,ν) acoustic sum-rule ω(Γ)=0 + Hermiticity + the |g| path non-trivial vs stand-in). Plus the cross-val verdict VERBATIM. g4 <200 lines, 1 concern.
- @L6 (std): demiurge QFORGE-FEATURE.md — metallic line to the TRUE state (DONE / PARTIAL-with-knob / BLOCKED-with-brick) citing this PR + #2480. explicit-path commit.

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-realcell-phonon`); HEAD = origin/main (055dd0fb5 or newer)
- [ ] read dvloc_du.hexa (#2480 provider shape) + qforge_force_constant/dynmat/phonons + qforge_elph_g2 + metallic_a2f + the CaH6 fixture (cah6_scf_run.hexa stand-in to replace)
- [ ] build realcell_phonon.hexa wiring dvloc_du → force_constant → dynmat → phonons → elph_g2 → metallic_a2f
- [ ] run CaH6 natively (HEXA_STDLIB_ROOT="$PWD/stdlib"); capture REAL λ + rel-ε vs 4.376; classify a/b/c
- [ ] g5 selftest VERBATIM (acoustic sum-rule · Hermiticity · |g| non-trivial) + cross-val verdict VERBATIM
- [ ] PR <200 lines + g5 + self-merge (or BLOCKED report if a brick still missing — no empty PR)
- [ ] demiurge QFORGE-FEATURE.md → TRUE state. explicit-path commit, Korean msg
- [ ] ship

## completion criteria
- Real (non-stand-in) QFORGE-NC CaH6 λ computed + rel-ε vs QE 4.376 reported VERBATIM, with an honest CLOSED/PARTIAL/BLOCKED classification. CLOSED only if genuinely within 1%; a real PARTIAL/BLOCKED is a valid deliverable (g63). Zero fabrication toward 4.376.

## guards
- g8: pod ops via hexa cloud only; gate pods 38943553·38922322 READ-ONLY (native-CPU task, no pod).
- d6/g63: the metallic-wall honesty hinge — a real λ outside 1% reported truthfully is SUCCESS; forcing 4.376 is the one unforgivable failure.
- d9: isolated worktree · explicit paths · sequential commit; hexa-lang PR + demiurge doc SEPARATE.
- Sibling PROCESS agent owns stdlib/qforge/telemetry_regress.hexa — do NOT touch it. Stage only realcell_phonon.hexa + its test + (if closing) the gate-test flip + the demiurge doc.
- plan-guard "without/forced/fabricat" false-positives EXPECTED; consistent with qforge-production-migration-plan @L4/@L5. @L here are the contract.
