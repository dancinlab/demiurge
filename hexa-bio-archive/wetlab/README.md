# wetlab/ — wet-lab handoff substrate (Phase 1, public templates only)

**Status**: Phase 1 seed landed 2026-05-12 cycle-30++++++.
**Scope**: PUBLIC templates only. Sensitive contracts / signed MTAs / IRB
submissions / IND drafts do NOT live here (see `data/.gitignore` + Phase 2
plan below).

> Per [AGENTS.md](../AGENTS.md) "External-contact deferral policy": agents
> DRAFT these templates; the user sends/signs/pays externally. All deferred
> items are flagged with `STATUS: draft-ready, deferred for user send`.

---

## 디렉토리

| Dir | Purpose | Content type |
|---|---|---|
| [`cro/`](cro/) | CRO RFP templates per axis | drop-in send-ready RFPs |
| [`sop/`](sop/) | Standard Operating Procedures | wet-lab protocols (open-research) |
| [`mta/`](mta/) | Material Transfer Agreement templates | NIH UBMTA + custom MTAs |
| [`ip/`](ip/) | Invention disclosure templates | pre-patent disclosure drafts |
| [`regulatory/`](regulatory/) | Pre-IND / IRB prep docs | FDA / 식약처 submission templates |
| [`data/`](data/) | (gitignored) Anonymized read-out results | post-CRO data archives |

---

## Cross-refs

- [`AGENTS.md`](../AGENTS.md) "External-contact deferral policy"
- [`USER_ACTION_REQUIRED.md`](../USER_ACTION_REQUIRED.md) — single canonical index for deferred items
- [`CLOSURE_RESIDUAL_BACKLOG.md`](../CLOSURE_RESIDUAL_BACKLOG.md) §C handoff destinations

---

## raw_91 honest C3

- Templates here are STARTER drafts; customize before any use
- All execution decisions are out-of-scope for this repo per the
  external-contact deferral policy in AGENTS.md
