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

@I nexus := "demiurge intra-project reuse lattice" :: identity [active]
  kind  = "cross-domain reuse graph — verified primitives + discoveries shared between sibling domains"
  scope = "intra-project ONLY — never link domains across repos (@D g67)"
  ssot  = "this file (NEXUS.tape) · INDEX.md is a pointer to it"
  governs = "commons @D g67 (universal) + project @D d19"

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

# ── 3. candidate edges (conceptual · no code reuse yet) ──

@X c1 := "CERN accelerator <-> ANTIMATTER deceleration/generation" :: reuse-candidate [proposed draft]
  note = "shared relativistic kinematics + deceleration ladder — unverified"

@X c2 := "NUCLEAR <-> RTSC+NUCLEAR" :: reuse-candidate [proposed draft]
  note = "meta-domain (+) composition"

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
  GRAPH
