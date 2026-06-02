#!/usr/bin/env tape
# IMPORTED_FROM_CANON.tape — meta import-record for dancinlab/hexa-bio
#
# Documents items migrated from canon@mk1 (retired 2026-05-11).
# Routing post-retirement: active formal/lean4 → hexa-meta;
# frozen Theorem B / MechVerif content → nexus/canon-infra/legacy-canon.

@V := "tape" :: spec [active]
  version = "1.2"

# ─── §1 Identity ─────────────────────────────────────────────────────

@I id001 := "imported-from-canon" :: identity-claim [d=2026-05-16 active]
  kind = "meta/import-record — canon@mk1 migration manifest for hexa-bio"
  brief = "Files moved from dancinlab/canon at canon@a86ca143 (2026-05-10) during canon-minimization migration; prior history recoverable via git log in canon"
  parent = "dancinlab/hexa-bio"
  tape-class = "meta/import-record"
  sibling-md = "IMPORTED_FROM_CANON.md"
  sibling-log = "IMPORTED_FROM_CANON.log.tape"
  rewritten-from = "IMPORTED_FROM_CANON.tape pre-2026-05-16 (no honesty-lint compliance)"
  canon-retirement = "canon@mk1 RETIRED 2026-05-11 · active formal/lean4 → hexa-meta · frozen Theorem B/MechVerif → nexus/canon-infra/legacy-canon"

# ─── §2 Scope disclaimer ─────────────────────────────────────────────

@N scope_disclaimer := "scope and honesty boundary for this import-record" :: note [required d=2026-05-16]
  text = "This tape is a MIGRATION MANIFEST — it records what files were physically relocated from canon to hexa-bio at canon@a86ca143 (2026-05-10). It makes no scientific claims. The n=6 lattice does NOT appear as a derivation tool here. The imported papers (n6-genetics-paper.md, n6-synthetic-biology-paper.md, etc.) were authored under the n=6 framework; the fact that they ARE named n6-papers is recorded as provenance (artifact names), not as endorsement that n=6 is scientifically valid. All in-silico / wet-lab boundary caveats from AGENTS.tape g8_in_silico_only apply to those papers' content. Canon retirement context (2026-05-11) means hexa-bio now holds these artifacts as read-side archive; no active development continues inside canon itself."

# ─── §3 Honesty preamble (meta-mode, LATTICE_POLICY g1/g2/f1) ───────

@F f_lattice_fit := "lattice-fit-in-import-record" :: governance [required deny:write]
  pattern = "Deriving any scientific claim (efficacy / count / ratio / closure-grade) FROM the n=6 lattice (σ=12, τ=4, φ=2, J₂=24) because this tape lists papers whose titles contain 'n6'."
  why = "The 'n6' in the paper names is a provenance label (artifact-name), not a derivation. Recording that a file named n6-genetics-paper.md was moved from canon is history; asserting genetics results derive from the n=6 lattice is the forbidden anti-pattern this guard forbids."
  exception = "artifact names containing 'n6' are OBSERVATION / provenance only — the import-record may list them verbatim"
  remedy = "Future entries must cite the real underlying source (commit hash / wet-lab data / sister-repo gate) for any claim; never the lattice as derivation"
  authority = "[@x_lattice_policy] g1/g2 · hexa-bio AGENTS.tape f1 · [@x_agents_tape] g_meta_mode_optin"

@N n6_honest_stance := "import-record lattice mentions are provenance labels, not derivation" :: note [required d=2026-05-16]
  text = "Stated plainly and honestly: the paper files listed below carry 'n6' in their filenames. This is an artifact-naming convention from canon; it is PROVENANCE (the name the file was given when it was created), not a claim that genetics / synthetic biology / hexa-bio integration results DERIVE from the n=6 lattice. Per LATTICE_POLICY g1/g2 + lattice-as-tool, the lattice is declined here as a derivation tool. The import-record asserts no science from the lattice. The honesty contract for this meta tape is satisfied via governance citations per meta-mode opt-in (AGENTS.tape g_meta_mode_optin, d=2026-05-16)."

# ─── §4 Import inventory ─────────────────────────────────────────────

@N import_inventory := "files imported from canon@a86ca143 (2026-05-10)" :: note [active d=2026-05-10]
  source-repo = "dancinlab/canon"
  source-commit = "a86ca143"
  import-date = "2026-05-10"
  canon-retirement-date = "2026-05-11"
  routing-post-retirement = "active formal/lean4 → hexa-meta · frozen Theorem B/MechVerif → nexus/canon-infra/legacy-canon"
  items = [
    "papers/embody-p11-2-nanobot-gen2-2026-04-15.md",
    "papers/hexa-weave-formal-mechanical-w2-2026-04-28.md",
    "papers/n6-dolphin-bioacoustics-paper.md",
    "papers/n6-genetics-paper.md",
    "papers/n6-hexa-bio-integrated-paper.md",
    "papers/n6-hexa-limb-paper.md",
    "papers/n6-hexa-skin-paper.md",
    "papers/n6-synthetic-biology-paper.md"
  ]
  note = "All 'n6-*' filenames are artifact-name provenance from canon's naming convention; they are not derivation claims. Prior history recoverable via git log in canon."

# ─── §5 External citations ───────────────────────────────────────────

@X x_lattice_policy := "echoes/LATTICE_POLICY.md" :: governance [active]
  url = "https://github.com/dancinlab/echoes/blob/main/LATTICE_POLICY.md"
  scope = "real-limits-first · lattice-is-tool · observation-not-derivation — the governing authority this honesty preamble enforces"

@X x_agents_tape := "hexa-bio AGENTS.tape" :: governance [active]
  path = "./AGENTS.tape"
  scope = "g_meta_mode_optin (meta-mode opt-in rule, d=2026-05-16) · g1 real-limits-first · g2 lattice-is-tool · g8 in-silico-only · f1 lattice-fit-on-external-entity · g_arch_vs_log_split"

@X x_imported_from_canon_md := "IMPORTED_FROM_CANON.md" :: doc [active]
  path = "./IMPORTED_FROM_CANON.md"
  scope = "long-form prose sibling — canonical human-readable import manifest with full file list and canon-minimization migration context"
