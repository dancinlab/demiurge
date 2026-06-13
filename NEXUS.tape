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

# ── QFORGE multi-scale d19 reuse lattice (the "one engine, six scales" core) ──
# atoms/chem/system consume the MOLSCF molecular-SCF core + materials DFPT + flame matmul.
# These cross-LANE reuse edges ARE the universal-axis thesis: one generic atom-centered /
# linear-response path, instance = basis-set + geometry manifest only (d4). g5-gated, PySCF/
# Crawford/literature-anchored. Implementation home (d3) = hexa-lang stdlib/qforge/<scale>/.

@X e16 := "QFORGE-MOLSCF molecular-SCF core -> QFORGE-ATOMS" :: reuse-edge [tier-1 active]
  provides  = "QFORGE-MOLSCF (molecular ab-initio SCF front-end)"
  primitive = "gaussian_integrals S · coulomb_integrals ERI+V · rhf (rhf_scf) · md_shell (p/d/f MD integrals) · uhf (DIIS + open-shell) · rohf (spin-pure)"
  reused_by = "QFORGE-ATOMS — real-STO overlap (r10) · true Roothaan RHF force consuming ERI+V (r11) · p/d-shell force via md_shell (r13/14) · DIIS-accel cc-pVTZ RHF (r24) · UHF-reference UMP2/UCCSD/UCCSD(T) (r25-27) · spin-pure ROHF-CCSD(T) ⟨S²⟩ exact (r28)"
  evidence  = "hexa-lang qforge-atoms r10-r28 (#3162·#3168·#3174·#3178·#3228·#3232·#3234·#3235·#3237) — atoms stdlib consumes molscf brick verbatim"

@X e17 := "stdlib/flame matmul -> QFORGE-ATOMS CC tensor contractions" :: reuse-edge [tier-1 active]
  provides  = "stdlib/flame (native matmul)"
  primitive = "flame matmul (4-index AO->MO transform + CC tensor contraction routing)"
  reused_by = "QFORGE-ATOMS — CC accel (r20, 13×) · spatial-orbital CCSD (r21, 41×, cc-pVDZ CCSD live 18.6s) · spatial (T) (r22, cc-pVDZ CCSD(T) live 24s)"
  evidence  = "hexa-lang qforge-atoms r20-r22 (#3208·#3213·#3216) — cc_accel/ccsd_rhf/ccsd_t_rhf route through flame"

@X e18 := "materials qforge_phonons (DFPT) -> QFORGE-CHEM TS-Hessian" :: reuse-edge [tier-1 active]
  provides  = "QFORGE materials DFPT linear-response (qforge_phonons · dfpt.hexa · dfpt_response.hexa)"
  primitive = "Γ-point Hessian / lowest-eigenmode from DFPT linear response"
  reused_by = "QFORGE-CHEM — TS-Hessian saddle 1-neg-eigenvalue (r3, DFPT reused at the TS coordinate, thin layer) · dimer/eigenvector-following minimum-mode following (r4)"
  evidence  = "hexa-lang qforge-chem r3/r4 (ts_hessian.hexa · dimer.hexa) g5 32/32 + dimer PASS"

@X e19 := "QFORGE SCF core + chem/md MM -> QFORGE-SYSTEM QM/MM bridge" :: reuse-edge [tier-1 active]
  provides  = "QFORGE scf/scf_etot (QM) + stdlib/chem/md (MM: lennard_jones · bonded · ewald · pme) + assembler qforge_assemble_h (V_ext SCF hook)"
  primitive = "E_QM(scf_etot) · E_MM(lennard_jones/bonded) · E_QM-MM electrostatic (ewald/pme) · V_ext 1-electron hook"
  reused_by = "QFORGE-SYSTEM — QM/MM partition algebra (r1) · electrostatic embedding V_ext (r3) · link-atom H-cap reusing r3 V_ext (r4) · CG-MARTINI (r5)"
  evidence  = "hexa-lang qforge-system round1/3/4/8 (qmmm.hexa · embed_electrostatic.hexa · link_atom.hexa · cg_martini.hexa) g5 PASS"

@X e20 := "materials DFPT el-ph coeff -> QFORGE-CHIP thermal/band feed" :: reuse-edge [tier-2 active]
  provides  = "QFORGE materials (DFPT el-ph · SCF plane-wave H(k) · dfpt/realcell_phonon ω(q))"
  primitive = "kinetic_diag (T(k) shared band/SCF) · DFPT ω(q,ν) phonon channels · thermal-quantum g₀ · (frontier) Callaway B_U/B_iso ab-initio coeff feed"
  reused_by = "QFORGE-CHIP — SCF-fed band H(k) (r3, real qforge_kinetic_diag) · phonon-Landauer κ via DFPT ω(q) (r4) · absolute-κ ab-initio coeff feed (named frontier, r11 verify-adapter)"
  evidence  = "hexa-lang qforge-chip r3/r4 (band_scf.hexa · phonon_kappa.hexa) g5 PASS · r11 verify-adapter names the B_U/B_iso DFPT feed frontier"

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

@X p8 := "QFORGE-MOLSCF provides (universal-axis SCF core)" :: provides [active]
  domain     = "QFORGE-MOLSCF (molecular ab-initio SCF front-end · stdlib/qforge/molscf)"
  primitives = "gaussian_integrals (S) · coulomb_integrals (ERI+V) · md_integrals/md_shell (s/p/d/f McMurchie-Davidson) · rhf · uhf (DIIS) · rohf (spin-pure) · scf_robust (Fermi smearing+GWH) · casci · fci (general N-e) · casscf · nevpt2 / nevpt2_srsi (full 8-class SC-NEVPT2)"
  note       = "method-complete (single-ref RHF/UHF/ROHF/robust-SCF + multiref static CASCI/CASSCF + dynamic 8-class SC-NEVPT2) · PySCF 2.13.1-anchored · the d19 core reused by atoms/chem/system (e16/e18/e19)"

@X p9 := "QFORGE-ATOMS provides (single-reference gold standard)" :: provides [active]
  domain     = "QFORGE-ATOMS (molecular wavefunction methods · stdlib/qforge/atoms)"
  primitives = "GFN-xTB stack (eeq/d4_disp/eht_scc/lowdin/harris_foulkes) · real_overlap · rhf_force(_gen/_pd) (fully-analytic s/p/d) · geom_opt (BFGS) · mp2/ccsd/ccsd_t (Crawford-anchored) · ccsd_rhf/ccsd_t_rhf (flame-accel) · ump2/uccsd/uccsd_t · rohf_ccsd_t (spin-pure) · CBS extrapolation"
  note       = "single-reference method lattice COMPLETE (both shells, gold-standard, CBS) · consumes MOLSCF core (e16) + flame matmul (e17)"

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

  QFORGE — one engine, six scales (d19 multi-scale reuse lattice):
  QFORGE-MOLSCF (molecular SCF core: S · ERI+V · rhf · md_shell · uhf · rohf · casci/casscf/nevpt2)
          --gaussian_integrals/coulomb_integrals/rhf/md_shell/uhf/rohf--> QFORGE-ATOMS (e16)
  stdlib/flame matmul --CC tensor contractions (13-41×)-----------------> QFORGE-ATOMS (e17)
  materials DFPT (qforge_phonons) --Γ-Hessian / lowest-eigenmode--------> QFORGE-CHEM TS-Hessian/dimer (e18)
  QFORGE scf_etot + chem/md (LJ·bonded·ewald·pme) --QM/MM partition-----> QFORGE-SYSTEM bridge (e19)
  materials DFPT ω(q) + kinetic_diag --band H(k) · phonon-Landauer κ----> QFORGE-CHIP (e20)
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
