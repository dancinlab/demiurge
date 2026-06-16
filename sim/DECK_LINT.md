# `hexa deck` — deck-discipline validator (self-improving guard registry)

> SSOT for the QE / DFT electron-phonon **deck discipline**. Code = `sim/deck_lint.hexa`.
> Governance: `d_deck_always` · d13 · d15 · d16 · d6.

## What it is

`hexa deck` (this validator) is the **lint half** of the deck tool. The
**build half** already exists — the 빵틀 emitter `hexa-lang stdlib/deck/gen.hexa`
(`/deck <domain> <slug> '<spec>'`) — which generates a deck set from a compact
manifest. What did NOT exist is a *content validator* that bakes in the
hard-won deck discipline so the bug-prone hand-written `.in` decks of this RTSC
campaign can never reach a billing pod again.

The two halves compose with the existing `dft_run` dispatch gate:

```
spec  ──►  stdlib/deck/gen.hexa   (BUILD — emit vc-relax/scf/ph/bands)
deck  ──►  sim/deck_lint.hexa     (LINT  — static content discipline, THIS tool)   ← FREE, no rent
deck  ──►  dft_run --validate     (d16 1-iter QE dry-run on pool free)             ← FREE, no rent
deck  ──►  dft_run --go           (cost-bearing rent — d17)                        ← $ only after green
```

`deck_lint` is the cheapest gate (pure static analysis, no QE, no pool) and so
runs FIRST. It catches the discipline bugs `dft_run --validate` would only
surface as a QE crash (or, worse — verbosity / wrong-mass — that QE accepts
silently and produces garbage from).

## The self-improving workflow (the whole point)

> **trouble happens → encode the prevention as a NEW GUARD here.**

A deck bug is never *just fixed in one deck*. Its prevention is stamped into the
tool, so the NEXT deck — and every sweep sibling — inherits the guard. This file
+ `sim/deck_lint.hexa` are the deck-discipline SSOT.

Adding a guard is **two lines**:

1. Write a pure function in `sim/deck_lint.hexa`:
   ```hexa
   fn guard_<slug>(d: Deck) -> Finding {
       // inspect d.raw / d.lc / d.path; return finding(id, SEV_PASS|WARN|FAIL, msg)
   }
   ```
2. Register it in `all_guards()` (one `out.push(guard_<slug>(d))` line) and add
   a row to `_guard_catalogue()`.

Then add a `good` + `broken` case to `_self_test()` and run
`hexa run sim/deck_lint.hexa --self-test`. That's it — the guard is live for
every deck and every sweep.

Severity contract: `PASS` = satisfied · `WARN` = advisory (dispatch allowed) ·
`FAIL` = blocks dispatch (exit 1). Pick `FAIL` only for a bug that produces a
crash or silent-garbage result; `WARN` for a "you probably forgot X".

## Seed guards (this session's real deck bugs)

| id | guard | catches | sev | directive |
|----|-------|---------|-----|-----------|
| G01 | `bands_verbosity` | `bands`/`nscf` with total #k ≥ 100 but no `verbosity='high'` (QE omits eigenvalues → flat-band ΔE unreadable). Real culprit: `exports/rtsc/decks/cosn/bands.in`. | FAIL | d_deck_always |
| G02 | `atomic_mass_zero` | an `ATOMIC_SPECIES` mass of 0 / blank (typo → NaN phonons) | FAIL | — |
| G03 | `atomic_mass_wrong` | a covered element's mass off the periodic value (this session: a wrong-row mass) | FAIL | — |
| G04 | `pseudo_missing` | a UPF named in `ATOMIC_SPECIES` not present under the deck's `pseudo_dir` | WARN | d13 |
| G05 | `d15_scf_aids` | a metal/small-gap (`occupations='smearing'`) SCF missing `degauss`+`mixing_beta`+`electron_maxstep` | WARN | d15 |
| G06 | `ph_stability_gate` | an el-ph (`electron_phonon=`) deck with NO `q2r.in`/`matdyn.in`/RUNBOOK imaginary-mode gate — never fire el-ph on a dynamically-unstable cell | WARN | d6 |
| G07 | `ascii_only` | a non-ASCII byte in a `.in` (em-dash · Å · Γ …) that crashes QE 6.7's FoX XML parser (SIGABRT) | FAIL | — |
| G08 | `vcrelax_convergence` | a `vc-relax` deck missing tight `etot_conv_thr`/`forc_conv_thr`/`press_conv_thr` — QE defaults leave the cell **under-relaxed** → a forest of matdyn imaginary modes (this session: YH6 41, MgH6 34) → no physical Tc | WARN | d6 |
| G09 | `elph_needs_relaxed_cell` | an el-ph (`electron_phonon=`) deck with NO `relax.in`/`vc-relax.in`/`scf.in` sibling and no RUNBOOK relax note — el-ph must run on a **relaxed** cell, not a raw/guessed one (distinct axis from G06: G06 = stability *verification* exists, G09 = the cell was *relaxed*) | WARN | d6 |
| G10 | `kgrid_zero` | a `K_POINTS automatic` mesh of `0×…` (a hand-blanked/zeroed nk line) — computes no real k-mesh → garbage energies with no QE error | FAIL | — |

## Usage

```bash
hexa run sim/deck_lint.hexa <deck.in> [<deck2.in> ...]   # lint deck file(s)
hexa run sim/deck_lint.hexa <deck-dir/>                  # lint every *.in in a dir
hexa run sim/deck_lint.hexa --guards                     # list registered guards
hexa run sim/deck_lint.hexa --self-test                  # built-in good/broken cases (@ci_gate)
```

Exit `0` = all decks PASS (WARNs allowed) · exit `1` = a FAIL guard tripped
(do NOT dispatch — d16).

### Pre-dispatch recipe (d16)

```bash
# 1. lint the whole deck dir FREE (this tool — no pool, no rent)
hexa run sim/deck_lint.hexa exports/rtsc/decks/<slug>/   # must be PASS/WARN, not FAIL
# 2. then the d16 1-iter QE dry-run on pool free
pool on ubu-1 'cd <deck-dir> && pw.x -i scf.in 2>&1 | head -50'
# 3. then fire (d17)
```

## Design notes

- **Pure / network-free** — every guard is a pure `(Deck) -> Finding`; the only
  syscalls are `read_file` / `file_exists` / `list_dir` for the pseudo + el-ph
  dir checks. `--self-test` is fully embedded (no fixtures) so it is a clean
  `@ci_gate`.
- **Generic (d4)** — guards key on QE directives / cards, never on a candidate
  name. The periodic-mass reference table (`_ref_symbols`/`_ref_masses`) is the
  single place to extend element coverage (one row per element).
- **k-point counting** — `_total_kpoints` handles `automatic` (nk1·nk2·nk3),
  `crystal_b`/`tpiba_b` (sum of the per-segment npts — the band-path case that
  triggers the eigenvalue omission), and explicit lists.
