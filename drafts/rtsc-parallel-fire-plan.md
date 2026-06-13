---
slug: rtsc-parallel-fire
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
---

# rtsc-parallel-fire — plan

## task brief
Fire the RTSC candidates that are either (a) queued-but-not-running (Wave-2 perovskite family,
scf-done on pod 38095989 but ph stuck behind CaAuH3 in a sequential onstart.sh chain) or (b)
entirely un-fired (Li2MgH16, CeH9, LaY_H10 — in drafts, never staged). Launch ALL of them in
PARALLEL ("수직" = each its own dedicated run, NOT a single-pod sequential queue), with
oversubscription strictly avoided (the A11 pod's 5× thrash must not recur). Li2MgH16 gets a SOLO
dedicated pod with the SHORTEST-walltime valid spec for a fast first λ signal.

## locked decisions (AUTO 1:1:1:1 + user amendment)
- Q1 Li2MgH16: SOLO dedicated pod. Shortest-walltime valid spec — coarse q-grid (2×2×2), modest ecut (still convergence-sane), Li2MgH16 sodalite-type clathrate at its known stabilization pressure (~250 GPa; confirm from literature/draft). Goal = fastest possible terminal λ/Tc on the headline RT-superconductor candidate.
- Q2 Wave-2 6 (BaAuH3, SrPtH3, YAuH3, KBeH8, MgBeH8, ScH9): copy each deck's `.in` files (small) from pod 38095989 `/root/<name>/` → run fresh full-chain (vc-relax→scf→ph) in PARALLEL on fresh pod(s). Do NOT touch the live CaAuH3 run on 38095989. (Re-running scf fresh is robust + avoids fragile .save pod-to-pod transfer.)
- Q3 CeH9 + LaY_H10: generate decks via `/deck rtsc <slug> '<spec>'` (CeH9 ~150-200 GPa clathrate; LaY_H10 ternary clathrate ~200-300 GPa — confirm coords from drafts/wave3b-coords.md or literature), d16 dry-run, fire in parallel.
- Q4 layout: PARALLEL ("수직"), NO single-pod sequential queue. Per pod: total MPI ranks ≤ physical cores, OMP/MKL/OPENBLAS_NUM_THREADS=1 (pure-MPI, the safe-launch lesson — the A11 pod's 270-thread/load-119 thrash must NOT recur). Bin-pack conservatively (e.g. ≤ physcores/np jobs per pod). Li2MgH16 alone on its pod.
- Q5 leak-guard: the local hexa-cloud is now 0.5.0 (#2056 — `cloud rent` auto-registers M5 + composite watchdog + hourly --kill cron LIVE). Still: dispatch every job with `hexa cloud nohup ... --register <jid>`; the agent MUST tear down its own rent churn (the prior 9-deck agent left 3 idle leaks — do NOT repeat) and end with `cloud reconcile` showing ZERO orphan/ghost beyond the intended pods. d16 dry-run gate before every fire; un-buildable deck → blocked + logged (d6, no fabricated coords/pseudos).

## next-action checklist
- [ ] read drafts/post-drain-pod-launch-list.md, drafts/wave3b-coords.md, drafts/rtsc-wave2-discovery-plan.md for specs/coords (Li2MgH16, CeH9, LaY_H10, the 6 perovskites)
- [ ] Li2MgH16: author shortest-walltime deck via /deck rtsc → d16 dry-run (pool ubu-1) → fire SOLO pod, --register `rtsc-li2mgh16`
- [ ] Wave-2 6: copy .in from 38095989 (hexa cloud copy-from) → /deck-or-reuse → d16 dry-run → fire parallel on fresh pod(s), --register each
- [ ] CeH9, LaY_H10: /deck rtsc → d16 dry-run → fire parallel, --register each
- [ ] all pods: OMP/MKL/OPENBLAS=1, ranks≤physcores, OMPI_ALLOW_RUN_AS_ROOT=1 (vast root), --source conda
- [ ] verify each job alive (cloud poll) + update ~/core/demiurge/pods.json manifest
- [ ] LEAK SWEEP: cloud reconcile → tear down any churn/orphan; final state = intended pods only, 0 leak
- [ ] ship (manifest + decks on disk; report — no code PR unless a deck-gen fix is needed)

## completion criteria
- Li2MgH16 running SOLO on a dedicated pod with the shortest valid spec; registered.
- All 6 Wave-2 perovskites running ph in PARALLEL (not queued), off the 38095989 chain; CaAuH3 untouched.
- CeH9 + LaY_H10 dry-run-validated + fired (or honestly logged blocked with the exact missing input).
- Every pod: no oversubscription (load ≤ physcores, OMP=1). Every job --registered.
- `cloud reconcile` shows ZERO unintended orphan/ghost; manifest current. Cost stated in one line.

## qa-results
