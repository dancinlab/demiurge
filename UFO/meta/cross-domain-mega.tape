#!/usr/bin/env tape
# UFO meta — CROSS-DOMAIN-MEGA 흡수 manifest tape.
# Sibling of UFO/meta/cross-domain-mega.md (numbers derive from the .md + NEXUS.tape SSOT).
# 17-type alphabet only (@V @I @C @D::governance @X). No name-hardcoded dispatch (@D d4).
# Reuse-lattice SSOT = repo-root NEXUS.tape — this tape is a UFO-scoped read-only view.

@V := "tape" :: spec [active]
  version = "1.0"

@I id001 := "ufo/meta/cross-domain-mega" :: identity [d=2026-05-26 active]
  kind = "🛸 UFO meta cross-domain-mega absorb (alias `mega-xlink`) — RTSC↔FUSION↔ANTIMATTER↔CERN reuse lattice"
  brief = "absorb UFO/CROSS-DOMAIN-MEGA.md triple-stack into demiurge 4-domain reuse graph · verified atoms only · no new physics"
  parent = "dancinlab/demiurge"
  sibling-md = "UFO/meta/cross-domain-mega.md"

# ─── §C lattice config (verifiable integer arithmetic — NOT physics proof) ───
@C c_lattice := "n=6 invariant lattice (shared substrate constant)" :: config [d=2026-05-26 active]
  n = 6
  sigma = 12
  tau = 4
  phi = 2
  B_star = "sigma*tau = 48 T  (RTSC Hc2 = FUSION Lawson target = UFO Meissner lift — arithmetic coincidence)"

@C c_source := "absorbed source provenance" :: config [d=2026-05-26 active]
  source = "UFO/CROSS-DOMAIN-MEGA.md"
  blob_sha = "0f7137a67a5f45ddb6b48fcf997013515e5cc13c"
  loc = 665
  scope = "section 8 MEGA-INTEGRATION (triple-SSOT matrix · Omega_mega=480 · section 8.5 falsifier)"

# ─── §X cross-domain reuse edges (provides -> reused_by · NEXUS.tape SSOT view) ───
# Each edge cites a verified atom/record. Verdicts are NOT minted here (NEXUS.tape is SSOT).

@X x_rtsc_stage1 := "RTSC -> UFO Stage-1 hover" :: reuse-edge [tier-2 d=2026-05-26 active]
  provides = "RTSC"
  primitive = "ioffe_loop_bz (= current_loop_offaxis zeta=0 specialisation · Wheeler on-axis B)"
  reused_by = "UFO Stage-1 hover (Meissner lift on 48T solenoid fringe)"
  shared = "B_star = sigma*tau = 48 T (Hc2)"
  evidence = "UFO/verify/stage1-hover-fields.md (atlas 663698a0...ce7fb) PR#191"

@X x_fusion_stage2 := "FUSION -> UFO Stage-2 cruise" :: reuse-edge [tier-2 d=2026-05-26 active]
  provides = "FUSION"
  primitive = "triple_product (Lawson n*T*tau_E)"
  reused_by = "UFO Stage-2 cruise (MHD propulsion F=J×B×V_ch)"
  shared = "B_star = sigma*tau = 48 T (Lawson target)"
  evidence = "UFO/verify/stage2-cruise-mhd.md"

@X x_anti_stage3 := "ANTIMATTER -> UFO Stage-3 orbital" :: reuse-edge [tier-2 d=2026-05-26 active]
  provides = "ANTIMATTER"
  primitive = "pair_threshold_total · rel_kinetic_from_p"
  reused_by = "UFO Stage-3 orbital (gamma-rocket e+e- -> 2x511keV photon -> I_sp=c/g)"
  shared = "photon ceiling I_sp=c/g (no shared B*)"
  evidence = "UFO/verify/stage3-orbital-gamma.md"

@X x_novel_rtsc := "NOVEL-TOOL -> RTSC (substrate-of-substrates)" :: reuse-edge [tier-2 d=2026-05-26 active]
  provides = "NOVEL-TOOL M2.4"
  primitive = "current_loop_offaxis (elliptic K/E on-axis B Green fn)"
  reused_by = "RTSC (Wheeler on-axis B · solenoid getdp)"
  evidence = "PR #900 -> #168 (NEXUS.tape @X e1)"

@X x_novel_anti := "NOVEL-TOOL -> ANTIMATTER" :: reuse-edge [tier-2 d=2026-05-26 active]
  provides = "NOVEL-TOOL M2.4"
  primitive = "current_loop_offaxis (elliptic K/E on-axis B Green fn)"
  reused_by = "ANTIMATTER (6) trap (Ioffe-Pritchard depth 0.35K)"
  evidence = "PR #900 -> #168 (NEXUS.tape @X e2)"

@X x_rtsc_anti := "RTSC -> ANTIMATTER (getdp toolchain)" :: reuse-edge [tier-2 d=2026-05-26 active]
  provides = "RTSC"
  primitive = "getdp 4.0 solenoid toolchain"
  reused_by = "ANTIMATTER (6) trap"
  evidence = "RTSC 3b33c26 -> ANTIMATTER #168 (NEXUS.tape @X e3)"

@X x_cern_anti := "CERN <-> ANTIMATTER (candidate · no code reuse yet)" :: reuse-candidate [proposed d=2026-05-26 draft]
  provides = "CERN accelerator (plasma-wakefield cold-linear)"
  reused_by = "ANTIMATTER deceleration/generation (e+ source · relativistic kinematics)"
  note = "shared relativistic kinematics + deceleration ladder — unverified (NEXUS.tape @X c1)"

@X x_nexus := "reuse-lattice SSOT pointer" :: source [d=2026-05-26 active]
  ssot = "repo-root NEXUS.tape (@X reuse-edge · provides · candidate)"
  scope = "this tape is a UFO-scoped read-only view — new edges register in NEXUS.tape, not here (@D d19)"

# ─── §D governance — manifest-only · arithmetic vs physics honesty ───
@D g_manifest_only := "UFO/meta holds manifests only — no implementation code" :: governance [required active]
  do = "keep UFO/meta as docs/manifests · cite verified atoms from hexa-lang atlas + sibling verify ledgers"
  dont = "duplicate primitive code in UFO/meta · mint a verdict here (NEXUS.tape + atlas are SSOT · @D d3)"

@D g_arith_vs_physics := "48-coincidence is arithmetic reuse observation, not integration proof" :: governance [required active]
  do = "treat B_star=sigma*tau=48T cross-domain match as a NEXUS reuse observation (verifiable integer)"
  dont = "claim UFO+RTSC+FUSION single-craft integration (Omega_mega=480) is proven — that is UNPROVEN"

@D g_no_impossibility := "no impossibility framing — concrete reuse + breakthrough paths" :: governance [required active]
  do = "frame unverified edges (CERN<->ANTIMATTER) as candidate reuse with a concrete path (@D d2)"
  dont = "concede 'impossible' · stamp a candidate edge as verified without evidence"

# ─── §X cross-links ───
@X x_md := "UFO/meta/cross-domain-mega.md" :: source [d=2026-05-26 active]
  scope = "Korean absorb manifest — TL;DR ASCII · cross-link tab · NEXUS reference"

@X x_source_md := "UFO/CROSS-DOMAIN-MEGA.md" :: source [d=2026-05-26 active]
  scope = "in-tree source — section 8 MEGA-INTEGRATION triple-stack + section 8.1 triple-SSOT matrix"

@X x_exp_hypo := "UFO/meta/experiments-hypotheses.md" :: source [d=2026-05-26 active]
  scope = "sibling Phase D meta absorb — 13-falsifier monotone set (UNPROVEN layer)"
