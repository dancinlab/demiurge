# ABSORPTION — historical log

Spec at [`./ABSORPTION.md`](./ABSORPTION.md). Log entries below preserve session-by-session evolution; the spec file holds only the current confirmed state.

## Log

- 2026-05-20 — created. 외부 라이브러리/도구 흡수 시 ①~⑤ 영역 (STDLIB
  / DOMAIN_MAP / RECORD / WORKFLOW / HONESTY) 분류 + 8-단계 흡수 절차
  + 현재 흡수된 producer 5건 표 + 가벼운 distrib 선호. substrate vs
  absorbed 구분 (Yosys §5 사례) 명시. 새 D-decision 없음 — 기존
  D15/D17/D50/D53~D55 + rfc_001~005 cite.
- 2026-05-20 — **제1 원칙 추가** (사용자 지시): 모든 producer 의
  최종 형태 = hexa-native (`.hexa`), substrate wrapper 는 임시
  stepping-stone. 핵심 원칙 최상단에 박제. + 두 deep-research
  라운드 통합 「흡수 후보 우선순위」 섹션 추가 — 18 빈 measurable
  셀 + 8 도메인 (rtsc·cern·antimatter·ufo·space·fusion·mobility·
  aura) 실측 stack, ROI 순, arxiv reference 동반, macOS-blocked
  honest 명시. 새 D-decision 없음 — research 정리.
- 2026-05-20 — **D72 — ① STDLIB 2-layer** (커널 레이어 + 도메인
  어댑터). 사용자 통찰 "도메인 엄청 추가될 건데 공용 해야" → ①
  영역을 ①a `kernels/<kernel>/` (도메인-무관 재사용 엔진) + ①b
  `<domain>/` (thin 어댑터) 로 재작성. 흡수 절차 체크리스트에
  단계 2.5 (커널 분류) 추가. 정합 갱신처: design.md D72 (SSOT) ·
  AGENTS.tape `g_stdlib_ownership.kernel_layer` · 본 파일 ①
  영역 + 체크리스트. N×M → N+M scaling, hexa-native 제1 원칙과
  시너지.
- 2026-05-20 — κ-39 (D66) — `component + verify` 행이 "현재까지
  흡수된 producer" 표에 추가됨 (gmsh 4.15.2 + scikit-fem 12.0.1,
  GATE_OPEN, absorbed=false). 동시에 "무거운 후보 — 별도 세션 권장"
  표에서 같은 행 제거 — docker (Salome-Meca 5 GB+) 가 아니라 pip
  라이브러리 4종 (gmsh · scikit-fem · meshio · numpy, ~70 MB) 만으로
  흡수가 가능했기 때문 (당초 가정 = docker 필수). SECOND
  D61-compliant-from-birth producer (script SSOT = `~/core/hexa-lang/
  stdlib/component/gmsh_skfem.py`).
- 2026-05-20 — **빈-셀 sweep ROI 1→18 17 cell + firmware 도메인
  추가 (κ-47..κ-49, D73)**. 8 parallel agent + main session direct
  로 sscb/scope/energy/space/bot synth + scope/sscb verify (ROI
  1-10) + 7 verify (ROI 11-18 fusion/energy/bot/space/rtsc/mobility/
  antimatter) substrate landed; demiurge 측 17 cell dispatch wiring.
  honest install-gated / platform-gated skip 패턴 — OpenMC nuclear
  data 3GB · Drake multi-GB · CARLA Unreal · Geant4 multi-hour build
  · CalculiX / GetDP 부재 시 GATE_OPEN + absorbed=false 명시 skip
  record (silent pass 금지). D72 N+M payoff 실현: kernels/
  mc_transport/ 4 consumer (antimatter+analyze, fusion+verify,
  energy+verify, antimatter+verify). cern+analyze 는 substrate 2개
  (pylhe legacy + xsuite-tracking κ-49) — ProducerRegistry D74 로
  routing.
- 2026-05-20 — **cern+synth κ-51 absorbed=true 흡수 + ProducerRegistry
  D74 도입**. cern+synth 가 chip §B+§D (κ-43) 이후 두 번째 *동역학*
  흡수: substrate `xsuite_optics.py` 에 `_analytic_fodo_twiss` (pure-
  Python Wiedemann §6.2 + §7.4 closed-form) 내장 → Xsuite 결과와
  rel err ≤ 1e-6 비교, 통과 시 GATE_CLOSED_MEASURED + absorbed=true.
  관측 parity: β_x_max rel err 2.57e-14, Q_x rel err 4.11e-14 (8
  orders 안쪽). scope_caveats 가 "ALGORITHM-level closure (Xsuite ⇄
  Wiedemann/Lee), NOT measured-lattice closure" 명시 (g3 — flip 의
  의미가 좁음을 정직히 박음). ProducerRegistry (D74) — cells with
  alternatives, `(cern, analyze)` = xsuite-tracking (default) | pylhe
  (legacy). 다른 cell 은 hardcoded switch 그대로 — additive.
- 2026-05-20 — **κ-53 — 5 parallel agent round (firmware dispatch +
  scope+synth metric fix + scope+verify WebbPSF v2 + inbox cleanup +
  NEXT_SESSIONS handoffs)**. firmware (D73) 16번째 도메인 7-cell
  dispatch wired (hexa-lang `350ffd92` + demiurge `73bfcddc`); scope+
  synth area parity 100% PASS (substrate fix 76cce52a, hex-pack
  collecting area + 7/19/37 ring labels); scope+verify WebbPSF v2
  surfaced λ-mismatch design flaw (550 nm vs 4.8 μm, 4 fix options
  surveyed); inbox/INDEX.md SSOT 신규 (20 entries 분류); NEXT_SESSIONS.md
  7 handoff prompts (H-1..H-7) for cross-session heavy installs.
  flip 0 (auto-flip 안 함, g3 honest).
- 2026-05-20 — **κ-54 — D75 scope+verify substrate fix (Option B,
  same-wavelength split)**. 사용자 게이트 "완성도 기준 진행" → 4
  options 중 Option B 채택 (둘 다 살림: 가시광 Airy + JWST cross-
  check at same λ). hexa-lang `03470762` — `check_webbpsf_cross_
  same_wavelength`: NIRCam F480M @ 4.8μm vs kernel propagation
  @ 4.8μm (같은 λ, ±50% tol 의미 있음). 로컬 실행 5/5 PASS (rel_err
  12.78%, tol 50%). absorbed=true flip 권고 NO — D75 가 풀어준
  honesty blocker 1개, 나머지 2 caveats 잔존 (measured optics deck,
  hexa-native FFT IEEE-754).
- 2026-05-20 — **κ-56 — Round 1 phase A: D81 + D82 (chem/bio/ufo
  도메인 추가 + graph DAG 모델 land)**. 사용자 게이트 "Round 1 go"
  + ufo/aura 시뮬레이션 통과 후. 변경:
  (1) D81 chem + bio + ufo 도메인 (16→19) — short-id naming;
      `domains/chem.md` + `domains/bio.md` + `domains/ufo.md`
      skeleton (deliverable / 7-verb 1:1 표 / cited sources / D72
      kernel mapping / cross-domain).
  (2) D82 graph DAG + multi-facet tag — `Domain.swift` 에
      prerequisites + DomainFacets fields 추가. `DomainGraph.swift`
      신규: transitiveClosure BFS / topologicalSort Kahn /
      byScale / byCluster / roots / leaves.
  (3) `DomainCatalog.all` 19 entries — 16 기존 + 3 신규. 각 entry
      에 prerequisites + facets (scale / clusters / hostility) +
      optional substrateSSOT 박음. ufo prereq = [fusion, antimatter,
      rtsc]; bio prereq = [chem, matter]; aura prereq = [rtsc, chip,
      brain, bio, firmware]; fusion prereq = [antimatter, cern,
      energy, rtsc]; 등 시뮬레이션 chain 직접 반영.
  (4) `FalsifierEntry.swift` 신규 (G5 — typed monotone OPEN /
      CONFIRMED / DEMOTED + demotedIf for G6 cascade).
  (5) `SiblingRepoSpawner.swift` 신규 (G3 — D17 sibling-repo
      standardized spawn pattern; matter / ufo / aura / bio / chem /
      cern / antimatter / fusion / rtsc / space / brain / scope 의
      ~/core/hexa-<id>/ entrypoint 자동 resolve).
  build: xcrun swift build --product DemiurgeCLI OK (3.49s).
  g3 — type-layer + 도메인 메타데이터 추가만, 측정 record / gate /
      absorbed 변경 0. INDEX.demi parser (D83) + cockpit NewProjectSheet
      UI 갱신 (G1 UI 부분) 은 후속 phase B.
