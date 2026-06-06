#!/usr/bin/env tape
# NEXUS.tape — demiurge intra-project reuse lattice (SSOT)
# Canonical structured SSOT of the cross-domain reuse graph.
# Migrated from INDEX.md (which is now a pointer to this file).
# Governance: commons @D g67 (universal) + project @D d19.
# Substrate: discovery = hexa-lang atlas (verified atoms) · primitive home = hexa-lang stdlib (@D d3).
# Scope: intra-project ONLY — never link domains across repos (@D g67).
#
# Block legend:
#   @I nexus              — identity (kind · scope)
#   @X e<n> :: reuse-edge       — a VERIFIED reuse edge (one provides -> one reused_by)
#   @X p<n> :: provides         — a domain's provides[] registry (primitives it offers)
#   @X c<n> :: reuse-candidate  — a conceptual edge, no code reuse yet (proposed)
#   @N n<n> :: note             — usage protocol / human ASCII graph view
# Block type is @X (External-citation / declarative, one of the closed 17-type
# alphabet @S@U@A@T@R@H@D@K@P@?@I@X@F@N@C@L@V). Body keys are free-form (the
# @D-only do/dont field restriction does NOT apply to @X). Lints clean v1.2.

@V := "tape" :: spec [active]
  version = "1.2"

@I nexus := "demiurge reuse lattice (intra g67 + cross-repo bidirectional peers g68)" :: identity [active]
  kind  = "intra: cross-domain reuse graph · cross-repo: 4 bidirectional peers (hexa-lang, anima, phanes, echoes)"
  scope = "intra-project (g67) + 4 cross-repo bidirectional peers (g68) — unidirectional consumers NOT enumerated here"
  ssot  = "this file (NEXUS.tape) · INDEX.md is a pointer to it"
  governs = "commons @D g67 (intra) + g68 (cross-repo peers) + project @D d19"

# ── 1. VERIFIED reuse edges (provides -> reused_by, with evidence) ──

@X e1 := "NOVEL-TOOL current_loop_offaxis -> RTSC" :: reuse-edge [tier-2 active]
  provides  = "NOVEL-TOOL M2.4"
  primitive = "current_loop_offaxis (elliptic K/E on-axis B Green fn)"
  reused_by = "RTSC"
  evidence  = "PR #900 -> #168"

@X e2 := "NOVEL-TOOL current_loop_offaxis -> ANTIMATTER" :: reuse-edge [tier-2 active]
  provides  = "NOVEL-TOOL M2.4"
  primitive = "current_loop_offaxis (elliptic K/E on-axis B Green fn)"
  reused_by = "ANTIMATTER (6) trap — Ioffe-Pritchard depth 0.35K"
  evidence  = "PR #900 -> #168"

@X e3 := "RTSC getdp solenoid toolchain -> ANTIMATTER" :: reuse-edge [tier-2 active]
  provides  = "RTSC"
  primitive = "Wheeler on-axis B verifier · getdp 4.0 solenoid templates"
  reused_by = "ANTIMATTER (6) trap"
  evidence  = "RTSC 3b33c26 -> ANTIMATTER #168"

@X e4 := "ANTIMATTER ioffe_loop_bz -> UFO" :: reuse-edge [tier-2 active]
  provides  = "ANTIMATTER"
  primitive = "ioffe_loop_bz (on-axis current-loop B_z)"
  reused_by = "UFO Stage-1 hover — Meissner 부상 B-field verify (🟢 SUPPORTED-NUMERICAL ×3)"
  evidence  = "UFO/verify/stage1-hover-fields.md · UFO.log R1 (#237)"

@X e5 := "FUSION triple_product -> UFO" :: reuse-edge [tier-2 active]
  provides  = "FUSION"
  primitive = "triple_product (a·b·c product atom · Lawson n·T·τ)"
  reused_by = "UFO Stage-2 cruise — MHD thrust F_MHD = J·B·V verify (🟢 |Δ|=0.0 ×3)"
  evidence  = "UFO/verify/stage2-cruise-mhd.md · UFO.log R1 (#237)"

@X e6 := "ANTIMATTER pair_threshold_total + rel_kinetic_from_p -> UFO" :: reuse-edge [tier-2 active]
  provides  = "ANTIMATTER"
  primitive = "pair_threshold_total · rel_kinetic_from_p (relativistic energy bookkeeping)"
  reused_by = "UFO Stage-3 orbital — γ-rocket I_sp = c/g 광자천장 verify (🟢 |Δ|=0.0 ×3)"
  evidence  = "UFO/verify/stage3-orbital-gamma.md · UFO.log R1 (#237)"

@X e7 := "NUCLEAR n11_island_cell_checked -> RTSC+NUCLEAR (meta funnel finding)" :: reuse-edge [tier-2 active]
  provides  = "NUCLEAR (n11_island_cell_checked island funnel)"
  primitive = "(c)-gate island_weight composite scorer — accelerator-priority SHE shortlist"
  reused_by = "RTSC+NUCLEAR §F4 (meta-domain elemental-funnel · PARALLEL lane, NOT a supply merge)"
  finding   = "N12: 298-120 (deformed-magic N=178) composite 0.545 = funnel TOP · OUT-ranks entire N11 G4 cohort (N11 top 295-119=0.046). N13: chain-daughter calibration (292-Lv 0.3725 top) confirms 298-120 stands as the novel-element headline."
  evidence  = "exports/nuclear_discovery/n12_funnel/2026-05-28T18-37-27Z + n13_funnel/2026-05-28T19-20-02Z · NUCLEAR PR #504 + N13"
  invariant = "absorbed=false 영구 (R4) · sim PASS = accelerator beam-time hint, NEVER a discovery · meta bridge §6.1 honest-rejects 초중핵→RTSC-bulk supply (벽=생산량) — this is the parallel-funnel reflection, not a coupling"

# ── 2. provides[] registry (per-domain offered primitives · atlas fn) ──

@X p1 := "NOVEL-TOOL provides" :: provides [active]
  domain     = "NOVEL-TOOL"
  primitives = "current_loop_offaxis"

@X p2 := "RTSC provides" :: provides [active]
  domain     = "RTSC"
  primitives = "Wheeler B · getdp solenoid templates · supercon fns (McMillan · Allen-Dynes · WHH)"

@X p3 := "ANTIMATTER provides" :: provides [active]
  domain     = "ANTIMATTER"
  primitives = "penning_* · pair_threshold_* · rel_kinetic/p · cyclotron_cool_* · recomb_3body_* · ioffe_* · h1s2s_rydberg"

@X p4 := "CERN provides" :: provides [active]
  domain     = "CERN"
  primitives = "accelerator (plasma-wakefield cold-linear)"

@X p5 := "FUSION provides" :: provides [active]
  domain     = "FUSION"
  primitives = "triple_product · sigma_v_dt/dhe3/ddp/ddn · pb11_* · q_plasma · ignition_margin · beta_max_pct/beta_n/q_star (Troyon)"

@X p6 := "UFO provides" :: provides [active]
  domain     = "UFO"
  primitives = "ufo_isp_fuel_ratio · ufo_rocket_beta · ufo_gl_derating · ufo_mli_shield (R1 실물리) · ufo_lattice_sigma_pow · ufo_warp_composite · ufo_lattice_master (R2 n6-lattice formal · 물리 ⚪-fenced)"
  note       = "folded to hexa-lang atlas (@F verified-ufo_*-num · substrate hub g68) — recompute-resolvable · PR #1222 (R1) #1244 (R2)"

@X p7 := "NUCLEAR provides" :: provides [active]
  domain     = "NUCLEAR"
  primitives = "n11_island_cell_checked (install-FREE (c)-gate: NC1 Viola-Seaborg · NC2 Royer · C1 α⊕SF total · C2 island_weight 2-D Gaussian) · sf_consensus (C3 Ren-Xu/Hoffman · C4 Zdeb-Warda-Pomorski) · n11_alpha_cell (VS+Royer consensus)"
  note       = "stdlib/nuclear/sim.hexa (@D d3 home) · α-kernels 🟢 SUPPORTED-NUMERICAL (hexa-lang #960) · anchor smoke 4/4 (test/nuclear_r4_anchor_smoke.hexa) · absorbed=false 영구 (R4)"

# ── 3. candidate edges (conceptual · no code reuse yet) ──

@X c1 := "CERN accelerator <-> ANTIMATTER deceleration/generation" :: reuse-candidate [proposed draft]
  note = "shared relativistic kinematics + deceleration ladder — unverified"

@X c2 := "NUCLEAR <-> RTSC+NUCLEAR" :: reuse-candidate [promoted active]
  note = "meta-domain (+) composition — PROMOTED to verified finding edge e7 (NUCLEAR N12 island funnel -> RTSC+NUCLEAR §F4 parallel lane). Composition stays PARALLEL: meta bridge §6.1 honest-rejects 초중핵→RTSC-bulk supply (벽=생산량)."

# ── 4. usage protocol (atlas-first · @D g67 / d19) ──

@N n1 := "reuse protocol" :: note [active]
  step1 = "before building a primitive — `hexa atlas lookup --prefix=<topic>` + grep sibling `<DOMAIN>.md`"
  step2 = "on reuse stamp record `reused[]` · on offering stamp `provides[]`"
  step3 = "add the edge here (one @X e<n> reuse-edge block) — this file is the SSOT"

@N n2 := "human ASCII graph view" :: note [active]
  graph <<~GRAPH
  NOVEL-TOOL --current_loop_offaxis (M2.4)--+--> RTSC (Wheeler on-axis B · solenoid getdp)
                                            +--> ANTIMATTER (6) trap (Ioffe-Pritchard depth 0.35K)
  RTSC --getdp 4.0 toolchain---------------------> ANTIMATTER (6) trap
  ANTIMATTER --ioffe_loop_bz · pair_threshold · rel_kinetic--> UFO (Stage-1 hover · Stage-3 γ-rocket)
  FUSION --triple_product (J·B·V)----------------> UFO (Stage-2 MHD cruise)
  UFO --provides (7 atom)--> hexa-lang atlas (isp/beta/gl/mli · lattice σ^k/(σ−φ)²/σ·φ)
  NUCLEAR --n11_island_cell_checked (N12: 298-120=0.545 top)--> RTSC+NUCLEAR §F4 (PARALLEL lane · NOT supply merge · §6.1 honest-reject)
  GRAPH

# ── 5. cross-repo bidirectional peers (g68) — declared 2026-05-28 ──
# 4 sibling repos with explicit mutual awareness. Unidirectional consumer relationships
# remain at the source repo's NEXUS.tape (not bidirectionally enumerated here).

@X xr1 := "demiurge <-> hexa-lang" :: cross-repo-peer [bidirectional active]
  peer       = "hexa-lang (shared substrate hub · @D g68)"
  from-hexa  = "stdlib/material/magnet · stdlib/rtsc/templates · stdlib/antimatter (16 fns) · stdlib/cern · compiler/atlas"
  to-hexa    = "UFO atom family (7 atoms) folded to compiler/atlas/embedded.gen.hexa (PR #1222/#1244)"
  evidence   = "hexa-lang NEXUS.tape p_magnet/p_rtsc_templates/p_antimatter/p_cern + e1/e2/e3 + e4 (atlas peer)"

@X xr2 := "demiurge <-> anima" :: cross-repo-peer [bidirectional declared]
  peer       = "anima (HEXAD/* consciousness substrate)"
  evidence   = "user NEXUS scope 2026-05-28 — concrete reuse edges TBD"

@X xr3 := "demiurge <-> phanes" :: cross-repo-peer [bidirectional declared]
  peer       = "phanes (hosted OUROBOROS platform · downstream of hexa kick)"
  evidence   = "user NEXUS scope 2026-05-28 — phanes tenants may target demiurge-style objectives"

@X xr4 := "demiurge <-> echoes" :: cross-repo-peer [bidirectional declared]
  peer       = "echoes (HEXA-* discoveries catalog · σφτ identity at centre)"
  evidence   = "user NEXUS scope 2026-05-28 · echoes README HEXA-* family listing"

@N n3 := "cross-repo scope policy (g68)" :: note [active]
  rule = "ONLY 4 declared bidirectional peers (hexa-lang, anima, phanes, echoes). other cross-repo consumers are unidirectional and live at the source repo's NEXUS.tape."
  ssot = "hexa-lang NEXUS.tape n2.scope_rule — hub records hub<->peer only; peer-mesh is peer-side."
@reuse SENOLYX reused[CURE-PRIMITIVE]
  provides = "η_neo-lift (niche senescent clearance) to AGA-CURE · periodontal · OA-cartilage · retinal"
  edge = "CURE-PRIMITIVE identified the universal η_neo bottleneck → SENOLYX is the cross-cutting drug that lifts it"
@reuse OA-CURE reused[CURE-PRIMITIVE,SENOLYX]
  edge = "chondral neogenesis bottleneck → SENOLYX η_neo-lift (clearance ≥78%)"
@reuse RETINA-CURE reused[CURE-PRIMITIVE,SENOLYX]
  edge = "photoreceptor neogenesis bottleneck → SENOLYX η_neo-lift (clearance ≥72%); UBX1325 retina-validated"
@reuse IVD-CURE reused[CURE-PRIMITIVE,SENOLYX]
  edge = "FIRST BOUNDARY case — senolytic necessary-but-not-sufficient; needs 3-agent (senolytic+cells+endplate-nutrition), closes only marginally (0.91 @95% clearance)"

@X c9 := "QFORGE bio-FEP engine -> {SENOLYX·AGA-CURE·IVD-CURE·OA-CURE·PERIO-CURE·RETINA-CURE} (planned compute engine)" :: reuse-edge [tier-2 candidate active]
  note  = "QFORGE universal multi-scale 확장(2026-06-07): bio scale = native MD/FEP(ABFE·RBFE·HREX·MBAR) + QM-derived FF. 4 CURE 도메인 + SENOLYX의 docking/FEP/ΔΔG 계산엔진이 QFORGE-native로 흡수 예정. materials c7(QFORGE->RTSC) 패턴 복제."
  gate  = "PENDING — bio scale 미구현. M-B1(native MD) -> M-B2/B3(FEP) 핵심경로. 게이트: QFORGE FEP ΔΔG vs openmm/openfe + 실험 ΔΔG(redox-matched) g5-agree시 verified-edge 승격. SENOLYX R12(17-AAG<->17-AG)가 첫 cross-val 앵커."
  scope = "intra-project(g67). 동기: bio 외부의존 3대 실패모드 실증(B1 FF 2.2x over-spread · B3 openfe 무한대기 · B4 vast CUDA-PTX 소멸; QFORGE.log.md 2026-06-07). QFORGE-native가 materials에서 QE 걷어낸 것과 동형으로 제거."
