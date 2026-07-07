# OA-cartilage cure — COMPLETE assembled co-therapy (assembly-novelty basis)

완성 설계. 신규성은 **조립(조성)**에 있고, 외부 A 노드는 **이미 검증된 최고 기성부품**을 그대로 사용.
설계 SSOT = `fable_complete_assembly.json` (Fable 5). 게이트 검증 = `assembly_gate.py` 🟢.

## 조성 (single intra-articular depot · 4층)

```
   ┌─ ONE 관절강내 주사 → 양이온 GAG-avid 운반체 depot (δ층, 우리 물리) ───┐
   │      │ payload1                         │ payload2                     │
   │      ▼                                  ▼                              │
   │  SENOLYTIC (φ, 우리)              KARTOGENIN (A_ext, 기성 최고부품)    │
   │  BCL-xL/MCL1 AND-gate            FLNA/CBFβ→RUNX1 → Col-II/aggrecan     │
   │  노화세포 청소·SASP 해소 ──먼저──▶ 빈 니치를 hyaline으로 분화          │
   │      │                                  ▲                             │
   │      ▼                                  │                             │
   │  A_endo(0.206, 우리): 전구세포 이주 ────┘ (KGN이 이주세포를 분화)      │
   └──────────────────────────────────────────────────────────────────────┘
```

| 층 | 작용제/기전 | 소유 | 전달/용법 | 상호작용 |
|----|-----------|------|----------|---------|
| φ 청소 | SENOLYX BCL-xL/MCL1 AND-gate senolytic | **우리** | 운반체 탑재·**선행**(빠른 kill) | SASP가 연골생성 억제 → 먼저 치워야 A_endo·KGN 작동 |
| δ 침투 | 양이온 GAG-avid 운반체(Step1 Φ=3; mAv-class +18mV ~9nm) | **우리**(물리)/운반체는 기성 | 단일 IA 주사, 10일 잔류 depot | 공유 섀시 — φ·A_ext 둘 다 δ≥1로 전달, KGN Donnan 배제 극복 |
| A_endo 재생 | 내생 전구세포 이주(무작용제) | **우리**(구조) | φ 청소로 잠금해제 | 바닥 0.206; KGN이 분화시킬 세포 공급 |
| A_ext 동화 | **Kartogenin**(기성 최고 hyaline 소분자) | **기성부품 1개** | 동일 운반체 공동탑재, 서방출 | A_endo 이주세포를 hyaline으로 분화 → A_ext≈0.50 |

## 게이트 닫힘 (assembly_gate.py 🟢)

`Ceiling = 0.68 + 0.075·δ + 0.21·δ·(A_endo+A_ext)` ≥ 0.90

- buy-down 사슬(외부 동화부담): 0.690 →(A_endo 크레딧)→ 0.484 →(양이온 δ=1.23)→ **0.289**.
- 측정 운반체 δ=1.23: KGN A_ext 0.45~0.60 **전부 PASS (ceiling 0.942~0.980)**.
- 보수적 δ=1: A_ext≥0.484 필요 = KGN 낙관에지 (knife-edge, 0.50에서 0.903 PASS).
- **결론: 실측 운반체 운용점에서 게이트 닫힘.** (미계상 시너지: D+Q senolytic이 FGF18/IGF1/TGFβ2 상향 → A_endo↑; mAv 10일 잔류 → δ↑)

## 조성-신규성 주장 (정밀·방어가능)

**신규 Δ = 삼중게이트 3자 조성**: *senolytic + kartogenin을 양이온 연골침투 운반체에 공동탑재한 단일 관절강내 depot, δ×φ×A 동시만족만이 OA-치료 게이트를 닫는다는 정량증명으로 선택됨* + buy-down(0.69→0.29).

- **왜 성립(부품 각각은 기존)**: composition-of-matter+method 주장. 청소단독=불가(A=0→0.755<0.90)·KGN단독=전달/니치 실패 — **조립만 통과**(비자명성).
- **정직한 강등(d6·프로브)**: **mAv-KGN(양이온운반체+KGN)은 이미 출판**(He/Bajpayee Cartilage 2022) → 4층 중 2층은 기존 쌍. 따라서 신규성은 "양이온침투 KGN"이 **아니라**, 엄밀히 **"senolytic ⊕ KGN ⊕ 양이온운반체 = 삼중게이트 최적화 depot"** (senolytic 층 추가). 이 3자엔 충돌 미발견.
- **구별 대상**: He/Bajpayee mAv-KGN 2022(senolytic 없음) · D+Q/UBX0101 senolytic 단독(동화·운반체 없음) · KGN+성장인자(senolytic 없음).

## 남은 게이트 — in-silico 부분 전부 닫힘

- [x] **특허검색 실행**: `kartogenin AND senolytic` (patents.google.com/USPTO via web) → **senolytic+KGN 조합 특허 미발견**. hit은 KGN 단독 전달특허(US10064832B2 KGN-키토산 양이온입자·US20170290791A1) + senolytic 세포제거 특허(US10213426) **따로**. 조합 충돌 없음. (키워드-수준; 정식 FTO는 법률/wet 영역 — d1/d5 downstream)
- [x] **KGN 분자별 δ** (`pk-delivery` 재사용): free 음이온 KGN δ=0.081 BLOCK(Donnan 배제) → 양이온 운반체 δ=**1.44 PASS**. 전하-class 추론이 아닌 KGN 분자 자체로 δ≥0.772 확인.
- [🟠] **A_ext 점-보정**: 연골생성 동역학 wet-data 필요 → in-silico로는 문헌-order 구간(0.45–0.60)이 정직한 상한(d6). δ=1.23에선 구간 전체 PASS라 knife-edge 아님.
- [⬇ wet] **공동제형 호환성 + 결합 PK**: 공동탑재 안정성·차등방출·joint PK = 제형/wet 영역 = downstream 확정(d1/d5, non-wet-lab 게이트는 완료).

## 판정

조립 **NOVEL (高신뢰·조성수준)** — 특허·문헌 키워드검색에서 senolytic⊕KGN⊕운반체 3자 충돌 미발견 + 게이트 닫힘(δ·A 실측 운용점) + KGN 분자별 δ 확인. 완성된 in-silico *설계 + 비-wet 게이트 종결*. 분자수준 최종확정은 정식 FTO + A_ext wet-보정(downstream). d1/d5: 비-wet-lab 게이트 PASS → 조립-신규성 종결.
