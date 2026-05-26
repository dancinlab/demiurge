# TAPE-AUDIT — hexa-aura

n=6 post-aural BCI chip substrate (temporal-bone mastoid clip + RT-SC nanocoil + cortical interface + safety). 4 pillars: clip / coil / cortex / safety. Sister of hexa-brain (BCI) and hexa-senses (sensory). Smaller chip-level repo, but has the busiest verifier marker stream of the leaf substrates.

## A. Audit-class ledgers (cargo / migration candidates)

- **`state/markers/`** — sizeable marker set: `numerics_coil_parity_*`, `calc_clip_*`, `falsifier_check_*`, `numerics_cross_pillar_*`, `numerics_clip_parity_*`, `numerics_clip_*_FAILED`, `lattice_check_*` (several `_FAILED`), `calc_cortex_*`, `numerics_safety_parity_*`, `numerics_cortex_parity_*`, `lint_numerics_*`, `numerics_cortex_solver_*`, `saturation_check_*`, `numerics_lattice_arithmetic_*_FAILED`, `numerics_clip_solver_*_FAILED`. **Multiple `_FAILED` markers** — exactly the grade=err Class-T tape use case. Direct `state/markers.tape` migration.
- **`verify/cross_doc_audit.hexa`** — audit program; its outputs are the markers above. Tape-shaped target = `verify.tape` with err grade on the FAILED entries.
- No `*.jsonl` ledgers, no audit dirs.

## B. Identity surface

Medium. The chip substrate identity (4-pillar lattice: clip σ·n/10=3.6 g, coil σ²=144 ch/tile / J₂=24 ch/macro / n^τ=1296-ch hex, cortex σ=12 zones · φ=2 dir · τ=4 modes · 18→0, safety bounds) is encoded in `LATTICE_POLICY.md` + `hexa.toml` (12 KB) + `.roadmap.hexa_aura` (21 KB). Could become `hexa-aura/identity.tape` per chip-rev snapshot.

## C. Domain.md files

Present: `AGENTS.md`, `CHANGELOG.md`, `IMPORTED_FROM_CANON.md`, `LATTICE_POLICY.md`, `LIMIT_BREAKTHROUGH.md`, `README.md`, `RELEASE_NOTES_v1.0.0.md`, `TODO.md`. Pillar-named subtrees (`clip/`, `coil/`, `cortex/`, `safety/`) substitute for per-pillar domain.md. Sibling per-pillar `<pillar>.tape` natural.

## D. Per-run / per-event history surfaces

`verify/` + `chip-verify/` — 23 verify scripts per the README badge ("RSC: 23 verify"). Each verifier tick is an event → `verify.tape` per run; the `_FAILED` markers are the most valuable trace data (grade=err with payload). `papers/` (2 paper drafts) + `tests/`. `.roadmap.hexa_aura` carries open falsifiers (4 OPEN per README badge) — falsifier resolutions are tape-shaped.

## E. Promotion candidates

- **n6 atoms** — `σ(6)·φ(6) = n·τ(6) = J₂ = 24` master identity + every pillar's derived parameter (3.6 g per clip, 144 ch/tile, 1296-ch hex, SAR≤2 W/kg, ΔT≤0.5 K, FAR≤1 %). Hardware-side empirical limits → high-confidence atoms.
- **hxc wire** — cortical read/write streams (V1..V6, A1, S1, M1) are textbook hxc byte-wire — when the chip materializes.
- **n12 cells** — verify pass/fail × pillar × revision × numerics-class.

**Verdict: MEDIUM** (3-4 tape surfaces — markers with err grades, verify.tape, falsifier-resolution stream, identity).
