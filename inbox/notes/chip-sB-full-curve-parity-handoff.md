# incoming note: chip-sB-full-curve-parity-handoff — re-open D10's execution gate via 3-host pool parallelism

> **id**: `chip-sB-full-curve-parity-handoff` · **opened**: 2026-05-20 KST · **status**: `CLOSED 2026-05-20 — completed in-session (κ-43 / D70), not delegated`
>
> **closure**: the handoff was self-fulfilled in the same session rather than delegated to a separate hexa-lang session. `stdlib/booksim/sweep_oracle_parity.hexa` landed; rfc_003 §4 acceptance 12/12 GREEN; `chip + verify` flipped to `GATE_CLOSED_MEASURED` + `absorbed=true`. The `hexa build` native-compile path made the pool-distribution plan moot — the full §B+§D run is ~1 s as a compiled binary. See design.md D70 / PLAN.md κ-43.
> **source**: user directive 2026-05-20 — `ABSORPTION.md §"무거운 후보"` chip §B row marked `진행` + `ubu-1/ubu-2/mini 자원활용` directive.
> **destination repo**: `~/core/hexa-lang/` (where `stdlib/booksim/` lives — D15 / D61 / g_stdlib_ownership)
> **scope**: extend `stdlib/booksim/sweep.hexa` (or new `stdlib/booksim/sweep_oracle_parity.hexa`) to run the full 9-config matrix vs the rfc_003 §4 reference numbers, emit F1F2Record rows, and flip `chip §B` from `GATE_B_PINNED_MET` → `GATE_CLOSED_MEASURED`. demiurge stays pointer-only per D61.

---

## Why this re-opens an explicitly-closed gate (D10)

`design.md` Decision 10 (2026-05-18) declared chip §B/§D full-curve parity an **execution gate, out of demiurge design scope** — the binding blocker named was *interpreted hexa-lang toolchain throughput ~1e4 ops/s* (compiled hexa or bounded per-flit DES required for re-entry).

The 2026-05-20 measurement on `ubu-1` (linux x86_64, hexa 0.1.0-dispatch) refutes that blocker on linux substrate:

| module           | local (mac, darwin-arm64) | ubu-1 (linux-x86_64) | speedup |
|------------------|---------------------------|----------------------|---------|
| `leighton.hexa`  | 90 s · 10/10 PASS         | 0.07 s · 10/10 PASS  | ~1000×  |
| `wire_delay.hexa`| timeout 10 s (no output)  | <1 s · 12/12 PASS    | n/a     |
| `traffic.hexa`   | timeout 10 s (no output)  | <1 s · 11/12 PASS (1 known FAIL — see §"Known failures") | n/a |

The "interpreted hexa-lang throughput ~1e4 ops/s" figure in D10 was measured on the local mac. On linux substrate via `ubu-1` the same interpreter clears the same selftests ~1000× faster. **The D10 blocker is platform-specific, not hexa-intrinsic.** Therefore the pool-distributed execution path is open.

`ABSORPTION.md §"무거운 후보"` lists this candidate at "수일"; with 3 linux hosts in `wilson-pool` (`ubu-1`, `ubu-2`, `mini`-when-up) the full-curve sweep is plausibly hours, not days. The note records this as the *measured* premise of re-opening the gate; the actual full sweep still needs to land in hexa-lang.

## What "full-curve parity" means (precise, from rfc_001 §8 + rfc_003 §4)

The acceptance set is **§B (4 rows) + §D (6 rows) + Leighton PASS for both topologies**, all within ±5% latency / ±2% hops / qualitative-inequality gates. Reference data is the Agent-1 BookSim2 reference run cited in rfc_003 §4 (locally at `/tmp/demiurge-rfc001-measurement/runs/` — verify still present, else re-cite from the rfc_003 §4 tables which carry the headline numbers verbatim).

### §B target — 8×8 mesh uniform saturation ≈ 0.42

| metric                              | upstream            | re-derivation must            |
|-------------------------------------|---------------------|-------------------------------|
| zero-load latency @ rate=0.05       | 50.25 cyc           | within ±5% (47.7–52.8)        |
| avg hops (~6.25 over all rates)     | 6.25                | within ±2% (graph-deterministic) |
| saturation knee (3× ZLL crossing)   | between 0.35–0.40   | knee_rate ∈ [0.30, 0.45]      |
| pre-knee curve monotonicity         | strictly increasing | strictly increasing (g3 sanity) |

### §D target — d=4 vs d=6 tornado headline numbers

| metric                              | upstream      | re-derivation must                                  |
|-------------------------------------|---------------|----------------------------------------------------|
| d=4 zero-load @ 0.05                | 64.70 cyc     | within ±5% (61.5–67.9)                             |
| d=6 zero-load @ 0.05                | 57.40 cyc     | within ±5% (54.5–60.3)                             |
| d=6 saturates *later* than d=4      | 0.19 vs 0.15  | qualitative: d=6 last_unsat > d=4 last_unsat       |
| d=6 ZLL < d=4 ZLL @ 0.05, tornado   | 57.4 < 64.7   | gap_cycles ≥ 5 cyc                                  |
| d=4 avg hops @ 0.05                 | 8.49          | within ±2%                                          |
| d=6 avg hops @ 0.05                 | 7.14          | within ±2%                                          |

### Leighton oracle PASS gate (rfc_001 §5)

For both topologies under both traffic patterns `leighton_check.pass == 1`. If `pass=0`, producer exits 91 and emits no record (rfc_001 §7.3, rfc_002 §4).

## Proposed 9-config sweep matrix (one row = one F1F2Record)

**Revised after 2026-05-20 host audit (D63 + D64)**: pool routing target = `ubu-2` (per D63, wilson-pool config); chip §B hexa-driven measurement target = **`ubu-1`** (the only host with `hexa` installed today). All 9 configs run on `ubu-1` until `hexa` is installed on `ubu-2` and/or `mini` recovers.

| # | topology       | traffic    | injection rate sweep  | host (current plan) |
|---|----------------|------------|-----------------------|---------------------|
| 1 | mesh-8×8       | uniform    | 0.05, 0.20, 0.35, 0.40 | ubu-1               |
| 2 | mesh-8×8       | tornado    | 0.05, 0.10, 0.15      | ubu-1               |
| 3 | hex-d6         | tornado    | 0.05, 0.10, 0.19      | ubu-1               |
| 4 | mesh-d4 anynet | tornado    | 0.05, 0.10, 0.15      | ubu-1               |
| 5 | hex-d6 anynet  | uniform    | 0.05, 0.20, 0.35      | ubu-1               |
| 6 | mesh-d4 anynet | uniform    | 0.05, 0.20, 0.35      | ubu-1               |
| 7 | mesh-8×8       | transpose  | 0.05, 0.20, 0.35      | ubu-1               |
| 8 | hex-d6         | transpose  | 0.05, 0.10, 0.19      | ubu-1               |
| 9 | leighton oracle pass-check for all 6 (topology, traffic) tuples above | n/a | n/a | ubu-1 |

Distribution upgrade path (when other hosts come online):
- **ubu-2 + hexa installed** → split #4–#6 (anynet variants) to ubu-2.
- **mini recovered** (currently `ssh Connection: Host is down`) → split #5–#6 to mini (macos-darwin is the original development substrate; if it matches ubu-1 numbers within ±2%, that becomes an additional substrate-cross-check signal).

## Known failures uncovered during smoke test (2026-05-20, ubu-1)

1. **`traffic.hexa` dispatch transpose** — selftest 11/12 PASS, the one FAIL is `dispatch_transpose got=-1`. Configs #7 and #8 above require transpose. **MUST FIX before sweep — single-line dispatch bug, not a model bug.**
2. **`anynet.hexa` runtime untimed** — ssh banner-timeout interrupted the 15-min budget background run. Re-measure with longer ssh `ServerAliveInterval` or run via `nohup` + log-tail.
3. **`mini` host down** (ssh `Connection to 192.168.50.39 port 22: Host is down`) — keeps pool routing single-target until recovered (D63).
4. **`ubu-2` has no `hexa`** (`bash: hexa: 명령어를 찾을 수 없음`) — pool routing target per D63 but cannot run booksim sweep; hexa-install on ubu-2 is a hexa-lang ops item, not blocking this handoff if ubu-1 alone suffices for the 9-config sweep (math: ubu-1 leighton 0.07 s × N configs is well under hours for the full matrix).

## demiurge side commitments (D61 — pointer only)

When hexa-lang ships `stdlib/booksim/sweep_oracle_parity.hexa`:

- **`cockpit/Sources/DemiurgeCore/Loaders/ChipVerifyProducer.swift`** — `Process`-spawn wrapper that invokes `hexa run ~/core/hexa-lang/stdlib/booksim/sweep_oracle_parity.hexa <config_id>` per row, decodes F1F2Record (existing schema, no extension needed — `measurement_gate` enum already accepts `GATE_CLOSED_MEASURED`).
- **`ActionDispatch.swift`** — `case (.verify, "chip")` → `runChipVerify()` (already partly wired per `ABSORPTION.md §"현재까지 흡수된 producer"`: row `chip · verify · booksim cmd_measure · GATE_OPEN`).
- **`design.md` D-num** — record the re-opening of D10's execution gate via pool parallelism (separate decision row; D10 itself not rescinded but factually superseded for the linux substrate path).
- **`PLAN.md` κ-entry** — append-only progress row when sweep records arrive.
- **`ABSORPTION.md`** — flip the `chip · verify · booksim cmd_measure` row from `GATE_OPEN` to `GATE_CLOSED_MEASURED` (and `absorbed=true` since this is hexa-native re-derivation matching the cited oracle — D17 matter pattern precedent).

demiurge **NEVER** carries the sweep / parity / oracle script logic. Per D61 / g_demiurge_pointer_only, `cockpit/scripts/*.py` is PR-blocked; the sweep_oracle_parity.hexa SSOT lives in `hexa-lang/stdlib/booksim/`.

## Acceptance / gate flip

Producer emits 10 F1F2Record rows (§B 4 + §D 6) with `measurement_gate=GATE_CLOSED_MEASURED`, `absorbed=true`, plus 1 leighton check record. demiurge ChipVerifyProducer decodes all, ABSORPTION.md row flips, design.md gets new D-num "chip §B GATE flipped via pool-distributed full-curve parity". GOAL.md `현재 정직한 위치` section gets honest update — first chip §B `GATE_CLOSED_MEASURED + absorbed=true` line.

## See also

- `design.md` D9 (GATE_B_PINNED_MET marker) · D10 (execution-gate non-goal — re-opened by this note) · D15 (stdlib ⊂ hexa-lang) · D17 (hexa-matter precedent: SSOT=hexa-lang, demiurge=consumer-pointer) · D61 (g_demiurge_pointer_only)
- `proposals/rfc_001_booksim2_noc_absorption.md` §5 (Leighton oracle) · §8 (measurement gate)
- `proposals/rfc_003_booksim_native_rederivation_plan.md` §4 (acceptance criterion verbatim numbers) · §7 (phased landing)
- `ABSORPTION.md` §"무거운 후보" (this row · 진행 status as of 2026-05-20)
- `hexa-lang/inbox/PATCHES.yaml` entry `stdlib-booksim-rederive-from-hexa-arch-rfc003` (applied 2026-05-19, commit `d5a63a82`) — the 14 booksim modules this handoff extends.
- `design.md` D63 (wilson-pool routing = ubu-2 only) · D64 (chip §B path = ubu-1 single-host hexa-driven; this handoff is D64's binding artifact)

## Log

- 2026-05-20 KST — opened. Demiurge-side smoke test on ubu-1 confirmed leighton/wire_delay/traffic selftests run ~1000× faster on linux than local mac, refuting the D10 throughput blocker on linux substrate. 1 known FAIL (traffic dispatch transpose) to fix in hexa-lang before sweep. mini host down — re-balance to 2 hosts until recovered.
- 2026-05-20 KST — host plan revised after D63/D64. wilson-pool routes general heavy bash to ubu-2 (D63); chip §B hexa-driven sweep runs on ubu-1 (D64, the only host with hexa installed). 9-config matrix re-assigned to ubu-1 single-host; upgrade path documented for ubu-2 / mini when ready.
