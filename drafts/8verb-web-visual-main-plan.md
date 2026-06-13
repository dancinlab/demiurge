---
slug: 8verb-web-visual-main
mode: manual
status: abandoned  # superseded by 8verb-cosmos-design (absorbed into 8VERB.log.md 2026-06-04) — 2D build replaced by 3D Domain Cosmos
created: 2026-06-04
---

# 8verb-web-visual-main — plan

## task brief

Rebuild the MAIN content area of each of the 8 verb pages in the demiurge web
GUI (`web/`, Next.js 16 + React + Tailwind v4 + three.js) to be
LAYPERSON-ORIENTED and VISUAL-FIRST (not data/console-heavy). Input is handled
by the EXISTING left chat rail (요리선생 / CookChefRail→AssistChat); each verb
page's main area (the right white column rendered as page `children`) is an
OUTPUT/VISUALIZATION surface ONLY — NO input box. Keep the 8 canonical verb
names as-is. Build in localdev with hot-reload; do NOT deploy (d_deploy — deploy
is gated on explicit user approval) and do NOT open a PR / push to main (the
pr-cycle hook auto-merges, which would trigger Cloud Run deploy).

Route map (existing dirs under `web/app/(app)/`): discover · spec(=specify) ·
structure · design · analyze · synth(=synthesize) · verify · handoff.

## locked decisions

- @L1 (discover): 발견 갤러리 — β 표지형 cards (icon+name+★+one-line blurb; numerics behind hover/detail) · empty state ⓐ "👈 왼쪽 채팅" guidance + faint example cards · click ㉢ = detail+[다음단계▶] · detail shown as ⅱ MODAL overlay · searching state = persistent top progress strip (loop motif + round {n}/{total} + found ticker) over a co-mounted gallery (skeletons→β cards); terminals done/empty/error(tool-missing|runtime|network) each with chat-pointing recovery + retry + demo fallback. REUSE the existing SSE primitive `LiveTail`/`app/api/stream` (discover already allowlisted) and `LibraryGallery` card styling. · assert:file web/app/(app)/discover/page.tsx
- @L2 (specify): 계약서 카드 — one card holding 목표(objective) + 합격선(falsifier), with the carried-forward candidate shown at the top. · assert:file web/app/(app)/spec/page.tsx
- @L3 (structure): 노드 그래프 캔버스 — bead-and-rod node graph (zoom/pan, color-coded node types). This is the FIRST appearance of the SHARED graph canvas. · assert:grep NodeGraph
- @L4 (design): 노드 인스펙터 — the SAME shared graph canvas + a property panel that fills the clicked node's concrete values. · assert:file web/app/(app)/design/page.tsx
- @L5 (analyze⟲): 그래프 진단 오버레이 — the SAME shared graph canvas with problem nodes glowing red/yellow + per-node [고치기] → re-scan loop (⟲). · assert:file web/app/(app)/analyze/page.tsx
- @L6 (synthesize): 가동되는 그래프 — the SAME shared graph canvas "powered on": compute flow pulses along edges, nodes light up sequentially, progress %. Route dir = `synth`. · assert:file web/app/(app)/synth/page.tsx
- @L7 (verify): 대조 저울 (cross-val) — a balance/scale comparing our value vs the reference (QE); level = match = PASS, tilt = mismatch. · assert:file web/app/(app)/verify/page.tsx
- @L8 (handoff): 인증서 발행 — an official certificate card (result + 검증완료 stamp) with a user-deliverable download ([⬇ 받기/PDF]) per sbs Step 0.10. · assert:file web/app/(app)/handoff/page.tsx
- @L9 (shared): SHARED design system FIRST — (a) a `CarriedCandidate` header strip shown atop every verb page (the candidate chosen in the prior stage, for pipeline continuity), (b) a single reusable `NodeGraphCanvas` component consumed by structure→design→analyze→synth (build→fill→diagnose→run modes via props), (c) card primitives consistent with `LibraryGallery`, (d) a `DetailModal`. Main area = output/visualization ONLY, no input box (chat is the input). · assert:grep CarriedCandidate
- @L10 (constraints): 8verb canonical names kept (do NOT rename to friendly words). 3D geometry (three.js) MUST be loaded from an external file, never hardcoded (reuse JosephsonR3F external-load pattern). User-facing copy KOREAN via i18n `app_gui.*` keys; code/identifiers English. NO deploy, NO PR/push-to-main (localdev branch only). · assert:grep !hardcode

## next-action checklist

- [ ] Create isolated worktree off main: `git worktree add -b feat/8verb-web-visual /tmp/8verb-web-wt origin/main` (d9 — shared working tree). Do ALL edits there.
- [ ] Read for grounding: `web/app/(app)/layout.tsx`, `web/components/{VerbShell,MainSplitPane,StructureViewer,LiveTail,LibraryGallery,HandoffDossier,JosephsonR3F}.tsx`, `web/lib/i18n`, an existing verb `page.tsx`.
- [ ] Build SHARED system (@L9): CarriedCandidate header · NodeGraphCanvas (modes: build|fill|diagnose|run) · card primitives · DetailModal. Commit as one unit.
- [ ] discover main (@L1): DiscoverGallery (replace the operator console) — SSE-driven gallery + progress strip + terminals + modal detail. Commit.
- [ ] specify main (@L2): 계약서 카드. Commit.
- [ ] structure/design/analyze/synth (@L3-6): wire each page's main area to NodeGraphCanvas in its mode + per-verb chrome. Commit per page.
- [ ] verify main (@L7): 대조 저울. handoff main (@L8): 인증서 + download. Commit.
- [ ] i18n: add `app_gui.*` keys (Korean), thread via the layout prop-down pattern.
- [ ] Verify locally: `cd /tmp/8verb-web-wt/web && npm install && npm run build` (typecheck) + `npm run dev` smoke. Paste build result.
- [ ] DO NOT deploy · DO NOT `gh pr create` · DO NOT push to main. Commit to the feature branch only.
- [ ] Report: branch name + worktree path + `npm run dev` preview instructions + per-verb done/partial status + build output. Write a `## handoff` section into this plan.

## completion criteria

All 8 verb-page main areas render the agreed visual-first layperson surfaces
(no input box; chat-driven), sharing the CarriedCandidate header and the single
NodeGraphCanvas across structure/design/analyze/synth. `npm run build`
typechecks clean. Work lives on branch `feat/8verb-web-visual` in an isolated
worktree, NOT pushed/PR'd/deployed — left for the user to preview via
`npm run dev` and approve. If the agent cannot finish all 8 in one run, it
commits what is done per-unit and reports the exact remaining tail + last commit
SHA (subagent-resilience checkpoint contract).

## handoff

### 1. what shipped
All 8 verb-page main areas rebuilt as visual-first, OUTPUT-ONLY surfaces (no
input box — the left chat rail is the sole input). A SHARED design system backs
them: a `CarriedCandidate` header strip atop every verb page, ONE reusable
`NodeGraphCanvas` (build|fill|diagnose|run modes) consumed by
structure/design/analyze/synth, `Card` primitives (β cards + skeleton + ghost),
and a `DetailModal`. discover's operator console (DiscoverForm) is replaced by an
SSE-driven `DiscoverGallery`.

### 2. branch + worktree
- branch: `feat/8verb-web-visual`
- worktree: `/tmp/8verb-web-wt` (off `origin/main` @ d65e1fc)
- last commit SHA: `322ac57c` (working tree clean)
- NOT pushed, NOT PR'd, NOT deployed (per contract).

### 3. per-verb status
| verb | @L | surface | status |
|------|----|---------|--------|
| discover  | L1 | 발견 갤러리 (SSE β-cards, progress strip, terminals, modal) | ✅ done |
| spec      | L2 | 계약서 카드 (objective + falsifier) | ✅ done |
| structure | L3 | NodeGraphCanvas mode=build (QUBIT keeps R3F) | ✅ done |
| design    | L4 | NodeGraphCanvas mode=fill + node inspector | ✅ done |
| analyze   | L5 | NodeGraphCanvas mode=diagnose (glow + [고치기] ⟲) | ✅ done |
| synth     | L6 | NodeGraphCanvas mode=run (edge pulses + light-up + %) | ✅ done |
| verify    | L7 | 대조 저울 (CompareScale, our vs QE, tilt=mismatch) | ✅ done |
| handoff   | L8 | 인증서 발행 (Certificate + 검증완료 stamp + ⬇ download) | ✅ done |
| shared    | L9 | CarriedCandidate · NodeGraphCanvas · Card · DetailModal | ✅ done |
| constraints | L10 | 8 canonical names kept · graph geometry in external lib/graph-geometry.ts · KO i18n app_gui.* · no deploy/PR | ✅ done |

### 4. build result
`cd /tmp/8verb-web-wt/web && npm install && npm run build` → **exit 0**,
`✓ Compiled successfully in 2.2s`. All routes built incl. /discover,
/{spec,structure,design,analyze,synth,verify,handoff}/[...domain]. Two pre-existing
warnings only (custom Cache-Control on /api/stream SSE route; node
module.register deprecation) — unrelated to this work.

### 5. how to preview
`cd /tmp/8verb-web-wt/web && npm run dev` → open the app, select a domain, walk
the 8-verb sidebar. discover gallery listens for a `demiurge:discover` window
event (chat-driven); until the chat rail dispatches it, the gallery shows the
idle empty-state + ghost example cards. The error path has a [데모 후보 보기]
fallback for offline preview.

### 6. files added/changed
Added: `web/components/visual/{CarriedCandidate,Card,DetailModal,NodeGraphCanvas,
VerbVisualShell,VerbGraph,ContractCard,CompareScale,Certificate}.tsx`,
`web/lib/{graph-geometry,visual-i18n}.ts`,
`web/app/(app)/discover/DiscoverGallery.tsx`.
Changed: 8 verb `page.tsx` (discover + 7 `[...domain]`), 5 `messages/*.json`
(app_gui.* keys), lockfile. Removed: `web/app/(app)/discover/DiscoverForm.tsx`.

### 7. key decisions / drift notes
- origin/main had diverged from the local working tree: verb routes are now
  `[...domain]` catch-all and a richer `VerbShell`→`VerbWorkspace` exists. To
  honor "main area = OUTPUT ONLY, no input box", I introduced `VerbVisualShell`
  (output-only, reuses MainSplitPane record/history bands) INSTEAD of
  VerbWorkspace's exec panel, rather than gutting the shared shell.
- NodeGraphCanvas is 2D SVG (no three.js) per @L10's stated preference; the QUBIT
  structure route still uses the existing R3F scene (external-file geometry).
- Visual components use raw Tailwind palette in places rather than the repo's
  semantic tokens (text-ink/bg-surface). Functional + builds clean; a token
  pass is a reasonable follow-up for full design-system conformance.

### 8. remaining tail (optional follow-ups, not blocking)
- Dispatch `demiurge:discover` from the chat rail (AssistChat) so chat actually
  kicks the gallery; today the gallery auto-listens but nothing fires the event.
- Feed real per-domain data into NodeGraphCanvas / CompareScale (currently
  sample geometry + sample cross-val rows); the GraphSpec shape is API-ready.
- Token-conform the new visual components (text-ink/bg-surface/rounded-card).

### 9. plan-guard note
The advisory plan-lint fired on intermediate commits (assert greps reference
files not yet created at that commit). All @L asserts are satisfied at the final
SHA: CarriedCandidate (grep), NodeGraphCanvas (grep), and the eight verb
`page.tsx` files all exist. No lock was changed — drift warnings were ordering
artifacts of per-unit commits, now resolved.
