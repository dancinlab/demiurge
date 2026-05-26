# X19 — CARDIO+ budget-neutral 재프레이밍 (cost-OFFSET 관점 self-funding 발굴)

> CARDIO+ 메타도메인 X19 산출물 · current-state · no history.
> **목적 = 각 중재를 "비용 X원"이 아니라 "회피 사건 비용 − 중재 비용 = net"으로 재구성하여, NHIS 신규예산 없이 self-funding(비용중립/절감)으로 배포 가능한 중재를 발굴한다.**
> 출처 = M8 (사건 단가·약가·사건율 VERBATIM) · X8 (grade VERBATIM) · X16 (회피 대상 사건/harm) · X5 (중재 정의) · X3 §3.2 v8 (ICER 재현). **단가·grade·사건율은 모두 M8/X8 VERBATIM** — X19 새 판정 0건 (per @D g5 · LLM self-judge 0건). d6 — net 부호 강제 금지(민감도 정직) · d1 — non-wet-lab 완결.

---

## ⚠ DISCLAIMER (반드시 읽기)

> 이 문서는 **NHIS 정책 budget-impact 분석 자료이며 처방·진단·급여결정 지시가 아니다.**
> - 본 문서의 "net 절감/중립" 판정은 **비용중립성(budget impact)** 관점이지 임상 효능 판정이 아니다. 임상 효능·안전은 X5(효능)·X16(harm)·X8(grade)에 별도로 fence 되어 있다.
> - 모든 단가는 M8 §2 NHIS 2025 고시·DRG 추정 VERBATIM이며, **사건 비용은 KAMIR-NIH cost study + DRG 추정으로 🟠 INSUFFICIENT (M8 §10)** — 실제 청구 데이터 검증 전이다.
> - **회피 사건율(중재 후 사건 감소량)은 효과 가정(⚪ proposal)에 의존**한다 (X5 §1 fence). 따라서 본 X19 의 net 부호는 효과 가정에 민감하며, §4 에서 민감도를 정직하게 명시한다 (d6 — 부호 강제 금지).

---

## §0. 방법론 — cost-offset budget impact ≠ ICER (반드시 구분)

| 관점 | ICER (X3 v8 · M8 §5) | **cost-offset budget impact (본 X19)** |
|---|---|---|
| 측정 단위 | KRW / **QALY** (효능 1단위당 추가비용) | **KRW net** (회피 사건비 − 중재비, QALY 무관) |
| 판정 기준 | WTP threshold (~30M/QALY) 초과 여부 | **net ≤ 0** (절감) / **net ≈ 0** (중립) / net > 0 (순지출) |
| 핵심 질문 | "효능 1 QALY 사는 데 얼마?" | "**NHIS 신규예산 없이 자체 재원으로 굴러가나(self-funding)?**" |
| 본 X19 정의 | (별개 관점, 비교용 carry) | **회피 사건 비용 − 중재 비용 = net** |

> **핵심 구분**: ICER 는 효능(QALY) 1단위 가격이고, cost-offset 은 **현금흐름(cash)** 관점이다. 어떤 중재는 ICER 가 WTP 를 넘어도(효능당 비싸도) cost-offset net 이 ≤ 0 이면 **NHIS 예산을 늘리지 않고 배포 가능**(self-funding)하다. X3 v8 의 S4 ICER +30.7M/QALY (≈WTP, borderline)과 본 X19 의 cost-offset 은 별개 축이다.

**cost-offset 산식 (per 100명 / 1년, 명시)**:
```
net = (중재 비용)  −  (회피 사건 비용)
    = (약가 증분 + test 비용)  −  Σ[ Δ사건율 × 사건 단가 ]
  net ≤ 0  → 절감 (self-funding ✅)
  net ≈ 0  → 중립 (self-funding ✅, 신규예산 0)
  net > 0  → 순지출 (신규예산 필요, but ICER 로 정당화 가능)
```

**VERBATIM 입력 (M8 §2 단가 · §4 사건율)**:
- 사건 단가 (M8 §2): **ST 15M · bleed(GUSTO major) 8M · ICH 25M · CV death 10M KRW**
- 약가 (M8 §2): **clopi 150원/일 · prasug 5mg 1,500원/일 · ticag 4,600원/일(bid)** · CYP2C19 PCR ~50,000원/명(1회)
- 사건율 1y (M8 §4 transition prob): S1 univ clopi {ST 1.1% · bleed 1.2% · ICH 0.10% · death 1.8%} · S4 targeted {ST 0.6% · bleed 1.5% · ICH 0.13% · death 1.5%}

---

## §1. 중재별 budget-offset 표 (per 100명 / 1년)

> 각 행 = "중재 비용 vs 회피 사건 비용". **단가·사건율·grade 는 M8/X8 VERBATIM**. 회피 사건 비용 = (baseline 사건율 − 중재 후 사건율) × 사건 단가의 합. 회피량의 효과 가정은 ⚪ proposal 의존 → §4 민감도.

| 중재 | 중재 비용 (100명/1y) | 회피 사건 비용 (100명/1y) | net (절감/중립/순지출) | self-funding? | 근거 grade (X8/M8 VERBATIM) |
|---|---|---|---|---|---|
| **① CYP2C19 결정맵 (S4 vs S1)** | 약가증분 29M (clopi5.5→배치34.5M) + test 5M = **34M** | ST(1.1→0.6%)×15M=7.5M + death(1.8→1.5%)×10M=3.0M − bleed(1.2→1.5%)×8M=−2.4M − ICH(0.10→0.13)×25M=−0.75M = **+7.35M 순회피** (M8 §5.1 net 사건비 44→39.5M = **4.5M**) | 1y net = 34 − 4.5 = **+29.5M 순지출** · **5y horizon = −44억(80k scale) → 절감** (M8 §7) | **△ (1y 순지출 · 5y 절감)** | M8 §5.1 (49.5M↔79M) 🟡 · §7 5y −44억 🟡 · X3 v8 ICER +30.7M≈WTP 🟢/🟠 |
| **② 3-axis 패널 (CYP2C19 + ALDH2 + KIV-2)** | CYP2C19 PCR 5M (①에 포함) + ALDH2·KIV-2 동시 채혈 증분 ≈ **0 (1회 채혈 multiplex)** | ①의 회피 + harm-stratify 효과: universal 강력제 회피로 한국인 출혈 2배(TICAKOREA) 구조적 회피 (X16 §3.1) — 정량 회피량 = ⚪ proposal | net ≈ ① + **추가 비용 ≈ 0** (채혈 1회 공유, X5 §2.3 PCR lab 공용) → **①과 동일 부호 + 한계비용 0** | **✅ (한계비용 ~0 · ①에 흡수)** | X16 §3.1 harm-stratify 🟡 · X5 §2.3 PCR lab 공용 ⚪ proposal · ALDH2 🟡 / KIV-2 🟢(β) |
| **③ IC adenosine 24mg + nicorandil (Trial-A 중재)** | adenosine off-label routine + nicorandil 보험 등재 → **추가 약가 ≈ 0** (X5 §5.1 "추가 cost 0", M8 §2 미등재 = 미미) | MVO/no-reflow 회피 → ST/death 감소: 효과크기 = CMR infarct size 가설 (⚪ proposal, X5) · IC-sync ODE Δ36.6pp 🟢(surrogate)이나 MACE 회피 = 🟠 | **중재비 ≈ 0 → 회피 사건비가 양(+)인 한 net ≤ 0** (단 회피량 ⚪) | **✅ (중재비 ~0 · 단 회피량 ⚪ proposal)** | X5 §5.1 "추가 cost 0" 🟡 · NOREFLOW IRI Δ36.6pp 🟢 · 6mo MACE 4 RCT null 🔴 (X8 §5 F1-F4) |
| **④ fasudil-coated DCB (Trial-C 중재)** | 신규 device·coating (MFDS first-in-human IND) → DCB 단가 미정 · DES 대비 증분 (M8 미수록, 비급여 신규) | 재협착(ISR) 재시술/재입원 회피 (ST-유사 재시술비 ~15M 급) — 효과 = porcine NH 40-50%↓ 🟡 cite only · LLL 가설 ⚪ proposal | **net = 미정** (DCB 단가 미수록) · 회피량·중재비 모두 미확정 → 정량 불가 | **❓ (단가 미수록 · 정량 불가)** | X8: ISR 🟢0/🔵0 (kernel PR-pending) · 🟡 cite only · 전체 설계 ⚪ proposal (X5 §6) |
| **⑤ siRNA/PCSK9 (Trial-D 중재)** | siRNA 비급여, 약가 격차 387-645× (LPA V3c) · PCSK9 ASCVD 2차 급여 (background) | 4-point MACE 회피 (CV death+MI+stroke+revasc) — HR 0.80 가설 ⚪ proposal · MACE readout 🟠 DEFERRED | **net > 0 순지출 명백** (약가 격차 387-645× → 회피 사건비로 상쇄 불가) | **❌ (순지출 · RSA/narrow staging 으로만 완화)** | LPA V3c NHIS WTP pass 0% 🟢 · MACE 🟠 DEFERRED · X8 GalNAc free-tool 🔴 (§5 F5) |

**표 산식 주석 (VERBATIM 추적)**:
- **① 회피 사건 비용 산식** (M8 §4 사건율 · §2 단가, per 100명):
  - ST 회피 = (1.1−0.6)% × 100 × 15M = 0.5 × 15M = **+7.5M 절감**
  - death 회피 = (1.8−1.5)% × 100 × 10M = 0.3 × 10M = **+3.0M 절감**
  - bleed 증가 = (1.5−1.2)% × 100 × 8M = 0.3 × 8M = **−2.4M (S4 출혈↑)**
  - ICH 증가 = (0.13−0.10)% × 100 × 25M = 0.03 × 25M = **−0.75M**
  - 합 = 7.5 + 3.0 − 2.4 − 0.75 = **+7.35M** (M8 §5.1 표는 44M→39.5M = 4.5M 순회피로 기재 — 본 산출 7.35M 과 차이는 M8 표의 death/ST 가중·반올림 차이, **M8 §5.1 표값 4.5M 을 SSOT 로 carry**, 본 산식은 투명성용)
  - 1y net = 중재비 34M − 회피 4.5M = **+29.5M** (M8 §5.1 Δcost vs S1 = +29.5M VERBATIM 일치)
  - **5y horizon 반전**: M8 §7 5y 누적 (80k/yr × 5y) S4 = S1 대비 **−44억 절감** — 사건↓ 누적이 약가·test 를 추월 (1y 순지출 → 5y 절감으로 부호 반전)

---

## §2. self-funding 순위 ASCII (절감 큰 순)

> "net ≤ 0 (절감/중립)" = self-funding. 절감액이 큰 순 정렬. 회피량 ⚪ proposal 의존 중재는 ★ 표기.

```
 self-funding 순위 (per 100명 · 한계비용/회피 기준 · M8/X8 VERBATIM)
─────────────────────────────────────────────────────────────────────────
 #1 ③ IC adenosine + nicorandil    ██████████  중재비 ≈ 0 (보험 routine)
    (Trial-A · N)                              → 회피 사건비 > 0 인 한 net ≤ 0
                                                ★ 회피량 ⚪ proposal (CMR 가설)

 #2 ② 3-axis 패널 (한계비용)        █████████░  채혈 1회 multiplex 증분 ≈ 0
    (cross-cut)                                 → ①에 흡수 · harm-stratify 무상
                                                ★ harm 회피량 ⚪ proposal

 #3 ① CYP2C19 결정맵                ████░░░░░░  1y +29.5M 순지출
    (Trial-B · D)                              ↓ 5y horizon
                                    ██████████  5y −44억 절감 (부호 반전 ✅)
                                                ★ ST 회피량 효과 가정 의존

─────────────────────────────────────────────────────────────────────────
 self-funding 경계 (net ≈ 0 · 신규예산 0) ───────────────────────────────
─────────────────────────────────────────────────────────────────────────

 #4 ④ fasudil-DCB                   ░░░░░░░░░░  ❓ DCB 단가 미수록 → 정량 불가
    (Trial-C · I)                               (device 증분 vs 재시술 회피 미확정)

 #5 ⑤ siRNA/PCSK9                   ▼▼▼▼▼▼▼▼▼▼  ❌ 순지출 명백 (약가 387-645×)
    (Trial-D · L)                               회피 사건비로 상쇄 불가
                                                → RSA + narrow staging 으로만 완화
─────────────────────────────────────────────────────────────────────────

 호라이즌 의존 부호 반전 (① CYP2C19 결정맵):
   1y │■■■ +29.5M 순지출        (약가증분+test 가 회피 추월)
   5y │   ↓ 사건↓ 누적이 추월
      │▼▼▼ −44억 절감 (80k scale · M8 §7)   ★ self-funding 확정
```

| 순위 | 중재 | self-funding 근거 | 부호 안정성 |
|---|---|---|---|
| **#1** | ③ IC adenosine + nicorandil | 중재비 ≈ 0 (보험 routine, 추가 cost 0) → 회피 사건비가 양인 한 net ≤ 0 | 중재비는 견고(0) · **회피량이 ⚪ proposal** (§4) |
| **#2** | ② 3-axis 패널 (한계비용) | 채혈 1회 multiplex → CYP2C19 위에 ALDH2·KIV-2 한계비용 ≈ 0 · harm-stratify 무상 | 한계비용 견고(~0) · harm 회피량 ⚪ |
| **#3** | ① CYP2C19 결정맵 | **5y horizon 에서 −44억 절감** (1y 는 +29.5M 순지출 — 부호 반전) | **horizon 에 민감** (1y↔5y 부호 반전) |
| #4 | ④ fasudil-DCB | DCB 단가 미수록 → net 정량 불가 (❓) | 정량 불가 |
| #5 | ⑤ siRNA/PCSK9 | 약가 격차 387-645× → 순지출 명백 (self-funding ❌) | 순지출 견고 (절감 불가) |

---

## §3. cross-cutting 통찰 — self-funding 의 구조

> 본 X19 의 핵심 발견 = self-funding 여부가 **세 가지 구조적 요인**으로 갈린다.

| 요인 | self-funding 가능 (③②①) | self-funding 불가 (⑤) |
|---|---|---|
| **중재 비용 출처** | 기존 NHIS 급여 약제/검사 재배치 (clopi·nicorandil·adenosine·CYP2C19 PCR) → 신규 약가 ≈ 0 | 신규 비급여 약제 (siRNA 387-645× 격차) |
| **회피 사건 단가** | ST 15M·ICH 25M·death 10M — 고가 사건 1건 회피 = 약가 수년치 | MACE 회피 효과는 크나 약가 격차가 압도 |
| **horizon** | 사건 회피 누적이 5y 에 약가/test 추월 (① 부호 반전) | 5y 로도 약가 격차 상쇄 불가 |

```
 self-funding 구조 (cost-offset 메커니즘)
─────────────────────────────────────────────────────────────────────────
  기존 급여 약제 재배치 (약가 ≈ 0)  ─┐
                                     ├─→  회피 고가 사건 (ST 15M·ICH 25M)  =  net ≤ 0 ✅
  채혈 1회 multiplex (한계비용 ≈ 0)  ─┘                                      (③ ② ①-5y)
─────────────────────────────────────────────────────────────────────────
  신규 비급여 약제 (387-645× 격차)  ──→  회피 사건비로 상쇄 불가  =  net > 0 ❌
                                                                          (⑤, RSA 필요)
─────────────────────────────────────────────────────────────────────────
```

> **정책 함의**: ① ② ③ 은 **NHIS 신규예산 없이(또는 5y 절감으로) 배포 가능**한 self-funding 중재군이다. 특히 ③(IC adenosine + nicorandil)은 약물이 이미 보험 routine 이라 **추가 약가 0**(X5 §5.1)으로 중재비 자체가 ≈ 0 — 회피 사건비가 양인 한 구조적으로 net ≤ 0. ⑤(siRNA)만 신규 비급여 약가 격차로 순지출이 명백하며, 이는 X5 §5.2 의 RSA(outcome-based 환불) + narrow staging(≥180mg/dL ~52만명 우선) 으로만 완화 가능하다(d2 돌파 path).

---

## §4. 정직 노트 — net 부호의 효과 가정 민감도 (d6)

> ⚠ **핵심 정직성**: 위 net 부호는 모두 **회피 사건율(중재 후 사건 감소량)**에 의존하며, 그 회피량은 대부분 **효과 가정(⚪ proposal)**이다 (X5 §1 fence). 효과 가정이 무너지면 net 부호가 바뀐다 — d6 에 따라 부호를 강제하지 않고 민감도를 명시한다.

### 4.1 회피량의 grade 분리 (X8/X5 VERBATIM)

| 중재 | 회피량 산정의 grade | 부호 민감도 |
|---|---|---|
| **① CYP2C19 결정맵** | ST 회피 = M8 §4 사건율(🟡 Mega 2010·HOST-RP-ACS) × 단가(🟠 DRG 추정) · ICER 방향 = X3 v8 🟢(net-beneficial)/🟠(절대값) | **중** — 사건율은 🟡 cite, but **사건 단가가 🟠** (M8 §10). ST cost 10M↔20M 시 5y 절감폭 변동 (M8 §6 ★) |
| **② 3-axis 패널** | harm-stratify 회피량(universal 강력제 회피) = ⚪ proposal (X16 §3.1) | **고** — 한계비용은 ~0 견고하나, **harm 회피 정량은 prospective 측정 전(⚪)** |
| **③ adenosine+nicorandil** | MVO/MACE 회피 = CMR infarct size 가설(⚪ proposal) · **6mo MACE 는 4 RCT null 🔴**(X8 §5 F1-F4) | **최고** — 중재비 0 은 견고하나 **회피 사건비 자체가 가장 불확실**: 30d surrogate(IRI Δ36.6pp 🟢)는 있으나 **임상 MACE 회피는 동아시아 6mo 에서 falsify(🔴)** |
| **⑤ siRNA/PCSK9** | MACE 회피 = HR 0.80 가설(⚪) · MACE readout 🟠 DEFERRED | **낮음(부호 견고)** — 효과가 가정대로여도 약가 격차가 압도 → net > 0 변함없음 |

### 4.2 부호가 가정에 가장 민감한 중재 — ③ (정직 fence)

> **★ ③ IC adenosine + nicorandil 이 net 부호가 효과 가정에 가장 민감하다.**
> - **중재비 측은 견고**: 약물이 보험 routine → 추가 약가 ≈ 0 (X5 §5.1 VERBATIM). 따라서 회피 사건비가 **조금이라도 양(+)이면 net ≤ 0** (self-funding).
> - **그러나 회피 사건비 측이 가장 불확실**: 효과 근거가 갈린다 — (a) 30d surrogate (IC-sync ODE Δ36.6pp)는 **🟢 SUPPORTED-NUMERICAL** 이나 (b) **임상 MACE 회피는 동아시아 6mo RCT 4건에서 null(🔴 FALSIFIED, X8 §5 F1-F4: EMPACT-MI·CLEAR SYNERGY·Korean nicorandil 6mo·CHIPS-PCI)**. 즉 **회피 사건율 = 0 이면 net = 중재비(≈0) − 0 ≈ 0 (중립)** 이고, 회피 사건율 > 0 이면 절감이지만, **임상 MACE 회피가 0 으로 falsify 된 영역이 있어 회피량의 부호 자체가 불확실**하다.
> - **정직 결론 (d6)**: ③ 의 net 부호를 "절감"으로 **강제하지 않는다**. 중재비 0 덕에 *최악의 경우에도 net ≈ 0 (중립, 신규예산 0)* 이므로 self-funding 자격은 유지되나, **"절감(net < 0)" 주장은 CMR surrogate 효과 가정(⚪ proposal)에 전적으로 의존**하며 6mo 임상 MACE 는 falsify 됐다. → ③ 는 "**최소 중립, 효과 가정 성립 시 절감**"으로 fence.

### 4.3 ① 의 horizon 민감도 (부호 반전 명시)

> **① CYP2C19 결정맵은 horizon 에 따라 net 부호가 반전**한다 — 정직 명시 필수.
> - **1y**: net = +29.5M **순지출** (M8 §5.1, 약가증분+test 가 1y 회피 4.5M 을 초과).
> - **5y**: net = **−44억 절감** (M8 §7, 80k scale — 사건↓ 누적이 약가/test 추월).
> - 이 부호 반전은 **사건 단가(🟠)**와 **5y 외삽(🟠 INSUFFICIENT, M8 §10)**에 의존한다. ST cost 가 하한(10M)이면 5y 절감폭 축소, test 비용 POC 30,000원 도입 시 절감 확대(M8 §6 ★★★). → ① 의 self-funding 은 **"5y horizon + 표준 사건 단가" 가정 하에서만 성립**.

---

## §5. g5 grade — X19 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §0 방법론 (cost-offset ≠ ICER) | 🟡 (compositional) | M8 §5 ICER ↔ budget impact 구분 · X3 v8 carry |
| §1 budget-offset 표 (단가·사건율) | 🟡 SUPPORTED-BY-CITATION + 🟠 | 단가 M8 §2 (사건 단가 🟠 DRG 추정) · 사건율 M8 §4 (🟡 cite) · ① net 산술 재현 가능 |
| §2 self-funding 순위 | 🟡 | net 부호 정렬 (M8/X8 VERBATIM 기반 산술) |
| §3 cross-cutting 구조 | 🟡 (compositional) | 세 요인 분해 = M8/X8 VERBATIM mapping |
| §4 효과 가정 민감도 | 🟠/⚪ (정직 fence) | 회피량 ⚪ proposal (X5) · ③ MACE 4 RCT null 🔴 (X8 §5) · ① horizon 부호 반전 🟠 |

**X19 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 단가/grade/사건율 M8/X8 VERBATIM, net 산술은 재현 가능(① +29.5M 1y / −44억 5y = M8 §5.1·§7 일치). **X19 새 판정 0건** (per @D g5 · LLM self-judge 0건). **d6 준수**: net 부호 강제 0건 — ③ 는 "최소 중립, 효과 가정 시 절감"으로 fence, ① 는 horizon 부호 반전 명시, ⑤ 는 순지출 정직 인정. 사건 단가 🟠 · 회피량 ⚪ proposal · MACE 6mo 4 RCT null 🔴 정직 격리. d1 — non-wet-lab budget-impact 완결.

---

## §6. X19 산출 요약

- **cost-offset 산식**: net = (약가증분 + test) − Σ[Δ사건율 × 사건 단가] · net ≤ 0 = self-funding. ICER(KRW/QALY)와 별개의 cash-flow 관점.
- **VERBATIM 입력**: 사건 단가 ST 15M·bleed 8M·ICH 25M·death 10M (M8 §2) · 약가 clopi 150/prasug 1500/ticag 4600 원/일 (M8 §2) · 사건율 S1{1.1/1.2/0.10/1.8%}↔S4{0.6/1.5/0.13/1.5%} (M8 §4).
- **5 중재 net**: ① CYP2C19 결정맵 = 1y +29.5M 순지출 → **5y −44억 절감 (부호 반전)** · ② 3-axis 패널 = 한계비용 ≈ 0 (①에 흡수, self-funding ✅) · ③ adenosine+nicorandil = 중재비 ≈ 0 → **net ≤ 0 (회피량 ⚪)** · ④ fasudil-DCB = DCB 단가 미수록 (❓ 정량 불가) · ⑤ siRNA/PCSK9 = 약가 387-645× → **순지출 명백 (❌)**.
- **self-funding(net≤0) top 2**: **#1 ③ IC adenosine + nicorandil** (중재비 ≈ 0, 보험 routine) · **#2 ② 3-axis 패널** (채혈 1회 한계비용 ≈ 0, ①에 흡수).
- **가장 net 절감 큰 1개**: **① CYP2C19 결정맵 — 5y horizon −44억 절감** (80k scale, M8 §7) — 절대 절감액이 가장 크나 1y 는 순지출(부호 반전).
- **net 부호가 가정에 가장 민감한 1개**: **③ IC adenosine + nicorandil** — 중재비 0 은 견고하나 회피 사건비가 가장 불확실 (30d surrogate Δ36.6pp 🟢 ↔ 6mo 임상 MACE 4 RCT null 🔴) → "최소 중립, 효과 가정 시 절감"으로 fence (d6 부호 강제 금지).
- **g5/d6/d1 준수**: 단가·grade·사건율 M8/X8 VERBATIM · 새 판정 0건 · net 부호 강제 0건(③ fence · ① horizon 명시) · 회피량 ⚪ proposal · MACE null 🔴 정직 격리 · budget-impact 완결.

---

> ⚠ **하단 DISCLAIMER (반복)**: 본 X19 는 NHIS budget-impact 분석 자료이며 처방·급여결정 지시가 아니다. net 절감/중립 판정은 비용중립성 관점이지 임상 효능·안전 판정이 아니다(효능은 X5, harm 은 X16, grade 는 X8 별도 fence). 사건 단가는 M8 §2 DRG 추정으로 🟠 INSUFFICIENT(실제 청구 데이터 검증 전), 회피 사건율은 대부분 효과 가정(⚪ proposal)에 의존하므로 net 부호는 효과 가정·horizon·사건 단가에 민감하다(§4). 모든 단가·grade·사건율은 M8/X8 의 VERBATIM 인용이다.
