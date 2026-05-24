# M15 — EMR CDS 구현 spec (한국 PCI 결정맵)

> M7 §8 cockpit + CLI+COCKPIT M5/M6/M7 spec을 한국 EMR (분당서울대 BESTCare · 서울아산 AMIS) 통합 spec.
> per @D g0 (Occam — minimal viable EMR layer) + g3 (table + ASCII) + d3 (impl code → hexa-lang stdlib).

## 1. CDS architecture overview ASCII

```
     ┌────────────────┐         ┌─────────────────┐
     │  EMR (BESTCare │   FHIR  │  CDS Hooks      │
     │  · AMIS · 등) │ ◄─────► │  service        │
     └────────┬───────┘         └────────┬────────┘
              │                          │
              │ patient context          │ verify
              │ (genotype · HBR · age)   │ resolve
              ▼                          ▼
     ┌────────────────┐         ┌─────────────────┐
     │  결정맵 cube   │ ──────► │  hexa atlas     │
     │  cell lookup   │         │  CYP2C19.*     │
     │  (PM × HBR ×  │         │  atoms          │
     │   complex)     │         └─────────────────┘
     └────────┬───────┘
              │
              ▼
     ┌────────────────────────────────────────────┐
     │ CDS card UI:                               │
     │  🔴 PM × HBR-HIGH × complex                │
     │    권장: clopi 75mg + DAPT 3-6mo           │
     │    근거: HOST-EXAM 10y · KSC 2024          │
     │    PFT: Day 14 권장                        │
     │    [Accept] [Override + reason]            │
     └────────────────────────────────────────────┘
```

## 2. CDS Hooks 표준 (HL7) 적용

| hook event | trigger 시점 | DAPTPGX 동작 |
|---|---|---|
| `patient-view` | EMR 환자 chart 열림 | genotype + HBR 자동 lookup → 배지 표시 |
| `medication-prescribe` | 의사가 P2Y12 약제 처방 | cell 매칭 → 권장/경고 카드 |
| `order-sign` | 처방 sign-off | 최종 cross-check → audit log |
| `appointment-book` | follow-up 예약 | Day 14 PFT 권장 시 자동 추가 |

각 hook = JSON request `{patient, encounter, draftOrders, fhirAuthorization}` 입력 → CDS service `{cards: [...], systemActions: [...]}` 응답.

## 3. CDS card JSON 표준 형식

```json
{
  "summary": "🔴 CYP2C19 PM × HBR-HIGH × complex PCI",
  "indicator": "warning",
  "detail": "환자는 한국 KSC 2024 권고 \"PM × HBR⊕\" critical cell에 해당. clopidogrel 75mg + DAPT 3-6mo 단축 권장.",
  "source": {
    "label": "DAPTPGX 결정맵 M7 §3 critical cell #1",
    "url": "https://github.com/dancinlab/demiurge/blob/main/DAPTPGX/M7_map.md#critical-cells",
    "icon": "https://demiurge.org/icon.png"
  },
  "links": [
    {"label": "M3 switch tree", "url": "...", "type": "absolute"},
    {"label": "M5 PFT cutoff", "url": "...", "type": "absolute"},
    {"label": "KSC 2024 가이드라인", "url": "https://kosc.or.kr/...", "type": "absolute"}
  ],
  "suggestions": [{
    "label": "clopidogrel 75mg q.d. + aspirin 100mg q.d. × 3mo",
    "uuid": "ksc-2024-pm-hbr-critical",
    "actions": [{"type": "create", "description": "clopi 처방", "resource": {...FHIR MedicationRequest...}}]
  }],
  "overrideReasons": [
    {"code": "patient-preference", "display": "환자 거부"},
    {"code": "drug-allergy", "display": "clopi 알러지"},
    {"code": "other", "display": "기타 임상 판단"}
  ]
}
```

## 4. patient context input (FHIR resources)

| FHIR resource | DAPTPGX 사용 |
|---|---|
| `Patient` | age · sex (M12 sex axis · M12 ultra-elderly subgroup) |
| `Condition` | M4 ARC-HBR 14 항목 mapping (이전 출혈 · ICH · 빈혈 · CrCl 등) |
| `Observation` | CYP2C19 genotype (LOINC 89306-7) · Hb · platelet count · CrCl |
| `MedicationStatement` | 현재 약 (출혈 risk 보강 — anticoag · NSAID 등) |
| `Procedure` | PCI 시술 복잡도 (M7 z-axis: simple/complex/LMCA) |
| `DiagnosticReport` | 최근 PFT VerifyNow / LTA / MEA |

## 5. 결정맵 cell lookup workflow

```
input: {phenotype, hbr, complexity, subgroup}
  ↓
1. atlas lookup `CYP2C19.<phenotype>.kor.recommendation`  (M11 inbox 흡수 후)
  ↓ atlas hit / miss
2. cell index = phenotype_idx × hbr_idx × complexity_idx × subgroup_idx
  ↓
3. M7 27-cell base table + M12 4-subgroup overlay = 108-cell tesseract
  ↓
4. card render JSON (above) + verify verdict attach
  ↓
5. 시간축 trigger 4종 (acute LD · Day 14 PFT · Month 1 de-esc · Month 3-12 HOST-EXAM)
  ↓
6. follow-up 자동 booking + alert reminder
```

## 6. 한국 EMR 통합 sites (M11 inbox + 임상 capacity)

| EMR system | 도입 hospital | DAPTPGX 통합 readiness |
|---|---|---|
| **BESTCare 2.0** (분당서울대) | SNUBH 등 | FHIR 부분지원 · CDS Hooks pilot |
| **AMIS** (서울아산) | AMC · 등 | FHIR R4 + CDS Hooks production |
| **MediTrack** (삼성서울) | SMC | proprietary · API gateway 필요 |
| **세브란스 SES** (연세) | YUHS | 자체 build, FHIR 마이그레이션 진행 |
| **EzCaretech** (다수 종합) | ~60+ 병원 | FHIR R4 plan 2026 |
| **AhnLab Cocoon** (~50 종병) | 다수 | basic, 통합 후순위 |

## 7. PoC dispatch (CLI+COCKPIT M5/M6/M7 연계)

CLI+COCKPIT (M6 verify spec) + DAPTPGX (M15 CDS spec) cross-reference:

```
CLI+COCKPIT M5 synthesize  ──►  CDS service handler 호출
CLI+COCKPIT M6 verify      ──►  hexa verify <cell-id> verbatim → CDS card source
CLI+COCKPIT M7 handoff     ──►  CDS card → EMR order placement
```

## 8. PoC implementation roadmap (5-stage)

| stage | 산출 | 기간 | 한국 partner |
|---|---|---|---|
| 1. spec | 본 M15 + CDS Hooks JSON schema | 1mo | SNUBH IRB |
| 2. backend | hexa-lang stdlib `bio/cds_hooks.hexa` wrapper + hexa atlas PGx atoms | 2-3mo | hexa-lang sibling 흡수 |
| 3. CDS service | Node.js/Python FastAPI · CDS Hooks 표준 endpoint | 2-3mo | SNUBH IT |
| 4. EMR pilot | BESTCare 통합 + 50명 환자 retrospective + IRB | 3-6mo | SNUBH 순환기 |
| 5. RCT | DAPTPGX-CDS guided vs usual care · MACE/bleeding 1y | 12-24mo | KAMIR + KSC 연계 |

## 9. cost-effectiveness (M15 vs M8 §5 추정)

CDS deployment 추가 비용:
- 개발 (stage 1-3): ~3-5억원 (1.5 FTE × 18mo + infrastructure)
- 유지 (per hospital, /year): ~5-10백만원 (CDS service hosting + update)

cost-effectiveness 시나리오:
- 80,000 PCI/y × 1,000원/case CDS attribution = ~800백만/y benefit ceiling (단순 추정)
- 실측 benefit = MACE ↓ + 출혈 ↓ via CDS adherence (M8 §7 budget impact 일부)
- M15 break-even: ~2-3y after deployment, ~10+ EMR sites adoption

## 10. 검증 등급 (g5)

| 항목 | 등급 | 근거 |
|---|---|---|
| §1-3 CDS Hooks 표준 | 🟡 SUPPORTED-BY-CITATION | HL7 CDS Hooks 1.0 spec |
| §4 FHIR resources | 🟡 | FHIR R4 · LOINC 89306-7 (CYP2C19 phenotype) |
| §6 한국 EMR readiness | 🟡 | 각 EMR 벤더 public docs |
| §8 roadmap 5-stage | ⚪ SPECULATION-FENCED | forward plan (미실행) |
| §9 cost-effectiveness | ⚪ SPECULATION-FENCED | 추정 (예산 + benefit) |

## 11. 핵심 통찰

- **CDS Hooks 표준이 DAPTPGX 결정맵의 자연스러운 EMR 진입로** — patient-view + medication-prescribe + order-sign 3 hook으로 100% workflow 커버. proprietary 통합 대비 vendor lock-in 회피.
- **분당서울대 BESTCare = 가장 빠른 partner** — FHIR + CDS Hooks 이미 pilot, SNUBH IRB + 순환기 임상 collaboration 용이. AMIS production · MediTrack 후순위.
- **stage 2 hexa-lang stdlib wrapper = upstream cycle 자연스러운 next step** — M11 inbox `daptpgx-pgx-cds-tools.md` 흡수 → `bio/cds_hooks.hexa` 신설 → DAPTPGX cockpit M5 synth panel routing 실현.
- **CDS RCT (stage 5) = HOST-EXAM 후속 evidence-leading 후보** — 한국 KSC 가이드라인의 implementability 증거 → ESC/ACC upstream + EU 도입 가능. 결정맵 의 글로벌 영향력 path.
- **M15 break-even = 10+ EMR 사이트** — 단일 병원 비용 ~5-10백만/y, benefit ~800백만/y 가능 — 8-10 사이트 도입 시 자체 ROI 양수. KSC 2024 권고가 가속 변수.
