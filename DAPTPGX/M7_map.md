# M7 — 한국인 PCI DAPT 통합 결정맵 (유전형 × 출혈위험 × 시술복잡도)

> 마일스톤 M7 산출물 · current-state · no history.
> 종합 = M1 (allele) + M2 (active AUC · PRU) + M3 (3제 switch) + M4 (PRECISE-DAPT · ARC-HBR) + M5 (PFT) + M6 (selatogrel · vicagrel · revacept).
> 위치 = 한국인 PCI 환자 (ACS · elective 모두) · 시점 = cath-lab → 12mo chronic phase.
> 등급 = 🟡 SUPPORTED-BY-CITATION (cell-level 권고는 RCT 직접 적용 가능 cell만 🟡, 나머지는 🟠).

---

## §1. 3-axis decision space (ASCII cube)

```
            z = 시술 복잡도
            ┌──────────────────────────────────┐
            │   LMCA / multi-vessel            │
            │     ┌─────────────────────┐      │
            │     │ STEMI primary       │      │
            │     │   ┌────────────────┐│      │
            │     │   │ complex PCI    ││      │
            │     │   │   ┌───────────┐││      │
            │     │   │   │simple PCI │││      │
            │     │   │   └───────────┘││      │
            │     │   └────────────────┘│      │
            │     └─────────────────────┘      │
            └──────────────────────────────────┘
                        │
                        │
   y = HBR              │              x = CYP2C19 phenotype
   ───────              │              ──────────────────────
                        │
   HIGH (ARC-HBR ⊕)   ▲ │                NM/RM  IM   PM
                      │ │                  │    │     │
   INT (≥1 minor)     │ │                  │    │     │
                      │ │                  │    │     │
   LOW                └─┴──────────────────┴────┴─────▶
                       (0,0,0)

  Cube 총 cell = 3 (x) × 3 (y) × 3 (z, simple/complex/STEMI 통합)
              = 27 cell + LMCA/multi-vessel layer (별도 modifier)
```

- **x-axis** (M1): NM/RM (~33명/100) · IM (~45명) · PM (~15명) — 한국인 PCI 분포
- **y-axis** (M4): LOW (~50명) · INT (~25명, 1 ARC-HBR minor 또는 PRECISE-DAPT 15-24) · HIGH (~25명, ARC-HBR ⊕ 또는 PRECISE-DAPT ≥25)
- **z-axis**: simple PCI (~50명, single vessel · non-DES bifurcation 없음) · complex PCI (~30명, ≥3 stent · bifurcation · CTO) · STEMI primary (~15명) · LMCA/multi-vessel modifier (~5명, complex의 subset로 z layer 추가)

→ 27 cell × LMCA modifier ≈ 30+ 실용 cell. §2에서 9-cell 요약 + 27-cell 상세.

---

## §2. 3×3×3 = 27-cell 결정맵

### §2.1 9-cell 요약 (x × y, z 통합 평균)

| | **NM/RM** (~33%) | **IM** (~45%) | **PM** (~15%) |
|---|---|---|---|
| **HBR-HIGH** (~25%) | clopi 75 / **3-6mo** / PFT 선택 | clopi 75 / **3-6mo** / PFT 선택 | ★ clopi 75 / **3-6mo** / **PFT 의무 1mo** (★high-stakes) |
| **HBR-INT** (~25%) | clopi 75 / 6-12mo / no PFT | clopi 75 / 6-12mo / PFT 의심 시 | **prasugrel 5mg** / 6-12mo / PFT day 14 |
| **HBR-LOW** (~50%) | clopi 75 / **12mo** / no PFT | **prasugrel 5mg** / 12mo / 1mo de-escalation 옵션 | **prasugrel 5mg** or ticagrelor 90bid / 12mo / PFT 보조 |

→ **clopi-based ≈ 5 cell (NM 3개 + HBR-HIGH 행 전체)** / **prasugrel-based ≈ 4 cell** (한국 5mg) / **ticagrelor = PM × HBR-LOW에서만 옵션 (TICAKOREA 출혈 시그널 회피)**.

### §2.2 27-cell 전체표 (x × y × z)

표기: `약제 · loading · maintenance · DAPT기간 · PFT여부`

#### z = simple PCI (~50명/100)

| | NM/RM | IM | PM |
|---|---|---|---|
| HBR-HIGH | clopi · 300mg · 75mg · **3mo** · PFT 선택 | clopi · 300mg · 75mg · **3mo** · PFT 선택 | ★ clopi · 600mg · 75mg · **3mo** · **PFT 1mo 의무** |
| HBR-INT | clopi · 300mg · 75mg · 6mo · ✗ | clopi · 300mg · 75mg · 6mo · day 14 선택 | prasug · 20mg · **5mg** · 6mo · day 14 |
| HBR-LOW | clopi · 300mg · 75mg · **12mo** · ✗ | prasug · 20mg · 5mg · 12mo · 1mo de-esc 옵션 | prasug · 20mg · 5mg · 12mo · ✗ |

#### z = complex PCI (~30명/100, ≥3 stent · bifurcation · CTO)

| | NM/RM | IM | PM |
|---|---|---|---|
| HBR-HIGH | clopi · 600mg · 75mg · **3-6mo** · PFT 권고 | clopi · 600mg · 75mg · **3-6mo** · PFT 권고 | ★★ clopi · 600mg · 75mg · **6mo** · **PFT 1mo + 3mo** + 잔존 PRU>280 → 신약 (vicagrel 가용 시) 또는 ticag 60mg |
| HBR-INT | clopi · 600mg · 75mg · 12mo · day 14 선택 | prasug · 20mg · 5mg · 12mo · day 14 | prasug · 20mg · 5mg · 12mo · PFT 의무 |
| HBR-LOW | prasug · 20mg · 5mg · 12mo · ✗ | prasug · 20mg · 5mg · **12mo (de-esc 비권고)** · ✗ | prasug · 20mg · 5mg · 12mo · PFT 보조 |

#### z = STEMI primary (~15명/100)

| | NM/RM | IM | PM |
|---|---|---|---|
| HBR-HIGH | clopi · 600mg · 75mg · 6mo · PFT 1mo | prasug · 20mg · 5mg · 6mo · PFT 1mo (출혈 vs 허혈 weighted) | ★ prasug · 20mg · 5mg · **6mo** · **PFT 1mo 의무** |
| HBR-INT | prasug · 20mg · 5mg · 12mo · ✗ | prasug · 20mg · 5mg · 12mo · 선택 | prasug · 20mg · 5mg · 12mo · PFT 의무 |
| HBR-LOW | prasug · 20mg · 5mg · 12mo · ✗ | prasug · 20mg · 5mg · 12mo · ✗ | **prasug · 20mg · 5mg** · 12mo · ✗ (selatogrel 도입 후: prehospital SC bridge → 표준 진입) |

#### LMCA/multi-vessel modifier (~5명/100, 어느 z에서든 추가)

→ 모든 cell에서 **DAPT 기간 +3-6mo · 강력제 선호 · PFT 1mo + 6mo 의무** (z layer를 complex 이상으로 격상).

---

## §3. Critical cells 5개 deep dive

### §3.1 **PM × HBR-HIGH × complex PCI** (~3-5명/100) — ★ Apex high-stakes cell

```
환자 프로파일
─────────────
  CYP2C19 *2/*2 (또는 *2/*3 · *3/*3)
  + ARC-HBR ⊕ (예: Hb 10.5 + eGFR 28)
  + complex (3-stent bifurcation, LAD-D1)
  → 출혈 + 허혈 dual jeopardy 정점
  → 1y MACE 예측 ~15-20% · 1y BARC ≥3 ~10-12%
```

**약제 / 시간축**

| 시점 | 권고 | 근거 |
|---|---|---|
| Day 0 LD | **clopidogrel 600 mg LD** (prasugrel ICH ↑, ticagrelor 출혈 ↑ 회피) | TRITON 5번 금기 + TICAKOREA |
| Day 0-24h | **clopi 75 mg** maintenance + UFH/bivalirudin standard | KSC 2024 |
| Day 1-7 | clopi 75 + ASA 100, **Hb 일일 모니터** | ARC-HBR HIGH 표준 |
| Day 14 | **PFT (VerifyNow PRU) #1** — PRU >280 시 신중 escalation (vicagrel 가용 시 1:1 대체 우선, 미가용 시 ticagrelor 60mg bid 감량) | M5 + Working Group 2013 |
| Month 1 | **PFT #2 + Hb · Cr · BARC 평가** — PRU 정상화 OK 시 유지 / 잔존 HTPR + 출혈 stable 시 신약 검토 | TROPICAL-ACS 개념 응용 |
| Month 3 | **DAPT 종료 → clopi 단독** (HOST-EXAM 적용) | HOST-EXAM HR 0.73 |
| Month 6 | clopi 단독 유지 + 임상 follow | — |
| Month 12 | clopi 단독 유지 (lifelong 가능) | HOST-EXAM 24mo extension |

**Monitoring**: 1mo · 3mo · 6mo · 12mo Hb · 신기능 · BARC bleeding diary · 재발 ACS 증상 시 즉시 응급실.

### §3.2 **PM × HBR-LOW × STEMI primary** (~7-8명/100)

```
환자 프로파일
─────────────
  CYP2C19 *2/*2 + Hb 13.5 + eGFR 75 + 60세 + STEMI LAD
  → 골든타임 IPA 확보가 생명선
  → 1y MACE 예측 ~8-12% · 1y BARC ≥3 ~3-5%
```

**약제 / 시간축**

| 시점 | 권고 |
|---|---|
| Prehospital (EMS) | **현재**: PCI center 이송 + 응급실 LD · **미래 (selatogrel 도입 후)**: SC selatogrel 16 mg auto-injector (30분 peak IPA >90%, CYP genotype 무관) |
| Cath-lab door | prasugrel 60 mg LD (≥75세 아님 + ≥60kg 가정) — **PM이므로 clopidogrel 회피** |
| Day 0-24h | prasugrel **5 mg** (한국인 dose) maintenance + ASA |
| Day 1-30 | 5mg 유지 · in-hospital MACE/bleeding 모니터 |
| Month 1 | (HBR-LOW이므로) 5mg 유지 — de-escalation 비권고 (PM이라 clopi switch 시 IPA 손실 위험) |
| Month 6 | 평가 — 안정 시 12mo까지 5mg |
| Month 12 | DAPT 종료 · clopi 단독 (HOST-EXAM) **but PM에선 clopi 단독도 PRU 우려** → ASA 단독 또는 clopi 단독 선택 시 6mo PFT 확인 |

**Monitoring**: PFT 1mo 권고 (de-escalation 결정 보조), 출혈 event 시 즉시 평가.

### §3.3 **IM × HBR-INT × simple PCI** (~15명/100) — 가장 흔한 cell

```
환자 프로파일
─────────────
  CYP2C19 *1/*2 + 70세 (ARC-HBR minor 1개)
  + single-vessel RCA · DES 1개
  → 한국 PCI 환자의 가장 흔한 중간형 cell
  → 1y MACE 예측 ~5-7% · 1y BARC ≥3 ~3-4%
```

**약제 / 시간축**

| 시점 | 권고 |
|---|---|
| Day 0 LD | **clopi 300mg** LD (HIR 없음 + HBR INT → 강력제 net benefit 미달) |
| Day 0-30 | clopi 75mg + ASA |
| Month 1 | 임상 평가 — 무사 시 유지 |
| Month 6 | **DAPT 종료 옵션** (HBR-INT + simple PCI · KSC 2024 6mo OK) |
| Month 6-12 | clopi 단독 (HOST-EXAM 적용) |
| Month 12+ | clopi 단독 lifelong |

**Monitoring**: PFT는 routine 아님. 재발 ACS 또는 stent thrombosis 의심 시만.

### §3.4 **NM × HBR-HIGH × complex PCI** (~5명/100)

```
환자 프로파일
─────────────
  CYP2C19 *1/*1 + 78세 + eGFR 35 + 3-stent bifurcation
  → 약리는 normal but 환자가 fragile
  → 1y MACE 예측 ~7-9% · 1y BARC ≥3 ~7-9%
```

**약제 / 시간축**

| 시점 | 권고 |
|---|---|
| Day 0 LD | clopi 600 mg LD (HBR-HIGH라 강력제 회피) |
| Day 0-30 | clopi 75 + ASA |
| Month 1 | PFT 권고 (NM이라도 환경 변수: PPI · 신기능 · 약물상호작용) — PRU 정상 (85-208) 확인 |
| Month 3-6 | **DAPT 종료 → clopi 단독** (3-6mo는 complex PCI에서 boundary; HBR-HIGH 우위로 6mo 선호) |
| Month 6-12 | clopi 단독 |

**Monitoring**: 출혈 minor event도 즉시 보고 (DAPT 단축 trigger).

### §3.5 **RM × HBR-LOW × STEMI primary** (~2명/100) — 드문 cell

```
환자 프로파일
─────────────
  CYP2C19 *1/*17 (한국인 RM ~1%, STEMI subset 합산 ~2명)
  + Hb 14 + eGFR 90 + 50세 + STEMI inferior
  → active metabolite ↑ → 출혈 risk asymmetric ↑
  → 1y MACE 예측 ~3-5% · 1y BARC ≥3 ~5-7%
```

**약제 / 시간축**

| 시점 | 권고 |
|---|---|
| Day 0 LD | clopi 600mg LD or prasugrel 60mg (STEMI · HIR ⊕) — RM이므로 clopi도 정상 작동 |
| Day 0-30 | clopi 75mg + ASA (출혈 모니터링 강화) |
| Month 1 | **PFT 권고** — PRU <85 (LTPR) 시 ASA 단독 또는 clopi 격일 검토 (근거 약함, individualized) |
| Month 6-12 | DAPT 12mo + de-escalation 보수적 |

**Monitoring**: 출혈 빈도 ↑ 우려 (RM 자체 + STEMI dose) — monthly Hb · BARC.

---

## §4. 시간축 결정 트리 ASCII (acute → chronic 12mo)

```
시간   │ 0h    24h    7d    14d    1mo    3mo    6mo    12mo    24mo+
═══════╪══════════════════════════════════════════════════════════════════
       │
NM/RM  │ clopi LD → clopi 75 ──────────────────────────►│ HOST-EXAM
       │   (NM-HBR-LOW 12mo · NM-HBR-HIGH 3-6mo)        │ clopi 단독
       │                                                  │
       │
IM     │ clopi LD or prasug 5mg ──┐
       │   (HBR-INT/HIGH → clopi) │
       │   (HBR-LOW → prasug 5mg) │
       │                          ├─── 1mo PFT 검토 ─────┤
       │                          │   ↓                  │
       │                          │   normal PRU         │
       │                          │   → 유지             │
       │                          │   ↓                  │
       │                          │   HTPR → escalation  │
       │                          └─────────────────────►│ HOST-EXAM
       │                                                  │ clopi 단독
       │
PM     │ ★ phenotype branching ★
       │
       │ HBR-LOW + STEMI/HIR: prasug 5mg or ticag ──────►│ 12mo 유지 → ASA/clopi 단독
       │   (selatogrel 미래: prehospital SC bridge)        │
       │
       │ HBR-HIGH + complex: clopi 600 LD → 75mg
       │                       │
       │                       ├── Day 14: PFT #1
       │                       │     ↓
       │                       │     PRU>280 → ★ escalation 신중 ★
       │                       │     ↓
       │                       │     vicagrel 가용 → 1:1 대체 (미래)
       │                       │     vicagrel 미가용 → ticag 60mg bid
       │                       │
       │                       ├── Month 1: PFT #2 + Hb/Cr
       │                       │
       │                       ├── Month 3: DAPT 종료 → clopi 단독
       │                       │   (HOST-EXAM 우위)
       │                       │
       │                       └── Month 6/12: 평가 + lifelong clopi 단독
       │
═══════╪══════════════════════════════════════════════════════════════════
       │
공통    │ 출혈 event 발생 시 모든 phenotype:
이벤트  │   - BARC 1-2 → 약제 유지, PPI 추가
대응    │   - BARC 3a → DAPT 일시 중단 또는 단축, GI 평가
       │   - BARC 3b/3c (major) → DAPT 중단, hemostasis, 재시작 판단 (HBR upgrade)
       │   - BARC 5 (fatal) → autopsy/case review
```

→ **시간축 trigger 4개**: (i) acute LD 시점 약제 선택, (ii) Day 14 PFT (PM × HBR-HIGH only), (iii) Month 1 de-escalation (IM/PM × HBR-LOW), (iv) Month 3-12 HOST-EXAM clopi 단독 전환.

---

## §5. 모니터링 알고리즘

### §5.1 PFT 시행 기준 (M5 통합)

| Cell | PFT 시점 | 목적 | 행동 trigger |
|---|---|---|---|
| **PM × HBR-HIGH × complex** ★ | Day 14 + Month 1 + Month 3 | HTPR 잔존 → escalation 신중 결정 | PRU >280 → vicagrel/ticag60mg ; PRU 85-208 → 유지 ; PRU <85 → DAPT 단축 |
| PM × HBR-HIGH × simple/STEMI | Month 1 | 잔존 HTPR 판단 | 동상 |
| IM × any × any (강력제 시작자) | Day 14 또는 Month 1 | de-escalation 안전성 (TROPICAL-ACS 방식) | PRU <208 → clopi switch OK ; ≥208 → 강력제 유지 |
| NM × HBR-HIGH × complex | Month 1 (선택) | 환경 변수 (PPI · 약물상호작용) 영향 | 동상 |
| RM/UM | Month 1 | LTPR (출혈 risk) 확인 | PRU <85 → 감량 검토 |
| NM/IM × HBR-LOW × simple | ✗ (routine 아님) | — | — |

→ **routine PFT는 ‘PM × HBR-HIGH’ + ‘강력제 de-escalation 후보’ 두 시나리오에 집중**. 나머지는 임상 indication 발생 시만 (재발 ACS · stent thrombosis 의심 · 약물상호작용 · 효과 의심).

### §5.2 Genotype re-test

- **원칙: 평생 1회 (once-in-lifetime)** — CYP2C19 genotype은 germline 변이라 평생 불변
- PCI 첫 입원 시 POC genotyping (Spartan RX · Genomadix Cube · 1h TAT) 권고 (M5 §8)
- EMR에 영구 기록 → 재시술/재입원 시 즉시 활용
- **예외**: 골수이식 환자 (donor genome 변경) — 이식 후 re-test
- → re-test 비권고 = 비용 ↓ + 결정 단순화

### §5.3 임상 follow-up 스케줄

| 시점 | 평가 항목 |
|---|---|
| Day 7-14 (외래 1차) | wound · 약물 compliance · BARC bleeding diary 시작 |
| Month 1 | Hb · Cr · BARC 누적 · symptom (재발 ACS · 호흡곤란 [ticag] · 멍 빈도) · ECG · (cell별) PFT |
| Month 3 | 동상 + DAPT 단축 결정 (HBR-HIGH cell) |
| Month 6 | 동상 + de-escalation 결정 (HBR-LOW/INT IM/PM) |
| Month 12 | 동상 + DAPT 종료 + clopi 단독 (HOST-EXAM) |
| Month 24, 36 | clopi 단독 평가 + 재시술/MACE/major bleeding event 누적 |

**즉시 외래/응급 trigger**: BARC ≥2 출혈 · 흉통 재발 · 호흡곤란 (ticag) · 새 vascular event.

---

## §6. 신약 통합 미래 결정맵 (5-10y timeline · M6 통합)

### §6.1 vicagrel 도입 (KFDA ~2026-2028 예상)

```
                  현재 (2026)              vicagrel 도입 후 (~2028)
                  ──────────────           ─────────────────────
PM × HBR-LOW    : prasug 5mg / ticag      → **vicagrel 1:1 대체 1차** (CES1 우회)
                                            prasug 5mg 2차 (출혈 ↑ 환자)

PM × HBR-HIGH   : clopi + PFT             → **vicagrel** + PFT (clopi 대비 IPA 우위 + 출혈 동등)
                                            잔존 HTPR 시 ticag 60mg

IM × HBR-LOW    : prasug 5mg              → vicagrel (저비용 + 1×/d) or prasug 5mg
```

→ **임팩트**: 한국인 PCI 100명 중 ~60명 (IM+PM)이 vicagrel 후보. 결정맵의 약제 분포가 prasugrel/ticagrelor 비중 ↓ → vicagrel 비중 ↑로 재편.

### §6.2 selatogrel 도입 (KFDA ~2028-2030 예상)

```
시나리오: STEMI prehospital
────────────────────────────
EMS 도착 (증상 30min) → SC selatogrel 16mg auto-injector
                       (30분 peak IPA >90%, CYP genotype 무관)
                       │
                       ↓
cath-lab 도착 (증상 90min) → PCI + 표준 P2Y12 LD 진입
                              │
                              ├─ NM/RM → clopi 600 LD
                              ├─ IM → prasug 60 LD (한국 5mg MD)
                              └─ PM → prasug 60 LD or vicagrel LD
                              │
                              ↓
                       유지요법 진입 (M3 phenotype branching)
```

→ **임팩트**: STEMI (한국 PCI 100명 중 ~15명) 모두에 prehospital bridge. PM phenotype의 “골든타임 IPA 미달” 문제를 selatogrel이 약제 그 자체로 해결. EMS-병원 연계 protocol 정비 필요.

### §6.3 revacept 도입 (~2029-2032, very-HBR add-on niche)

```
시나리오: very-HBR + 잔존 허혈 risk (예: PM × ARC-HBR major 2개 + complex)
─────────────────────────────────────
PCI 직전 또는 직후 IV revacept (80-160 mg single)
+ 표준 DAPT 단축 (1-3 mo)
→ lesion-selective collagen 차단 → systemic platelet 보존 → 출혈 ↓
→ DAPT 단축의 허혈 cost 일부 보상
```

→ **임팩트**: 매우 좁은 niche (~1-2명/100). ISAR-PLASTER-stroke + 후속 PCI study readout 의존. 결정맵의 “very-HBR + 허혈 잔존” cell에 add-on 옵션 추가.

### §6.4 5-10y 결정맵 evolution timeline

| 연도 | 주요 변화 | 결정맵 영향 |
|---|---|---|
| 2026 (현재) | 3제 + 한국 5mg prasug | clopi-first (~57%) · prasug 5mg (~42%) · ticag 한정 |
| 2027 | SOS-AMI selatogrel readout · TAILOR-PCI extension | genotype-guided 근거 강화 |
| 2028 | vicagrel KFDA 진입 (예상) | PM cell 약제 분포 재편 (~15%가 vicagrel) |
| 2029 | selatogrel KFDA 진입 (예상) | STEMI prehospital 표준화 (~15%) |
| 2030 | revacept reposition + PAR-4 antagonist 초기 진입 | very-HBR niche + 새 PGx 축 (PAR-4 rs773902) |
| 2032 | 4-약제 통합 매트릭스 + AI 결정 지원 | 결정맵이 cube → tesseract (4D) 확장 |

---

## §7. 결정맵 KPI — 한국인 PCI 100명 적용 시 예상 outcome

### §7.1 Baseline (no PGx 결정맵 · clopidogrel one-size-fits-all)

| Outcome (1y) | 발생률 | 절대 인원 (100명 중) |
|---|---|---|
| Stent thrombosis (definite/probable) | ~1.5-2.0% | 1-2명 |
| MACE (CV death/MI/stroke) | ~7-8% | 7-8명 |
| Major bleeding (BARC 3-5) | ~4-5% | 4-5명 |

(KAMIR-NIH 5yr · K-ACTIVE baseline 추정)

### §7.2 M7 결정맵 적용 시 예상

| Outcome (1y) | 예상 발생률 | 절대 인원 | Δ vs baseline | 근거 (M2-M5 HR 곱) |
|---|---|---|---|---|
| Stent thrombosis | ~1.0-1.3% | 1명 | **↓ ~30-35%** | M2: PM × clopi avoidance → HR 3.97 → 1.0 (-75% in PM cell ~15명) · IM cell 부분 ↓ |
| MACE | ~5.5-6.5% | 5-6명 | **↓ ~20-25%** | M2: PM/IM escalation HR 0.70-0.81 (TRITON 적용) · HOST-REDUCE de-esc HR 0.70 |
| Major bleeding (BARC 3-5) | ~3.0-3.5% | 3-4명 | **↓ ~25-30%** | M3/M4: HBR-HIGH 단축 (3-6mo) · 한국 5mg prasug · TICAKOREA 회피 · HOST-EXAM clopi 단독 |

→ **순임팩트 (100명 기준 연간)**: ST 1명 회피 + MACE 1-2명 회피 + major bleeding 1-2명 회피. NNT ~50-100명 (event-level), 비용 효과는 별도 분석.

### §7.3 vicagrel/selatogrel 도입 후 (2030 추정)

| Outcome (1y) | 예상 발생률 | Δ vs M7-only |
|---|---|---|
| ST | ~0.8-1.0% | ↓ 추가 ~15-20% (PM cell vicagrel 효과 + STEMI selatogrel) |
| MACE | ~4.5-5.5% | ↓ 추가 ~15% |
| Major bleeding | ~2.5-3.0% | ↓ 추가 ~10-15% |

**누적 (baseline vs 2030)**: ST ~50%, MACE ~35%, major bleeding ~40% 감소 추정 (🟠 시뮬레이션, RCT 검증 필요).

---

## §8. 실시간 구현 workflow

### §8.1 POC genotyping

| 시스템 | 시간 | 변이 cover | 한국 도입 |
|---|---|---|---|
| **Spartan RX CYP2C19** | ~60 min | `*2` `*3` `*17` | 일부 대학병원 (서울대 등) |
| **Genomadix Cube** | ~60 min | `*2` `*3` `*17` | 검토 중 |
| 표준 PCR (lab-based) | 2-4 h | `*2` `*3` `*17` + 확장 | 광범위 |
| NGS panel (확장) | 1-3 d | 전체 CYP2C19 + ABCB1 + 기타 PGx | 연구 / 정밀의료 트랙 |

→ **PCI workflow에 통합**: cath-lab 도착 → 채혈 → POC 1h → 응급 PCI 종료 후 결과 활용 (M3 약제 결정). STEMI primary는 LD 우선 + 결과 도착 후 maintenance switch.

### §8.2 EMR integration + CDS alert

```
patient admit (ACS)
        │
        ↓
[EMR auto-trigger]
        │
        ├─ CYP2C19 genotype request (POC 또는 lab)
        ├─ HBR auto-calculation (Hb · Cr · age · prior bleed pull from EMR)
        ├─ ARC-HBR checklist (manual + auto)
        └─ ischemic risk auto (multivessel · DM · prior MI flag)
        │
        ↓
[CDS engine 실행]
        │
        ↓
[권고 cell 표시]
        │
        ├─ "PM × HBR-HIGH × complex → clopi 600 LD + PFT Day 14"
        ├─ 근거 RCT 인용 (TRITON · HOST-EXAM · HOST-REDUCE)
        └─ 의사 override 옵션 + 사유 기록
        │
        ↓
[order set 자동 제안]
        │
        ├─ 약제 + dose
        ├─ DAPT 기간 (default + 단축 옵션)
        ├─ PFT 예약 (cell 매칭 시)
        └─ follow-up 일정
```

### §8.3 환자 카드 (patient-facing)

```
┌────────────────────────────────────────────────────┐
│  DAPT-PGx 환자 카드 (Wallet card)                  │
├────────────────────────────────────────────────────┤
│  이름: ___________________________                  │
│  CYP2C19 genotype: __________ (예: *2/*2)           │
│  Phenotype: ☐ NM  ☐ RM  ☐ IM  ☐ PM  ☐ UM           │
│                                                     │
│  현재 약제: __________________________              │
│    Loading 일자: ____________                       │
│    DAPT 종료 예정: ____________                     │
│                                                     │
│  주의 약물 (CYP2C19 영향):                          │
│    - PPI (omeprazole · esomeprazole) 우려           │
│    - SSRI (fluvoxamine) 우려                        │
│                                                     │
│  응급 시 알릴 정보:                                  │
│    - "P2Y12 차단제 복용 중 — 출혈위험 높음"          │
│    - 수술 시 hold 기간: clopi 5d / prasug 7d / ticag 3-5d │
│                                                     │
│  주치의 연락: ____________                          │
└────────────────────────────────────────────────────┘
```

→ **once-in-lifetime genotype** 카드 → 재입원/응급실 즉시 활용 + 환자 이동성 보장.

---

## §9. 참고문헌 (M1-M6 통합 요약)

- M1: Lee CR 2022 *CPT* CPIC update · Park KW 2020 *Lancet* TICAKOREA · Kim HS 2020 *JAMA Cardiol* HOST-EXAM
- M2: Mega 2009 *NEJM* / 2010 *JAMA* · Shuldiner 2009 *JAMA* PRU · Park KW 2017 *EHJ* HOST-RP-ACS
- M3: Wiviott 2007 TRITON · Wallentin 2009 PLATO · Park KW 2020 TICAKOREA · Sibbing 2017 TROPICAL-ACS · Kim HS 2021 HOST-REDUCE
- M4: Costa 2017 PRECISE-DAPT · Baber 2016 PARIS · Urban 2019 ARC-HBR · Choi 2019 KAMIR · Yoon 2021 K-ACTIVE
- M5: Tantry 2013 PRU consensus · Claassens 2019 POPular Genetics · Pereira 2020 TAILOR-PCI · Galli 2022 *Lancet* meta
- M6: Sinnaeve 2020 selatogrel · Mayer 2021 revacept ISAR-PLASTER · Jiang 2017 vicagrel · Li 2020 vicagrel CYP2C19-independent
- 가이드라인: ESC 2023 (Byrne) · ACC/AHA 2025 (Rao) · KSC 2024 · CPIC 2022

---

## §10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| 3-axis cube 구조 (phenotype × HBR × 시술복잡도) | 🟡 SUPPORTED-BY-CITATION | M1 + M4 + KSC 2024 시술분류 |
| 9-cell 요약 (x × y) | 🟡 SUPPORTED-BY-CITATION | M3 결정 트리 직접 적용 |
| 27-cell 상세 (z 추가) | 🟠 INSUFFICIENT/DEFERRED | z layer는 RCT subgroup 외삽 (직접 RCT 부족) |
| PM × HBR-HIGH × complex deep dive | 🟡 SUPPORTED-BY-CITATION | TICAKOREA + HOST-EXAM + Mega 2010 메타 |
| PM × HBR-LOW × STEMI deep dive | 🟡 SUPPORTED-BY-CITATION | TRITON STEMI + 한국 5mg PRASFIT |
| IM × HBR-INT × simple deep dive | 🟡 SUPPORTED-BY-CITATION | HOST-EXAM + KSC 2024 |
| NM × HBR-HIGH × complex deep dive | 🟡 SUPPORTED-BY-CITATION | HOST-EXAM + ARC-HBR consensus |
| RM × HBR-LOW × STEMI deep dive | 🟠 INSUFFICIENT/DEFERRED | RM 한국인 빈도 < 1%, RCT subset 부족 |
| 시간축 결정 트리 (acute → 12mo) | 🟡 SUPPORTED-BY-CITATION | TROPICAL-ACS + HOST-REDUCE + HOST-EXAM |
| PFT 시행 cell 매핑 | 🟡 SUPPORTED-BY-CITATION | M5 + Working Group 2013 |
| Genotype once-in-lifetime | 🟡 SUPPORTED-BY-CITATION | germline 원칙 |
| vicagrel/selatogrel/revacept 미래 cell | 🟠 INSUFFICIENT (가설) | M6 임상 진행 중 · head-to-head 부재 |
| 100명 코호트 outcome 추정 | 🟠 INSUFFICIENT/DEFERRED | M2-M5 HR 곱 추정 · KAMIR-NIH baseline + 시뮬레이션 |
| 2030 누적 50%/35%/40% 감소 | ⚪ SPECULATION-FENCED | 신약 readout + KFDA + 실제 도입 의존 |
| EMR CDS workflow | 🟡 SUPPORTED-BY-CITATION | CPIC implementation guidance + IGNITE network 사례 |

---

## 🔑 핵심 통찰 — 결정맵의 unique value vs 서양 표준 (5 bullets)

- **한국인 60% IM+PM이 결정맵의 정당성 그 자체** — 서양 cohort LoF ~15% vs 한국 ~60%. ESC/ACC의 "ticagrelor-first one-size-fits-all"는 한국에서 net harm (TICAKOREA HR 2.26 출혈). M7 cube는 한국인 표현형 분포를 정면 직시한 첫 통합 결정맵.

- **"PM × HBR-HIGH × complex" 3-axis intersection이 결정맵의 critical cell (~3-5명/100)** — 9-cell 요약으로는 ~7-8명이지만 z (시술 복잡도) 축 추가 시 ~3-5명으로 좁혀짐. 이 cell이 PFT + de-escalation + 신약 (vicagrel/ticag 60mg) 모두 활용되는 결정맵 가치 최대 cell. 단일 cell에 RCT-level 의사결정 강도 집중.

- **HOST-EXAM clopi 단독이 chronic phase의 한국적 표준** — 서양은 aspirin 단독, 한국은 clopi 단독 (HR 0.73). 12mo 이후 모든 phenotype에서 clopi 단독 우위 (PM은 신중) → 결정맵의 마지막 column이 서양과 분기. 한국이 evidence-leading 영역.

- **시간축 trigger 4개로 결정맵을 단순화 가능** — 27-cell 복잡도를 4개 시점 (acute LD · Day 14 PFT · Month 1 de-esc · Month 3-12 HOST-EXAM)으로 압축. 임상의 인지부하 ↓ + EMR CDS 통합 용이. 결정맵의 implementability 핵심.

- **신약 도입은 결정맵을 단순화 (not 복잡화)** — vicagrel (PM 1:1 대체) · selatogrel (STEMI prehospital 표준화) 도입 시 PM cell의 약제 분기 ↓ + STEMI의 phenotype branching ↓. 5-10y 후 결정맵은 cube에서 4D tesseract로 확장하나 cell당 선택지는 ↓ — 약제 paradigm의 phenotype-strength matching이 완성형에 근접.
