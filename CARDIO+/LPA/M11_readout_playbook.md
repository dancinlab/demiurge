# M11 — HORIZON 2026 H1 readout 즉시 응답 playbook

@goal: HORIZON Ph3 (pelacarsen · NCT04023552) 2026 H1 readout 시점 3-시나리오별 즉시 응답 액션 정의 → Lp(a) field 전체 분기점 대응 준비

## Trigger 정의

- **Trigger source**: Novartis IR press release · NEJM/JAMA 정식 publication
- **Expected window**: 2026 H1 (2026-01-01 ~ 2026-06-30)
- **Best estimate**: 2026 H1 1차 + 2026 H2 규제 제출 (R2 §4 인용)
- **Monitoring**: M10 A3 축 — 주 1회 ClinicalTrials.gov + Novartis IR + BioSpace

## 시나리오 분류 (RRR 기반 3-tier)

| 시나리오 | 정의 | 확률 추정 | Lp(a) hypothesis |
|---|---|---|---|
| **A (양성)** | MACE RRR ≥ 15% (HR ≤ 0.85) · p<0.05 | ~40% | 강력 확정 |
| **B (modest)** | MACE RRR 5-15% (HR 0.85-0.95) · p borderline | ~30% | 부분 확정 |
| **C (null/음성)** | MACE RRR < 5% (HR > 0.95) · p>0.05 | ~30% | 흔들림 |

## 시나리오별 응답 (T+0 → T+24w)

### 🟢 시나리오 A (양성 · RRR ≥ 15%)

**T+0 (readout 당일)**
- M3/M4/M7/M8 즉시 갱신 (RRR 실측치 입력)
- V3c ICER 재계산 (RRR 분포 → break-even 재산정)
- KSoLA · KAMIR 한국 KOL 즉시 contact (한국 sub-group 분석 요청)

**T+1주**
- M8 ranking re-evaluation — pelacarsen Tier-2 → Tier-1 candidate
- 한국 sub-group RRR (HORIZON KR site sub-analysis) 요청 push
- V3a/V3b 시뮬 재실행 (실측 RRR 입력)

**T+1개월**
- M9 IIT design 갱신 — arm B = pelacarsen 확정
- HIRA 약가 협상 시작 준비 (NHIS RSA framework)
- KSoLA Position Paper revision 권고 push (PCSK9 + pelacarsen 권장)

**T+24주 (~2026 H2)**
- Novartis NDA/MAA 제출 monitoring
- MFDS 한국 등록 timeline 추적
- M8 Tier-2 → Tier-1 확정 (한국 IIT M9 fast-track)

### 🟡 시나리오 B (modest · RRR 5-15%)

**T+0**
- M3/M4 modest 결과 흡수 → 신중한 해석
- V3c ICER 재계산 — break-even 더 어려워짐 ($17.8 → $10 미만?)
- M8 ranking — pelacarsen Tier-2 유지 (Tier-1 진입 보류)

**T+1주**
- olpasiran OCEAN(a) 결과 대기 (Tier-1 진입 후보로 미룸)
- obicetrapib PREVAIL (2026-27) 가속화 시나리오 활성화
- M5 보조 약제 재평가 — PCSK9 mAb 강화

**T+1개월**
- M9 IIT 설계 보류 (OCEAN(a) 결과 후 단일 arm vs dual-arm 결정)
- HIRA 협상 보류 (효능 데이터 부족)
- KSoLA 가이드라인 update 보류

### 🔴 시나리오 C (null/음성 · RRR < 5%)

**T+0**
- M3 즉시 update — pelacarsen Tier-2 → Tier-X (퇴출)
- Lp(a) hypothesis 자체 검토 — Mendelian vs 약물 외삽 caveat 재강조 (M7 §6)
- M8 ranking 대폭 개편 — pelacarsen 제외

**T+1주**
- OCEAN(a) 결과 대기 (siRNA class effect 의존)
- obicetrapib PREVAIL 가속화 (대안 우위)
- M9 IIT 설계 시나리오 C로 pivot (observational registry 우선)

**T+1개월**
- Lp(a) 신약 전체 field freeze (siRNA / gene editing 모두 risk-up)
- M8 ranking — PCSK9 mAb Tier-1 유지 + obicetrapib Tier-2 (CETP dual-effect)
- KSoLA에 hypothesis revision 권고 push

**T+24주**
- siRNA class (OCEAN(a) 2027) 결과로 hypothesis 재검증
- LPA field consortium meeting 권고 (한국 KOL 주축)

## 즉시 자동화 후보 (M10 + M11 연계)

```python
# pseudo-code (실제 구현은 cycle 6+)
# horizon_readout_watch.py
import pytrials, requests
nct = pytrials.fetch('NCT04023552')
if nct.status == 'Completed' and nct.results_posted:
    rrr = parse_results(nct)
    if rrr >= 0.15:
        trigger_scenario('A')
    elif rrr >= 0.05:
        trigger_scenario('B')
    else:
        trigger_scenario('C')
```

각 시나리오 trigger → M3/M4/M7/M8 자동 갱신 + KSoLA 한국 KOL email + V3a/V3c 자동 재실행.

## 한국 KOL stakeholder map (사전 contact list)

| 영역 | 후보 institution/group |
|---|---|
| 한국 lipidology 권위 | KSoLA executive committee |
| Lp(a) 전문 KOL | 서울대 · Asan · Samsung · Severance lipid clinic 책임자 |
| Cardiology ASCVD 2차 예방 | KAMIR registry P.I. + 한국심장학회 |
| 임상 시험 운영 | KCTRN · KMA central IRB 책임 |
| HIRA 협상 path | HIRA 약제급여평가위원회 · KSoLA-HIRA 연락 |
| KOFIH / NRF | 한국형 임상 R&D 자금 |

## verify rubric (M11 본 playbook)

- 시나리오 분류 (3-tier): 🟡 SUPPORTED-BY-CITATION (HORIZON pre-spec)
- 확률 추정 (40/30/30): 🟠 (heuristic · Lp(a) field consensus 추정)
- 응답 timeline (T+0 → T+24w): 🟡 (KSoLA + HIRA 정책 주기 inference)
- 자동화 pseudo-code: 🟠 (실제 구현 cycle 6+)

## 핵심 통찰 (M11)

- **HORIZON readout = Lp(a) field 단일 분기점** (5축 동시 재정렬)
- **3-tier 확률** = 양성 ~40% · modest ~30% · null ~30% (heuristic)
- **시나리오 A (양성)** → pelacarsen Tier-1 진입 + M9 IIT fast-track
- **시나리오 B (modest)** → OCEAN(a) 대기 + obicetrapib 가속화
- **시나리오 C (null)** → 전체 hypothesis 검토 + PCSK9 mAb 유지
- **자동화 trigger** = pytrials + scenario classifier → cycle 6 후보
- 다음 cycle 입력 — M11 자동화 스크립트 + KSoLA contact list 정식화
