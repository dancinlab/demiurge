# NUCLEAR N12 next-cohort funnel — ranked accelerator-priority output

> ⚛️ **NUCLEAR** · "초중핵 사냥(超重核 funnel)" · N12 next-cohort sweep (sibling of N11 G4)
> Producer: `sim.hexa@nuclear-N12` (driver `n12_next_cohort.hexa` · scorer `n11_island_cell_checked`)
> Run: `hexa run n12_next_cohort.hexa` on pool **mini** (macOS · $0 local-pool · NO pod rent) · 2026-05-28T18-37-27Z
> **R4 invariant: `gate_type=nuclear-novel-discovery-simulation` · `absorbed=false` 영구.** Sim PASS = accelerator beam-time priority hint, NEVER a discovery claim. '가능성' != '임'.

## Cohort

10 nuclides — the Z=119/120 isotopes NOT covered by N11 (N11 G4 ranked 293/295-119 + 295/297-120). N12 sweeps the neutron-rich tail toward the predicted N≈184 island. **Cited Q_alpha from arxiv:1706.04068** (WS4 mass model primary; KTUY05 where W4 unavailable). NO fabrication: only cells with a cited numeric Q_alpha scored.

**Honest-skipped (no cited Q_alpha → §3.3, no fabrication):**
- Z=121, Z=122 — no cited Q_alpha anywhere (arxiv:2402.11514 Skyrme table concludes at Z=120; note §3 has none). Out-of-scope != impossible (@D d2).
- N=184-region (303/304-120, 301/303-119) — WS4 table reaches N=182 (302-120); island-center N=184 Q_alpha not in source → skip (no fabrication of the island-center value).

## Ranked top-K by composite_score (= c_total × island_weight)

| rank | nuclide | Z | N | Q_α (MeV) | log10 T_total (s) | dominant | island_w | **composite** | model_validity | tier |
|------|---------|---|---|-----------|-------------------|----------|----------|---------------|----------------|------|
| 1 | **298-120** | 120 | 178 | 11.486 | -1.96 | α (b=1.00) | 0.607 | **0.5447** | nominal | priority |
| 2 | **296-119** | 119 | 177 | 11.209 | -1.56 | α (b=1.00) | 0.499 | **0.4922** | out-of-domain | priority |
| 3 | 300-119 | 119 | 181 | 12.278 | -4.42 | SF (b=0.50) | 0.870 | 0.3064 | out-of-domain | priority |
| 4 | 299-119 | 119 | 180 | 12.526 | -4.94 | SF (b=0.50) | 0.790 | 0.1854 | odd-A | priority |
| 5 | 302-120 | 120 | 182 | 12.766 | -5.19 | SF (b=0.50) | **0.946** | 0.1701 | nominal | priority |
| 6 | 297-119 | 119 | 178 | 12.046 | -5.20 | SF (b=0.02) | 0.598 | 0.1068 | odd-A | priority |
| 7 | 301-120 | 120 | 181 | 12.939 | -5.54 | SF (b=0.50) | 0.882 | 0.0903 | odd-A | priority |
| 8 | 299-120 | 120 | 179 | 13.14 | -5.63 | α (b=1.00) | 0.707 | 0.0585 | odd-A | priority |
| 9 | 296-120 | 120 | 176 | 13.131 | -5.58 | α (b=1.00) | 0.411 | 0.0382 | nominal | priority |
| 10 | **300-120** | 120 | 180 | 13.308 | -8.22 | SF (b=0.006) | 0.801 | **0.0000** | nominal | **CLOSED-NEGATIVE** |

10/10 cells scored (no honest-skips within the cited-Q_alpha set). 1 CLOSED-NEGATIVE (300-120).

## Key findings

1. **298-120 (deformed-magic N=178) leads the cohort (0.545) and OUT-RANKS the entire N11 G4 novel list** (N11 top 295-119 = 0.046). Lower Q_alpha (11.486, the deformed shell-closure candidate from arxiv:2506.02684) gives a longer half-life that lands inside the accelerator band [-6,+3] log10 s, where N11's higher-Q_alpha cells fell short. This is the deformed-magic candidate the research note (§3 rank 6) flagged but could not score before — now scored from a CITED WS4 Q_alpha.
2. **302-120 has the highest island_weight (0.946)** — N=182 is the closest cited cell to the predicted N=184 island, on the Z=120 proton-magic candidate. Its short half-life (high Q_alpha) lowers c_total, so it ranks 5th by composite despite top island proximity.
3. **300-120 = CLOSED-NEGATIVE (g63)**: composite=0, even-even, in-model SF-collapse (b_α=0.006, log10 T_total=-8.22 s below the band). KEPT, not skipped. This is a genuine in-model SF-collapse (Ren-Xu valid for even-even Z=120), NOT "cannot exist" (@D d2). High Q_alpha (13.308) drives it.
4. **5 cells carry `sf_model_invalid=true`** (Ren-Xu out-of-domain guard → α-only total used as PREDICTION). Several odd-A cells carry the hindrance-not-modeled flag — a low composite there is an honest model-limit signal, not a true SF collapse (the only genuine CLOSED-NEGATIVE is the even-even 300-120).

## Verification (g5)

Closed-form kernels (NC1 Viola-Seaborg, NC2 Royer, C1 Ren-Xu/Hoffman/ZWP SF) reproduce the U-238 (+17.45 vs anchor +17.4) and Og-294 (-2.931 vs anchor -2.93) anchors VERBATIM via `test/nuclear_r4_anchor_smoke.hexa` — **4/4 PASS** (run on pool mini, hexa-lang af645e419). R4 invariant intact (7 absorbed=false literals, 0 absorbed=true). The same kernels were prior-registered as 2/2 + SF-trio 🟢 SUPPORTED-NUMERICAL `hexa verify --expr` atoms (NUCLEAR.md §6.3 / hexa-lang #960).

`hexa verify --expr` re-registration this session was BLOCKED: `tool/verify_cli.hexa` fails to compile on pool mini at hexa-lang af645e419 (clang: `_bessel_j1` duplicate-symbol codegen bug — pre-existing, unrelated to N12; the kernels themselves run cleanly via `hexa run`). hexa-lang INBOX item: verify-CLI build broken at af645e419 on macOS arm64.

## Provenance / citations

- arxiv:1706.04068 — Alpha decay of nuclei for synthesis of Z=119,120 (WS4 + KTUY05 Q_alpha; AKRA/ASAF/UNIV/semFIS half-life models)
- arxiv:2402.11514 — High-Quality Microscopic Nuclear Masses of SHE (Skyrme Q_alpha, dev <0.2 MeV; scope ends at Z=120 → confirms Z=121/122 honest-skip)
- arxiv:2506.02684 — Deformed magic N=178, Z=120 (basis for 298-120 candidate)
- arxiv:2601.21317 — Competing decay modes & stability of Z=120
- Viola-Seaborg 1966 / Royer 2000 / Ren-Xu PRC71 014309 2005 / Hoffman 1993 / Zdeb-Warda-Pomorski 2013 (kernels)
- demiurge research note 2026-05-25-she-driplinelit.md §3 (cohort context)

absorbed=false 영구 (R4). The (e)-gate detection (DGFRS-2 / GARIS-III) is permanently wet-lab-dependent — no sim substitutes for accelerator beam-time.
