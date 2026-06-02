# Release Notes — hexa-matter v1.2.0

**Release date**: 2026-05-13
**Range covered**: 2026-05-09 → 2026-05-13
**Status**: SPEC_FIRST · **36 verbs** · 4/4 verify PASS · 28/28 selftest PASS · ✅ **Category (a)+(b) closure = 100%**
**Author**: 박민우 <nerve011235@gmail.com>
**Tag**: `v1.2.0` (Phase A–I elevation + Category (a)+(b) closure certification)
**Companion artifact**: [`CLOSURE_STATUS.md`](CLOSURE_STATUS.md) — top-level certification doc

---

## Headline

**Phase A–I elevation: 17 → 36 verbs, +30 external adapters, +29 parity gates,
Category (a)+(b) closure = 100%.**

Between 2026-05-09 (v1.0.0 retroactive base) and 2026-05-13 (this release),
hexa-matter has been elevated from a thin 17-verb SPEC_FIRST catalog to a
36-verb substrate with 14 absorption adapters, 8 research-bridge modules,
12 Python-compute bridges, 29 Category (b) parity gates, and a 28/28 selftest
harness. The combined `Category (a) + Category (b) closure-grade is 100%`
as of this release. Category (c) — wet-lab synthesis, vendor procurement,
fab capacity — remains **OUT-OF-REPO BY DESIGN** per
[`AXIS_CLOSURE_PLAN.md §0`](AXIS_CLOSURE_PLAN.md).

---

## Summary

The v1.1.0 → v1.2.0 window is the most architecturally dense window in
hexa-matter's history:

| Surface                       | v1.1.0       | v1.2.0           | Delta                              |
|-------------------------------|--------------|------------------|------------------------------------|
| Verb specs                    | 17           | **36**           | +19 (Phase D + D' + D'')           |
| Verify scripts                | 4/4 PASS     | **4/4 PASS**     | unchanged (structural closure)     |
| Selftest gates                | 0            | **28/28 PASS**   | +28 (Phase B + bridges + parity)   |
| Python-bridge modules         | 0            | **12**           | +12 (Phase E)                      |
| Research-bridge modules       | 0            | **8**            | +8 (Phase F)                       |
| Absorption-bridge adapters    | 0            | **14**           | +14 (Phase G + G+1 + G+2)          |
| Category (b) parity gates     | 0 / 29       | **29 / 29 ✅**   | +29 (Phase H + I.1 + I.2)          |
| Closure verdict               | (a)=100%     | **(a)+(b)=100%** | (b) fully closed; (c) out-of-repo  |

This release ships under the dancinlab-wide `LATTICE_POLICY` (Wave K) +
`LIMIT_BREAKTHROUGH` (Wave M) discipline; all 19 new artifacts respect the
UNPROVEN/UNVERIFIED markers verbatim.

---

## Phase-by-phase rollup

Each phase below ships under a single commit; SHAs are recorded in
[`INIT.md` §"Commit log (this elevation)"](INIT.md) and reproduced inline.

### Phase A — infrastructure docs (`c55199b`)

26 files / 5045 lines. 10 architecture-and-lifecycle docs (`AXIS.md`,
`AXIS_CLOSURE_PLAN.md`, `CLOSURE_RESIDUAL_BACKLOG.md`, `DECOMPOSITION_PLAN.md`,
`LESSONS.md`, `RELEASE_NOTES_v1.0.0.md`, `RELEASE_NOTES_v1.1.0.md`,
`V1_2_0_HANDOFF.md`, `USER_ACTION_REQUIRED.md`, `IMPORTED_FROM_CANON.md`),
5 deep-expansion chapters (300+ lines each: `SILICON.md`, `CERAMIC-ENGINEERING.md`,
`METALLURGY-DEEP.md`, `POLYMER-CHEMISTRY.md`, `GRAPHENE-CARBON.md`), and 11
Phase D candidate stubs. The 7-group taxonomy (CER · POL · FIB · MET · GEM ·
PRC · FAS) and the Category (a)/(b)/(c) closure framework were imported from
`hexa-bio` cycle-30 and adapted to the materials axis.

### Phase D — 12 new material verbs (`99620b2`)

17 → 29 verbs. Added: `elastomer`, `compound-semi`, `perovskite`, `2d-materials`,
`adhesive`, `magnetic-materials`, `mof`, `liquid-crystal`, `superalloy`,
`biodegradable-plastics`, `wood-cellulose`, `carbon`. Each follows the
`silicon.md` real-limits-first template (~269 lines avg, 3227 total new lines).
12 honest UNPROVEN/UNVERIFIED markers preserved per verb (LK-99 not reproduced,
6/8" bulk GaN UNVERIFIED, marine-biodegradable PHA generic UNVERIFIED, Re-free
4th-gen SX UNVERIFIED, magic-MOF DAC $100/t UNPROVEN, etc.).

### Phase D' — 4 follow-on verbs (`f4531fa`)

29 → 33 verbs. Added: `glass-ceramic`, `geopolymer`, `aerogel-foam`,
`ionic-liquid`. UNVERIFIED carries-through: glass-ceramic transparent-armor
large-pane UNVERIFIED · geopolymer CO₂-reduction LCA UNVERIFIED · aerogel
cost-per-kg UNPROVEN · ionic-liquid "green-solvent" claim UNVERIFIED at full
LCA. Allocation: CER +3 (silicate / aluminosilicate chemistry); POL +1
(ionic-liquid as soft-matter extension).

### Phase D'' — 3 more verbs (`1924adc`)

33 → **36 verbs**. Added: `refractory` (firebrick · Al₂O₃ · MgO · ZrO₂ · mag-C ·
SiC · carbon · AZS), `photoresist` (g/i-line DNQ · KrF · ArF · EUV CAR · MOR ·
dry-film PCB), `electrode-material` (LFP · NMC811 · LCO · graphite · Si-anode ·
Li-metal · Pt-ORR · IrO₂-OER · MnO₂). Cross-link discipline enforced:
`photoresist/photoresist.md` declares lithography process belongs to
`hexa-chip`; `electrode-material/electrode-material.md` declares cell
engineering belongs to `hexa-energy`. UNVERIFIED: RCF Group 2B IARC (real),
EUV resist photon-shot-noise vs LER NOT FULLY RESOLVED (IRDS 2023), CATL Blade
12,000-cycle multi-vendor reproduction OPEN.

### Phase B — selftest harness (`f24d8a5`)

21 fine-grained gates landed under `selftest/`: 8 cross-cutting (symlink audit,
registry consistency, regression audit, n=6 axis computation, cross-doc audit,
canon provenance, NIST anchor audit, **lattice-fit-on-external-entities audit
tensile, MET alloy classification, GEM authenticity, PRC yield, FAS dye
chemistry, silicon purity) + 4 verb-specific (compound-semi bandgap, magnetic
Curie+BHmax, **CNT 80 GPa honesty caveat**, **MOF DAC $100/t UNPROVEN
preservation**) + 1 Phase E bonus aggregator. Sentinel:
`__HEXA_MATTER_SELFTEST__ PASS (21/21)`.

### Phase C — `hexa-*` axis-prefixed depth dirs (`6e4928a`)

9 depth directories, one per AXIS group: `hexa-silicon/`, `hexa-polymer/`,
`hexa-ceramic/`, `hexa-metal/`, `hexa-fiber/`, `hexa-gem/`, `hexa-fashion/`,
`hexa-recycle/`, `hexa-synthesis/`. 36 files / 3913 lines of sub-spec markdown
+ cross-links back to verb dirs.

### Phase E — `_python_bridge/` (`b4ebf8f`)

12 runnable scientific-compute modules: 6 stdlib FUNCTIONAL
(`silicon_purity_compute`, `polymer_mw_distribution`,
`metallurgy_alloy_composition`, `carbon_form_factor_classifier`,
`cross_doc_consistency_compute`, `nist_anchor_resolver`) + 2 RDKit PARTIAL
(`rdkit_smiles_audit`, `rdkit_descriptor_calc`) + 2 ASE PARTIAL
(`ase_atoms_construct`, `ase_relaxation_check`) + 2 pymatgen PARTIAL
(`pymatgen_structure_io`, `pymatgen_phasediagram_smoke`). Aggregator:
`selftest/pyproject_smoke.sh`. Stock-Python result:
`__HEXA_MATTER_PYTHON_BRIDGE__ PASS (12/12 modules, 5 skipped)`.

### Phase F — `_research_bridge/` (`185ce33`)

8 absorption modules across arxiv + web + selftest aggregators:
`arxiv/arxiv_pull.py`, `arxiv/arxiv_digest.py`, `web/vendor_datasheet_pull.py`,
`web/materials_news_feed.py`, `web/patent_search.py`, plus 3 selftest wrappers.
Each accepts `--selftest` (OFFLINE replay only — NO live network in CI); `--live`
is rate-limit-aware (arxiv 3-sec backoff, vendor robots.txt, USPTO/EPO polite
cadence). UNPROVEN flag list propagates through digest: LK-99, magic-MOF $100/t,
perovskite 25-yr lifetime, ambient metallic-H, infinite-recycle.

### Phase G — `_absorption_bridge/` (`e712068`)

10 adapters for AlphaFold-class external materials-discovery system absorption
per user directive ("알파폴드 처럼 흡수할 시스템도 흡수"): Materials Project
(Berkeley/LBNL ~154k materials) · GNoME (DeepMind 2.2M predicted-stable crystals,
Zenodo DOI 10.5281/zenodo.10371563, **PREDICTED NOT SYNTHESIZED**) · Matlantis
(Preferred Networks PFP universal NNP, **COMMERCIAL UNVERIFIED**) · OMat24 (Meta
AI 110M structures + MACE-OMat checkpoint) · SchNet · MACE · ALIGNN · CHGNet ·
M3GNet (5 universal force fields). All offline-replay; aggregator
`selftest/absorption_bridge_smoke.sh`.

### Phase G+1 — COD adapter (`6993e4a`)

`_absorption_bridge/cod/` — Crystallography Open Database (Gražulis 2009/2012),
the **first EXPERIMENTAL XRD measurement source** in the bridge (distinct from
MP / GNoME / OMat24 NNP outputs, which are computed predictions). CC0
public-domain raw data. 11th adapter. Selftest 23/23 → **24/24**.

### Phase G+2 — OQMD + AFLOW + NOMAD (`a54da35`)

3 more DFT/FAIR-data adapters: **OQMD** (Wolverton/Northwestern, ~1M DFT-PBE
entries, Saal 2013 + Kirklin 2015 npj Comput. Mater.) · **AFLOW** (Curtarolo/
Duke, 3M+ DFT compounds — largest single computational DB, Curtarolo 2012 +
Toher 2018 + Rose AFLUX 2017) · **NOMAD** (Draxl & Scheffler EU FAIR-data,
19M+ aggregated multi-code DFT entries preserving originating-code provenance:
VASP / QE / FHI-aims / ABINIT / CP2K / GPAW / SIESTA). All CC-BY 4.0.
Selftest 24/24 → **27/27**. Brings adapter count to **14**.

### Phase H — Category (b) parity gates batch 1 (`e12dfb9`)

10 stdlib-only parity gates landed under `tests/*_parity.py` + 10 vendored
snapshots under `tests/snapshots/<gate_id>.json`. Each gate ≤ 80 LOC, reads
its snapshot, locates the spec doc's value via deterministic regex, asserts
spec↔source parity within a published tolerance. Gates: `cer_b2_si_density`,
`cer_b3_si_bandgap`, `cer_b4_sic_bandgap`, `cer_b5_si3n4_flexural`,
`pol_b1_aramid_tensile`, `pol_b4_nylon66_tg_tm`, `fib_b2_paper_tensile`,
`met_b4_w_melting`, `met_b5_os_density`, `gem_b1_corundum_ri`. Aggregator
`selftest/parity_gates_smoke.sh`. Selftest 27/27 → **28/28**. Ledger §B
drained 29 → 19.

### Phase I.1 — Phase B target parity gates batch 2 (`583fddb`)

10 more parity gates: `cer_b1_quartz_ri` (NIST SRM 1960) · `cer_b7_mohs_hardness`
(Mohs 1812 + NIST SRD) · `pol_b2_pet_hydrolysis_ea` (Marshall 1988 + Toray) ·
`fib_b1_cellulose_segal` (TAPPI T 271 + Segal 1959) · `met_b1_inconel718_creep`
(ASM vol. 1 + Special Metals) · `met_b2_ti64_transus` (ASM vol. 2) ·
`met_b3_aisi1080_ttt` (ASM vol. 4 + Bain 1930) · `gem_b2_ruby_rline` (NIST +
Sugano-Tanabe-Kamimura) · `prc_b1_hales_packing` (Hales 2017 formal proof) ·
`fas_b1_reactive_dye_yield` (ISO 105-X12 + ICI Procion-H + Aspland 1997).
Aggregator now sweeps 20/20. Ledger §B drained 19 → 9.

### Phase I.2 — Phase F target parity gates batch 3 (`196b03c`)

9 more parity gates closing the residual: `cer_b6_uhpc_compressive` (Ductal +
Cor-Tuf datasheets — σ_c 150–800 MPa) · `cer_b8_si_thermal_donor` (Kaiser-Frisch
1958 + SEMI MF1188) · `cer_b9_si_oxygen_interstitial` (ASTM F121 / F1188) ·
`pol_b3_microplastic_kd` (NOAA + Mato 2001 + Rochman 2013) · `pol_b5_uhmwpe`
(DSM Dyneema SK99) · `pol_b6_cnt_yarn` (Tsinghua Bai 2018 — 80 GPa **UNPROVEN
at commodity scale preserved verbatim**; gate verifies lab-mm parity only) ·
`prc_b2_recycling_gibbs` (ISO 14040 + Gibbs ideal-mixing) · `prc_b3_solgel_teos`
(Hench & West 1990 + Brinker & Scherer 1990) · `fas_b2_kubelka_munk` (AATCC
TM6 + Kubelka-Munk 1931 closed-form K/S identity). Aggregator now sweeps
**29/29**. Ledger §B drained 9 → 0. **Combined with §A 100%, Category
(a)+(b) closure = 100%.**

---

## Cross-link manifest (`CROSS_LINK.md`)

19 sister repos cataloged (18 on disk; 1 future):

`hexa-rtsc` · `hexa-chip` · `hexa-energy` · `hexa-bio` · `hexa-fusion` ·
`hexa-space` · `hexa-mobility` · `hexa-earth` · `hexa-cern` · `hexa-grid` ·
`hexa-physics` · `hexa-cosmos` · `hexa-farm` · `hexa-arts` · `hexa-antimatter` ·
`hexa-fantasy` · `hexa-millennium` · `hexa-aura` · `hexa-aero (FUTURE)`.

Per-sister boundary lines, contact verbs, and no-double-claim discipline
documented in `CROSS_LINK.md §3`. Key invariants: hexa-matter owns the
**material layer only** — composition, structure, property table anchored on
NIST/CRC/SEMI/ASTM/vendor. Devices, processes, system-level claims belong
to the sister. No cross-repo CI runs; this is a written manifest, not an
executed integration.

---

## NOVEL ledger (`NOVEL.md`)

12 hxm-* candidate IDs (sister-of-pattern: `hexa-bio/.roadmap.novel_drugs`)
across 11 distinct classes, all `DESIGN` status — none claim measurement,
all carry quantitative falsifiers:

| Class      | Candidate IDs (DESIGN status)                                                      |
|------------|------------------------------------------------------------------------------------|
| sc         | `hxm-sc-cuprate-001`, `hxm-sc-pnictide-001`, `hxm-sc-h3s-derived-001`              |
| cath       | `hxm-cath-licmf-001`, `hxm-cath-ni-rich-001`, `hxm-cath-disord-001`                |
| se         | `hxm-se-argyrod-001`, `hxm-se-halide-001`                                          |
| pv         | `hxm-pv-pb-free-001`, `hxm-pv-tandem-001`                                          |
| mag        | `hxm-mag-refree-001`, `hxm-mag-mnbi-001`, `hxm-mag-tetra-001`                      |
| hea        | `hxm-hea-refrac-001`, `hxm-hea-cantor-001`, `hxm-hea-light-001`                    |
| mof        | `hxm-mof-dac-001`, `hxm-mof-dac-002`                                               |
| 2d         | `hxm-2d-mosi2n-001`, `hxm-2d-cri3-stack-001`                                       |
| pcm        | `hxm-pcm-gst-001`, `hxm-pcm-sbte-001`                                              |
| cnt        | `hxm-cnt-yarn-001`                                                                 |
| meta       | `hxm-meta-neg-001`, `hxm-meta-cloak-001`, `hxm-meta-acoustic-001`                  |
| top        | `hxm-top-bi2se3-001`, `hxm-top-sn-001`, `hxm-top-majorana-001`                     |
| bmg        | `hxm-bmg-zr-001`                                                                   |
| aero       | `hxm-aero-graphene-001`                                                            |
| mxene      | `hxm-mxene-ti3c2-001`, `hxm-mxene-mo2c-001`                                        |
| bio        | `hxm-bio-pha-marine-001`                                                           |
| liq        | `hxm-liq-gain-001`                                                                 |
| anode      | `hxm-anode-sigr-001`                                                               |
| cat        | `hxm-cat-fenc-001`                                                                 |
| ferro      | `hxm-ferro-hzo-001`                                                                |
| thermo     | `hxm-thermo-snse-001`                                                              |
| membrane   | `hxm-membrane-zif8-001`                                                            |
| quantum    | `hxm-quantum-sicvv-001`                                                            |

Per `NOVEL.md §2`, no entry has `EXTERNAL-VERIFIED` status — that requires
written quantitative falsifier (`F-<class>-NN`). Per `LATTICE_POLICY.md §1.2`,
the n=6 lattice is NOT evidence for property claims here — it is an organizing
tool only.

---

## Honesty inventory — UNPROVEN / UNVERIFIED markers preserved verbatim

Across the 19 new verb specs + 14 absorption adapters + 29 parity gates, the
following honesty stamps are preserved verbatim per `INIT.md` hard rules
4/5/6 and `LIMIT_BREAKTHROUGH.md`:

- **LK-99 room-T SC** — NOT REPRODUCED; HARD_WALL until peer-reviewed reproduction. Per `perovskite/perovskite.md` + `LIMIT_BREAKTHROUGH.md` + `PEROVSKITE.md` anti-claim row.
- **Metallic hydrogen at ambient** — UNPROVEN. Per `verify/real_limits_anchor.hexa` caveat list.
- **Magic-MOF DAC $100/t** — UNPROVEN; Climeworks amine baseline $600–1000/t named. Per `mof/mof.md` + `selftest/mof_dac_economics_honesty_audit.py`.
- **CNT yarn 80 GPa lab-mm** — UNPROVEN at commodity scale; commercial 1–3 GPa preserved. Per `carbon/carbon.md` + `selftest/carbon_cnt_strength_honesty_audit.py` + `tests/pol_b6_cnt_yarn_parity.py` (gate verifies lab-mm parity only, NOT km-scale reproducibility).
- **Re-free 4th-gen single-crystal superalloy** — UNVERIFIED at parity to Re-bearing CMSX. Per `superalloy/superalloy.md`.
- **Marine-biodegradable PHA (generic)** — UNVERIFIED; only specific PHA D7081-certified grades. Per `biodegradable-plastics/biodegradable-plastics.md`.
- **L5 autonomy** — UNVERIFIED; not a hexa-matter claim. Cross-substrate caveat preserved in `CROSS_LINK.md §3.7` (hexa-mobility boundary).
- **GNoME 2.2M predicted stable crystals** — `is_synthesized: false` + `synthesis_status: UNPROVEN — DFT prediction only`. Per `_absorption_bridge/gnome/SOURCES.md` + `gnome_dataset_smoke.py`.
- **Matlantis commercial** — UNVERIFIED at hexa-matter scale economics; Preferred Networks proprietary SDK. Per `_absorption_bridge/matlantis/SOURCES.md`.

Additional preserved markers: rare-earth-free > 35 MGOe UNVERIFIED · Majorana
fermion identification CONTESTED · 50+ story mass-timber UNVERIFIED · CATL
Blade 12,000-cycle multi-vendor reproduction OPEN · EUV resist photon-shot-noise
vs LER NOT FULLY RESOLVED · transparent-armor large-pane production UNVERIFIED.

---

## Verdict (v1.2.0)

```toml
[closure]
verbs_total = 36
groups_total = 7
verbs_wired = 0
verbs_spec = 36
verdict = "SPEC_FIRST"
verify_pass = "4/4"
selftest_pass = "28/28"
python_bridge_modules = 12
research_bridge_modules = 8
absorption_bridge_modules = 14
parity_gates_total = 29
category_ab_closure = "100%"        # ← reached 2026-05-13
category_c_status   = "OUT_OF_REPO_BY_DESIGN"

[verify]
scripts_total = 4
scripts_passed = 4
verdict = "CLOSED"
```

---

## What's next (v1.3.x candidate)

**TBD per maintainer direction.** This release does NOT promise any
specific Phase J or v1.3 scope. Candidate axes that are conceivable but
not committed:

- additional NOVEL.md candidates with `SIM-*` status (would require live
  `_python_bridge` or `_absorption_bridge` run + recorded sim handle)
- additional absorption adapters (e.g. Open Catalyst Project, Atomly,
  AtomWork) if user directs
- live-mode (non-selftest) tests of Phase F arxiv + web + patent endpoints
- per-verb falsifier deadlines (DESIGN → SIM transition for specific candidates)
- additional parity-gate batches if `LIMIT_BREAKTHROUGH.md` is extended

None of the above is on the v1.3.x roadmap as of this release. The (a)+(b)
closure verdict is stable; (c) is OUT-OF-REPO BY DESIGN; this release is
internally consistent at the values declared in §"Scoreboard" of
`CLOSURE_STATUS.md`.

---

## Acknowledgments

- canon authors at `canon@47c70cbf` for the 16-verb v1.0.0 base
- `hexa-bio` team for the AXIS / AXIS_CLOSURE_PLAN / CLOSURE_RESIDUAL_BACKLOG /
  DECOMPOSITION_PLAN / LESSONS / `_absorption_bridge/` / `NOVEL.md` patterns
  (cycle-30, 2026-05-12) — hexa-matter and hexa-bio are tone-parity across
  these dimensions
- Wave K `LATTICE_POLICY` (dancinlab-wide, 2026-05-12) for the n=6-as-tool
  discipline
- Wave M `LIMIT_BREAKTHROUGH` audit for surfacing the silicon gap and
  anchoring the real-limits-first verification anchors
- All 23 external scientific tools / databases / NNPs absorbed across
  Phase E + F + G + G+1 + G+2 — their published license + citation + version

---

## Commit log (this elevation)

```
91981d4  chore(closure): drive hexa-matter to 100% spec-first verify closure (4/4)
a239611  feat(silicon): add silicon material spec — 17/17 verbs
c55199b  feat(phase-a): elevate hexa-matter to hexa-bio architectural maturity
99620b2  feat(phase-d): add 12 new material verbs (17→29)
f24d8a5  feat(phase-b): hexa-matter selftest harness — 21/21 gates PASS
6e4928a  feat(phase-c): hexa-matter axis-prefixed depth dirs
b4ebf8f  feat(phase-e): hexa-matter _python_bridge — 12 compute modules
185ce33  feat(phase-f): hexa-matter _research_bridge — arxiv + vendor + news + patent
e712068  feat(phase-g): hexa-matter _absorption_bridge — 10 adapters
f4531fa  feat(verbs): add 4 verbs — glass-ceramic + geopolymer + aerogel-foam + ionic-liquid (29→33)
1924adc  feat(verbs): add 3 verbs — refractory + photoresist + electrode-material (33→36)
6993e4a  feat(absorption): add COD adapter — Crystallography Open Database (11th adapter)
a54da35  feat(absorption): add OQMD + AFLOW + NOMAD adapters (11→14)
e12dfb9  feat(phase-h): land 10 parity gates — Category (b) closure (10/10)
583fddb  feat(phase-i.1): land 10 Phase B target parity gates (20/20)
196b03c  feat(phase-i.2): land 9 Phase F target parity gates — Category (a)+(b) = 100%
```

---

*Release notes authored 2026-05-13 by 박민우 <nerve011235@gmail.com>. Sister-
of-tone: `RELEASE_NOTES_v1.0.0.md` (retroactive 2026-05-09 base) +
`RELEASE_NOTES_v1.1.0.md` (silicon addition + Phase A infrastructure).
Top-level certification companion: [`CLOSURE_STATUS.md`](CLOSURE_STATUS.md).*
