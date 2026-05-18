# domains/matter/ — POINTER (consumed, NOT absorbed here)

> design.md Decision 17 (supersedes D12 / D13 / D14 / rfc_005
> tombstone for hexa-matter). 2026-05-18.

The materials toolkit is **already absorbed into hexa-lang** — its
SSOT is `hexa-lang/stdlib/` (hexa-lang's own `stdlib/PLAN.md`:
"hexa-matter stdlib-only 6모듈 | 완료 | 완전 이관, .py 제거,
selftest 38/38"). demiurge does **not** own a copy of it.

Per D15 (`stdlib` is exclusively hexa-lang's; demiurge is a
consumer) + D2/D11 (meta-conductor): the **materials-synthesis chain
stage** (rfc_004 §4) is satisfied by *consuming* hexa-lang's absorbed
materials over a typed-interface seam (a material-property record,
rfc_002-style) feeding the chip stage's SPECIFY — demiurge conducts,
it does not hold the toolkit.

What happened (g3 — honest audit, nothing hidden):
- D12 absorbed a verbatim git-tracked copy here (469 files / 8 MB);
  rfc_005 §4 gate re-verified hexa-matter's selftest 38/38 under this
  tree. That parity is **real but it is hexa-lang's absorption** —
  the ④ dependents inventory then found hexa-lang had already
  completed the absorption (its stdlib/PLAN.md + 2026-05-14 plan).
- D17 reconciled the conflict: hexa-lang = SSOT, demiurge = pointer.
  The redundant copy here was `git rm`'d 2026-05-18 (recoverable from
  git history; `~/core/hexa-matter` original intact + pushed;
  hexa-lang owns the live absorption).
- `dancinlab/hexa-matter` rename/delete (rfc_005 ⑤⑥) is **NOT a
  demiurge action** — its disposition belongs to hexa-lang. CANCELLED
  from this repo's side.

See: `proposals/rfc_005_hexa_matter_absorption.md` (SUPERSEDED
banner), `design.md` D17, `hexa-lang/stdlib/PLAN.md` (the real SSOT).
