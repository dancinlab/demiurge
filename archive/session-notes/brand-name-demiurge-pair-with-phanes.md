# incoming note: brand-name-demiurge-pair-with-phanes — proposed mythic brand for hexa-arch, paired with `dancinlab/phanes`

> **id**: `brand-name-demiurge-pair-with-phanes` · **opened**: 2026-05-19 KST · **resolved**: 2026-05-19 KST · **status**: `resolved — accepted as design.md D23/D24/D25 (rename executed same day, hand-fix Naming history banner added; see design.md tail)`
> **source**: downstream session working on `dancinlab/phanes` (the SaaS sibling that just got branded **Phanes / 파네스**, `~/core/phanes` private). hexa-arch was raised separately as "이름 필요해".
> **scope**: brand mark for `~/core/hexa-arch` (the meta-conductor / universal technical-design architecture program). Not the codebase, not the 7-verb spine, not the absorption pipeline — just the public-facing name.
> **decision authority**: hexa-arch session (this note is a handoff, not a fait accompli).

---

## Proposal

**Brand mark: `Demiurge` / 한글: `데미우르지`** (alt classical: `데미우르고스`).

Lore: in Plato's *Timaeus*, the Demiurge is the divine craftsman who
shapes pre-existing matter according to eternal Forms (*eidos*) to
produce the ordered cosmos. Universal designer · the maker who composes.
Maps 1:1 onto hexa-arch's stated act — the **meta-conductor** that
consumes typed *forms* (hexa-matter, hexa-bio) and shapes them through
the 7-verb pipeline (명세→구조→설계→해석⟲→합성→검증→인계) into
designed reality across chip · cern · antimatter · rtsc · space · brain
· energy · component · …

## The cosmogony (verbatim from chat — "이거 그대로")

```
🏛 Palantir-급 결승 (검증된 클린 4)

   Phanes (드러내는 자)  ──▶  Forms (관념)  ──▶  Demiurge (빚는 자)  ──▶  built world
   파네스                       에이도스                  데미우르지                    설계된 코스모스
   = 빛이 forms 를 끌어냄                          = forms 를 물질로 짜내림
   (already chosen for SaaS)                       (← hexa-arch ?)
```

The pairing is **classically grounded**, not retrofitted: Phanes (Orphic
primordial revealer) and Demiurge (Platonic craftsman) are sibling
cosmological figures — the revealer brings forth Forms; the craftsman
shapes matter to those Forms. Two dancinlab brands, one continuous
cosmos.

## Provenance — collision search (g3: evidence, not assumption)

5 web-search rounds across naming candidates (2026-05-19). **Web-verified
clean** survivors only:

| Candidate | 한글 | Status |
|---|---|---|
| **Demiurge** | **데미우르지** (4 syl) / 데미우르고스 (5 syl) | ✅ no AI/SW collision found |
| Architekton | 아르키텍톤 (5 syl) | ✅ clean — "chief builder" / root of "architect" |
| Konstrukt | 콘스트룩트 (5 syl) | ✅ clean — German "construct" (cold tone vs dancinlab warmth) |
| Poiesis | 포이에시스 (5 syl) | ⚠️ marginal — 1998 design firm (not AI/SW) |

**Burned in our adjacent space** (search-evidenced — do NOT propose):
Daedalus (trydaedalus.ai · daedalus.de · …) · Talos (trydaedalus product
line) · Hephaestus (Hephaestus Technologies; also internal `forge`
collision) · Vulcan (Vulcan Technologies 2025 reg-tech AI) · Eidos
(eidos.ai · Parmenides EIDOS) · Bauplan (2025 $7.5M seed AI/data
platform) · Tekton (Tekton CI/CD + LambdaClass Tekton agent platform) ·
Techne (Techne AI) · Aletheia/Phanes/Manteia/Pythia/Apeiron/Mantic
(burned in prior phanes-naming rounds — see `~/core/phanes/design.md`
Decision 2 risk notes).

## Why this is a handoff (not a fait accompli)

hexa-arch session owns the brand decision — the phanes session just
spotted the mythic pairing and ran the collision searches. Filing here
because:

1. hexa-arch repo had `M ARCH.tape` mid-session when this was raised —
   no business of mine to touch top-level SSOT from a sibling session
   (shared-worktree-hazard pattern).
2. Inbox/notes is the established cross-session handoff mechanism
   (mirrors hexa-lang's `inbox/notes/` and `inbox/patches/` discipline).
3. The hexa-arch session's `design.md` D1–D22 audit trail is the right
   home for an actual `Decision N — brand = Demiurge` lock, with the
   3+ rationale bullets and provenance pointers back to this note.

## Suggested next step (hexa-arch session's call)

If accepted:

1. Lock as `design.md` `### Decision N — brand mark = Demiurge`
   (picked + rationale 3+ bullets, can quote this note).
2. Update README header (`📐` → consider sun-disc-with-compass or a
   geometric mark; emoji choice = sub-decision).
3. Update the identity block in `.specify/memory/constitution.md`
   (kind / signature / brief) with the Demiurge lore.
4. Update `GOAL.md` first line to weave the name in (the "한 문장" stays;
   the brand-token comes alongside).
5. Cross-link `~/core/phanes/README.md` "## Naming" section once locked
   (currently it records phanes' own name + alts; can add
   "Sibling: Demiurge / 데미우르지 → dancinlab/hexa-arch").

If rejected / want alternative: simply reply with the chosen mark and
this note can be archived (rationale + collision data still useful for
the next candidate).

## Sister handoffs already filed (for context)

phanes filed **2 upstream patches to hexa-lang**, both **RESOLVED SSOT
same-day (2026-05-19)** — the downstream→upstream pipeline is
demonstrably working in this session:

- `phanes-hx-data-dir-per-tenant-isolation` → `hx_data_dir()` helper
  landed (`HX_DATA_DIR > $HOME/.hx/data > ".hx/data"`).
- `phanes-pluggable-verifier-oracle-for-drill-loop` → in-loop verifier
  callback landed in `drill_run` (`verifier_cmd / verifier_timeout_s /
  verifier_authoritative`, DRILL_VERIFIER audit, DrillResult fields).

(Both pending binary promote per the 22c27a05 deploy pattern.)
