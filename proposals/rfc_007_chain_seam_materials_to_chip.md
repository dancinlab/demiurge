# RFC 007 — chain seam: materials → chip (typed HANDOFF→SPECIFY contract)

> Status: **draft / design only — NOT wired** · 2026-05-19 ·
> Source: rfc_004 §4 (chained meta-pipeline) + §7 Phase 3 + §9 open
> ("material-property typed contract schema"). Decisions: `design.md`
> D2 (typed-interface decoupling), D11 (meta-conductor), D17
> (hexa-matter absorption SSOT = hexa-lang; demiurge = consumer),
> D7 (producer-owned export path), g3 (no-over-claim — no fabricated
> records). Pattern mirror: **rfc_002** (the chip→comb F1F2 typed
> seam — same shape, opposite end of the chain).

---

## 1. The seam this RFC specifies

rfc_004 §4 chains 7-verb passes in series; each seam = upstream
**HANDOFF** feeding downstream **SPECIFY** via a typed contract. This
RFC specifies the **first seam — the chain head**:

```
┌── materials (hexa-matter) ──┐  THIS RFC   ┌── demiurge[chip] ──┐
│ 물질합성·소재               │  typed      │ 소자/공정 → NoC/arch │
│ SSOT = hexa-lang (D17)      │  contract   │ (EDA stack absorbed)│
│ …SPECIFY..HANDOFF ─────────▶│  material-  │ SPECIFY.. ──────────▶│ (next seams)
│ (consumed, D2 — NOT absorbed)│  property   │                     │
└─────────────────────────────┘  record     └─────────────────────┘
```

demiurge[chip] **SPECIFY** needs the upstream material properties to
parameterise device/interconnect/PDK characterization (the chip
domain's first 7-verb sub-pass). This RFC = the **consumption
contract** chip declares; the records are produced **upstream**
(hexa-matter, SSOT hexa-lang per D17) — demiurge does **not** emit
them (g3, §5).

## 2. Producer vs consumer (D2 / D17 — explicit)

| side | repo | role | this RFC |
|---|---|---|---|
| producer | hexa-matter (SSOT `hexa-lang`, D17) | emits material-property records at its 7-verb HANDOFF | upstream — **not** owned/decided here |
| consumer | `demiurge[chip]` SPECIFY | reads a typed subset to parameterise device/PDK char | **this contract** |

D2 holds: hexa-matter is **typed-interface-consumed, NOT absorbed**.
D17: its absorption SSOT is hexa-lang; demiurge is a consumer. This
RFC therefore specifies only what demiurge **expects to read**, never
how the upstream produces it.

## 3. Schema v0 (draft — the material-property record key set)

`schema_version` = **0.x** (pre-1.0 on purpose — the upstream
hexa-lang/hexa-matter HANDOFF shape is **not yet pinned**; honest, g3).
Units explicit on every physical quantity (ai-native: typed,
machine-readable). JSON shown for human read; wire form = HXC v2
canonicalisation of the same key set (rfc_002 §3 carrier convention).

```jsonc
{
  "interface": "demiurge:seam:materials->chip:matprop-record",
  "schema_version": "0.1",
  "record_id": "<content-hash of body, HXC A12-canon hex>",
  "produced_at_utc": "<ISO-8601 UTC — set by upstream producer>",

  "material": {
    "id":          "<upstream hexa-matter material id>",
    "composition": "<formula / phase string>",
    "structure":   "<crystal/amorphous/2d/... string>",
    "role":        "dielectric" | "conductor" | "semiconductor" |
                   "barrier" | "substrate" | "package"
  },

  "electrical": {
    "resistivity_ohm_m":      <number|null>,
    "rel_permittivity_k":     <number|null>,   // low-k interconnect
    "carrier_mobility_cm2_Vs":<number|null>,
    "bandgap_eV":             <number|null>,
    "breakdown_field_MV_cm":  <number|null>
  },
  "thermal": {
    "conductivity_W_mK":      <number|null>,
    "cte_ppm_K":              <number|null>,   // → thermal signoff
    "specific_heat_J_kgK":    <number|null>
  },
  "mechanical": {
    "youngs_modulus_GPa":     <number|null>,   // → component stage
    "density_kg_m3":          <number|null>
  },

  "process_hints": {
    "node_relevance": ["<process node string>", ...],
    "notes":          "<free text — non-load-bearing>"
  },

  "provenance": { /* §4 — required, carried from upstream */ }
}
```

`null` is explicit "upstream did not supply" — never a fabricated
default (g3). chip SPECIFY consumes only the subset its active
device/PDK model declares; unknown extra keys are ignored
(forward-compatible, rfc_002 §6 idiom).

## 4. Provenance / no-over-claim required fields (mirror rfc_002 §4)

Every record MUST carry, set **by the upstream producer**, read-only
to demiurge:

```jsonc
"provenance": {
  "producer":          "hexa-matter@<rev>  (SSOT hexa-lang, D17)",
  "absorbed":          false,          // D2 — consumed, never absorbed
  "measurement_gate":  "GATE_OPEN" | "GATE_B_PINNED_MET" |
                        "GATE_CLOSED_MEASURED",
  "citations":         ["<DOI/standard/dataset>", ...],
  "upstream_selftest": "<cited counts, e.g. 'matter 38/38'>"
}
```

demiurge **renders** `measurement_gate` / `absorbed` on every
consuming output (D16 cockpit honesty feature) but **never asserts or
upgrades** them — the gate state is the upstream's claim, carried
verbatim. A record without a `provenance` block is **rejected
fail-loud** (no silent default — g3 / `@F f4`).

## 5. Path convention — contract spec only, NO records here (g3)

```
exports/seams/materials_to_chip/
  schema/v0.md          ← the contract definition (this RFC §3/§4)
  records/README.md     ← records are UPSTREAM-produced; demiurge
                          carries the CONTRACT, not the data
```

Per D7 export artifacts are **producer-owned**; the producer of
material-property records is hexa-matter (SSOT hexa-lang, D17), **not
demiurge**. Therefore demiurge ships the *schema/contract* and an
empty `records/` with a README — it does **not** fabricate sample
material records (that would be exactly the over-claim g3/`@F f2`
forbids). Real records arrive when the hexa-lang materials HANDOFF
emits them against this contract (cross-session, §7).

## 6. Versioning

v0.x = draft, upstream HANDOFF shape unpinned. → **v1.0 only when**
the hexa-lang/hexa-matter materials-HANDOFF shape is pinned in a
hexa-lang session and a real record validates against it (mirror
rfc_002 §6/§7 cross-repo deferral; same honest seam discipline). No
`absorbed`/`resolved`/"wired" claim before that (g3).

## 7. Cross-repo landing

- **demiurge side (this repo — this commit)**: rfc_007 +
  `exports/seams/materials_to_chip/schema/v0.md` + `records/README.md`
  (contract spec only).
- **hexa-lang / hexa-matter side (separate repo — DEFERRED to a
  hexa-lang session, D19 idiom)**: emit material-property records at
  the materials HANDOFF against this contract; pin v1.0. Not touched
  from here (same boundary discipline as rfc_002 §7 / D19).

## 8. Scope boundary (g3 — what this RFC does NOT cover)

- **chip → component seam** (the *next* seam: netlist/GDS/STA →
  demiurge[component] SPECIFY, system BoM + thermal/EM dossier) —
  **explicitly deferred**. It depends on `rfc_004 §9` open decision
  *"whether demiurge[component] is a new top-level domain or a chip
  sub-domain"* + chain-stage granularity — a real branch point that
  gets its **own decision gate** when Phase 3's second seam is
  active. Not pre-decided here.
- Nothing is "wired": no record flows, no chip SPECIFY consumes a
  real material record yet. This RFC = the **contract design only**.

## 9. Cross-references

`design.md` D2 / D7 / D11 / D17 · rfc_002 (twin seam, chip→comb) ·
rfc_004 §4 (chain map) / §7 (Phase 3) / §9 (this was the open
"material-property typed contract schema") · CHARTER (meta-conductor,
g3) · HANDOFF §4.
