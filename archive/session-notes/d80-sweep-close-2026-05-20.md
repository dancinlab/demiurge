# D80 sweep close — 2026-05-20 breakthrough digest

> status: **resolved (audit)** — single-session sweep that promoted the
> D80 `g_hexa_only` rule from "schema half" (κ-66, 5e9f6dea) to "RFC 013
> MOSTLY-LANDED" (κ-67 closure + D87..D106 follow-on cascade). This note
> is the cold-start anchor: a new session or external reviewer should
> be able to read it standalone and locate every artifact below.

**Abstract** — On 2026-05-20 demiurge and hexa-lang co-landed 20
D-decisions (D87..D106 · D104 reserved) that wired hexa-lang substrate
parity (13 D80 pilots + 1 Stage-0 chem seed = **15 PILOTS.demi rows**,
375+ assertions PASS at rel_err ≤ 1e-10) to demiurge cell-records via 5
`.demi` SSOTs · 5 cockpit Loaders · an 8-field `HexaNativeParityRef`
record carrier · a 4-case chip UI · a 3-tier link-integrity verifier ·
19/19 domain narrative coverage · and a `.illustrativePhysics` GateType
first-class. **No `absorbed=true` flip on cell records** — substrate-
parity ≠ measurement-parity stays honest. RFC 013 status flipped
PARTIAL-LAND → MOSTLY-LANDED (P-⑩ ① per-cell measured-oracle is the
sole remaining queued item).

---

## 1. Seven elements (self-check — required by handoff prompt)

| element | value |
|---|---|
| **icon** | 🪡 (needle — single-session sweep stitching 20 decisions through one schema fabric) |
| **이름** | D80 sweep close (2026-05-20) |
| **별칭** | κ-67 PARTIAL-LAND → MOSTLY-LANDED sweep · "the D87..D106 cascade" · RFC 013 follow-on round 1 |
| **하는 일** | hexa-lang substrate-parity facts → demiurge cell-record annotation (typed, declarative SSOT, render-only chip, dimension-separated absorbed flag) without duplicating the 44-row dependency audit in Swift and without auto-flipping `absorbed=true` |
| **비유** | 갈비뼈를 흉골에 잇는 hinge — substrate (척추) 와 demiurge cockpit (가슴팍) 사이가 typed schema (갈비) 로 정확히 연결되었지만, 두 SSOT 가 독립 호흡 (Q1: two-SSOT independent) 한다. |
| **ASCII** | `[hexa-lang/stdlib/kernels/<id>/*.hexa] --(PILOTS.demi 15 rows)--> [PilotLoader] --(HexaNativeParityRef 8-field)--> [5 cell records] --(computed isHexaNativeAbsorbed)--> [HexaNativeParityChip 4-case]` |
| **비교** | D72 (2-layer stdlib extraction) 는 *코드* axis 의 N+M; D80 sweep 은 *데이터* axis 의 N+M. D72 가 같은 .hexa kernel 을 여러 producer 가 재사용하게 했다면, D80 sweep 은 같은 substrate-parity fact 를 여러 cell-record 가 typed annotation 으로 재사용한다. 둘 다 single source, multi consumer. |

---

## 2. Five key findings (양 SSOT 독립 · 분 port 패턴 · sibling narrative · verifier 가치 · chip UI 4-case)

### Finding 1 — 양 SSOT independent ontology (Q1 = "two SSOTs independent")

`hexa-lang/inbox/notes/hexa-native-port-pattern-pilot.md` (prose rolling
diary) 와 `demiurge/domains/PILOTS.demi` (machine-readable 8-field)
는 **별도 dimension** 의 SSOT. D93 가 양쪽 cross-link 만 박고, *자동
sync 는 거절*. D97 의 3-tier verifier 도 Tier ③ (advisory prereq
coverage) 는 **warn-only · XCTFail 안 함** — 두 SSOT 가 같은 사실의 두
projection 이 아니라, *prose 권위 vs field 권위* 의 분리 책임. drift
감지는 자동 (CI), drift 해소는 사람. 이 ontology 가 D97 / D98 / D103
모두의 골격.

### Finding 2 — "분 port" 패턴 (heavy-port 의 hexa-native 부분 증명)

D80 의 ultimate-form 정신은 "전부 hexa-native" 이지만, 현실은 heavy-port
substrate (skfem · openmc · pypsa · openmdao · osmnx · poppy 6 row) 가
존재. **D80 pilots #10/#11/#12 가 답을 제시**: skfem 의 `bar1d`
subset (c9ca39e7) · autodiff dual-forward (170f74af) · bio_align
Needleman-Wunsch (d73a2cbf) — 전체 라이브러리가 아니라 *kernel-단위
subset* 으로 port 가능. PILOTS.demi `scope_notes` 필드가 이 부분-port
의 정직 표면 (e.g. "bar1d subset only; full PDE NOT ported"). 새
substrate growth 패턴: 1) kernel 하나 port → 2) PILOTS.demi row +
scope_notes 정직 → 3) 추가 consumer 도착 시 N+M 격상.

### Finding 3 — sibling sub-domain narrative (D96 + D100 의 거꾸로 짝)

D96 (47bf504) 가 5 sibling-bearing 도메인 (rtsc · cern · antimatter ·
fusion · ufo) 에 `**Sibling sub-domains**` 한 줄. D100 (e451037) 가
역방향으로 14 non-sibling 도메인에 `**Substrate** (where the .hexa
kernels live)` 한 줄. 합계 **19/19 도메인 narrative coverage**, SSOT
데이터 (`.demi` 4종) 무변경. "어느 sibling 의 어느 sub-domain 이 이
demiurge 도메인의 substrate 인지" 가 1-pass 확인 가능 — 이전에는
prereq DAG 뿐이라 reader 가 sibling repo 안 폴더 구조까지 따로 읽어야
했음.

### Finding 4 — 3-tier link-integrity verifier 의 진짜 가치

D97 (74a1b92) 의 `SubstrateLinkIntegrityTests` 3 XCTest 가 단순한
existence check 가 아니다 — Tier ① `sibling_path` directory 존재 ·
Tier ② `<sibling_path>/AGENTS.tape` 안 `@I id001 := "<identity_key>"`
선언 보유 · Tier ③ `advisory_prereqs` 가 `DomainGraph.transitiveClosure`
안 존재 (warn-only). **identity drift 까지 잡는 것이 핵심**: sibling
repo 가 rename 되거나 identity 가 바뀌어도 path 만 살아있으면 Tier ①
는 통과하는데 Tier ② 가 잡는다. + D98 (`DependenciesPilotsCrossRefTests`,
9fcf05b + 384101b) 가 같은 패턴을 demiurge 내부 두 .demi 에 적용 —
already-ported deps 가 pilot row 보유 · pilot `kernel_path` 가
실재 · 8-field 무누락. 양쪽 모두 D80 honesty (clone 부재 시 XCTSkip,
silent pass 0).

### Finding 5 — chip UI 4-case (D99 + D106 의 정직성 강제)

D99 (f036f6f) 의 `HexaNativeParityChipModel` 3-case (`absent` 회색 /
`absorbed` 녹색 / `provisional` 노랑) + D106 (f9a9a90) 의 typed
`GateType.illustrativePhysics` 4번째 case (cyan) — 합계 4-case 가 cell
record 의 두 axis (substrate-parity dimension vs cell-measurement
dimension) 를 시각적으로 분리한다.
- **absent (회색)** — `hexaNativeParity = nil`, port 없음 (born-
  unported).
- **absorbed (녹색)** — `parity_status` 가 PASS 토큰 보유 (PILOTS.demi
  의 declarative 사실).
- **provisional (노랑)** — ref 첨부됐는데 PASS 토큰 없음 (heavy-port
  중간 단계).
- **illustrative-physics (cyan, D106)** — substrate-parity PASS 인데
  kernel 자체가 illustrative (mc_slab_demo 같은 single-energy-group /
  closed-form analytic / pattern-proof). cell-level absorbed flip 은
  여전히 외부 measured oracle 필요. `FusionVerifyRecord` 가 canonical
  occupant. RFC 013 §6.12 의 가장 미묘한 anti-conflation gate.

### Finding 6 — D103 dimension-separation docstring (코드 변경 0, 의미 강화)

D103 (105315e) 는 코드를 안 바꾸고 5 cell record 의 `absorbed: Bool`
docstring 만 추가. 두 dimension (측정-oracle vs substrate-parity) 가
이미 별도 SSOT (per-cell measured oracle vs `PILOTS.demi.parity_status`)
인데, producer 작성자가 substrate-parity PASS 를 보고 stored
`absorbed = true` 자동 flip 시킬 risk 를 docstring 으로 차단. **컴파일러
가 잡을 수 없는 semantic gate 를 코멘트로 enforce** — D80 honesty
floor 의 가장 작은 surface intervention.

### Finding 7 — hexa-lang language fixes (substrate-side gotchas 발견)

분-port 패턴의 부산물: hexa-lang 자체 fix 2종이 같은 sweep 에 land —
codegen param-shadow + `stdlib/core/math/wrap_pi`. URDF FK 2-link
pilot 의 wrap_pi sign flip 발견이 `pattern-pilot.md` 안 prose 로 기록
(.demi 8-field 로 표현 안 됨 — Finding 1 의 양 SSOT independent ontology
가 정당화). D93 양쪽 유지 결정의 *왜* 가 이 fix-discovery 표면에서
입증.

---

## 3. SHA cite — 양 repo 의 핵심 commits

### demiurge (origin/main, branch d80-breakthrough 의 base 는 f9a9a90)

| SHA | D | role |
|---|---|---|
| `cea3c66` | (κ-67 promotion) | rfc_013 publication |
| `5e9f6de` | (κ-66 schema half) | `HexaNativeParityRef` 8-field + `DependenciesLoader` land |
| `2d07fd8` | D87..D94 foundation | PILOTS.demi seed + DEPENDENCIES.demi relocate + PilotLoader + allHardcoded purge |
| `efa4afe` | D94 phase T7 | Producer ↦ `PilotLoader.find(id:)` auto-lookup wire |
| `a5d12d2` | D95 | cell absorbed flip = computed property over PILOTS.demi parity_status |
| `47bf504` | D96 | sibling sub-domain narrative line on 5 domains/<id>.md |
| `74a1b92` | D97 | 3-tier substrate link-integrity verifier (Q3=A) |
| `9fcf05b` + `384101b` | D98 | DEPENDENCIES.demi ↔ PILOTS.demi dual-source CI |
| `f036f6f` | D99 | HexaNativeParityChip — 3-case visualize cell parity ref |
| `e451037` | D100 | substrate narrative line on 14 non-sibling domains/<id>.md (Q2 reverse) |
| `8fc0862` | D101 | deprecate `DEMIURGE_HEXA_LANG` env fallback |
| `a033def` | D102 | chem 첫 PILOTS row `[pilot-chem_arrhenius]` (P-⑫ chem ②) |
| `105315e` | D103 | cell `absorbed` vs `isHexaNativeAbsorbed` = 2 orthogonal dimensions |
| `943a5b8` | D105 | RFC 013 status PARTIAL-LAND → MOSTLY-LANDED |
| `f9a9a90` | D106 | `.illustrativePhysics` GateType first-class (P-⑩ ③ · RFC 013 §6.12 LANDED) |
| `87cb765` | (D80 #9) | pilot #9 doc — breaker_trace_reduce_kernel |
| `c63f406` | (D80 #10) | pilot #10 doc — bar1d_kernel |
| `f28c1b0` | (D80 #11) | pilot #11 doc — dual_forward_kernel |
| `a2fcb1b` | (D80 #12) | pilot #12 doc — needleman_wunsch_kernel |
| `bb7bac2` | (ARCH) | §11.4 G13-G18 Round 5 checklist extension |

### hexa-lang (origin/main)

| SHA | role |
|---|---|
| `b1745c3a` | D80 pilot #9 — circuit `breaker_trace_reduce_kernel` |
| `c9ca39e7` | D80 pilot #10 — fem `bar1d_kernel` (skfem subset port) |
| `170f74af` | D80 pilot #11 — autodiff `dual_forward_kernel` |
| `d73a2cbf` | D80 pilot #12 — bio_align `needleman_wunsch_kernel` (first bio kernel) |
| `78aee88d` | chem domain substrate seed — Arrhenius kernel scaffold (Stage-0) |
| `aaa9d109` | D87+D88+D93 mirror — relocate DEPENDENCIES.demi to demiurge, cross-link pattern-pilot.md to PILOTS.demi |
| `2139dbd1` | D80 pilot #8 — mc_transport `transport_kinematics_kernel` |
| `c668702b` | D80 pilot #5 — plasma `plasma_metrics_kernel` |

### D104 reservation note

D104 was claimed pre-rebase by what became D106; D105 took precedence
chronologically (status refresh landed first), so D104 is reserved /
skipped in the design.md decision sequence. No semantic content lost
— D104 is a numbering gap, not a missing decision.

---

## 4. Decisions table (D87..D106 한 줄 each)

| D | one-line |
|---|---|
| D87 | `.demi` 보관 위치 = `demiurge/domains/` (양쪽 sharded X) |
| D88 | `DEPENDENCIES.demi` 위치 = hexa-lang → demiurge 로 이동 (verbatim) |
| D89 | `DomainCatalog.allHardcoded` 19-도메인 Swift literal 폐기 (D86 정합) |
| D90 | `PILOTS.demi` 8-field schema (`HexaNativeParityRef` 1:1) |
| D91 | `PILOTS.demi` row 단위 = kernel 별 1 row (assertion-per-row X) |
| D92 | `demiurge/domains/` 디렉토리 구조 = flat (4 files) |
| D93 | pattern-pilot.md ↔ PILOTS.demi 양쪽 유지 + mutual cross-link |
| D94 | emit 시 parity_ref = `PilotLoader.find(...)` (T7 phase wire) |
| D95 | cell-record `isHexaNativeAbsorbed` = computed (NOT stored) |
| D96 | sibling sub-domain narrative line on 5 `domains/<id>.md` |
| D97 | 3-tier substrate link-integrity verifier (Q3 = A; SUBSTRATE_LINKS.demi + 3 XCTest) |
| D98 | `DEPENDENCIES.demi ↔ PILOTS.demi` dual-source consistency CI |
| D99 | cockpit `HexaNativeParityChip` 3-case 시각화 (render-only) |
| D100 | substrate narrative line on 14 non-sibling `domains/<id>.md` (D96 reverse) |
| D101 | `DEMIURGE_HEXA_LANG` env-var deprecation (D3/D88 follow-up) |
| D102 | chem 첫 PILOTS row `[pilot-chem_arrhenius]` (Stage-0 scaffolding, no external oracle) |
| D103 | cell `absorbed` vs `isHexaNativeAbsorbed` = 2 orthogonal dimensions (docstring-only) |
| D104 | **reserved** (numbering gap — pre-rebase D104 claim merged into D106) |
| D105 | RFC 013 status refresh: PARTIAL-LAND → MOSTLY-LANDED (κ-67 sweep reconciliation) |
| D106 | `.illustrativePhysics` GateType first-class (P-⑩ ③ · RFC 013 §6.12 LANDED) |

---

## 5. Topology (15 PILOTS.demi rows + 14 kernel folders + 5 SSOT + 5 Loader)

### 15 PILOTS.demi rows (origin/main verified, kernel-per-row)

| # | row id | kernel folder | parity_status | hexa-lang SHA |
|---|---|---|---|---|
| 1 | `pilot-solar` | solar | 21/21 PASS @ ≤1e-13 | (κ-65 sweep) |
| 2 | `pilot-mc_transport` | mc_transport | 8/8 PASS @ ~1e-3 @ N=1e5 (illustrative) | (κ-65) |
| 3 | `pilot-neural_lif` | neural | 23/23 PASS @ ≤2e-15 | (κ-65) |
| 3b | `pilot-orbital_kepler` | orbital | 41/41 PASS @ 0.0 | (κ-65) |
| 4 | `pilot-graph_bfs` | graph | PASS (concurrent · networkx companion) | (κ-65) |
| 5 | `pilot-urdf_fk_2link` | urdf | PASS (concurrent · yourdfpy companion) | (κ-65) |
| 5b | `pilot-plasma_metrics` | plasma | 27/27 PASS @ 0.0 | `c668702b` |
| 6 | `pilot-dft_naive` | signal_proc | 17/17 PASS @ ≤1e-12 | (κ-65) |
| 7 | `pilot-event_queue` | noc_sim | 36/36 PASS exact | (κ-65) |
| 8 | `pilot-transport_kinematics` | mc_transport | 41/41 PASS @ 0.0 | `2139dbd1` |
| 9 | `pilot-breaker_trace_reduce` | circuit | 24/24 PASS @ 0.0 | `b1745c3a` |
| 10 | `pilot-fem_bar1d_subset` | fem | 53/53 PASS @ 0.0 (skfem subset) | `c9ca39e7` |
| 11 | `pilot-autodiff_dual_forward` | autodiff | 48/48 PASS (≤7e-16 abs + companion rel=0) | `170f74af` |
| 12 | `pilot-bio_align_nw` | bio_align (NEW) | 36/36 PASS @ 0 (integer DP) | `d73a2cbf` |
| seed | `pilot-chem_arrhenius` | chem (NEW, Stage-0) | 6/6 PASS (no external oracle) | `78aee88d` |

**총 substrate-side 376 assertions PASS** (numeric 376 + 2 concurrent
PASS rows; 13 D80 pilots + 1 Stage-0 chem seed + chem이 13th unique
domain entry; bio_align 이 first true D80 pilot in molecular tier).

### 14 stdlib/kernels/<id>/ folders

`autodiff · circuit · fem · graph · logic_synth · mc_transport · neural
· noc_sim · orbital · plasma · signal_proc · solar · urdf · wave_optics`

Note: `bio_align` 과 `chem` 은 `stdlib/kernels/` 하위에 별도 폴더로
존재 (위 ls 결과의 14개 는 origin/main 시점 캡처; D80 #12 `bio_align`
+ chem seed 가 같은 트리에 추가됨). `logic_synth` 와 `wave_optics`
는 D80 pilot 이 아닌 RFC 006/RFC 073 (Yosys 흡수) substrate. PILOTS.demi
seed 이전에 흡수된 `kernel-logic_synth` 는 D98 cross-ref CI 의
allowlist 로 surface.

### 5 `.demi` SSOTs (demiurge/domains/ 직속, flat per D92)

1. `INDEX.demi` — 19 domain records (D83 schema + D82 DAG)
2. `PRODUCERS.demi` — sibling-repo dispatch declarative (D85)
3. `DEPENDENCIES.demi` — 44-row substrate audit (relocated D88)
4. `PILOTS.demi` — 15 row 8-field (D87..D91 + D94..D95 + D102)
5. `SUBSTRATE_LINKS.demi` — 5 row 4-field sibling identity (D97)

### 5 cockpit Loaders (DemiurgeCore/Loaders/)

`DomainLoader` · `ProducerLoader` · `DependenciesLoader` · `PilotLoader`
· `SubstrateLinksLoader` — 모두 `DemParser` 재사용, D80 honesty
(SSOT-missing → 빈 array + stderr warn, no Swift hardcoded fallback).

---

## 6. Cross-links

- **RFC 013** — `proposals/rfc_013_hexa_native_parity_connection.md`
  (κ-67, status MOSTLY-LANDED per D105). §6.1..§6.10 LANDED with SHA
  cross-link, §6.11 = P-⑩ ① per-cell measured-oracle (still queued),
  §6.12 = D106 LANDED.
- **NEXT_SESSIONS** — P-⑩ (cell measured-oracle parity round) · P-⑪
  (next D80 pilot batch) · P-⑫ (chem 2nd consumer + Python substrate
  trigger).
- **ARCH §11.4 G1–G18 Round 5** — `ARCH.md` L1264..L1503 (Round 5
  D87..D101 checklist, G13..G18 all `[x]`, post-sweep doc anchor
  `bb7bac2`).
- **design.md** D87..D106 — `design.md` L3391..L4047 (decisions audit
  trail, 20 entries · D104 reserved).
- **PLAN κ-history** — κ-65 (audit + 4 pilots + connection-plan) · κ-66
  (schema half) · κ-67 (RFC 013 promotion + sweep close · D87..D106
  cascade).
- **AGENTS.tape @D** — `g_hexa_only` (D80) · `g_no_hardcoded_data` (D86)
  · `g_ssot_single_source` (D50) — 본 sweep 의 3-tier governance 기반.
- **pattern-pilot.md** (hexa-lang) — `inbox/notes/hexa-native-port-
  pattern-pilot.md` rolling diary, prose dimension (양 SSOT independent
  per D93).

---

## 7. What did NOT happen (honest scope floor)

- ❌ **`absorbed=true` flip on any cell record** — substrate-parity 가
  PASS 더라도 cell-level measured oracle 없으면 stored `absorbed` 는
  안 바뀐다 (D80 honesty floor · D103 dimension separation · D106
  illustrative-physics gate). P-⑩ ① remaining queued.
- ❌ **자동 cross-repo sync** — D97 의 Tier ③ 가 warn-only. drift
  감지는 자동, drift 해소는 사람 (Q1: two-SSOT independent).
- ❌ **chem 2nd consumer / Python substrate** — D102 가 PILOTS row
  anchor 만 박았고, `DEPENDENCIES.demi` `kernel-chem` row + sibling
  `~/core/hexa-chem/` seed 는 별도 세션 (P-⑫ ②a/②b/②c).
- ❌ **새 Swift stored field** — D86 g_no_hardcoded_data 가 sweep 전체
  를 통제. 모든 추가 surface (chip / verifier / cross-ref CI / env-var
  cleanup) 는 declarative .demi + Swift type + loader 패턴만, 새 stored
  data 0.
- ❌ **JSON wire shape 변경** — 5 cell-record carrier 의 CodingKeys /
  init signature byte-unchanged. legacy record (`hexaNativeParity =
  nil`) 는 회색 chip 으로 정직하게 표시.

---

## 8. How to read this note (cold-start)

새 세션이 D80 sweep 직후 (post-2026-05-20) pickup 한다면:

1. **이 노트 §1 + §2** 만 읽어도 "무엇이 land 했나" 가 보임.
2. 구체 SHA / D-decision 필요 → §3 + §4.
3. 데이터 topology (PILOTS row · kernel folder · SSOT · Loader)
   필요 → §5.
4. 다음 할 일 → §6 의 NEXT_SESSIONS P-⑩/⑪/⑫ 진입.
5. "왜 이게 안 했나" 질문 → §7 의 honest scope floor.

본 노트는 audit-trail 로 잔존. 후속 D80 pilot (#13+) 이 land 하거나
P-⑩ ① 의 per-cell measured oracle 이 land 하면 이 노트는 superseded
되지 않고, 새 round-close 노트가 별도 생성된다 (한 사실 한 곳 — D50).
