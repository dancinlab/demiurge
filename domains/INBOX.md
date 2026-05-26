# INBOX — current state

@goal: handoff 수신함 — cross-repo gap·request + demiurge 자체 cross-session pickup 을 한 곳에서 추적·해소

(현재 상태만 기록 — 열린 handoff는 `- [ ]` 로, 처리 이력은 `INBOX.log.md` 로)

## 열린 handoff

### cross-repo (→ hexa-lang) patch

- [ ] hexa-lang stdlib **bio-stats kernel** — HW · binomial CI · Wilson CI · Markov^n · ICER 8개 함수 `verify --expr` 확장 (DAPTPGX V2 ledger 10+ atom escalation 가능) · spec: `archive/session-notes/patches/hexa-lang-stdlib-bio-stats.md`
- [ ] hexa-lang **atlas PGx K-kind 확장** — `append-witness` emitter 를 `atlas pr --staging` promoter 가 인식 못함 (0 promoted) → DAPTPGX V2 shard 흡수 불가 · spec: `archive/session-notes/patches/hexa-atlas-pgx-kind-extension.md`

### demiurge cross-session pickup (open)

- [ ] hexa runtime `exec` subprocess broken — empty stdout + broken pipe (`self/runtime.c` popen 처리 · `stdlib/yosys/gate_record.hexa` 측정 차단) · `archive/session-notes/2026-05-21-hexa-exec-broken-pipe.md`
- [ ] hexa-native **mc_transport 1-D slab pilot** — OpenMC/Geant4/nuclear-data 없이 minimum-viable port (D80 g_hexa_only) · `archive/session-notes/hexa-native-port-pattern-pilot-mc-transport.md`
- [ ] κ-68 **cell pick** — 첫 measured-oracle absorbed flip cell (Energy/solar + NREL MIDC) · 5 open sub-decision G27 D-block 대기 · `archive/session-notes/k68-cell-pick-2026-05-21.md`
- [ ] κ-68 **D109 draft** — Energy/solar decision-only D-block 초안 (사용자 승인 후 design.md land) · `archive/session-notes/k68-d109-draft-2026-05-21.md`
- [ ] κ-68 **G28 MeasuredOracleRef** — typed struct sketch + `EnergyVerifyRecord` additive field · 6 open design Q (user review 후 Swift land) · `archive/session-notes/k68-g28-measured-oracle-ref-sketch-2026-05-21.md`
- [ ] κ-68 **G30 revised** — Stage 1 `AbsorbedNeedsMeasuredOracleTests.swift` XCTest invariant (load-bearing) · Stage 2 constitution row (deferred) · `archive/session-notes/k68-g30-revised-2026-05-21.md`
- [ ] κ-69 **G32 candidate research** — 3 finalist (Aura/EEG · Energy/wind · Ufo/plasma) 5-fold lock-in · RANK #1 Aura/EEG → user pick → D111 → G33 first-flip · `archive/session-notes/k69-g32-candidate-research-2026-05-21.md`
- [ ] κ-69 **G33 schema-prep** — `MeasuredOracleRef` 재사용성 audit (`AuraVerifyRecord` generalization) · work-plan skeleton · `archive/session-notes/k69-g33-schema-prep-2026-05-21.md`
- [ ] κ-69 **chip §B substrate-axis (f..i) closure** — post-(e) LANDED 후 Tier-1 (f..i) `measurement_gate=CLOSED_MEASURED` 최단 honest path · `archive/session-notes/k69-substrate-axis-closure-path-2026-05-21.md`
- [ ] **OpenMDAO kernel 승격** — scope+space 2 consumer 조건 충족 → `hexa-lang/stdlib/kernels/mdo/` extraction round 대기 · `archive/session-notes/openmdao-kernel-promotion-pickup.md`
- [ ] **rfc006 §5 area-oracle parity** — oracle bit-exact 재현 (router_d4 61,762.99 µm²) · §5 gate ±5% target 미달 · 다음: hexa-cc strlit-init unique-emit PR + sequential emit + sv2v · `archive/session-notes/rfc006-s5-area-oracle-parity-handoff.md`

### blocked

- [ ] (blocked) **hexa-lang branch consolidation** — live tree origin/main 정렬 · concurrent session 점유 (NEXT_SESSIONS H-1) · `archive/session-notes/hexa-lang-branch-consolidation-2026-05-20.md`
- [ ] (blocked) **OpenMC install** — osx-arm64 wheel 부재 + Linux pool unreachable → k-eff 측정 보류 · `archive/session-notes/openmc-install-blocker-2026-05-20.md`

> 참고: demiurge 의 historical cross-session 노트(~108 notes + INDEX) 는 `archive/session-notes/` 로 이관됨 (구 `inbox/` 폐기). resolved/superseded/archive 항목은 거기 보존 — provenance 인용은 모두 `archive/session-notes/` 경로.
