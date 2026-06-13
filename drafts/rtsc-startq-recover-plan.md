---
slug: rtsc-startq-recover
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
pod: 38095989 (ssh9.vast.ai:15988) — vast, anima compute
constraint: live runs (cabeh8, KBeH8) MUST stay untouched
---

# rtsc-startq-recover — plan

## task brief
CaAuH3 (5/10 q) and MgBeH8 (4/8 q) are RTSC el-ph decks whose phonon (ph.x) runs CRASH on resume —
even after isolating the whole phsave — because their el-phon recover state is corrupt
("PARTIAL_EL_PHON not found / closing tag not found / cannot open file"). The completed q-points are
intact (good `*.dynN` + `*.dynN.elph.N` in the deck dir). Salvage by NOT touching the corrupt recover
at all: run a FRESH ph.x computing ONLY the remaining q-range via `start_q`/`last_q` (recover=.false.),
so QE never reads the corrupt files. Completed q's are preserved; the final `lambda.x` aggregates the
full q-set. Run on the same pod's spare cores (38095989 has 128 cores, ~16 used by live cabeh8+KBeH8),
in parallel, WITHOUT disturbing the live runs.

## locked decisions (AUTO 1:1:1:1)
- Q1 method: FRESH ph.x with `start_q = <first q with no good dynN>`, `last_q = <q-total>`, `recover = .false.` — bypasses the corrupt recover entirely (no crash). Determine q-total from the deck's `*.dyn0`; determine start_q = the first q index lacking a nonzero `<prefix>.dynN`.
- Q2 preserve: do NOT delete/modify the completed `*.dynN` / `*.dynN.elph.N`. The fresh start_q run only writes the remaining q's. lambda.x later reads the union. (Net loss = only the partial progress of the single broken in-progress q, which was unrecoverable anyway.)
- Q3 location: same pod 38095989 spare cores, parallel, OMP_NUM_THREADS=MKL_NUM_THREADS=1, `mpirun --allow-run-as-root -np 8 --bind-to none ph.x -in <fresh.ph.in>`, wrapped in `timeout <walltime>`. Σ(all ph.x ranks on pod) ≤ physcores (128) — with cabeh8(8)+KBeH8(8)+CaAuH3(8)+MgBeH8(8)=32, ample headroom, NO oversubscription.
- Q4 verify: run-health — the fresh runs start WITHOUT the corrupt-recover crash AND begin writing new `*.dynN` for q ≥ start_q (advancing). This is a CLI/run check, not a g5 numerical claim; the λ/Tc g5 verify happens at the final lambda.x (out of scope here).
- Q5 execution: dedicated background agent, READ + LAUNCH only. NO destroy/stop/adopt/rm of any pod. The live runs (cabeh8, KBeH8) and all other pods are untouched.

## next-action checklist
- [ ] probe CaAuH3 + MgBeH8: q-total (from `*.dyn0`), and the set of q with a good nonzero `<prefix>.dynN` → derive start_q (first missing) + last_q (q-total).
- [ ] make a fresh ph.in copy per deck (e.g. `ph_startq.in`) = the deck's ph.in with `recover=.false.`, `start_q=<S>`, `last_q=<T>` (+ a distinct fildyn/recover scratch if needed so it doesn't collide with the corrupt state). Keep prefix/outdir pointing at the existing `.save` (the SCF ground state is valid).
- [ ] confirm the live runs first: `pgrep -c ph.x` + per-cwd — cabeh8 + KBeH8 must be running and MUST NOT be touched.
- [ ] launch CaAuH3 + MgBeH8 fresh-startq ph.x in parallel on spare cores (OMP=1, timeout cap, backgrounded, nohup/setsid so they survive session close). Σ ranks ≤ 128.
- [ ] verify (after ~60s): the new ph.x are alive (not crashed), no PARTIAL_EL_PHON error in their new logs, and they're computing q≥start_q (representation/iter lines). Report which q each is on.
- [ ] confirm live cabeh8 + KBeH8 still running, untouched.

## completion criteria
- CaAuH3 + MgBeH8 fresh start_q ph.x are RUNNING without the corrupt-recover crash, computing the
  remaining q-range, in parallel on spare cores. Completed q's (.dynN) preserved. Live cabeh8 + KBeH8
  untouched. No pod torn down. (Final λ/Tc verify is a later lambda.x step, not this task.)
- If a fresh start_q run ALSO crashes (deeper corruption in the .save ground state), report that
  honestly with the verbatim error + breakthrough paths (e.g. re-run scf first) — do NOT thrash-relaunch.

## qa-results
