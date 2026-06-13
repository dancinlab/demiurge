---
slug: qforge-feature-realq-a2f
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-02
repo: hexa-lang (~/core/hexa-lang) · worktree isolated
domain: QFORGE-FEATURE (demiurge domains/)
---

## task brief
The migration default-flip's LAST engine wall is "metallic SCF beyond Γ-only Einstein": M5.8
(#2437/2438/2440) converges a metallic SCF but the el-ph λ is a Γ-only SINGLE-Einstein coarse
estimate — not a real q-mesh α²F. Advance toward an independent λ that can actually cross-val QE
by extending the path to a REAL q-mesh α²F: drive the metallic SCF + DFPT response over a
qforge_mp_grid q-mesh and feed the per-q el-ph into the existing L3 α²F assembler
(qforge_a2f_from_elph) → multi-q α²F → λ = 2∫α²F/ω, instead of a 1-mode δ.

## locked decisions
- @L1 (complete): build a real-q α²F driver in stdlib/qforge (e.g. metallic_a2f.hexa) that, given a q-mesh (qforge_mp_grid) + per-q {ω(q,ν), |g(q,ν)|²} from the metallic DFPT path, assembles a multi-q α²F via the verified L3 assembler (qforge_a2f_from_elph) + L2 integrator → λ·ω_log. assert:file stdlib/qforge/metallic_a2f.hexa
- @L2 (complete): reuse — qforge_mp_grid (q-mesh, d19) · qforge_a2f_from_elph (L3 BZ double-δ, d3/d19) · the L2 moment integrator · the M5.8 smeared+Anderson SCF. 0-diff to those files; the new driver COMPOSES them (d4 generic — caller supplies the per-q el-ph provider closure).
- @L3 (complete): g5 selftest with a SYNTHETIC multi-mode anchor — a known multi-q α²F whose closed-form λ = Σ λ(q,ν) is reproduced (same spirit as L3 YH10 2-mode additivity), proving multi-q assembly ≠ Γ-only. Show σ_ph→0 monotone convergence. Paste verdict VERBATIM.
- @L4 (safe): NO pod ops, NO live-pod touch — synthetic/fixture el-ph input only. The full CaH6 convergence cross-val (QFORGE-NC λ within 1% of QE λ_BZ) needs real DFPT over a q-mesh = GATED/DEFERRED; this PR builds the ASSEMBLY PATH + selftest, honestly leaving the converged-CaH6 cross-val as the next gated step.
- @L5 (complete · d6 HONESTY): do NOT fabricate a CaH6 λ to claim the metallic wall closed. The deliverable is the multi-q α²F ASSEMBLER + g5 on a synthetic anchor; the CaH6 cross-val residual is reported as the remaining gated step (consistent with QFORGE-FEATURE "metallic SCF beyond Γ-only" gate).
- @L6 (std): match qforge L3 selftest idiom (@ci_gate, synthetic-analytic anchor, σ→0 monotone). g4 <200 lines, 1 concern.
- @L7 (std): update demiurge QFORGE-FEATURE.md — mark "metallic SCF beyond Γ-only" as PARTIAL (multi-q assembler DONE · CaH6 converged cross-val still gated), cite the new PR. explicit-path commit.

## next-action checklist
- [ ] isolated worktree off origin/main (`~/core/hexa-lang-realq-a2f`); confirm HEAD = origin/main (40abe986a)
- [ ] read elph.hexa (qforge_a2f_from_elph L3 surface) + mpgrid.hexa + the M5.8 scf smeared entry to fix the compose seams
- [ ] build metallic_a2f.hexa (q-mesh → per-q el-ph provider → L3 assembler → L2 integrator → λ·ω_log)
- [ ] g5 selftest VERBATIM — synthetic multi-q λ=Σλ(q,ν) reproduced · σ→0 monotone · Γ-only vs multi-q distinct. HEXA_STDLIB_ROOT="$PWD/stdlib" for unmerged stdlib.
- [ ] stacked PR <200 lines · 1 concern · self-merge squash on g5 green
- [ ] demiurge QFORGE-FEATURE.md: metallic-SCF line → PARTIAL (assembler DONE · CaH6 cross-val gated) + cite PR. explicit-path commit, Korean msg
- [ ] ship

## completion criteria
- metallic_a2f.hexa lands + g5 PASS (synthetic multi-q λ=Σλ reproduced · σ→0 monotone · distinct from Γ-only) · QFORGE-FEATURE.md metallic line → PARTIAL with honest gated residual.
- HONEST (d6/@L5): zero fabricated CaH6 λ; the converged-CaH6 QE cross-val is explicitly the remaining gated step, not faked-closed.

## guards
- g8: pod ops via hexa cloud only; LIVE gate pods 38943553·38922322 READ-ONLY (this task needs NO pod — synthetic el-ph fixtures only).
- d9: isolated worktree · explicit paths · sequential commit. hexa-lang PR + demiurge doc = SEPARATE commits.
- d6: this is the migration gate's honesty hinge — building the assembler is real progress; do NOT claim the metallic wall closed without a real converged CaH6 cross-val.
- plan-guard "without/forced/fabricat" word-match false-positives EXPECTED; consistent with qforge-production-migration-plan @L4 (no forced flip) + @L5 (correlation/accuracy honest). @L here are the contract.
- Do NOT touch the sibling PROCESS agent's files (it owns telemetry_report.hexa). Stage only metallic_a2f.hexa + its test + the demiurge doc.
