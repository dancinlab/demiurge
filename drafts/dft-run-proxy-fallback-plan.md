---
slug: dft-run-proxy-fallback
mode: auto
auto-weights: complete=2, simple=1, safe=1, std=1
created: 2026-06-01
repo: hexa-lang (~/core/hexa-lang) · worktree ~/core/hexa-lang-dft-proxyfix
---

## task brief

`hexa cloud dft-run --detach` cannot launch Li2MgH16 (a QFORGE migration-gate anchor):
the dispatch (`stdlib/cloud/dft_dispatch.hexa`) rents with `create --direct`, uploads over the
bare-IP direct endpoint, and on a proxy-only vast offer `scp` exits 255 → the instance is torn
down. Worse, a re-fire (even with a `--query` steer) re-selects the SAME broken offer (28919799),
so it loops deterministically. Confirmed class: 3 instances (38917013/38917304/38917745), all
scp-255, all clean teardowns. Full diagnosis: `hexa-lang/inbox/patches/dft-run-direct-endpoint-scp255.md`.

Fix the tool, then re-fire Li2MgH16 to a terminal QE λ·ω_log·Tc (the gate anchor).

## locked decisions (AUTO · complete-biased)

- @L1 (std): TWO stacked PRs, each <200 lines / 1 logical thing (g4). PR1 = (a) scp proxy-fallback. PR2 (base PR1) = (c) durable offer-blacklist. · assert:grep proxy
- @L2 (complete): (a) when `scp` to the `--direct` endpoint exits NON-ZERO (255 or other), resolve the PROXY endpoint (`vast ssh-port <id>` → `sshN.vast.ai:PORT`, what `hexa cloud resolve` returns) and RETRY the upload there ONCE before declaring failure + teardown. · assert:grep proxy
- @L3 (complete): (c) offer-blacklist is DURABLE / cross-invocation (a small file, e.g. `~/.hx/cloud/offer-blacklist.json`, TTL'd) — NOT process-local (each `--detach` is a fresh process, so process-local cannot stop the re-pick). After an scp-fail teardown, record the offer_id; the rent offer-search EXCLUDES blacklisted offers. · assert:grep blacklist
- @L4 (complete): a single scp-fail must not orphan — keep the existing clean-teardown; the proxy-retry happens BEFORE teardown. · assert:grep teardown
- @L5 (std): work in a dedicated worktree `~/core/hexa-lang-dft-proxyfix` off origin/main; push each PR branch immediately (d9 concurrent-worktree). · assert:file /dev/null
- @L6 (std): g5 evidence = `dft_dispatch_test.hexa` cases for BOTH fixes (proxy-fallback command shape + blacklist exclude/TTL), `hexa run <test>` PASS pasted VERBATIM. · assert:grep dft_dispatch_test
- @L7 (safe): after g5 green, self-merge each PR (`gh pr merge --squash --admin --delete-branch`) — campaign needs the unblock; base-chain PR2 on PR1. · assert:grep !forced
- @L8 (complete): after merge + `hx install` / rebuild, RE-FIRE `hexa cloud dft-run exports/rtsc/decks/Li2MgH16 --detach` (now blacklist skips 28919799 + proxy-fallback recovers scp), drive `--resume` to terminal, harvest λ·ω_log·Tc. · assert:grep qforge
- @L9 (honesty): report the QE λ·Tc verbatim (Li2MgH16 lit ~473 K@250 GPa) — do NOT fabricate or tune (d6). Migration default flip stays HELD regardless; this only makes the anchor terminal (d_qforge_engine @L4 — no forced flip). · assert:grep !fabricat

## next-action checklist

- [ ] worktree `~/core/hexa-lang-dft-proxyfix` off origin/main; pull latest (origin/main has M5.8 etc.)
- [ ] PR1 — `_dft_*` upload: on scp non-zero, resolve proxy endpoint + retry scp once; helper + call site
- [ ] PR1 — `dft_dispatch_test.hexa`: proxy-fallback command-shape case; `hexa run` PASS
- [ ] PR1 — `gh pr create --base origin/main`; g5 green → `gh pr merge --squash --admin --delete-branch`
- [ ] PR2 (base PR1) — durable offer-blacklist file + exclude in offer-search + record-on-scp-fail + TTL
- [ ] PR2 — `dft_dispatch_test.hexa`: blacklist exclude + TTL case; `hexa run` PASS
- [ ] PR2 — `gh pr create --base PR1`; g5 green → self-merge squash
- [ ] rebuild/install hexa; re-fire Li2MgH16 `--detach` → confirm 28919799 skipped + upload OK
- [ ] `--resume` poll to terminal; harvest λ·ω_log·Tc into the deck (git-durable)
- [ ] update drafts/qforge-production-migration-plan.md qa-results (Li2MgH16 PENDING→terminal, g5 verbatim) + QFORGE/QFORGE.log.md; commit explicit paths (d9)
- [ ] ship — push all branches, sidecar sync, report back

## completion criteria

- Both PRs merged to hexa-lang main with `dft_dispatch_test.hexa` g5 PASS (verbatim).
- A fresh `dft-run --detach` for Li2MgH16 does NOT re-pick 28919799 and uploads successfully
  (proxy-fallback or a non-blacklisted direct offer).
- Li2MgH16 reaches terminal QE λ·ω_log·Tc, harvested git-durable; gate qa-results updated honestly.
- If the upload still fails for a NEW root cause after the fix, report it verbatim with breakthrough
  paths (d2) — do NOT thrash or fabricate. Migration default flip remains HELD (d_qforge_engine @L4).
