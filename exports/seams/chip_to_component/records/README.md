# records/ — intentionally empty (g3, distinct reason from rfc_007)

This directory holds **no records by design**.

Unlike `materials_to_chip/records/` (empty because the producer is
the *external* hexa-matter sibling, D7/D17), here the producer **is
hexa-arch[chip]** — so hexa-arch *could* emit these dossiers in
principle (D7 producer-owned).

It does **not** yet, for an honest reason: **no measured chip HANDOFF
exists**. The chip pipeline is `GATE_B_PINNED_MET` for the NoC and
**design-only** for synth/P&R (rfc_006 Yosys not yet implemented).
Emitting a sample chip→component dossier now would imply a chip
HANDOFF that has not measured-happened — exactly the over-claim that
g3 / `AGENTS.tape @F f2` forbids.

Records arrive when the chip pipeline actually produces a **measured**
HANDOFF dossier that validates against `../schema/v0.md` (gated,
cross-phase — rfc_008 §5/§6).

State: **GATE_OPEN** — seam designed, nothing wired, zero records.
No `absorbed`/`resolved`/"wired" claim (g3).
