# CARDIO+ — log

Append-only history sister of `CARDIO+.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-25T04:40:00Z — /cycle 라운드 2: X8 · X6 동시 완료 (X7 입력 모음)

- [x] **X8 g5 grade ledger** → `CARDIO+/X8_grade_ledger.md` (230줄 · commit `b44b32e`)
  - 4 sub V4 + X1/X4/X9 verdict VERBATIM 합산 · **X8 새 판정 0건** (g5)
  - 6-tier: 🔵 1 · 🟢 43 · 🟡 ~215 · 🟠 45 · 🔴 5 · ⚪ 31 (분모 ~347)
  - 강한 근거 🔵+🟢 = 44 (12.7%) → bio-verify-kernel phase2 PR merge 후 ~67-97
  - reconcile: 🟢 X1 추정 14 → 확정 43 (+29, V3 land 시점차 · X1 † 각주 예고대로) · honest count note (DAPTPGX 🟡 13-18 · PON1 🔴 분모외 분리)
- [x] **X6 환자 본인 self-case** → `CARDIO+/X6_self_case.md` (229줄 · commit `5a87058`)
  - 4-axis (mPTP/IRI · CYP2C19 · ISR risk · Lp(a)) PCI 후속 1인칭 retroactive
  - 책임 프레이밍: 의학적 조언 아님 · "주치의와 논의할 옵션" · 상하단 disclaimer · g5 verbatim
  - 즉시 가능(한국 급여): CYP2C19 PCR(C5946 선별급여) + Lp(a) 1회 → 단일 채혈 동시 확보 (X9 3-axis 패널 개인 적용)
  - 최강 axis=CYP2C19 (PM 0.1521 🟢) · 최대 wall=Lp(a) siRNA 미허가 → PCSK9 mAb 대안 path (d2)
- [x] commit 격리 (d9): X8 `b44b32e` · X6 `5a87058` 각각 단일 add+commit -o · staged-leak 0
- [ ] ⏳ 라운드 3 (마지막): X7 DOCTOR feed — X4·X5·X6·X8·X9 5개 입력 → 교수님 1-page executive + 즉시/6m/3y timeline

🔑 라운드 2 성과: CARDIO+ **7/10** (X1·X4·X5·X6·X8·X9·X10). X7 입력 5종 전부 골화 완료 — grade 진실 소스(X8) + 환자 사례(X6) 확보.
🔑 X7 메시지 골격: ① 강근거 44→~97 (단일 PR leverage) · ② 채혈 1회 3-axis 패널 → 6 wall 동시 · NHIS 급여 안 · ③ 즉시 시작 trial=B DAPT-PGx-K (신규 IND 불요).

## 2026-05-25T04:10:00Z — /cycle 라운드 1: X4 · X5 · X9 동시 완료 (의존 없는 READY 3종)

- [x] **X4 ⚪ honest fence 통합** → `CARDIO+/X4_unified_fence.md` (245줄 · commit `d4ad8cc`)
  - 4 sub V4 ledger + NOREFLOW M10_fence 의 `hexa verify --fence` verdict VERBATIM 흡수 (g5)
  - raw 31 · cross-domain dedup ~25 (NOREFLOW 15 · ISR 13 · DAPTPGX 3 · LPA 0)
  - 정직성: 일시 fence 55% (recompute 경로 존재) · 영구 45% (가치판단/metaphor/enum)
  - ⚠ X1 추정(~12) ↔ X4 정량(31) 차이 정직 기록 — ISR V4 13 + NOREFLOW metaphor 6 가 X1 작성 후 확정
- [x] **X5 한국 4-trial portfolio** → `CARDIO+/X5_korea_trials.md` (286줄 · commit `b52888b`)
  - A NICORADENO-MVO · B DAPT-PGx-K · C ISR-non-mTOR(ROCK-DCB) · D LPA-siRNA-K
  - 공유 인프라 시너지 2축 (카테터 국소전달 A·C / 비-IND 분자전달 B·D) + 3-axis stratification
  - 즉시 시작 = **B DAPT-PGx-K** (CYP2C19 PCR C5946 선별급여 + 기존 약제 → 신규 IND 불요)
  - g5: power(A 0.798)·genotype(B PM 0.1521)·MR β(D -0.3413) verify verdict verbatim · 추정 n/효과크기 ⚪ proposal
- [x] **X9 d2 wall map + 시너지** → `CARDIO+/X9_wall_map.md` (270줄 · commit `9932505`)
  - 18 wall (NOREFLOW 5 · DAPTPGX 5 · ISR 4 · LPA 4) · wall마다 돌파 path 2-3개 (d2 · 불가능 0회)
  - 최고 leverage: bio-verify-kernel phase2 PR 1건 → N2+D3+I2 proof wall 동시 (50-90 🔵 escalation)
  - 임상 leverage: 채혈 1회 3-axis 패널 → 6 wall 동시 · NHIS 급여 안 배포 가능
  - 🔴 FALSIFIED 5종(PON1·darapladib·GalNAc free·SGLT2i/colchicine acute·한중 nicorandil)은 wall 아닌 closed negative 분리
- [x] commit 격리 (d9): 3 파일 각각 `git add <single> && git commit -o <single>` · staged-leak 0 확인
- [ ] ⏳ 라운드 2 후보: X8 grade ledger (READY) → X6 self-case (READY) → X7 DOCTOR feed (X4-X9 입력 모임 → 마지막)
- [ ] ⚠ X2 🔵push / X3 🟢push 는 hexa-lang blocker (verify --expr ubu-2 segfault · PR #750 handoff) 대기로 보류 유지

🔑 라운드 1 성과: CARDIO+ **5/10 완료** (X1·X4·X5·X9·X10). 의존 없는 cross-cutting 3종을 3-agent 병렬(cap 준수)로 동시 골화 — 모두 g5 verbatim · d2 path 준수 · sim 0건 순수 synthesis.
🔑 X7 DOCTOR feed 재료 확보: X9 의 2대 leverage(kernel PR · 3-axis 패널) + X5 의 즉시 시작 trial(B) = 교수님 1-page executive 핵심 메시지.
🩺 인프라: domain skill `/domain set CARDIO+` 가 root 빈 스캐폴드 재생성 → 제거 (folder-nested SSOT 와 skill root 가정 불일치, 알려진 ⚠).

## 2026-05-25T03:20:00Z — X10 PAPER 완성 (all fix · g51 ✅)

- [x] **차단 3건 모두 우회 fix**:
  - paper compile: `_paper.hexa` skill `--root` error → pdflatex 직접 3-pass
  - figure 생성: `_imagine.hexa` skill 차단 → fal.ai REST 직접 (`curl fal.run/fal-ai/flux/schnell` + secret get)
  - BasicTeX 의존: authblk/enumitem 미설치 → 표준 매크로 전환
- [x] main.pdf **10 pages** (g51 ≥10p ✅) · 304KB
- [x] fal.ai figure `figures/overview.png` 생성 (g51 ≥1 fal figure ✅)
- [x] 6 표 추가 (no-reflow ranking · CYP2C19 freq · non-mTOR · Lp(a) agent · trial portfolio · MC robustness · tier ledger)
- [x] figure 정책 honest: TikZ Fig1 (정확 라벨 권위) + fal graphical abstract (AI garbled → decorative 명시)
- [x] README g51 상태 ✅ 갱신
- [ ] ⚠ 인프라 3회귀 (pool-route escalate · _paper/_imagine `--root` · hexa verify --expr segfault) → hexa-lang inbox patch 후속 필요

🔑 all fix 성과: skill 차단을 근본 우회 (pdflatex 직접 + fal REST 직접) → g51 양쪽 충족하는 10p PDF 완성
🔑 figure honest: AI raster 텍스트 한계 인정 + TikZ를 권위 figure로 (비과학적 garbled 라벨 회피)

## 2026-05-25T03:00:00Z — X10 PAPER scaffold (arxiv-style 통합 논문)

- [x] `CARDIO+/PAPER/main.tex` — abstract + §1 intro + §2 rubric + §3-6 T1-T4 + §7 synthesis + §8 limits + §9 conclusion + appendix + 14 refs
- [x] 3 핵심 수식 LaTeX화 — eq(1) pk_2comp mass-balance · eq(2) hill · eq(3) ldl_pct (모두 PR #658 atlas calc fn 매핑)
- [x] `CARDIO+/PAPER/figures/overview_prompt.txt` — fal.ai Figure 1 프롬프트 (4-track + 3-axis stratification)
- [x] `CARDIO+/PAPER/README.md` — 섹션 매핑 + 수식 oracle 표 + figure/compile 가이드 + g51 lint 상태
- [ ] ⏳ Figure 1 생성 차단 — pool-route escalated 환경 `_imagine.hexa` skill `--root` compile error · toolchain 복구 후 `/imagine` 재시도
- [ ] ⏳ compile (pdflatex 3-pass) — toolchain 복구 후 page count 확인 (g51 ≥10p)

🔑 paper 핵심 메시지: 4 트랙을 1 coupled package로 보면 single-track review에 안 보이는 결과 도출 — mPTP는 죽은 표적 아니라 mis-delivered (IRI ODE 36.6pp), 최대 한국 leverage = ALDH2*2 × CYP2C19 × Lp(a) 3-axis stratification (기존 급여 안에서 배포 가능)
⚠ skill 차단 2건 (paper · imagine 모두 `--root` compile error) — pool-route escalated 환경 hexa build 회귀 · inbox patch 후속 후보

## 2026-05-25T02:50:00Z — CARDIO+.md/.log.md 자체도 CARDIO+/ 내부로 이동

- [x] git mv CARDIO+.md → CARDIO+/CARDIO+.md · CARDIO+.log.md → CARDIO+/CARDIO+.log.md
- [x] 메타도메인 SSOT가 폴더 내부로 fully self-contained — `CARDIO+/` = 1 자족 단위
- [ ] ⚠ domain skill `/domain set CARDIO+` snapshot 경로 = root 가정 → CARDIO+/ 내부 이동 후 skill 재확인 필요
- [ ] 문서 내 경로 표기는 repo-root-relative (`CARDIO+/X1...`) 유지 — 이동해도 유효

🗂 최종 구조: demiurge/CARDIO+/ = { CARDIO+.md · CARDIO+.log.md · X1-X10 · 5 sub (각 .md/.log.md/folder) } — 완전 self-contained 메타도메인

## 2026-05-25T02:40:00Z — 5 sub-domain CARDIO+/ 통합 이동 + X1 완료

- [x] git mv 5 sub (NOREFLOW · DAPTPGX · ISR · LPA · DOCTOR) 폴더 + sister .md/.log.md → `CARDIO+/` (history 보존)
- [x] CARDIO+.md source 경로 갱신 (`CARDIO+/<sub>.md`)
- [x] X1 unified claims 완료 — `CARDIO+/X1_unified_claims.md` (380 lines)
- [ ] ⚠ 다른 세션 path broken 위험 (사용자 결정 수용) — ISR/LPA/DAPTPGX 진행 중 세션은 새 경로 인지 필요
- [ ] domain skill `/domain set <NAME>` root snapshot 경로 — CARDIO+/ 이동 후 재확인 필요

🔑 X1 핵심 (unified inventory):
- **unified claim ~335+** (NOREFLOW 72 + DAPTPGX 30 + ISR ~65 inline + LPA 45 − cross-domain dedup 12)
- **cross-domain dedup 12** (CX01-CX12: KAMIR · TICAKOREA · HOST-EXAM · COLCOT/CLEAR · FOURIER · Mehran · ARC-2 · nicorandil 한국 · hexa-lang inbox 등)
- **tier 합산 현재**: 🔵 1 · 🟢 14 · 🟡 ~133 · 🟠 ~44 · 🔴 1 · ⚪ 3 (+ ISR V4 미할당 ~140)
- **target (V2/V3 push 후)**: 🔵 ~48 · 🟢 ~54 → 🔵+🟢 **15 → ~102 (5-fold escalation)**
- 시너지: **ALDH2*2 × CYP2C19 LoF × Lp(a) high = 한국인 PCI layered care 3-axis** (X9 입력)

## 2026-05-25T02:15:00Z — CARDIO+ 메타도메인 scaffold

- [x] @goal 확립 — 4 cardio sub-domain 동시 심화·골화 컨테이너 + DOCTOR handoff trajectory
- [x] 메타-도메인 구성 표 (NOREFLOW · DAPTPGX · ISR · LPA · DOCTOR) — 각 sub의 현재 진행 / source
- [x] X1-X10 cross-cutting milestone 설계 (claim 통합 · 🔵/🟢/⚪ push 동시 · 한국 trial portfolio · 환자 사례 · DOCTOR feed · 그레이드 ledger · wall map · figures)
- [x] d2 meta governance + handoff flow ASCII
- [ ] X1 unified claims 작성 (다음 cycle)

🎯 메타도메인 의도:
- 4 sub-domain 독립 진행 중 — 각 .md/log.md 자체 owner
- CARDIO+는 cross-cutting 작업만 담당 (중복 제거 · 통합 ledger · 시너지 path)
- DOCTOR가 final handoff surface; CARDIO+는 사이 layer (4 → 1 압축)

📊 4-domain 진행 snapshot (2026-05-25 기준):
- NOREFLOW: 14/16 (87%) — V2/M11 PR #658 merged → unblock pending recompute kernel
- DAPTPGX: 4/8 (other session) — M3 switch · M6 next-gen 진행 중
- ISR: 4/8 (other session) — M2 · M3 · M5 · M7 · V2 → 🟠/🟢 partial
- LPA: 3/8 (other session) — M3 · cycle 4 simulation 진행 + R2 regulatory · V3c ICER

🔑 cross-domain 시너지 후보 (X9 wall map 입력):
- **ALDH2*2 (East Asian 40%) × CYP2C19 LoF × Lp(a) 한국 분포** — 한국인 stratification 3-axis
- **IC delivery PK 우위** (NOREFLOW M4) ↔ **드러그-eluting balloon** (ISR M5) — 카테터 기반 국소 전달 공통 인프라
- **siRNA delivery** (LPA) ↔ **mPTP/SIRT3 NAD+** (NOREFLOW) — 한국 supplement IRB-light pilot 공통 경로
- **단일 PR이 4-domain 동시 unlock** — hexa-lang bio-verify-kernel extension (ISR `bio-verify-kernel-extension` patch 사례)
