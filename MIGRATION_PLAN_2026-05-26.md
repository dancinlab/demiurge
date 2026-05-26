# Domain Flatten Migration — 2026-05-26

> ⚠ 다른 세션 에이전트에게 알림 — 이 PR(머지 시점)부터 모든 도메인 매니페스트가 `domains/` 하위로 이동.
> `git pull` 후 새 경로로 재참조하라.

## 개요

루트에 흩어져 있던 27개 도메인(`<NAME>.md` + `<NAME>.log.md` 쌍 + 같은 이름 폴더)을 `domains/`로 일괄 이동. `DOMAINS.tape` roster에 일괄 등록.

## 이동된 도메인 (27 + CARDIO+ 5 sub)

| 카테고리 | 도메인 | 새 경로 |
|---|---|---|
| 물리/소재 | ANTIMATTER | `domains/antimatter.md` ← merged (snapshot+legacy pointer) |
| 물리/소재 | CERN | `domains/cern.md` ← merged |
| 물리/소재 | FUSION | `domains/fusion.md` ← merged |
| 물리/소재 | MONDALOY | `domains/MONDALOY.md` |
| 물리/소재 | MP | `domains/MP.md` |
| 물리/소재 | NUCLEAR | `domains/NUCLEAR.md` |
| 물리/소재 | RTSC + RTSC/ folder | `domains/rtsc.md` ← merged + `domains/RTSC/` |
| 물리/소재 | RTSC+NUCLEAR | `domains/RTSC+NUCLEAR.md` |
| 물리/소재 | UFO + UFO/ folder | `domains/ufo.md` ← merged + `domains/UFO/` |
| 물리/소재 | YOSYS | `domains/YOSYS.md` |
| 바이오/의료 | AURA(이미 #252) | `domains/aura.md` + `domains/AURA/` |
| 바이오/의료 | CARDIO+ container | `domains/CARDIO+/` (sub: DAPTPGX·DOCTOR·ISR·LPA·NOREFLOW) |
| 바이오/의료 | HERPES + HERPES/ | `domains/HERPES.md` + `domains/HERPES/` |
| 바이오/의료 | TTR + TTR/ | `domains/TTR.md` + `domains/TTR/` |
| 바이오/의료 | TTR-CREAM | `domains/TTR-CREAM.md` |
| 바이오/의료 | TTR-LAC + dir | `domains/TTR-LAC.md` + `domains/TTR-LAC/` |
| 바이오/의료 | TTR-MN + dir | `domains/TTR-MN.md` + `domains/TTR-MN/` |
| 바이오/의료 | TTR-ORAL + dir | `domains/TTR-ORAL.md` + `domains/TTR-ORAL/` |
| 플랫폼/메타 | ABSORPTION | `domains/ABSORPTION.md` |
| 플랫폼/메타 | CLI+COCKPIT + dir | `domains/CLI+COCKPIT.md` + `domains/CLI+COCKPIT/` |
| 플랫폼/메타 | DEMIURGE | `domains/DEMIURGE.md` |
| 플랫폼/메타 | GOAL | `domains/GOAL.md` |
| 플랫폼/메타 | HEXA-PORT | `domains/HEXA-PORT.md` |
| 플랫폼/메타 | INBOX | `domains/INBOX.md` |
| 플랫폼/메타 | NOVEL-TOOL | `domains/NOVEL-TOOL.md` |
| 플랫폼/메타 | NUMB + NUMB/ | `domains/NUMB.md` + `domains/NUMB/` |
| 플랫폼/메타 | POOL | `domains/POOL.md` |
| 이미 정착 | XPRIZE | `domains/XPRIZE.md` |
| 이미 정착 | COSME-* (8) | `domains/COSME-*.md` + `domains/COSME/` |

## 충돌 도메인 merge 방식

5개 도메인(RTSC·ANTIMATTER·CERN·FUSION·UFO)은 case-insensitive APFS에서 기존 소문자 `domains/<lower>.md`(verb-cell public-surface 포인터)와 충돌. 해결 — **AURA 패턴**으로 snapshot을 lowercase 파일에 prepend, `---`로 구분된 legacy 섹션으로 기존 public-surface 보존.

```
domains/rtsc.md (after merge)
├─ # RTSC — current state           ← root에서 옮긴 도메인 snapshot
├─ @goal: ...
├─ ## Milestones ...
├─ (~127KB snapshot content)
├─ ---
└─ # (legacy) verb-cell public-surface
    └─ (~5KB pointer content — ARCH/DESIGN/PLAN 참조 살아있음)
```

## 루트 유지 (메타 docs — 도메인 아님)

`CHARTER.md`, `DOMAIN_AUDIT.md`, `EASY.md`, `LATTICE_POLICY.md`, `README.md`, `CLAUDE.md`, `ARCH.md`(+.log), `DESIGN.md`(+.log), `PLAN.log.md`, `HANDOFF.log.md`, `CHANGELOG.md`, `TODO.md`, `INDEX.md`, `AGENTS.md`, `project.tape`, `DOMAINS.tape`(roster — 루트 유지)

## 외부 참조 (이 PR에서 갱신 안 함)

ARCH/DESIGN/PLAN 등 메타 docs와 cockpit Swift 안의 `RTSC.md`, `MP.md` 등 절대 경로 참조는 **이 PR에 포함되지 않음**. 후속 PR에서 grep+replace 일괄 갱신 예정. case-collision 도메인(RTSC 등)은 `domains/rtsc.md`로 path 그대로 살아있으므로 즉시 영향 없음. 다른 도메인은 `<NAME>.md` → `domains/<NAME>.md`로 명시 경로 수정 필요한 곳만 후속.

## 다른 세션 에이전트 권장 행동

1. `git pull origin main` 후 작업 재개
2. 도메인 파일 편집 — 새 경로 `domains/<NAME>.md` 사용
3. 진행 중인 도메인 작업 PR이 있다면 — base를 새 main으로 rebase 후 경로 충돌 해결
4. `DOMAINS.tape` 추가 등록은 `domains/DOMAINS.tape`에서 (roster SSOT)

## 후속 PR 예정

- 외부 참조 grep+replace (ARCH/DESIGN/PLAN/cockpit Swift)
- antimatter-*, cern-accelerator, rtsc-superconductor, ufo-capstone 등 lowercase-dash sub-prototype 폴더 정리 (도메인 sub로 묶을지 별도 keep)
- COSME-* sub-domains의 컨테이너화 (현재 평면, CARDIO+ 패턴으로 폴더화 검토)
