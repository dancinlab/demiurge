# RFC 008 — chain seam: chip → component (typed HANDOFF→SPECIFY contract)

> Status: **draft / design only — NOT wired** · 2026-05-19 ·
> Source: rfc_004 §4 (chained meta-pipeline) + §7 Phase 3.
> Decisions: `design.md` D2 (typed-interface), D7 (producer-owned
> export path), D11 (meta-conductor), **D21** (hexa-arch[component]
> = new top-level domain — the gate this RFC depended on), g3
> (no-over-claim — no fabricated records). Pattern mirror:
> **rfc_002 / rfc_007** (the two existing seams — same shape).

---

## 1. The seam this RFC specifies

The chain's **second seam** — chip HANDOFF feeding the new component
domain's SPECIFY (rfc_004 §4):

```
┌── hexa-arch[chip] ──┐  THIS RFC   ┌── hexa-arch[component] ──┐
│ NoC/arch→synth→P&R  │  typed      │ 부품/패키지/시스템 설계   │
│ →signoff            │  contract   │ (FEM/EM/thermal)         │
│ …SPECIFY..HANDOFF ─▶│  chip-      │ SPECIFY.. (own 7-verb)   │
│ (EDA stack absorbed)│  handoff    │ NEW top-level domain, D21 │
└─────────────────────┘  dossier    └──────────────────────────┘
```

With D21, both ends are hexa-arch domains; the seam is a typed
contract between two of its own passes (vs rfc_007 where the producer
is the external hexa-matter sibling).

## 2. Producer vs consumer (D7 / D21 — explicit)

| side | owner | role | this RFC |
|---|---|---|---|
| producer | `hexa-arch[chip]` HANDOFF | emits the chip-handoff dossier at the end of its 7-verb pass | producer-owned (D7) — hexa-arch *can* emit it (chip is an absorbed-tooling domain) |
| consumer | `hexa-arch[component]` SPECIFY (new domain, D21) | reads it to parameterise package/thermal/EM design | **this contract** |

Unlike rfc_007 (producer = external hexa-matter, hexa-arch never
emits), here the producer **is hexa-arch[chip]** — so the records are
*producible by hexa-arch in principle* (D7). They are still **absent
today** for a different, honest reason (§5).

## 3. Schema v0 (draft — the chip-handoff dossier key set)

`schema_version` = **0.x** (pre-1.0 — the chip pipeline that would
emit this is itself `GATE_B_PINNED_MET`, not measured-absorbed;
honest, g3). Units explicit. JSON for human read; wire = HXC v2
(rfc_002 §3 carrier convention).

```jsonc
{
  "interface": "hexa-arch:seam:chip->component:handoff-dossier",
  "schema_version": "0.1",
  "record_id": "<content-hash of body, HXC A12-canon hex>",
  "produced_at_utc": "<ISO-8601 UTC — set by hexa-arch[chip] HANDOFF>",

  "die": {
    "node":           "<process node string>",
    "area_um2":       "<number|null>",
    "pad_count":      "<int|null>",
    "pad_ring":       "<peripheral|area-array|null>",
    "bump_pitch_um":  "<number|null>"
  },
  "power": {
    "total_W":        "<number|null>",
    "hotspot_map_ref":"<artifact ref|null>",   // → thermal FEM
    "rails":          [{"name":"<str>","v":"<number>","i_A":"<number|null>"}]
  },
  "thermal_ctx": {
    "tjmax_C":        "<number|null>",
    "theta_jc_K_W":   "<number|null>"
  },
  "io": {
    "signal_count":   "<int|null>",
    "max_data_rate_Gbps":"<number|null>",      // → EM/SI
    "diff_pairs":     "<int|null>"
  },
  "netlist_ref":      "<artifact ref|null>",    // chip signoff netlist
  "gds_ref":          "<artifact ref|null>",
  "sta_ref":          "<artifact ref|null>",

  "provenance": { /* §4 — required */ }
}
```

`null` = "chip HANDOFF did not supply" — never a fabricated default
(g3). component SPECIFY consumes only the subset its active
package/thermal/EM model declares; unknown keys ignored
(forward-compatible, rfc_002 §6 idiom).

## 4. Provenance / no-over-claim required fields (mirror rfc_002 §4 / rfc_007 §4)

```jsonc
"provenance": {
  "producer":          "hexa-arch[chip]@<rev>",
  "absorbed":          false,           // chip EDA stack not yet
                                        // measured-absorbed (g3)
  "measurement_gate":  "GATE_OPEN" | "GATE_B_PINNED_MET" |
                        "GATE_CLOSED_MEASURED",
  "citations":         ["<tool/standard refs>"],
  "chip_pipeline_state":"<e.g. 'NoC GATE_B_PINNED_MET; synth=rfc_006 design-only'>"
}
```

`measurement_gate` reflects the **chip pipeline's real state**
(today: NoC `GATE_B_PINNED_MET`; Yosys = rfc_006 design-only; not
`absorbed`). hexa-arch renders it on every consuming output (D16
cockpit honesty) and **never upgrades** it. No `provenance` →
**rejected fail-loud** (`@F f4`).

## 5. Path convention — contract spec only, NO records here (g3, distinct reason)

```
exports/seams/chip_to_component/
  schema/v0.md          ← the contract definition (this RFC §3/§4)
  records/README.md     ← empty: see reason below
```

`records/` is empty — but **for a different honest reason than
rfc_007**. There the producer is external (hexa-matter); here the
producer **is hexa-arch[chip]**, so hexa-arch *could* emit these. It
does not yet because **no real chip HANDOFF dossier exists**: the
chip pipeline is `GATE_B_PINNED_MET` (NoC) with synth/P&R still
design-only (rfc_006). Emitting a sample dossier now would imply a
chip HANDOFF that has not measured-happened — exactly the over-claim
g3 / `@F f2` forbids. Records arrive when the chip pipeline actually
produces a measured HANDOFF (gated, cross-phase).

## 6. Versioning

v0.x = draft. → **v1.0 only when** a real chip HANDOFF dossier is
emitted by a measured chip pipeline pass and validates against this
contract (same honest cross-phase deferral as rfc_002 §6 / rfc_007
§6). No `absorbed`/`resolved`/"wired" claim before that (g3).

## 7. Cross-domain landing

- **this repo / this commit**: rfc_008 +
  `exports/seams/chip_to_component/{schema/v0.md, records/README.md}`
  (contract spec only) + `domains/component.md` (the D21 new
  top-level domain's shallow public-surface map).
- **deferred (gated, cross-phase)**: real dossier emission by a
  measured chip pipeline; component-domain internal sub-staging
  (D21 declared domain-internal, not gated here).

## 8. Scope boundary (g3 — what this RFC does NOT cover)

- No record flows; no component SPECIFY consumes a real chip
  dossier yet. Contract **design only**.
- component-domain *internal* 7-verb sub-staging (package vs system
  granularity) — **domain-internal per D21**, decided inside the
  component domain later, not here.
- This completes Phase 3's two chain seams at the **design/contract**
  level only — it does **not** claim the chain is wired or that any
  stage is absorbed (g3).

## 9. Cross-references

`design.md` D2 / D7 / D11 / **D21** · rfc_002 (chip→comb seam) ·
rfc_007 (materials→chip seam, twin) · rfc_004 §4 / §7 / §9 ·
`domains/component.md` · CHARTER (meta-conductor, g3) · HANDOFF §4.
