# COSMOS — log

Append-only history sister of `COSMOS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-05 — 🚀 DEPLOYED to production (demiurge.dancinlab.org) + overview back to round glyphs

User: 배포 + 별자리는 원으로 다시 (per-rung overview shapes too busy). Both done.

- [x] Overview simplification `f4709cfa`: `canRenderShapeGlyphs()` forced → false, so the cosmos overview constellation renders SIMPLE round sphere glyphs again (per-rung 3D shapes made the wide view too busy). Detail surfaces (/d/<domain>, /sample DomainModel3D cards) KEEP the high-quality RTSC-grade shapes. build exit 0.
- [x] MERGED `feat/8verb-cosmos` → `main` via PR #597 (merge commit, NOT squash — preserved 34-commit history; mergeable=CLEAN, only 2 intentional deletions = old 2D JosephsonR3F/SlotViewers). main tip `019caabf`.
- [x] DEPLOYED: `gcloud builds submit --config cloudbuild.yaml --project dancinlab --substitutions=_REGION=us-central1,_SERVICE=demiurge-web` (Docker → Artifact Registry → Cloud Run). Build `95e161eb` = SUCCESS. New Cloud Run revision **demiurge-web-00043-d4z** at https://demiurge.dancinlab.org (also https://demiurge-web-2n7kup3fpa-uc.a.run.app).
- [x] LIVE smoke: `/` 200 · `/sample` (public) 200 · structure proxy alphafold Q8N474 200 (1.4s) · pdb 3ZLR 200 (1.5s).
- [ ] ⚠ PROD ISSUE (non-fatal · 1 of 9 sample cards): `/api/structure?source=pubchem` → 502 because PubChem PUG REST returns **503** for the Cloud Run shared egress IP (rate-limits UA-less / shared-IP requests). Proteins are fine; only the WAY-316606 chem MOLECULE card fails. FIX = commit the WAY-316606 3D SDF as a STATIC asset (`web/public/models/…`) so the molecule viewer never hits PubChem at runtime (+ optional UA header/retry on the proxy). Needs a follow-up redeploy.

## 2026-06-05 — HIGH-QUALITY rung 3D shapes (RTSC-coil grade) + web-research-backed R3F look

User: 단별 3D 퀄리티를 과거 Swift RTSC 코일(HtsCoilGeometry) 수준으로 + web research. Web-research agent (cited) → R3F high-quality recipes; impl agent landed it.

- [x] RESEARCH (cited): R3F/three.js polish recipes — shared look-good base (drei `Environment preset="studio"` IBL + ACES tone map + `ContactShadows` + `Bounds`/`Center` auto-frame), nested-translucent-shells (depthWrite:false + ascending renderOrder + spaced radii + ONE `MeshTransmissionMaterial` hero), `HelixCurve extends THREE.Curve`→`TubeGeometry` windings, `InstancedMesh` lattices, vertex-color ribbons, `RoundedBox` die, perf (frameloop demand · WebGL ~8-16 context cap · drei 10.x = R3F9/React19 line). Sources: three.js TubeGeometry/transparency, drei Environment/MeshTransmissionMaterial/Instances docs.
- [x] RTSC reference confirmed: Swift `HtsCoilGeometry` (git history blob) + `hts_solenoid_proxy_v1.geo.json` = 6 concentric rings (bore #2A2A2A op0.15 · support #7A7A7A · HTS REBCO #D4A53A · jacket #B87333 · shield #C0C0C0 op0.45 · cryostat #5C7A99 op0.25), 120 turns, 200mm.
- [x] LANDED `feat/8verb-cosmos` `247e4297`(geometry+scene) + `798a6d5e`(lazy-mount). `web/lib/geometry-3d.ts`: coil→6 translucent shells + dense 120-turn `TubeGeometry` REBCO winding + ONE `MeshTransmissionMaterial` cryostat; helix→smooth ribbon-tube + N→C vertex gradient (+double-helix base-pairs); molecule→32×32 spheres + CPK element colors + oriented bonds; lattice/supercell→instanced + quaternion-oriented bonds; die→`RoundedBox` metallic + gold pad grid; junction/orbit higher-seg + physical clearcoat. `BuiltModel` extended with optional material hints (no domain-name branching, d4). New `DomainModel3DR3F.tsx` scene: Environment studio + ambient+key(castShadow)+fill + ContactShadows + Bounds/Center + OrbitControls(damping, autoRotate hover-gated) + AdaptiveDpr.
- [x] PERF (9-card /sample): `DomainModel3D` lazy-mounts its `<Canvas>` via IntersectionObserver (rootMargin 300px) + unmounts far-offscreen → live WebGL contexts track on-screen cards (under the cap); `frameloop="demand"` + hover-gated autoRotate = off-screen cards ~0 rAF; CSS-3D placeholder until mount. CosmosScene overview glyphs also pick up oriented/scaled bonds (no IBL/shadow added to the many-node canvas).
- [x] VERIFIED: fresh `npm run build` exit 0 (39 pages, `/sample` builds) · cosmos.test exit 0 · geometry-3d-parse exit 0 · `tsc --noEmit` clean. drei helpers all present in 10.7.7. Browser-only: actual pixel quality confirmed in-preview.
- [ ] NEXT (optional): a pLDDT legend on protein cards; `<View>`-based single-canvas if card count grows; deploy.

## 2026-06-05 — PUBLIC /sample showcase (no login) + AlphaFold version fix

User: "그냥 샘플페이지 만들어줘 · 이것저것 샘플로 다양하게 볼수있는" — everything was behind the `/signin` gate (middleware PROTECTED regex), so nothing was viewable without an account.

- [x] LANDED `feat/8verb-cosmos` `062bbe58`(page)+`af860758`(AF fix): `web/app/sample/page.tsx` — a PUBLIC showcase (`/sample` is NOT in the middleware PROTECTED regex → ungated; `/api/*` is excluded from middleware too). One scrollable gallery: ① the 6-band rung 3D shapes (atom lattice · materials supercell · bio helix · chem molecule · chip die · system coil) via `DomainModel3D` (stylized ⚪); ② the 3 REAL structures via `MolViewer`/3Dmol — AGA-RX SFRP1 (AlphaFold), SENOLYX BCL-xL (PDB 3ZLR), WAY-316606 drug molecule (PubChem SDF). Tailwind tokens fixed (`bg-card`→`bg-surface`).
- [x] AlphaFold version fix `af860758`: the proxy used `model_v4.cif` but AlphaFold DB moved to **v6** (v4/v5 now 404). The `/api/structure` alphafold path now resolves the REAL `cifUrl` from the prediction API `…/api/prediction/<id>` (origin-checked) and falls back to a v6 template — robust to future version bumps.
- [x] VERIFIED live: `/sample` → HTTP 200 (public, no login) · all 3 structure sources 200 (alphafold Q8N474 · pdb 3ZLR · pubchem 16727102) · build exit 0 (39 static pages incl `○ /sample`). Browser confirms the actual 3D render.
- [ ] NEXT (optional): add an OrbitControls hint / per-card loading shimmer; link `/sample` from the marketing page; deploy.

## 2026-06-05 — BUILD BLOCKER RESOLVED: pdbe-molstar → 3Dmol.js (production build green)

User picked ① 완성도: swap to 3Dmol.js. Done INLINE (rate-limit storm — no agents).

- [x] LANDED `feat/8verb-cosmos` `05f7e452`: `npm uninstall pdbe-molstar` (drops `molstar@5.8 → h264-mp4-encoder@1.0.12`, the `require("fs")` culprit) + `npm install 3dmol@2.5.5` (BSD-3). Rewrote `components/MolstarInner.tsx` to a 3Dmol.js mount: `$3Dmol.createViewer` → fetch from the SAME `/api/structure` proxy → `addModel(data, "cif"|"sdf")` → style per source (alphafold = cartoon coloured by B-factor=pLDDT confidence · pdb = spectrum cartoon · pubchem = ball-and-stick molecule) → zoomTo/render; `clear()` + innerHTML reset on cleanup. `MolViewer.tsx` (dynamic ssr:false) + `route.ts` proxy + `demi.ts` facets all UNCHANGED.
- [x] VERIFIED: a FRESH `next build` now exits 0 — "✓ Compiled successfully 2.3s · ✓ Generating static pages (38/38)", NO h264/`Can't resolve 'fs'` error (grepped clean). cosmos.test exit 0. Preview molecule SDF API `?source=pubchem&id=16727102` → HTTP 200 (real WAY-316606 SDF proxied). `/d/WAY-316606` route 307 (login gate).
- [x] Honest: filename `MolstarInner.tsx` is now a misnomer (it's 3Dmol, not Mol*) — kept to avoid churn; comments updated. pLDDT colouring is approximated via 3Dmol's B-factor gradient (roygb 50–90), not Mol*'s exact 4-band AlphaFold legend — same data channel, simpler legend. The production build is now deploy-capable (the §9.1b viewer goal met with the lighter lib).
- [ ] NEXT: browser-confirm the 3Dmol render (protein fold + molecule) in-preview; then optionally a pLDDT legend + deploy-prep.

## 2026-06-05 — chem molecule viewer + CURE registration LANDED · ⚠ surfaced a real build blocker (molstar→h264)

User picked ① 완성도: chem molecule viewer + CURE family. The dispatched agents BOTH died on a server-wide rate-limit storm (0 tokens) → I did the work INLINE in foreground (resilience protocol: stop fan-out, sequential commit-per-unit).

- [x] LANDED `feat/8verb-cosmos` 3 commits: `6aac5615`(molecule viewer infra) + `7bcf1c5e`(INDEX.demi data) + test commit. (a) `web/app/api/structure/route.ts` extended: `source=pubchem&id=<CID>` → PubChem `SDF?record_type=3d` (3D→2D fallback, CID regex `^[0-9]{1,9}$`); (b) `demi.ts` parses `facets.pubchem` → `node.structure={source:"pubchem",id}` (precedence uniprot>pdb>pubchem); (c) `MolstarInner` loads SDF format for pubchem; (d) `/d/[domain]` molecule caption + PubChem CID/public-domain attribution.
- [x] INDEX.demi data (nodes 22→28): `[way-316606]` chem node (`facets.pubchem="16727102"`, prereq=aga-rx — AGA-RX's lead compound C18H19F3N2O4S2; PubChem CID serves 3D SDF HTTP 200, verified by direct curl). CURE family REAL-DATA-ONLY: `[aga-cure]`(facets.uniprot Q8N474, reuse AGA-RX) · `[ivd-cure]`(facets.pdb 3ZLR, reuse SENOLYX) · `[oa-cure]`/`[perio-cure]`/`[retina-cure]` (NO structure facet → honest ⚪, none invented — η_neo modeling has no PDB per §9.1).
- [x] cosmos.test exit 0 (way-316606 pubchem CID · aga-cure alphafold Q8N474 · ivd-cure pdb 3ZLR · oa/perio/retina-cure NO structure + ⚪). The molecule + CURE LOGIC is verified.
- [x] ⚠ **SURFACED a real BUILD BLOCKER (NOT from the chem work)**: a FRESH `npm ci`/`npm install` then `next build` fails — `Module not found: Can't resolve 'fs'` from `h264-mp4-encoder@1.0.12`, pulled by `pdbe-molstar@3.12 → molstar@5.8 → h264-mp4-encoder` (bare `require("fs")` in the CLIENT bundle, Turbopack can't resolve). REPRODUCES on the Mol* tip `aeb5c126` with the same fresh node_modules → it's the **Mol* dependency** (prior turn), not the chem data; the earlier "build exit 0" was a stale/cached install. `next dev` (preview) is unaffected. FIX: (a) swap `pdbe-molstar`→`3dmol` (BSD-3 · §9.1b's named lighter alt · no molstar/h264 · reads PDB/mmCIF + SDF) — RECOMMENDED, fixes build + lighter; or (b) browser `fs:false` fallback for the molstar chunk. MUST fix before deploy.
- [ ] NEXT: resolve the build blocker (recommend 3Dmol.js swap) so the production build + Mol*/molecule render both work, THEN deploy-prep.

## 2026-06-05 — Mol* real-fold viewer on /d/<domain> (§9.1b) — landed (agent died on rate-limit AFTER pushing)

User picked ① 완성도: AlphaFold-grade real protein fold on the detail page. The dispatched agent pushed its work to `feat/8verb-cosmos` then hit a SERVER-WIDE rate-limit (not usage cap) before reporting; I verified + landed from the orphaned worktree.

- [x] LANDED `feat/8verb-cosmos` `babf1fa4`(facets→node.structure parse) + `aeb5c126`(Mol* viewer + route + dep). Added `pdbe-molstar@^3.12.0` (MIT). `web/components/MolViewer.tsx` (dynamic `ssr:false` wrapper) + `MolstarInner.tsx` (mounts molstar in a ref div, loads structure, AlphaFold/pLDDT preset, disposes on cleanup) + `web/app/api/structure/route.ts` (server proxy: alphafold `AF-<id>-F1-model_v4.cif` · pdb `<id>.cif`, strict id regex SSRF guard, cache header, 502 on upstream fail).
- [x] `.demi`-canonical structure ref (§10): INDEX.demi `[aga-rx] facets.uniprot="Q8N474"` (SFRP1, AlphaFold-DB) + `[senolyx] facets.pdb="3ZLR"` (BCL-xL, RCSB experimental); `demi.ts` parses → `node.structure = {source:"alphafold"|"pdb", id}`. `/d/[domain]/page.tsx`: renders `<MolViewer>` when `node.structure` present (+ CC-BY/CC0 attribution caption + layperson "실제 단백질 접힘 · 색=예측 신뢰도(pLDDT)" note), else the existing R3F `DomainModel3D`. Overview unchanged (no 2nd WebGL context).
- [x] VERIFIED from the orphaned worktree (`/tmp/cosmos-mol-wt`, tip aeb5c126, pdbe-molstar installed): `npm run build` BUILD_EXIT=0 "✓ Compiled successfully" + "✓ Generating static pages (38/38)" — the `dynamic ssr:false` import did NOT break SSR/static gen. cosmos.test TEST_EXIT=0. Browser-only bar: the actual 3D fold render needs a real WebGL browser (user confirms in-preview); headless verifies build + route + facet-parse.
- [x] HONEST: only aga-rx (alphafold) + senolyx (pdb) carry a structure ref → only they show Mol*; all other nodes keep the existing R3F model. AlphaFold prediction shown WITH pLDDT confidence coloring (not presented as experimentally solved). AGA-RX = AlphaFold predicted; SENOLYX 3ZLR = experimental. CC-BY (AlphaFold) / CC0 (PDB) attribution rendered.
- [ ] NEXT (optional): chem molecule viewer (WAY-316606 SDF via 3Dmol/Mol*) · CURE-family registration · bundle-size check on the molstar dep.

## 2026-06-05 — bio PRODUCT nodes AGA-RX·SENOLYX registered + faithful α-helix 3D

User picked ① 완성도: register the §9.1 bio products into INDEX.demi so they appear as real bio nodes with faithful 3D.

- [x] LANDED `feat/8verb-cosmos` 3 commits (tip `6595148a`): registered `[aga-rx]`("탈모 치료제 발굴") + `[senolyx]`("노화세포 제거제") in `domains/INDEX.demi` — `facets.scale=molecular`, `facets.rung=bio`, `prerequisites=["bio"]` (children of the bio category node), keywords. Node count 20→22.
- [x] faithful descriptors `web/public/models/AGA-RX/model.3d.json` + `SENOLYX/model.3d.json` (UPPERCASE dirs — resolver does `.toUpperCase()`): `procedural`/`helix` from REAL residue counts — SFRP1 314 res→87 turns (UniProt Q8N474) · BCL-xL 290 res→81 turns·2 strands (PDB 3ZLR), each with a `src` provenance string. Faithful-BY-DIMENSION (real helix size), NOT the experimental fold (real fold via Mol* = §9.1b follow-up).
- [x] HONEST: both nodes read ⚪ unverified — no `<id>.demi` verb-cell, no fabricated gate/absorbed. A faithful 3D shape is NOT a verified verdict (d6). Generic sampler domains (GENE-EDIT/RNA/chem) still have no entity → stay ⚪ stylized (not invented).
- [x] DEPLOY FIX: `web/next.config.ts` `outputFileTracingIncludes` now bundles `../domains/*.demi` + `../domains/INDEX.demi` (was `*.md` only) — Cloud Run standalone build will carry the `.demi` SSOT. build exit 0 · cosmos.test ✓ (aga-rx/senolyx present · rung=bio · prereq edge→bio · faithful non-symbol descriptor · ⚪ unverified).
- [ ] NEXT (optional): Mol* real-fold viewer on `/d/<domain>` (§9.1b) · register more bio products (CURE family) or chem when a real entity/formula exists · enrich a chem product descriptor (WAY-316606 molecule).

## 2026-06-05 — 6-band rung restored via `.demi` facets.rung (data-driven)

User picked ① 완성도: restore the 6-band ladder (원자·물질·바이오·화학·칩·시스템) the `.demi` way, not a hardcoded classifier.

- [x] LANDED `feat/8verb-cosmos` `eae83c00`(data) + `020b36ac`(code): added `facets.rung` to all 20 INDEX.demi `[id]` sections (matter→materials · bio→bio · chem→chem · chip/firmware/sscb/rtsc/brain/aura/component/bot→chip · energy/grid/mobility/scope/space/cern/antimatter/fusion/ufo→system). cosmos `resolveRung(d.rung ?? SCALE_TO_RUNG[d.scale])` prefers the explicit facet, falls back to scale mapping (molecular→materials, device/component→chip, system→system). `Rung` union restored to 6 {atom,materials,bio,chem,chip,system}; ladder Y-bands 6 (atom −15 → system +15); 3D default shapes atom→lattice/materials→supercell/bio→helix/chem→molecule/chip→die/system→orbit (existing primitives). i18n 5 locales (ko 원자·물질·바이오·화학·칩·시스템).
- [x] HONEST: `atom` band is EMPTY — no atom-scale node in INDEX.demi today; none fabricated. (qubit/hex-n6 are not INDEX.demi nodes.) build exit 0 · TypeScript clean · cosmos.test ✓ (facets.rung=bio→bio not lumped · scale-only fallback · rtsc dotted-key→chip · ufo=system · matter=materials) · geometry-3d-parse ✓. Fixed a stale `RUNG_Y.molecular` spine ref mid-build.
- [ ] NEXT: bio/chem faithful-3D (§9.1) — the real data (AGA-RX SFRP1·SENOLYX BCL-xL) is for PRODUCT domains NOT in INDEX.demi's 20 nodes; needs a node-set decision (register products into INDEX.demi vs attach representative structure to the bio/chem category nodes).

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

