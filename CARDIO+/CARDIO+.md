# CARDIO+ — current state

@goal: 4개 cardio sub-domain (NOREFLOW + DAPTPGX + ISR + LPA) 동시 심화·골화 진행 — 환자 본인 PCI 후속 + 교수님 첫 임상 적용 가능한 통합 evidence package + 한국 first-in-class 4-trial portfolio 완주 (모두 🟢 SUPPORTED-NUMERICAL 이상, ⚪ honest fence 분류 완료, DOCTOR handoff ready)

## 메타-도메인 구성 (per domain skill `+`)

> 2026-05-25: 5 sub-domain 폴더 + sister .md/.log.md를 `CARDIO+/` 아래로 통합 이동 (git mv, history 보존).

| sub | scope | 현재 진행 | source |
|---|---|---|---|
| **NOREFLOW** | PCI 직후 no-reflow / MVO 보호 | 14/16 (87%) | `CARDIO+/NOREFLOW.md` |
| **DAPTPGX** | 한국인 CYP2C19 DAPT 약물유전체 | (other session) | `CARDIO+/DAPTPGX.md` |
| **ISR** | in-stent restenosis 비-mTOR | (other session) | `CARDIO+/ISR.md` |
| **LPA** | Lp(a) 잔여 위험 침묵화 | (other session) | `CARDIO+/LPA.md` |
| **DOCTOR** | 교수님 handoff 패키지 | 10/10 (H1-H10 ✅) | `CARDIO+/DOCTOR.md` |

## milestones (cross-cutting · 4-domain 동시 진행)

- [x] X1 cross-domain V1 통합 — 4 sub-domain claim inventory 합산 + 중복 제거 + 통합 tier triage → `CARDIO+/X1_unified_claims.md`
- [x] X2 cross-domain V2 🔵 push 동시 — honest formal-tier 평가: 🔵 천장=number-theory 전용, bio claim=🟢 (d6) · ubu-2 segfault **mini 우회 입증** · 🔵 escalation=atlas 등록 PR 환원 → `CARDIO+/X2_blue_push.md`
- [x] X3 cross-domain V3 🟢 push 동시 — 4-domain recompute mini 재실측 통합 (🟢 43, X8 정합) · DAPTPGX v3/v5/v6.hexa 재실행 · PM×HBR 🟢 reconcile · ICER sign V6까지 🟠 (정직) → `CARDIO+/X3_green_push.md`
- [x] X4 cross-domain ⚪ fence 통합 — 4 sub-domain × subjective/prognostic claim 합산 honest fence → `CARDIO+/X4_unified_fence.md` (raw 31 · dedup ~25 · 일시 55%/영구 45%)
- [x] X5 한국 first-in-class 4-trial portfolio 통합 — Trial-A NICORADENO-MVO + DAPT-PGx-K + ISR-non-mTOR + LPA-siRNA-K → `CARDIO+/X5_korea_trials.md` (즉시 시작=B DAPT-PGx-K · 신규 IND 불요)
- [x] X6 환자 본인 사례 retroactive — PCI 후속 4-axis 적용 (mPTP retroactive · CYP2C19 검사 · ISR risk · Lp(a) 검사) → `CARDIO+/X6_self_case.md` (즉시=CYP2C19 PCR C5946 + Lp(a) 단일 채혈 · disclaimer)
- [x] X7 교수님 handoff package (DOCTOR feed) — 4 트랙 통합 1-page executive + 즉시/6m/3y timeline → `CARDIO+/X7_doctor_feed.md` (thesis: mPTP=mis-delivered · H1/H7/H8/H10 즉시 채움)
- [x] X8 cross-domain g5 grade ledger — 모든 영역 🔵 trajectory + 🟢 NUMERICAL 합산 + ⚪ fence + 🔴 falsified 통합 → `CARDIO+/X8_grade_ledger.md` (🔵1·🟢43·🟡~215·🟠45·🔴5·⚪31 · 강근거 44→~67-97)
- [x] X9 cross-domain d2 wall map — 4 sub-domain 각 wall + 돌파 path 시너지 (예: ALDH2*2 × Lp(a) × CYP2C19 stratification 통합) → `CARDIO+/X9_wall_map.md` (18 wall · 최고 leverage=bio-verify-kernel phase2 PR + 3-axis 패널)
- [x] X10 paper-ready — arxiv-style 통합 논문 `CARDIO+/PAPER/main.pdf` (10 pages · TikZ Fig1 + fal graphical abstract · 6 표 · 14 refs · g51 ✅) + `CARDIO+/PAPER/{main.tex,README.md}`

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
