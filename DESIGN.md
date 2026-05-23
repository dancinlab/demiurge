# DESIGN — decision audit trail (live pointer)

> Architecture/why SSOT = [`./CHARTER.md`](./CHARTER.md) (HANDOFF.md absorbed 2026-05-22 → [`./HANDOFF.log.md`](./HANDOFF.log.md) historical) · progress SSOT = [`./PLAN.log.md`](./PLAN.log.md) (PLAN.md absorbed 2026-05-22 — forward Roadmap into CHARTER.md, κ-phase log retained in PLAN.log.md archive). This file is the live spec — the chronological decision log (every gated D-number with `picked` / `rationale` / `anchors`) lives in [`./DESIGN.log.md`](./DESIGN.log.md). D-numbers are referenced across CHARTER / GOAL / ARCH / RTSC / NUCLEAR / RFC files; the log is the SSOT for those numbers.

## How new decisions land

- One `### Decision N — <title>` block appended at the tail of `DESIGN.log.md` (never edited in place — gated, irreversible audit trail).
- Each block carries: `**picked**` (the chosen option), `**rationale**` (cited bullets · governance link), optional `**anchors**` (PR / commit / file pointers). No prose outside this shape — keep the audit terse and citation-grade.
- Cross-link every new Decision to: prior superseded D-numbers (state explicitly), the RFC it lands on (`proposals/rfc_0NN_*.md`), and the AGENTS.tape `@F` / `g*` clauses it engages.
- Governance: no over-claim (`g3`); decision text must be falsifiable (numbers cited or framed as scaffold) — not aspirational.

## Domain pointers (where the live state lives, not the audit trail)

- Architecture / why → [`./CHARTER.md`](./CHARTER.md) (HANDOFF.md absorbed 2026-05-22 — historical at [`./HANDOFF.log.md`](./HANDOFF.log.md))
- Goal (one-sentence north-star + IS/NOT) → [`./GOAL.md`](./GOAL.md)
- Progress / measured distance / cockpit κ-phase log → [`./PLAN.log.md`](./PLAN.log.md) (PLAN.md absorbed 2026-05-22 — Roadmap → CHARTER.md, κ-log retained in archive)
- Domain spec heads (ABSORPTION / ARCH / MP / NUCLEAR / POOL / RTSC) → corresponding `<DOMAIN>.md`
- Enforced governance → `AGENTS.tape`
- RFC tree → `proposals/rfc_001..0NN_*.md`

---

Historical decision blocks (D1 → D122 → …) are in [`./DESIGN.log.md`](./DESIGN.log.md).
