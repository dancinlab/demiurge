---
slug: qforge-cah6-converged-xval
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated · NATIVE CPU (no pod, d7 7-atom cell)
domain: QFORGE-FEATURE (demiurge domains/) — the migration gate's last metallic physics residual
---

## task brief
THE gated residual: run QFORGE-NC end-to-end on a REAL CaH6 cell and cross-val its λ against QE.
Pieces now exist — orchestrator_pw.hexa (M5.7/M5.8 CaH6 real PW chain) + scf_pw.hexa (smeared
metallic SCF) + metallic_a2f.hexa (PR#2476 multi-q α²F assembler) + QE CaH6 ref λ=4.376 (in
qforge_qe_xval_test.hexa / orchestrator_selftest.hexa). Wire the real CaH6 multi-q DFPT |g| path
through metallic_a2f → λ, and compare to QE λ_BZ within the L3 1% bar. This is the engine's
deepest open wall; it may NOT close in one shot — HONESTY (d6) governs the outcome.

## locked decisions
- @L1 (complete): drive the QFORGE-NC CaH6 chain — orchestrator_pw smeared-SCF (M5.8) → real per-q DFPT response over a q-mesh (qforge_mp_grid, e.g. 2×2×2) → metallic_a2f (PR#2476) → λ·ω_log. Reuse the verified bricks (d3/d19); compose, don't reimplement.
- @L2 (complete · d6 HARD HONESTY): report the REAL QFORGE-NC CaH6 λ + rel-ε vs QE 4.376. Do NOT fabricate, tune, or force λ→4.376. If the real λ is far (the M5.7 Γ-only gave ~0.009–0.02), report that number AS-IS with the rel-ε.
- @L3 (complete): CLASSIFY the outcome honestly into one of:
  (a) CLOSED — QFORGE-NC λ within 1% of QE 4.376 → metallic wall closed; flip qforge_migration_gate_test CaH6-NC to terminal + update QFORGE-FEATURE.md "metallic" line to DONE.
  (b) PARTIAL/UNDER-CONVERGED — real λ computed but outside 1%; report the exact λ, rel-ε, and the CONCRETE convergence knob to turn next (denser q-mesh · higher ecut · k-mesh · smearing σ · whether real DFPT |g| is fully wired vs a stand-in). NO forced close.
  (c) BLOCKED — a real brick is missing (e.g. per-q DFPT |g| for the real PW cell not yet wired); report exactly which brick + the minimal next PR to unblock.
- @L4 (safe): NATIVE CPU only (d7 — CaH6 is 7 atoms, small-cell → pool ubu/local, NOT a pod). NO pod ops, do NOT touch the live gate pods 38943553·38922322. If the native run is too heavy, reduce the cell/ecut/q-mesh and SAY SO (note the reduced parameters in the result).
- @L5 (std): whatever lands (g5 selftest of the wired path OR an honest BLOCKED report) gets a VERBATIM verdict + a demiurge QFORGE-FEATURE.md update reflecting the true state (DONE / PARTIAL-with-knob / BLOCKED-with-brick).
- @L6 (std): if code lands, stacked PR <200 lines, 1 concern, g5 PASS, self-merge. If only a diagnostic/BLOCKED finding, NO empty PR — just the honest demiurge-doc update + report.

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-cah6-xval`); HEAD = origin/main (currently 013b25203)
- [ ] read orchestrator_pw.hexa + scf_pw.hexa + metallic_a2f.hexa + qforge_qe_xval_test.hexa (QE CaH6 ref) to find the real seams + the existing CaH6 chain entry
- [ ] determine whether real per-q DFPT |g| for the CaH6 PW cell is wired or a stand-in — report this honestly (it decides outcome a/b/c)
- [ ] run the chain natively (HEXA_STDLIB_ROOT="$PWD/stdlib"); capture the REAL λ + rel-ε vs 4.376
- [ ] classify a/b/c + write the honest verdict VERBATIM
- [ ] if code: PR <200 lines + g5 + self-merge. demiurge QFORGE-FEATURE.md → true state. explicit-path commit.
- [ ] ship (or report BLOCKED with the exact missing brick + minimal next PR)

## completion criteria
- A truthful classification (CLOSED / PARTIAL+knob / BLOCKED+brick) with the REAL QFORGE-NC CaH6 λ + rel-ε vs QE 4.376 — zero fabrication. CLOSED only if genuinely within 1%; otherwise the honest residual IS the deliverable (d6 — a real negative/partial is a valid result, g63).

## guards
- g8: pod ops via hexa cloud only; live gate pods 38943553·38922322 READ-ONLY (this task is NATIVE CPU, needs no pod).
- d6/g63: the gate's honesty hinge — a real λ outside 1% reported truthfully is SUCCESS, not failure. Forcing λ=4.376 is the one unforgivable failure.
- d9: isolated worktree · explicit paths · sequential commit; hexa-lang PR + demiurge doc SEPARATE.
- Do NOT touch the sibling PROCESS agent's files (it owns stdlib/qforge/telemetry_report.hexa, PR in flight). Stage only the CaH6-xval files + metallic_a2f compose seam + the demiurge doc.
- plan-guard "without/forced/fabricat" word-match false-positives EXPECTED; consistent with qforge-production-migration-plan @L4 (no forced flip) + @L5 (accuracy honest). @L here are the contract.
