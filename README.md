# Demiurge — universal hexa-native technical-design architecture program

> Standalone repo · `~/core/demiurge` · created 2026-05-18 ·
> Status (2026-05-22): **4-Phase design-complete · macOS Swift cockpit
> workbench live (`/Applications/demiurge.app`) · 3 cells with stored
> `absorbed=true` legitimate flip via measured-oracle PASS**
> (Energy/solar D110 · Aura/EEG D117 · Ufo/plasma D119 · κ-68/69/70
> closure narrative). G30 invariant `invariantHolds(...)` record-type-
> agnostic generalization confirmed across 3 record types with
> 0-code-change auto-extension. RTSC §9 5-gate stack LANDED (N1-N5 ·
> Phase 1-4 #1 + #2 unblock pending CI infra · 20/20 cell matrix
> PASS post-JARVIS-OPTIMADE 3rd corpus) · Nuclear discovery stack
> LANDED (NUCLEAR.md spec + N6 HFBTHO + N7 WKB α-decay + Phase 4 #1
> microkernel port 31/31 parity bit-exact). g3 honest — see
> `PLAN.log.md` for measured distance (κ-phase archive, PLAN.md 2026-05-22
> 흡수), `CHARTER.md` for mission/scope (HANDOFF.md 2026-05-22 흡수 —
> historical at `HANDOFF.log.md`), `DESIGN.md` for the decision audit trail.
> Family: **typed-interface consumer** (not absorber) of `hexa-lang`,
> the **sole SSOT** for reusable stdlib / tools / absorbed modules
> (D15 / D17 + 2026-05-19 user directive); demiurge is the consumer-
> pointer side.
> This one = **모든 기술설계의 아키텍쳐** — chip is one domain,
> `component` (FEM/EM/thermal, D21) the chain's 3rd-pass domain,
> plus 13 shallow public-surface maps.
> Self-contained pickup entry point: `CHARTER.md` (HANDOFF.md 2026-05-22
> 흡수 — historical at `HANDOFF.log.md`).

---

## Concept

```
📐 DEMIURGE — "만능 설계 아키텍쳐 프로그램"

- 하는 일: 어떤 공학 시스템이든 명세→구조→설계→해석⟲→합성→검증→인계 의
           7-verb hexa-native 파이프라인으로; 분야는 플러그인 도메인으로 꽂힘
- 비유: 만능 설계실 — 칩·가속기·초전도·우주선·BCI 책상이 한 건물 안에
```

```
            demiurge (umbrella · 메타-컨덕터 D11)
   ┌───────────────────────────────────────────────────────┐
   │ 명세→구조→설계→해석⟲→합성→검증→인계                   │  7-verb 범용 파이프라인 (cited, D5)
   └───────────────────────────────────────────────────────┘
   Meta-conductor chain (rfc_004 §4):
   materials ─rfc_007─▶ chip ─rfc_008─▶ component
   (matter)   typed     (lead,  typed     (D21 신규 top-level
   상류=hexa- seam      deep)   seam       — FEM/EM/thermal)
   lang(D17)  contract          contract

   Plus 13 shallow cohort domains: cern · antimatter · rtsc · space ·
                                   energy · brain · fusion · scope ·
                                   sscb · mobility · bot · grid · aura
   ▲
   comb (hexa-lang, n=6 fabric) 가 [chip] 도메인을 *사용* — 소비자만,
   EDA 흡수 주체 아님 (typed-interface 패턴, D2).
   hexa-matter/hexa-bio 도 동일 패턴 (소비, 흡수 X — D2).
   hexa-matter 흡수 SSOT = hexa-lang (D17); demiurge 는 소비-포인터.

   Product surface (D16 / rfc_009·010·011·012): macOS Swift cockpit
   **workbench live** — `/Applications/demiurge.app` (cockpit/ ·
   SwiftPM). κ-phase build log in `PLAN.log.md` (archive).
```

vs 기존: hexa-matter = 물질을 계산, hexa-bio = 분자를 계산, **demiurge =
설계 자체를 계산·검증** (분야 무관 메타프레임워크). 외부 오픈소스를 도메인별로
흡수하는 메커니즘은 hexa-matter(⟵ASE/pymatgen)·hexa-bio(⟵AlphaFold) 와 동일.

## Files (SSOTs)

- `CHARTER.md` — **자기완결 인수인계** + mission · scope · 비목표 ·
  도메인 모델 (HANDOFF.md 2026-05-22 흡수 — historical at
  `HANDOFF.log.md`). 0-context pickup 진입점, 먼저 읽을 것.
- `GOAL.md` — 한 문장 north-star + 무엇이 아닌가/무엇인가 + 정직한
  현 위치(g3)
- `DESIGN.md` — **결정 감사추적** (gated picks SSOT — D-번호 SSOT)
- `PLAN.log.md` — 진행 / 측정 거리, append-only `## 진행 로그` ·
  cockpit κ-phase build log archive (수치·phase SSOT, PLAN.md 2026-05-22
  흡수 — forward Roadmap → CHARTER.md)
- `AGENTS.tape` — 강제 거버넌스 (`g_stdlib_ownership` ·
  `g_ssot_single_source` · `g_cockpit_isolation` ·
  `g_swift_native` · `g_cockpit_reinstall` · `g_ai_agent_*` · g3 · `@F`)
- `ARCH.tape` — tape v1.2 인덱스
- `proposals/rfc_*` — 흡수 / seam / cockpit 설계 RFC (`rfc_001..012`)
- `domains/` — 도메인 맵 (Cohort + `component.md` D21 + `matter/`
  D17 pointer) · 각 §6 = workbench ingredient shelf SSOT
- `cockpit/` — SwiftPM package (CockpitApp GUI + DemiurgeCLI +
  DemiurgeCore library — rfc_009/010/011/012 product surface)
- `exports/` — `chip/noc/f1f2/` (rfc_002 v1.0 records) +
  `seams/{materials_to_chip, chip_to_component}/` (rfc_007/008 v0,
  records 의도적 빈칸 — 위조 0, g3)
- `NEXT_SESSIONS.md` — cross-repo / post-completion 핸드오프
  프롬프트 (Tracks matrix · P-②③ · P-④ · P-⑧ · P-⑨)

## Related repos (구분 — 혼동 방지)

- `~/core/hexa-lang` — **the sole SSOT for stdlib / tools /
  absorptions** (D15 / D17 + 2026-05-19 user directive). Every
  domain's reusable tooling (booksim · matter · component · …) lives
  inside this single repo; demiurge consumes only.
- `~/core/hexa-*` (hexa-chip / hexa-space / hexa-component / …) —
  **NOT SSOT**. They exist on disk but the κ-17 correction removed
  the cockpit's earlier "sibling repo" recognition; the canonical
  stdlib home is `hexa-lang/<domain>` (booksim / matter pattern).

## Current state (snapshot, g3 — *카테고리* only; 수치·phase 는
PLAN.log.md / DESIGN.md SSOT)

**Design-complete (4-Phase 로드맵):**

- absorption RFCs — BookSim2 NoC (rfc_001/003, modules now in
  `hexa-lang/stdlib/booksim/` per D15, commit `d5a63a82`) · Yosys
  (rfc_006 + D18 bounded-subprocess + D19 hexa-lang 세션 소관) ·
  matter SUPERSEDED to hexa-lang (D17).
- typed-interface seams — F1F2 (rfc_002 v1.0, chip→comb) · materials
  →chip (rfc_007 v0) · chip→component (rfc_008 v0).
- cockpit spec — rfc_009 (product surface · D22) · rfc_010
  (architecture) · rfc_011 (control surface) · rfc_012 (project
  workbench).
- domain maps cited (Cohort + `component.md` D21 + `matter/` D17
  pointer) · each §6 = workbench ingredient shelf SSOT.
- end-to-end meta-conductor program (rfc_004, D11).

**Built (measured-green):**

- macOS Swift cockpit workbench — `/Applications/demiurge.app` ·
  3-column workbench (recipe rail · LLM chat · work zone) · project
  manifest persistence · ingredient shelf · θ-2 action skeleton ·
  §4.2 REJECTED guard · domain-aware canvas mode · CLI ↔ cockpit
  parity (ActionDispatch shared). κ-phase log in PLAN.log.md (archive).
- hexa-native substrate parity surface (D80 · κ-67 · RFC 013
  MOSTLY-LANDED) — declarative `.demi` SSOTs (5) · cockpit Loaders
  (5) · `HexaNativeParityRef` 8-field × 5 cell carriers · 4-case
  chip UI · ARCH §11.4 G1..G24 Round 1-6 + G25/G26 post-closure
  bracket. 측정 수치 (pilot 수 · assertion 수 · kernel folder 수 ·
  PILOTS row 수) SSOT = `PLAN.log.md` κ-history archive + `domains/PILOTS.demi`
  (g_ssot_single_source · D50).

**Not done (정직한 갭, g3 — engine tool 0 이 핵심):**

- **engine tool 0** — θ-2 가 돌릴 실제 도구 0개 (Yosys §4 미구현 =
  hexa-lang 세션 · booksim 은 hexa-lang/stdlib 이전됨) → 어떤
  프로젝트도 측정 record 0 · 어떤 verb 도 ✅ 아님.
- seam records 0 (rfc_007/008 v0 의도적 빈칸 — 위조 0).
- chip §B 풀-커브 / §D 미측정 (NEXT_SESSIONS P-④).
- `d5a63a82` 미push (NEXT_SESSIONS P-②③, hexa-lang 세션).
- 3D real USDZ 0 (component producer 부재; NEXT_SESSIONS P-⑨).
- 어떤 도메인도 `absorbed=true` 아님.

외부 매핑 = `ARCH.md` §5 (HANDOFF.md §5 흡수); 측정 거리 = `PLAN.log.md`
(archive); 결정 = `DESIGN.md`; cross-repo / post-completion 핸드오프 =
`NEXT_SESSIONS.md`.
