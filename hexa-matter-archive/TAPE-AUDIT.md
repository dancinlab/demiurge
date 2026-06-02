# TAPE-AUDIT — hexa-matter

## A. Audit-class ledgers

- `state/markers/*.marker` — **229 markers**, mostly `closure_consistency_*` (lattice-closure verifications). Pattern: one marker per run, `_FAILED.marker` suffix encodes grade. Direct **Class-T + grade-marker** fit — collapse into `state/closure.tape` with `@T closure_consistency => @R ok|err`.
- No `*.jsonl` registries. No `state/*audit*/` subdir.
- `state/markers` alone — flatter ledger surface than hexa-bio.

## B. Identity surface

`AGENTS.md` + `AXIS.md` + `AXIS_CLOSURE_PLAN.md` + `CLOSURE_STATUS.md` + `CLOSURE_RESIDUAL_BACKLOG.md` form a multi-file identity-plus-roadmap stack. **Good fit** for consolidating axis + closure state into `hexa-matter/identity.tape` (`@I` axis pin + residual-backlog `@?` open-questions).

## C. Domain.md files

59 UPPERCASE.md domains (2D-MATERIALS, ADHESIVE, ARAMID, BIODEGRADABLE-PLASTICS, CERAMIC-ENGINEERING, CERAMICS, COMPOUND-SEMI, CONCRETE-TECHNOLOGY, ...). No `+`-meta-domains. Each domain is a candidate sibling `<DOMAIN>.tape` for that material's closure-run history + promoted constants.

## D. Per-run/per-event history

`closure_consistency_*` is the canonical event grain — every lattice-closure verification emits one marker. Append-only stream of `@T closure_consistency phase=<material> => @R ok|err` is **byte-cheaper than 229 separate inode entries**.

## E. Promotion candidates

- **n6 atoms** — `bt-1388-ionic-octahedral` (octahedral coordination = n=6 hard constraint). Material stoichiometry constants (ceramic Si:O ratios, aramid amide-N density) once axis-closed.
- **hxc binaries** — XRD diffraction patterns + stress-strain curves, when those land. Currently no raw-data ledger.
- **n12 cube cells** — material-family × processing-stage matrix (2D / aramid / ceramic / concrete / compound-semi × extract/synthesize/anneal/test/scale/age).

## Verdict

**MEDIUM** — 229 markers + 59 domain files but no JSONL registry; ledger consolidation has clear value, atom-promotion candidate list is thinner than hexa-bio.
