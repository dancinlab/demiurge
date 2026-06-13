---
slug: qforge-dvloc-du-brick
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-FEATURE (demiurge domains/) — real |g| brick 1/2 unblocking the metallic wall
---

## task brief
The CaH6 cross-val BLOCKED finding (demiurge 73e9157) showed the QFORGE-NC el-ph coupling is a
constant STAND-IN, not real DFPT |g| — λ=0.0208 vs QE 4.376 (99.5% off). Two real-physics bricks
unblock it. This task builds BRICK 1/2: `qforge_dvloc_du` — the phonon-displacement bare-potential
derivative ∂V_loc/∂u → ΔV_bare|ψ⟩. This is the missing input the existing qforge_force_constant /
metallic_a2f path needs to compute a REAL coupling instead of a stand-in.

## locked decisions
- @L1 (complete): build `qforge_dvloc_du` in stdlib/qforge — the G-space structure-factor derivative of the local potential w.r.t. atomic displacement u_κ: ∂V_loc/∂u_κ(G) = i(G)·V_loc^κ(|G|)·e^{-iG·τ_κ} (per species κ, per Cartesian dir), returning the bare ΔV_bare provider the Sternheimer/force-constant path consumes. assert:file stdlib/qforge/dvloc_du.hexa
- @L2 (complete): REUSE the existing `qforge_vloc_of_g` (V_loc(G), d3/d19) — the new brick is its displacement derivative, NOT a reimplementation. d4-generic: element/structure agnostic (species τ_κ + V_loc^κ supplied by caller).
- @L3 (complete · g5 STRONG): selftest with a FINITE-DIFFERENCE cross-check — the analytic ∂V_loc/∂u(G) must match (V_loc[τ+δ] − V_loc[τ−δ])/(2δ) per G within rel-ε≤1e-6 (the same FD-vs-analytic gate the L4 DFPT response used). Plus: G=0 behavior, Hermiticity/realness of the assembled ΔV, malformed guard. Paste verdict VERBATIM.
- @L4 (safe): READ-only/pure brick — no pod ops, no live-pod touch (gate pods 38943553·38922322 untouched). 0-diff existing files; compose, don't mutate.
- @L5 (complete · d6 HONESTY): this is BRICK 1/2 — it does NOT by itself close the metallic wall (brick 2 = the real-cell phonon ω(q,ν) driver still needed). State that honestly; do NOT claim CaH6 cross-val closed. The deliverable is the verified ∂V_loc/∂u kernel + its g5.
- @L6 (std): match the qforge brick selftest idiom (@ci_gate, FD-vs-analytic anchor like dfpt_response_selftest). g4 <200 lines, 1 concern, stacked PR, self-merge on green.
- @L7 (std): update demiurge QFORGE-FEATURE.md — the metallic line's "missing brick 1 (∂V_loc/∂u)" → DONE (cite PR); brick 2 (real-cell phonon driver) remains the open unblock step. explicit-path commit.

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-dvloc-du`); HEAD = origin/main (currently 013b25203 or newer)
- [ ] read qforge_vloc_of_g + the dfpt_response/force_constant seam to fix the ΔV_bare provider shape the consumer expects
- [ ] build dvloc_du.hexa (analytic ∂V_loc/∂u(G) structure-factor derivative)
- [ ] g5 selftest VERBATIM — FD-vs-analytic rel-ε≤1e-6 · G=0 · realness · guard. HEXA_STDLIB_ROOT="$PWD/stdlib"
- [ ] stacked PR <200 lines · 1 concern · self-merge squash on green
- [ ] demiurge QFORGE-FEATURE.md: brick 1 → DONE (cite PR) · brick 2 still open. explicit-path commit, Korean msg
- [ ] ship

## completion criteria
- qforge_dvloc_du lands + g5 PASS (FD-vs-analytic rel-ε≤1e-6) · QFORGE-FEATURE.md brick-1 → DONE with brick-2 honestly still open.
- HONEST (d6/@L5): brick 1 of 2; the metallic wall is NOT claimed closed. A verified derivative kernel is the deliverable.

## guards
- g8: pod ops via hexa cloud only; gate pods 38943553·38922322 READ-ONLY (this is a pure-physics brick, no pod).
- d9: isolated worktree · explicit paths · sequential commit; hexa-lang PR + demiurge doc SEPARATE.
- d6/g63: brick 1/2 — honest partial, no forced close.
- plan-guard "without/forced/fabricat" word-match false-positives EXPECTED; consistent with qforge-production-migration-plan @L4/@L5. @L here are the contract.
- No sibling agents currently hold qforge brick files; still stage ONLY dvloc_du.hexa + its test + the demiurge doc.
