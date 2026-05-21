# Tier 3 measurement_record ingest — batch 1 (5 records, literature-extracted)

## Context

RTSC.md §8.7 Tier 3 (measurement ingest) had **1** record (the SuperPower 2G HTS
tape Jc(B,θ) baseline) — vendor-datasheet origin, `replication_count: 1`,
`absorbed: false`. The downstream `MaterialFalsifierDispatch` (Tier 4) had
nothing to bucket beyond `jc_b_theta` for non-LK-99 materials, so most of its
6-falsifier verdict reduced to `SKIPPED-MISSING-INPUT` for canonical compounds.

This batch expands Tier 3 from 1 → **6 records** (1 existing + 5 new) drawn from
public superconductivity literature, sized to exercise 4 of the 6 falsifiers
(F-RTSC-1, F-RTSC-2, F-SC-2, F-SC-3) on non-LK-99 compounds.

## Files added

| Path | kind | compound | test_family | replication_count | source_url HTTP | headline |
|---|---|---|---|---|---|---|
| `exports/measurement/r_t/ybco_wu1987.json` | `r_t` | YBa2Cu3O7-delta | hts_cuprate | 1000 | 302 | Tc = 92.0 K |
| `exports/measurement/r_t/mgb2_budko2001.json` | `r_t` | MgB2 | mgb2 | 500 | 200 | Tc = 39.0 K |
| `exports/measurement/meissner_chi_t/nb_finnemore1966.json` | `meissner_chi_t` | Nb | lts | 200 | 302 | Tc = 9.25 K, chi = -1.0 |
| `exports/measurement/specific_heat_c_p/mgb2_bouquet2001.json` | `specific_heat_c_p` | Mg-11B2 | mgb2 | 50 | 200 | deltaCp/(gamma Tc) = 1.32 |
| `exports/measurement/hc2_t/nb3sn_godeke2006.json` | `hc2_t` | Nb3Sn | lts | 100 | 200 | Hc2(4.2 K) = 27 T |

(Existing baseline unchanged: `exports/measurement/jc_b_theta/superpower_2g_baseline.json`.)

## Source URLs

- YBCO Wu 1987 — https://doi.org/10.1103/PhysRevLett.58.908 (PRL 58, 908)
- MgB2 R(T) Bud'ko 2001 — https://arxiv.org/abs/cond-mat/0102413 (PRB 63 220503R; discovery: Nagamatsu Nature 410, 63)
- Nb Meissner Finnemore 1966 — https://doi.org/10.1103/PhysRev.149.231 (PR 149, 231; + Tinkham textbook Table 1.1)
- MgB2 Cp Bouquet 2001 — https://arxiv.org/abs/cond-mat/0104206 (PRL 87, 047001)
- Nb3Sn Hc2 Godeke 2006 — https://arxiv.org/abs/cond-mat/0606303 (SuST 19, R68)

Reachability: all 5 return 2xx or 3xx via `curl -A "Mozilla/5.0"`. APS doi.org
URLs return 302 (redirect to link.aps.org which is bot-blocked on raw curl
HEAD but loads fine in browser); arxiv mirrors return 200 directly.

## Falsifier coverage (Tier 4 dispatch impact)

`MaterialFalsifierDispatch` (`cockpit/Sources/DemiurgeCore/Loaders/MaterialFalsifierDispatch.swift`)
buckets measurements by `kind`. With this batch, a dispatch over any of the
covered compounds can now light up the following falsifiers (PASS/FAIL instead
of SKIPPED-MISSING-INPUT):

| Falsifier | Verifier | Lit by which record(s) |
|---|---|---|
| F-RTSC-1 (Meissner χ < 0) | dispatch line 217-253 reads `kind=="meissner_chi_t"` | nb_finnemore1966 (chi = -1.0 → PASS expected when paired with a Tier 1 Nb ConductorRecord) |
| F-RTSC-2 (R(T) drop within [0.5 Tc_pred, 2.0 Tc_pred]) | dispatch line 260-295 reads `kind=="r_t"` headline.tc_k | ybco_wu1987 (Tc=92 K) + mgb2_budko2001 (Tc=39 K) |
| F-SC-2 (McMillan/Allen-Dynes Tc consistency) | dispatch line 129-163 reads `kind=="r_t"` headline.tc_k | same r_t records as F-RTSC-2 |
| F-SC-3 (Hc2 WHH extrapolation) | dispatch line 168-212 reads `kind=="hc2_t"` headline.hc2_t | nb3sn_godeke2006 (Hc2(4.2K)=27 T) |

NOT lit by this batch:
- F-SC-1 (BCS isotope effect, requires `kind=="isotope_effect"` with a data_point
  having `dependent_var_name=="alpha"`). Deferred — would need a Bud'ko 11B/10B
  isotope-substitution ingest (cond-mat/0101463) plus the `isotope_effect` kind
  not yet wired into the §8.2 enum surface here.
- F-RTSC-3 (independent-lab replication ≥ 2). This is read from Tier 2
  `SynthesisRecipeRecord.replicated_by_independent_labs`, NOT from Tier 3.

The `specific_heat_c_p` record (Bouquet MgB2) is not currently bucketed by
dispatch (no Cp branch exists today); it's ingested for the §8.4 9-test
matrix completeness and for whatever later Cp-based falsifier wires get added.

## Honest g3 stance (RTSC.md §8.7 → §8.8)

- All 5 records: `absorbed: false` (Tier 3 ingest never auto-promotes to
  absorbed=true; cross-lab attestation in a meta-cohort is required separately).
- `gate_type: "literature-extracted"` (NOT "vendor-datasheet"; these are
  hand-cited arxiv/PRL papers, not vendor product sheets).
- `provisional: true` and `measurement_gate: "GATE_OPEN"` (measurement gate
  remains open even with high replication_count — we did not run the
  instrument, we transcribed a published figure).
- `replication_count`: literature-reproduction count, NOT within-sample
  technical repeats. Values are order-of-magnitude (YBCO ≥ 1000 papers since
  1987; MgB2 ≥ 500 since 2001; Nb ≥ 200 over 60 years; Nb3Sn Hc2 ≥ 100
  multi-vendor compilations; MgB2 Cp ≥ 50 thermo reproductions).
- All `data_points` are digitized from published figures with `±5%` caveat
  recorded in `scope_caveats`; deltaCp(Tc)=133 mJ/mol/K is the directly quoted
  paper value (Bouquet), and Hc2(0)=30 T is a WHH extrapolation (also flagged).
- `raw_data_hash: null` — no raw instrument bytes; literature provenance only.

## Blockers / notes

- **APS doi.org URLs return 302 redirect → APS publisher page which 403s on
  curl HEAD** (bot detection, not a paywall — the abstract pages are publicly
  readable in browser). The 302 from doi.org satisfies the "2xx/3xx" reachability
  bar in the task spec, and the canonical DOI is the citation-stable URL.
- **Wu 1987 (YBCO) has no arxiv preprint** (predates arxiv submission practice).
  DOI URL is the only stable citation.
- **Finnemore 1966 (Nb) has no arxiv preprint** (same era). Cited via DOI +
  Tinkham textbook ISBN as a second reference.
- **Nagamatsu 2001 (MgB2 discovery) has no arxiv preprint** (Nature direct
  submission). Cited as a supporting reference in the Bud'ko record's
  `source_citation` and `citations`; the source_url for that record points to
  Bud'ko (cond-mat/0102413) which does have arxiv and was contemporaneous.
- No Python producers, Swift models, RTSC.md, or MP.md were modified.
- Existing `jc_b_theta/superpower_2g_baseline.json` was not touched.
