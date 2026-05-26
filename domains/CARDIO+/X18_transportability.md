# X18 — 국제 transportability (3-axis 일반화)

> 목적: 한국 3-axis leverage (ALDH2\*2 ~40% × CYP2C19 LoF ~60% × Lp(a) high 12-13%) 가 일본·중국·동아시아 전반에 transport 되는지를, allele/biomarker 분포 비교 + effect 일반화로 판정하고, 어느 결론이 동아시아 일반화 vs 한국 특이인지 + 한·일·중 공동 trial 가능성을 드러낸다.

> 입력 = X9 (3-axis wall map §5) · X8 (grade ledger) · X1 (unified claims §3/§7) · DAPTPGX/M1 (CYP2C19 freq) · LPA/M2 (Lp(a) 분포 + KIV-2) · NOREFLOW/M9§5 + M8 (ALDH2\*2 East Asian) · X5 (trial portfolio 국제 cross-recognition).
> ⚠ 본 X18 = transportability 분석 only — 새 hexa verify / sim / atlas / pool / cloud / python 실행 0건. 4 sub-domain `.md` + X1/X5/X8/X9 read-only 인용. **LLM self-judge 새 🟢 부여 0건** (per @D g5) — allele freq/grade 는 sub-V/문헌 VERBATIM, sub-V 에 country-split 이 없는 수치는 🟡 citation 으로 명시.

---

## §0. 방법론 — transportability 란

역학·인과추론의 **transportability** = "한 모집단(source = 한국)에서 추정된 효과/결정규칙이 다른 모집단(target = 일본·중국)에서도 성립하는가" 를 판정하는 절차. 두 축으로 분해한다:

```
transport 성립 = (1) allele/biomarker 분포 transport  ×  (2) effect (인과 효과·결정 임계값) 일반화
                  ─────────────────────────────         ─────────────────────────────────────
                  "위험 인자의 빈도가 비슷한가"           "그 인자가 결과에 미치는 효과가 같은가"
```

- **(1) 분포 transport** = source vs target 의 allele freq / biomarker 분포가 통계적으로 호환되는가 (본 X18 §1 cross-population 표).
- **(2) effect 일반화** = 그 axis 의 임상 효과(예 LoF → HTPR, Lp(a) → MACE HR, ALDH2\*2 → IRI)가 모집단 불문 동일한 생물학에 기반하는가. 동일 변이·동일 단백 기능이면 effect 일반화 강함 / 약물 가용성·약가·식이 등 환경 modifier 가 다르면 결론(배포·정책)은 한국 특이로 갈림.
- **판정 규약**: 분포 transport ✅ + effect 일반화 ✅ → **동아시아 일반화**. 분포 ✅ 이나 결론이 한국 환경(보험·약가·trial 인프라)에 묶이면 → **한국 특이 (생물학은 일반, 적용은 특이)**. 분포 자체가 한국과 다르면 → **transport 약함/불성립**.

---

## §1. cross-population allele / biomarker 분포 표 (핵심)

> 각 셀 = sub-V `.md` 에 기록된 수치 VERBATIM. sub-V 가 country-split 을 주지 않는 경우(특히 ALDH2\*2 일본/중국 별도) 는 East Asian 통합치를 carry 하고 country-level 은 🟡 citation 로 별도 명시 (LLM 추정 금지 · d6 정직).

| axis | 한국 | 일본 | 중국(한족) | 백인(참조) | 출처 grade |
|---|---|---|---|---|---|
| **ALDH2\*2 (rs671) 보유율** | East Asian ~40% (한국 포함) | East Asian ~40% (일본 cohort JAHA 2021 직접 관찰) | East Asian ~40% (한족 변이 기원지) | **거의 0% (East Asian 특이)** | 🟡 NOREFLOW M9§5 (East Asian ~40% VERBATIM) · M8§5 |
| **CYP2C19 LoF allele 합 (\*2+\*3)** | **~40%** (\*2 ~29-31% + \*3 ~9-11%) | 동아시아 ~37% (\*2 ~30% + \*3 ~7%) ‡ | 동아시아 ~37% (\*2 ~30% + \*3 ~7%) ‡ | **~15%** (\*2 ~15% · \*3 <0.5%) | 🟡 DAPTPGX M1§3 (한국·동아시아·백인 열 VERBATIM) |
| CYP2C19 IM+PM (LoF carrier) | **~60%** | 동아시아 ~55-60% ‡ | 동아시아 ~55-60% ‡ | ~25-30% | 🟡 DAPTPGX M1§4 (한국 60% VERBATIM · 동아시아 = LoF 합 환산 추정) |
| **Lp(a) ≥50 mg/dL 분율** | **~12-13%** | 동아시아 ~10-15% | 동아시아 ~10-15% | **~20%** | 🟡 LPA M2§1 (인종별 표 VERBATIM: 동아시아 CN·JP ~10-15% · 백인 ~20%) |
| Lp(a) 중앙값 (mg/dL) | ~13 | 동아시아 ~10-15 | 동아시아 ~10-15 | ~10-14 | 🟡 LPA M2§1 (Wang 2020 JAHA — 중국·일본) |
| **LPA KIV-2 copy (평균/allele)** | ~24-26 (백인보다 약간 ↑) | 동아시아 ~높음(plasma 낮음 정합) | 동아시아 ~높음 | ~24 (글로벌 기준) | 🟡 LPA M2§4 (한국 KARE Lee 2017 VERBATIM · 일본/중국 직접 copy 분포 = 🟠 미공개) |
| LPA rs10455872 (high-Lp(a) tag) minor allele | 한국인 ~4% | 동아시아 낮음 (한국과 정합) | 동아시아 낮음 | 백인 ~7% | 🟡 LPA M2§4 (KRGDB 한국 ~4% vs 백인 ~7% VERBATIM) |

```
3-axis 분포 — 동아시아 3국 vs 백인 (sub-V VERBATIM 기반)
                 한국      일본       중국       백인
ALDH2*2 (rs671)  ~40% ███  ~40% ███  ~40% ███   ~0%  ·     ← East Asian 특이 (백인 부재)
CYP2C19 LoF 합   ~40% ███  ~37% ███  ~37% ███   ~15% █     ← 동아시아 ≫ 백인 (한국 *3 최고)
Lp(a) ≥50        ~13% ██   ~12% ██   ~12% ██    ~20% ███   ← 백인이 오히려 높음 (역전)
```

**‡ 동아시아 CYP2C19 country-split honest note**: DAPTPGX M1§3 분포표는 열을 **"한국인 · 동아시아 · 백인 · 흑인"** 으로 제공하며 일본/중국을 개별 분리하지 않는다. 표의 "동아시아" 열 (\*2 ~30% · \*3 ~7% · LoF 합 ~37%) 이 일본·중국 공통 대표치다 — 본 X18 은 이를 양국에 carry 하되 country-level 정밀치는 **sub-V 미수록 → 🟡 (동아시아 통합치 환산)** 으로 정직 표기. 한국이 동아시아 내에서도 \*3 (rs4986893) 빈도가 ~9-11% 로 동아시아 통합 ~7% 보다 높아 **LoF 합 ~40% 로 동아시아 최고** (M1§3 "한국인 LoF 합 ~40% = 글로벌 최고 수준" VERBATIM).

**ALDH2\*2 country-split honest note**: NOREFLOW M9§5 는 "40% 동아시아 보유" 를 VERBATIM 으로 주며 일본(JAHA 2021 n=308 cohort 직접 관찰)·중국·한국을 East Asian 단일 보유율로 묶는다. 문헌상 ALDH2\*2 는 한족 기원의 East Asian 특이 변이로 3국 모두 35-45% 대이나, sub-V 가 country-split 을 명시하지 않으므로 X18 은 **East Asian ~40% 통합치를 3국 공통**으로 carry (country-level 별도 정밀치는 sub-V 미수록 → 부여 안 함, d6 정직).

---

## §2. axis 별 effect 일반화 판정

분포가 호환되어도 effect(생물학적 인과·임계값)가 일반화되어야 결론이 transport 된다. axis 별로 분해한다.

| axis | 변이/기전 동일성 | effect 일반화 근거 | effect transport |
|---|---|---|---|
| **ALDH2\*2 (rs671)** | rs671 단일 SNP — Glu504Lys → ALDH2 효소 활성 소실 · NO bioavailability ↓. 3국 동일 변이·동일 단백 | NOREFLOW M9§5: STEMI IRI 악화(남성) · NO bioavailability ↓ = 동일 분자 기전. 일본 cohort(JAHA 2021)에서 직접 관찰 | ✅ **강함** (동일 SNP·동일 단백) |
| **CYP2C19 \*2/\*3 LoF** | 681G>A(\*2 splice defect) · 636G>A(\*3 stop) — 3국 동일 변이. clopidogrel 2-step 활성화 율속 | M1§1-2: LoF 1개로 active metabolite 30-50%↓ = 약물대사 분자 기전 (인종 불문). HTPR 50-60% (Jeong 2014, 한국) = 동아시아 공통 | ✅ **강함** (동일 변이·동일 prodrug 대사) |
| **Lp(a) ≥50 / KIV-2** | LPA 유전자 KIV-2 copy 역상관 — Lp(a) 90% 유전 결정. 변이 자체는 모집단 공통 (copy 분포만 차이) | LPA M2: Lp(a)↑→CHD risk = Erqou 2009 글로벌 meta (인종 불문 인과). 단 한국인 hard endpoint(MACE HR)는 🟠 글로벌 extrapolation (M2§8) | △ **인과는 일반 · 한국 endpoint 미확정** |

→ **effect 일반화 결론**: 3 axis 모두 **동일 변이·동일 분자 기전** 에 기반 → 효과 자체(IRI 악화·HTPR·Lp(a) 인과)는 동아시아 일반화 강함. 단 Lp(a)→MACE 의 한국인 hard endpoint 는 sub-V 가 🟠 INSUFFICIENT/DEFERRED (글로벌 meta extrapolation) 로 둔 상태 — 인과 방향은 일반, 한국·동아시아 정량 effect size 는 미확정.

---

## §3. transport 판정 — 어느 결론이 일반화 vs 한국 특이

X9 §5/§7 의 3-axis leverage 핵심 결론 3개 (① 3-axis 패널 가치 · ② DAPT 결정맵 · ③ no-reflow IC/ALDH2\*2 stratification) 를 transport 판정.

| 결론 | source 근거 | 분포 transport | effect 일반화 | **판정** |
|---|---|---|---|---|
| **① 3-axis 패널 가치** (채혈 1회 + PCR 로 N+D+L 동시 stratify) | X9 §5.2 (N4·N5·D1·D4·L1·L2 6 wall 동시) | ✅ 3국 모두 ALDH2\*2 ~40% · CYP2C19 LoF ~37-40% · Lp(a) ≥50 ~10-15% | ✅ 동일 변이 — 동시보유 확률도 3국 공통 高 | **동아시아 일반화** (패널 구성·생물학적 가치는 한·일·중 공통) |
| **②a DAPT-PGx 결정맵 가치** (한국인 60% clopidogrel 비-최적) | X9 D1 · M1§4 | ✅ 동아시아 LoF carrier ~55-60% (백인 ~25-30% 대비 2배) | ✅ 동일 prodrug 대사 — HTPR 일반화. HOST-EXAM/TICAKOREA(한국) 은 동아시아 출혈 paradigm 일치 | **동아시아 일반화** (PGx-guided antiplatelet 가치는 한·일·중 공통) |
| **②b CYP2C19 PCR ₩50,000 NHIS 급여 배포** | X9 §5.2 (기존 NHIS 급여 안 배포) | ✅ 빈도 동일 | — (정책·약가 modifier) | **한국 특이** (NHIS 수가·급여 구조는 한국 제도 — 일·중은 별도 보험·약가) |
| **③a no-reflow ALDH2\*2 stratification 가치** | X9 N4/N5 · M9§5 | ✅ ALDH2\*2 ~40% 3국 공통 | ✅ rs671 동일 SNP·NO bioavailability↓ 동일. 일본 JAHA 2021 직접 관찰 | **동아시아 일반화** (ALDH2\*2 IRI 악화 + alternative NO donor 가설은 한·일·중 공통) |
| **③b nicorandil null = 동아시아 일반** | X8 §5 F3/F4 (🔴) · M9§5 | ✅ — | ✅ Korean RCT 6mo null(F3) **+ CHIPS-PCI 중국 6mo null(F4)** 양국 일치 | **동아시아 일반화** (nicorandil 6mo 무효는 한국·중국 RCT 양국 falsify — 가장 강한 transport) |
| **③c no-reflow IC delivery (adenosine/nicorandil IC-sync)** | X9 N1 · M4 | (delivery = device, 분포 무관) | ✅ IC PK 우위 = 생리(인종 무관) | **동아시아 일반화** (카테터 국소전달 물리는 인종 무관) |
| **④ Lp(a) siRNA 한국 NHIS WTP 0% pass + 잠재시장 500만** | X9 L2 · M2§3 (43M×0.12-0.13) | ✅ Lp(a) ≥50 분율 동아시아 공통 ~12% | — (약가·HIRA 협상 modifier) | **한국 특이** (WTP·HIRA·인구 절대수는 한국 제도·인구 — 일·중은 별도 경제) |

```
transport 판정 요약
──────────────────────────────────────────────────────────────────
동아시아 일반화 (생물학·효과 transport ✅)
  ① 3-axis 패널 가치        ── 3국 모두 3 axis 동시보유 확률 高
  ②a DAPT-PGx 결정맵 가치    ── LoF carrier 55-60% (백인 2배), 동일 대사
  ③a ALDH2*2 stratification ── rs671 동일 SNP, 일본 cohort 직접 관찰
  ③b nicorandil null         ── 한국 RCT + 중국 CHIPS-PCI 양국 falsify ★최강
  ③c IC delivery 물리        ── 인종 무관 생리
한국 특이 (분포는 ✅, 결론이 한국 제도/인구에 묶임)
  ②b CYP2C19 PCR NHIS 급여    ── NHIS 수가/급여 구조
  ④  Lp(a) siRNA WTP·시장     ── HIRA 약가협상 + 인구 절대수 (520만)
백인에 덜 적용 (분포 transport 자체 약함)
  · ALDH2*2 ~0% (East Asian 특이 변이 — 백인엔 axis 자체 부재)
  · CYP2C19 LoF ~15% (동아시아 ~40%의 절반 이하)
  · Lp(a)만 백인이 오히려 ↑(~20%) — 단일 axis 역전
──────────────────────────────────────────────────────────────────
```

---

## §4. 백인 코호트엔 왜 덜 적용되나

| axis | 백인 분포 | 적용 약화 사유 |
|---|---|---|
| **ALDH2\*2** | 거의 0% | rs671 은 한족 기원 East Asian 특이 변이 — 백인엔 **axis 자체가 존재하지 않음** → ALDH2\*2 stratification 무의미 |
| **CYP2C19 LoF** | ~15% (\*3 거의 0) | 동아시아 ~40%의 절반 이하 · 백인은 오히려 \*17 GoF (~21%) 비중 高 → "PGx-guided de-escalation" 의 임상적 yield 가 동아시아만큼 크지 않음 (M1§3) |
| **Lp(a) ≥50** | ~20% (동아시아보다 높음) | **유일하게 백인에 더 흔한 axis** — 단, 백인 단독 axis 로는 3-axis lattice 의 "3중 동시보유" 시너지(§3 ①)가 성립 안 함 (ALDH2\*2·CYP2C19 부재) |

→ **백인 비적용 핵심**: 3-axis leverage 의 가치는 **3축이 동시에 高빈도** 라는 동아시아 특이 조합에서 나온다. 백인은 Lp(a) 한 축만 흔하고 ALDH2\*2 부재·CYP2C19 LoF 절반 → "한 명의 환자가 3축 동시보유" 확률이 낮아 단일 채혈·PCR 패널의 cross-domain leverage(§3 ①)가 약화. 즉 3-axis 패널은 **동아시아 ethnicity-specific differentiator** 이며, 백인 코호트엔 Lp(a) 단축 stratification 으로 축소된다.

---

## §5. 함의 — 한·일·중 공동 trial 가능성 (X5 국제 확장)

X5 4-trial portfolio (A NICORADENO · B DAPT-PGx-K · C ROCK-DCB · D LPA-siRNA-K) 의 국제 확장 후보를 transport 판정 기반으로 도출.

| X5 trial | 3-axis | 국제 확장 leverage (sub-V VERBATIM) | 공동 trial 후보도 |
|---|---|---|---|
| **A. NICORADENO-MVO** | ALDH2\*2 primary | **nicorandil = 일본 J-WIND positive (Kitakaze 2007) + 한국 보험 등재 + 중국 CHIPS-PCI** → 3국 모두 nicorandil familiarity. ALDH2\*2 ~40% 3국 공통 → **ALDH2\*2 stratified RCT(글로벌 부재)를 한·일·중 공동 enrollment** 로 power 확보 (한국 단독 ALDH2\*2 power 0.654 🟠 → 3국 합산으로 effect size 회복) | ★★★ **최고** |
| **B. DAPT-PGx-K** | CYP2C19 LoF | HOST-EXAM(한국) · TICAKOREA(한국) · 일본 PGx 가이드 + 중국 LoF ~37% → 동아시아 공통 de-escalation paradigm. CYP2C19-guided RCT 동아시아 공동 cohort | ★★ 높음 (단 PCR 급여는 각국 제도) |
| **C. ROCK-DCB IIT-1** | (ALDH2\*2 eNOS modifier 가설) | **fasudil = 일본 1995 승인 (30y 안전성)** → X5 §1 명시 "MFDS first-in-human IND + Japan PMDA cross-recognition" — 한일 device cross-recognition 이미 portfolio 에 반영 | ★★ 높음 (한일 우선) |
| **D. LPA-siRNA-K** | Lp(a)/KIV-2 | Lp(a) ≥50 분율 동아시아 공통 ~12% → HORIZON/OCEAN(a) 동아시아 enrollment 공동. 단 약가·급여 분기점은 각국(§3 ④ 한국 특이) | ★ 중간 (enrollment 공동 가능, 경제는 각국) |

```
한·일·중 공동 trial 국제 확장 매트릭스
─────────────────────────────────────────────────────────
              한국          일본              중국
Trial-A    nicorandil보험  J-WIND positive   CHIPS-PCI(n=2420)   → ALDH2*2 stratified 3국 공동 ★최고
Trial-B    HOST-EXAM       일본 PGx guide     LoF ~37%            → CYP2C19 de-escalation 동아시아
Trial-C    MFDS IND        fasudil 1995 승인  —                   → 한일 PMDA cross-recognition
Trial-D    HIRA 약가       PMDA              NMPA                → Lp(a) enrollment 공동 (경제 각국)
─────────────────────────────────────────────────────────
공통 backbone = ALDH2*2 ~40% + CYP2C19 LoF ~37-40% + Lp(a) ≥50 ~12% 3국 공유
```

**최우선 공동 trial 후보 = Trial-A (NICORADENO / ALDH2\*2 stratified)**:
- nicorandil 6mo null 이 한국(F3) + 중국 CHIPS-PCI(F4) 양국에서 이미 입증 (§3 ③b, 가장 강한 transport) → 일반 인구 가설은 닫혔으나 **ALDH2\*2 stratified sub-group RCT 는 글로벌 부재** (M9§5 "한국 우위 기회" VERBATIM).
- 한국 단독 ALDH2\*2 sub-group power = NOREFLOW M12.4 **0.654 🟠 INSUFFICIENT** (X5 §6 fence VERBATIM) → 한·일·중 3국 공동 enrollment 로 effect size 증폭 → power 회복 = transport 가 직접 만드는 leverage.
- nicorandil(일본 J-WIND·한국 보험·중국 CHIPS) + ALDH2\*2 (3국 ~40%) = 약물 familiarity + axis 분포 둘 다 3국 공유 → 신규 IND 부담 최소.

---

## §6. g5 grade — X18 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 cross-population 분포 표 | 🟡 SUPPORTED-BY-CITATION | DAPTPGX M1§3 / LPA M2§1 인종별 표 + NOREFLOW M9§5 ALDH2\*2 VERBATIM. country-split 미수록분은 동아시아 통합치 + 🟡 명시 |
| §2 effect 일반화 판정 | 🟡 | sub-V 기전(rs671·\*2/\*3·KIV-2) + effect(IRI·HTPR·Lp(a) 인과) VERBATIM carry. Lp(a) 한국 endpoint 는 sub-V 🟠 그대로 |
| §3 transport 판정 | 🟡 (compositional) | X9 §5/§7 결론 + §1 분포 + §2 effect 의 transport 논리 결합 (분포·effect 는 VERBATIM, 일반화/특이 분류는 X18 가공) |
| §4 백인 비적용 | 🟡 | M1§3 백인 ~15% · M2§1 백인 ~20% VERBATIM + ALDH2\*2 East Asian 특이 carry |
| §5 한·일·중 공동 trial | 🟡 + ⚪ (proposal) | X5 trial portfolio + J-WIND/CHIPS-PCI/fasudil cross-recognition VERBATIM. 공동 trial 자체는 ⚪ proposal (미결성) |

**X18 종합 등급**: 🟡 SUPPORTED-BY-CITATION (compositional) — 분포/effect/grade 는 4 sub-V + X1/X5/X8/X9 VERBATIM carry, transport 판정(일반화 vs 특이)은 X18 분석 가공. **새 🟢 LLM self-judge 0건** (per @D g5).

⚠ **honest fence (d6 정직)**:
- (1) **ALDH2\*2 country-split 불확실**: sub-V 가 East Asian ~40% 통합치만 제공 (일본 JAHA 2021 cohort 는 보유율이 아닌 outcome 관찰) — 한·일·중 개별 정밀 보유율은 sub-V 미수록, X18 은 통합치 carry (개별치 LLM 추정 금지).
- (2) **CYP2C19 일본/중국 country-level**: M1§3 은 "동아시아" 단일 열 → 일본/중국 개별치는 동아시아 통합 ~37% 환산 🟡 (한국만 ~40% 직접).
- (3) **Lp(a) 일본/중국**: Wang 2020 JAHA (M2§1 ref) 가 중국·일본 동아시아 ~10-15% 로 묶음 — country-level 정밀 분율은 review-derived (M2§6 공백: 1차 코호트 open-access 부족).
- (4) **공동 trial = proposal**: 한·일·중 공동 enrollment 는 어느 trial 도 미결성 ⚪ (regulatory cross-recognition 은 X5 §1 fasudil/nicorandil precedent VERBATIM 이나 통합 trial 미시작).

---

## §7. X18 산출 요약

- **분포 transport**: ALDH2\*2 ~40% · CYP2C19 LoF ~37-40% · Lp(a) ≥50 ~10-15% 가 **한·일·중 3국 공통** (백인은 ALDH2\*2 ~0% · CYP2C19 LoF ~15% · Lp(a) ~20%로 단일축만 역전) — 3-axis 동시고빈도는 동아시아 특이.
- **effect 일반화**: 3 axis 모두 동일 변이·동일 분자 기전(rs671 · \*2/\*3 splice/stop · KIV-2) → 효과 transport ✅. Lp(a)→한국 hard endpoint 만 🟠 미확정.
- **동아시아 일반화 결론**: ① 3-axis 패널 가치 · ②a DAPT-PGx 결정맵 · ③a ALDH2\*2 stratification · ③b nicorandil null(한·중 양국 falsify, 최강 transport) · ③c IC delivery 물리.
- **한국 특이로 남는 것**: ②b CYP2C19 PCR NHIS 급여 배포 + ④ Lp(a) siRNA WTP·잠재시장 520만 = **분포는 transport 되나 제도(NHIS·HIRA)·인구 절대수는 한국 특이**.
- **백인 비적용**: ALDH2\*2 axis 부재 + CYP2C19 LoF 절반 → 3축 동시보유 확률 낮아 패널 leverage 약화 (Lp(a) 단축으로 축소).
- **한·일·중 공동 trial 최우선 = Trial-A (NICORADENO / ALDH2\*2 stratified RCT)** — nicorandil familiarity (일본 J-WIND · 한국 보험 · 중국 CHIPS-PCI) + ALDH2\*2 ~40% 3국 공유 + 한국 단독 power 0.654 🟠 → 3국 공동으로 power 회복. 한일 우선 Trial-C (fasudil PMDA cross-recognition) 차순위.
- **g5 준수**: 분포/effect/grade 4 sub-V + X1/X5/X8/X9 VERBATIM · 새 🟢 0건 · country-split 불확실분 🟡 + honest fence 명시 (d6) · "현재 방법 불가능" 표현 0회 (공동 trial = 구체 후보 명명).

---

## §8. CLI commands log

본 X18 작성 시 **새 hexa verify / atlas / pool / cloud / python 명령 실행 0건** — 4 sub-domain `.md` (DAPTPGX/M1 · LPA/M2 · NOREFLOW/M9·M8) + X1/X5/X8/X9 read-only 인용 + transport 판정 논리만. (절대 금지 준수: git 0 · sim/pool/cloud/python/hexa verify 0 · X18_transportability.md 외 수정 0 · ~/core/demiurge 경로 미사용 — /tmp/cardio-work 전용.)
