# CARDIO+ — current state

@goal: 4개 cardio sub-domain (NOREFLOW + DAPTPGX + ISR + LPA) 동시 심화·골화 진행 — 환자 본인 PCI 후속 + 교수님 첫 임상 적용 가능한 통합 evidence package + 한국 first-in-class 4-trial portfolio 완주 (모두 🟢 SUPPORTED-NUMERICAL 이상, ⚪ honest fence 분류 완료, DOCTOR handoff ready)

## 메타-도메인 구성 (per domain skill `+`)

| sub | scope | 현재 진행 | source |
|---|---|---|---|
| **NOREFLOW** | PCI 직후 no-reflow / MVO 보호 | 14/16 (87%) | `NOREFLOW.md` |
| **DAPTPGX** | 한국인 CYP2C19 DAPT 약물유전체 | (other session) | `DAPTPGX.md` |
| **ISR** | in-stent restenosis 비-mTOR | (other session) | `ISR.md` |
| **LPA** | Lp(a) 잔여 위험 침묵화 | (other session) | `LPA.md` |
| **DOCTOR** | 교수님 handoff 패키지 | 0/10 (scaffold) | `DOCTOR.md` |

## milestones (cross-cutting · 4-domain 동시 진행)

- [ ] X1 cross-domain V1 통합 — 4 sub-domain claim inventory 합산 + 중복 제거 + 통합 tier triage → `CARDIO+/X1_unified_claims.md`
- [ ] X2 cross-domain V2 🔵 push 동시 — 4 sub-domain × 🔵 후보 (NOREFLOW 11 + DAPTPGX ? + ISR ? + LPA ?) hexa-lang atlas 확장 의존 → `CARDIO+/X2_blue_push.md`
- [ ] X3 cross-domain V3 🟢 push 동시 — pool ubu-1/2 4-domain 병렬 simulation (PK · IRI · M7 MC · siRNA ODE · ICER · IVW MR 등) → `CARDIO+/X3_green_push.md`
- [ ] X4 cross-domain ⚪ fence 통합 — 4 sub-domain × subjective/prognostic claim 합산 honest fence → `CARDIO+/X4_unified_fence.md`
- [ ] X5 한국 first-in-class 4-trial portfolio 통합 — Trial-A NICORADENO-MVO + DAPT-PGx-K + ISR-non-mTOR + LPA-siRNA-K → `CARDIO+/X5_korea_trials.md`
- [ ] X6 환자 본인 사례 retroactive — PCI 후속 4-axis 적용 (mPTP retroactive · CYP2C19 검사 · ISR risk · Lp(a) 검사) → `CARDIO+/X6_self_case.md`
- [ ] X7 교수님 handoff package (DOCTOR feed) — 4 트랙 통합 1-page executive + 즉시/6m/3y timeline → `CARDIO+/X7_doctor_feed.md`
- [ ] X8 cross-domain g5 grade ledger — 모든 영역 🔵 trajectory + 🟢 NUMERICAL 합산 + ⚪ fence + 🔴 falsified 통합 → `CARDIO+/X8_grade_ledger.md`
- [ ] X9 cross-domain d2 wall map — 4 sub-domain 각 wall + 돌파 path 시너지 (예: ALDH2*2 × Lp(a) × CYP2C19 stratification 통합) → `CARDIO+/X9_wall_map.md`
- [ ] X10 paper-ready figures — 4 sub-domain ASCII + 통합 1 figure (4-axis ranking radar · timeline · korean trial portfolio) → `CARDIO+/X10_figures.md`

## d2 governance (meta)

- 4-domain 동시 d2 wall 발견 시 → cross-domain breakthrough path 우선 (single PR이 4-domain 동시 unlock하는 leverage 사례)
- 인덱스 leak 방지: 4-domain 동시 작업 시 `git commit -o <paths>` 격리 commit 필수
- pool routing: small (PK · MC) ubu-1/2 · large (ODE · MD) RunPod per d7
- 모든 영역 🔵 trajectory: hexa-lang PR (RFC + recompute kernel) merge 후 unblock

## handoff (sub-domain → CARDIO+ → DOCTOR)

```
NOREFLOW ─┐
DAPTPGX  ─┤  → CARDIO+ X7 (compact)  → DOCTOR H1-H10 (final handoff)
ISR      ─┤      4-domain 통합           교수님 + 환자 본인
LPA      ─┘      + 한국 trial portfolio
```
