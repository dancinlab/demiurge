# hexa `exec` subprocess broken — empty stdout + "broken pipe" on all commands

**Date** : 2026-05-21
**Reporter** : SSA-fix session (rfc_006 §5 work)
**Severity** : blocks `stdlib/yosys/gate_record.hexa` end-to-end measurement
**Scope** : `self/runtime.c` (popen / pipe handling) — NOT a stdlib bug

## Reproduce

```hexa
// /tmp/probe.hexa
fn main() {
    let r1 = exec("echo hello")
    println("r1='" + to_string(r1).trim() + "'")
    let r2 = exec("command -v abc 2>/dev/null || true")
    println("r2='" + to_string(r2).trim() + "'")
    let r3 = exec("which abc 2>/dev/null || true")
    println("r3='" + to_string(r3).trim() + "'")
    let r4 = exec("echo $PATH")
    println("r4='" + to_string(r4).trim() + "'")
    let r5 = exec("ls /opt/homebrew/bin/abc 2>/dev/null || echo MISSING")
    println("r5='" + to_string(r5).trim() + "'")
}
```

```sh
$ hexa run /tmp/probe.hexa
sh: line 0: echo: write error: Broken pipe
r1=''
r2=''
r3=''
sh: line 0: echo: write error: Broken pipe
r4=''
sh: line 0: echo: write error: Broken pipe
r5=''
```

Every exec call returns empty + emits a `Broken pipe` warning on the
child side. Shell-side commands work fine:

```sh
$ command -v abc
/opt/homebrew/bin/abc
$ bash -c "command -v abc 2>/dev/null"
/opt/homebrew/bin/abc
$ /bin/sh -c "command -v abc 2>/dev/null"
/opt/homebrew/bin/abc
```

The child `sh` is being torn down before its stdout can be drained,
so `popen` returns "" and the child detects the closed pipe on its
next write attempt.

## Downstream blast radius

- `stdlib/kernels/logic_synth/abc_map.hexa::abc_binary_path()` —
  `exec("command -v abc …")` returns `""` → `[abc_map] exit=missing`
  → `[FAIL] d4:abc_map` → `[gate] verdict: PARTIAL — d4 frontend gap`.
- `stdlib/yosys/gate_record.hexa` end-to-end area measurement
  cannot complete; `router_d{4,6} area=0.0 µm²` cannot be tested
  for ±5 % oracle parity.
- Blocks `rfc_006 §5 measurement_gate` close even after PR #247
  (ABC comb-loop SSA fix) lands.

## Suspect

`self/runtime.c` was modified in the parent branch
`s1-step2-codegen-perf` (stashed at session start: "WIP s1-step2
sibling work (AGENTS.tape + self/runtime.c + untracked inbox
patch) 2026-05-21 before rfc006-yosys-comb-loop-ssa"). If the
current `self/native/hexa_v2` binary was rebuilt against that
modified runtime.c, popen plumbing might be in an inconsistent
state.

To test:
```sh
$ git -C ~/core/hexa-lang log -1 self/native/hexa_v2
$ git -C ~/core/hexa-lang log -1 self/runtime.c
```
If `hexa_v2` mtime > runtime.c HEAD mtime → binary built against
working tree, possibly a broken intermediate.

Also worth checking:
- `runtime.c:758` ("popen → sh -c → interp loses DYLD" comment)
- `runtime.c:7607` ("pipe/fork/execvp (not popen, which merges 2>&1
  when you redirect it)")
- `runtime.c:7735` `popen(cmd, "r")` — main exec entry
- `runtime.c:8281` `"POSIX fork buffer flush before popen (mirrors
  hexa_exec)"` comment

The broken-pipe-on-first-write pattern is classic
parent-closes-pipe-before-child-writes — likely a missing
`pclose`/`fclose` or a too-early `fflush` race.

## Tried + rolled back

In PR #247 dev cycle I tried an absolute-path fallback in
`abc_binary_path()`:

```hexa
let probe = exec("test -x /opt/homebrew/bin/abc && echo /opt/homebrew/bin/abc || true")
```

That ALSO returns "" (every exec call is broken, not just `command -v`).
Reverted. PR #247 ships pure `read_verilog.hexa` changes only.

## Next session

1. Reproduce the broken-pipe with the probe script above on a clean
   tree (no sibling stash applied) to confirm the bug isn't local to
   the working state.
2. If reproducible, instrument `self/runtime.c::hexa_exec` (or
   whichever wrapper hosts `popen("…", "r")`) with stderr trace —
   exact line where the pipe closes early.
3. After fix, re-run `hexa run stdlib/yosys/gate_record.hexa` and
   confirm `router_d4 area > 0` (the rfc_006 §5 measurement-gate
   signal).

## UPDATE 2026-05-21 — root cause narrowed: popen path broken, spawn fast path works

Further diagnosis with the probe script after rebuilding hexa_v2
from the current origin/main runtime.c (binary mtime May 20 19:18,
runtime.c mtime May 21 00:07 — binary was stale but rebuild does
NOT fix the broken pipe).

### Two paths in `hexa_exec` (`self/runtime_core.c:4593`)

```c
fflush(NULL);
FILE* spawn_fp = NULL;
pid_t spawn_pid = hexa_spawn_no_shell(HX_STR(cmd), &spawn_fp);
FILE* fp;
if (spawn_pid > 0) {
    fp = spawn_fp;                  // FAST path: posix_spawnp
} else {
    fp = popen(HX_STR(cmd), "r");   // SLOW path: popen + sh -c
}
```

- **Spawn fast path** (`hexa_spawn_no_shell` at L4527) is opt-in via
  `HEXA_EXEC_NO_SHELL=1` env var (L4460-4466). When env unset,
  fast path returns 0 immediately, falls into popen.
- **Spawn path additionally** requires the command to be free of
  shell metacharacters (`|&;<>*?$()\`\\\"'` newline tab `~{}[]#=`)
  per `hexa_cmd_has_shell_meta` (L4473-4486). Meta-bearing cmds
  fall to popen even with env set.

### Empirical results with the probe

```sh
$ HEXA_EXEC_NO_SHELL=1 hexa run /tmp/probe.hexa
r1='hello'                                          # echo hello — SPAWN path, works
r2=''                                                # command -v abc 2>/dev/null || true — meta-bearing, POPEN path, broken
```

→ **popen path is broken; spawn fast path works.**

### Workaround applied (hexa-lang PR #247 second commit f4c3c493)

`stdlib/kernels/logic_synth/abc_map.hexa::abc_binary_path()` rewritten
to use `which abc` (two tokens, no shell metas) instead of `command
-v abc 2>/dev/null || true` (shell-meta-bearing). With
`HEXA_EXEC_NO_SHELL=1`, the new form takes the spawn fast path and
resolves `/opt/homebrew/bin/abc` correctly:

```
[abc_map] binary=/opt/homebrew/bin/abc
[abc_map] script-size=27537
[abc_map] exit=0
[OK] d4:abc_map — abc_map: ok
[OK] d6:abc_map — abc_map: ok
```

### Underlying popen bug still open

popen path remains broken for any meta-bearing command — that is a
separate `self/runtime.c` (or `runtime_core.c`'s popen pre/post-
processing) defect, NOT addressed in PR #247. The probe + rebuild
sequence narrows the search:

- `hexa_exec` popen branch (`runtime_core.c:4607-4626`) — fread
  loop + pclose, standard pattern, no obvious bug.
- `hexa_pipe_buf_enlarge_kernel` (`runtime_core.c:93`) — macOS
  noop, not the culprit.
- `hexa_exec_capture` (`runtime.c:7607`) — separate function with
  its own fork/pipe/dup2, not on this call path.

The broken behavior surfaces in `to_string(exec_result).trim()`
returning empty string + `sh: echo: write error: Broken pipe`
emitted to the parent's stderr. The child sh's stderr being on the
parent terminal (not piped) means the broken-pipe message is the
child seeing its stdout pipe already closed — i.e. parent's
fread/pclose closed the read end before child's first write
completes. Likely a timing/race in the popen + fread loop OR a
stdio-layer state corruption between fork and exec.

Diagnostic next step: instrument the popen path with `perror` after
each fread and before pclose; run the probe under `dtrace -n
'syscall:::entry /pid == $target/ ...'` to capture the close
sequence.

### Bonus discovery — `str(float)` also broken

When the abc_map chain completed and gate_record reached the area
verdict line, the printed output was:

```
[gate] router_d4 area=(float) µm² oracle=(float) µm² Δ=(float)% FAIL (±5%)
[gate] router_d6 area=(float) µm² oracle=(float) µm² Δ=(float)% FAIL (±5%)
```

→ `str(float)` (or the float interpolation path used by gate_record)
emits the literal token `(float)` instead of the numeric value.
Filed separately — gates the FINAL g3 acceptance signal (±5 % area
oracle parity), but does NOT gate confirming that the SSA fix made
ABC's chain complete (which is now confirmed via `exit=0` +
`abc_map: ok`).
