# hexa-arch — HANDOFF (self-contained · cold-readable · 0-context)

> 2026-05-18 · This single file is everything needed to continue hexa-arch
> anywhere (new machine / new agent / new repo) with **zero prior context**.
> Read top to bottom; the RESUME block at the end is copy-paste ready.

---

## 1. TL;DR (3 lines)

- **hexa-arch** = a hexa-native, domain-pluggable program to **design →
  synthesize → layer → verify → simulate** *any* engineered system.
- It is the design/architecture sibling of **hexa-matter** (물질·소재) and
  **hexa-bio** (화학분자). Chip design is the **first domain**; aerospace,
  mechanical, … follow.
- Each domain **absorbs external open-source** the same way hexa-matter
  (⟵ ASE/pymatgen) and hexa-bio (⟵ AlphaFold/RDKit) did — Python-0,
  shell-out-0, measured, no fake progress.

## 2. Why this exists / vision

Not a chip tool. A **universal technical-design architecture program**: the
five verbs 설계(model) → 쌓기(synthesize) → 적층(layer/assemble) →
검증(verify) → 계산(simulate) are domain-neutral. "Chip" is one plug-in
domain among many (space, mechanical, …). The differentiator vs SysML /
Modelica / Cadence / Ansys is that it is **one hexa-native pipeline** with
domains absorbed as hexa stdlib+cli (no Python/shell-out), every absorption
gated by measured feature-parity.

## 3. Identity

```
📐 HEXA-ARCH — "만능 설계 아키텍쳐 프로그램"
- 하는 일: 어떤 공학 시스템이든 설계→쌓기→적층→검증→계산, 분야는 플러그인
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

## 4. Universal pipeline (the 5 verbs)

| 단계 | verb | 의미 | chip 도메인 예 |
|---|---|---|---|
| 설계 | model | 시스템 구조화 | RTL · netlist · arch model |
| 쌓기 | synthesize | 상위→하위 구체화 | logic synthesis |
| 적층 | layer/assemble | 물리 배치·레이어 | place&route → GDSII |
| 검증 | verify | 정합·형식·타이밍 | sim · formal · STA |
| 계산 | simulate | 거동·성능 측정 | cycle-accurate · SPICE |

## 5. 도메인맵 — chip 도메인 외부 오픈소스 전수 매핑 (흡수 대상)

| 파이프라인 | 외부 오픈소스 (흡수 대상) | 비고 |
|---|---|---|
| 아키텍쳐 (계산) — NoC/system sim | **gem5 (+Garnet)** · **BookSim2** · Noxim · Ratatoskr | ← comb T1 / F1·F2 직격 (degree-6 vs degree-4). **첫 흡수 타깃** |
| 쌓는다 (합성) — RTL→netlist | **Yosys** | logic synthesis |
| 적층 (레이어) — place&route→GDSII | **OpenROAD** / **OpenLane2** · Magic · KLayout | physical layout |
| 검증한다 — sim·formal·timing | **Verilator** · cocotb · **SymbiYosys** (formal) · **OpenSTA** (timing) | verification |
| 계산한다 (아날로그) | **ngspice** | analog / SPICE |
| 실제 공정노드 (fab-free) | **SkyWater SKY130** · **IHP SG13G2** PDK | tapeout-ready 설계용, **fab 안 함** |
| RTL 생성 | **Chisel/FIRRTL** · **Amaranth** (nMigen) | HW construction langs |

Absorption order (incremental, measured — no big-bang): **NoC sim first**
(BookSim2 or gem5-Garnet) → unblocks comb F1/F2 → then synth (Yosys) →
verify (Verilator) → layout (OpenROAD+SKY130). Each = its own absorption RFC.

Other domains (space / mechanical / …) — placeholder; map when first needed.
`~/core/hexa-space` exists as a separate repo; future space-domain may link it.

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

1. `proposals/rfc_001_noc_sim_absorption.md` — absorb a NoC cycle simulator
   (BookSim2 or gem5-Garnet), minimal subset for degree-6 vs degree-4.
2. Wire it so hexa-lang `comb` RFC 057 F1/F2 can run (modern-node wire model,
   Leighton degree-d bisection/diameter bounds as the real-limit anchor).
3. Then synth/verify/layout domains incrementally; each its own RFC, measured.

## 10. RESUME (copy-paste anywhere)

```
hexa-arch 이어서. 이 repo(~/core/hexa-arch) 의 HANDOFF.md 가 단일 SSOT —
전부 거기 있음. 정체: 📐 모든 기술설계의 hexa-native 메타프레임워크
(설계→쌓기→적층→검증→계산), 도메인 플러그인, hexa-matter/hexa-bio 와
형제(외부-흡수 패턴 동일). 현 상태: SCAFFOLD (README·CHARTER·PLAN·
ARCH.tape·HANDOFF 만 존재, 코드 0). 다음 = HANDOFF §9 step1:
proposals/rfc_001_noc_sim_absorption.md (BookSim2 또는 gem5-Garnet 최소
흡수) → hexa-lang comb RFC 057 F1/F2 (degree-6 vs degree-4) 해소.
거버넌스: hexa-native-only, no-fab, no-over-claim(측정만), 흡수-RFC 패턴
(hexa-lang/proposals/rfc_047·048 미러). comb 는 소비자이지 EDA 흡수 주체
아님 — 분리 유지.
```

> SSOT note: this HANDOFF + CHARTER are the architecture/why SSOT; PLAN.md is
> the progress/measured-distance SSOT. No over-claim — scaffold is scaffold.
