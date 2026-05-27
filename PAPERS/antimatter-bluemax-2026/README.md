# antimatter-bluemax-2026 — BLUE-MAX audit of the antimatter factory

arxiv-style LaTeX paper externalising the ANTIMATTER domain's BLUE-MAX
algebraic-root audit. Regenerated on the paper-scaffolder **v0.8**
(`sample-blue-max` template + the new auto-generation verbs).

## Claim

The antimatter factory — a seven-stage antihydrogen production line
(generation → deceleration → capture → cooling → recombination →
confinement → measurement) — is reproduced verify-native as hexa-native
atoms. Every libm-class 🟢 SUPPORTED-NUMERICAL atom is backed by an integer
or rational 🔵 SUPPORTED-FORMAL sibling that pins its load-bearing exponent
or factor exactly.

- **26 atoms total** — 11 🟢 libm-class + 15 🔵 integer algebraic roots
- **BLUE-MAX coverage 11/11** — every 🟢 atom has a 🔵 sibling (@D g69)
- **absorbed=true** (demiurge PR #173) per @D d5
- **CPT Δ** (H vs H̄ 1S–2S) is downstream wet-lab, named openly, non-blocking

## Build

```
make            # xelatex × 3 + bibtex → main.pdf  (10 pages)
/paper compile .
/paper lint .   # commons g51 gate: ≥10 pages · ≥2 figures · ≥10 bib · sections
```

## Provenance (paper v0.8 verbs used)

- `/paper sample sample-blue-max antimatter-bluemax-2026` — template
- `/paper companion init` — `companion/` (verify-ledger, pr-roll)
- `/paper pr-roll dancinlab/demiurge <ref>` — merged-PR provenance
- `/paper bib add <doi>` — 10 references auto-fetched from CrossRef
- `/paper verify-block <fn> <args> <expected>` — verbatim `hexa verify` blocks
- `/paper compile` + `/paper lint`

Verdicts are faithful captures of `hexa verify --expr` against
`bin/hexa-verify` (rebuilt from `hexa-lang/tool/verify_cli.hexa`) on a single
`POOL_DISABLE=1` host. The figure was generated via fal.ai; its prompt is
preserved at `figures/_prompts/factory_line.txt` (provenance, @D g51).

## Layout

```
main.tex                  paper source
main.pdf                  compiled (10 pp)
references.bib            10 DOI-backed entries (bib add)
figures/                  fal.ai factory-line schematic + prompt
companion/                verify-ledger.json · pr-roll.json
out/                      arxiv submission tarball
```
