#!/usr/bin/env tape

@V := "tape" :: spec [active]
  version = "1.2"
  role    = "agent-operating-guide (structured supplement; AGENTS.md is the prose SSOT)"

@X hexa_verify := "hexa verify — verification via hexa CLI only" :: guide [active]
  tldr = "Any correctness / purity / grade / identity claim → verify with `hexa <verb>` or `hexa run <verifier>.hexa` (e.g. `hexa run tool/atlas_verify.hexa`) and paste the verdict VERBATIM. NEVER cite sympy / PyPhi / Wolfram / Mathematica output as evidence."
  detail = "~/core/atlas/VERIFY.tape"

@X wilson_pool := "wilson pool — resource utilization" :: guide [active]
  tldr = "Heavy / deterministic work (build · drill · probe · compile · test-sweep · GPU fire) → do NOT serialize on localhost; route to the host pool: `wilson pool list` then `wilson pool on <host> <cmd>`, or a ToolUse `\"host\"` field. Empty roster = degrade-to-local, fine."
  detail = "~/core/atlas/POOL.tape"

# ────────────────────────────────────────────────────────────────────
# Identity
# ────────────────────────────────────────────────────────────────────

@I id001 := "hexa-matter" :: project [active d=2026-05-14]
  brief = "HEXA-Matter family · materials science · 16+ DB bridges · 29 parity gates"
  parent = "dancinlab"
  family   = "HEXA"
  scope    = "materials-science substrate — industrial materials side"
  layout   = "36-verb materials toolkit on the n=6 invariant lattice"
  version  = "1.2.0"
  license  = "MIT"
  doi      = "10.5281/zenodo.20102811"
  => "ceramic / polymer / fiber / gem / metal / synthesis / recycle (7-group AXIS)"

@D g_arch_vs_log_split := "v1.2 architecture-vs-history split" :: governance [required d=2026-05-14 active]
  rule = "UPPERCASE.tape files are EDITABLE architecture (latest-wins per id). Append-only event history lives in UPPERCASE.log.tape siblings."
  why = "declarative entries (governance · config · layout · identity) evolve naturally; locking them as append-only via ~> supersedes creates noisy histories. The split lets architecture stay current and history stay immutable."
  applies-to = "AGENTS.tape · all UPPERCASE.tape root files"
  authority = "[@x_tape_spec] §Domain-tape sibling §Architecture-vs-history split"
  @> AGENTS.md


@I id002 := "verb-coverage" :: domain-scope [active]
  verbs_total = 36
  v1_0_0      = 17   # 16 canon-imported (SHA 47c70cbf) + silicon (in-repo)
  phase_d     = 12   # elastomer, compound-semi, perovskite, 2d-materials, adhesive,
                     # magnetic-materials, mof, liquid-crystal, superalloy,
                     # biodegradable-plastics, wood-cellulose, carbon
  phase_d_followon = 4  # glass-ceramic, geopolymer, aerogel-foam, ionic-liquid
  phase_d_prime    = 3  # refractory, photoresist, electrode-material
  groups = ["CER", "POL", "FIB", "MET", "GEM", "PRC", "FAS"]
  => "inorganic ceramics · concrete · engineered polymers · glass · silicon (material layer)"
  => "wide-bandgap compound-semi · perovskite · 2D · MOFs · carbon allotropes"
  => "gems · metallurgy (general + superalloy + magnetic) · elastomers · adhesives"
  => "liquid crystals · biodegradable plastics · ionic liquids · glass-ceramics"
  => "geopolymers · aerogels · wood/cellulose · synthesis platforms · refractory"
  => "photoresist · electrode-material · circular-material flows"

@I id003 := "out-of-scope" :: boundary [active]
  note = "chip-grade semi DEVICE/FAB process → hexa-chip; lutherie/fashion-textile → future repos"
  silicon_here = "MATERIAL layer (polysilicon · mono-Si · SiO₂ · SiC ceramic · silicone polymer)"

# ────────────────────────────────────────────────────────────────────
# Layout (verified 2026-05-14 via ls)
# ────────────────────────────────────────────────────────────────────

@L l1 := "repo-root" :: file-tree [active]
  ssot_entry        = "INIT.md"              # READ FIRST — Phase A-G status, pick-it-up-cold
  agents_md         = "AGENTS.md"            # prose SSOT — companion to this file
  axis              = ["AXIS.md", "AXIS_CLOSURE_PLAN.md", "CLOSURE_RESIDUAL_BACKLOG.md",
                       "CLOSURE_STATUS.md", "DECOMPOSITION_PLAN.md", "LESSONS.md",
                       "CROSS_LINK.md"]
  release_notes     = ["RELEASE_NOTES_v1.0.0.md", "RELEASE_NOTES_v1.1.0.md",
                       "RELEASE_NOTES_v1.2.0.md", "RELEASE_NOTES_v1.3.0.md",
                       "V1_2_0_HANDOFF.md"]
  phase_plans       = ["PHASE_H_PLAN.md", "PHASE_J_PLAN.md", "PHASE_K_PLAN.md",
                       "NOVEL_ROADMAP.md", "IMPORTED_FROM_CANON.md"]
  novel_ledger      = "NOVEL.md"             # hxm-<class>-<target>-<NNN> candidates
  limit_breakthrough = "LIMIT_BREAKTHROUGH.md"
  deep_chapters     = ["SILICON.md", "CERAMIC-ENGINEERING.md", "METALLURGY-DEEP.md",
                       "POLYMER-CHEMISTRY.md", "GRAPHENE-CARBON.md"]
  supply_chain_domain = ["RARE-EARTH.tape",                  # 17-element family reference
                         "RARE-EARTH+ALTERNATIVE.tape",      # meta-domain: 6-track substitution roadmap (added 2026-05-17)
                         "CRITICAL-MINERAL.tape"]            # umbrella: REE + Ga + Ge + Sb + W + Co + Li + graphite + Mg + Ti + Nb + Ta
  verb_dirs         = "<verb>/<verb>.md per 36 verbs (ceramics, polymer, silicon, …)"
  bridges           = ["_python_bridge/ (12 modules)",
                       "_research_bridge/ (8 modules)",
                       "_absorption_bridge/ (16 adapters)"]
  hexa_native       = ["_hexa_bridge/module/*.hexa   (T1 · 6 stdlib-only compute modules)",
                       "_hexa_bridge/selftest/*.hexa (T2 · 26/26 selftest gates, byte-parity verified)"]
  selftest          = "selftest/run_all.sh   # 38/38 PASS; hexa-first union (.hexa→.py/.sh fallback)"
  verify            = "verify/run_all.hexa   # 4/4 PASS structural closure"
  parity_gates      = "tests/*_parity.py + tests/snapshots/*.json (29 gates)"
  cli               = "cli/hexa-matter.hexa"
  toml              = "hexa.toml"
  policy            = "LATTICE_POLICY.md"

# ────────────────────────────────────────────────────────────────────
# Governance — inherited + local
# ────────────────────────────────────────────────────────────────────

@D g_inherit := "dancinlab-default" :: policy [required active]
  source = "@x_lattice_policy"
  note   = "deployed 2026-05-12 to all dancinlab projects"

@D g1 := "real-limits-first" :: policy [required active]
  rule <<~EOF
    Project ceiling = REAL math/physics/engineering limits, NEVER the n=6
    invariant lattice (σ(6)=12, τ(6)=4, φ(6)=2, J₂(6)=24).
    Verification anchors MUST include ≥1 real limit from LATTICE_POLICY §1.2
    (Shannon · Kolmogorov · Bekenstein · c · ℏ · k · Stefan-Boltzmann · Carnot
     · ASML throughput · ERCOT capacity · …).
    Lattice-tautology checks (σ·φ=24) alone are NOT sufficient verification.
  EOF
  |> "verify/real_limits_anchor.hexa"
  |> "LIMIT_BREAKTHROUGH.md (per-limit HARD_WALL / SOFT_WALL / BREAKABLE_WITH_TECH / UNCLEAR)"

@D g2 := "lattice-as-tool-not-constraint" :: policy [required active]
  rule = "n=6 lattice is a TOOL. Apply where naturally fits (native lattice spec files); do NOT force-map onto external domains / external entities / general analyses."
  anti = "no artificial ceilings — do not bound this project's ambition by lattice fit"
  external_entities_exempt = ["companies", "fabs", "accelerators", "life systems"]
  |> "selftest/lattice_fit_on_external_entities_audit.py"

@D g3 := "honesty-external-and-unproven" :: policy [required active]
  rule <<~EOF
    Predictions ≠ measurements. GNoME / OMat24 / Matlantis / NNP outputs are
    PREDICTIONS — preserve verbatim in smoke output and SOURCES.md.
    UNPROVEN/UNVERIFIED markers stay verbatim: LK-99, metallic-H, magic-MOF
    DAC $100/t, CNT yarn 80 GPa lab-mm, Majorana contested, marine-biodegradable
    PHA, …
  EOF
  |> "selftest/hardwall_provenance_audit.py"
  |> "selftest/carbon_cnt_strength_honesty_audit.py"
  |> "selftest/mof_dac_economics_honesty_audit.py"

@D g4 := "commit-conventions" :: policy [required active]
  title    = "<type>(<scope>): <one-line summary>   # Conventional Commits"
  body     = "bullet list of file changes + honesty caveats"
  trailer  = "Co-Authored-By: <model> <noreply@anthropic.com>"

@D g5 := "bridge-rules" :: policy [required active]
  scope = "_python_bridge/ · _research_bridge/ · _absorption_bridge/"
  rules <<~EOF
    1. stdlib fallback — every adapter works on stock Python 3.9+ via stdlib,
       OR cleanly SKIP with `SKIP: <dep> not installed` (exit 0).
       No mocked functionality disguised as real.
    2. OFFLINE selftest only — `--selftest` MUST NOT make live API calls.
       Bundled cache fixtures tagged `SAMPLE FIXTURE — not real data`.
    3. License honesty — every adapter SOURCES.md MUST cite license + paper
       + version. Commercial/non-commercial restrictions flagged loudly
       (Matlantis commercial; AlphaFold-3 non-commercial).
    4. Predictions ≠ measurements — see g3.
  EOF
  aggregators = ["selftest/pyproject_smoke.sh",
                 "selftest/research_bridge_smoke.sh",
                 "selftest/absorption_bridge_smoke.sh"]

@D g6 := "selftest-canonical-scoreboard" :: policy [required active]
  rule = "selftest/run_all.sh is the canonical scoreboard — 38/38 PASS sentinel"
  layers <<~EOF
    verify/run_all.hexa     → 4/4  structural closure (file presence + lattice arithmetic
                                    + real-limits anchor + scoreboard cross-check)
    selftest/run_all.sh     → 38/38 content layer
      breakdown = 8 cross-cutting + 8 group-specific + 4 verb-specific
                + 3 bridge aggregators + 6 adapter-specific gates
                + 1 parity-gates aggregator (29 gates inside)
                + 2 closure-meta gates
                + 3 Phase J.1 deepening audits
                + 1 Phase J.2 universal-FF proxy-predictions
                + 1 Phase J.5 NOVEL ↔ verb xref audit
                + 1 Phase K.1 universal-FF runner (added 2026-05-14)
  EOF
  hexa_native_union <<~EOF
    Phase HX (2026-05-18): run_all.sh `run()` is a hexa-first UNION — if
    `_hexa_bridge/selftest/<label>.hexa` exists it runs THAT, else the
    `.py`/`.sh` fallback. T1 6 compute modules + T2 26/26 selftest gates
    are hexa-native; each verified byte-parity vs its `.py` (lossless —
    `grep -E` ERE ≡ Python `re`, NO Stage-1 substring approx, g3
    regression = 0). `.py`/`.sh` retained as fallback + re-parity ref.
    Migration SSOT: ~/core/hexa-lang/stdlib/PLAN.md (T1✅ T2✅ T3/T4/T5⏳).
  EOF
  |> "verify/closure_consistency.hexa (README-badge regex fixed 2026-05-18 — verify 3/4→4/4)"

@D g7 := "parity-gates-anchored" :: policy [required active]
  rule = "29 parity gates verify spec↔source parity within published tolerance — NOT measurements"
  category = "(b) formal/empirical material-property parity"
  status   = "100% closed (29/29) as of 2026-05-13 (Phase H 10 + I.1 10 + I.2 9)"
  anchors  = ["NIST", "CRC 105th", "ASM Handbook", "TAPPI", "GIA", "SEMI",
              "ASTM", "AATCC", "ISO", "vendor datasheets (Dyneema, Ductal, Cor-Tuf, …)"]
  honesty  = "UNPROVEN markers in source data preserved verbatim in snapshot metadata"
  |> "selftest/parity_gates_smoke.sh"
  |> "tests/snapshots/*.json"
  sentinel = "__HEXA_MATTER_PARITY_GATES__ PASS (29/29 gates, 0 skipped)"

@D g8 := "closure-framework-abc" :: policy [required active]
  rule <<~EOF
    Category (a) in-repo SW/spec closure   = 100% (4/4 verify + 38/38 selftest + 36/36 specs)
    Category (b) formal/empirical parity   = 100% (29/29 parity gates, 0 UNVERIFIED)
    Category (c) wet-lab/manufacturing-scale closure = OUT-OF-REPO BY DESIGN
      → vendors (Wacker · Wolfspeed · Hitachi Metals · Stora Enso · Climeworks ·
        NatureWorks · Danimer · Element Six · Merck KGaA · …) own this layer
      → 18 (c) items audited 2026-05-13 for SW-side handoff completeness:
        every row has named DEST + LIMIT_BREAKTHROUGH wall classification
    "100% closure" claims here = Category (a) only. C2/C3+ candidates in
    NOVEL.md cannot self-promote to EXTERNAL-VERIFIED.
  EOF
  |> "selftest/c_handoff_completeness_audit.py (gate #29)"
  |> "CLOSURE_STATUS.md"
  |> "CLOSURE_RESIDUAL_BACKLOG.md"

@D g9 := "novel-ledger-discipline" :: policy [required active]
  rule <<~EOF
    NOVEL.md candidates use id `hxm-<class>-<target>-<NNN>` (sister of
    hexa-bio/.roadmap.novel_drugs). Adding a new candidate:
      - status starts at DESIGN
      - MUST define a quantitative falsifier
      - CANNOT claim EXTERNAL-VERIFIED without external wet-lab evidence
    Promotion ladder: DESIGN → SIM-NNP-PROXY → SIM-NNP → EXTERNAL-VERIFIED
  EOF
  |> "selftest/falsifier_wellformed_audit.py"
  |> "selftest/novel_verb_xref_audit.py (Phase J.5)"

@D g10 := "sister-substrate-cross-links" :: policy [recommended active]
  hexa_rtsc   = "room-temp SC sister — `hxm-sc-*` candidates are research-hypothesis ONLY, NOT RT-SC claims"
  hexa_chip   = "semi DEVICE+FAB layer — silicon/ here is MATERIAL layer only"
  hexa_energy = "battery cathode + solid electrolyte candidates are material-layer"
  hexa_bio    = "molecular toolkit — `_absorption_bridge/` pattern and NOVEL.md ledger imported FROM here"

# ────────────────────────────────────────────────────────────────────
# Forbidden patterns
# ────────────────────────────────────────────────────────────────────

@F f1 := "lattice-fit-on-external-entities" :: anti-pattern [denied]
  rule = "External entities (companies · fabs · accelerators · life systems · NIST anchors · vendor datasheets) MUST NOT include lattice-fit assertions"
  fix  = "Use the entity's OWN invariants (NIST SRD numbers, ASM Handbook tables, vendor datasheet values)"
  |> "selftest/lattice_fit_on_external_entities_audit.py"

@F f2 := "predictions-promoted-to-measurements" :: anti-pattern [denied]
  rule = "GNoME / OMat24 / Matlantis / SchNet / MACE / ALIGNN / CHGNet / M3GNet outputs are PREDICTIONS — must not be presented as measurements"
  fix  = "Tag every prediction `SIM-NNP-PROXY` or `SIM-NNP`; only `EXTERNAL-VERIFIED` after external wet-lab evidence"
  |> "selftest/c_handoff_completeness_audit.py"

@F f3 := "live-api-in-selftest" :: anti-pattern [denied]
  rule = "selftest path MUST NOT touch network — use vendored fixtures only"
  fix  = "Adapter `--selftest` mode replays from bundled cache fixture tagged `SAMPLE FIXTURE`"

@F f4 := "unproven-marker-stripped" :: anti-pattern [denied]
  rule = "UNPROVEN / UNVERIFIED markers (CNT yarn 80 GPa lab-mm, magic-MOF DAC $100/t, LK-99, Majorana, marine-biodegradable PHA, …) must NEVER be removed silently"
  fix  = "Preserve verbatim. If contradicting evidence appears, ADD a dated counter-anchor; do not erase the prior marker"

@F f5 := "category-c-self-promotion" :: anti-pattern [denied]
  rule = "Software side cannot self-promote a candidate to EXTERNAL-VERIFIED. C2/C3+ require external wet-lab evidence — out of scope for this repo's `hxm-*` ledger"

# ────────────────────────────────────────────────────────────────────
# Agent checklist (mirrors AGENTS.md §"Quick agent checklist")
# ────────────────────────────────────────────────────────────────────

@N n1 := "pre-commit-checklist" :: workflow [recommended active]
  steps <<~EOF
    [ ] Read INIT.md first — know the current Phase state
    [ ] Run verify/run_all.hexa → confirm 4/4 PASS
    [ ] Run bash selftest/run_all.sh → confirm 38/38 PASS
        (or be explicit if your change adds/removes a gate)
    [ ] Honor LATTICE_POLICY §1.2/§1.3 — real-limits-first, n=6 auxiliary
    [ ] Preserve UNPROVEN / UNVERIFIED markers verbatim
    [ ] If touching NOVEL.md: define quantitative falsifier; don't self-validate
    [ ] If touching a bridge: stdlib fallback or clean SKIP; offline selftest only
    [ ] Trailer: Co-Authored-By: <model> <noreply@anthropic.com>
    [ ] Update INIT.md if change shifts Phase status
  EOF

# ────────────────────────────────────────────────────────────────────
# External citations
# ────────────────────────────────────────────────────────────────────

@X x_lattice_policy := "LATTICE_POLICY.md" :: in-repo-file [active]
  path    = "./LATTICE_POLICY.md"
  status  = "dancinlab-wide real-limits-first verification policy (deployed 2026-05-12)"
  sections = ["§1.2 real-limits catalogue", "§1.3 verification anchor rule"]

@X x_tape_spec := "tape v1.2 spec" :: external-spec [active]
  ssot   = "~/core/tape/spec/tape.md"
  remote = "github.com/dancinlab/tape"
  authority = "the source-of-truth for .tape grammar; this file conforms to v1.2"

@X x_agents_md := "AGENTS.md" :: companion-prose-ssot [active]
  path = "./AGENTS.md"
  role = "long-form prose agent-operating-guide — see @h1 for coexistence rationale"
  size = "~19.6 KB · 329 lines (2026-05-14)"

@X x_init_md := "INIT.md" :: in-repo-file [active]
  path = "./INIT.md"
  role = "pick-it-up-cold entry — Phase A-G status, commit log, hard constraints"

@X x_limit_breakthrough := "LIMIT_BREAKTHROUGH.md" :: in-repo-file [active]
  path = "./LIMIT_BREAKTHROUGH.md"
  role = "project-specific real-limits + per-limit breakthrough assessment (Wave M 2026-05-12)"

@X x_axis_closure_plan := "AXIS_CLOSURE_PLAN.md" :: in-repo-file [active]
  path = "./AXIS_CLOSURE_PLAN.md"
  role = "per-group closure roadmap, Category (a)/(b)/(c) framework"

@X x_hexa_migration_ssot := "hexa-native migration SSOT" :: external-ssot [active]
  path   = "~/core/hexa-lang/stdlib/PLAN.md"
  role   = "SINGLE source-of-truth for the T3/T4/T5 hexa-native migration tracks (hexa-bio gates + hexa-lang science-stack stdlib). append-only `## 진행 로그` — read its tail for current state."
  rule   = "do NOT duplicate migration status into hexa-matter — this repo is a POINTER only. SSOT lives in hexa-lang."
  note   = "T3 (hexa-bio run_all.sh gates → hexa-native) complete 2026-05-19; T4 (atoms/crystal/mol stdlib Stage-2 kernels) landed; T5 pending."

# ────────────────────────────────────────────────────────────────────
# Hooks — file-relationship anchors
# ────────────────────────────────────────────────────────────────────

@H h1 := "agents-md-coexists" :: file-decision [active d=2026-05-14]
  pattern = "COEXISTENCE"
  rationale <<~EOF
    AGENTS.md (19,594 B · 329 lines) is content-rich, project-specific prose:
    - Documentation ledger with verb-by-verb pointers (INIT.md, AXIS.md,
      AXIS_CLOSURE_PLAN.md, CLOSURE_RESIDUAL_BACKLOG.md, deep chapters)
    - Phase E/F/G bridge tables with per-source license · adapter · rate-limit
      detail (16+ external systems: Materials Project, GNoME, Matlantis,
      OMat24, COD, OQMD, AFLOW, NOMAD, NIMS MatNavi, Catalysis-Hub, SchNet,
      MACE, ALIGNN, CHGNet, M3GNet)
    - 29 parity gates table (Phase H 10 + I.1 10 + I.2 9) with NIST/CRC/ASM/
      vendor anchors
    - Closure framework §(a)/(b)/(c) detail
    - Sister-substrate cross-links (hexa-rtsc/hexa-chip/hexa-energy/hexa-bio)
    - Quick agent checklist
    Compressing this to .tape would lose the per-source/per-gate granular
    reference value. AGENTS.tape carries the structured rules + identity +
    governance + forbidden patterns; AGENTS.md remains the long-form prose
    SSOT for source-by-source detail.
  EOF
  @> "AGENTS.md"
  ?> "@x_agents_md"
  ?> "@x_tape_spec"

@H h2 := "claude-md-symlink" :: file-decision [active d=2026-05-14]
  before = "CLAUDE.md -> AGENTS.md"
  after  = "CLAUDE.md -> AGENTS.tape"
  rationale = "tape v1.2 migration — Claude Code reads the structured supplement first; can still walk @x_agents_md to the prose companion"
  -> "ln -sf AGENTS.tape CLAUDE.md"
