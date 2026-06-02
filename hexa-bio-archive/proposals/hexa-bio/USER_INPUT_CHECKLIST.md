<!--
@canonical-origin: proposals/hexa-bio/USER_INPUT_CHECKLIST.md
parent_proposal:   proposals/hexa-bio/zenodo_v2_deposit_prep_2026_05_16.md
metadata_draft:    proposals/hexa-bio/zenodo_v2_metadata_draft.json
governance:        AGENTS.tape g9 (external-contact-defer) + g10 (no-proposal-for-deferred)
-->

# Zenodo v2 — USER_INPUT_CHECKLIST

> **STATUS: DRAFTED — READY FOR USER REVIEW — DEPOSIT NOT EXECUTED. User owns the SEND step (g9 external-contact-defer).**
>
> Agent's deliverable ends at this checklist plus the sibling
> `zenodo_v2_deposit_prep_2026_05_16.md` proposal and
> `zenodo_v2_metadata_draft.json` draft. Per AGENTS.tape g10
> (no-proposal-for-deferred-items) the agent will NOT recommend, urge,
> schedule, or propose the deposit as a "next step" in any end-of-turn
> summary. `USER_ACTION_REQUIRED.md` at the repo root is the single
> canonical index for deferred external items; this file is the v2
> deposit's gate list.

---

## How to use this checklist

1. Open `zenodo_v2_metadata_draft.json` alongside this file.
2. For each item below, decide the value yourself (none of these are
   software-derivable).
3. Patch the JSON `PLACEHOLDER_*` fields with your decisions.
4. Only after **all 7 items are resolved AND the consent checkbox at the
   bottom is ticked**, may you (the user) proceed with a deposit.
5. The agent does NOT execute step 4. The agent does NOT run any deposit
   command. The agent does NOT read or store the Zenodo API token.

---

## The 7 items

### [ ] 1. ORCID iD

- Decision required: do you want to link an ORCID iD to this deposit?
  - ORCID is public-by-design. Linking is permanent in Zenodo's record.
- Action: provide ORCID iD string (`0000-XXXX-XXXX-XXXX`) or explicit
  decision to deposit without ORCID.
- Patch target: `metadata.creators[0].orcid` in
  `zenodo_v2_metadata_draft.json`.
- PII note: ORCID maps to a public scholarly identity. Use deliberately.

### [ ] 2. Creator byline name + email + affiliation

- Decision required: which name + email appears as the deposit's author
  of record?
  - The repo's `CITATION.cff` lists `M. Park` with `arsmoriendi99@proton.me`;
    the user-global memory references `mk55911@proton.me`. These differ.
  - Affiliation must be a real entity or "independent researcher" — agent
    does not fabricate affiliations.
- Patch targets: `metadata.creators[0].name` / `.affiliation` /
  (Zenodo also accepts `.email` at the API level, not in metadata.json
  schema — the email is configured at the Zenodo account level, not in
  this file).
- PII note: byline email is indexed by search engines via the deposit
  page; choose deliberately.

### [ ] 3. Final title

- Decision required: long form or short form?
  - Long (default in JSON):
    `hexa-bio v2 — 5-axis core + 4-axis expansion-layer record + 15 sub-axes + cross-axis bridges + disease-portfolio case studies (in-silico simulator-consistency)`
  - Short alternative:
    `hexa-bio: HEXA-Bio Molecular Toolkit — expansion-layer snapshot, 2026-05-16`
- Patch target: `metadata.title`.

### [ ] 4. Final keyword set

- Decision required: trim the 16-keyword draft to ~10 per Zenodo
  guideline, or keep as-is.
- Patch target: `metadata.keywords` (array).
- Honesty: do NOT add keywords that imply clinical / therapeutic /
  regulatory scope (g8 / f2 forbidden surface).

### [ ] 5. License (Apache-2.0 vs CC-BY-4.0)

- Decision required: choose one.
  - Apache-2.0 — matches repo `LICENSE`; permissive software licence;
    grants patent licence; allows commercial use.
  - CC-BY-4.0 — Zenodo academic default; appropriate for paper-text-only
    deposits; less appropriate for code (no patent grant).
- Patch target: `metadata.license`.
- Note: changing a Zenodo deposit's licence post-publication is generally
  not possible; decide deliberately.

### [ ] 6. Related identifier — v1 DOI (if v1 was actually deposited)

- Decision required: did you deposit v1?
  - v1 prep (`proposals/hexa-weave/hexa_weave_zenodo_deposit_prep_2026_04_28.md`)
    states "no deposit performed this cycle. Deposit gated on explicit
    user approval." Agent has NO on-file evidence v1 was subsequently
    deposited.
- Action:
  - If yes — provide the v1 DOI (`10.5281/zenodo.XXXXXXX`). Patch
    `metadata.related_identifiers[0].identifier` and keep relation
    `isNewVersionOf`.
  - If no — delete the entire `related_identifiers` entry; the v2
    deposit stands alone.
- Patch target: `metadata.related_identifiers`.

### [ ] 7. Zenodo API token — NEVER in metadata.json

- Decision required: where will your Zenodo personal API token live at
  deposit time?
- **Required policy** (token rules):
  - Token MUST live in the `$ZENODO_TOKEN` environment variable only.
  - Token MUST NOT appear in `zenodo_v2_metadata_draft.json`.
  - Token MUST NOT be committed to git.
  - Token MUST NOT be pasted into any chat with the agent.
  - The agent will refuse to read or store the token; the agent will
    not execute the deposit command.
- Generation: at https://zenodo.org/account/settings/applications/ →
  Personal access tokens → New token with `deposit:write` scope. Treat
  like an SSH key.

---

## Consent gate

- [ ] **I, the user, have reviewed all 7 items above, patched
      `zenodo_v2_metadata_draft.json` with my decisions, confirmed the
      token lives only in `$ZENODO_TOKEN` env, and consent to deposit.**

---

## After consent

This file's role ENDS at the consent checkbox above. Any subsequent
deposit command, network call, DOI mint, ORCID linkage, or curation step
is the user's action — not the agent's. The agent's deliverable
(this checklist + the proposal + the JSON draft) is COMPLETE per
AGENTS.tape g10 once committed in-repo, and `USER_ACTION_REQUIRED.md`
remains the single canonical index for any deferred external item.
