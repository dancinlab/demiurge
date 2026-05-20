# inbox/INDEX.md — cross-session pickup SSOT

> Updated 2026-05-21 (κ-67 closure + ARCH §11.4 Round 7 scaffold + κ-68 cell pick).
> Status SSOT for every `inbox/notes/*.md` entry. Each entry keeps
> its own body intact; this file is the at-a-glance index.

## Legend

- **resolved** — completed, landed on origin/main; note kept as audit
- **superseded** — covered by a newer entry / decision
- **pickup-open** — actionable, awaits dependency or session
- **pickup-blocked** — toolchain / cross-session dependency
- **archive** — reference / methodology, no further action

## Index (32 entries)

| filename | status | reference | one-liner |
|---|---|---|---|
| `absorption-empty-cells-research-2026-05-20.md` | resolved | κ-47..κ-49 | Deep-research source for ROI 1→18 sweep; all 10 targets dispatched |
| `brand-name-demiurge-pair-with-phanes.md` | resolved | D23/D24/D25 | Brand-rename approved + executed 2026-05-19 |
| `cern_analyze_producer_alternative_decision_2026-05-20.md` | resolved | D74 / κ-51 | ProducerRegistry Option C picked, default = xsuite-tracking |
| `chip-sB-full-curve-parity-handoff.md` | resolved | κ-43 / D70 | chip §B + §D dynamic absorbed=true |
| `cohort-pickup-bot-urdf-producer.md` | resolved | κ-37 / D58 | bot+structure URDF producer landed |
| `cohort-pickup-grid-networkx-producer.md` | resolved | κ-36 | grid+structure networkx producer landed |
| `cohort-pickup-rtsc-femm-producer.md` | resolved | κ-48 + κ-49 | pyfemm rtsc+analyze (κ-48) + GetDP rtsc+verify (κ-49) substrates landed |
| `d80-sweep-close-2026-05-20.md` | archive | D87..D108 / κ-67 / RFC 013 | D80 sweep close — 2026-05-20 single-session digest (15 PILOTS rows · 14 kernel folders · 5 .demi SSOT · 5 cockpit Loader · 4-case chip · 19/19 도메인 narrative · D104 reserved · RFC 013 MOSTLY-LANDED · D108 closure); self-contained cold-start anchor for next session / external reviewer. NOTE — pre-geodesy snapshot; post-D108 origin/main has 16 PILOTS rows / 15 kernel folders / 445 cumulative assertions (geodesy pilot #13 via acac78c added the geodesy bridge substrate, 4 consumer ①b adapters queued) |
| `hexa-8domain-measurement-stack-2026-05-20.md` | resolved | κ-47..κ-49 | 8-domain stack survey consumed by empty-cell sweep |
| `hexa-lang-branch-consolidation-2026-05-20.md` | pickup-blocked | (cross-session) | hexa-lang live tree alignment to origin/main — concurrent session blocker |
| `hexa-native-connection-plan-2026-05-20.md` | resolved | RFC 013 / κ-67 | SHAPE note promoted to `proposals/rfc_013_hexa_native_parity_connection.md` — wiring from hexa-lang substrate parity to demiurge `absorbed` flag |
| `hexa-native-port-pattern-pilot-mc-transport.md` | pickup-open | (D80 g_hexa_only pilot) | Minimum-viable hexa-native mc_transport 1-D slab pilot — port without OpenMC / Geant4 / nuclear-data |
| `hexa-lang-stdlib-full-consolidation-2026-05-20.md` | resolved | κ-45 | 15 domain modules consolidated to hexa-lang origin/main |
| `kernel-extraction-pickup.md` | resolved | κ-45 | All 13 D72 kernels landed on hexa-lang origin/main |
| `k68-cell-pick-2026-05-21.md` | pickup-open | κ-68 / G27 / RFC 013 §6.11 | κ-68 첫 measured-oracle absorbed flip 의 cell pick — Energy (solar) + NREL MIDC pyranometer GHI direction. 5 open sub-decisions (station / window / bridge trust / PASS criterion / D-number) queued for G27 D-block (D109 후보). 회피 후보: Fusion (D106 illustrative) · ChipAnalyze (YOSYS 별 세션) · Aura (heavy oracle infra) · Ufo (closed-form only). |
| `k68-d109-draft-2026-05-21.md` | pickup-open | κ-68 / G27 / D109 후보 | design.md D109 entry 초안 — Energy/solar + NREL MIDC SRRL Golden CO + single clear-sky day 1-min cadence + pvlib clearsky trusted bridge + mean rel_err ≤ 5% PASS criterion 의 5 default 를 baked-in 한 decision-only D-block. 사용자 승인 후 design.md 에 land. code 0 · scope 박제만. |
| `k68-g28-measured-oracle-ref-sketch-2026-05-21.md` | pickup-open | κ-68 / G28 / Swift schema | `MeasuredOracleRef` typed struct sketch (Codable Sendable · 8 field · isMeasuredOraclePASS computed) + `EnergyVerifyRecord` additive field (`measuredOracle: MeasuredOracleRef?`). 6 open design questions (time-series carrier · unit field · PASS evaluation · type 재사용성 · derived computed property · intermediate state UI). 사용자 review 후 Swift land. |
| `k68-g30-governance-row-sketch-2026-05-21.md` | superseded | κ-68 / G30 / AGENTS.tape (archived) | **SUPERSEDED 2026-05-21** by `k68-g30-revised-2026-05-21.md` — post-1a620ad/.tape archive + bd28631 redirect. body content 는 audit trail 로 보존 (XCTest sketch §6 는 revised 안에서도 load-bearing). |
| `k68-g30-revised-2026-05-21.md` | pickup-open | κ-68 / G30 / Stage 1 XCTest + Stage 2 constitution | post-archive revised G30 plan. **Stage 1** (MANDATORY · load-bearing) = `AbsorbedNeedsMeasuredOracleTests.swift` XCTest invariant 3 method (testAbsorbedRequiresMeasuredOraclePASS · testAbsorbedNotAutoflippedByD95Computed · testD106IllustrativeCellExemptFromMeasuredOracle). **Stage 2** (DEFERRED) = `.specify/memory/constitution.md` row · constitution.md template-only 인 동안 land 보류. 5 open Q (κ-68 closure stage boundary · scan scope · D106 detection · commit boundary · test 갯수). |
| `openmc-install-blocker-2026-05-20.md` | pickup-blocked | (Track D / H-3) | OpenMC + ENDF/B-VIII.0 install fails on osx-arm64 + Linux pool unreachable — k-eff measurement deferred |
| `openmdao-kernel-promotion-pickup.md` | pickup-open | (2nd consumer) | OpenMDAO 2 consumers (scope+space) — promote to kernels/mdo/ |
| `parity_attempt_bot_synth_2026-05-20.md` | resolved | κ-50 | Pinocchio rel err 0.04% / 0.0003% vs Spong; flip NO (URDF hermetic) |
| `parity_attempt_cern_synth_2026-05-20.md` | resolved | κ-51 | xsuite FODO rel err 1e-10; **absorbed=true flip executed** |
| `parity_attempt_energy_synth_2026-05-20.md` | resolved | κ-50 | PyPSA rel err 6e-6 vs scipy LP; flip NO (data-honesty gate) |
| `parity_attempt_scope_synth_2026-05-20.md` | superseded | v2 (κ-53 B-track) | FAIL @ 87-94% — superseded by v2 after κ-53 metric fix |
| `parity_attempt_scope_synth_2026-05-20-v2.md` | resolved | κ-53 B-track | Hex-pack area 100% (3 shelves, trivial by construction); flip NO (3 other v1 caveats unchanged) |
| `parity_attempt_scope_verify_2026-05-20.md` | superseded | v3 / D75 | v1 — 4/5 PASS (WebbPSF env missing) |
| `parity_attempt_scope_verify_2026-05-20-v2.md` | superseded | v3 / D75 | v2 — 4/5 PASS (WebbPSF env installed, λ-mismatch design flaw surfaced + 4 options) |
| `parity_attempt_scope_verify_2026-05-20-v3.md` | resolved | κ-54 / D75 | 5/5 PASS after same-wavelength split; flip still NO (other caveats) |
| `parity_attempt_space_synth_2026-05-20.md` | resolved | κ-50 | Tsiolkovsky rel err ≤1e-4; flip NO (SLSQP bound) |
| `rfc006-s5-area-oracle-parity-handoff.md` | pickup-open | (next session) | (o)-(s) cumulative: #4j fixed (sed workaround) · router_d4 RTLIL first-measured 35 comb / 0 sequential · cell-name source-mapped to generate-for L48-55 · **oracle reproduced bit-exact 61,762.985600 µm² on yosys 0.65 + SKY130 tt-corner via `synth -top router_d4` macro + flat_v2k/router_d4.v** — §5 gate refined target ∈ [58,675, 64,851] µm² (±5%), seq/comb split ~79/21%; next: hexa-cc strlit-init unique-emit PR (workaround removal) + #4g/#4h/#4i sequential emit + sv2v pre-step + share/freduce parity |
| `yosys-dispatcher-use-integration-compile-fail.md` | resolved | (mis-diagnosis) | No action needed, kept as resolution audit |

## Open pickup count

- **pickup-open**: 7 (`openmdao-kernel-promotion-pickup.md` 2nd MDO consumer · `rfc006-s5-area-oracle-parity-handoff.md` next-session entry = §5 gate refined to [58,675, 64,851] µm² with oracle 61,762.99 reproducible; sub-steps #4g/#4h/#4i + hexa-cc strlit-init PR + sv2v pre-step · `hexa-native-port-pattern-pilot-mc-transport.md` D80 hexa-native mc_transport 1-D pilot · `k68-cell-pick-2026-05-21.md` κ-68 cell pick anchor — Energy/solar + NREL MIDC direction, 5 sub-decisions queued · `k68-d109-draft-2026-05-21.md` G27 D-block 초안 (D109 land 후 audit trail) · `k68-g28-measured-oracle-ref-sketch-2026-05-21.md` G28 Swift schema 초안 (G28a 4a1a087 land 후 audit trail) · `k68-g30-revised-2026-05-21.md` G30 revised plan Stage 1 XCTest mandatory + Stage 2 constitution deferred)
- **pickup-blocked**: 2 (`hexa-lang-branch-consolidation-2026-05-20.md` cross-session live-tree alignment · `openmc-install-blocker-2026-05-20.md` osx-arm64 + Linux pool unreachable)

## Cross-references

- PLAN.md κ-1..κ-67 (progress log SSOT)
- design.md D1..D108 (decision audit-trail SSOT · D104 reserved)
- NEXT_SESSIONS.md (handoff prompts for cross-session work)
- proposals/rfc_013_hexa_native_parity_connection.md (κ-67 promotion target · MOSTLY-LANDED per D105)
- ARCH.md §11.4 G1..G30 Round 1-7 (+ G25/G26 post-closure bracket · Round 7 G27..G30 scaffold `[ ]` placeholder · κ-68 per-cell measured-oracle round)

## Maintenance

When a note is resolved: add a status line at the head of the note
AND update this INDEX. When a new note lands: append a row here in
the same sweep.
