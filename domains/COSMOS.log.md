# COSMOS — log

Append-only history sister of `COSMOS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-05 — PIVOT: COSMOS rebased onto the `.demi` SSOT (§10) — directive "우리는 .demi잖아"

User directive: ".demi 기준으로 모두 작동되게". Investigated `.demi` and found it is the repo's canonical machine-readable domain SSOT — this SUPERSEDES the DOMAINS.tape/@link/<D>.md sourcing patchwork (incl. the membership filter + NEXUS→@link I'd just landed). Documented `.demi`-canonical architecture as `COSMOS.md` §10; implementation dispatched.

- [x] **Discovery**: `domains/INDEX.demi` (230 lines, D83) = "canonical machine-readable 19-domain graph", loaded by the hexa demi CLI (`stdlib/demi/domain_catalog.hexa` + `domain_composer.hexa`, ported DemiParser→DomainLoader). Each `[<id>]` carries `prerequisites=[...]` (composition graph, D82), `facets.scale` (rung ∈ molecular·device·component·system), `canvas_mode`, `keywords`, `label`. Per-domain `domains/<id>.demi` (cellrun Phase-A dialect) carries `[cell.<verb>]` sections with `gate_default`/`absorbed_default` = the HONEST verify-state SSOT.
- [x] **Mapping decided (§10)**: node membership ← INDEX.demi `[id]` presence (by-construction, no exclude list) · composition edges ← `prerequisites` (RETIRES NEXUS→@link) · rung ← `facets.scale` · verify-state ← cell gate flags (RETIRES prose-parse + matter ledger) · 8-verb surface ← `<id>.demi` cells.
- [x] **Honest deltas recorded**: (1) node-set CHANGES from ~50 DOMAINS.tape product domains to ~19 INDEX.demi category domains (cleaner composition cosmos; product domains out-of-graph until registered in INDEX.demi — data, no code). (2) rung is 4 (`facets.scale`), not the earlier ad-hoc 6 (원자·물질·바이오·화학·칩·시스템); a finer split = add `facets.rung` to INDEX.demi (data-driven), not a hardcoded keyword table. User picked ① 완성도 = full re-base.
- [x] **Superseded**: the membership filter (`c229f2c7`) + NEXUS→@link (`d87a2185`) landed but are now moot under §10 — marked superseded in COSMOS.md milestones (kept on branch, harmless; §10 replaces the whole sourcing).
- [x] **IMPL LANDED** `feat/8verb-cosmos` (4 commits, tip `0f757d46`): `web/lib/demi.ts`(pure parser) + `demi.server.ts`(fs) mirror `domain_catalog.hexa`/`domain_composer.hexa`. `buildCosmos()` now assembles from `.demi`: nodes=INDEX.demi `[id]` (membership by-construction, `COSMOS_EXCLUDE` RETIRED) · edges=`prerequisites` (`@link`/`readLinkEdges` RETIRED) · rung=`facets.scale` via `SCALE_TO_RUNG` (`Rung` union changed 6→4 = molecular·device·component·system; keyword classifyRung RETIRED) · verify-state from cell `gate_default`/`absorbed_default` (prose-parse + matter ledger RETIRED). Ladder→4 bands · 3D default shapes molecular→supercell/device→die/component→coil/system→orbit · i18n 5 locales updated. BUILD exit 0 · cosmos.test 43✓ (ufo prereqs antimatter/fusion/rtsc · 8VERB/COSMOS/QFORGE absent · ufo rung=system · all-GATE_OPEN→⚪) · geometry-3d-parse 19✓. 2 real bugs fixed mid-verify (multi-line `scope_caveats` trim corruption · molecular supercell `nx` param drop).
- [x] node count: BEFORE 25 (DOMAINS.tape roster) → AFTER 20 (INDEX.demi `[id]`). Expected shrink — clean high-level composition graph, not the product roster. All 20 INDEX.demi nodes have a matching `<id>.demi` on the branch (0 missing-manifest ⚪).
- [x] honest: no `.demi` field expresses 🔵 formal / 🔴 falsified yet, so a cell emits only ⚪/🟢 today (states kept in union for rollup + forward-compat, NOT fabricated). INDEX.demi/`<id>.demi`/NEXUS.tape NOT deleted; DOMAINS.tape retained (still resolves `repoDataRoot()`, no longer a cosmos source). `/tmp/cosmos-wt` untouched · no deploy.
- [ ] NEXT: preview the `.demi` cosmos (20 clean nodes) · then bio/chem faithful-3D (§9.1) attaches to the `.demi` node · optionally enrich INDEX.demi facets if a finer rung split is wanted (data, not code).

## 2026-06-05 — IMPL membership filter + NEXUS→@link landed · bio/chem faithful-3D research (web+arxiv+AlphaFold)

Two parts this turn: (1) implemented the two §7/§7.1 fixes on `feat/8verb-cosmos`; (2) ran 3 parallel research threads to fill the bio/chem faithful-3D path, written into `COSMOS.md` §9.1.

- [x] **IMPL §7 membership filter** → `feat/8verb-cosmos` `c229f2c7`: `COSMOS_EXCLUDE` set (20 Category-C names) + `isCosmosDomain()` in `cosmos.ts`, applied in `assembleCosmos()` (domains + edge endpoints). The 8VERB·COSMOS·NOVEL-TOOL·POOL·QFORGE*·YOSYS·… leak is closed.
- [x] **IMPL §7.1 NEXUS→@link** → `d87a2185`: cosmos reads `@link <from> --<verb>--> <to>` from root `DOMAINS.tape` (`readLinkEdges`/`parseLinkEdges`), NOT `NEXUS.tape`; 24 `@link` rows migrated from NEXUS into `DOMAINS.tape` under a g67 header. BUILD_EXIT=0 · TEST_EXIT=0 "ALL cosmos smoke checks passed" (exclude-absent + RTSC-present + no Category-C edge endpoint + parseLinkEdges). Caveats: 1 lowercase-stdlib provider edge (e13) + conceptual c1–c6 not mapped (no domain pair); NEXUS.tape not deleted (repo-wide retirement separate). DOMAINS.tape tape-lsp `@domain`/`@link` "unknown @d" lint = pre-existing roster-convention noise (hexa-lang/anima same), non-blocking.
- [x] **RESEARCH (§9.1)** — 3 parallel agents, all cited, APIs verified LIVE:
  - (a) Structural data: bio domains DO carry real ids in `.log.md`/`exports/` — AGA-RX (SFRP1 UniProt Q8N474=314 res · Dkk1-LRP6 PDB 3S2K · AR-LBD 2AM9 · WAY-316606 PubChem CID 16727102=C18H19F3N2O4S2/29 heavy) · SENOLYX (BCL-xL PDB 3ZLR=290 res). Honest gaps: GENE-EDIT/RNA-THERAPY/ORGANOID/PROTEIN-FOLD + all 4 chem are generic "sampler" stubs with NO entity → stay ⚪ (do not invent).
  - (b) Viewer: AlphaFold DB's GUI = Mol* (molstar). HYBRID design — keep cosmos overview as native R3F meshes (avoid 2nd WebGL context, browsers cap ~8), mount Mol*/`pdbe-molstar` (MIT) on `/d/<domain>` in its own canvas (dynamic ssr:false) with pLDDT coloring. Replaces the CSS-3D `StructureViewer.tsx` placeholder. 3Dmol.js (BSD-3) lighter chem fallback. Avoid molstar-react (stale)/NGL (RCSB-removed).
  - (c) APIs verified: RCSB `data.rcsb.org/rest/v1/core/entry/{PDB}` · AlphaFold `alphafold.ebi.ac.uk/api/prediction/{ACC}` + `/files/AF-{ACC}-F1-model_v4.cif` · UniProt `rest.uniprot.org` · PubChem PUG REST `+ SDF?record_type=3d`.
  - (d) **Licensing (load-bearing)**: AlphaFold DB structures = CC-BY-4.0 → product-safe WITH attribution; PDB = CC0; AF3 weights = NON-COMMERCIAL → COSMOS CONSUMES pre-computed AF-DB, never runs AF3. Viewers MIT/BSD = clean.
  - (e) NOVEL probe: prose→structure resolver cascade (AF-DB → ESMFold → ESM3/RFdiffusion → text→graph diffusion); tiers 3–4 flagged "generated·illustrative" (d6). Refs: AF3 Nature 2024 · ESMFold Science 2023 · RFdiffusion Nature 2023 · Mol* NAR 2021 · 3M-Diffusion arXiv:2403.07179 · ProteinGPT arXiv:2408.11363.
- [x] Updated milestones: bio/chem promotion (research done, surface counts) · Mol* viewer on detail page · NOVEL resolver cascade.
- [ ] NEXT (implementation, separate turns): surface AGA-RX/SENOLYX counts into `<D>.md` (cheapest win → auto-promote) · then Mol* detail viewer · then resolver cascade. Isolated `/tmp` worktree PR · build-green · no deploy.

## 2026-06-05 — DOC-prep: membership rule + NEXUS retirement + bio/chem audit + GUI guardrails (no code)

User: "도메인 폴더에 관련 아닌것들도 있어 — NOVEL-TOOL 이런거 물질 아닐꺼야" + "GUI 구현 실수 안 하게 문서 잘 처리해둬" + "NEXUS.tape 폐기 — DOMAINS.tape 으로만 정리, anima/hexa-lang 참고". Documentation-only turn — NO GUI code touched. All findings written into `COSMOS.md` (§7·§7.1·§8·§9) as the SSOT the implementation agent reads first.

- [x] **Membership leak (§7)** — ground-truthed on `feat/8verb-cosmos` (tip d38f5907): node-set = ENTIRE `DOMAINS.tape` roster via `listDomains()`→`assembleCosmos()`, **NO exclusion filter**. Non-material/meta/tooling domains LEAK as bogus `materials` nodes (`classifyRung` honest-default). Confirmed leakers in curated root tape: `8VERB`,`COSMOS`. Full `domains/DOMAINS.tape` (70 rows) adds `NOVEL-TOOL·POOL·DEMIURGE·QFORGE{,-PROCESS,-PERF,-FEATURE}·YOSYS·CLI+COCKPIT·ABSORPTION·GOAL·XPRIZE·INBOX·HEXA-PORT·NUMB·MP`. Wrote the inclusion RULE + named `COSMOS_EXCLUDE` set (20) + `isCosmosDomain()` predicate spec + test contract. Fix = HIGHEST-priority milestone.
- [x] **NEXUS.tape RETIRED (§7.1)** — per user + commons g70-guard hint. The old `NEXUS.tape` (260-line `@X … :: reuse-edge` lattice) is retired; the cross-domain reuse/composition graph now rides INSIDE `DOMAINS.tape` as `@link <from> --<verb>--> <to>  # evidence` rows (canonical ref = `hexa-lang/DOMAINS.tape` g67 intra + g68 cross-project; `anima` same). Cosmos currently reads `NEXUS.tape` (`readNexusEdges`/`parseNexusEdges`/`NEXUS_PATH_PARTS` + refs in cosmos.ts/.server.ts/.test.ts/cosmos page/d-page). Documented the 2-part migration: (a) code → read `@link` from DOMAINS.tape; (b) data → migrate NEXUS reuse-edges to `@link` rows (demiurge DOMAINS.tape currently has ZERO `@link` rows, so decomposition would go empty if NEXUS vanishes before the data migration). Also flagged: NEXUS edges reference Category-C `NOVEL-TOOL` as a provider → edge endpoints must inherit the §7 exclude filter.
- [x] **§8 GUI guardrails** — anti-mistake checklist (membership · fidelity≠badge honesty · no-fabrication · geometry=data · rung manifest · reuse-no-dup · edges=@link · no-deploy · shared-worktree-PR · build-green).
- [x] **§9 Bio/Chem audit** — most bio/chem docs are prose stubs with NO raw structural counts (PDB id ≠ buildable count) → honestly stay stylized helix/molecule + ⚪ badge, auto-promote when a real residue/formula count lands. User notes real bio progress (AGA-RX/SENOLYX/CURE) lives in `.log.md`+`exports/`; to promote, surface a structural count into `<D>.md` or a descriptor. Documented per-rung trigger (bio=residues→turns, chem=formula→atoms).
- [x] Added 3 open milestones: membership filter (⚠ highest) · NEXUS→@link migration · surface bio/chem counts.
- [ ] NEXT (implementation, separate turn, isolated `/tmp` worktree PR · build-green · no deploy): §7 filter + §7.1 NEXUS→@link migration are the two REAL fixes (non-material leak + retired-SSOT read). bio/chem promotion is data-entry, lower priority.

## 2026-06-05 — bg: overview hover highlight

User "bg go" on the hover follow-up. Background agent in its OWN isolated worktree (`/tmp/cosmos-hover-wt` off origin/feat/8verb-cosmos) so the running preview on `/tmp/cosmos-wt` was untouched; fast-forward push to the shared branch.

- [x] Hover affordance → **`d38f5907`** (ff `5fcf71e6..d38f5907`, single file `CosmosScene.tsx`): pointer-over a node = tint lerp 40%→white + scale ×1.22 (instanced rung-shape path, via existing `setColorAt`/`setMatrixAt`+needsUpdate, zero rebuild) / brighten + scale ×1.18 + emissiveIntensity 0.7 + opacity 1 (sphere-glyph fallback) + hovered label → pure white, slightly larger. Hover state lifted into `Scene`, one `onHoverName` feeds both paths; added `onPointerMove` on the instanced mesh so moving between instances of the SAME mesh re-targets (R3F `onPointerOver` only fires on mesh enter). Restores on pointer-out. build + `tsc --noEmit` GREEN.
- [ ] caveat: not browser/fps-verified (shared dev server intentionally untouched); correctness build/type-verified, per-instance zero-rebuild path = no expected perf regression. Agent cleaned its worktree+branch.

## 2026-06-05 — all-go: overview per-rung 3D + auto-promotion pipeline

User "all go" on the two next-candidates. Foreground-sequential (shared worktree d9), worktree `/tmp/cosmos-wt`.

- [x] #1 overview per-rung 3D → **`275d5b75`**: constellation nodes now draw their rung-typed shape (atom=lattice·materials=supercell·bio=helix·chem=molecule·chip=die·system=coil; faithful HEX-N6/RTSC/QUBIT keep real shape) instead of generic spheres. Perf: `InstancedMesh` grouped-by-shape (≤6 draw calls, not ~37), low-poly merged unit geometry per shape (`overviewParamsForShape`+`mergeBuiltModelToUnit`), per-instance verify-state color. Guard `OVERVIEW_GLYPH_FALLBACK_THRESHOLD=60` (>60 nodes OR `hardwareConcurrency<4` → sphere glyph) + per-shape merge-fail fallback. Click→focus/hover/Y-band layout intact, labels+badges unchanged. build+tsc GREEN. caveat: fps not browser-measured (static analysis ≤6 draws + per-node Html badges = the cost at density); hover-tint is follow-up.
- [x] #2 auto-promotion pipeline → **`5fcf71e6`**: `geometry-3d-parse.server.ts` (`parseDocToDescriptor` pure + disk wrapper) scans `domains/<D>.md` for real structural numbers by rung (lattice a/b/c·σ·τ·φ triple · residue/seq→helix turns · chain→strands · formula→atom count · R/D/H/κ/winding → coil) each with matched-line+lineno provenance. Resolver priority in `geometry-3d.server.ts`: (1) hand-authored json → (2) in-memory auto-parsed faithful → (3) rung stylized. Faithful coverage AUTO-grows from docs, zero new files. HONEST: audited all 177 docs → only RTSC (`a=2.984` `rtsc.md:983`) + UFO (`D=6.0m` `ufo.md:48`) carry clean geometry, both already hand-authored at priority-1 → 0 NEW net promotions (the honest result; parser independently re-derived UFO's numbers, validating it). Fixed 2 false positives mid-build (software "N-layer", `σ·τ=48` product) by requiring crystal context / full triple. 19/19 parser tests + build GREEN.
- [ ] caveat: no unit-test framework (Playwright e2e only) → parser test runs via a tiny ESM resolve hook; tsc typecheck is the primary green gate.

## 2026-06-05 — 6-rung scale ladder + per-rung 3D vocabulary (atom·material·bio·chem·chip·system)

User: cosmos must span 원자·물질·바이오·화학·칩·시스템 — bio & chem rungs were missing. Foreground agent, worktree `/tmp/cosmos-wt`.

- [x] Rung model extended 4→6: `atom · materials · bio · chem · chip · system` (Y −10..10 bands). `classifyRung()` manifest keyword/roster-driven (d4, no per-domain hardcode). bio (10): GENE-EDIT·RNA-THERAPY·ORGANOID·PROTEIN-FOLD·SENOLYX·AGA-CURE·OA-CURE·PERIO-CURE·RETINA-CURE·IVD-CURE (+`-CURE` keyword fallback). chem (4): ELECTROCAT·PHOTOREDOX·CO2-CAPTURE·GREEN-NH3.
- [x] New 3D shape primitives in `geometry-3d.ts`: `helix`(bio α/double-helix) · `molecule`(chem ball-and-stick) · `die`(chip pad-grid wafer) · `coil`(system Helmholtz pair). `buildSymbol` rung-glyph map → 6 rungs. Added `stylized` flag + single-source `isStylizedDescriptor()` (badge layer + renderer both delegate).
- [x] System 3 retrofit orbit→`coil` keeping real numbers+provenance (FUSION R=1.280m/a=0.424m/AR=2.99 `fusion.md:140` · UFO D=6.0m/H=1.6m/×6 `ufo.md:48` · ANTIMATTER B=5T/U₀=10V/d=5mm `antimatter.md:11`).
- [x] HONEST: NO faithful bio/chem 3D — those docs are template stubs with no extractable structural numbers (AGA-RX/SENOLYX cite PDB IDs 3ZLR/4QVX but no raw residue/atom counts; AAV T-number generic). They render rung-typed STYLIZED 3D (helix/molecule), desaturated + ⚪/🟡 "데이터없음/검증필요" badge. No numbers invented. Fidelity=data-presence ≠ verify badge.
- [x] build GREEN (`npm run build` ✓); cosmos smoke test 20/20 incl. new bio/chem classification + `-CURE`→bio. Commits `e55a365e` (6-rung model + i18n 5 locales + CosmosScene) + `de2c66a4` (primitives + 3 descriptors), pushed (56cc3973..de2c66a4). NO PR/merge/deploy (d_deploy). next.config.ts dev-only allowedDevOrigins left uncommitted.
- [ ] caveat: overview constellation keeps lightweight sphere glyphs per node (perf); rung-typed 3D shape renders on FOCUS (node click) via FocusModel — reachable per rung, not all ~30 at once.

## 2026-06-05 — real per-domain 3D data: faithful models beyond HEX-N6/RTSC (ANTIMATTER·FUSION·UFO)

Resumed the rate-limit-stalled milestone (foreground, isolated worktree `/tmp/cosmos-wt`).

- [x] 3 new faithful 3D nodes via external `web/public/models/<DOMAIN>/model.3d.json` descriptors (priority-1 manifest path — NO `.ts` source change, geometry stays external data per d4·@L10·D5):
  - ANTIMATTER → `orbit` (ring electrode + trapped particle + 3 motional bodies) from Penning trap B=5T·U₀=10V·d=5mm (`domains/antimatter.md:11`)
  - FUSION → `orbit` (plasma torus ring + magnetic axis) from FreeGS R=1.280m·a=0.424m·AR=2.99·κ=1.358 (`domains/fusion.md:140`)
  - UFO → `orbit` (disc rim + 6 equiangular solenoids + 3 CMG) from lenticular D=6.0m·H=1.6m·×6 (`domains/ufo.md:48`)
- [x] All radius/count values are true ratios from the docs; full source numbers preserved verbatim in each descriptor's `params` (with `src` provenance field) for the inspector panel.
- [x] HONEST: starter-scaffold domains (GRAPHENE·PEROVSKITE·METAMATERIAL·AEROGEL·GENE-EDIT·…) have NO lattice/geometry numbers → correctly stay ⚪ stylized symbols (no fabrication). Fidelity = data-presence only, NOT the verify badge (`deriveState()` untouched; faithful model never implies "verified").
- [x] build GREEN (`npm run build` exit 0, all 3 JSON validated vs `validateDescriptor`). Commit `56cc3973` on `feat/8verb-cosmos`, pushed (`2520a8cb..56cc3973`), NO PR/merge/deploy (d_deploy). Worktree removed.
- [ ] caveat: shape vocab has no torus/coil-pair primitive → all 3 map to `orbit` (schematic with true dims, not CAD mesh). cosmos-graph geom domains (CLOAK·SRR·wormhole·warp) live only as untracked files on `main`, out of branch scope.

## 2026-06-04 — domain-ized: design + P1–P5 build re-homed into COSMOS

- [x] Created the COSMOS domain (🌌) — the web GUI is a first-class system spanning all domains; 8VERB stays the CLI-pipeline domain. The perfected design (D1–D7) is now `COSMOS.md` (living architecture snapshot), no longer buried in 8VERB.log.md.
- [x] Design perfected via /sbs manual: vision (chat→compose→verify→build) + scale ladder (atom→system) + composition (NEXUS edges) + honest verify-state model + 3D-first + D1–D7 all LOCKED. Originally absorbed into 8VERB.log.md (2026-06-04), now the authoritative copy lives here.
- [x] Built P1–P5 foreground-sequential on branch `feat/8verb-cosmos` (off origin/main), each phase build-green + pushed, NO deploy/PR/merge (d_deploy):
  - P1 `web/lib/cosmos.ts` — composition graph (NEXUS+DOMAINS+verdict → nodes/edges/rung/verify-state) + `decompose()` · SHA 87b88c86
  - P2 `web/lib/geometry-3d*.ts` + `DomainModel3D.tsx` — descriptor (procedural|glb|symbol) + builders; JosephsonR3F de-hardcoded into a descriptor (@L10 closed) · SHA 56df36c3
  - P3 `/cosmos` MAIN page — 3D constellation, rung axis, focus decompose, filter toggles · SHA ed431957
  - P4 8 verb node surfaces (3D-first per §6) + `CarriedCandidate` header + stage breadcrumb · SHA 4e4be994
  - P5 wiring — chat→`demiurge:focus` event + `?target=` deeplink + `/d/[domain]` detail + node→work-page nav · SHA 89eceb62
- [x] Honest verify-state: only HEX-N6 🔵 + RTSC 🟢 carry proven badges; all other nodes ⚪ until a real verdict lands (deriveState auto-picks, no code change). Never paint a projection green (d6).
- [x] Preview server live on mini:3008 (key-wired, allowedDevOrigins for tailscale/LAN); UFO journey reachable (`/cosmos` → focus UFO → `/d/UFO` → verb page).
- [ ] P6 completeness hardening — design-conformance audit + i18n `app_gui.*` + semantic-token conform + empty/error/loading states + a11y + responsive (NEXT).
- [ ] superseded: 2D `8verb-web-visual` build (branch `feat/8verb-web-visual`, plan abandoned) — a few components reused.

