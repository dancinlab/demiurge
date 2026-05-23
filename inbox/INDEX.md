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

## Index (38 entries)

| filename | status | reference | one-liner |
|---|---|---|---|
| `2026-05-21-hexa-exec-broken-pipe.md` | pickup-open | hexa runtime / self/runtime.c popen | hexa `exec` subprocess broken — empty stdout + "broken pipe" on all commands. Scope: `self/runtime.c` popen / pipe handling — NOT a stdlib bug. Filed by other session (rfc_006 §5 work). Bonus discovery: `str(float)` emits literal `(float)` token (filed separately). Blocks `stdlib/yosys/gate_record.hexa` end-to-end measurement. Pickup = hexa runtime debug session. |
| `2026-05-21-pool-gate_v3-abc-diagnosis.md` | archive | κ-69 / chip §B / rfc006 §5 substrate-axis | pool cross-platform (Mac arm64 vs ubu-2 Linux x86_64) re-execution of `/tmp/gate_v3` ABC mapping reproduced **identical** failure mode — confirms two `gate_v3` BLIF-emitter bugs (multi-output sky130 cells like `fa_1` fanin serialization · net-node fanin invariant) + wrapper honest-violation (`[abc_map] exit=0` masking Abort trap 6 / Linux assertion as `[OK]`). Platform-invariant ⇒ NOT a macOS abc build issue. Two honest conclusions: (1) wrapper must propagate abc non-zero exit · (2) fix lives in `~/core/hexa-lang/build/artifacts/gate_v3.c` RTLIL→BLIF converter. Pool value reframed: cross-platform falsification of platform-hypothesis, not raw parallelization. Cited from ARCH §12 / rfc006 §5 trail. |
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
| `k69-g32-candidate-research-2026-05-21.md` | pickup-open | κ-69 / G32 / ARCH §11.4 Round 8 | κ-69 G32 next-cell candidate digest — 3 finalist (Aura/EEG · Energy/wind · Ufo/plasma) 의 5-fold lock-in (cell · external oracle · bridge stack · hexa-native scope · PASS criterion) articulated. RANK #1 = Aura/EEG (PhysioNet Sleep-EDF · `aura_mne.py` bridge ✓ · `pilot-dft_naive` 17/17 PASS ✓ · `AuraVerifyRecord` 1-줄 schema 확장 · G33 different-record-type generalization payoff). #2 = Ufo/plasma (substrate 41/41 PASS · prediction-shape 약함 · Stage-4..7 carve-out 필요). #3 = Energy/wind (kernel 신설 필요 · same-record reuse 시 G33 payoff 약함). User pick → D111 박제 → G33 first-flip. |
| `k69-g33-schema-prep-2026-05-21.md` | pickup-open | κ-69 / G33 / ARCH §11.4 Round 8 (POST-G32) | κ-69 G33 schema-prep digest — `MeasuredOracleRef` 재사용성 audit (`EnergyVerifyRecord` G28a 패턴을 `AuraVerifyRecord` 로 generalization). G32 = Aura/EEG 가정. §1 / §3 schema-generalization audit 는 G32 후보 무관 holds; §2 / §4 / §5 estimates 는 후보별 shift. NO code changed · digest only · G33 work-plan skeleton. |
| `k69-substrate-axis-closure-path-2026-05-21.md` | pickup-open | κ-69 / chip §B / §12.1 (f..i) | post-(e) LANDED audit — chip §B substrate-axis (f..i) closure path 평가. (e) `fifo_mem` 2-D LHS Option A 가 hexa-lang `c4b35b13` + `a4a032af` (2026-05-21) 직접 push 로 LANDED 후 잔여 Tier-1 (f..i) `measurement_gate = CLOSED_MEASURED` 까지 가는 최단 honest path + 측정해야 할 unknowns surface. NO ARCH/PLAN/HANDOFF mutation — 조사 결과 직접 inbox 박제. |
| `k69-substrate-axis-yosys-stat-measurement-2026-05-21.md` | archive | κ-69 / chip §B / SSOT (kk)/(ll) | historical · measurement caveat in (ll) — `yosys -p stat` cell-type breakdown (hexa-native vs substrate) for post-(e) 98% area gap disambiguation. dff_ratio 40× · comb_ratio 7.7-12.1× · Option F algebra. **Cell-type breakdown remains authoritative**, but the area numbers (1207/1677 µm²) were based on stale `/tmp/*_out.blif` files; reconciled in SSOT (kk)/(ll) at commit `1b63afa` (truncate-before-exec fix). Read for breakdown structure, not absolute area. |
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

- **pickup-open**: 11 (`2026-05-21-hexa-exec-broken-pipe.md` hexa runtime `exec` subprocess broken — popen/pipe handling, blocks stdlib/yosys/gate_record.hexa measurement · `openmdao-kernel-promotion-pickup.md` 2nd MDO consumer · `rfc006-s5-area-oracle-parity-handoff.md` next-session entry = §5 gate refined to [58,675, 64,851] µm² with oracle 61,762.99 reproducible; sub-steps #4g/#4h/#4i + hexa-cc strlit-init PR + sv2v pre-step · `hexa-native-port-pattern-pilot-mc-transport.md` D80 hexa-native mc_transport 1-D pilot · `k68-cell-pick-2026-05-21.md` κ-68 cell pick anchor — Energy/solar + NREL MIDC direction, 5 sub-decisions queued · `k68-d109-draft-2026-05-21.md` G27 D-block 초안 (D109 land 후 audit trail) · `k68-g28-measured-oracle-ref-sketch-2026-05-21.md` G28 Swift schema 초안 (G28a 4a1a087 land 후 audit trail) · `k68-g30-revised-2026-05-21.md` G30 revised plan Stage 1 XCTest mandatory + Stage 2 constitution deferred · `k69-g32-candidate-research-2026-05-21.md` G32 next-cell candidate digest (3 finalist + RANK #1 Aura/EEG) · `k69-g33-schema-prep-2026-05-21.md` G33 schema-prep digest (MeasuredOracleRef generalization) · `k69-substrate-axis-closure-path-2026-05-21.md` chip §B substrate-axis (f..i) post-(e) closure-path audit)
- **pickup-blocked**: 2 (`hexa-lang-branch-consolidation-2026-05-20.md` cross-session live-tree alignment · `openmc-install-blocker-2026-05-20.md` osx-arm64 + Linux pool unreachable)

## Cross-references

- PLAN.log.md κ-1..κ-67 (progress log archive · PLAN.md 2026-05-22 흡수)
- design.md D1..D108 (decision audit-trail SSOT · D104 reserved)
- NEXT_SESSIONS.md (handoff prompts for cross-session work)
- proposals/rfc_013_hexa_native_parity_connection.md (κ-67 promotion target · MOSTLY-LANDED per D105)
- ARCH.md §11.4 G1..G30 Round 1-7 (+ G25/G26 post-closure bracket · Round 7 G27..G30 scaffold `[ ]` placeholder · κ-68 per-cell measured-oracle round)

## Maintenance

When a note is resolved: add a status line at the head of the note
AND update this INDEX. When a new note lands: append a row here in
the same sweep.
