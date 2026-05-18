# Demiurge — universal hexa-native technical-design architecture program

> Standalone repo · `~/core/demiurge` · created 2026-05-18 ·
> Status: **4-Phase design-complete (g3: design only — NOT built /
> wired / absorbed; see `PLAN.md` for measured distance, `design.md`
> D1–D22 for the decision audit trail).**
> Family: **typed-interface consumer** (not absorber) of
> `hexa-matter` (물질·소재) and `hexa-bio` (화학분자) — `design.md`
> D2. hexa-matter's absorption SSOT is `hexa-lang` (D17); demiurge
> is the consumer-pointer side.
> This one = **모든 기술설계의 아키텍쳐** — chip is one domain,
> `component` (FEM/EM/thermal, D21) the chain's 3rd-pass domain,
> plus 13 shallow public-surface maps.
> Single self-contained handoff for picking this up anywhere:
> `HANDOFF.md`.

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

   Product surface (D16, rfc_009): macOS Swift cockpit · 빌드는
   downstream 세션 (D22) — 본 repo 산출은 spec 까지.
```

vs 기존: hexa-matter = 물질을 계산, hexa-bio = 분자를 계산, **demiurge =
설계 자체를 계산·검증** (분야 무관 메타프레임워크). 외부 오픈소스를 도메인별로
흡수하는 메커니즘은 hexa-matter(⟵ASE/pymatgen)·hexa-bio(⟵AlphaFold) 와 동일.

## Files (SSOTs)

- `HANDOFF.md` — **완전 자기완결 인수인계** (cold-readable, §10
  RESUME). 0-context 로 이어가기 위한 단일 문서. 먼저 읽을 것.
- `CHARTER.md` — mission · scope · 비목표 · 도메인 모델
- `GOAL.md` — 한 문장 north-star + 무엇이 아닌가/무엇인가 + 정직한
  현 위치(g3)
- `design.md` — **결정 감사추적 D1–D22** (gated picks SSOT)
- `PLAN.md` — 진행/측정 거리, append-only `## 진행 로그`
- `AGENTS.tape` — 강제 거버넌스 (`g_stdlib_ownership`·g3·`@F`)
- `ARCH.tape` — tape v1.2 인덱스
- `proposals/rfc_001..009` — 흡수/seam/cockpit 설계 RFC 9건
- `domains/` — 15 도메인맵 (13 Cohort + `component.md` D21 +
  `matter/` D17 pointer)
- `exports/` — `chip/noc/f1f2/` (rfc_002 v1.0, 실 records) +
  `seams/{materials_to_chip, chip_to_component}/` (rfc_007/008 v0,
  records 의도적 빈칸 — 위조 0, g3)

## Related repos (구분 — 혼동 방지)

- `~/core/hexa-chip` — **별개 기존 repo** (5G/6G·advanced packaging·accel).
  demiurge 의 chip *도메인*(EDA 설계 파이프라인 흡수) 과 다름. 향후 조율은
  HANDOFF §related 참조.
- `~/core/hexa-space` — 별개 기존 repo. 향후 demiurge 의 space 도메인과
  연계 가능 (현재 미연결).
- `~/core/hexa-lang` — substrate. `comb/` (n=6 fabric R&D) 가 첫 소비자.

## Current state (snapshot, g3 — 측정 거리만)

**Design-complete (4-Phase 로드맵):**

- `rfc_001/003` — BookSim2 NoC-sim 흡수 + 6-모듈 clean-room
  hexa-native 재도출 (modules now in `hexa-lang/stdlib/booksim/`
  per D15, hexa-lang commit `d5a63a82`).
- `rfc_002` — F1F2 typed-interface schema v1.0 (chip→comb seam),
  실제 records 다수 존재 (NoC `GATE_B_PINNED_MET` 측정 기반).
- `rfc_004` — end-to-end 메타-컨덕터 프로그램 (D11).
- `rfc_005` — SUPERSEDED by D17.
- `rfc_006` — Yosys 흡수 설계 + D18 (ABC = bounded-subprocess) +
  D19 (모듈 구현은 hexa-lang 세션, target `stdlib/yosys/`).
- `rfc_007/008` — materials→chip / chip→component 타입드 seam
  계약 v0 (D20/D21).
- `rfc_009` — macOS Swift cockpit 설계 spec (D22).
- 15 도메인맵 (cited).
- inbox handoff filed: `hexa-lang/inbox/notes/2026-05-19-demiurge-
  rfc006-yosys-handoff.md` + `PATCHES.yaml` +2.

**Not done (정직한 갭, g3):** 코드/앱 0 · seam records 0 (전부 v0) ·
chip §B 풀-커브/§D 미측정 · Yosys §4 모듈 미구현 (hexa-lang 세션) ·
`d5a63a82` 미push (hexa-lang 세션) · Swift 앱 미빌드 (downstream).
어떤 도메인도 `absorbed=true` 아님.

전체 외부 매핑 = `HANDOFF.md` §5; 측정 거리 = `PLAN.md`;
결정 = `design.md` D1–D22.
