# DOMAINS.tape — WEB-facing curated roster (public starter inventory · /DOMAINS.md SSOT)
# 5축 × 4 범용 연구영역. cockpit 풀 로스터는 domains/DOMAINS.tape (40+ 내부 도메인 포함).
@V := "domains" :: index

@domain RTSC         := "domains/rtsc.md"
@domain FUSION       := "domains/fusion.md"
@domain ANTIMATTER   := "domains/antimatter.md"
@domain QUBIT        := "domains/QUBIT.md"
@domain PEROVSKITE   := "domains/PEROVSKITE.md"
@domain GRAPHENE     := "domains/GRAPHENE.md"
@domain METAMATERIAL := "domains/METAMATERIAL.md"
@domain AEROGEL      := "domains/AEROGEL.md"
@domain NEUROMORPHIC := "domains/NEUROMORPHIC.md"
@domain PHOTONIC     := "domains/PHOTONIC.md"
@domain MEMRISTOR    := "domains/MEMRISTOR.md"
@domain SPINTRONIC   := "domains/SPINTRONIC.md"
@domain GENE-EDIT    := "domains/GENE-EDIT.md"
@domain RNA-THERAPY  := "domains/RNA-THERAPY.md"
@domain ORGANOID     := "domains/ORGANOID.md"
@domain PROTEIN-FOLD := "domains/PROTEIN-FOLD.md"
@domain ELECTROCAT   := "domains/ELECTROCAT.md"
@domain PHOTOREDOX   := "domains/PHOTOREDOX.md"
@domain CO2-CAPTURE  := "domains/CO2-CAPTURE.md"
@domain GREEN-NH3    := "domains/GREEN-NH3.md"
@domain SENOLYX := "domains/SENOLYX.md"
@domain PERIO-CURE := "domains/PERIO-CURE.md"
@domain OA-CURE := "domains/OA-CURE.md"
@domain RETINA-CURE := "domains/RETINA-CURE.md"
@domain IVD-CURE := "domains/IVD-CURE.md"

# --- cross-domain connection graph (g67 · migrated from retired NEXUS.tape) ---
# Carrier (g3 minimal): @link <from> --<verb>--> <to>   # <evidence>
# `domain list` ignores every non-@domain row, so the graph rides along here.
# Mapping: a NEXUS reuse-edge (provides -> reused_by) becomes the CONSUMER
# (reused_by) reusing the PROVIDER (provides): @link <reused_by> --reuses--> <provides>.
# verified reuse-edges (NEXUS e1-e15)
@link RTSC --reuses--> NOVEL-TOOL       # current_loop_offaxis (elliptic K/E on-axis B Green fn) · PR #900 -> #168
@link ANTIMATTER --reuses--> NOVEL-TOOL # current_loop_offaxis (Ioffe-Pritchard trap depth 0.35K) · PR #900 -> #168
@link ANTIMATTER --reuses--> RTSC       # Wheeler on-axis B verifier · getdp 4.0 solenoid templates · RTSC 3b33c26 -> #168
@link UFO --reuses--> ANTIMATTER        # ioffe_loop_bz on-axis B_z + pair_threshold/rel_kinetic (Stage-1 hover · Stage-3 γ-rocket) · UFO.log R1 #237
@link UFO --reuses--> FUSION            # triple_product Lawson n·T·τ (Stage-2 cruise MHD thrust F=J·B·V) · UFO.log R1 #237
@link CLOAK --reuses--> HEX-N6          # n=6 lattice anchors σ-φ=10/σ-τ=8 + 5-기하 1:1 lock-in · cloak verify V3/design phase_b
@link WARP --reuses--> HEX-N6           # σ=12 + n=6 (Alcubierre δ=1/σ R=n bubble · physics UNPROVEN ⚪) · warp.md Phase A
@link WORMHOLE --reuses--> HEX-N6       # σ=12 (Morris-Thorne throat b₀=ℓ_Pl·σ · physics UNPROVEN ⚪) · wormhole.md Phase A
@link DIM-JUMP --reuses--> HEX-N6       # n=6 + J_2(6)=24 (KK 4D→26D ladder · physics UNPROVEN ⚪) · dim-jump.md Phase A
@link DIM-USE --reuses--> HEX-N6        # τ(6)=4 + σ·φ=24 ((σ-φ)²=100c identity · physics UNPROVEN ⚪) · dim-use.md Phase A
@link CLOAK --reuses--> RTSC            # plasma_freq_drude ε<0 (3-stage Veselago n<0 compose) · cloak verify V4 §2
@link UFO --reuses--> CLOAK             # veselago_n_eff sign-aware cloak switch (Stage-cloak RCS 10⁻⁶ m²) · UFO Phase B + PR #1936
@link NUCLEAR --reuses--> RTSC          # mining lens machinery + 5D survival map + island_weight rank (298-120 transmutation) · rtsc.mining cycle 17 E40
# candidate reuse-edges tagged reuse-edge (NEXUS c7/c8) — QFORGE/PWFORGE filtered out of cosmos at runtime
@link RTSC --reuses--> QFORGE           # QFORGE hexa-native SCF·DFPT·λ·Tc engine (QE cross-val ref) · GATE A+L3 PASS PR#2362/#2380
@link QFORGE --reuses--> PWFORGE        # plane-wave H assembler cell->H_of_rho front-end · M1-M6 PR#2407-#2414
# @reuse short-form (NEXUS tail · CURE family)
@link AGA-CURE --reuses--> AGA-RX       # non-AR Wnt-restore drug stack + 5-axis modality → cure arms · 2026-06-03 domain split
@link SENOLYX --reuses--> CURE-PRIMITIVE   # η_neo-lift (niche senescent clearance) universal bottleneck lift
@link OA-CURE --reuses--> CURE-PRIMITIVE   # chondral neogenesis bottleneck → η_neo-lift
@link OA-CURE --reuses--> SENOLYX          # chondral neogenesis bottleneck → SENOLYX η_neo-lift (clearance ≥78%)
@link RETINA-CURE --reuses--> CURE-PRIMITIVE  # photoreceptor neogenesis bottleneck → η_neo-lift
@link RETINA-CURE --reuses--> SENOLYX      # photoreceptor neogenesis → SENOLYX η_neo-lift (clearance ≥72%); UBX1325 retina-validated
@link IVD-CURE --reuses--> CURE-PRIMITIVE  # senolytic necessary-but-not-sufficient boundary case
@link IVD-CURE --reuses--> SENOLYX         # 3-agent close (senolytic+cells+endplate-nutrition) marginal 0.91 @95% clearance
