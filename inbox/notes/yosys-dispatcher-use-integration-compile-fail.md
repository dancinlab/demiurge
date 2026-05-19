# incoming note: yosys-dispatcher-use-integration-compile-fail — rfc_006 §4 module-7 blocker

> **id**: `yosys-dispatcher-use-integration-compile-fail` · **opened**: 2026-05-20 KST · **status**: `handoff-open — awaits hexa-lang session`
> **source**: demiurge session 2026-05-20 — user directive "hexa 포팅" + "hexa upstream 필요시도 이 세션에서 진행" + `/goal "완료시까지 진행"`. Discovered while measuring origin/main's yosys 7-module landing (commit `4f70ce46`).
> **destination repo**: `~/core/hexa-lang/` — the bug is in either the hexa transpiler's cross-module `use` symbol emission OR in `stdlib/yosys/yosys.hexa`'s `use` of `stdlib/yosys/rtlil`.
> **scope**: make `hexa run stdlib/yosys/yosys.hexa` compile + pass its dispatcher selftest. demiurge stays pointer-only per D61 — this is a hexa-lang toolchain/stdlib fix.

---

## The measured failure

origin/main carries hexa-lang commit `4f70ce46` "stdlib(yosys): rfc_006 §4 bodies landed for 7 modules" (2026-05-20 01:04 KST, verified `origin/main` ancestor). All seven rfc_006 §4 modules have real bodies — `rtlil.hexa` (346 lines), `read_verilog.hexa` (501), `passes.hexa` (473), `liberty.hexa` (481), `abc_map.hexa` (361), `write_verilog.hexa` (293), `yosys.hexa` (302) + `gate_record.hexa`.

But the dispatcher does not compile. Measured on a clean `git worktree` of `origin/main` (HEAD `28374717`), mac darwin-arm64, `hexa ~/.hx/bin/hexa`:

```
$ hexa run stdlib/yosys/yosys.hexa
build/artifacts/hexa_run.*.c:1715:24: error: use of undeclared identifier 'rtlil_module_add_cell'
build/artifacts/hexa_run.*.c:1740:20: error: use of undeclared identifier 'rtlil_cell'
build/artifacts/hexa_run.*.c:1741:20: error: use of undeclared identifier 'rtlil_cell_connect'
fatal error: too many errors emitted, stopping now
2 warnings and 20 errors generated.
error: clang compile failed — binary not produced
```

## What is NOT the problem

The functions ARE defined. `stdlib/yosys/rtlil.hexa` on origin/main:

- `struct CellConn` (line 47), `struct Cell` (line 52)
- `fn rtlil_cell(name, cell_type, is_mapped) -> Cell` (line 114)
- `fn rtlil_cell_connect(c, pin, net) -> Cell` (line 124)
- `fn rtlil_module_add_cell(m, c) -> Module` (line 144)

And `rtlil.hexa` runs clean standalone: `hexa run stdlib/yosys/rtlil.hexa` → **`rtlil selftest: 10/10 PASS`**.

`yosys.hexa` line 46 imports it: `use "stdlib/yosys/rtlil"`.

So: the module is correct, the import statement is present, the standalone selftest is green. The transpiler simply does not emit (or does not link) the `rtlil_*` symbols into the `yosys.hexa` translation unit. This is a **cross-module `use` symbol-emission gap** in the hexa transpiler — or a `use`-path resolution mismatch specific to `yosys.hexa`.

## Why this matters — it is the real rfc_006 §4 blocker

rfc_006 §4 has 7 modules; module-7 is the `yosys` dispatcher that ties the other 6 together (`hexa yosys <subcmd>` entry). The 7 module *files* landed in `4f70ce46`, but the dispatcher integration is broken — so the §5 SKY130 area-oracle gate (router_d4 ≈61,763 µm² · d6 ≈93,609 µm² · 1.516× ±5%) cannot even be attempted: there is no working `hexa yosys synth` to run. **This compile failure is the gating blocker for the entire Yosys absorption**, not any individual module body.

## Suggested next action (hexa-lang session)

1. Reproduce: `git worktree add /tmp/x origin/main && cd /tmp/x && hexa run stdlib/yosys/yosys.hexa`.
2. Diagnose whether the gap is (a) the transpiler not emitting `use`-imported free fns into a dependent translation unit, or (b) a `use`-path string mismatch (e.g. `use "stdlib/yosys/rtlil"` vs the path the resolver expects). Compare against a `use` that *does* work — `stdlib/booksim/booksim.hexa` cross-module `use` is a known-good reference.
3. If (a), it is a transpiler bug → fix in `compiler/` + file a `PATCHES.yaml` entry. If (b), it is a one-line `use`-path fix in `yosys.hexa`.
4. Re-run the dispatcher selftest to green, then the §5 area-oracle measurement becomes reachable.

## Boundary / provenance (g3)

This note is the ONLY artifact filed about this bug from the demiurge side. No hexa-lang source modified to diagnose it (the worktree was read-only and removed after measurement). The demiurge session's own `rfc006-yosys-rtlil-skeleton` branch (commits `ec8a51fc`/`06ccb656`) is a stale-base duplicate of `4f70ce46`'s rtlil.hexa and is recommended for abandon — see demiurge `design.md` "Decision-gate note on Decision 68" for that audit trail. The lasting demiurge-side fruit of the 2026-05-20 session is D63 (wilson-pool roster) + this gap note.

g3: nothing here is claimed absorbed. The Yosys absorption's §5 gate is OPEN and this compile failure keeps it unreachable.
