# R4 Stage 1 Enforcement — Swift Codable Lock

**Date**: 2026-05-21
**Constitution**: v1.4.0 R4 (RTSC absorbed=true twin-error invariant)
**SSOT cross-refs**:
  - `.specify/memory/constitution.md` §R4 (Stage 1 TODO line)
  - `RTSC.md` §8.9 (5-criteria gate · SOLE 정의) · §8.10 (Nb honest correction)

## What landed

Three new Swift files under `cockpit/`:

1. **`Sources/DemiurgeCore/Models/RTSC5GateEvaluation.swift`** — 5-gate
   evaluation struct (`Codable, Equatable, Sendable`) with explicit
   `GateState` enum (`PASS` / `FAIL` / `SKIPPED`) per RTSC.md §8.9 (a)–(e)
   gate; `Aggregate` enum (`ALL_PASS` / `ANY_FAIL` / `INSUFFICIENT`);
   `evidence: [String]`; `rtsc_absorbed_eligible: Bool` (producer-set,
   cross-checked by carrier-record decoder); explicit snake_case
   `CodingKeys` mapping. Also exposes a static
   `deriveAggregate(...)` helper for producer-side aggregate computation.

2. **`Sources/DemiurgeCore/Models/MaterialAttestationRecord.swift`** —
   New combined attestation carrier (domain · verb · kind · stamp ·
   producer · measurementGate · absorbed · gateType · provisional ·
   `rtsc_5_gate_evaluation: RTSC5GateEvaluation?` · scopeCaveats ·
   citations). Custom `init(from:)` enforces R4 Stage 1 invariant at
   decode time:
     - `domain == "rtsc"` AND `absorbed == true` AND `rtsc_5_gate_evaluation == nil` → `DecodingError.dataCorrupted` (cites R4)
     - same + `aggregate != .allPass` → reject (cites ALL_PASS requirement)
     - same + `aggregate == .allPass` BUT `rtsc_absorbed_eligible == false` → reject (producer-intent mismatch)
   non-rtsc domains (e.g. `domain == "energy"`) are entirely
   unconstrained (no over-reach).

3. **`Tests/DemiurgeCoreTests/RTSC5GateEnforcementTests.swift`** — 5
   XCTest cases:
   - `testNbAttestationDomainRTSCRequires5GateField` — loads
     `exports/material_attestation/nb_bcs_v1/...json`, peeks
     `domain="rtsc" + absorbed=true + rtsc_5_gate_evaluation=nil`,
     asserts `MaterialAttestationRecord` decoder THROWS. Test passes;
     this is the migration trigger (R4 invariant catches the namespace
     exploit at decode time).
   - `testFutureRTSCAttestationRequiresAllPass` — synthetic JSON with
     `aggregate=ANY_FAIL` → decoder MUST throw. ✓
   - `testNonRTSCDomainNoConstraint` — `domain=energy` +
     `absorbed=true` decodes fine without 5-gate. ✓
   - `testRTSCAttestationAllPassRoundTrip` — happy-path 5/5 PASS
     round-trip is lossless. ✓
   - `testDeriveAggregateHelper` — `deriveAggregate(...)` semantics. ✓

**Verify**:
  - `swift build --target DemiurgeCore` → clean.
  - `swift test --filter RTSC5GateEnforcementTests` → 5/5 PASS.

## Immediate consequence — existing Nb attestation record is now INVALID

The landed `exports/material_attestation/nb_bcs_v1/rtsc_attestation_nb_bcs_20260521T111656Z.json`
record has `domain: "rtsc"` + `absorbed: true` + NO
`rtsc_5_gate_evaluation` field. Under the new `MaterialAttestationRecord`
Codable invariant, this JSON cannot be decoded into the new type — it
throws `DecodingError.dataCorrupted` with rationale "R4 invariant
violation: domain=rtsc + absorbed=true requires rtsc_5_gate_evaluation
field".

This is by design — the test
`testNbAttestationDomainRTSCRequires5GateField` *asserts the throw* as
the Stage 1 migration trigger. The Nb attestation predates R4
ratification; the Stage 1 enforcement is the moment doctrinally
incompatible records become structurally incompatible.

**Scope note**: this enforcement currently lives at the
`MaterialAttestationRecord` decode site only. Other Swift record types
(`MeasurementRecord`, `MaterialVerdictRecord`, `EnergyVerifyRecord`)
are unchanged — the new type is the *carrier for future RTSC
attestations*, NOT a retroactive replacement.

## Migration plan — two paths

### Path A — re-emit Nb attestation with `rtsc_5_gate_evaluation` field

Re-run `nb_bcs_attestation_producer.py` (or its successor) with the
5-gate field populated:

```json
"rtsc_5_gate_evaluation": {
  "a_synthesis_replicated": "SKIPPED",
  "b_tc_above_270k": "FAIL",          // Tc=9.25 K << 270 K
  "c_ambient_pressure": "SKIPPED",
  "d_independent_lab_replication": "SKIPPED",
  "e_measurement_oracle_parity": "PASS",  // BCS universal ratio 2Δ(0)/(k_B·Tc) parity rel_err < 5%
  "aggregate": "ANY_FAIL",            // (b) FAIL → ANY_FAIL by §8.9 AND-semantics
  "evidence": ["(b) Tc=9.25 K (Nb LTS) ≪ 270 K → FAIL", "(e) BCS ratio 3.5168 vs 3.5278 · rel_err 0.31% < 5% → PASS"],
  "rtsc_absorbed_eligible": false
}
```

**Honest consequence**: under §8.9, Path A makes the 5-gate result
`ANY_FAIL` (because (b) Tc<270K) — which is *incompatible* with
`absorbed: true`. The decoder would still reject the record (the
`absorbed: true` cannot stand once the 5-gate verdict is honestly
recorded). So Path A is NOT a fix — it's a forced demotion to
`absorbed: false`. The original `absorbed: true` flip was honest *for
BCS parity*, NOT for RTSC.

### Path B — rename domain from `"rtsc"` → `"lts"` (honest reclassification)

Re-emit the attestation with `domain: "lts"` (or `"superconductor_lts"`).
This:
  - Removes the namespace exploit (Pattern 1) at its root — Nb is
    *not* RTSC, it's LTS (Tc=9.25 K).
  - Preserves the legitimate `absorbed: true` for the BCS universal
    ratio parity (the *(e)*-gate-style measured-oracle parity is the
    real basis for the flip — `absorbed: true` is honest *as an LTS
    BCS attestation*, just not as an RTSC one).
  - Makes `rtsc_5_gate_evaluation` field unnecessary — non-rtsc
    domains aren't constrained by R4.
  - Matches RTSC.md §8.10's honest narrative: "Nb attestation is for
    Nb (LTS, Tc=9.25 K) — a *rtsc.md-domain* material, NOT a room-
    temperature SC. […] absorbed=true here means: 'BCS universal ratio
    is experimentally vindicated for Nb to <5%' — NOT 'Nb is a RTSC'."

### Recommendation — Path B

Path B (domain rename `"rtsc"` → `"lts"`) is the **recommended**
migration. Rationale:
  1. Pattern 1 (namespace exploit) is the root cause R4 was ratified
     to lock; renaming the domain removes the exploit at its root
     rather than papering over with a SKIPPED-heavy 5-gate field.
  2. The `absorbed: true` flip is legitimate *in the LTS namespace*
     (§8.10 narrative); a rename preserves the honest signal without
     dragging RTSC semantics into it.
  3. R4 leaves non-rtsc domains unconstrained — `lts` attestations
     don't need a 5-gate field, matching their actual semantics.
  4. The companion `PAPERS/sample-nb-bcs-absorbed/main.tex` abstract
     will also need its "first RTSC-domain absorbed=true" phrasing
     corrected; a domain rename keeps the correction surface narrow
     ("LTS BCS validation"), versus Path A which still leaves
     "RTSC" in the record domain.

**Flag for future PR** (not in scope for this Stage 1 enforcement
landing):
  - Re-emit `nb_bcs_v1/rtsc_attestation_*.json` as
    `nb_bcs_v1/lts_attestation_*.json` with `domain: "lts"`.
  - Update `nb_bcs_attestation_producer.py` to emit `domain: "lts"`.
  - Update `PAPERS/sample-nb-bcs-absorbed/main.tex` abstract phrasing
    ("first LTS BCS-parity absorbed=true" or similar — never "first
    RTSC absorbed=true").
  - Optionally: leave the rtsc-namespaced file in place as
    *historical artifact* with a `MIGRATED_TO.md` pointer (don't
    delete provenance) — but the *active* attestation lives under
    `lts/`.

## Stage 2 (deferred)

R4 row notes a Stage 2: paper-compile-time hook that checks any
"RTSC absorbed=true" phrasing in `PAPERS/*/main.tex` against a
companion attestation record's 5-gate state. Out of scope for this
PR — Stage 1 (Swift Codable lock) lands the structural guarantee that
underpins Stage 2's runtime check.
