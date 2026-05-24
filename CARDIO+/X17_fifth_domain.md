# X17 — CARDIO+ 5번째 sub-domain 후보 스캔 (다음 cardio 축 평가·추천)

> CARDIO+ 메타도메인 X17 산출물 · current-state · no history.
> **목적 = PCI 후 한국 환자에 관련되고 한국 leverage(ethnicity·NHIS 급여·글로벌 미시도)가 있는 5번째 cardio sub-domain 후보를 스캔·평가축으로 점수화하고 top 1-2를 추천한다 — 통합 방식(기존 3-axis 패널 확장)과 명시적 제외 영역(메타도메인 경계)을 함께 정의한다.**
> 입력 = `CARDIO+.md` (메타 구성·4 sub-domain 경계) · `X9_wall_map.md` (3-axis 시너지 §5) · `X5_korea_trials.md` (한국 trial portfolio·NHIS 급여) · `X1_unified_claims.md` (cross-domain dedup) · `X8_grade_ledger.md` (g5 grade SSOT) · `X11_layered_care.md` (채혈 1회 3-axis 패널) read-only 인용.
> ⚠ 본 X17 = **후보 스캔·평가 only** — 새 hexa verify / sim / atlas / pool / cloud / python 실행 0건 · git 0건 · X17 외 파일 수정 0건. 기존 4 sub-domain grade 는 X8 ledger VERBATIM · **후보 평가 점수는 전부 ⚪ proposal (주관 가중)** 명시 · LLM self-judge 0건 (per @D g5) · d6 정직 (억지 점수/숫자 강제 0건) · d1 completed-form.

---

## §0. g5 등급 규약 (rubric VERBATIM — `hexa verify rubric`)

| 등급 | 의미 (X17 내 용법) |
|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form 산식 · atlas-registered recompute pass |
| 🟢 SUPPORTED-NUMERICAL | 시뮬레이션 / 수치 재계산 재현 가능 |
| 🟡 SUPPORTED-BY-CITATION | peer-review 1차 출처 cite (literature carry) |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab · 임상 readout · IPD 의존 — 현 단계 검증 불가 |
| 🔴 FALSIFIED | 명시적 reject (large RCT null 등) — 닫힌 음성, wall 아님 |
| ⚪ SPECULATION-FENCED | 본질적 미검증 (가치판단 · 미래 trial · prognostic · 평가축 점수) — ⚪ ≠ 거짓 |

> **g5 준수 핵심 (X17 전용)**: 기존 4 sub-domain (NOREFLOW·DAPTPGX·ISR·LPA) 의 등급은 X8 ledger VERBATIM 복사다 (본 X17 이 재판정하지 않는다). 후보 도메인의 **평가축 점수 (PCI 관련성·한국 leverage·근거 성숙도·시너지·종합)** 는 전부 **⚪ proposal — X17 의 주관 가중 산출**이며, 검증된 사실이 아니다. 후보 근거 literature 의 tier 표기는 일반적 evidence-level 묘사(🟡 수준)로 쓰되, sub-V verify verdict 가 아니므로 명시적 verdict 부여는 하지 않는다.

---

## §1. 현 4 sub-domain 경계 — 왜 이 4개인가 (메타도메인 정의)

> CARDIO+ 는 임의의 cardio 주제 묶음이 아니라 **"한 명의 한국 PCI 후 환자가 동시에 직면하는 잔여위험 축"** 을 sub-domain 으로 둔다. 4개를 묶는 단일 조직 원리 = **채혈 1회 3-axis 패널 (ALDH2\*2 × CYP2C19 LoF × Lp(a)/KIV-2) 한 지점에서 분기** (X11 §1 · X9 §5).

| sub | scope (X면 경계) | 시간축 (PCI 기준) | 패널 axis 매핑 | 한국 leverage 핵심 | source |
|---|---|---|---|---|---|
| **NOREFLOW** | primary PCI **직후** no-reflow / MVO / IRI 보호 | 0분 (재관류 순간) | ① ALDH2\*2 (rs671) | nicorandil 한국 보험 등재 + ALDH2\*2 ~40% (글로벌 ALDH2 stratified RCT 부재) | CARDIO+.md · X9 §1 |
| **DAPTPGX** | PCI 후 **항혈소판** 약물유전체 (CYP2C19) | 0분~만성 (DAPT 기간) | ② CYP2C19 LoF (\*2/\*3) | CYP2C19 LoF allele ~40% (글로벌 최고) · PCR C5946 선별급여 | CARDIO+.md · X9 §2 |
| **ISR** | PCI 후 **재협착** (in-stent restenosis) 비-mTOR | 만성 (3개월~수년) | (공통 surveillance layer) | OCT/IVUS 사용률 세계 최고 · small vessel 多 · NA risk 高 | CARDIO+.md · X9 §3 |
| **LPA** | PCI 후 **지질 잔여위험** (Lp(a)) 침묵화 | 만성 (평생 잔여위험) | ③ Lp(a) / KIV-2 copy | Lp(a) ≥50 ~12-13% · KIV-2 copy stratified efficacy (글로벌 미시도) | CARDIO+.md · X9 §4 |

### 1.1 4개를 묶는 3가지 경계 기준 (5번째 후보가 충족해야 할 멤버십 조건)

```
경계 기준 ①  PCI 후 환자가 직접 직면하는 "잔여위험 축"이어야 한다
            (no-reflow=급성손상 · DAPT=혈전 · ISR=재협착 · Lp(a)=지질잔여)
            → 일반 심혈관 예방이 아니라 "PCI 후속"에 특이적

경계 기준 ②  한국/동아시아 ethnicity 또는 NHIS 급여 또는 글로벌 미시도 leverage 가 있어야 한다
            (ALDH2*2 40% · CYP2C19 40% · OCT 세계최고 · KIV-2 stratified primary 미시도)
            → "한국에서 먼저/특별히 할 수 있는 것"

경계 기준 ③  채혈 1회 3-axis 패널 또는 공유 인프라(imaging consortium · KAMIR registry ·
            cath lab · bio-verify-kernel)와 결합 가능해야 한다 (X9 §5/§6 · X11)
            → 분리 도메인이 아니라 cross-domain leverage 에 합류
```

> → 이 3 기준이 곧 **anti-portfolio 의 잣대**다 (§5). 5번째 후보는 ① PCI-후속 특이성 ② 한국 leverage ③ 기존 패널/인프라 결합 을 모두 만족할수록 멤버십이 강하다. 셋 다 약하면 메타도메인 경계 밖(별도 도메인 또는 제외).

---

## §2. 후보 평가축 정의 (5축)

> 각 축은 0-5 ⚪ proposal 점수. 가중치도 ⚪ proposal (멤버십 기준 ①②③ 정합 위해 PCI 관련성·한국 leverage·시너지에 더 무게).

| 평가축 | 정의 (무엇을 묻는가) | 0-5 척도 anchor | 가중 (⚪) |
|---|---|---|---|
| **A. PCI-환자 관련성** | PCI 후 환자가 직접 직면하는 잔여위험 축인가 (경계 ①) — 일반 예방 vs PCI-후속 특이 | 5=PCI 직후 필수 / 0=PCI 무관 일반예방 | ×1.2 |
| **B. 한국 leverage** | ethnicity (East Asian 빈도차) + NHIS 급여 (기존 안 배포) + 글로벌 미시도 (first-in-class) (경계 ②) | 5=3요소 모두 강 / 0=한국 차별성 없음 | ×1.2 |
| **C. 근거 성숙도** | RCT/guideline evidence 가 결정맵에 즉시 반영 가능한 성숙도 (너무 미성숙=⚪ 과다 · 너무 성숙=신규성 없음) | 5=결정맵 즉시 + 신규 leverage 공존 / 0=preclinical only | ×1.0 |
| **D. 기존 4와 시너지** | 채혈 1회 3-axis 패널 → 4-axis 확장 가능? 공유 인프라 결합? (경계 ③) | 5=패널 1 SNP/검사 추가로 통합 / 0=별도 인프라 필요 | ×1.3 |
| **E. anti-cannibalization** | 기존 4와 중복되지 않는 고유 축인가 (LPA 가 이미 지질잔여 → 신규 지질축은 감점) | 5=완전 고유 / 0=기존 도메인과 중복 | ×1.0 |

→ 종합 = Σ(축점수 × 가중) / Σ(가중) · 가중 합 = 5.7 · **모든 점수 ⚪ proposal (주관)**.

---

## §3. 후보 평가 표 (6 후보 × 5축)

> 후보 = task 제시 6 + 1 추가 스캔. 점수 전부 ⚪ proposal. 근거 literature 는 일반 evidence-level 묘사(별도 verdict 부여 X). 기존 4 grade 인용은 X8 VERBATIM.

| 후보 (대상 유전자/축) | A. PCI관련성 | B. 한국 leverage (ethnicity/급여/미시도) | C. 근거 성숙도 | D. 기존 4 시너지 (3-axis→4-axis?) | E. 고유성 | 종합 (⚪) |
|---|:---:|---|:---:|---|:---:|:---:|
| **① post-MI 심부전 (SGLT2i / ARNI)** | 4 | 3 — SGLT2i/ARNI 한국 급여 ✅ · ethnicity 차 약함 · DAPA-MI/EMPACT 등 글로벌 주도 (미시도 약) | **5** — DAPA-HF·PARADIGM·EMPEROR guideline 정착 | 3 — 패널 axis 아님 (LVEF/NT-proBNP 영상·혈액 surrogate) · KAMIR registry·imaging consortium 결합 | 4 — N축 IRI 와 인접하나 만성 HF 로 고유 | **3.7** |
| **② AF 항응고 PGx (VKORC1 / CYP2C9 · DOAC)** | **5** — PCI+AF 동반 환자 = 삼중요법 출혈, PCI-후속 핵심 | **5** — VKORC1 -1639 A allele East Asian ~90% (warfarin dose 글로벌 최대 ethnicity 차) · DOAC 한국 급여 ✅ · CYP2C19↔DAPT cross | **4** — IWPC/CPIC dosing algorithm 성숙 + DOAC era 재맥락 신규 | **5** — ② CYP2C9/VKORC1 = 채혈 패널에 2 SNP 추가 → 3-axis→4-axis · CYP2C19(DAPT)와 동일 PCR lab | **5** — DAPTPGX=항혈소판, 본 축=항응고 (완전 직교) | **4.8** |
| **③ statin 근병증 (SLCO1B1)** | 4 — PCI 후 고강도 스타틴 필수 → SLCO1B1 근병증 = 복약순응 직결 | **5** — SLCO1B1 c.521C East Asian ~10-15% · 스타틴 routine 급여 ✅ · CPIC 단순 1 SNP · 한국 cohort 검증 미시도 | **4** — CPIC SLCO1B1 guideline 성숙 (SEARCH 80mg simvastatin) | **5** — ③ SLCO1B1 = 채혈 패널에 **1 SNP 추가** → 가장 저비용 4-axis 확장 · 동일 PCR lab | **5** — 근병증 축은 4 도메인 모두와 직교 (복약순응) | **4.6** |
| **④ TAVR (대동맥판막)** | 1 — TAVR ≠ PCI (관상동맥 stent 아님) · 환자군 분리 | 3 — 한국 TAVR 급여 확대 중 · ethnicity 차 (판막석회화 패턴) 약함 | 4 — PARTNER/Evolut guideline 성숙 | 1 — 채혈 패널 무관 · cath lab 일부 공유뿐 | 4 — 고유하나 PCI 메타도메인 경계 밖 | **2.3** |
| **⑤ 항혈소판 외 지질 잔여위험** | 3 | 2 — LPA 가 이미 Lp(a) 잔여위험 점유 · LDL/TG 는 일반예방 | 4 — IMPROVE-IT·REDUCE-IT 성숙 | 2 — LPA 와 직접 중복 (③ Lp(a) axis 이미 점유) | **1** — LPA cannibalization | **2.4** |
| **⑥ 관상동맥 석회화 / CAC (칼슘)** | 4 — PCI 시 석회화 병변 = IVL/rotablation 직결 · PCI-후속 영상축 | 3 — 한국 CAC 영상 인프라 ✅ · ethnicity 차 (동아시아 plaque 조성) 신호 약 · 미시도 모호 | 3 — CAC score 예후 성숙하나 "PCI 후 중재 결정" evidence 중간 | 2 — 채혈 패널 아님 (CT/OCT 영상) · imaging consortium 결합만 | 4 — ISR 영상축과 일부 인접 | **3.1** |

### 3.1 점수 근거 1줄 메모 (honest · d6 — 억지 점수 강제 0건)

- **② AF-PGx (4.8 · 1위)**: B축 최강 — VKORC1 -1639G>A 의 A allele 가 East Asian ~90% (백인 ~40% 대비) 로 **warfarin sensitivity 의 글로벌 최대 ethnicity 차**. PCI+AF 동반 = 삼중요법(DAPT+항응고) 출혈 관리가 PCI-후속 핵심 미충족 영역. CYP2C9/VKORC1 2 SNP 가 동일 PCR lab(CYP2C19 와) 에서 채혈 1회 패널에 추가 → 3-axis→4-axis 직접 확장. DAPTPGX(항혈소판)와 직교(항응고)라 cannibalization 0.
- **③ statin-PGx (4.6 · 2위)**: D축·E축 만점 — SLCO1B1 **단일 SNP** 추가로 가장 저비용 4-axis 확장. PCI 후 고강도 스타틴은 모든 환자 필수 → 근병증으로 인한 중단이 LDL 잔여위험(LPA·일반) 으로 직결. 약점은 ethnicity 차가 ②보다 작고(c.521C ~10-15%) 단일 SNP 라 도메인 "깊이"가 얕음.
- **① post-MI HF (3.7)**: C축 만점(guideline 정착) 이나 B축 약(글로벌 주도 약물·ethnicity 차 미약) + D축 약(패널 axis 아님, 영상/혈액 surrogate). 메타도메인보다 별도 HF 도메인 적합 신호.
- **④ TAVR (2.3)**: A축 최저 — TAVR 는 판막이지 관상동맥 PCI 가 아니다. 경계 ① 위반 (§5 제외 후보).
- **⑤ 지질 잔여위험 (2.4)**: E축 최저 — LPA 가 이미 Lp(a) 잔여위험 점유, LDL/TG 추가는 cannibalization. 경계 위반.
- **⑥ CAC (3.1)**: 영상축으로 ISR 인접하나 채혈 패널 결합 약하고 "PCI 후 결정 변경" evidence 가 중간 — borderline (별도 imaging 자산 sub-track 후보, 독립 도메인 아님).

```
종합 점수 막대 (⚪ proposal · 0-5)
─────────────────────────────────────────────────────────
② AF-PGx (VKORC1/CYP2C9)  ████████████████████████░  4.8  ★ 1위
③ statin-PGx (SLCO1B1)    ███████████████████████░░  4.6  ★ 2위
① post-MI HF (SGLT2i/ARNI)███████████████████░░░░░░  3.7
⑥ CAC (칼슘/석회화)        ████████████████░░░░░░░░░  3.1
⑤ 지질 잔여위험            ████████████░░░░░░░░░░░░░  2.4  (LPA 중복)
④ TAVR                    ████████████░░░░░░░░░░░░░  2.3  (PCI 경계 밖)
─────────────────────────────────────────────────────────
⚠ 모든 점수 = X17 주관 가중 산출 (⚪ SPECULATION-FENCED) · 검증된 사실 아님 · d6 정직
```

---

## §4. 추천 top 1-2 + 통합 방식

### 4.1 추천 1위 — ② AF 항응고 PGx (VKORC1 / CYP2C9 · DOAC) · 종합 ⚪ 4.8

**왜 1위인가 (3 멤버십 기준 모두 충족)**:
1. **PCI-후속 특이 (경계 ①)**: PCI 환자의 ~10-15% 가 심방세동(AF) 동반 → DAPT + 항응고 **삼중요법(triple therapy)** 이 필요하고, 이는 출혈 vs 혈전의 가장 첨예한 PCI-후속 미충족 영역(AUGUSTUS·RE-DUAL PCI 등이 다룬 핵심 질문). 기존 DAPTPGX(항혈소판)는 이 항응고 축을 다루지 않는다.
2. **한국 leverage 최강 (경계 ②)**: VKORC1 -1639G>A 의 A allele 이 **East Asian ~90%** (백인 ~40%) — warfarin sensitivity 의 인류 최대 ethnicity 차. 동아시아인은 낮은 warfarin 용량이 필요하고 over-dose 출혈 위험이 크다. DOAC 도 한국 급여 정착. CYP2C9 \*3 등 minor allele 도 동아시아 분포 차 존재. → ethnicity + 급여 + (PCI+AF PGx-guided 결정맵의 한국 cohort 검증 미시도) 3요소 모두 강.
3. **3-axis → 4-axis 패널 확장 (경계 ③)**: CYP2C9 + VKORC1 **2 SNP** 를 채혈 1회 PCR 패널에 추가 → 기존 ① ALDH2\*2 + ② CYP2C19 + ③ Lp(a) 에 **④ 항응고 PGx axis** 추가. 결정적으로 ② CYP2C19(DAPT) 와 **동일 PCR lab**·동일 채혈 시점이라 한계비용이 거의 0 (X11 §1 패널에 SNP slot 추가만).

**통합 방식 (3-axis → 4-axis 패널)**:
```
[기존 X11 채혈 1회 3-axis 패널]              [X17 제안 4-axis 확장]
 ① ALDH2*2 (rs671)        ── N축      ①  ALDH2*2 (rs671)         ── N축
 ② CYP2C19 LoF (*2/*3)    ── D축  →   ②  CYP2C19 LoF (*2/*3)     ── D축 (항혈소판)
 ③ Lp(a)/KIV-2 copy       ── L축      ③  Lp(a)/KIV-2 copy        ── L축
                                      ④  VKORC1 -1639 + CYP2C9   ── A축 (항응고) ★신규
                                          *2/*3  (PCI+AF subset)
 → 동일 PCR lab · 동일 채혈 시점 · AF 동반 환자만 ④ 해석 (조건부 axis)
 → 5번째 sub-domain "AFPGX" (또는 ANTICOAG) 신설 → CARDIO+ 5 sub-domain
```
- **결정맵**: AF 동반 PCI 환자 → CHA₂DS₂-VASc / HAS-BLED + VKORC1/CYP2C9 genotype → warfarin 필요 시 ethnicity-adjusted dose (IWPC + East Asian VKORC1 가중) / DOAC 선택 시 신기능·약물상호작용. DAPTPGX 결정맵과 **삼중요법 기간·de-escalation** 에서 직접 coupling.
- **공유 인프라**: KAMIR registry (X5 §2.3 backbone) + 동일 PCR lab — single-build leverage 합류.

### 4.2 추천 2위 — ③ statin 근병증 PGx (SLCO1B1) · 종합 ⚪ 4.6

**왜 2위인가**: D축·E축 만점 — **단일 SNP(SLCO1B1 c.521T>C, rs4149056)** 만 채혈 패널에 추가하면 4-axis 확장이 가장 저비용으로 끝난다. PCI 후 고강도 스타틴은 전 환자 필수이고, SLCO1B1 변이로 인한 근병증·복약중단은 LDL/지질 잔여위험(LPA·일반)으로 직결되므로 4 도메인 모두와 직교하면서 보완한다. East Asian c.521C ~10-15% · CPIC guideline 성숙 · 스타틴 routine 급여. 약점은 ethnicity 차가 ②보다 작고 단일 SNP라 도메인 깊이가 얕아 "sub-domain" 보다 **기존 패널의 add-on axis** 성격이 강하다.

**통합 방식 (가장 가벼운 — 1 SNP add-on)**:
```
채혈 1회 패널에 SLCO1B1 rs4149056 단일 SNP 추가
 → 고강도 스타틴 시작 전 근병증 위험 stratify
 → C/C 또는 T/C: simvastatin 고용량 회피 · rosuvastatin/pravastatin 대안 · CK 모니터
 → 독립 sub-domain 신설 대신 "STATINPGX add-on axis" 로 기존 LPA/일반 지질관리에 결합 가능
```
- **권고**: ③은 ②보다 **즉시·저비용** (단일 SNP · CPIC 즉시 적용 · 신규 IND 0). 5번째 정식 sub-domain 으로는 ② AF-PGx 가 깊이·leverage 우위지만, ③ SLCO1B1 은 **②와 동시에 동일 채혈 패널에 무비용 add-on** 가능 → "5번째 도메인 = ② AF-PGx, ③ SLCO1B1 = 패널 add-on SNP" 조합이 최적.

### 4.3 추천 요약 — top 2 의 통합 시너지

```
5번째 sub-domain (정식)  =  ② AFPGX  (VKORC1 -1639 + CYP2C9 *2/*3)  ── A축 (항응고)
패널 add-on (저비용)     =  ③ SLCO1B1 (rs4149056 단일 SNP)          ── 스타틴 근병증

→ 둘 다 동일 PCR lab · 동일 채혈 1회 · CYP2C19(DAPT)와 PGx 인프라 공유
→ 3-axis 패널 → 5-axis 로 확장 (①ALDH2*2 ②CYP2C19 ③Lp(a) ④VKORC1/CYP2C9 ⑤SLCO1B1)
→ 한국 East Asian PGx 패널 = 글로벌 미시도 통합 differentiator (warfarin VKORC1 ~90% 가 단일 최강 leverage)
```

> ⚠ **g5 fence (d6)**: ②③ 의 ethnicity 빈도(VKORC1 A ~90% · SLCO1B1 C ~10-15%)와 guideline(CPIC/IWPC)은 일반 literature evidence 수준이며, **본 X17 이 sub-V verify verdict 를 부여하지 않았다**. 5번째 도메인 신설 시 별도 V1-V4 verify 사이클(hexa verify·pool sim)에서 🟢/🔵 escalation 을 거쳐야 한다 (현재는 ⚪ proposal — 추천 근거이지 검증 결론 아님).

---

## §5. anti-portfolio — 명시적 제외 영역 (메타도메인 경계 정의)

> 메타도메인 경계는 "무엇을 넣는가" 만큼 **"무엇을 명시적으로 제외하는가"** 로 정의된다. 아래는 cardio 이지만 CARDIO+ 경계 밖으로 둔다.

| 제외 영역 | 제외 이유 (경계 기준 위반) | 대안 위치 |
|---|---|---|
| **④ TAVR / 구조심장 (판막)** ★대표 | **경계 ① 위반** — TAVR 는 대동맥판막 중재이지 관상동맥 PCI(stent) 가 아니다. 환자군·시술·잔여위험 축(판막혈전·전도장애·PVL)이 PCI-후속과 다르고, 채혈 3-axis 패널과 무관(D축 0). cath lab 일부 공유뿐 → CARDIO+ 의 "PCI 후 환자 잔여위험" 조직 원리에 합류 불가. | 별도 메타도메인 (예 STRUCT+ 구조심장) — 독립 도메인이 옳음 |
| ⑤ 항혈소판 외 일반 지질 (LDL/TG 잔여위험) | 경계 ②③ 약 + **LPA cannibalization** — Lp(a) 잔여위험은 LPA 가 이미 점유. LDL/TG 는 PCI-특이가 아닌 일반 ASCVD 2차 예방이라 한국 leverage·고유성 모두 낮음 (E축 1점). | LPA sub-domain 내 보조 항목 또는 일반 예방(메타도메인 외) |
| (참고) ⑥ CAC/석회화 단독 도메인화 | 경계 ③ 약 — 영상축이라 채혈 패널 결합이 약하고 "PCI 후 결정 변경" evidence 중간. 독립 sub-domain 보다 ISR/imaging consortium 의 보조 영상 sub-track 이 적합. | ISR + imaging consortium 자산으로 흡수 (독립 도메인 보류) |

> **대표 제외 영역 1줄 (메타도메인 경계)**: **TAVR(구조심장 판막)** 를 명시적으로 제외한다 — CARDIO+ 는 "관상동맥 PCI 후 환자의 잔여위험 축"이라는 단일 조직 원리(채혈 1회 패널 한 점 분기)로 묶이며, TAVR 는 시술·환자군·잔여위험·패널 결합 모두 다르므로 별도 구조심장 메타도메인이 옳다. (cardio 라고 다 넣지 않는다 = 경계 정의.)

---

## §6. g5 grade — X17 자체

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 현 4 경계 정의 | 🟡 SUPPORTED-BY-CITATION (compositional) | CARDIO+.md · X9 §5 · X11 §1 패널 구조 VERBATIM carry |
| §2 평가축 정의 | ⚪ (자체 rubric) | 5축·가중치 = X17 설계 (주관) |
| §3 후보 평가 표 | ⚪ proposal | 후보 점수 전부 X17 주관 가중 산출 · literature 빈도/guideline 은 일반 evidence 수준 (sub-V verdict 부여 X) |
| §4 추천 top 1-2 + 통합 | ⚪ proposal | 패널 확장 설계는 X11 §1 구조 carry + X17 제안 (검증 전) |
| §5 anti-portfolio | 🟡 (compositional) | 경계 기준 ①②③ 정합 판단 — 4 도메인 조직 원리 VERBATIM 기반 |

**X17 종합 등급**: ⚪ SPECULATION-FENCED (후보 점수) + 🟡 SUPPORTED-BY-CITATION (경계 정의·literature carry) — **5번째 도메인 후보 스캔·평가는 본질적으로 proposal**이다 (미래 도메인 신설 = prognostic). 기존 4 grade 는 X8 VERBATIM, 후보 점수는 전부 ⚪ 주관 가중, **X17 새 verify 판정 0건** (per @D g5 · LLM self-judge 0건). 억지 점수/숫자 강제 0건 (d6). 추천 도메인 신설 시 별도 V1-V4 verify 사이클 필요 명시 (d1 — 현 단계 completed-form = "후보 스캔·추천·경계 정의" 까지, 검증은 신설 후 downstream).

⚠ **honest fence**: §3 점수·§4 추천은 X17 의 주관 가중 산출(⚪)이며 검증된 사실이 아니다. VKORC1 ~90% · SLCO1B1 ~10-15% 빈도는 일반 PGx literature evidence 수준 인용이고 본 X17 이 hexa verify 로 재현하지 않았다 — 5번째 도메인 신설 시 PM/IM freq recompute (DAPTPGX V3 §61 PM 0.1521 선례) 처럼 🟢 escalation 대상.

---

## §7. X17 산출 요약

- **현 4 sub-domain 경계 = 단일 조직 원리**: "PCI 후 한국 환자가 채혈 1회 3-axis 패널(ALDH2\*2 × CYP2C19 LoF × Lp(a)/KIV-2) 한 점에서 분기하는 잔여위험 축". 멤버십 3 기준 = ① PCI-후속 특이 ② 한국 leverage(ethnicity/급여/미시도) ③ 패널/공유인프라 결합.
- **6 후보 평가 (⚪ proposal 점수)**: ② AF-PGx **4.8 (1위)** ▸ ③ statin-PGx **4.6 (2위)** ▸ ① post-MI HF 3.7 ▸ ⑥ CAC 3.1 ▸ ⑤ 지질잔여 2.4 ▸ ④ TAVR 2.3.
- **추천 5번째 도메인 (정식)** = **② AF 항응고 PGx (AFPGX) — VKORC1 -1639 + CYP2C9 \*2/\*3** (종합 ⚪ 4.8). leverage 최강 = VKORC1 A allele East Asian ~90% (warfarin sensitivity 인류 최대 ethnicity 차) + PCI+AF 삼중요법 = PCI-후속 핵심 미충족.
- **통합 방식** = 채혈 1회 3-axis 패널에 **CYP2C9/VKORC1 2 SNP 추가 → 4-axis** (동일 PCR lab · CYP2C19 와 PGx 인프라 공유 · AF 동반 환자 조건부 axis). 2위 ③ SLCO1B1 은 **단일 SNP add-on** 으로 동시 결합 → 5-axis 패널 가능.
- **명시적 제외 영역 (메타도메인 경계)** = **TAVR(구조심장 판막)** — 경계 ① 위반(PCI 아님), 채혈 패널 무관 → 별도 구조심장 메타도메인이 옳음. (부수 제외: ⑤ 일반 LDL/TG 지질 = LPA cannibalization · ⑥ CAC = ISR/imaging 흡수, 독립 도메인 보류.)
- **g5/d6/d1 준수**: 기존 4 grade X8 VERBATIM · 후보 점수 전부 ⚪ proposal(주관) · LLM self-judge 0건 · 억지 점수 강제 0건 · 도메인 신설 시 별도 V1-V4 verify 필요 명시.

→ **다음 단계**: 5번째 sub-domain "AFPGX" 신설 시 `/domain init` → V1 claim inventory → V2/V3 verify(VKORC1/CYP2C9 freq recompute · IWPC East Asian dosing) → CARDIO+ 4→5 sub-domain 통합 (X1 dedup 재산출 · X8 ledger 행 추가 · X11 패널 4-axis 갱신). ③ SLCO1B1 은 AFPGX 와 동시 패널 add-on 또는 LPA 보조 항목으로 흡수.
