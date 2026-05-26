# X6 — 환자 본인 사례 retroactive 적용 (PCI 후속 4-axis 의사결정 지원 자료)

> ⚠️ **상단 DISCLAIMER (반드시 읽기)**
> 이 문서는 **의학적 조언·진단·처방이 아니다.** PCI(관상동맥 중재시술)를 받은 환자 본인이 자신의 후속 관리를
> **주치의·심장내과 전문의와 상의할 때 쓰는 근거-정리 / 의사결정 지원 자료**다.
> - 모든 항목은 "주치의와 **논의할 옵션**" 으로 적었다. "이렇게 하라" 는 지시가 아니다.
> - 어떤 검사를 받을지, 어떤 약을 쓸지, 용량을 어떻게 할지는 **전적으로 담당 의료진의 판단**이며,
>   본 자료의 어떤 수치도 처방·용량 지시로 해석해서는 안 된다.
> - 효과 추정·미래 전망은 ⚪ proposal / 연구단계로 라벨했다. 검증된 효과가 아니다.
> - 근거 등급(g5)은 CARDIO+ 4 sub-domain verify verdict 의 **VERBATIM 인용**이다 (이 문서가 새로 판정한 것이 아님).

---

## §0. 이 자료의 출처 + g5 등급 규약

본 X6 는 4개 sub-domain (NOREFLOW · DAPTPGX · ISR · LPA) + cross-cutting (X1 · X4 · X5 · X9) 의 결론을
**환자 본인 PCI 후속 1인칭 사례**에 retroactive(소급) 적용한 것이다. 새 시뮬레이션·검증 실행은 없다 (read-only 인용 + 개인 적용 매핑).

### g5 등급 (rubric VERBATIM — `hexa verify rubric`)

| 등급 | 의미 (이 문서 내 용법) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 산식 · atlas-registered recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 시뮬레이션 / 수치 재계산 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | peer-review 1차 출처 cite (literature carry) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · 임상 readout · IPD 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | 명시적 reject (large RCT null 등) |
| ⚪ SPECULATION-FENCED | 본질적 closed-form 미가능 (subjective · 미래 trial · prognostic · metaphor) — ⚪ ≠ 거짓, "아직 미검증" |

> g5 준수: 아래 모든 등급은 X1 §2 / X4 / sub-V verify verdict 의 verbatim 복사다. LLM self-judge 0건.
> "지금 한국에서 가능한 것" 칸의 검사·약제·급여는 사실(보험·허가) 진술이고, "효과 추정" 은 전부 연구단계/proposal 로 분리했다.

---

## §1. 4-axis 개인 적용 표 (핵심)

> 한 명의 한국인 PCI 환자(=본인) 에게 4개 위험축이 동시에 작동할 수 있다. 각 축마다
> (a) 근거 등급(verbatim), (b) **지금 한국에서 실제로 가능한 것**(검사/약제/급여), (c) 아직 옵션이 아닌 연구단계,
> (d) 주치의와 논의할 포인트 — 4 칸으로 정리한다.

| axis | 근거 등급 (g5 verbatim) | 지금 한국에서 가능한 것 (검사/약제/급여) | 연구단계 (아직 옵션 아님) | 주치의와 논의할 포인트 |
|---|---|---|---|---|
| **① mPTP / IRI** (NOREFLOW — 재관류 손상·미세혈관 보호) | mPTP IV bolus 가설 = 🔴 FALSIFIED (CIRCUS·CYCLE·EMBRACE·MITOCARE 4 large RCT neutral, n>2,000) [X9 N1]. nicorandil 동아시아 6mo = 🔴 (한국 RCT 2023 Heart · CHIPS-PCI null) [X1 CX10]. NAD+/NMN preconditioning 효과 = ⚪ proposal (Trial-B 미실시) [X4 NRF-F4]. | **시술 당시**(이미 지난 시점): adenosine IC 24 mg distal + nicorandil PO/IV 는 한국 보험 routine — 본인 시술 기록에서 사용 여부 확인 가능 [X5 §5.1]. **지금 2차 예방**: 표준 2차 예방(스타틴·DAPT·혈압·금연·운동·당뇨관리)이 IRI 후속 관리의 근거 중심. NMN/NR 은 한국 건강기능식품으로 구입 가능하나(식품 등급) **심근 보호 효과는 미확립** [NOREFLOW M2 §6]. | mPTP 직접약물(NIM811·debio-025·TRO40303) = 한국 미수입/미허가 [X9 N4]. 차세대 IC-synced delivery·elamipretide(국내 미승인) = 연구단계 [NOREFLOW M2]. NMN-PRECON IRB-light pilot = 설계 단계(⚪). | (1) 내 시술 기록상 no-reflow/MVO·IMR 측정·adenosine/nicorandil 사용 여부가 어땠는지 / (2) NMN 같은 보충제를 "심장 보호 목적"으로 복용하는 것이 근거가 있는지(현재 미확립) + 항혈소판제·다른 약과 상호작용은 없는지 / (3) 본인이 ALDH2*2(동아시아 ~40%) 보유 시 NO 대사 차이가 후속에 의미가 있는지 |
| **② CYP2C19** (DAPTPGX — 항혈소판제 유전형 맞춤) | 한국인 PM phenotype freq = **0.1521** (cited 0.14-0.15) 🟢 SUPPORTED-NUMERICAL [X5 §6 · DAPTPGX V3 §61]. IM+PM 합 = **0.6279** (cited 0.60) 🟢 [동]. TICAKOREA ticagrelor major bleeding ↑ vs clopidogrel = 🟡 SUPPORTED-BY-CITATION [X1 CX03]. 결정맵 적용 시 ST event ↓ X% = 🟠 (model assumption) / ⚪-성격 [X4 DPX-C21]. | **CYP2C19 PCR 검사**: C5946 **선별급여** (PCI 환자 대상, 약 ₩50,000, 1회) — 지금 주문 가능 [DAPTPGX M8 §C5946]. 결과 약제는 모두 **기존 급여 약제**라 신규 승인 불요: clopidogrel · prasugrel 5 mg(한국 dose) · ticagrelor [X5 §5.1]. PFT(VerifyNow PRU 등)는 일부 indication 시. | vicagrel(CES1 1-step, CYP2C19-무관) = 한국 미도입(KFDA 진입 ~2028 예상) [DAPTPGX M7 §6]. selatogrel 피하 자가주사 = 연구단계 [동]. 결정맵 outcome 정량(DAPT-PGx-K cohort) = 미측정. | (1) 내가 CYP2C19 검사를 받은 적 있는지 / 안 받았다면 선별급여로 검사할 가치가 있는지 / (2) 결과가 IM·PM 으로 나오면 현재 복용 중인 clopidogrel 이 나에게 충분히 듣는지(아래 §4 결정맵) / (3) 만약 약제 변경을 고려한다면 출혈 위험(TICAKOREA — 한국인 ticagrelor 출혈↑)과의 균형을 어떻게 볼지 |
| **③ ISR risk** (ISR — 스텐트 재협착) | ISR 임상 정의(재협착 >50% + 허혈증상 / FFR≤0.80) = 🟡 SUPPORTED-BY-CITATION [ISR M1]. 한국인 cohort = small vessel(<2.75mm) 35-40% · OCT/IVUS 사용률 70%+ (세계 최고) · NA risk 高 = 🟡 [ISR M8 §rank]. 2nd-gen DES 잔여 5-10% ISR = 🟡 [X9 I1]. | **surveillance(추적)**: PCI 후 정기 외래(NHIS 급여, 약 4회/년) + 증상 기반 평가 [DAPTPGX M8]. 재발 흉통·운동 시 흉부압박감 등 허혈 증상 시 즉시 진료. **재시술 시** OCT/IVUS-guided(한국 가용·세계 최고 사용률) — 재협착 원인(neointima vs neoatherosclerosis vs strut 문제) 구분 가능 [ISR M8]. 기존 표준: 스타틴·당뇨·혈압 조절로 ISR 위험 인자 관리. | 비-mTOR 신규 코팅(fasudil-DCB ROCK 등) = MFDS first-in-human 단계(연구) [X9 I3]. dual-DCB · 차세대 Mg-BRS = 연구단계 [ISR M6]. fasudil-DCB IIT-1(n=60) = 설계 단계(⚪) [X5 trial C]. | (1) 내 시술의 재협착 위험 인자(혈관 크기·병변 길이·당뇨 유무·스텐트 종류·개수)가 어디에 해당하는지 / (2) 증상 기반 추적 외에 추가 영상(OCT)/검사가 내 경우 필요한지 / (3) 재발 흉통 같은 어떤 증상이 나타나면 바로 연락해야 하는지(개인 red-flag 목록) |
| **④ Lp(a)** (LPA — 잔여 위험) | Lp(a)→CHD 인과 MR/IVW β = **-0.3413** (Burgess -0.34249, Δ=0.0012) 🟢 SUPPORTED-NUMERICAL [X5 §6 · LPA V3b]. 스타틴 Lp(a) 무효/오히려 +5-10% = 🟡 [X9 L1]. PCSK9 mAb Lp(a) -20~30% = 🟡 [LPA M2]. 한국인 ≥50 mg/dL ~12-13% = 🟡 SUPPORTED-BY-CITATION [LPA M2 §korea]. | **Lp(a) 검사**: 1회 측정으로 평생 위험 가늠(유전 결정성 ~90%) — 주치의 통해 주문 가능(임상화학 검사). **현 가용 약제**: PCSK9 mAb(evolocumab·alirocumab) — ASCVD 2차 예방 급여(단, 트리거는 LDL-C 기준: max 스타틴+ezetimibe 후 LDL ↓<50% 또는 LDL ≥70 mg/dL) [LPA R2 §5.1]. Lp(a) -25% 는 LDL 기준 급여의 부수효과 [LPA M2]. | siRNA/ASO(pelacarsen HORIZON · olpasiran OCEAN(a) · lepodisiran · zerlasiran) Lp(a) -80~98% = **현 비급여·미허가**, Ph3 진행중(HORIZON 2026 H1 readout) [LPA M3/M4]. muvalaplin 경구·VERVE-301 base editor = 연구단계 [LPA M13/M14]. | (1) 내 Lp(a) 수치를 측정한 적 있는지 / 없다면 1회 검사 가치(평생 1회로 충분) / (2) 측정 결과 ≥50(또는 ≥75) mg/dL 이면 LDL 목표를 더 공격적으로 가야 하는지(PCSK9 급여는 LDL 기준임을 이해) / (3) siRNA 같은 신약은 아직 한국 미허가 — 향후 HORIZON readout(2026) 후 옵션이 될 수 있음을 인지 |

> ⚠️ g5 fence: ②의 "PM 0.1521 / IM+PM 0.6279" 와 ④의 "β_IVW -0.3413" 만 sub-V 에 🟢 verdict 가 있어 verbatim 인용했다.
> 그 외 효과 추정(결정맵 ST↓ X% · PCSK9 MACE 감소 폭 · siRNA -80% 등)은 모두 literature carry(🟡) 또는 미래 readout 의존(🟠/⚪)이다.
> **이 표의 어떤 칸도 "본인이 이 약을 써야 한다"는 지시가 아니다 — 주치의와 논의할 옵션 목록이다.**

---

## §2. 개인 timeline — 즉시 / 6개월 / 3년 (ASCII)

> "지금 당장 할 수 있는 것 → 결과 기반 조정 → 미래 옵션" 의 순서. 모든 항목은 주치의 상의 전제.

```
 시점        나의 행동 (주치의와 논의 후)                         규제/급여 상태
═══════════════════════════════════════════════════════════════════════════════════════

 즉시        ┌─ ★ 3-axis 채혈 1회 패널 논의 (§3)                  ★ 최저 장벽
 (0m)        │   = CYP2C19 PCR (C5946 선별급여)                    · CYP2C19 = 선별급여
             │   + Lp(a) 1회 측정 (임상화학)                       · Lp(a) = 일반 검사
             │   + (선택) ALDH2*2 유전형                           · 신규 IND/약 승인 전혀 불요
             │   → "한 번 채혈"로 ②④(+①의 ethnicity) 동시 확보
             │
             ├─ 현재 항혈소판제(주로 clopidogrel) 복용 지속 확인     · 자의 중단 절대 금지
             │   (검사 결과 나오기 전 임의 변경 금지 — 주치의 결정)   · DAPT 중단은 ST 위험
             │
             └─ 표준 2차 예방 점검: 스타틴/LDL · 혈압 · 금연 ·       · 모두 기존 급여
                운동 · 당뇨관리 (③ ISR · ①IRI 공통 토대)

───────────────────────────────────────────────────────────────────────────────────────

 6개월       ┌─ 검사 결과 기반 ② DAPT 적정성 재평가 (§4 결정맵)      ★ 중 (약제 재배치)
 (3-6m~)     │   · NM → clopidogrel 적절 가능성                     · 약제는 전부 기존 급여
             │   · IM/PM → clopidogrel 효과 저하 가능 →             · 신규 승인 불요
             │     주치의가 prasugrel 5mg/ticagrelor·PFT 고려        · 변경은 주치의 판단
             │
             ├─ ④ Lp(a) 결과 기반 LDL 목표 재설정 논의               · PCSK9 급여 = LDL 기준
             │   · Lp(a) high → LDL 더 공격적 / PCSK9 후보 검토       · (Lp(a) 자체는 트리거 X)
             │
             └─ ③ ISR surveillance — 증상 점검 + 정기 외래 유지       · 외래 NHIS 급여 4회/년

───────────────────────────────────────────────────────────────────────────────────────

 3년         ┌─ ④ Lp(a) 신약(siRNA/ASO) 한국 허가·급여 추적          ★ 최고 (신약 승인 대기)
 (2-3y~)     │   · HORIZON 2026 H1 readout → 허가/급여 분기점          · 현재 미허가·비급여
             │   · 본인이 Lp(a) high 면 → 향후 trial 참여 또는        · RSA 협상 의존
             │     신약 가용 시 후보가 될 수 있음 (주치의/임상센터 통해)
             │
             ├─ ③ ISR 신규 옵션(fasudil-DCB 등) = 임상시험 단계         · MFDS FIH 단계
             │   재협착 발생 시 표준 치료(재시술/DCB) + trial 정보 문의
             │
             └─ ① NMN-PRECON 등 IRB-light pilot = 설계 단계 (참고만)    · 효과 미확립
```

> **honest 핵심**: 즉시 할 수 있는 것은 사실상 "**검사 1회 + 현 치료 점검**" 이다. 6개월은 "검사 결과로 조정",
> 3년은 "신약·임상시험 도착 대기" 다. 신약(siRNA·fasudil-DCB)은 아직 한국 옵션이 아니므로 d2 대안(§5)으로 다룬다.

---

## §3. 3-axis 채혈 1회 패널 — 본인에게 주는 의미 (X9 leverage 연결)

> X9 §5 의 핵심 발견 = "**단일 입원 채혈 1회 + 1 PCR/측정 panel 이 여러 wall 을 동시에 낮춘다**" 를
> **개인(본인) 차원**으로 옮긴 것. 한국인은 3개 위험축이 동시에 높을 확률이 비-동아시아보다 현저히 높다.

### 3.1 3-axis = 한 번 채혈로 동시 확보

```
                  ALDH2*2 (rs671)          CYP2C19 LoF (*2/*3)        Lp(a) high
                  동아시아 ~40% 보유        한국인 IM+PM ~60%          한국 ≥50 mg/dL ~12-13%
                  NO ↓ · IRI 修飾인자       clopidogrel 효과 저하       잔여 위험 평생 결정
                       │                         │                          │
                       ▼                         ▼                          ▼
   ┌───────────────────────────── 단 한 번의 채혈 ─────────────────────────────┐
   │   ① mPTP/IRI axis           ② CYP2C19 axis            ④ Lp(a) axis        │
   │   (ethnicity 참고)          (PM=0.1521 🟢)            (β_IVW -0.3413 🟢)   │
   │                                                                            │
   │   · CYP2C19 PCR = C5946 선별급여 (₩50,000, 1회)   ← 지금 주문 가능          │
   │   · Lp(a) = 임상화학 1회 측정 (유전 결정성 ~90% → 평생 1회로 충분)          │
   │   · ALDH2*2 = 유전형 검사 (선택 · 연구/임상 맥락)                           │
   └────────────────────────────────────────────────────────────────────────────┘
                                       │
                          ┌────────────┴────────────┐
                          │ 결과 → §4 DAPT 결정맵 +  │
                          │        §1 ④ LDL 목표 재설정 │
                          └─────────────────────────┘
```

### 3.2 왜 본인에게 leverage 인가

| 측정 1축 | 본인에게 주는 의미 | 근거 등급 (verbatim) |
|---|---|---|
| **CYP2C19** | 현재 복용 중인 clopidogrel 이 나에게 충분히 듣는지(IM/PM 이면 효과 저하 가능) — 스텐트 혈전증·MACE 예방의 직접 관련. 선별급여라 비용 부담 낮음. | PM 0.1521 / IM+PM 0.6279 🟢 [LPA→DAPTPGX V3 §61] |
| **Lp(a)** | 스타틴·PCSK9 후에도 남는 잔여 위험을 평생 1회 측정으로 가늠. 유전 결정성 ~90% 라 반복 측정 불필요. high 면 LDL 목표를 더 공격적으로 갈 근거. | β_IVW -0.3413 🟢 [LPA V3b] · 인과 정량 |
| **ALDH2*2** (선택) | 동아시아 ~40% 보유 — NO 대사·IRI 수정 인자. 직접 약제 결정과 연결은 아직 연구단계지만, 본인 ethnicity 위험 맥락 이해에 도움. | ALDH2*2 East Asian 40% 🟡 [NOREFLOW M9 §5] |

> **핵심**: 본인은 PCI 를 이미 받은 당사자이므로 "예방"보다 "**2차 예방 + 후속 최적화**" 단계다.
> CYP2C19 와 Lp(a) 두 가지는 **지금 한 번의 채혈로 확보 가능하고 비용·접근성 장벽이 낮은** 가장 실행 가능한 행동이다.
> (어떤 검사를 실제로 주문할지는 주치의 판단 — 본 자료는 "논의 가치가 있는 옵션"으로 제시한다.)

---

## §4. ② CYP2C19 결과 해석 — NM / IM / PM 결정맵 (논의용)

> 출처 = DAPTPGX M7 결정맵 (한국인 PCI 100명 분포: NM/RM ~33 · IM ~45 · PM ~15) VERBATIM.
> ⚠️ 아래는 **주치의가 환자별로 판단하는 결정 트리의 일반 구조**이며, 본인에게 어떤 약을 쓸지는
> 출혈 위험(ARC-HBR)·시술 복잡도·신기능·동반약 등을 종합한 **주치의 결정**이다. 자의로 약을 바꾸지 말 것.

```
  CYP2C19 PCR 결과
        │
        ├─ NM/RM (정상 대사, 한국 ~33%) ──► clopidogrel 대체로 적절 가능성
        │     · 환경변수(PPI·신기능·약물상호작용) 있으면 주치의가 PFT 고려
        │
        ├─ IM (중간 대사, 한국 ~45% · 가장 흔함) ──► clopidogrel 효과 부분 저하 가능
        │     · 주치의가 출혈위험 낮으면 prasugrel 5mg(한국 dose) 고려
        │     · de-escalation(강력제 → clopi) 은 PFT(PRU<208) 보조로 안전성 확인
        │
        └─ PM (저대사, 한국 ~15%) ──► clopidogrel 효과 크게 저하 가능 (ST 위험↑)
              · 주치의가 prasugrel 5mg 또는 ticagrelor 고려
              · ★ 단, ticagrelor 는 한국인 출혈위험↑ (TICAKOREA: major bleed clopi 대비↑)
                → 출혈위험 균형이 핵심 (dual jeopardy)
              · PFT(VerifyNow PRU)로 잔존 효과 확인 후 조정 옵션
```

| phenotype | 한국 빈도 | 일반적 고려 방향 (주치의 판단) | 근거 등급 |
|---|---|---|---|
| **NM/RM** | ~33% | clopidogrel 적절 가능 · 환경변수 시 PFT | 🟡 SUPPORTED-BY-CITATION [DAPTPGX M7] |
| **IM** | ~45% | clopidogrel 부분 저하 가능 · 위험 낮으면 prasugrel 5mg 고려 · de-escalation PFT 보조 | 🟡 [DAPTPGX M7] |
| **PM** | ~15% | clopidogrel 회피 고려 · prasugrel 5mg/ticagrelor (출혈균형) · PFT 확인 | 🟡 [DAPTPGX M7] + TICAKOREA 🟡 [X1 CX03] |

> 결정맵 적용 시 ST event 감소 X% 같은 정량 효과 = 🟠 (model assumption) / ⚪-성격 [X4 DPX-C21] — 아직 cohort outcome 미측정.
> **논의 포인트**: "내 결과가 IM/PM 이면, 현 clopidogrel 을 유지할지 / 바꿀지 / PFT 를 볼지" 를 출혈위험과 함께 주치의와 결정.

---

## §5. d2 — 한국 미가용 옵션의 대안 path (포기 금지)

> 거버넌스 d2: 한국 미가용 약물/옵션에 막혀도 "불가능"으로 닫지 않고 **가용 대안 path** 를 명시한다.
> (모두 주치의·임상센터와 논의할 옵션 — 본인이 임의 실행할 사항 아님.)

| axis | 한국 미가용 (wall) | 가용 대안 path (d2) | 근거 |
|---|---|---|---|
| **① IRI** | mPTP 직접약물 NIM811·debio-025·TRO40303 미수입·미허가; elamipretide 국내 미승인 | (A) **표준 2차 예방 극대화**(스타틴·DAPT·혈압·금연·운동·당뇨) = IRI 후속의 근거 토대 · (B) NMN/NR 은 한국 건강기능식품으로 구입 가능하나 심근보호 효과 **미확립** → "보조제로 복용 시 상호작용 없는지" 만 주치의 확인 · (C) ALDH2*2 보유 시 ethnicity-aware 관리 맥락 인지 | NOREFLOW M2 §6 · X9 N4 path |
| **② CYP2C19** | vicagrel(CYP2C19-무관 신약) 한국 미도입; selatogrel 연구단계 | (A) **기존 급여 약제 내 최적화** — NM=clopidogrel · IM/PM=prasugrel 5mg/ticagrelor(출혈균형) → 신약 없이도 결정맵으로 대응 가능 · (B) PFT(PRU) 로 잔존 효과 확인 후 조정 · (C) 향후 vicagrel KFDA 진입(~2028 예상) 추적 | DAPTPGX M7 §6 · X5 §5.1 |
| **③ ISR** | fasudil-DCB·dual-DCB·차세대 Mg-BRS = 임상/연구 단계 | (A) **OCT/IVUS-guided 표준 재시술**(한국 세계 최고 사용률) — 재발 시 원인별 최적 치료 · (B) 표준 paclitaxel/sirolimus DCB(기존 가용) · (C) 위험인자 관리(스타틴·당뇨·혈압)로 재협착 예방 + 증상 기반 surveillance | ISR M8 · X9 I3 path |
| **④ Lp(a)** | siRNA/ASO(pelacarsen·olpasiran 등) 미허가·비급여 (가장 큰 wall) | (A) **PCSK9 mAb**(ASCVD 2차 급여, LDL 기준) — Lp(a) -25% 부수효과 즉시 가용 · (B) **LDL 공격적 조절**(스타틴+ezetimibe → PCSK9) 로 전체 ASCVD 위험 낮추기 · (C) HORIZON 2026 H1 readout 후 신약 허가/급여 또는 **임상시험 참여** 경로 추적 | LPA M2 §정리 · M8 Tier-1 · X5 §5.2 |

> **가장 큰 wall = ④ Lp(a) 신약(siRNA)** — 효능은 크나(연구단계 -80~98%) 한국 미허가·비급여. 그러나 d2 path 로
> "PCSK9 + LDL 공격적 조절 + 향후 임상참여/허가 추적" 이라는 **현 가용 대안이 분명히 존재**한다 (포기 아님).

---

## §6. 책임 프레이밍 재확인 + g5 종합

### 6.1 이 자료가 하는 것 / 하지 않는 것

| 하는 것 (✅) | 하지 않는 것 (❌) |
|---|---|
| 4-axis 의 근거 등급을 verbatim 정리 | 진단·처방·용량 지시 |
| "지금 한국에서 가능한 것 vs 연구단계" 구분 | "이 약을 복용하라" 같은 지시 |
| 주치의와 논의할 질문 목록 제공 | 현 치료의 자의적 변경 권유 |
| 검사 1회 패널의 접근성·의미 정리 | 검증 안 된 효과를 확정처럼 제시 |

### 6.2 X6 자체 g5 grade

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 4-axis 개인 적용 표 | 🟡 SUPPORTED-BY-CITATION (compositional) | 4 sub-V verdict + X1/X4/X5 verbatim 인용 (LLM 새 판정 0건) |
| §2 개인 timeline | 🟡 | X1 §9 + X5 §4 timeline carry · 개인 적용 매핑 |
| §3 3-axis 채혈 패널 | 🟡 + 🟢(인용) | X9 §5 leverage + PM 0.1521 / β_IVW -0.3413 🟢 verbatim |
| §4 NM/IM/PM 결정맵 | 🟡 | DAPTPGX M7 결정 트리 verbatim |
| §5 d2 대안 path | 🟡 | sub-V d2 path verbatim · 미가용→대안 명시 |

**X6 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 4 sub-V + cross-cutting verdict 의 1인칭 retroactive 적용.
효과 추정·미래 옵션은 ⚪ proposal / 🟠 deferred 로 분리. 새 검증 실행 0건.

---

> ⚠️ **하단 DISCLAIMER (반복)**
> 이 문서는 **의학적 조언·진단·처방이 아니다.** 환자 본인이 주치의·심장내과 전문의와 후속 관리를 **상의할 때 쓰는 근거-정리 자료**다.
> - 모든 항목은 "주치의와 **논의할 옵션**"이며, 실제 검사·약제·용량 결정은 **전적으로 담당 의료진**의 판단이다.
> - 현재 복용 중인 약(특히 항혈소판제/DAPT)을 **임의로 중단·변경하지 말 것** — 스텐트 혈전증 위험.
> - 근거 등급(g5)은 sub-domain verify verdict 의 verbatim 인용이며, 효과 추정·미래 전망(⚪/🟠)은 검증된 사실이 아니다.
> - 궁금한 점은 본 자료를 **출력해 주치의에게 보여주고 함께 검토**하는 용도로 활용하길 권한다.
```
