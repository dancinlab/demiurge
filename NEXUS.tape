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

@X e7 := "HEX-N6 lattice anchors -> CLOAK" :: reuse-edge [tier-1 active]
  provides  = "HEX-N6 (n=6 lattice substrate primitive)"
  primitive = "sigma·tau·phi·sopfr·mu·is_perfect·aliquot·omega_big·liouville·sigma_2 at n=6 (10/11 🔵)"
  reused_by = "CLOAK Phase A ⓸ σ-φ=10 cell pitch · ⓺ σ-τ=8 octave bandwidth · Phase B 5-기하 ↔ 5-atom 1:1 lock-in"
  evidence  = "exports/cloak/verify/V3_phase_a_completion.md + exports/cloak/design/phase_b_metacell.md"

@X e8 := "HEX-N6 -> WARP" :: reuse-edge [tier-1 active]
  provides  = "HEX-N6"
  primitive = "sigma=12 + n=6 lattice anchors"
  reused_by = "WARP Alcubierre δ=1/σ=1/12 + R=n=6 bubble radius (lattice arithmetic only · physics UNPROVEN ⚪)"
  evidence  = "domains/warp.md Phase A"

@X e9 := "HEX-N6 -> WORMHOLE" :: reuse-edge [tier-1 active]
  provides  = "HEX-N6"
  primitive = "sigma=12 anchor"
  reused_by = "WORMHOLE Morris-Thorne throat b₀=ℓ_Pl·σ (Planck-scale lattice scaling · physics UNPROVEN ⚪)"
  evidence  = "domains/wormhole.md Phase A"

@X e10 := "HEX-N6 -> DIM-JUMP" :: reuse-edge [tier-1 active]
  provides  = "HEX-N6"
  primitive = "n=6 + J_2(6)=24 (Calabi-Yau / bosonic ladder anchors)"
  reused_by = "DIM-JUMP Kaluza-Klein 4D→6D→10D→11D→24D→26D ladder (lattice arithmetic · physics UNPROVEN ⚪)"
  evidence  = "domains/dim-jump.md Phase A"

@X e11 := "HEX-N6 -> DIM-USE" :: reuse-edge [tier-1 active]
  provides  = "HEX-N6"
  primitive = "tau(6)=4 + sigma·phi=24 composition"
  reused_by = "DIM-USE τ=4 cycle + (σ-φ)²=100c composite identity (lattice arithmetic · physics UNPROVEN ⚪)"
  evidence  = "domains/dim-use.md Phase A"

@X e12 := "RTSC plasma_freq + SRR lc_resonance + Veselago carrier -> CLOAK meta" :: reuse-edge [tier-3 active]
  provides  = "RTSC (Drude ε<0 via plasma_freq_drude PR #1943) + SRR (Lorentz μ<0 via lc_resonance/lorentz_mu_re PR #1934) + Veselago carrier (n=-√(εμ) PR #1936)"
  primitive = "3-stage composition: ε<0 (PR #1943) · μ<0 (PR #1934) · n<0 (PR #1936)"
  reused_by = "CLOAK Phase A ⓵⓶⓷ + Phase C verb-3 design dossier (n_eff = -√(εμ) < 0 cloak active)"
  evidence  = "exports/cloak/verify/V4_final_tier_ledger.md §2"

@X e13 := "stdlib/math exp + boltzmann_absorption_floor -> CLOAK" :: reuse-edge [tier-2 active]
  provides  = "stdlib/math (PR #1949)"
  primitive = "exp_neg_one + boltzmann_absorption_floor (1 - 1/e = 0.6321205588285577)"
  reused_by = "CLOAK Phase A ⓹ Boltzmann transmission floor (Lambert-Beer 1-1/e absorption per MFP)"
  evidence  = "PR #1949 (hexa-lang) + exports/cloak/verify/V4 §3.5"

@X e14 := "CLOAK veselago_n_eff -> UFO Stage-cloak" :: reuse-edge [tier-2 active]
  provides  = "CLOAK (Phase A ⓷ + carrier composition)"
  primitive = "veselago_n_eff(eps_re, mu_re) — sign-aware n=±√(εμ) cloak switch"
  reused_by = "UFO Stage-cloak — EM 가시성 차단 (RCS 10⁻⁶ m² target · Mk.II)"
  evidence  = "UFO Phase B HEXA-CLOAK 흡수 + PR #1936"

@X e15 := "RTSC mining lens machinery -> NUCLEAR 298-120 campaign" :: reuse-edge [tier-1 active]
  provides  = "RTSC (mining lens · ouroboros lens · 5D survival map · edge graph · combinatorial lens · island_weight rank)"
  primitive = "mining lens machinery (same-formula · ouroboros · dimensional · tension · combinatorial) + 5D map template + edge graph aggregation"
  reused_by = "NUCLEAR 298-120 — transmutation campaign (cross-domain edge first node via combinatorial lens + island_weight rank)"
  evidence  = "domains/rtsc.mining.md cycle 17 E40 + NUCLEAR cross-domain edge documented"

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

@X p7 := "HEX-N6 provides" :: provides [active]
  domain     = "HEX-N6 (n=6 lattice substrate primitive)"
  primitives = "sigma · sigma_2 · tau · phi · mu · sopfr · is_perfect · aliquot · omega_big · liouville · jordan_totient at n=6 (10/11 🔵 LANDED · J_2 calc gap closing via separate PR)"
  note       = "all atoms 🔵 SUPPORTED-FORMAL via hexa verify --expr mini · atlas idempotent skip @D g69 · OEIS A000203/A000005/A000010/A001414/A002819 family"

@X p8 := "SRR provides" :: provides [active]
  domain     = "SRR (Split-Ring Resonator primitive)"
  primitives = "lc_resonance(L,C) · srr_filling_factor(r,a) · lorentz_mu_re(F,w,w0,gamma)"
  note       = "PR #1934 · 7/7 self-test PASS · mu<0 branch supplier for Veselago composition (CLOAK 부품 2)"

@X p9 := "CLOAK provides" :: provides [active]
  domain     = "CLOAK (meta-carrier · n_eff=-√(εμ)<0)"
  primitives = "veselago_n_eff (sign-aware) + composition of {RTSC plasma_freq_drude · SRR lc_resonance/lorentz_mu_re · HEX-N6 lattice · stdlib/math exp_neg_one}"
  note       = "Phase A 6/6 + Phase B 4/4 + Phase C 7/7 LANDED · absorbed=true V4 §6.1 · 5-기하 ↔ HEX-N6 5-atom 1:1 lock-in 발견 candidate"

# ── 3. candidate edges (conceptual · no code reuse yet) ──

@X c1 := "CERN accelerator <-> ANTIMATTER deceleration/generation" :: reuse-candidate [proposed draft]
  note = "shared relativistic kinematics + deceleration ladder — unverified"

@X c2 := "NUCLEAR <-> RTSC+NUCLEAR" :: reuse-candidate [proposed draft]
  note = "meta-domain (+) composition"

@X c3 := "WARP + WORMHOLE <-> ANTIMATTER exotic E_neg" :: reuse-candidate [proposed draft]
  note = "WARP/WORMHOLE both need exotic matter / WEC-NEC violation source; ANTIMATTER as candidate negative-energy substrate (unverified · physics UNPROVEN ⚪)"

@X c4 := "DIM-JUMP <-> CERN LHC" :: reuse-candidate [proposed draft]
  note = "DIM-JUMP compactification radius bounded by LHC 1e-19 m (실측 anchor); CERN domain supplies experimental ceiling for F-DIM-1 falsifier"

@X c5 := "DIM-USE <-> DIM-JUMP" :: reuse-candidate [proposed draft]
  note = "DIM-USE τ=4 cycle requires DIM-JUMP precondition (must enter the extra dimension first before navigating); sequential dependency UFO Stage-6 → Stage-7"

@X c6 := "RTSC <-> RADGUARD" :: reuse-candidate [proposed draft]
  note  = "방사성 초수소화물(ThH10/AcH10) 후보 → RADGUARD 3축(제어/제거/결박) 안전성 참조"
  scope = "intra-project (g67); conceptual edge, no code reuse yet"

@X c7 := "QFORGE el-ph engine -> RTSC (canonical compute engine)" :: reuse-edge [tier-1 active]
  note  = "QFORGE(hexa-native SCF·DFPT·λ·Tc, stdlib/qforge) = RTSC 캠페인 계산엔진. QE = cross-val reference."
  gate  = "GATE A PASS — QFORGE L0 Tc ↔ QE 12/12 (Nb·CaH6·H3S·YH10·H3O, rel-ε≤2.5e-3, hexa-lang PR#2362). full migration = L3 |g| cross-val(Li2MgH16/LaH10 terminal) 잔여."
  scope = "intra-project (g67); engine dependency RTSC←QFORGE (QFORGE.md SSOT). L0 Tc layer 검증완료 → verified-edge 승격."

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

  HEX-N6 (n=6 lattice substrate · 10/11 🔵)
          --sigma/tau/phi/sopfr/mu/J₂/...--+--> CLOAK (Phase A ⓸⓺ + Phase B 5-기하 1:1 lock-in)
                                            +--> WARP (Alcubierre δ=1/σ R=n)
                                            +--> WORMHOLE (Morris-Thorne b₀=ℓ_Pl·σ)
                                            +--> DIM-JUMP (KK 4D→26D ladder)
                                            +--> DIM-USE (τ-cycle + (σ-φ)²=100c)
  RTSC plasma_freq + SRR lc_resonance + Veselago --3-stage compose--> CLOAK (n_eff=-√(εμ)<0)
  stdlib/math exp_neg_one (PR #1949) -----------> CLOAK Phase A ⓹ (1-1/e=0.6321)
  CLOAK veselago_n_eff --------------------------> UFO Stage-cloak (RCS 10⁻⁶ m²)
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
