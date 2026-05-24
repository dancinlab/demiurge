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
- [x] X11 통합 layered-care 프로토콜 — 4축을 채혈 1회 3-axis 패널서 분기하는 단일 침상 결정흐름 (1 패널 → 6 wall 동시 stratify) → `CARDIO+/X11_layered_care.md`
- [x] X12 4-trial MCDA 우선순위 — B DAPT-PGx-K 1위(4.60, 5/5 민감도 robust) ▸ A ▸ D ▸ C · 가중치 ⚪ proposal → `CARDIO+/X12_trial_mcda.md`
- [x] X13 red-team falsification — 8 claim 적대검정 (survives 2·weakened 4·🔴-flip 후보 1) · thesis "mis-delivered" hedge 권고 · numerical→causal over-read 최대 취약 · gradedown 0 → `CARDIO+/X13_redteam.md`
- [x] X14 known-unknowns 레지스트리 — VoI 카탈로그 21건 · top=IC-sync delivery IIT (thesis 전체 gate) · 즉시7/readout5/IIT6/장기3 → `CARDIO+/X14_known_unknowns.md`
- [x] X15 환자 본인 self-case 운영화 — 다음 외래 액션 카드 (채혈 1회 3-axis 주문 + 주치의 질문 스크립트 + timeline) → `CARDIO+/X15_self_action.md`
- [x] X16 안전성/harm profile 통합 — 4-track 중재별 부작용·모니터링·중단규칙 · 최대 출혈위험=ticagrelor (TICAKOREA 2.8%) → `CARDIO+/X16_safety.md`
- [x] X17 5번째 sub-domain 후보 스캔 — 추천=AF 항응고 PGx (VKORC1 East Asian ~90% · CYP2C9) → 3-axis→4-axis 패널 확장 · TAVR 명시 제외 → `CARDIO+/X17_fifth_domain.md`
- [x] X18 국제 transportability — 3-axis 생물학 한·일·중 일반화 (백인 ALDH2*2 ~0% 비적용) · 적용만 한국 특이 · 공동 trial=NICORADENO ALDH2*2 → `CARDIO+/X18_transportability.md`
- [x] X19 budget-neutral 재프레이밍 — cost-offset(회피사건비−중재비) · self-funding top=CYP2C19 결정맵(5y −44억) + IC adenosine/nicorandil(약가≈0) → `CARDIO+/X19_budget_neutral.md`
- [x] X20 subtraction medicine — de-implement 7건 (routine thrombectomy Class III · mPTP IV bolus 🔴×4 · universal ticag 출혈2배) · 전면금지≠none, bailout 잔여 명시 → `CARDIO+/X20_subtraction.md`
- [x] X21 anti-portfolio 경계정의 — 포함기준 4축(PCI-후속·한국leverage·공유인프라·직교성) · TAVR 단호제외(→STRUCT+) · CAC/AF-ablation 경계선 → `CARDIO+/X21_anti_portfolio.md`
- [x] X22 AI-PGx CDS 알고리즘 spec — 입력 12변수 → DAPT 권고+alert · 금기 게이트 우선 · 검증1순위=caller concordance (구현 아닌 spec) → `CARDIO+/X22_ai_pgx_cds.md`
- [x] X23 grant-readiness — 4-trial 한국 펀딩 5기제 매핑 · 즉시=B DAPT-PGx-K(NRF/IIT ~3-5억) · 최대=D siRNA(IISR+RSA) · 예산순서 B<C≈A<D → `CARDIO+/X23_grant.md`
- [x] X24 환자-facing 평이언어 — 🔌CYP2C19/🍯Lp(a)/🍺ALDH2 비유 · "검사≠진단·약 임의중단 금지·결정은 의사와" · disclaimer → `CARDIO+/X24_patient_facing.md`
- [x] X25 wet-lab readiness — d5 non-wet→wet 다리 · 최소 실험 14건 · 최우선=IC-sync delivery IIT(thesis gate) · 외부 readout 의존 4(HORIZON 등) → `CARDIO+/X25_wetlab_readiness.md`
- [x] X26 living-doc 자동화 spec — X8 grade ledger=단일 SSOT → DOCTOR/X7 derived 9개 auto-regen · drift lint(H8/H10 🟢% 불일치 적발) → `CARDIO+/X26_living_doc.md`
- [x] X27 불확실성 UQ 집계 — CI 있는 🟢 5(LPA bootstrap) vs 없는 ~38(robustness gap 정직) · 민감도 최대=v8 ICER(horizon) · bootstrap 1순위=NOREFLOW Δ36.6pp → `CARDIO+/X27_uncertainty.md`
- [x] X28 index-patient 10y microsim — illustrative 환자(65yo·IM·Lp(a)high·ALDH2*2) 10년 Markov · 3-axis 층화 vs 표준 Δ+0.066 QALY·사망−1.28pp (mini 실측 · projection ⚪) → `CARDIO+/X28_patient_microsim.md`
- [x] X29 EMR-CDS 배포 설계 — X22 spec→BPA 9 trigger(핵심=ticag Month-1 모니터) · fatigue=관련성 게이팅 · POCT 90분 "처방 전 결정" · SaaS scale-out → `CARDIO+/X29_emr_cds_deploy.md`
- [x] X30 채택 lever — default-nudge(최강이자 최대 역효과) · P4P/적정성평가 · audit-feedback · champion/약사 · 책임장벽은 ①+②⑤ stack 필요 → `CARDIO+/X30_adoption_levers.md`
- [x] X31 배포 roadmap/playbook — 즉시/6m/1y/3y phasing · 배포=증거 LHS 루프 · 실패모드(alert fatigue 최대) · DOCTOR H11 deployment playbook feed → `CARDIO+/X31_deploy_roadmap.md`
- [x] X32 교육·인력 — 4대상(전공의·전문의·약사·간호) PGx-DAPT 커리큘럼·CME · genetic counselor 부족→CDS+약사+counselor 3-경로 분산(d2) · 역할분담 → `CARDIO+/X32_workforce_training.md`
- [x] X33 수가·재정·지속가능 — HIRA 청구(C5946+prasugrel 코드·삭감방지) · 지속주체=병원(self-funding 정렬) · VBC metric=ST↓+출혈균형 → `CARDIO+/X33_reimbursement_sustainability.md`
- [x] X34 거버넌스·동의·형평 — 7-직역 PGx 위원회(권고강도=근거강도) · 3-계층 동의(법령 ⚪/🟡) · 채혈-only 3-axis 지역 형평 + POCT/telegenetics/SaaS 3-bridge → `CARDIO+/X34_governance_consent_equity.md`
- [x] X35 inaction cost (배포 capstone) — 비채택 연 toll: 사망 +240명·ST +400·QALY ~3,316 vs 약가 1y −167억 절약 = devil's bargain (mini 실측 · X19와 정합) → `CARDIO+/X35_inaction_cost.md`

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
