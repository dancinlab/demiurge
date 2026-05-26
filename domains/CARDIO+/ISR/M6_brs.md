# M6 — 차세대 BRS (bioresorbable scaffold) 재시도

> 마일스톤 M6 산출물 · current-state · no history.
> 출처 = ABSORB III/IV · BIOSOLVE-IV/V · meta + 2024-2025 reviews → 🟡 SUPPORTED-BY-CITATION.
> M1 hook = SF (stent fracture) · NH/NA 4-axis. M3 hook = 비-mTOR 표적 × BRS coating. M5 hook = DCB-in-BRS.

---

## 1. BRS 개요 — permanent metal stent vs bioresorbable scaffold

**BRS (Bioresorbable Scaffold)** = 일정 기간 vessel을 지지한 후 **완전히 흡수**되어 사라지는 scaffold. PLLA · Mg · Zn 등이 후보 재료.

### 1.1 이론적 장점 (vs DES 영구 metal)

| 장점 | 메커니즘 |
|---|---|
| **vessel restoration** | scaffold 흡수 후 native vessel function 회복 |
| **late lumen enlargement** | 흡수 + positive remodeling → 늦은 시점 내경 ↑ (DES는 不可) |
| **positive remodeling** | adventitia 압박 해제 → vessel wall 정상 신장 |
| **imaging artifact 부재** | CT/MR strut artifact 없음 → follow-up imaging 용이 |
| **CABG 호환** | 흡수 후 동일 부위 graft anastomosis 가능 |
| **DAPT 단축 잠재** | scaffold 흡수 후 thrombosis risk 자연 감소 |
| **재시술 자유도** | DES-in-DES 3겹 strut 회피 |

### 1.2 시간축 — implant → integrate → resorb → restored

```
  t = 0           t = 3-6m         t = 6-24m            t > 2-4y
  ─────           ────────         ─────────             ──────────
  implant         integrate        resorb                vessel restored
   ▲                ▲                 ▲                     ▲
   │                │                 │                     │
  ┌─┐            ┌─┐  EC          ┌╴╴┐  partial          ┌────┐
  │█│ scaffold   │█│←──── strut   │░░│ ←─ degradation    │    │  native
  │█│ radial     │█│   coverage   │░░│   product         │    │  vessel
  │█│ force      │█│              │░░│   washout         │    │  function
  └─┘            └─┘              └╴╴┘                   └────┘
```

PLLA = 36-48 m · Magmaris = 12 m · Freesolve = 12 m · Zn = ~12-24 m (재료별 큰 차이).

---

## 2. 1세대 PLLA BRS — Abbott Absorb 실패 분석

### 2.1 Absorb BVS 스펙

| 항목 | Absorb BVS | Xience (비교 DES) |
|---|---|---|
| 재료 | PLLA scaffold + PDLLA-everolimus 코팅 | CoCr + everolimus |
| **strut 두께** | **157 µm** | **81 µm** |
| radial force | 낮음 | 높음 |
| 약물 | everolimus | everolimus |
| 흡수 기간 | 3-4년 | — (영구) |
| 시판 | 2011 EU · 2016 US → **2017 시장 철수** | 진행중 |

### 2.2 ABSORB III/IV 핵심 결과 (3년 시점)

| Endpoint | Absorb | Xience | Δ |
|---|---|---|---|
| **TLF (target lesion failure)** | **11.0%** | **7.9%** | +3.1% (p<0.01) |
| TV-MI | 7.0% | 4.6% | + |
| ID-TLR | 5.3% | 3.9% | + |
| **scaffold/stent thrombosis** | **1.9%** | **0.8%** | +1.1% |
| cardiac death | 1.1% | 0.9% | NS |

→ 1y 시점 non-inferior 였으나 **3y 시점에서 안전성 신호 명확** → 2017 EU/US 시장 자진 철수.

### 2.3 실패 원인 4가지

| 원인 | 메커니즘 | 임상 시그널 |
|---|---|---|
| **(a) thick strut 157 µm** | turbulent flow · mal-apposition · 늦은 endothelial coverage | early/late ST · NH 위험 ↑ |
| **(b) PLLA recoil + slow resorption** | PLLA radial force 부족 + 흡수 3-4y → strut dismantling 후 strut discontinuity | late strut fracture · ISR |
| **(c) GW2 lesion prep 부족** | aggressive predilation / 1:1 sizing / post-dilation 부재 | mal-apposition + edge dissection |
| **(d) suboptimal sizing** | small vessel (<2.5 mm) 적용 → strut/lumen ratio 악화 | small vessel 환자에서 ST/TLF spike |

→ post-hoc 분석: **2.5 mm 이상 + GW2 적용** 시 TLF 차이 축소 — 그러나 **재료 자체의 thick strut가 본질적 wall** → 1세대 PLLA = 사실상 사망.

### 2.4 d2 wall 분석 — PLLA의 본질적 한계

PLLA는 radial force/두께 trade-off의 물리적 한계:
- thin strut (≤100 µm) → 강도 부족 → 늦은 recoil
- thick strut (≥150 µm) → 강도 OK but flow 교란
→ **재료 변경 없이는 돌파 불가** (M3 비-mTOR coating으로도 보완 한계).

---

## 3. 2세대 폴리머 BRS 시도

| Scaffold | 제조사 | 재료 | strut (µm) | 약물 | resorption | 임상 status (2026) |
|---|---|---|---|---|---|---|
| **DESolve** | Elixir | PLLA + novolimus | 100-150 | novolimus | 1-2y | EU CE — 제한적, US 미진입 |
| **MeRes100** | Meril (인도) | PLLA | 100 | sirolimus | 2-3y | India 승인 · MeRes-1 trial OK |
| **NeoVas** | Lepu (중국) | PLLA + sirolimus | 170 | sirolimus | 3y | NMPA 승인 (CN) · CN registry |
| **Firesolve** | MicroPort (중국) | PLLA + 박형 polymer | 100-120 | sirolimus | 2-3y | CN 등록 · FUTURE-II |
| **MAGNITUDE** | Reva (Mg-PLLA hybrid) | tyrosine polymer + Mg | 95-120 | sirolimus | 1-2y | Ph1/2 stopped (재정 이슈) |
| **Fantom Encore** | Reva | tyrosine polycarbonate | 95 | sirolimus | 3y | EU CE — 좁은 사용 |

→ **공통**: strut을 100 µm 이하로 박형화 · 흡수 1-2y 단축 · sirolimus/novolimus 사용. EU/CN 시장만, US/Korea 진입 제한.

---

## 4. Mg 합금 BRS — Magmaris / Freesolve (Biotronik)

### 4.1 1세대 Magmaris (2016 EU CE)

| 항목 | Magmaris (DREAMS 2G) |
|---|---|
| 재료 | Mg WE43 합금 + PLLA-sirolimus 코팅 |
| strut 두께 | **150 µm** (1세대 PLLA와 유사) |
| radial force | **DES 수준** (Mg 합금이 강함) |
| 흡수 기간 | **12개월** (PLLA 대비 1/3) |
| 약물 | sirolimus 1.4 µg/mm² |

### 4.2 2세대 Freesolve (DREAMS 3G, 2024 CE)

| 항목 | Freesolve |
|---|---|
| 재료 | Mg + 박형 BIOlute (sirolimus elution) |
| strut 두께 | **99-117 µm** (1세대 박형화) |
| radial force | 향상 (alloy 조성 개선) |
| 흡수 기간 | 12개월 |

### 4.3 BIOSOLVE-IV (Magmaris registry, n>1000)

| Endpoint @ 12m | 값 |
|---|---|
| TLF | 4.3-5.9% |
| definite/probable scaffold thrombosis | **0.5%** (← Absorb 1.9% 대비 ↓) |
| TLR | 3.6% |
| cardiac death | 0.8% |

→ **DES 수준 안전성** (small/non-complex lesion 한정).

### 4.4 BIOSOLVE-V (Freesolve, 2024)

초기 데이터에서 1y TLF 2.6%, scaffold thrombosis 0% (n=150, small cohort) → **promising but 표본 작음**.

### 4.5 Mg BRS 장점 vs 한계

| 장점 | 한계 |
|---|---|
| rapid resorption 12m (vs PLLA 36-48m) | **hydrogen gas release** (Mg corrosion: Mg + 2H₂O → Mg(OH)₂ + H₂↑) |
| radial force DES 수준 | local pH 상승 (alkaline) → endothelial dysfunction 가능 |
| less thrombogenic (Mg ion antithrombotic 가설) | corrosion 부산물 (Mg(OH)₂, MgO, MgCl₂) tissue clearance 메커니즘 미확립 |
| imaging artifact 더 적음 | **ISR 데이터 한정** — large/complex lesion · 장기 follow-up 부재 |
| no PLLA recoil | alloy 조성 standardization 미정 |

→ **Mg 합금이 현 시점 BRS leader** — but `M7 safety` (hydrogen · Mg byproduct) deferred.

---

## 5. Zn 합금 BRS — emerging (2026 시점 전임상-임상 cusp)

### 5.1 Zn의 매력 — Mg/Fe의 중간

| 재료 | 부식 속도 | 강도 | 임상 status |
|---|---|---|---|
| **Mg** | **빠름** (3-12m) | 중간 (alloy로 보강) | Magmaris/Freesolve 시판 |
| **Zn** | **중간** (12-24m 추정) | 중간-높음 (Zn-Cu, Zn-Mg, Zn-Li alloy) | 전임상 · 동물 · IFU first-in-man (2024-2025) |
| **Fe** | **느림** (수년) | 높음 | 부식 product 잔여 (Fe oxide) → 미해결 |

### 5.2 Zn 생물학적 역할 + mechanical balance

- **Zn 일일 섭취 ~10 mg** — biological 친화 (>2000 효소 cofactor)
- **부식 부산물 Zn²⁺** = systemic ion 풀에 자연 흡수 (hydrogen release 없음)
- **mechanical**: Mg 대비 더 강 · Fe 대비 빠른 흡수 → **두 극단의 trade-off 해소 후보**

### 5.3 주요 후보 alloy

| Alloy | 특징 | 단계 |
|---|---|---|
| **Zn-Li** | strength ↑↑ | 전임상 (porcine OK) |
| **Zn-Cu** | antibacterial + ductility | 전임상 |
| **Zn-Mg** | hybrid biodegradation | 전임상 |
| Pure Zn | reference | 동물 |

### 5.4 임상 status

2026 시점 first-in-man trial 진행중 (Lifetech 등 중국 메이커 주도), **ISR/TLF 데이터 거의 없음** → M6 시점 추론 only, 향후 M8 한국인 registry 모니터링 필요.

---

## 6. ISR 관점 잔여 wall — BRS가 ISR을 해결하는가?

### 6.1 (a) early ISR (NH) — BRS는 오히려 위험 ↑

```
   thick strut (150 µm)
        │
        ↓
   turbulent flow · mal-apposition · 늦은 EC coverage
        │
        ↓
   염증 · platelet activation · VSMC 증식 ━━━━▶ NH ↑
```

→ Absorb 사례 = thick strut → NH 위험 DES 초과. Magmaris도 1세대 strut 150 µm → 유사. Freesolve 99-117 µm로 박형화 → DES 수준 회복.

### 6.2 (b) late ISR / NA — BRS resorption 후 plaque 형성 가능

**가설**: scaffold 흡수 → vessel restored = 정상 vessel이라면 **NA가 native atherosclerosis 수준** (DES보다 ↓).
**우려**: scaffold 흡수 중간기 (6-24m)에 incomplete EC coverage → ox-LDL deposition → 신생 atheroma 가속 가능 — 데이터 부재.

### 6.3 (c) scaffold restenosis (ISR-in-BRS) — DCB 적용 hook

BRS 내부 ISR 발생 시:
- **DCB-in-BRS**: scaffold strut이 흡수중이므로 strut 추가 없이 약물 전달 가능 → **이상적 옵션** (M5 hook)
- **DES-in-BRS**: 흡수전 단계라면 strut 3겹 회피
- **DCB-in-BRS-after-resorption**: 흡수 후 native vessel에 단순 DCB → 가장 깔끔

→ **BRS + DCB combination = ISR 재시술의 미래 비전** (M5 연결 강함).

### 6.4 종합 — BRS가 ISR을 줄이는가?

| 시점 | BRS vs DES | 평가 |
|---|---|---|
| 0-1y (early NH) | 동등 ~ 열등 | thick strut 위험 (Freesolve로 완화 진행) |
| 1-3y | 동등 | resorption 중 — 미해결 영역 |
| 3-10y (late NA) | **잠재적 우위** | vessel restored → NA 자연사 회복 가설 |

→ **현 시점 (2026): BRS가 DES 대비 명확한 ISR 우위 미입증**. 박형화 + Mg/Zn 합금 + M3 coating combo가 차세대 hook.

---

## 7. 차세대 BRS + 약물 코팅 — M3 비-mTOR × BRS hypothesis

M3에서 도출된 5 family × BRS substrate combination 가설:

| Coating | Substrate | 가설 메커니즘 | 우선순위 |
|---|---|---|---|
| **sirolimus-Mg-BRS** (Freesolve) | Mg + BIOlute | 현행 baseline | ★★★★★ (시판) |
| **fasudil-Mg-BRS** | Mg + PLA carrier | ROCK 차단 → NH 추가 억제 + Mg vasodilatation 합세 | ★★★★ |
| **sirolimus-Zn-BRS** | Zn-Li alloy | 12-24m 흡수 · Zn ion antithrombotic + mTOR baseline | ★★★★ |
| **verteporfin-Mg-BRS** | Mg + PDLLA | YAP/TAZ 차단 → NH/NA dual + Mg synergy | ★★★ (verteporfin 광독성 hurdle) |
| **roxadustat-Zn-BRS** | Zn + biodegradable polymer | HIF-PHD → re-endothelialization + Zn 천천히 흡수 | ★★★ |
| **apabetalone-BRS combo** | Mg or Zn | BET 차단 → NA 표적 (DES 표적 외) | ★★ (분자량 큼) |
| **GLP-1R agonist-coated BRS** | local sustained release | 항-염증 · EC 보호 | ★★ (peptide 안정성 hurdle) |

→ **fasudil-Mg-BRS · sirolimus-Zn-BRS** = M4 short-list 진입 후보 (M4 milestone 입력).

---

## 8. 한계 + M7 / M8 입력

### 8.1 M7 입력 — safety / off-target

- **Mg dissolution byproduct**: hydrogen gas (local) · Mg(OH)₂ deposit · MgCl₂ ion balance — long-term safety 미확립
- **Zn ion toxicity**: high local Zn → endothelial dysfunction · cytotoxicity 가능 — dose dependent
- **late catch-up ISR**: scaffold 흡수 후 5-10y NA 신호 — registry 부재
- **PLLA 부산물**: lactic acid local pH 저하 → 염증 (Absorb의 또 다른 가설)
- **DAPT 단축 안전성**: BRS 단축 정책 RCT 부재

### 8.2 M8 입력 — 한국인 BRS 사용 현황 + registry

- **한국 BRS 사용**: Absorb 철수 후 사실상 공백 · Magmaris/Freesolve 국내 미진입 · 임상 도입 미정
- **K-DES 등 registry**: BRS 항목 부재 — M8에서 mapping 필요
- **재시술 옵션**: BRS-in-DES (BRS 흡수 후 ISR) / DES-in-BRS (BRS 흡수 전 ISR) / DCB-in-BRS 양쪽 — 한국 imaging-guided 시술 환경에서 OCT 기반 평가 가능
- **HBR 한국인 cohort**: HBR + BRS 적합성 잠재적 매력 (DAPT 단축) — registry 설계 입력

### 8.3 d2 wall 돌파 paths

| Wall | 돌파 path 1 | 돌파 path 2 |
|---|---|---|
| Mg hydrogen release | alloy 조성 (Mg-Y-Zn) tuning + ceramic surface coating | controlled corrosion kinetics by surface micro-pattern |
| Zn 임상 데이터 부재 | 전임상-임상 cusp 가속 (한국 first-in-man) | M4 short-list에 Zn substrate 명시 포함 |
| BRS-in-ISR 데이터 부재 | M8 registry 설계에 BRS 항목 추가 | OCT/IVUS imaging 기반 mechanistic cohort |
| thick strut → NH | strut 박형화 + alloy strength 동시 향상 | M3 coating으로 보완 (fasudil 등) |

---

## 9. 참고문헌

- Serruys PW et al. (2017) *NEJM* 376:1379 — ABSORB III 3-year
- Kereiakes DJ et al. (2017) *JAMA Cardiol* 2:1187 — ABSORB IV
- Stone GW et al. (2019) *Lancet* 393:1530 — ABSORB pooled meta
- Haude M et al. (2020) *Lancet* 396:875 — BIOSOLVE-IV Magmaris registry
- Verheye S et al. (2024) *EuroIntervention* — BIOSOLVE-V Freesolve early
- Bowen PK et al. (2018) *Adv Mater* 30 — Zn alloy review
- Hermawan H et al. (2021) *Acta Biomater* — biodegradable metal scaffolds
- Iqbal J et al. (2014) *Eur Heart J* 35:765 — BRS rationale + risk
- Sotomi Y et al. (2017) *JACC Cardiovasc Interv* 10:2330 — BRS thick strut hemodynamics

---

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| Absorb 실패 4원인 | 🟢 SUPPORTED-NUMERICAL | ABSORB III/IV 3y data |
| Magmaris 안전성 | 🟡 SUPPORTED-BY-CITATION | BIOSOLVE-IV registry n>1000 |
| Freesolve 우월성 | 🟠 INSUFFICIENT/DEFERRED | n=150, 1y only |
| Zn BRS 임상 | 🟠 INSUFFICIENT/DEFERRED | first-in-man 단계 |
| BRS가 ISR 줄임 | 🔴 FALSIFIED (PLLA) / 🟠 (Mg/Zn) | ABSORB III/IV TLF 11% vs 7.9% |
| M3 coating × BRS combo | ⚪ SPECULATION-FENCED | 가설 — 전임상 부재 |

🔑 핵심 통찰:
- **PLLA BRS = 사망** (thick strut + slow resorption + d2 wall = 재료 자체)
- **Mg 합금 (Magmaris/Freesolve)이 현 시점 leader** — 12m 흡수 + DES 수준 thrombosis rate
- **Zn 합금 = emerging cusp** (mechanical/biodegradation balance, 임상 데이터 부재)
- **ISR 관점**: BRS가 DES 대비 명확한 ISR 우위 **미입증** (2026) → strut 박형화 + M3 비-mTOR coating combo가 차세대 돌파 path
