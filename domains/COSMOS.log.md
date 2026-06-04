# COSMOS — log

Append-only history sister of `COSMOS.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

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

