# Release Notes — hexa-ufo v1.0.0 (2026-05-06)

## Summary

`hexa-ufo` v1.0.0 is the **initial standalone extraction** of the
`canon/domains/sf-ufo/` substrate-atlas tree into a public,
MIT-licensed repository under the `dancinlab` GitHub organization.

- Source: `canon` SHA `c0f1f570`
- Extraction date: 2026-05-06
- Sister pattern: `dancinlab/hexa-bio` (molecular toolkit standalone)

## What ships

### 6 verbs (all DOC-grade)

| Verb       | Doc LOC | Role                                                        |
|------------|---------|-------------------------------------------------------------|
| `ufo`      | 1890    | main atlas (484-tier `L(k)=24^(k-15)` lattice; alien_index 6→500) |
| `grav`     | 653     | Stage-1 substrate: Meissner gravitomagnetic levitation      |
| `hover`    | 457     | Stage-1/2 substrate: hover / VTOL primitive                 |
| `cloak`    | 471     | optical / RF / thermal cloaking                             |
| `teleport` | 440     | Stage-5/6 substrate: wormhole / quantum-teleport            |
| `sim`      | 614     | airframe / cross-domain simulation                          |

### 7-stage propulsion stack

Stages 1-3 (Meissner / fusion / antimatter) cross-link to public sister
substrate repos. Stages 4-7 (warp / wormhole / dim-jump / dim-use) are
**TBD — no public substrate exists yet**.

| Stage | Mechanism                                | Substrate status                |
|-------|------------------------------------------|---------------------------------|
| 1     | Meissner diamagnetism (RT-SC 48T)        | grounded (`hexa-rtsc`)          |
| 2     | MHD + tabletop fusion (D-T / p-11B)      | grounded (`hexa-fusion`)        |
| 3     | antimatter gamma-rocket (anti-H + H)     | grounded (`hexa-antimatter` + `hexa-cern`) |
| 4     | Alcubierre warp bubble                   | TBD                             |
| 5     | Morris-Thorne wormhole / ER bridge       | TBD                             |
| 6     | KK-tower brane transit (dim-jump)        | TBD                             |
| 7     | Calabi-Yau 6-fold navigation (dim-use)   | TBD                             |

### Tooling

- `cli/hexa-ufo.hexa` — 6-verb router + `status` + `selftest`.
- `install.hexa` — hx hook (pre: no-op; post: warn-only selftest).
- `tests/test_atlas_consistency.hexa` — verb count + lattice arithmetic.
- `examples/propulsion_stack.md` — 7-stage evolution table.

## Cross-links

- <https://github.com/dancinlab/hexa-rtsc>      — Stage-1 substrate
- <https://github.com/dancinlab/hexa-fusion>    — Stage-2 substrate
- <https://github.com/dancinlab/hexa-antimatter> — Stage-3 substrate
- <https://github.com/dancinlab/hexa-cern>    — onboard sigma-cascade accelerator (Stage-3 aux)

## Honest C3 caveats

1. All 6 verbs are DOC-grade (markdown atlases) in v1.0.0. No empirical
   sandbox in this repo — the empirical work lives in sister substrate repos.
2. Propulsion Stages 4-7 are TBD. The narrative in the main atlas describes
   them, but no public substrate exists for independent verification.
3. The 484-tier `L(k)=24^(k-15)` lattice is an arithmetic indexing
   convention, not an empirical claim.
4. alien_index 6→500 spans verified engineering through pure conjecture.

## License

MIT. See [LICENSE](LICENSE).
