# Demiurge — HANDOFF (self-contained · cold-readable · 0-context)

> 2026-05-21 · This single file is everything needed to continue demiurge
> anywhere (new machine / new agent / new repo) with **zero prior context**.
> Read top to bottom; the RESUME block at the end is copy-paste ready.
> Reconciled to **workbench-live** state — `design.md` and `PLAN.md` are
> the SSOTs for decision numbers and phase counts (g_ssot_single_source);
> this file describes *categories* only.

---

## 1. TL;DR (3 lines)

- **demiurge** = a hexa-native, domain-pluggable program to **specify →
  architect → design → analyze → synthesize → verify → handoff** *any*
  engineered system (7-verb spine, cited — see §4 and `design.md` D5).
  Also the **meta-conductor** of a chained materials→chip→component
  program (D11), each pass joined by a typed seam (`rfc_007`, `rfc_008`).
- **Typed-interface consumer** (not absorber) of **hexa-matter** and
  **hexa-bio** (D2). hexa-matter's absorption SSOT is **hexa-lang**
  (D17); demiurge carries only `domains/matter/` pointer. Chip is the
  lead domain; `component` (FEM/EM/thermal) is a new top-level domain
  for the chain's 3rd pass (D21); 13 other domains shallow-mapped.
- Each domain absorbs external prior art via an absorption-RFC; the
  re-derived modules land in **`hexa-lang/stdlib/`**, not under demiurge
  (D15 — stdlib is hexa-lang's exclusively, demiurge is the consumer).
  No fake progress; measured gate per absorption (g3).

## 2. Why this exists / vision

Not a chip tool. A **universal technical-design architecture program**: the
seven verbs 명세(SPECIFY) → 구조(ARCHITECT) → 설계(DESIGN) → 해석(ANALYZE
⟲) → 합성(SYNTHESIZE) → 검증(VERIFY, with VALIDATE bound) → 인계(HANDOFF)
are domain-neutral and grounded in 9 surveyed lifecycles (ISO/IEC/IEEE 15288
· V-model · NASA SE · FDA design controls · EDA RTL→GDSII · MBSE/OOSEM ·
PLM · accelerator · spacecraft) — see §4 and `design.md` Decision 5.
"Chip" is one plug-in domain among many (cern, antimatter, rtsc, space,
energy, brain, …). The differentiator vs SysML / Modelica / Cadence /
Ansys is that it is **one hexa-native pipeline** with the *public surface*
of external prior art absorbed as hexa stdlib+cli (no Python/shell-out, no
closed-binary RE), every absorption gated by measured feature-parity.

## 3. Identity

```
📐 DEMIURGE — "만능 설계 아키텍쳐 프로그램"
- 하는 일: 어떤 공학 시스템이든 명세→구조→설계→해석⟲→합성→검증→인계, 분야는 플러그인
- 비유: 만능 설계실 — 칩/우주선/기계 책상이 한 건물 안에
```

Family position:

```
hexa-lang    🧰  substrate + stdlib SSOT (D15)   ← hosts absorbed modules
  └ hexa-matter content (absorption SSOT here per D17) · comb/ (consumer)
hexa-matter  🧱  물질·소재 sibling                 ⟵ typed-consumed by demiurge (D2)
hexa-bio     🧬  화학분자 sibling                  ⟵ typed-consumed by demiurge (D2)
demiurge    📐  모든 기술설계 메타프레임          ⟵ (per-domain absorption — §5) ← THIS
  ├ domain chip       (lead, deep)
  ├ domain component  (NEW top-level, D21 — chain 3rd pass)
  └ 13 cohort domains (shallow public-surface maps)
comb         🧊  n=6 fabric                       (demiurge[chip]의 소비자)
macOS cockpit📺  product surface (D16, rfc_009)   (typed-consumer of exports/; build OOS)
```

Repo: standalone `~/core/demiurge` (own git). Created 2026-05-18.

## 4. Universal pipeline (the 7 verbs — cited, `design.md` Decision 5)

| 단계 | verb | 의미 | chip 도메인 예 |
|---|---|---|---|
| 명세 | SPECIFY | 도면이 만족할 요구사항·스펙 캡처 | system spec (perf · power · area · process node) |
| 구조 | ARCHITECT | 스펙을 구조/토폴로지로 분해 | microarchitecture · 블록/RTL 분할 |
| 설계 | DESIGN | 구체 설계 산출물(도면) 생성 | RTL + floorplan |
| 해석 | ANALYZE ⟲ | 시뮬·사이징; 실패 시 DESIGN/SYNTH로 되먹임 | STA · power · functional/formal sim · cycle-accurate NoC |
| 합성 | SYNTHESIZE | 실현 가능한 하위 형태로 변환 | logic synthesis + place&route |
| 검증 | VERIFY (+VALIDATE) | output↔input 정합 + 실수요 정합 (게이트 쌍) | DRC/LVS/STA signoff + functional V&V |
| 인계 | HANDOFF | 사인오프된 도면을 제작/건설로 이관 | tapeout → mask/fab handoff |

근거: 9개 라이프사이클 (ISO/IEC/IEEE 15288 · V-model · NASA SE · FDA design
controls · EDA RTL→GDSII · MBSE/OOSEM · PLM · 가속기 lattice · spacecraft
Phase A–F) 전수 조사 — `design.md` Decision 5. **ANALYZE 는 반복 게이트**
(CAE↔CAD 루프, STA↔tapeout, 빔 트래킹↔엔지니어링) — terminal 아님.
**VERIFY / VALIDATE** 는 표준상 별 verb (15288·V-model·NASA·FDA) 이나, 같은
게이트 위치를 공유하므로 본 spine 에선 *의도된 압축*으로 한 verb 에 묶음
(no-over-claim: 표준 구분은 명시).

## 5. 도메인맵 — chip 도메인 (7-verb 1:1, 공개면 클린룸 cited)

> 구조: §4 의 7 verb 1:1 매핑 + 횡단 자원(단계 아님) 분리 + 흡수 순서
> (≠ 파이프라인 순서) 주석. 외부 매핑은 **공개면 클린룸**(`design.md`
> Decision 1) 한정 — OSS · arxiv · 특허 · 표준 · 데이터시트 · 상용툴
> 공개문서. closed-binary 역공학 · 라이선스 우회 0.

| verb | 외부 공개면 — 오픈소스 (흡수 대상) | 외부 공개면 — 상용 (공개문서 한정; 역량/공백 분석용) |
|---|---|---|
| 명세 SPECIFY | (도메인 사용자 입력; OSS spec-format 약함) | Cadence Allegro Constraint류 사내 spec/요건 관리 |
| 구조 ARCHITECT | (수동 모델; SystemC 일부) | — |
| 설계 DESIGN | **Chisel/FIRRTL** · **Amaranth** (HW construction langs) · 직접 Verilog | Cadence Xcelium · Synopsys Verdi (front-end) |
| 해석 ANALYZE ⟲ | (system cycle) **BookSim2** · gem5(+Garnet) · Noxim · Ratatoskr · (formal) **SymbiYosys** · (analog) **ngspice** | (timing) **Synopsys PrimeTime** (golden sign-off) · (sim) Siemens **Questa** · (analog) Synopsys **HSPICE** / Cadence **Spectre** |
| 합성 SYNTHESIZE | **Yosys** (logic synth) · **OpenROAD/OpenLane2** · Magic · KLayout (P&R→GDSII) | Cadence **Genus + Innovus** · Synopsys **Design Compiler + IC Compiler II** |
| 검증 VERIFY (+VAL) | **Verilator** · **cocotb** (sim) · **OpenSTA** (timing — guardband 필요) | Siemens **Calibre nmDRC/nmLVS** (foundry-golden 물리검증) |
| 인계 HANDOFF | (foundry shuttle 인터페이스; OSS 표준 약함) | foundry sign-off deliverables (TSMC / IHP / SkyWater) |

**⊥ 횡단 자원 (단계 아님 — 여러 단계 공유)**

- 공정노드 / PDK: **SkyWater SKY130** · **IHP SG13G2** (둘 다 130nm —
  fab-free 설계용). ⚠ *modern node 미충족* — comb F1/F2 해석엔 별도
  per-link wire-delay 모델 필요 (§9, `proposals/rfc_001_*`).

**⊥ 흡수 순서 (≠ 파이프라인 순서 — 우선순위 시그널)**

1. **BookSim2** (해석 ANALYZE 의 system-cycle 부분집합) — comb RFC 057
   F1/F2 직격. `proposals/rfc_001_booksim2_noc_absorption.md` 참조.
   (gem5 아님 — Agent-2 cited 비교: BookSim2 가 정확도 *레퍼런스*이며
   full-system Ruby 비용 없음.)
2. **Yosys** (합성) — RTL→netlist.
3. **Verilator + cocotb** (검증) — sim 기본.
4. **OpenROAD + SKY130** (합성 P&R + 횡단 PDK) — full RTL→GDS.
5. **OpenSTA** (검증 timing) · **ngspice** (해석 analog).

> 상용툴 공개문서 매핑은 **역량/공백 분석용**이며 흡수 대상이 아님
> (`design.md` Decision 1).

**상용 vs 오픈소스 갭 (cited)**

- system-cycle 해석은 OSS 가 *필드 레퍼런스* (BookSim2 ↔ RTL 정확도 기준,
  BST ISPASS'20). comb F1/F2 의 진짜 리스크는 도구가 아니라 *wire-delay
  모델 부재* — §9 참조.
- 합성/P&R 갭 최대: OpenROAD 실리콘 검증 ≤ ~12nm; Innovus/IC Compiler II
  는 첨단 노드 (Cadence/Synopsys 공개 datasheet).
- timing sign-off: OpenSTA 가드밴드 필요 vs PrimeTime golden (HSPICE 5% 내
  공개 벤치).
- 물리 검증: Calibre 가 foundry-골든 (첨단 노드 multi-patterning).
- analog: ngspice 는 연구/교육 grade vs HSPICE/Spectre 첨단 노드 인증.

Cited 원천: Agent-2 출력 (gem5.org · github BookSim2 / OpenROAD ·
Cadence / Synopsys / Siemens 공개 datasheets · arXiv:2007.03152 ·
SMART ISPASS'17 · Leighton DOI 10.1007/BF01744433 등 — 상세 인용은
`proposals/rfc_001_booksim2_noc_absorption.md` §10).

타 6개 도메인 (cern · antimatter · rtsc · space · energy · brain) =
별도 *얕은* 공개면 맵 (Decision 3 하이브리드) — 후속 파일로 분리 예정
(Agent-3 출력 기반: Monte-Carlo transport + FEM EM/thermal 추상화가 5/6
도메인 공통; 통합 글루가 demiurge 의 일관된 니치).

## 6. comb relationship (decoupled — important)

- **comb** lives in `~/core/hexa-lang/comb/` (n=6 hexagonal fabric R&D,
  RFC 057, falsifiers F1–F5). It is a **consumer** of demiurge's chip
  domain — NOT the EDA absorber. Do not fold EDA absorption into comb.
- comb needs from demiurge[chip]: (T1) a NoC cycle sim to resolve F1/F2
  degree-6 vs degree-4 @ modern node; (T2) RTL + cycle-accurate sim; (T3)
  tapeout-ready design (Yosys/OpenROAD/SKY130). No fab.
- comb governance carried over: g1·g2 lattice-is-tool, binary-tile fixed,
  multi-valued logic forbidden (comb A-axis = WALL), every topology claim
  carries least-perimeter≠least-latency + EDA-cost caveat.

## 7. Governance / non-goals

- **No actual fab/FPGA** — chip domain outputs tapeout-ready *design* only
  (real PDKs used for realism, not manufacturing).
- **No over-claim (g3 — RETAINED)** — `absorbed`/`parity`/`resolved`
  only at a measured gate filed with cited numbers; SKIP-mode regression
  banned (`AGENTS.tape` `g3_no_over_claim` · `@F f2`/`@F f4`).
- **hexa-native-only (g5)** — absorbed substrate runs as hexa intrinsics;
  re-derived modules belong in **`hexa-lang/stdlib/`**, NOT under
  demiurge (D15; demiurge carries no `stdlib/` tree — `@F f1`).
  Bounded exception per the rfc_048 precedent: verbatim foreign
  substrate as a documented fail-loud subprocess (e.g. ABC inside the
  Yosys flow per D18), re-derivation as scheduled follow-on.
- **No big-bang** — incremental, per-domain absorption-RFC; the previous
  "design-only" framing of D10 was **rescinded by D12** (full scope
  permitted; gate discipline, not scope cap, enforces honesty).
- **Absorption-RFC pattern** — mirror `hexa-lang/proposals/rfc_047_*`,
  `rfc_048_*`: one `rfc_0NN_<tool>_absorption.md` per external tool.

## 8. Related repos (avoid confusion)

- `~/core/hexa-lang` — substrate + **single SSOT for `stdlib/`** (D15).
  Hosts the re-derived modules demiurge references: e.g.
  `stdlib/booksim/` (rfc_003 absorption, hexa-lang commit `d5a63a82`,
  pending push in a hexa-lang session per D19) and the planned
  `stdlib/yosys/` (rfc_006 §4 impl pending, D19). demiurge references
  these; it does **not** carry them.
- `~/core/hexa-matter` — sibling; absorption SSOT = hexa-lang per D17.
  demiurge's `domains/matter/` is a pointer README, not a copy.
- `~/core/hexa-chip` — **distinct existing repo** (5G/6G, advanced
  packaging, accel). NOT demiurge's chip domain. If overlap emerges,
  coordinate; do not merge blindly.
- `~/core/hexa-space` — distinct existing repo; potential future space domain.
- **macOS Swift cockpit (D16, rfc_009)** — the product surface, a
  read-only consumer of `exports/{chip/noc/f1f2, seams/*}`. Build is
  **out of scope here** (D22) — belongs to a downstream session
  (D19 idiom). Public honest-audit surface is the public GitHub
  `dancinlab/demiurge` repo itself (D16).

## 9. Current state (g3 — *category* only; numbers live in PLAN.md)

Original First-Milestone plan above (steps 1–4) is **superseded by
actual progress** — preserved in `design.md` and the audit trail.

**Design-complete (4-Phase roadmap):**
- Absorption RFCs — BookSim2 (rfc_001/003 → `hexa-lang/stdlib/booksim/`
  per D15, commit `d5a63a82`) · Yosys (rfc_006 + D18 bounded-
  subprocess + D19 hexa-lang session) · matter SUPERSEDED to
  hexa-lang (D17, rfc_005 tombstone).
- Typed-interface seams — rfc_002 F1F2 v1.0 (chip→comb) · rfc_007
  materials→chip v0 · rfc_008 chip→component v0.
- Meta-conductor program — rfc_004 (D11 chain).
- Cockpit spec — rfc_009 (product surface, D22) · rfc_010
  (architecture) · rfc_011 (control surface) · rfc_012 (project
  workbench).
- Domain maps (Cohort + `component.md` D21 + `matter/` D17 pointer)
  — each §6 = workbench ingredient shelf SSOT.

**Built (measured-green via `swift run`):**
- macOS cockpit workbench — `cockpit/` SwiftPM package · 3-column
  workbench (recipe rail · LLM chat · work zone) · project manifest
  persistence (App Support, D45) · ingredient shelf · verb stepper ·
  θ-2 action skeleton · §4.2 REJECTED guard · domain-aware canvas
  mode · CLI ↔ cockpit parity (ActionDispatch). Installed as
  `/Applications/demiurge.app`. κ-phase log = `PLAN.md`.

**Honest core gap (g3) — "engine tool 0" (post-κ-68 closure refresh):**
- κ-68 closure (2026-05-21) landed RFC 013 §6.11 per-cell measured-
  oracle parity round — **first cell `absorbed=true` legitimate flip**
  (Energy/solar · D110 · hexa-lang `b8d35920` PR #259 MERGED · mean
  rel_err 0.0499 vs 0.05 PASS · 480 clear-sky samples NREL MIDC SRRL
  Golden CO). 직전의 "어떤 도메인도 absorbed=true 아님" narrative 는
  Energy 도메인 의 첫 cell 에 한해 honest update — 다른 cell / 다른
  도메인 의 `absorbed=true` 는 여전히 없음 (G33/G34 axis · κ-69).
- κ-69 opening (2026-05-21 같은 사이클): ARCH §11.4 Round 8 scaffold
  G31..G34 pre-code 박힘 + ARCH §12 신설 (chip §B substrate-axis
  잔여 로드맵 이관 from rm'd YOSYS.md). G31a wrapper half landed
  (hexa-lang PR #263 OPEN · partial-land · κ-69 의 first cross-repo
  partial). 자세한 현재 진행 axis = `NEXT_SESSIONS.md` P-⑬.
- chip §B full-curve — substrate-side `measurement_gate` 여전히 OPEN.
  ARCH §12.1 (Tier-1 (0..i) / Tier-2 / Tier-3 · 8-16 session est) 가
  잔여 axis 의 narrative anchor. **§12.1 (e) fifo_mem RTLIL Memory
  emit** 은 hexa-lang sibling repo 측에 별 agent 가 활성 작업 중
  (`inbox/PATCHES.yaml` 504-line WIP) — demiurge 세션은 이 axis
  미접촉. chip §B / §D = `absorbed=false`.
- Seam records — 0 (both rfc_007/008 v0, `records/` intentionally
  empty — no fabrication).
- 3D real USDZ — 0 (`exports/` holds zero geometry; component
  producer awaited per `NEXT_SESSIONS.md` P-⑨).
- Nothing flips `absorbed=true` without a cited measurement — D103
  dimension-separation + D106 illustrative-physics gate typed
  enforcement (κ-68 G30 Stage 1 XCTest invariant LANDED).

## 10. RESUME (copy-paste anywhere)

```
demiurge 이어서. 이 repo(~/core/demiurge) 의 SSOT:
HANDOFF.md (cold-readable 아키텍처) · CHARTER.md (mission/거버넌스) ·
design.md (결정 감사추적 SSOT — 번호·요지 보유) · PLAN.md (진행 ·
측정 거리 · cockpit κ-phase log SSOT) · NEXT_SESSIONS.md (cross-repo
/ post-completion 핸드오프). 거버넌스 SSOT = AGENTS.tape (g_stdlib_
ownership · g_ssot_single_source · g_cockpit_isolation · g_swift_
native · g_cockpit_reinstall · g_ai_agent_* · g3 · g5 · @F).
정체: 📐 모든 기술설계의 hexa-native 메타프레임워크 + 메타-컨덕터 —
7-verb 스파인(명세→구조→설계→해석⟲→합성→검증→인계, 9 lifecycle
cited) 을 materials→chip→component 체인에 직렬 적용. 도메인 = chip
(deep) + component (NEW top-level) + Cohort shallow 맵.
hexa-matter / hexa-bio = typed-interface 소비; **hexa-lang 이 유일
SSOT** (재사용 stdlib · 도구 · 흡수 전부 — 2026-05-19 user directive).
공개면 클린룸 한정. 산출 표면 = macOS Swift cockpit workbench —
**built · `/Applications/demiurge.app` live**. 거버넌스 = g3 RETAINED
+ g5 + g_clean_room + bounded-subprocess 예외(rfc_048 선례, D18).
현 상태 (g3 — category only, 수치는 PLAN.md/design.md):
**4-Phase 설계 design-complete · workbench live (rfc_012 IMPLEMENTED)
· κ-68 closure (2026-05-21) RFC 013 §6.11 LANDED · Energy/solar 첫
cell `absorbed=true` legitimate flip (D110 · hexa-lang `b8d35920`
PR #259 MERGED) · κ-69 opening (같은 cycle) ARCH §11.4 Round 8 scaffold
(G31..G34) + §12 신설 + G31a wrapper half landed (hexa-lang PR #263
OPEN · partial-land) · chip §B 잔여 axis (§12.1 Tier-1/2/3) measurement
_gate 여전히 OPEN**. 다음 = `NEXT_SESSIONS.md` P-⑬ (κ-69 horizon ·
G31b producer integration + G32 cell-pick decision + G33 flip + G34
constitution.md row) + P-⑩ (κ-68 historical · 본 closure 박제 후
참조용) · chip §B substrate-axis 는 ARCH §12.1 + sibling repo 측
별 agent active (§12.1 (e) fifo_mem · 본 세션 미접촉).
```

> SSOT note: this HANDOFF + CHARTER are the architecture/why SSOT; PLAN.md
> is the progress / measured-distance / κ-phase SSOT; `design.md` is the
> decision audit trail SSOT (numbers + summaries live there, not here);
> `NEXT_SESSIONS.md` is the cross-repo / post-completion handoff SSOT;
> `AGENTS.tape` is the enforced governance. No over-claim (g3): workbench
> built ≠ wired / absorbed / measured — the engine-tool-0 gap is honest,
> and the measured distance lives in PLAN.md, never asserted here.
