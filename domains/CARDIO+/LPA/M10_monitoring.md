# M10 — KSoLA + HIRA 실태 monitoring schema

@goal: LPA 도메인 핵심 외부 지표 (KSoLA 가이드라인 · HIRA 약가 · 임상 trial · 신약 허가)의 분기별 monitoring + 즉시 응답 trigger 정의

## Monitoring axes (5축 · 분기별 cadence)

| 축 | 출처 | cadence | trigger 조건 | 응답 |
|---|---|---|---|---|
| **A1 KSoLA 가이드라인** | e-JLA · 한국지질학회 | 분기 (3개월) | Position Paper revision · 약물 권고 update | M1/M2 cutoff 재확인 → R2 갱신 |
| **A2 HIRA 급여 고시** | hira.or.kr | 월 1회 | PCSK9i 적응증 확대 · siRNA/ASO 신규 급여 | M5/V3c ICER 재계산 → 신규 Tier 추가 |
| **A3 HORIZON readout** | Novartis IR · BioSpace · ClinicalTrials.gov NCT04023552 | 주 1회 (2026 H1 임박) | "primary completion" status 변화 · IR press release | M11 playbook 즉시 발동 |
| **A4 OCEAN(a) status** | Amgen IR · NCT05581303 | 월 1회 (~2027 H1 readout) | enrollment update · interim analysis | M4 갱신 |
| **A5 신약 NDA/MAA** | FDA Orange Book · EMA · MFDS | 분기 | pelacarsen / olpasiran / muvalaplin / VERVE-301 신규 등록 | M3/M4 modality 확장 |

## 분기별 체크리스트 템플릿

```
■ Q1 (1-3월) — 매년
  □ KSoLA e-JLA 최신호 Lp(a) Position Paper revision 확인
  □ HIRA 1월 1일 급여 고시 변경사항
  □ HORIZON 2026 H1 readout watch (active)
  □ KSoLA 학술대회 / 봄철 학술집담회 발표 모니터링

■ Q2 (4-6월) — 매년
  □ HORIZON readout 후 즉시 M11 playbook 발동
  □ HIRA 4월 1일 분기 급여 update
  □ Novartis Q1 earnings call (HORIZON status)
  □ ACC (American College of Cardiology) 학술대회 한국 발표

■ Q3 (7-9월) — 매년
  □ ESC (European Society of Cardiology) 학회 한국 site 결과
  □ Amgen Q2 earnings (OCEAN(a) status)
  □ HIRA 7월 1일 update
  □ KSoLA 가을 학술집담회

■ Q4 (10-12월) — 매년
  □ AHA (American Heart Association) Scientific Sessions
  □ HIRA 10월 1일 update
  □ KSoLA 연말 가이드라인 revision 발표
  □ Lilly Q3 earnings (ACCLAIM/lepodisiran)
```

## 핵심 URL/source registry

| 종류 | URL/source | 책임 |
|---|---|---|
| KSoLA e-JLA | https://e-jla.org/ | 분기 manual check |
| KSoLA 사이트 | https://www.lipid.or.kr/ | 분기 |
| HIRA 급여 고시 | https://www.hira.or.kr/ | 월 1회 |
| HIRA 약제급여 | https://www.hira.or.kr/dummy.do?pgmid=HIRAA030063060000 | 월 1회 |
| ClinicalTrials.gov | NCT04023552 · NCT05581303 · NCT06292013 · NCT07136012 | pytrials 자동화 (R3) |
| Novartis IR | https://www.novartis.com/investors | 분기 earnings + press release |
| Amgen IR | https://investors.amgen.com/ | 분기 |
| Lilly IR | https://investor.lilly.com/ | 분기 |
| Newamsterdam IR | https://newamsterdampharma.com/investors | 분기 (obicetrapib) |
| Verve IR | https://ir.vervetx.com/ | 분기 (VERVE-301) |
| Korea Biomedical Review | https://www.koreabiomed.com/ | 한국 site 등록 update |

## 자동화 후보 (R3 라이브러리 활용)

| 작업 | 도구 | 활용 |
|---|---|---|
| ClinicalTrials.gov XML 파싱 | `pytrials` 0.3.0 (R3 §3) | NCT IDs 5건 자동 status 추적 |
| HIRA 급여 RSS | manual (RSS 미지원) | 월 1회 수동 |
| KSoLA e-JLA RSS | DOAJ RSS | 신호 trigger |
| IR press release | webhook (회사별) | 즉시 trigger 가능 |

## 응답 SLA (Service Level Agreement)

| trigger 강도 | 응답 SLA | 처리 |
|---|---|---|
| HORIZON readout (positive/null/negative) | **즉시** (1일) | M11 playbook 발동 |
| 신규 약물 NDA approval | 1주 | M3/M4 + M8 ranking 갱신 |
| KSoLA Position Paper revision | 2주 | M1/M2 cutoff 재확인 |
| HIRA 급여 변경 | 1개월 | V3c ICER 재계산 |
| 신규 Ph3 trial 등록 | 1개월 | M4/R1 갱신 |

## verify rubric (M10 본 monitoring)

- 출처 URL 유효성: 🟢 (수동 검증)
- cadence 적정성: 🟡 (heuristic 산정)
- 자동화 가용성: 🟡 (pytrials만 자동, 나머지 수동)
- SLA 준수성: 🟠 (현재 미발동, 향후 평가)

## 핵심 통찰 (M10)

- **5축 모니터링** = KSoLA · HIRA · HORIZON · OCEAN(a) · 신약 NDA
- **분기 cadence** = 한국 의료 정책 변화 주기와 일치 (HIRA 1/4/7/10월 갱신)
- **HORIZON readout 즉시 응답** = M11 playbook 발동 trigger
- **pytrials 자동화** = ClinicalTrials.gov 5개 NCT 자동 polling 후보
- 다음 cycle 입력 — M10 자동화 스크립트 (cycle 6 후보)
