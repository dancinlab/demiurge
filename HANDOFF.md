# hexa-arch — HANDOFF (self-contained · cold-readable · 0-context)

> 2026-05-18 · This single file is everything needed to continue hexa-arch
> anywhere (new machine / new agent / new repo) with **zero prior context**.
> Read top to bottom; the RESUME block at the end is copy-paste ready.

---

## 1. TL;DR (3 lines)

- **hexa-arch** = a hexa-native, domain-pluggable program to **specify →
  architect → design → analyze → synthesize → verify → handoff** *any*
  engineered system (7-verb spine, cited — see §4 and `design.md` D5).
- It is the design/architecture sibling of **hexa-matter** (물질·소재) and
  **hexa-bio** (화학분자). Chip design is the **first domain**; aerospace,
  mechanical, … follow.
- Each domain **absorbs external open-source** the same way hexa-matter
  (⟵ ASE/pymatgen) and hexa-bio (⟵ AlphaFold/RDKit) did — Python-0,
  shell-out-0, measured, no fake progress.

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
📐 HEXA-ARCH — "만능 설계 아키텍쳐 프로그램"
- 하는 일: 어떤 공학 시스템이든 명세→구조→설계→해석⟲→합성→검증→인계, 분야는 플러그인
- 비유: 만능 설계실 — 칩/우주선/기계 책상이 한 건물 안에
```

Family position:

```
hexa-matter  🧱  물질·소재     ⟵ ASE · pymatgen
hexa-bio     🧬  화학분자       ⟵ AlphaFold · RDKit · qiskit
hexa-arch    📐  모든 기술설계  ⟵ (도메인별 외부 흡수 — §5)   ← THIS
comb         🧊  n=6 fabric    (hexa-arch[chip] 의 소비자)
```

Repo: standalone `~/core/hexa-arch` (own git). Created 2026-05-18.

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
도메인 공통; 통합 글루가 hexa-arch 의 일관된 니치).

## 6. comb relationship (decoupled — important)

- **comb** lives in `~/core/hexa-lang/comb/` (n=6 hexagonal fabric R&D,
  RFC 057, falsifiers F1–F5). It is a **consumer** of hexa-arch's chip
  domain — NOT the EDA absorber. Do not fold EDA absorption into comb.
- comb needs from hexa-arch[chip]: (T1) a NoC cycle sim to resolve F1/F2
  degree-6 vs degree-4 @ modern node; (T2) RTL + cycle-accurate sim; (T3)
  tapeout-ready design (Yosys/OpenROAD/SKY130). No fab.
- comb governance carried over: g1·g2 lattice-is-tool, binary-tile fixed,
  multi-valued logic forbidden (comb A-axis = WALL), every topology claim
  carries least-perimeter≠least-latency + EDA-cost caveat.

## 7. Governance / non-goals

- **No actual fab/FPGA** — chip domain outputs tapeout-ready *design* only
  (real PDKs used for realism, not manufacturing).
- **No over-claim** — a domain counts "absorbed" only at measured
  feature-parity; SKIP-mode regression = banned (hexa-lang `stdlib/PLAN.md`
  discipline; lattice-is-tool g1·g2; measured-only g3).
- **hexa-native-only** (hexa-lang g5) — external tools absorbed into hexa
  stdlib+cli, never shelled out; no LLVM/C-transpile as architecture.
- **Absorption-RFC pattern** — mirror `hexa-lang/proposals/rfc_047_*`,
  `rfc_048_*` (mc-integrate, xeno absorptions): one `rfc_0NN_<tool>_
  absorption.md` per external tool.

## 8. Related repos (avoid confusion)

- `~/core/hexa-chip` — **distinct existing repo** (5G/6G, advanced
  packaging, accel). NOT hexa-arch's chip domain. If overlap emerges,
  coordinate; do not merge blindly.
- `~/core/hexa-space` — distinct existing repo; potential future space domain.
- `~/core/hexa-lang` — substrate; `comb/` is first consumer; absorption-RFC
  pattern and `stdlib/PLAN.md` discipline come from here.

## 9. First milestones

1. **`proposals/rfc_001_booksim2_noc_absorption.md`** — absorb **BookSim2**
   (per Decision 5 / Agent-2 cited comparison — *not* gem5-Garnet). Minimal
   subset: `anynet` topology loader (degree-4 baseline + degree-6 candidate)
   · IQ-router pipeline + VC + credit (4 delay knobs) · synthetic traffic
   (uniform / transpose / tornado) · latency-vs-injection + saturation
   measurement loop · **per-link wire-delay model** injected as per-link
   cycle latency (SMART/Leighton-class literature; modern node *not*
   covered by SKY130/SG13G2 130 nm PDKs) · **Leighton degree-d bisection /
   diameter bound as analytic cross-check oracle**.
2. Wire it so hexa-lang `comb` RFC 057 F1/F2 (degree-6 vs degree-4 @ modern
   node) can run **only when** sim + wire-delay model + Leighton oracle are
   all in the loop — no F1/F2 resolution claim before that (no-over-claim).
3. Then incremental absorption RFCs: Yosys → Verilator+cocotb → OpenROAD +
   SKY130 → OpenSTA → ngspice. Each its own RFC, each with its own
   measurement gate.
4. 6 other named cohort domains (cern · antimatter · rtsc · space · energy ·
   brain) — *shallow* public-surface map per Decision 3 hybrid; deliverable
   to follow as separate per-domain files (seed: Agent-3 output).

## 10. RESUME (copy-paste anywhere)

```
hexa-arch 이어서. 이 repo(~/core/hexa-arch) 의 **HANDOFF.md + design.md**
가 단일 SSOT (design.md = 결정 감사추적). 정체: 📐 모든 기술설계의
hexa-native 메타프레임워크, **7-verb pipeline** = 명세 SPECIFY → 구조
ARCHITECT → 설계 DESIGN → 해석 ANALYZE ⟲ → 합성 SYNTHESIZE → 검증 VERIFY
(+VALIDATE) → 인계 HANDOFF (9개 라이프사이클 cited — design.md D5).
hexa-matter / hexa-bio = 형제·**typed-interface 소비** (흡수 X — D2).
조사 경계 = **공개면 클린룸** (OSS+arxiv+특허+표준+상용툴 공개문서;
closed-binary RE 금지 — D1). 명시 코호트 = chip · cern · antimatter ·
rtsc · space · energy · brain (D3 하이브리드: chip 깊이 + 6 얕은 공개면
맵). 현 상태: SCAFFOLD + 첫 RFC 골격. 다음 = §9 step1:
`proposals/rfc_001_booksim2_noc_absorption.md` (BookSim2 + per-link
wire-delay 모델 + Leighton oracle — *gem5 아님*, Agent-2 cited).
거버넌스: hexa-native-only · no-fab · no-closed-binary-RE (D1) ·
no-over-claim (측정 게이트). comb 는 소비자, 분리 유지.
```

> SSOT note: this HANDOFF + CHARTER are the architecture/why SSOT; PLAN.md is
> the progress/measured-distance SSOT. No over-claim — scaffold is scaffold.
