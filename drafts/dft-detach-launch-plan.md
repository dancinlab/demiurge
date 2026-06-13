---
slug: dft-detach-launch
mode: auto:safety
status: shipped
auto-weights: complete=1, simple=1, safety=2, std=1
created: 2026-05-30
repo: hexa-lang (~/core/hexa-lang)
---

## task brief

Add a sanctioned NON-BLOCKING detach launch mode to `hexa cloud dft-run`
(`stdlib/cloud/dft_dispatch.hexa`) so paced multi-candidate el-ph campaign
dispatch works WITHOUT the forbidden `( nohup dft-run --go & )` double-fork
(the launchd-zombie fork-storm just banned in demiurge `project.tape`
`d_parallel_fire`).

ROOT GAP: `_dft_go` runs rent→provision→relax→scf→ph→teardown synchronously in
ONE local process (hours), which (a) exceeds the 10-min Bash tool cap and (b)
the only background workaround is the banned fork-storm hack. The new policy
forbids the hack but the toolchain offers no sanctioned detach → policy↔tool
hole. This PR closes it.

DESIGN = option α 2-phase detach. The expensive QE stages run ON the pod
detached (via the EXISTING `cloud_nohup_opts`); the local side only does quick
kickoff + (later) a re-invokable harvest/parse. The hexa-native coord parser
(`dft_relax_to_scf_coords`, "hand-parser FORBIDDEN" guard) stays LOCAL — it is
NOT reimplemented on the pod.

## locked decisions

- @L1 (std): keep `--go` synchronous path INTACT (backward-compat; /system may
  rely on it) · ADD `--detach` (phase-1 launch) + `--resume` (phase-2) flags ·
  assert:grep --detach
- @L2 (safety): hexa-native coord parse stays LOCAL — `--resume` harvests
  relax.out then calls `dft_relax_to_scf_coords` on the LOCAL machine before
  assembling scf · assert:grep dft_relax_to_scf_coords
- @L3 (std): reuse `cloud_nohup_opts` for the detached remote stage launch +
  `cloud_tail_cmd` for Monitor; phase-1 records pod-id+logfile via
  `pod_registry_record` and does NOT teardown · assert:grep cloud_nohup
- @L4 (safety): phase-2 is an EXPLICIT idempotent `--resume` (re-invokable,
  reads pod state from registry/logfile) — NOT an auto-poll loop that could
  hang past the Bash cap · assert:grep --resume
- @L5 (std): `--resume` detects terminal (ph JOB DONE + dynN complete, per the
  QE checkpoint-trap guard) → harvest ph.out + render verdict + teardown · Monitor
  via `hexa cloud tail` · assert:grep teardown
- @L6 (simple): stacked PRs — PR1 = phase-1 `--detach` launch (relax detached +
  return) · PR2 = phase-2 `--resume` (harvest→local-parse→scf+ph detached→
  terminal harvest+teardown) · each <200 lines where feasible (g4)
- @L7 (complete): add `dft_dispatch_test.hexa` case(s) covering the new flag
  parse + the detach command shape · `hexa run <test>` self-test PASS is the g5
  evidence (paste verbatim) · assert:file stdlib/cloud/dft_dispatch_test.hexa

## next-action checklist

- [ ] create worktree `~/core/hexa-lang-dft-detach` off origin/main (NOT /tmp —
      reaper drops /tmp worktrees + branch); push branch immediately
- [ ] PR1 — add `--detach` flag to `dft_run` arg parse + a `_dft_go_detach`
      path: rent→endpoint→reach→upload→provision→pseudo (reuse existing helpers)
      then launch relax via `cloud_nohup_opts` (detached, logfile e.g.
      `/root/deck/relax.nohup.log`), `pod_registry_record`, print pod-id +
      `hexa cloud tail` hint, RETURN 0 (no teardown)
- [ ] PR1 — `dft_dispatch_test.hexa`: assert `--detach` parsed + detached relax
      command contains nohup + logfile + no teardown; `hexa run` PASS
- [ ] PR1 — `gh pr create --head` (concurrent-worktree rule) · base origin/main
- [ ] PR2 (base PR1) — add `--resume` flag + `_dft_go_resume`: resolve pod from
      registry, check relax terminal, `cloud_copy_from` relax.out, LOCAL
      `dft_relax_to_scf_coords`, assemble scf.in.gen, upload, launch scf+ph
      detached via `cloud_nohup_opts`; a second `--resume` after ph terminal →
      harvest ph.out + `dft_phonon_stable` verdict + `_dft_teardown`
- [ ] PR2 — `dft_dispatch_test.hexa`: `--resume` parse + local-parse-stays-local
      assertion (coord parse fn referenced) + terminal→teardown shape; `hexa run` PASS
- [ ] PR2 — `gh pr create --head --base <PR1-branch>`
- [ ] update `dft_run` usage string + the leading doc comment to document
      `--detach` / `--resume` (the paced-campaign launch pattern)
- [ ] ship — commit (Korean body) · push · (hexa-lang lands via PR, auto-merge
      per hook) · report PR URLs + verbatim `hexa run` self-test verdicts

## completion criteria

- `hexa cloud dft-run <deck> --detach` provisions a pod, launches relax
  DETACHED on the pod, and RETURNS within the Bash 10-min cap (no local block).
- `hexa cloud dft-run <deck> --resume` is idempotent: drives relax→scf→ph
  forward one terminal step at a time, parses coords LOCALLY, and on ph-terminal
  harvests + renders verdict + tears the pod down.
- NO `( nohup … & )` double-fork anywhere in the new path; the long stages run
  on the POD via cloud_nohup, the local CLI returns promptly.
- `dft_dispatch_test.hexa` self-test PASS (paste verbatim) — g5 evidence.
- `--go` synchronous path unchanged (regression: existing test still PASS).
- Both PRs landed on hexa-lang.
