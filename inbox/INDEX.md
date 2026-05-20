# inbox/INDEX.md — cross-session pickup SSOT

> Updated 2026-05-20 (κ-53 D-track). Status SSOT for every
> `inbox/notes/*.md` entry. Each entry keeps its own body intact;
> this file is the at-a-glance index.

## Legend

- **resolved** — completed, landed on origin/main; note kept as audit
- **superseded** — covered by a newer entry / decision
- **pickup-open** — actionable, awaits dependency or session
- **pickup-blocked** — toolchain / cross-session dependency
- **archive** — reference / methodology, no further action

## Index (20 entries)

| filename | status | reference | one-liner |
|---|---|---|---|
| `absorption-empty-cells-research-2026-05-20.md` | resolved | κ-47..κ-49 | Deep-research source for ROI 1→18 sweep; all 10 targets dispatched |
| `brand-name-demiurge-pair-with-phanes.md` | resolved | D23/D24/D25 | Brand-rename approved + executed 2026-05-19 |
| `cern_analyze_producer_alternative_decision_2026-05-20.md` | resolved | D74 / κ-51 | ProducerRegistry Option C picked, default = xsuite-tracking |
| `chip-sB-full-curve-parity-handoff.md` | resolved | κ-43 / D70 | chip §B + §D dynamic absorbed=true |
| `cohort-pickup-bot-urdf-producer.md` | resolved | κ-37 / D58 | bot+structure URDF producer landed |
| `cohort-pickup-grid-networkx-producer.md` | resolved | κ-36 | grid+structure networkx producer landed |
| `cohort-pickup-rtsc-femm-producer.md` | resolved | κ-48 + κ-49 | pyfemm rtsc+analyze (κ-48) + GetDP rtsc+verify (κ-49) substrates landed |
| `hexa-8domain-measurement-stack-2026-05-20.md` | resolved | κ-47..κ-49 | 8-domain stack survey consumed by empty-cell sweep |
| `hexa-lang-branch-consolidation-2026-05-20.md` | pickup-blocked | (cross-session) | hexa-lang live tree alignment to origin/main — concurrent session blocker |
| `hexa-lang-stdlib-full-consolidation-2026-05-20.md` | resolved | κ-45 | 15 domain modules consolidated to hexa-lang origin/main |
| `kernel-extraction-pickup.md` | resolved | κ-45 | All 13 D72 kernels landed on hexa-lang origin/main |
| `openmdao-kernel-promotion-pickup.md` | pickup-open | (2nd consumer) | OpenMDAO 2 consumers (scope+space) — promote to kernels/mdo/ |
| `parity_attempt_bot_synth_2026-05-20.md` | resolved | κ-50 | Pinocchio rel err 0.04% / 0.0003% vs Spong; flip NO (URDF hermetic) |
| `parity_attempt_cern_synth_2026-05-20.md` | resolved | κ-51 | xsuite FODO rel err 1e-10; **absorbed=true flip executed** |
| `parity_attempt_energy_synth_2026-05-20.md` | resolved | κ-50 | PyPSA rel err 6e-6 vs scipy LP; flip NO (data-honesty gate) |
| `parity_attempt_scope_synth_2026-05-20.md` | superseded | κ-53 B-track | FAIL @ 87-94% — see v2 note from κ-53 metric fix |
| `parity_attempt_scope_verify_2026-05-20.md` | superseded | κ-53 C-track | 4/5 PASS; WebbPSF retry pending κ-53 C-track |
| `parity_attempt_space_synth_2026-05-20.md` | resolved | κ-50 | Tsiolkovsky rel err ≤1e-4; flip NO (SLSQP bound) |
| `rfc006-s5-area-oracle-parity-handoff.md` | pickup-blocked | (hexa-lang session) | Yosys read_verilog 6-construct multi-week expansion |
| `yosys-dispatcher-use-integration-compile-fail.md` | resolved | (mis-diagnosis) | No action needed, kept as resolution audit |

## Open pickup count

- **pickup-open**: 1 (`openmdao-kernel-promotion-pickup.md` — promotion at 2nd MDO consumer; condition met by κ-47 space+synth + scope+synth, awaits a κ-N kernel extraction round)
- **pickup-blocked**: 2 (`hexa-lang-branch-consolidation-2026-05-20.md` cross-session live-tree alignment + `rfc006-s5-area-oracle-parity-handoff.md` multi-week hexa-lang Yosys session)

## Cross-references

- PLAN.md κ-1..κ-52 (progress log SSOT)
- design.md D1..D74 (decision audit-trail SSOT)
- NEXT_SESSIONS.md (handoff prompts for cross-session work)

## Maintenance

When a note is resolved: add a status line at the head of the note
AND update this INDEX. When a new note lands: append a row here in
the same sweep.
