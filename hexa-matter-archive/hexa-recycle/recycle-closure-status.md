<!-- @authored: 2026-05-13 -->
<!-- @phase: C — recycle closure status -->

# recycle-closure-status — (a)/(b)/(c) per-verb ledger

> Mirror of `AXIS_CLOSURE_PLAN.md §8` at group depth (recycle subset).

## §1 Per-verb closure table

| Verb | (a) % | (b) gap | (c) gap |
|------|-------|---------|---------|
| recycling | 100% | Gibbs ΔS_mix for polymer recycling vs ISO 14040 LCA (B-PRC-2) | chemical-recycling pilot (Eastman / Loop Industries / Carbios) |
| recycle_n6 | 100% | n=6 lattice arithmetic (aux); in-software only — no real-world parity expected | (n/a — aux verb, in-software only) |

## §2 Group roll-up

| Category | Count | Status |
|----------|-------|--------|
| Recycle verbs | 2 (recycling, recycle_n6) | ✅ |
| (a) verb spec presence | 2/2 | 100% |
| (b) parity gates queued | 1 (B-PRC-2) | UNVERIFIED — Phase B |
| (c) OUT-OF-REPO items | 3 | DEST list enumerated |
| UNPROVEN / UNVERIFIED markers preserved | 1 (recycle_n6 aux discipline) | verbatim |

## §3 UNPROVEN / UNVERIFIED markers (verbatim)

| Verb | Marker | Source |
|------|--------|--------|
| recycle_n6 | "n=6 lattice arithmetic (aux); in-software only" — does NOT predict any recycling efficiency | AXIS_CLOSURE_PLAN.md §8.1 |
| recycling | Infinite-recycle / cradle-to-cradle: UNPROVEN at L12 thermodynamic limit; rare-earth-from-NdFeB > 5% UNVERIFIED | implied by L12 + R&D status |

## §4 The aux-verb discipline (recycle_n6)

Per `LATTICE_POLICY §1.3`, the n=6 lattice is **auxiliary, not load-bearing**.

`recycle_n6/recycle_n6.md` checks:
- σ(6) = 1+2+3+6 = 12 (sum of divisors)
- τ(6) = 4 (divisors {1, 2, 3, 6})
- φ(6) = 2 (Euler totient {1, 5})
- J₂(6) = 24 (Jordan totient)
- Master identity: σ·φ = 12·2 = 24 = 6·4 = n·τ

These are **arithmetic facts about the integer 6**. They are mathematically
provable and have nothing to do with recycling efficiency. The verb exists
to make the lattice-vs-real-limits boundary EXPLICIT — every time someone
asks "what does n=6 predict about recycling?" the answer is "nothing; see
L12 for the real limit."

`verify/lattice_arithmetic.hexa` checks the 4 identities. This is sanity,
not science.

## §5 v1.x / v1.1.x / v2 scope

| Scope | Items | Effort |
|-------|-------|--------|
| v1.x (a) | 2/2 recycle verbs | DONE pre-2026-05-13 |
| v1.1.x stretch (b) | 1 parity gate (B-PRC-2 Gibbs vs ISO 14040) | Phase B selftest |
| v2 stretch | rare-earth recycle research integration | external |
| v∞ (c) | chemical recycling at scale | external (Eastman / Loop / Carbios) |

## §6 Selftest hook (Phase B)

When `selftest/recycling_yield_audit.py` lands:
1. Parse `recycling/recycling.md` for vendor pilot data (Loop, Eastman, Carbios).
2. Confirm vendor figures are vendored AS-IS (no lattice arithmetic applied).
3. Cross-check `recycle_n6/recycle_n6.md` against `verify/lattice_arithmetic.hexa`
   for the 4 identity checks.
4. Verify L12 ΔS_mix is referenced as the recycling HARD wall (no lattice fit).

When `selftest/lattice_arithmetic_regression.py` lands:
1. Verify σ(6)=12, τ(6)=4, φ(6)=2, J₂(6)=24.
2. Verify σ·φ = 24 = 6·4 = n·τ master identity.
3. Confirm this aux verb does NOT cross-reference real recycling efficiency.

Pass criterion: 2/2 verbs consistent; aux discipline preserved.

---

*Phase C recycle closure ledger, authored 2026-05-13.*
