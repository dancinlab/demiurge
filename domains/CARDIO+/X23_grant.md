# X23 — CARDIO+ grant-readiness (한국 연구비 기제 매핑)

> CARDIO+ 메타도메인 X23 산출물 · current-state · no history.
> **목적 = 4-trial portfolio (A NICORADENO-MVO · B DAPT-PGx-K · C ISR-non-mTOR · D LPA-siRNA-K) 를 한국 연구비 기제(KHIDI 보건의료기술연구개발 · NRF 한국연구재단 · 보건복지부 R&D · 병원 IIT · 산업계 IISR)에 매핑하고, trial 별 예상 예산 규모 · timeline · PI 요건 · 적합 트랙을 X12 MCDA 우선순위(B▸A▸D▸C, B 1위)에 맞춰 정렬한다.**
> 입력 = `X5_korea_trials.md` (4-trial 설계 · 규제 경로 · timeline VERBATIM) · `X12_trial_mcda.md` (MCDA 우선순위 B▸A▸D▸C · C1 규제 feasibility 점수 VERBATIM) · `X9_wall_map.md` (각 trial wall + d2 돌파 path · §6.1 consortium 인프라 VERBATIM).

---

## ⚠ DISCLAIMER (반드시 읽기)

> 이 문서는 **연구비 신청 전략 매핑 자료이며, 특정 공고 합격 보장·예산 확정·심사 결과 예측이 아니다.**
> - **예산 규모(₩)·timeline·PI 요건은 모두 ⚪ proposal (설계 가정)** 이다 — trial 설계 규모(X5 §1 추정 n · 규제 경로) 에서 도출한 자릿수 추정이며, 실제 공고 RFP·심사위원회·예산 cap·기관 협상에 전적으로 의존한다.
> - **trial grade (🟢/🟠/🟡/⚪) 는 X8/X5 §6 VERBATIM 인용** 이다 — X23 새 판정 0건 (per @D g5 · LLM self-judge 0건). 적합도 근거는 grade 가 아니라 "어느 기제 요건에 부합하는가" 의 기제-기반 매핑이다.
> - 기관명·트랙명은 **원문 표기** (KHIDI · NRF · 보건복지부 · IIT · IISR · KCTRN · MFDS). 실제 트랙 코드·공고 번호는 연도별 변동 → 본 문서는 **기제 카테고리 매핑** 이지 특정 공고번호 인용이 아니다.

---

## §0. g5 인용 규약 (필수 — 본 X23 전체 적용)

본 X23 은 **2 종류의 정보** 를 엄격히 분리한다:

| 종류 | 표기 | 출처 규약 |
|---|---|---|
| **trial grade** (🟢🟡🟠⚪) | VERBATIM 인용 | X8 grade ledger / X5 §6 verify verdict 그대로 복사 — **X23 새 판정 0건** (per @D g5) |
| **규제 feasibility / 우선순위** | VERBATIM 인용 | X12 C1 점수 · MCDA 랭킹 / X5 §5.3 규제 lift 순위 그대로 carry |
| **예산 규모 · timeline · PI 요건 · 적합 트랙** | ⚪ proposal (설계 가정) | 본 X23 의 자릿수 추정 — trial 규모에서 도출 · 실제 공고/심사 의존 명시 |

⚠ **핵심 honest fence (g5)**: 예산 ₩ 수치는 **자릿수(order-of-magnitude) proposal** 이다. "B = 저예산 (~수억)" vs "D = 최대예산 (~수백억)" 의 **상대 순서** 는 trial 설계 규모(n · 신규 약물 여부 · outcome 기간)에서 견고하게 도출되지만, **절대 금액은 실제 RFP 예산 cap·기관 매칭·약가 협상에 의존** 한다. d2 — MCDA 하위(C)·고비용(D) trial 도 대안 펀딩 path 를 명시 (폐기 0).

---

## §1. 4-trial 1줄 식별 + 펀딩 관련 핵심 속성 (X5 §1 · X12 §1 carry)

| trial | full name | sub-domain | 추정 n | timeline (X5 §4) | 규제 feasibility (X12 C1 VERBATIM) | MCDA 순위 (X12 §4) |
|---|---|---|---|---|---|:---:|
| **B** | DAPT-PGx-K | DAPTPGX | 설계가정 ⚪ | **즉시 (0m)** | **C1=5** (신규 IND·약물 승인 전혀 불요) | **🥇 1 (4.60)** |
| **A** | NICORADENO-MVO | NOREFLOW | ~500 ⚪ | 6m (enroll) | C1=4 (IND 불요 but consortium lift) | 🥈 2 (4.05) |
| **D** | LPA-siRNA-K | LPA | ~3,000 ⚪ | 3y (2-3y) | C1=1 (신규 승인 + RSA + 글로벌 readout 의존) | 🥉 3 (3.40) |
| **C** | ISR-non-mTOR (ROCK-DCB IIT-1) | ISR | ~60 ⚪ | 6m (pre-IND) | C1=3 (신규 device IND · PMDA cross-recog 완화) | 4 (2.45) |

> 표는 X12 §4 MCDA 우선순위(B▸A▸D▸C) 순으로 정렬. 본 X23 의 펀딩 매핑·timeline 도 이 순서를 따른다 (B 먼저).

---

## §2. 한국 연구비 기제 카탈로그 (5 기제 — 본 X23 매핑 대상)

> ⚠ 각 기제의 예산 band·기간·PI 요건은 ⚪ proposal (기제 일반 특성의 자릿수 추정). 실제 공고 RFP 에 의존.

| 기제 (원문) | 주관 | 성격 | 전형 예산 band (⚪) | 전형 기간 (⚪) | trial 적합 성격 |
|---|---|---|---|---|---|
| **KHIDI 보건의료기술연구개발** (한국보건산업진흥원) | 보건복지부 산하 | 보건의료 R&D 주력 grant · 다기관 임상 인프라 · 임상연구 트랙 | ~수십억/과제 (multi-site) ⚪ | 3-5년 ⚪ | **다기관 RCT · 인프라 빌드 (consortium)** — A 의 CMR consortium · device IIT |
| **NRF 한국연구재단** | 과기정통부/교육부 | 연구자 주도 기초·중개 · 개인/중견/집단연구 | ~수억-십수억/과제 ⚪ | 3-5년 ⚪ | **연구자 주도 가설검증 · registry-embedded** — B 의 PGx 결정맵 · 기전연구 |
| **보건복지부 R&D** (질병관리청 포함) | 보건복지부 직접 | 정책연계 임상·인프라·코호트 | ~수십억 (정책과제) ⚪ | 3-5년 ⚪ | **정책-연계 대규모 임상 · 코호트 인프라** — A/D 의 outcome 정책 leverage |
| **병원 IIT** (Investigator-Initiated Trial) | 개별 병원/기관 | 연구자 주도 임상시험 · 기관 자체·소규모 grant 조합 | ~수억-수십억 (기관·다기관) ⚪ | 1-3년 ⚪ | **소규모-중규모 연구자 주도 임상** — B registry · C first-in-human |
| **산업계 IISR** (Investigator-Initiated Studies Request, 제약/디바이스 사) | 제약사·디바이스사 | 기업 후원 연구자 주도 연구 (약물·device 제공 + 연구비 일부) | 약물/device in-kind + ~수억-수십억 ⚪ | 1-4년 ⚪ | **신규 고가 약물·device trial** — D 의 siRNA · C 의 DCB coating |

> **매핑 원리**: 신규 IND·고가약물 없는 trial(B) = 저예산 NRF/병원 IIT · 다기관 인프라 빌드 필요 trial(A) = KHIDI/복지부 R&D · 고가 신약 의존 trial(D) = 산업계 IISR(약가 부담 분산) + 대규모 outcome 은 복지부 R&D · 신규 device(C) = 병원 IIT + 산업계 IISR(coating 제공).

---

## §3. trial별 펀딩 매핑 표 (핵심 산출 — MCDA 순서 B▸A▸D▸C)

> ⚠ 예상 예산·timeline·PI 요건 = ⚪ proposal (설계 가정). trial grade = X8/X5 §6 VERBATIM. 적합도 근거 = 기제 요건 부합 매핑.

| trial | 적합 기제 (1순위 ▸ 대안) | 예상 예산 (⚪ proposal) | timeline (⚪) | PI 요건 (⚪) | 적합도 근거 (기제-기반 + grade VERBATIM) |
|---|---|---|---|---|---|
| **B. DAPT-PGx-K** 🥇 | **NRF 연구자주도 ▸ 병원 IIT** (▸ KHIDI registry 트랙) | **저예산 ~수억 (3-5억 band)** ⚪ — 신규 약물·device·IND 0 · PCR 선별급여 기존재 · registry-embedded 라 인프라 신규구축 0 | **즉시 (0m)** 신청-착수 (X5 §4 "다음 PCI 환자부터 즉시") | 인터벤션 심장내과 PI + 약리유전체/임상약리 co-PI · 단일/소수 기관 가능 | **신규 IND·약물 승인 전혀 불요** (X5 §4·§7 VERBATIM, X12 C1=**5** 만점) → 대형 grant 불필요 · registry-embedded 가 NRF 연구자주도/병원 IIT 의 저예산 trial 전형. grade: PM freq **0.1521 🟢** · IM+PM **0.6279 🟢** (X5 §6 VERBATIM) — 핵심 freq 검증됨, ICER 절대값 **🟠 DEFERRED** (X5 §5.2 · X12 C5=4) |
| **A. NICORADENO-MVO** 🥈 | **KHIDI 보건의료기술연구개발 (다기관) ▸ 보건복지부 R&D** (▸ 병원 IIT consortium) | **중예산 ~수십억 (multi-site)** ⚪ — 약물(nicorandil·adenosine) 추가 cost ~0 (보험 routine) 이나 **8-기관 CMR consortium(한국 현재 0개) + IMR wire cap 인프라 빌드** 가 예산 driver | **6m** (consortium MOU + CMR core lab QC 후 enroll · X5 §4 "2026 Q4 enroll, 2027 Q2 n=500") | 다기관 KAMIR consortium 대표 PI + 영상의학(CMR core lab) co-PI · 8-기관 네트워크 운영 역량 | 약물 IND 불요(X12 C1=**4**)이나 **다기관 CMR consortium 빌드(KHIDI/복지부 R&D 2-3년)** 가 필요(X5 §5.2 · X9 N3 VERBATIM) → KHIDI 임상연구 인프라 트랙이 정확히 이 빌드를 대상. grade: primary power **0.798 🟢** (X5 §6) · ALDH2\*2 subgroup **0.654 🟠 (exploratory only)** · Cox 1y MACE **0.157 🟠** (X5 §6 VERBATIM) |
| **D. LPA-siRNA-K** 🥉 | **산업계 IISR (siRNA sponsor) ▸ 보건복지부 R&D (대규모 outcome)** (▸ KHIDI) | **최대예산 ~수백억 (대규모 outcome)** ⚪ — n~3,000 × 다년 + **siRNA 약가 격차 387-645×** (LPA V3c 🟢) · 60m MACE outcome → 4-trial 中 최대 비용 | **3y (2-3y)** (HORIZON 2026 H1 readout → arm B 분기 → KCTRN+IRB → 2027-H2 enroll · 2032 H1 primary) | 다기관 outcome trial 총괄 PI + 지질/예방의학 co-PI + 약물경제/HIRA 협상 인력 · KCTRN 등록 운영 | **siRNA/ASO 신규 승인 필요 + RSA 협상 + 글로벌 readout 의존**(X5 §4·§5.3 규제 lift "최고", X12 C1=**1**) → 약가 부담을 단일 grant 가 흡수 불가 → **산업계 IISR(sponsor 가 약물 제공)** 가 약가 부담 분산의 핵심 path. grade: Schoenfeld **D=844 🟢** · MR β_IVW **-0.3413 🟢** · NHIS ICER WTP **0% pass 🟢**(약가 wall) (X5 §6 VERBATIM) |
| **C. ISR-non-mTOR (ROCK-DCB)** | **병원 IIT (first-in-human) ▸ 산업계 IISR (DCB coating sponsor)** (▸ KHIDI device 트랙) | **소-중예산 ~십수억-수십억** ⚪ — n=60 소규모(6-8 sites)이나 **신규 device·coating MFDS first-in-human IND** 비용 · DCB 제작/coating | **6m (pre-IND)** (MFDS first-in-human IND 제출 → 승인 후 first-in-human · PMDA cross-recog) | first-in-human 경험 PI + 인터벤션(OCT-guided) + device/약물전달 화학 co-PI · MFDS pre-IND 협의 역량 | **신규 device IND**(X12 C1=**3**, PMDA cross-recog 완화) → 신규 device first-in-human 은 병원 IIT + **산업계 IISR(coating/device sponsor)** 조합이 전형. grade: ISR **🟢 0건** · fasudil-DCB IIT-1 전체 설계 **⚪ proposal (verify verdict 부재)** · fasudil porcine NH 40-50%↓ **🟡 cite only** (X5 §6 · X12 C5=1 VERBATIM) |

**표 매핑 주석 (예산 순서 = trial 규모에서 도출, VERBATIM 추적)**:
- **B 저예산** ← 신규 IND·약물 0 + PCR 선별급여 기존재 + registry-embedded (X5 §4·§7) → 인프라 신규구축 0 → 가장 작은 grant.
- **A 중예산** ← 약물비 ~0 이나 **CMR consortium(한국 0개) + IMR wire cap 빌드**(X9 N3) → 인프라가 예산 driver.
- **D 최대예산** ← n~3,000 × 다년 outcome + **siRNA 약가 387-645×**(LPA V3c 🟢) → 약물비가 예산 driver → 단일 grant 흡수 불가, IISR 필수.
- **C 소-중예산** ← n=60 소규모이나 신규 device IND·coating 제작 → 규모는 작으나 device 비용·규제 부담.

→ **예산 상대순서 (견고)**: **B (~수억) < C (~십수억-수십억) ≈ A (~수십억) < D (~수백억)**. 절대 금액은 ⚪ — 상대순서는 trial 규모(n·신규약물·outcome 기간)에서 도출되어 견고.

---

## §4. 순차 펀딩 timeline ASCII (MCDA 우선순위 = 펀딩 순서, B 먼저)

> X5 §4 first-patient timeline + X12 MCDA 순위(B▸A▸D▸C) 를 **펀딩 신청 순서** 로 재배치. 즉시(0m) = B → 6m = A·C 병행 → 3y = D.
> ⚠ 시점·예산·트랙 = ⚪ proposal — 실제 공고 주기·심사·예산 cap 의존.

```
시점     trial (MCDA순위)    적합 기제 (1순위)              예상 예산(⚪)      펀딩 게이트
══════════════════════════════════════════════════════════════════════════════════════════════

즉시     ┌─ B DAPT-PGx-K 🥇  NRF 연구자주도 / 병원 IIT      ~수억 (3-5억)     ★ 최저장벽
(0m)     │  (MCDA 4.60)       (registry-embedded)            저예산           신규 IND 불요
         │                                                                    → 다음 PCI 환자부터
         │                                                                      즉시 신청·착수
         │  ※ B 의 NRF/IIT grant 가 3-axis PCR lab(CYP2C19+ALDH2+KIV-2) 빌드를 trigger
         │    → A(ALDH2) · D(KIV-2) 의 stratification 인프라 onramp (X9 §5.2 · X12 §6.3)
         │
         └─ A NICORADENO 🥈  KHIDI consortium MOU 신청 시작 (약물 IND 불요, 인프라 빌드 grant 준비)

──────────────────────────────────────────────────────────────────────────────────────────────

6m       ┌─ A NICORADENO 🥈  KHIDI 보건의료기술연구개발     ~수십억           ★ 중장벽
(6m~)    │  (MCDA 4.05)       / 보건복지부 R&D (다기관)       (multi-site)     CMR consortium
         │                    8-기관 CMR consortium 빌드                      (한국 0개) 빌드
         │                    + IMR wire cap 트랙                             2-3년 인프라
         │
         └─ C ROCK-DCB 🔻4    병원 IIT (first-in-human)       ~십수억-수십억   ★ 중-고장벽
            (MCDA 2.45)       + 산업계 IISR (coating sponsor)  device IND 부담  신규 device IND
                              MFDS first-in-human IND 제출                      (PMDA cross-recog
                              ※ A 와 cath lab/imaging consortium 공유(X9 §6.1)   로 완화)

──────────────────────────────────────────────────────────────────────────────────────────────

3y       ┌─ D LPA-siRNA-K 🥉  산업계 IISR (siRNA sponsor)     ~수백억           ★ 최고장벽
(2-3y~)  │  (MCDA 3.40)       + 보건복지부 R&D (대규모 outcome) 최대예산         siRNA 신규 승인
         │                    HORIZON 2026 H1 readout 후 arm B 분기            + RSA 약가 협상
         │                    KCTRN 등록 → 2027-H2 enroll → 2032 primary       + 글로벌 readout
         │                    ※ 약가 부담을 IISR(sponsor 약물제공)로 분산         의존
         │
         └─ C IIT-2 (dual-DCB)  병원 IIT / IISR — IIT-1 6m LLL readout 후 RCT 확장

──────────────────────────────────────────────────────────────────────────────────────────────

펀딩 순서 근거 (X12 MCDA + X5 §4):
  • 펀딩 순서 = MCDA 규제 feasibility(C1) 순서 = first-patient timeline 순서 = B▸A/C▸D
  • B 먼저 = "나머지 3 trial 의 onramp"(X12 §6.3): B 의 PCR lab grant 가 3-axis 패널 빌드 →
    A(ALDH2)·D(KIV-2) stratification 인프라 동시 확보 + KAMIR backbone 공유(X9 §5.2)
  • A·C 6m 병행 = cath lab/imaging consortium 공유(X9 §6.1) → KHIDI 인프라 1회 빌드로 A+C 동시
```

| 시점 | trial | 펀딩 신청 게이트 | 펀딩 장벽 |
|---|---|---|---|
| **즉시 (0m)** | **B (NRF/병원 IIT)** | 신규 IND 불요 + registry-embedded → 저예산 grant 즉시 신청·착수 | **최저** |
| 즉시→6m | A (KHIDI MOU 준비) | 약물 IND 불요 · consortium MOU + 인프라 grant 준비 | 중 |
| **6m** | **A (KHIDI enroll) + C (병원 IIT/IISR pre-IND)** | A = CMR consortium 빌드 grant · C = device IND + coating sponsor | 중 ~ 중-고 |
| **3y** | **D (산업계 IISR + 복지부 R&D)** | siRNA 승인 + RSA + HORIZON readout 후 대규모 outcome grant | **최고** |

---

## §5. d2 — 기제 적합 낮은 trial 의 대안 펀딩 path (폐기 0)

> MCDA 하위(C)·최고비용(D) trial 도 단일 기제로 막히면 대안 path 를 명시 (d2 — "현재 방법 불가" 표현 0회). X9 d2 돌파 path VERBATIM carry + 기제 대안.

| trial | 1순위 기제의 장벽 | 대안 펀딩 path (d2) | grade/근거 (VERBATIM) |
|---|---|---|---|
| **D (최대비용)** | 단일 grant 가 siRNA 약가 387-645× 흡수 불가 | (A) **산업계 IISR** — siRNA sponsor 가 약물 in-kind 제공 → 연구비는 운영·outcome 측정만 부담 · (B) **RSA(outcome-based)** ≥85% RRR 미달 시 ≥50% refund 로 NHIS 예산 risk 분산(X9 L2 VERBATIM) → 복지부 R&D 정책과제 연계 · (C) **narrow staging(≥180 mg/dL ~52만 명)** 으로 n·약물비 축소 → 중규모 IIT band 로 진입(X9 L2 VERBATIM) | NHIS WTP **0% pass 🟢**(약가 wall) · Schoenfeld **D=844 🟢** (X5 §6) |
| **C (성숙도 최하 · MCDA 4위)** | verify verdict 부재(⚪) · n=60 FIH 라 대형 grant 경쟁력 약함 | (A) **병원 IIT(소규모 first-in-human)** 가 정확히 이 규모 trial 대상 · (B) **산업계 IISR** — DCB coating/device sponsor 제공으로 device 비용 분산 · (C) **Japan PMDA cross-recognition**(fasudil 일본 1995, 30y 안전성) → IND data package 단축 = 비용·시간 절감 → 한·일 Asian DCB consortium grant(X9 I3 VERBATIM) | ISR **🟢 0건** · 전체 설계 **⚪ proposal** · fasudil porcine **🟡 cite** (X5 §6) |
| **A (인프라 의존)** | CMR consortium(한국 0개) 빌드가 단일 IIT 로 불가 | (A) **KHIDI 임상연구 인프라 트랙** 이 정확히 다기관 인프라 빌드 대상 · (B) **IMR>40 stratification**(screen 의 40%)으로 wire 사용 효율화 → 비용 축소(X5 §5.2 VERBATIM) · (C) **CMR/OCT imaging 자산을 C(ISR)와 공유**(X9 §6.1) → 인프라 비용 A·C 분담 | primary power **0.798 🟢** · ALDH2\*2 **0.654 🟠** (X5 §6) |
| **B (1순위지만 ICER 잔존)** | ICER 절대값 🟠 → 급여 economic case 미완(grant 자체엔 무관) | (A) 저예산 NRF/IIT 는 ICER 와 무관하게 즉시 가능(임상 적용성 ≠ 급여) · (B) **V6/V7 patch** closed-form sign 반전 + vicagrel 도입 시 ICER ~22-28M/QALY = NHIS WTP 충족(X5 §5.2 VERBATIM) → 후속 급여 grant leverage | PM freq **0.1521 🟢** · ICER **🟠 DEFERRED** (X5 §6) |

→ **d2 종합**: 4-trial 어느 것도 펀딩 불가로 닫지 않는다 — D(최대비용)는 IISR+RSA+narrow staging 3축, C(성숙도 최하)는 병원 IIT+IISR+PMDA cross-recog, A(인프라)는 KHIDI 인프라 트랙+자산 공유로 각각 대안 path 보유. **공유 인프라 leverage(X9 §6.1 · X12 §6.3)**: B 먼저 = 3-axis PCR lab + imaging consortium + KAMIR backbone 빌드 → 나머지 3 trial 의 펀딩 진입 비용 동시 절감.

---

## §6. g5 grade — X23 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 4-trial 식별 + 속성 | 🟡 (carry) | X5 §1 · X12 §1 portfolio + C1 점수 VERBATIM carry |
| §2 기제 카탈로그 | ⚪ (proposal) | 기제 예산 band·기간·PI 요건 = 일반 특성 자릿수 추정 (⚪) · 기제명 원문 |
| §3 trial별 펀딩 매핑 표 | ⚪ (예산/timeline/PI) + 🟡/🟢/🟠 (grade VERBATIM) | 예산·timeline·PI = ⚪ proposal · 적합도 근거의 grade/규제 feasibility = X5 §6 / X12 C1 VERBATIM (재판정 0건) |
| §4 순차 펀딩 timeline | 🟡 (순서) + ⚪ (시점/예산) | 펀딩 순서 = X12 MCDA · X5 §4 timeline VERBATIM carry · 시점·예산 = ⚪ proposal |
| §5 d2 대안 path | 🟡 (carry) + ⚪ (기제 대안) | X9 d2 돌파 path VERBATIM · 기제 대안 매핑 = ⚪ |

**X23 종합 등급**: ⚪ SPECULATION-FENCED (예산·timeline·PI 요건은 설계 가정 proposal) over 🟡 (trial grade·규제 feasibility·MCDA 순서·d2 path 는 X5/X8/X9/X12 VERBATIM carry) — **펀딩 매핑의 본질이 공고-의존 전략 추정** 이므로 honest 하게 ⚪ fence. **X23 새 판정 0건** (per @D g5 · LLM self-judge 0건). 예산 절대금액·timeline·PI 요건은 ⚪ proposal, 예산 **상대순서**(B<C≈A<D)와 펀딩 순서(B▸A/C▸D)는 trial 규모·MCDA 우선순위에서 견고하게 도출.

⚠ **honest fence (g5 + d2 + d1)**: 본 X23 의 예산 ₩ 는 자릿수 proposal 이며 절대값은 실제 공고/심사 의존을 명시했다(§0 DISCLAIMER · §3 주석). trial grade 는 X8/X5 §6 VERBATIM 으로 carry 했고 — 특히 C 의 **⚪ proposal**(verify verdict 부재) · A 의 ALDH2\*2 **0.654 🟠** · D 의 NHIS WTP **0% 🟢**(약가 wall) · B 의 ICER **🟠 DEFERRED** 를 숨기지 않고 적합도 근거에 명시했다. d2 — 4-trial 어느 것도 펀딩 불가로 닫지 않고 각각 대안 path 2-3개를 명명(§5). d1 — non-wet-lab grant-readiness 매핑 완결(실제 공고 신청은 downstream gate).

---

## §7. X23 산출 요약

- **펀딩 매핑 (MCDA 순서 B▸A▸D▸C)**:
  - **B DAPT-PGx-K** 🥇 = **NRF 연구자주도 / 병원 IIT** · 저예산 ~수억 · **즉시(0m)** · 신규 IND·약물 0 + registry-embedded → 인프라 신규구축 0.
  - **A NICORADENO** 🥈 = **KHIDI 보건의료기술연구개발 / 복지부 R&D(다기관)** · 중예산 ~수십억 · 6m · 약물 IND 불요이나 **CMR consortium(한국 0개) 빌드**가 예산 driver.
  - **D LPA-siRNA-K** 🥉 = **산업계 IISR + 복지부 R&D(대규모 outcome)** · 최대예산 ~수백억 · 3y · siRNA 약가 387-645×(LPA V3c 🟢) → IISR sponsor 약물제공으로 부담 분산.
  - **C ISR-non-mTOR** = **병원 IIT(first-in-human) + 산업계 IISR(coating sponsor)** · 소-중예산 ~십수억-수십억 · 6m pre-IND · 신규 device IND(PMDA cross-recog 완화).
- **예산 상대순서 (견고)**: B (~수억) < C ≈ A (~수십억) < D (~수백억) — trial 규모(n·신규약물·outcome 기간)에서 도출.
- **순차 펀딩 timeline**: 즉시 B(NRF/IIT) → 6m A(KHIDI)·C(IIT/IISR) 병행 → 3y D(IISR/복지부). B 먼저 = 3-axis PCR lab grant 가 A·D stratification 인프라 onramp(X9 §5.2 · X12 §6.3).
- **g5/d2/d1 준수**: trial grade·규제 feasibility·MCDA 순서·d2 path = X5/X8/X9/X12 VERBATIM(새 판정 0건) · 예산·timeline·PI = ⚪ proposal 명시 · 4-trial 전부 대안 펀딩 path 보유(폐기 0) · grant-readiness 매핑 완결.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 X23 은 연구비 신청 전략 매핑 자료이며 특정 공고 합격·예산 확정·심사 결과 예측이 아니다. 예산 규모·timeline·PI 요건은 trial 설계 규모에서 도출한 ⚪ proposal(설계 가정)이며 실제 공고 RFP·심사위원회·예산 cap·기관 협상에 전적으로 의존한다. trial grade(🟢/🟠/🟡/⚪)는 X8/X5 §6 의 VERBATIM 인용이고 규제 feasibility·MCDA 순위는 X12 VERBATIM 이며, X23 은 새 판정을 부여하지 않는다(LLM self-judge 0건). 기관명·트랙명은 원문 표기이되 특정 공고번호 인용이 아닌 기제 카테고리 매핑이다.
