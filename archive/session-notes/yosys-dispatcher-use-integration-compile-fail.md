# note: yosys-dispatcher-use-integration-compile-fail — RESOLVED (mis-diagnosis)

> **id**: `yosys-dispatcher-use-integration-compile-fail` · **opened**: 2026-05-20 KST · **status**: `resolved — mis-diagnosis, no hexa-lang action needed`
> **source**: demiurge session 2026-05-20.
> **resolution**: the reported "yosys.hexa dispatcher compile failure" was a **measurement artifact**, not an upstream bug. origin/main's rfc_006 §4 yosys modules are healthy.

---

## What was originally reported (and was WRONG)

The first version of this note claimed origin/main's `yosys.hexa` dispatcher fails to compile (`rtlil_module_add_cell` / `rtlil_cell` / `rtlil_cell_connect` undeclared), and filed it as an rfc_006 §4 module-7 blocker for a hexa-lang session.

**That diagnosis was wrong.** Corrected here per g3 (a mis-diagnosis filed as a handoff is itself an over-claim — retract it explicitly).

## The actual measurement (what really happened)

The compile failure was reproduced inside a `git worktree` of `origin/main` at `/tmp/hexa-om`. But hexa's `module_loader` resolves `use "stdlib/..."` against a **fixed `~/core/hexa-lang/` root** — NOT the worktree the entry file lives in. The `[module_loader] begin:` marker in the expanded flat file proved it:

```
// [module_loader] begin: /Users/ghost/core/hexa-lang/stdlib/yosys/rtlil.hexa
// stdlib/yosys/rtlil.hexa — Yosys RTLIL IR data model (CLEAN-ROOM minimum body)
```

`(CLEAN-ROOM minimum body)` is THIS demiurge session's stale rtlil.hexa (the `rfc006-yosys-rtlil-skeleton` branch's 280-line minimum body, `module_add_wire`-style names). The main `~/core/hexa-lang/` checkout was on that stale branch, so every yosys build — even one whose entry file lived in an origin/main worktree — pulled the stale `rtlil.hexa` and mismatched origin/main's `read_verilog.hexa` (which calls the `rtlil_*`-prefixed API).

## The proof origin/main is healthy

Set the main checkout's `stdlib/yosys/` to origin/main (`git checkout origin/main -- stdlib/yosys/`) and re-ran:

```
$ hexa run stdlib/yosys/yosys.hexa
yosys dispatcher selftest: 8/8 PASS
```

origin/main's 7-module rfc_006 §4 absorption (hexa-lang commit `4f70ce46`) compiles and passes its dispatcher selftest. There is no upstream `use`-integration bug.

## The real lesson (worth keeping)

`module_loader` resolves `use "stdlib/..."` against a fixed `~/core/hexa-lang/` root, regardless of which worktree the entry file is in. **Consequence**: you cannot reliably measure a stdlib build in a `git worktree` — the build silently uses whatever branch the *main* `~/core/hexa-lang/` checkout happens to be on. If a sibling session has the main checkout on a feature branch, your worktree measurement is contaminated.

Mitigation when measuring hexa stdlib: ensure the *main* `~/core/hexa-lang/` checkout is on the intended branch (or scope-checkout the relevant `stdlib/<topic>/` subtree with `git checkout <ref> -- stdlib/<topic>/`), then measure — and restore afterward.

## g3 closeout

No hexa-lang action required — origin/main yosys is fine. This note stays in the inbox as a `resolved` audit trail of the mis-diagnosis and its real lesson. The demiurge-side `rfc006-yosys-rtlil-skeleton` branch (commits `ec8a51fc`/`06ccb656`) remains a stale-base duplicate of `4f70ce46` and is recommended for abandon — see demiurge `design.md` "Decision-gate note on Decision 68" (and its follow-up correction). The lasting demiurge-side fruit of the 2026-05-20 session is D63 (wilson-pool roster) + these honest correction artifacts.

g3: the original compile-failure claim was retracted by measurement. Nothing is claimed absorbed; rfc_006 §5 SKY130 area-oracle gate is OPEN (the genuine remaining work — but reachable, since the 7 modules + dispatcher are healthy on origin/main).
