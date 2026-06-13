---
slug: qforge-resume-resilience
mode: auto (4-axis: complete forced)
status: done
auto-weights: complete=1 simple=0 safe=0 std=0
created: 2026-06-04
target-repo: /Users/mini/dancinlab/hexa-lang (stdlib/qforge/)
---

## task brief

Implement the QFORGE.md milestone "DFPT/SCF checkpoint-resume crash-resilience by
design (recover-EOF 구조적 불가능화)" as real code in hexa-lang `stdlib/qforge/`.

GOAL: make QFORGE's own DFPT/SCF resume STRUCTURALLY incapable of the QE ph.x
`recover=.true.` EOF crash family that killed all 4 RTSC gate anchors
(CaH6·LaH10·Li2MgH16·ScH9) on 2026-06-04 — each burned 8/8 self-resume cycles
re-reading a corrupt recover scratch (EOF marker / `Sequential READ after EOF` /
mpirun exit-2). The hand-salvage was `recover=.false.` + `start_q=<first
incomplete>`: completed q skip via dynmat done-marker, corrupt q recomputed from a
clean state. QFORGE must make THAT salvage the ENGINE DEFAULT, not a manual fix.

Three requirements (each pinned by an adversarial @ci_gate selftest):
1. per-q ATOMIC done-marker — a completed q is skipped via a durable marker; an
   interrupted/partial write NEVER produces a valid marker (half-result can't look done).
2. resume = recompute ONLY the incomplete q from a CLEAN state — never replay a
   corrupt blob.
3. checkpoint read INTEGRITY verification — truncation/EOF/corruption detected →
   that q auto-recomputed (fallback), NOT a crash.

Root-cause handoff: hexa-lang `fc2331a3` (QE-side no-recover fallback gap).
QFORGE is designed to NOT HAVE that gap in the first place.

## locked decisions

- @L1 (complete): new generic module `stdlib/qforge/checkpoint.hexa` — a reusable resilient checkpoint/resume primitive, NOT folded into dfpt.hexa/scf.hexa (clean selftest surface, reused by both DFPT and SCF) · assert:grep "checkpoint"
- @L2 (complete): atomicity = write payload to a temp file → flush → atomic rename into place; the per-q DONE-MARKER is written LAST, also via atomic rename, only AFTER the payload is durably committed — so an interrupted write leaves NO valid marker (POSIX rename atomicity is the guarantee) · assert:grep "rename"
- @L3 (complete): integrity = a length-prefix + a trailing checksum on the checkpoint payload; the reader verifies length AND checksum → on mismatch / truncation / EOF the q is treated as INCOMPLETE → recomputed (NEVER a crash, NEVER a partial-blob replay) · assert:grep "checksum"
- @L4 (complete): contract = generic `qforge_checkpoint_write(dir, q, payload_bytes)` + `qforge_checkpoint_read(dir, q) -> {ok, payload}` + `qforge_resume_scan(dir, nq) -> {done_q[], next_q}` (d4 generic — caller supplies the payload codec; NO hardcoded q/struct names), wired as OPT-IN into the dfpt/scf drivers so that with the feature unused the existing path is 0-diff (regression-pinned) · assert:grep "resume_scan"
- @L5 (complete): each requirement closed by a g5 `@ci_gate` selftest with ADVERSARIAL injection — (a) inject a TRUNCATED checkpoint → assert resume recomputes that q with NO crash; (b) inject a CORRUPT (bad-checksum) checkpoint → same; (c) simulate an interrupted write (payload present, marker absent) → assert that q is NOT treated as done (recomputed); (d) assert COMPLETED q's are skipped (preserved). Paste verdicts VERBATIM, no LLM self-judge · assert:grep "selftest"
- @L6 (safe): NO running RTSC/ABFE job touched — the 4 vast gate-anchor pods (CaH6 39247634 · LaH10 39291022 · Li2MgH16 39291033 · ScH9 39309987) + summer ABFE are READ-ONLY-untouched; this is pure hexa-lang code + selftest, exercised against selftest stubs / throwaway temp dirs only · assert:grep "selftest"
- @L7 (std): land as a stacked 2-PR chain off `origin/main` in an isolated worktree — PR1 = `checkpoint.hexa` primitive + selftest; PR2 (base=PR1) = opt-in wiring into dfpt/scf resume + integration selftest. Each <200 LOC, 1 concern (g4). Do NOT merge — user reviews · assert:grep "checkpoint"

NOTE on the qforge-production-migration-plan.md @L locks (orchestrator build):
this resilience layer is ORTHOGONAL to that plan's orchestrator @L — it adds a
crash-resilient checkpoint primitive, it does NOT alter the `hexa qforge run` /
`dft-run --engine qforge` dispatch surface. No conflict; do not fake or skip
either plan's locks.

## next-action checklist

- [ ] locate stdlib/qforge layout: `dfpt.hexa`, `dfpt_response.hexa`, `scf.hexa`, `scf_pw.hexa` — find where a multi-q DFPT loop / SCF iteration would persist+resume state; map the natural opt-in seam
- [ ] check hexa stdlib fs primitives available (file write/read, rename, flush, exists, checksum/hash) — `grep` stdlib for `rename`/`fs`/`hash`/`crc`; if no atomic-rename primitive exists, use the lowest-level write+rename available and document it
- [ ] PR1 (primitive): write `stdlib/qforge/checkpoint.hexa` — `qforge_checkpoint_write` (temp→flush→atomic rename, marker last), `qforge_checkpoint_read` (len+checksum verify → {ok,payload}), `qforge_resume_scan` (dir,nq → {done_q[],next_q}); generic payload-bytes contract (d4). <200 LOC
- [ ] PR1 selftest `checkpoint_selftest.hexa` @ci_gate: (a) truncated→recompute no-crash · (b) bad-checksum→recompute no-crash · (c) interrupted-write (payload, no marker)→not-done · (d) completed-q→skip/preserve · (e) round-trip write→read byte-identical. Run via `hexa run` (canonical @ci_gate path), paste verdict VERBATIM
- [ ] PR2 (wiring): opt-in entry in dfpt/scf resume path (a `resume_dir`/flag param; absent → 0-diff existing behavior, regression-pinned) that calls resume_scan to skip done q + checkpoint_write per completed q + integrity-fallback recompute on a bad checkpoint. <200 LOC
- [ ] PR2 integration selftest: a multi-q DFPT/SCF resume stub where q_k's checkpoint is corrupt → assert the driver resumes, skips good q's, recomputes the corrupt one, completes — NO crash. Paste verdict VERBATIM
- [ ] regression: existing qforge selftests (dfpt · scf · scf_pw · screening · correlation · L0/L1/L3 · davidson · sternheimer) all green, existing files 0-diff where untouched
- [ ] each PR: `hexa build` + selftest green, Korean commit msg, push, `gh pr create --base <prev>`; do NOT merge (user reviews); `sidecar sync` after push
- [ ] update QFORGE.md milestone `- [ ]`→note PR#s (do NOT flip `[x]` until user merges); append QFORGE.log.md line
- [ ] ship: report the 2-PR stack + verdicts VERBATIM; NO force-push, NO merge

## completion criteria

- 2 PRs open in hexa-lang (stacked, each <200 LOC, g5 @ci_gate selftest GREEN, verdict pasted verbatim)
- requirement 1/2/3 each have a passing adversarial selftest (truncated · corrupt · interrupted-write · completed-skip)
- NO running RTSC gate-anchor or ABFE job perturbed (the 4 vast pods still ph-running after; verify read-only)
- pushed (not merged) · reported back with PR numbers · QFORGE.md/log.md noted (milestone NOT flipped to [x] pre-merge)
