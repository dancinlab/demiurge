# COSMOS — log

Append-only history sister of `COSMOS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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

