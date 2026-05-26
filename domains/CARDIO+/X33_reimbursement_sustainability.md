# X33 — CARDIO+ 수가·재정·지속가능 (reimbursement / sustainability · 배포 청구 워크플로우 + 유지 재정)

> CARDIO+ 메타도메인 X33 산출물 · current-state · no history.
> **목적 = 배포 재정 실무를 3축으로 통합한다 — (a) HIRA 청구 워크플로우(CYP2C19 PCR C5946 선별급여 청구 + prasugrel 5mg 코드 + 삭감 방지), (b) 지속 funding·거버넌스(파일럿 grant 후 누가 lab·CDS 유지 — 병원/보험/학회), (c) value-based contract(보험자와 outcome-based 지불 · X19 budget-neutral 위에).**
> 입력 = `X19_budget_neutral.md` (budget/self-funding · 사건 단가·약가·net VERBATIM) · `X23_grant.md` (파일럿 펀딩 기제·대안 path VERBATIM) · `X30_adoption_levers.md` (②P4P·④business case lever VERBATIM) · `DAPTPGX/M8_econ.md` (수가 코드·약가·사건 단가·budget impact VERBATIM). **수가 코드·단가·grade·net 은 모두 M8/X19/X23/X30 VERBATIM** — X33 새 판정 0건 (per @D g5 · LLM self-judge 0건). 수가 협상·VBC 구조는 ⚪ proposal (HIRA 의존 명시) · d2 — 삭감/지속재정 막힘에 돌파 path 동반 · d6 — net 부호·환급 강제 금지(정직 fence).

---

## ⚠ DISCLAIMER (반드시 읽기)

> 이 문서는 **배포 재정·청구·거버넌스 실무 전략 자료이며, 청구 코드 적용·삭감 결과·수가 협상 결과·급여결정을 보장하지 않는다.**
> - **수가 코드(C5946 등)·급여 유형·약가는 M8 §2 NHIS 2025 고시 VERBATIM** 이나, **삭감 위험·방지책·청구 워크플로우 운영은 ⚪ proposal** (실제 HIRA 심사 기준·심사사례·삭감률 검증 전)이다. 본 문서는 청구 코드 카테고리 매핑이지 특정 심사 결과 예측이 아니다.
> - **지속 재정 모델(누가 유지비를 대나)·value-based contract 구조는 전부 ⚪ proposal** — 실제 병원 결재·보험자 협상·학회 채택은 downstream gate 다. 본 문서는 X19 self-funding 구조 위에 올린 **재정 거버넌스 제안**이다.
> - **VBC outcome 환급 부호·절감 공유 금액은 X19 net 에 의존하며, X19 net 은 효과 가정(⚪ proposal)·사건 단가(🟠 INSUFFICIENT, M8 §10)·horizon 에 민감**하다(X19 §4). 따라서 본 X33 의 환급/공유 구조는 X19 의 정직 fence 를 그대로 상속한다 — net 부호를 강제하지 않는다(d6).
> - 본 문서의 모든 처방·진단 관련 코드는 **재정 워크플로우 맥락**이며 처방 명령이 아니다. 임상 효능·안전·결정맵은 X5/X16/X11 에 별도 fence 돼 있다.

---

## §0. g5 인용 규약 (필수 — 본 X33 전체 적용)

본 X33 은 **3 종류의 정보** 를 엄격히 분리한다:

| 종류 | 표기 | 출처 규약 |
|---|---|---|
| **수가 코드 · 급여 유형 · 단가 · grade** | VERBATIM 인용 | M8 §2/§10 (C5946·약가·사건 단가·grade) · X19 (net·사건 단가) 그대로 복사 — **X33 새 판정 0건** (per @D g5) |
| **net 절감/순지출 · self-funding 부호** | VERBATIM 인용 | X19 §1·§5·§6 net (① 1y +29.5M / 5y −44억) 그대로 carry · 효과 가정 fence 도 상속 |
| **삭감 위험 · 방지책 · 지속 재정 주체 · VBC 구조** | ⚪ proposal (운영 가정) | 본 X33 의 재정 실무 제안 — 실제 HIRA 심사·병원 결재·보험자 협상 의존 명시 |

⚠ **핵심 honest fence (g5)**: 수가 코드(C5946)·급여 유형(선별급여)·약가(prasugrel 5mg 1,500원/일)·사건 단가(ST 15M 등)는 M8 §2 VERBATIM 이다. 그러나 **"이 코드를 이렇게 청구하면 삭감 위험이 X" 와 "누가 유지비를 댄다"·"VBC 로 얼마를 환급/공유한다" 는 전부 ⚪ proposal** — 실제 HIRA 심사 기준·삭감 사례·기관 협상에 의존한다. d6 — VBC 환급 금액·지속 절감액은 X19 net 에 의존하고 X19 net 은 효과 가정·사건 단가·horizon 에 민감하므로(X19 §4) 부호를 강제하지 않는다.

---

## §1. (a) HIRA 청구 워크플로우 표 (핵심 산출 — 수가 코드·급여 유형·삭감 위험·방지책)

> ⚠ 수가 코드·급여 유형·단가 = M8 §2/§10 VERBATIM · grade VERBATIM · **삭감 위험·방지책은 ⚪ proposal** (실제 HIRA 심사 기준 검증 전). "POCT" = point-of-care CYP2C19 genotyping (Spartan RX 류).

| 항목 | 수가 코드 | 급여 유형 | 삭감 위험 (⚪ proposal) | 방지책 (⚪ proposal) |
|---|---|---|---|---|
| **CYP2C19 PCR (real-time)** | **C5946** (M8 §2 VERBATIM) | **선별급여 (PCI 환자 대상)** · ~50,000원/명 · 1회 (M8 §2 · §10 🟡 SUPPORTED-BY-CITATION 보건복지부 행위급여) | **중** — 선별급여는 적응증(PCI 시행 + DAPT 처방 예정) 명시 필수 · ① 동일 환자 재검(중복 PCR) 삭감 · ② "PCI 안 한 / DAPT 미처방" 환자에 청구 시 적응증 외 삭감 · ③ 결과를 처방에 반영 안 한 검사(결정맵 미적용)는 "불필요 검사" 지적 위험 | (1) 청구 시 **PCI 시술코드(스텐트 삽입) + DAPT 처방을 같은 episode 에 동반** 기재 → 적응증 자동 입증 · (2) PCR 1회/환자 enforce (EMR 중복 오더 차단) · (3) **결과→결정맵→처방 연결을 EMR 에 기록**(X30 ①default 의 시스템 기록이 곧 삭감 방어 근거) → "knew-and-applied" 추적 |
| **prasugrel 5mg** | NHIS 급여 약가 ~1,500원/T · **일 1,500원** (에피언트 Daiichi-Sankyo, M8 §2 VERBATIM) — 한국 5mg 가 표준 권고 (10mg 드묾) | **급여** (ACS·PCI DAPT 적응증) | **중-고** — ★ **최대 삭감 위험 항목** — ① **≥75세·<60kg 금기/감량 환자에 prasugrel 처방 시 삭감 + 안전 역효과**(X16: prasugrel ≥75yo TIMI major 4.3% vs 3.3% HR 1.36 net harm VERBATIM) · ② 한국 허가사항(5mg 표준)과 다른 용량(10mg) 처방 시 삭감 · ③ DAPT 적응증(ACS/PCI) 외 처방 삭감 | (1) **EMR default 가 X16 안전 결정맵 그대로**(NM=clopidogrel·≥75yo clopi 강제·<60kg 감량 고려) → 금기 환자 자동 차단(X30 §1 ① 안전 default) · (2) 처방 시 **PCI/ACS 적응증 + 체중·연령 입력 강제** → 허가사항 부합 자동 검증 · (3) IM/PM genotype 결과(C5946) 를 처방 사유로 동반 기재 |
| **Lp(a) 검사** | 코드 유무 = ⚪ (M8 미수록 — 본 X33 carry 안 함) · LPA sub-domain V3c 약가 격차 387-645× (X19 #5 VERBATIM) | 검사 자체는 일반 lipid 패널 일부 가능하나 **siRNA 치료 연계 = 비급여 신약**(X19 #5: 순지출 명백, self-funding ❌) | **고** (치료 연계 시) — ① Lp(a) 검사 자체보다 **연계 siRNA/ASO 가 신규 비급여 → 급여 청구 불가**(X19 #5 약가 387-645× 격차) · ② PCSK9 ASCVD 2차 급여는 적응증(LDL 목표 미달) 엄격 → 적응증 외 삭감 | (1) Lp(a) 측정은 **위험 stratification(검사 행위)으로 분리** — 치료 청구와 별도(X30 §4: 패널 측정 = 검사 행위, grade 무관) · (2) siRNA 는 **VBC/RSA 로만 진입**(§3 · X19 #5: RSA + narrow staging) — 일반 급여 청구 시도 금지 · (3) PCSK9 는 ASCVD 2차 급여 적응증 엄격 준수 |
| **POCT (point-of-care CYP2C19)** | **코드 부재** — Spartan RX 류 = **비급여** ~60,000-80,000원 (대학병원 일부, M8 §2 VERBATIM) | **비급여** (C5946 PCR 와 별개 — POCT 전용 수가 코드 없음) | **고 (급여 청구 불가)** — ① POCT 는 전용 코드 부재 → **급여 청구 자체 불가**(비급여 본인부담) · ② 같은 환자에 POCT + C5946 PCR 중복 시 PCR 만 인정·POCT 삭감 · ③ 비급여라 환자 본인부담 동의 누락 시 민원/환수 | (1) **POCT 는 비급여 본인부담 사전 동의서** 필수 · (2) 급여가 필요하면 **C5946 PCR 경로 사용**(POCT 는 turnaround 우선 시만) · (3) d2 돌파 path — **POCT 신규 수가 코드 신설을 HIRA 에 건의**(M8 §6: POC 30,000원 도입 시 S4 ICER 47M→24M dominant 전환 근거로 cost-effectiveness 제시) · POCT 도입은 X16 응급 primary PCI 시간 장벽(X30 §3 장벽 B) 해소 leverage |

**표 grade·코드 추적 주석 (VERBATIM)**:
- **C5946 = 보건복지부 행위급여 선별급여** (M8 §2·§10: "C5946 (선별 급여, PCI 환자 대상)" · 🟡 SUPPORTED-BY-CITATION) · ~50,000원/명 1회.
- **prasugrel 5mg = ~1,500원/T, 일 1,500원** (M8 §2: 에피언트 Daiichi-Sankyo) · 한국 5mg 표준, 10mg 드묾.
- **prasugrel ≥75yo net harm** = X16 VERBATIM(X30 §1 carry): TIMI major 4.3% vs 3.3% (HR 1.36) → 금기 환자 처방 = 삭감 + 안전 dual jeopardy.
- **POCT 비급여 60,000-80,000원** = M8 §2 ("CYP2C19 POC (Spartan RX) · 비급여 · 대학병원 일부") · VerifyNow P2Y12 PRU ~80,000원 비급여(일부 indication 인정) carry.
- **siRNA 순지출 = self-funding ❌** = X19 #5 VERBATIM(약가 387-645× → 회피 사건비로 상쇄 불가).
- **POCT 신규 코드 건의 근거** = M8 §6 민감도 ★★★: "CYP2C19 test 비용 30,000-100,000원 → ICER 24M↔47M" · "POC 도입으로 30,000원 ↓ 시 S4 명확히 dominant".

> **삭감 위험 종합**: 검사(C5946)는 적응증·중복·결과반영의 process 위험이고, 약제(prasugrel 5mg)는 **금기 환자(≥75세·<60kg)·허가용량·적응증의 안전-연동 위험**이라 더 크다. POCT 는 코드 부재로 급여 청구 자체가 불가(비급여). 모든 방지책의 공통 축 = **EMR 이 X16 안전 결정맵·적응증·허가사항을 처방 시점에 검증·기록**(X30 ①default 의 시스템 기록 = 삭감 방어 근거).

---

## §2. (b) 지속가능 재정 모델 ASCII (파일럿 grant → 정착 후 유지비 누가 — 병원/보험/학회)

> ⚠ 핵심 정직(d2/d6): 파일럿(X23 grant) 후 **lab(C5946 PCR)·CDS(EMR 결정맵)·약사 클리닉의 유지비를 누가 대느냐**가 지속가능성의 본질이다. 유지 재정 주체·금액은 ⚪ proposal. X19 self-funding 구조(CYP2C19 5y −44억 절감)와 X30 ②P4P·④business case lever 에 연계.

```
 지속가능 재정 모델 — 파일럿 grant → 정착 후 유지비 누가 대나
═══════════════════════════════════════════════════════════════════════════════════

 [PHASE 0] 파일럿 (X23 VERBATIM)
 ─────────────────────────────────────────────────────────────────────────────────
   B DAPT-PGx-K 🥇  ── NRF 연구자주도 / 병원 IIT (저예산 ~수억, 즉시 0m)
                       → 3-axis PCR lab + EMR CDS(결정맵) + 약사 클리닉 초기 빌드
                       ※ grant 는 "빌드" 비용 — 종료 후 "유지" 비용 공백이 진짜 문제
                                          │
                                          ▼  파일럿 종료 후 유지비 공백 (sustainability cliff)
 ─────────────────────────────────────────────────────────────────────────────────
 [PHASE 1] 정착 후 유지비 — 3 주체 (각 ⚪ proposal · 현실성 순)
 ─────────────────────────────────────────────────────────────────────────────────

  ┌─ ① 병원 (평가등급↑ + self-funding)  ████████████  ★ 가장 현실적 (구조적 정렬)
  │     • C5946 PCR = 선별급여 → 검사 수익이 lab 운영비 일부 자체 충당
  │     • CDS·약사 클리닉 유지비 ← 병원이 부담하되 동기 = "평가등급↑"
  │       (X30 ②: HIRA 적정성평가 등급 = 환자유입·수가 가산 → 유지 ROI)
  │     • X19 self-funding: ② 3-axis 한계비용≈0 · ① CYP2C19 5y −44억 절감
  │       → 병원 budget impact 가 5y 에 양(+) (단 1y +29.5M 순지출 정직)
  │                                          │
  ├─ ② 보험(NHIS) — 절감 공유(shared saving)  ██████░░░░  중 (제도 lead-time 김)
  │     • X19 ① CYP2C19 5y −44억 절감(80k scale, M8 §7)을 NHIS 가 일부 환원
  │       → 절감의 일부를 lab·CDS 유지비로 shared-saving 환급(§3 VBC)
  │     • ② P4P/적정성평가 가산(X30 ②)이 사실상 유지비 보조 기능
  │       ★ 단 net −44억은 5y horizon·효과 가정·사건 단가(🟠) 의존(X19 §4)
  │                                          │
  └─ ③ 학회(KSC/KAMIR) — 거버넌스·표준 유지  ████░░░░░░  중약 (재정 아닌 정당성)
        • 재정 주체라기보다 "결정맵 표준·CDS 콘텐츠·교육"의 거버넌스 유지
        • X30 ⑤champion: 가이드라인 등재 = 채택 정당성 + 책임 기준선 이동
          → 병원의 유지 동기(평가등급)와 보험의 환급 근거를 떠받침
        • KAMIR 레지스트리 = outcome 측정 인프라(§3 VBC 의 metric 공급원)

 ═══════════════════════════════════════════════════════════════════════════════════
 지속 재정의 구조 (3 주체 분업):
   병원(①) = 유지비 직접 부담 주체 (동기 = 평가등급 + 검사수익 + 5y self-funding)
   보험(②) = 절감 공유로 유지비 일부 환원 (동기 = NHIS 5y −44억 budget impact)
   학회(③) = 표준·거버넌스·outcome 인프라 (재정 아닌 정당성·metric 공급)
 ───────────────────────────────────────────────────────────────────────────────────
   ★ 현실성: ① 병원 > ② 보험 > ③ 학회
     — 병원은 검사수익(C5946 선별급여)+평가등급으로 동기가 구조적으로 정렬,
       보험은 5y horizon·효과 가정 의존(제도 lead-time 김), 학회는 재정 주체 아님
 ═══════════════════════════════════════════════════════════════════════════════════
```

| 주체 | 무엇을 유지 | 재정 출처 (⚪ proposal) | 동기 (lever) | 현실성 | X19/X30 VERBATIM 연계 |
|---|---|---|:---:|:---:|---|
| **① 병원** | lab(C5946 PCR) · EMR CDS · 약사 클리닉 | C5946 검사수익 + 병원 운영비 (평가등급 ROI 로 정당화) | **평가등급↑**(X30 ②) + **self-funding**(X19 ④) | **최고** | X19 ② 한계비용≈0 · ① 5y −44억 (1y +29.5M 정직) · X30 ④ business case |
| **② 보험 (NHIS)** | (간접) 절감 공유로 유지비 보조 | **shared saving** — X19 ① 5y −44억 절감의 일부 환원 + P4P 가산 | **NHIS budget impact**(5y 절감) | 중 | X19 ① 5y −44억(80k, M8 §7) · X30 ② P4P/적정성평가 |
| **③ 학회 (KSC/KAMIR)** | 결정맵 표준 · CDS 콘텐츠 · 교육 · outcome 인프라 | 학회 회비·연수강좌·레지스트리 운영(재정 아닌 거버넌스) | **정당성·책임 기준선**(X30 ⑤) | 중약 | X30 ⑤ champion · X23 KAMIR consortium · §3 VBC metric 공급 |

> **정착 후 유지비 핵심(d2)**: 파일럿 grant(X23)는 "빌드" 비용이고, 진짜 문제는 종료 후 "유지" 비용 공백(sustainability cliff)이다. **가장 현실적 주체 = ① 병원** — C5946 선별급여 검사수익이 lab 운영비를 일부 자체 충당하고, CDS·약사 클리닉 유지 동기가 "적정성평가 등급↑"(환자유입·수가 가산, X30 ②)과 "5y self-funding"(X19)으로 구조적으로 정렬되기 때문이다(단 ① CYP2C19 는 1y +29.5M 순지출 → 5y −44억 절감으로 부호 반전 — 1y 적자를 병원에 정직 제시, X19 §4·X30 ④). ② 보험은 5y 절감 공유로 보조하나 horizon·효과 가정 의존으로 제도 lead-time 이 길고, ③ 학회는 재정 주체가 아니라 표준·outcome 인프라의 거버넌스 주체다.

---

## §3. (c) value-based contract 구조 (outcome → 환급/공유 · X19 budget-neutral 위에)

> ⚠ VBC 구조·환급률·공유 금액 = **전부 ⚪ proposal** (실제 HIRA·보험자 협상 의존). outcome metric·net 은 X19/X16/M8 VERBATIM. d6 — 환급 부호·금액은 X19 net(효과 가정·사건 단가·horizon 의존)에 종속, 강제 금지.

### 3.1 VBC 두 갈래 — shared-saving (self-funding 중재) vs RSA (순지출 신약)

```
 value-based contract 구조 (X19 budget-neutral 위에 · 2 갈래)
═══════════════════════════════════════════════════════════════════════════════════

 [갈래 A] shared-saving VBC — self-funding 중재(① CYP2C19 결정맵 · ② 3-axis)
 ─────────────────────────────────────────────────────────────────────────────────
   outcome 개선(ST↓ · 사건↓)  ──→  X19 회피 사건비(ST 15M·death 10M)  ──→  NHIS 절감
        │                              (M8 §2 단가 VERBATIM)                   │
        ▼                                                                       ▼
   ① CYP2C19 5y −44억 절감(80k, M8 §7)                          절감의 일부를 병원에 환원
        │                                                       (lab·CDS 유지비 보조, §2 ②)
        └──→ "절감을 공유" — NHIS 신규예산 0, 절감분 재배분만
             ★ 단 1y +29.5M 순지출 → 5y 절감 부호 반전(X19 §4) → 공유는 5y 시점 정산

 ─────────────────────────────────────────────────────────────────────────────────
 [갈래 B] RSA(risk-sharing) — 순지출 신약(⑤ siRNA/PCSK9, X19 #5 self-funding ❌)
 ─────────────────────────────────────────────────────────────────────────────────
   siRNA 약가 격차 387-645×(X19 #5)  ──→  단일 급여 청구 불가
        │
        ▼  outcome-based 환불로 NHIS 예산 risk 분산
   outcome(MACE↓ · RRR) 미달  ──→  sponsor 가 환불(refund)
        │                          (X23 §5 · X9 L2 VERBATIM: ≥85% RRR 미달 시 ≥50% refund)
        ▼
   ≥85% RRR 미달 시 ≥50% refund  +  narrow staging(≥180mg/dL ~52만명) 으로 n·약물비 축소
        ★ MACE readout 🟠 DEFERRED(X19 #5) → 환급 trigger 는 글로벌 readout 의존(D trial, X23)
 ═══════════════════════════════════════════════════════════════════════════════════
 핵심: self-funding 중재(A)는 "절감 공유", 순지출 신약(B)은 "outcome 미달 시 환불".
       둘 다 NHIS 신규예산을 늘리지 않고(A=절감 재배분, B=risk 를 sponsor 에 전가)
       X19 budget-neutral 원칙 위에 선다.
 ═══════════════════════════════════════════════════════════════════════════════════
```

### 3.2 VBC outcome metric (환급/공유 trigger · X16/M8 VERBATIM)

| VBC 갈래 | 대상 중재 | 핵심 outcome metric | 환급/공유 trigger (⚪ proposal) | metric grade (VERBATIM) |
|---|---|---|---|---|
| **A. shared-saving** | ① CYP2C19 결정맵 · ② 3-axis | **ST(stent thrombosis)↓ + major bleeding 균형** — 회피 사건비(ST 15M·death 10M)가 절감 driver | ST 1y 1.1%→0.6%(M8 §4 S1→S4) 달성 시 5y 절감(−44억) 일부 병원 환원 | ST/death 사건율 = M8 §4 🟡 · 사건 단가 🟠 INSUFFICIENT(M8 §10) · 5y 외삽 🟠 |
| **B. RSA(refund)** | ⑤ siRNA/PCSK9 (LPA) | **MACE↓(RRR)** — 4-point MACE(CV death+MI+stroke+revasc) | **≥85% RRR 미달 시 ≥50% refund**(X23 §5·X9 L2 VERBATIM) | MACE readout 🟠 DEFERRED(X19 #5) · NHIS WTP 0% pass 🟢(약가 wall) |

> **★ VBC 핵심 outcome metric**: **shared-saving(A, self-funding 중재)의 핵심 metric = ST(stent thrombosis) 감소 + major bleeding 균형** — 회피 사건비(ST 15M·death 10M, M8 §2)가 X19 절감(① 5y −44억)의 직접 driver 이기 때문이다. **RSA(B, 순지출 신약)의 metric = MACE 감소(RRR)** 로, ≥85% RRR 미달 시 ≥50% refund(X23 §5 VERBATIM)가 환불 trigger 다. **정직(d6)**: A 의 ST↓→절감 공유는 사건 단가(🟠)·효과 가정·5y horizon(① 1y 순지출→5y 절감 반전)에 의존하고, B 의 MACE 환불 trigger 는 글로벌 readout(🟠 DEFERRED) 의존이라 — 두 환급/공유 모두 X19 의 정직 fence 를 상속하며, **환급 부호·금액을 강제하지 않는다**. 가장 견고한 단일 metric = **ST(stent thrombosis) 회피** (사건 단가 견고·결정맵의 1차 목표·X16 안전 결정맵과 정렬).

### 3.3 VBC 의 budget-neutral 정렬 (X19 위에 — 신규예산 0)

| VBC 메커니즘 | NHIS 예산 영향 | X19 연계 (VERBATIM) | 신규예산 |
|---|---|---|---|
| **shared-saving (A)** | 절감분 재배분 (신규지출 아님) | ① 5y −44억 절감을 병원·NHIS 가 공유 | **0** (절감 재배분만) |
| **RSA refund (B)** | sponsor 가 risk 흡수 | ⑤ 순지출(387-645×)을 outcome 미달 환불로 상쇄 | **risk 분산** (예산 변동성↓) |
| **P4P 가산 (X30 ②)** | 적정성평가 가산 = 유지비 보조 | X30 ② P4P · X19 ④ business case | 가산이나 등급=환자유입 상쇄 |

---

## §4. cross-cutting 통찰 — 청구·유지·VBC 의 한 줄 정렬

> 본 X33 의 3축은 분리된 게 아니라 **하나의 재정 파이프라인**이다.

```
 청구(§1) → 유지(§2) → VBC(§3) 의 정렬
─────────────────────────────────────────────────────────────────────────────────
 §1 청구  C5946 선별급여 + prasugrel 5mg 급여  ──→  검사수익 + 약가 정당 청구(삭감 방지)
            │                                          │
            ▼ (삭감 방지의 공통 축 = EMR 이 X16 안전 결정맵·적응증 기록)
 §2 유지  병원이 검사수익+평가등급으로 lab·CDS 유지  ──→  self-funding(X19) 으로 지속
            │                                          │
            ▼ (병원 유지 동기 = 평가등급 + 5y −44억 절감)
 §3 VBC   shared-saving(절감 공유) / RSA(환불)        ──→  X19 budget-neutral 위, 신규예산 0
            ST↓ metric → 절감 → 병원 환원 / 학회 outcome 인프라(KAMIR)가 metric 공급
─────────────────────────────────────────────────────────────────────────────────
 한 줄: 정당한 청구(삭감 0)가 검사수익을 만들고 → 검사수익+평가등급이 병원의 유지 동기를
        구조화하고 → VBC(절감 공유/환불)가 NHIS 신규예산 0 으로 그 절감을 재배분한다.
        세 축의 공통 토대 = X19 self-funding + EMR 이 X16 안전 결정맵을 기록(삭감 방어).
─────────────────────────────────────────────────────────────────────────────────
```

---

## §5. g5 grade — X33 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 청구 워크플로우 표 (코드·급여 유형·단가) | 🟡 SUPPORTED-BY-CITATION (코드·단가) + ⚪ (삭감 위험·방지책) | C5946·prasugrel 5mg·POCT 단가 = M8 §2/§10 VERBATIM 🟡 · 삭감 위험·방지책·운영 = ⚪ proposal |
| §2 지속 재정 모델 (3 주체) | ⚪ (재정 주체·금액 proposal) + 🟡 (X19 net carry) | 유지 주체·금액 = ⚪ · self-funding 근거(① 5y −44억 · ② 한계비용≈0) = X19 VERBATIM · X30 ② ④ lever carry |
| §3 VBC 구조 (shared-saving/RSA) | ⚪ (VBC 구조·환급률 proposal) + 🟡/🟠 (metric grade VERBATIM) | VBC 구조·환급률 = ⚪ · ST/MACE metric grade = M8/X19 VERBATIM · RSA ≥85% RRR/≥50% refund = X23 §5 VERBATIM |
| §4 cross-cutting 정렬 | 🟡 (compositional) | §1-§3 VERBATIM mapping |

**X33 종합 등급**: ⚪ SPECULATION-FENCED (삭감 위험·지속 재정 주체·VBC 구조는 운영 proposal) over 🟡 (수가 코드·급여 유형·단가·net·metric grade 는 M8/X19/X23/X30 VERBATIM carry) — **배포 재정 실무의 본질이 HIRA 심사·기관 협상·보험자 협상 의존**이므로 honest 하게 ⚪ fence. **X33 새 판정 0건** (per @D g5 · LLM self-judge 0건): 수가 코드(C5946)·급여 유형(선별급여)·약가(prasugrel 5mg 1,500원/일)·사건 단가(ST 15M 등)·net(① 5y −44억)·RSA(≥85% RRR/≥50% refund) 전부 M8/X19/X23 VERBATIM 인용. **d6 준수**: VBC 환급/공유는 X19 net 의 효과 가정(⚪)·사건 단가(🟠)·horizon(① 1y +29.5M→5y −44억 부호 반전) 의존을 상속하여 부호·금액 강제 0건. **d2 준수**: 삭감 위험 막힘(POCT 코드 부재)에 신규 수가 코드 건의 path(M8 §6 POC 30,000원 ICER dominant 근거) · 순지출 신약(siRNA)에 RSA+narrow staging path(X23 §5) 동반(폐기 0). **d1 — non-wet-lab 재정 워크플로우·거버넌스 매핑 완결**(실제 청구·협상은 downstream gate).

⚠ **honest fence (g5 + d6 + d2 + d1)**: 본 X33 의 수가 코드·급여 유형·단가는 M8 §2/§10 VERBATIM 이나, 삭감 위험·방지책·지속 재정 주체·VBC 구조는 ⚪ proposal(실제 HIRA 심사·기관/보험자 협상 의존)임을 §0 DISCLAIMER·§1-§3 칸에 명시했다. ① CYP2C19 의 1y +29.5M 순지출→5y −44억 절감 부호 반전, ⑤ siRNA 의 순지출 명백(self-funding ❌), MACE readout 🟠 DEFERRED, 사건 단가 🟠 INSUFFICIENT 를 숨기지 않고 VBC·유지 모델에 그대로 반영했다(X19 정직 fence 상속). d2 — POCT 코드 부재·siRNA 순지출을 막힘으로 닫지 않고 신규 코드 건의·RSA+narrow staging path 를 명명했다.

---

## §6. X33 산출 요약

- **(a) 청구 워크플로우 (§1)**: **CYP2C19 PCR = C5946 선별급여** ~50,000원/명(M8 §2 VERBATIM, 삭감 위험 중 — 적응증·중복·결과반영) · **prasugrel 5mg = 급여 일 1,500원**(삭감 위험 중-고, **최대** — ≥75세·<60kg 금기/안전 dual jeopardy) · **Lp(a)** = 연계 siRNA 비급여(순지출, VBC 로만) · **POCT = 코드 부재 비급여**(급여 청구 불가, 신규 코드 건의 path). 방지책 공통 축 = **EMR 이 X16 안전 결정맵·적응증·허가사항을 처방 시점에 기록**(삭감 방어 근거).
- **(b) 지속 재정 (§2)**: 파일럿 grant(X23) 후 유지비 공백(sustainability cliff) — **3 주체**: ① 병원(검사수익+평가등급+self-funding, **최고 현실성**) · ② 보험(절감 공유 shared-saving, 5y −44억 일부 환원) · ③ 학회(표준·outcome 인프라 거버넌스, 재정 아님). 현실성 ① 병원 > ② 보험 > ③ 학회.
- **(c) VBC (§3)**: **2 갈래** — A shared-saving(self-funding 중재 ①②, ST↓→절감 공유, X19 ① 5y −44억 위) · B RSA(순지출 신약 ⑤ siRNA, **≥85% RRR 미달 시 ≥50% refund**, X23 §5 VERBATIM). 둘 다 NHIS 신규예산 0(A=절감 재배분, B=risk sponsor 전가) — X19 budget-neutral 위.
- **g5/d6/d2/d1 준수**: 코드·단가·net·metric grade = M8/X19/X23/X30 VERBATIM(새 판정 0건) · VBC 환급 부호·금액 강제 0건(X19 net 효과 가정·사건 단가·horizon 의존 상속) · POCT 코드 부재·siRNA 순지출에 돌파 path 동반 · 재정 워크플로우 완결.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 X33 은 배포 재정·청구·거버넌스 실무 전략 자료이며 청구 코드 적용·삭감 결과·수가 협상 결과·급여결정을 보장하지 않는다. 수가 코드(C5946 등)·급여 유형·약가·사건 단가는 M8 §2/§10 NHIS 2025 고시 VERBATIM 이나, 삭감 위험·방지책·청구 운영·지속 재정 주체·VBC 구조는 전부 ⚪ proposal(실제 HIRA 심사 기준·기관/보험자 협상 의존)이다. VBC 환급/공유는 X19 net 의 효과 가정(⚪ proposal)·사건 단가(🟠 INSUFFICIENT)·horizon(① 1y +29.5M 순지출→5y −44억 절감 부호 반전)에 종속하므로 부호·금액을 강제하지 않는다(d6). 임상 효능·안전·결정맵은 X5/X16/X11 에 별도 fence 돼 있다. 모든 수가 코드·단가·grade·net 은 M8/X19/X23/X30 의 VERBATIM 인용이다(X33 새 판정 0건, LLM self-judge 0건).
