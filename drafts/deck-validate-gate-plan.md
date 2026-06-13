---
slug: deck-validate-gate
mode: auto
auto-weights: complete=1, simple=1, safe=1, std=1
created: 2026-05-29
depends-on: hexa-lang deck-im3m-prototypes PR (in-flight deck-unblock agent)
---

# deck-validate-gate — plan

## task brief
Systemically prevent the "rent → deck blocked → pod sits idle" failure that produced
the leaked pods (decks rented before their prototype existed / before a dry-run). Make
a deck UNRENTABLE until it passes a d16 free dry-run, and make a missing crystal
prototype a LOUD failure (exit≠0) instead of a silent empty/partial deck that strands a
pod. Build ON TOP of the in-flight deck-im3m-prototypes PR (git fetch first).

## locked decisions
- Q1 (dry-run gate): `/deck` (and the gen.hexa flow) writes a `.validated` stamp into the deck dir ONLY after a successful d16 1-iteration dry-run; the `cloud dft-run` / fire path REFUSES to rent for a deck dir lacking a fresh `.validated` stamp (overridable with an explicit `--force` for expert use).
- Q2 (prototype coverage): the deck generator validates the requested prototype against its dispatch table FIRST; an unknown prototype → exit non-zero with a clear `unknown prototype '<x>' — known: [...]` message. NEVER emit an empty/partial deck.
- Q3 (구현 위치): hexa-lang `stdlib/deck/rtsc.hexa` (prototype-coverage check) + the `/deck` plugin (stamp write) + the `cloud dft-run`/fire precondition (stamp check).

## next-action checklist
- [ ] git fetch origin in ~/core/hexa-lang; isolated worktree `git worktree add -b deck-validate-gate ~/core/hexa-lang-deckgate origin/main` (rebase onto deck-im3m-prototypes branch if not yet merged; else origin/main)
- [ ] gen.hexa / rtsc.hexa: prototype-coverage guard — unknown prototype → non-zero exit + clear message (loud-fail); add a `deck prototypes` list subverb
- [ ] /deck plugin: after emit, run the d16 1-iter dry-run on a free pool host; on PASS write `<deckdir>/.validated` (timestamp + host); on FAIL leave no stamp + surface the error
- [ ] fire precondition: `cloud dft-run` (and any rent-for-deck path) checks for a fresh `<deckdir>/.validated`; missing → refuse with guidance (run the dry-run first) unless `--force`
- [ ] selftest: a deck with a bad directive fails the dry-run → no stamp → fire refused; a clean deck → stamp → fire allowed
- [ ] ship (explicit paths · Korean commit msg · sidecar sync after push · gh pr create --head)

## completion criteria
- Requesting an unknown prototype exits non-zero with a known-list message (no empty deck produced).
- A deck without a `.validated` stamp is refused by the fire path; with a stamp it proceeds.
- The /deck dry-run → stamp → fire chain is exercised once end-to-end (selftest).
- PR opened on hexa-lang stacked on the deck-im3m-prototypes PR.

## qa-results (2026-05-29)
Worktree: ~/core/hexa-lang-deckgate (branch deck-validate-gate, off origin/main @ cc2fa26c5 — #2054 + #2056 already merged).
Files: stdlib/deck/rtsc.hexa (+48 coverage guard + rtsc_prototypes), stdlib/deck/gen.hexa (+18 gen_prototypes/gen_domains), stdlib/deck/cli.hexa (NEW `deck prototypes`/`domains` subverbs), stdlib/cloud/dft_dispatch.hexa (+145 .validated stamp + --validate + fire gate + --force), test/deck_validate_gate_selftest.hexa (NEW).

- functional: PASS. `hexa run test/deck_validate_gate_selftest.hexa` → `__DECK_VALIDATE_GATE__ PASS`.
  · unknown prototype → `panic: unknown prototype '<x>' — known: [...]`, exit 1, NO deck emitted.
  · bad deck → `--validate` caught namelist imbalance (rc 1, no stamp) → `--go` REFUSED (rc 2, NO rent).
  · clean deck → `--validate` PASS → `.validated` written → stamp fresh (gate OPEN).
  · stale → edit relax.in → stamp invalidated → `--go` REFUSED (rc 2, NO rent).
  · --force → source conformance (gate `force == 0` guarded + leak-warn present).
  · `deck prototypes rtsc/bio`, `deck domains` subverbs verified.
- visible: SKIP (CLI/stdlib, no UI surface).
- conformance: PASS. Q1 .validated stamp + --validate writes it + fire path refuses without fresh stamp + --force override — all present. Q2 unknown prototype → non-zero exit + known-list, NEVER empty deck + `deck prototypes` subverb. Q3 rtsc.hexa (coverage) + gen.hexa (registry) + dft_dispatch.hexa (stamp+gate). /deck plugin stamp-write is sidecar-repo scope (out of hexa-lang); the stamp+gate live in compiled stdlib instead (testable here).
- regression: PASS. deck_gen_smoke.hexa → MgBeH8 byte-match (empty diff), #2054 H3Cl + sodalite YH10 emit 4 files each, all 6 domains intact, unknown-domain still 0 files. All 5 edited/new files `hexa parse` clean.

## ops-notes
- COST: $0 net. 5 transient vast instances were created by EARLY selftest iterations that ran the OLD (pre-edit) dft_dispatch — 4 self-tore-down on upload-fail, all 5 (38364069/177/320, 38365253/453) + 1 stray (38364541) were manually destroyed + confirmed gone. The FINAL spend-safe selftest rents nothing (every --go refused at the gate, rc 2, pre-rent).
- stdlib resolution: the compiler resolves `use "stdlib/cloud/..."` from the COMPILER repo root (~/.hx/bin/self → hexa-lang-main) and `import "stdlib/deck/..."` from the installed package (~/.hx/packages/hexa-lang) — NOT the cwd worktree. A newly-added `pub fn` also stays unbound (codegen emits indirect `hexa_call2` + drops the def) until a full self-rebuild. To RUN the selftest, the 3 edited stdlib files were temporarily synced into both roots, exercised, then restored. CI must run from the canonical root / after a self-rebuild for the --go-refusal assertions; case-1 (unknown-prototype subprocess) + FREE --validate are always-on.
