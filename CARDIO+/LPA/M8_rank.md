# M8 — LPA 통합 후보 ranking + 한국인 임상 적용 전략

@goal: M1-M7 + R1-R3 + V1-V4 결과 통합 → Lp(a) 잔여 위험 차단 후보의 최종 ranking + 한국 임상 적용 단계 전략

## 입력 통합 매트릭스

| 후보 | M3/M4/M5 (효능) | M6 (안전) | M7 (정량) | V3a (PK) | V3c (경제) | R2 (한국) | tier 종합 |
|---|---|---|---|---|---|---|---|
| **olpasiran (siRNA)** | -98% Ph2 · OCEAN 2027 | inclisiran 외삽 ✅ | 5y NNT 20-25 (예상) | sim peak -95% ✅ | break-even $17.8/yr ❌ | KR site 가능 | 🟢 effectiveness · 🟠 outcome |
| **pelacarsen (ASO)** | -80% Ph2 · HORIZON 2026 H1 | flu-like 30% · Q4W | 5y NNT 25-30 | sim mean -85% ✅ | 동일 | KR site 확정 | 🟢 first-readout · 🟠 outcome |
| **lepodisiran (siRNA)** | -94% at 60wk · ACCLAIM 2029 | reversal 우려 (Q24-48W) | 5y NNT 22-28 | sim underfit (-43pp) ⚠️ | 동일 | unknown | 🟠 long timeline |
| **zerlasiran (siRNA)** | -85% Ph2 · Ph3 진입 단계 | minimal AE | TBD | sim mean -80% ✅ | 동일 | unknown | 🟠 Ph3 미진입 |
| **obicetrapib (CETP)** | -56% Ph2 (dual: LDL -45%) · PREVAIL 2026-27 | torcetrapib 학습 ✅ | 5y NNT ~40 | 미시뮬 | 경구 → 약가 ↓ 잠재 | KR site 가능 | 🟢 dual-effect · 🟠 outcome |
| **PCSK9 mAb (보조)** | -25% (FOURIER) | 안전 marketed ✅ | 5y NNT ~50 | 미시뮬 | KR 급여 ✅ | 즉시 가용 | 🟢 immediate ✅ |
| **muvalaplin (oral SM)** | -85.8% Ph2 KRAKEN (NEJM 2025) | unknown | TBD | 미시뮬 | 경구 → 약가 ↓ 잠재 | unknown | 🟡 신규 신호 |
| **VERVE-301 (gene editor)** | preclinical (LPA base editor) | unknown | TBD | 미시뮬 | 평생 1회 → 약가 ↑↑ | unknown | 🟠 preclinical |
| **apheresis** | -60% acute (독일) | 시설 부담 | 5y NNT ~80 | 미시뮬 | KR 시설 부재 ❌ | 미가용 | 🔴 KR 불가 |

## 종합 ranking (한국 진입 전략 가중치)

### 🥇 Tier-1 (즉시 가용 · 2026 land)
1. **PCSK9 mAb (evolocumab / alirocumab)** — Lp(a) ↓25% 부분 효과, ASCVD 2차 급여 ✅
   - 현재 한국 best option (siRNA 도입 전)
   - 잔여 위험 22-23% 미해결 (M7)

### 🥈 Tier-2 (2027-2028 도입 후보)
2. **pelacarsen (ASO)** — HORIZON readout **2026 H1** (first-in-class · 한국 site 확정)
   - 양성 outcome → 2026 H2 규제 제출 → 2027 출시 가능
   - 약점: Q4W 부담 · NHIS WTP 0% 통과 (V3c)
3. **olpasiran (siRNA)** — OCEAN(a) readout **2027 H1** · best reduction (-98%)
   - first-in-class siRNA · class-effect 정의 기준점
   - 약점: 동일 NHIS gate

### 🥉 Tier-3 (2027+ 대안 · 분기 시나리오)
4. **obicetrapib (CETP)** — PREVAIL Ph3 readout 2026-27 · dual-effect (LDL -45% + Lp(a) -56%)
   - 경구 → 약가 ↓ 잠재 → NHIS gate 통과 가능성
   - CETP class 마지막 생존자 · 양성 시 game-changer
5. **muvalaplin (oral SM)** — Ph2 -85.8% (NEJM 2025) · 경구 + 강력
   - Ph3 진입 시 olpasiran 대안 (편의성 우위)

### 🏅 Tier-4 (2029+ long-acting)
6. **lepodisiran (siRNA Q24-48W)** — ACCLAIM 2029 · 6-12개월 1회 dosing
   - adherence game-changer 후보
   - 단, reversal 불가능 우려 (M6)

### 🌱 Tier-5 (2030+ moonshot)
7. **VERVE-301 (LPA base editor)** — preclinical Q1 2025 dev candidate
   - 1회 평생 침묵 가능성
   - 약가 ↑↑ → 협상 wall

### ❌ Tier-X (한국 미가용)
8. **apheresis** — 시설 부재 · 보험 미적용 (Germany only)

## V 단계 통합 권고 (🔵 도달 경로 명시)

| V 단계 | 현재 | 다음 사이클 |
|---|---|---|
| V1 inventory | ✅ 45 claims · 🔵 target 8 | — |
| V2 atlas push | ⚠️ 0/8 (calc fn 부재) | **PR #665 merge 모니터링** |
| V3a siRNA ODE | ✅ 🟢 5건 (pool ubu-1) | lepodisiran k_clr refit |
| V3b MR/IVW MC | ⏳ in-flight | (V3b 완료 후 V4 업데이트) |
| V3c NHIS ICER | ✅ 🟢 5건 (pool ubu-2) | 좁은 적응증 NHIS 협상 시나리오 |
| V4 ledger | ✅ 22 🟢 / 1 🔵 / 17 🟡 / 4 🟠 / 1 🔴 | V3b 후 +4 🟢 |

## 한국 임상 적용 단계 전략

```
2026 (현재)
   ├─ PCSK9 mAb 모든 ASCVD 2차 + Lp(a) ≥50 mg/dL screen
   ├─ KSoLA 2026 cutoff 채택 (≥50 = high) → ~520만 명 screen
   └─ HORIZON 한국 site readout 대기 (2026 H1)

2026 H2 ~ 2027
   ├─ pelacarsen 양성 outcome → FDA/MFDS 동시 제출
   ├─ NHIS 약가 협상 시작 (목표: break-even $17.8/yr × 1380 = ₩24K/yr; 글로벌 $11.5K → 400× gap)
   ├─ RSA (risk-sharing arrangement) 우선 협상
   └─ 좁은 적응증 (Lp(a) ≥ 180 mg/dL · ~52만 명) 1차 진입

2027 ~ 2028
   ├─ OCEAN(a) outcome → olpasiran 경쟁 진입
   ├─ obicetrapib PREVAIL outcome → CETP 부활/사망 분기
   └─ KSoLA 약물 권고 update (양성 outcome 후)

2029
   ├─ ACCLAIM (lepodisiran) outcome — long-acting 검증
   └─ Q24-48W dosing adherence 데이터 land

2030+
   ├─ muvalaplin Ph3 진입 검증
   └─ VERVE-301 gene editing 1상 → 평생 1회 분기
```

## d2 breakthrough paths (한국 NHIS wall 돌파 5축)

V3c §11에서 제시 — 5축 모두 발동 시에도 ICER ₩2-4B/QALY (WTP 80-150× 초과):

1. **RSA (risk-sharing arrangement)** — outcome-based reimbursement (HORIZON 양성 시 NHIS 부담 0)
2. **narrow staging** — ≥180 mg/dL · ASCVD 2차 sub-pop (~52만 명 우선)
3. **한국 sub-group RRR 재산정** — HORIZON 한국 site sub-analysis (Asian-specific gain 가능성)
4. **KOQUSS utility weight** — 한국형 utility (글로벌 0.15 → 한국 0.20-0.25 가능성 → ARR ×1.3-1.7)
5. **bridge therapy** — pre-revasc · post-MI 단기 (3-6개월) 강력 사용 → 비용 ÷ 10

→ **유일 viable path = RSA + narrow + bridge** (3-축 동시) → ICER ₩15-25B/QALY (WTP 통과 가능 영역)

## 최종 권고 (한국 임상 적용)

```
🎯 SHORT-TERM (2026 H1-H2)
   - PCSK9 mAb 전체 ASCVD 2차 + Lp(a) ≥50 screening (Tier-1, 즉시)
   - HORIZON readout monitoring (Tier-2 trigger)

🎯 MID-TERM (2027-2028)
   - pelacarsen RSA + narrow staging (≥180 mg/dL · 52만 명) 협상 (NHIS Tier-2 land)
   - olpasiran OCEAN(a) outcome 후 class-effect 확장 (Tier-2 second)
   - obicetrapib PREVAIL 양성 시 경구 dual 우선 (Tier-3 game-changer)

🎯 LONG-TERM (2029+)
   - lepodisiran adherence advantage 검증 (Tier-4)
   - VERVE-301 platform 진입 모니터링 (Tier-5 moonshot)

🚨 ALWAYS-DEFER (정직한 closed)
   - apheresis (KR 시설 부재, Tier-X)
   - GalNAc 자유도구 (사내 IP wall, 🔴 FALSIFIED)
```

## verify rubric (M8 본 ranking)

| 항목 | tier | 비고 |
|---|---|---|
| ranking 정합성 | 🟡 | citation + sim weighted (V1-V4 종합) |
| timeline 정확성 | 🟡 | Ph3 dates from R2 (R2 R2_regulatory.md cross-check) |
| break-even price | 🟢 | V3c 시뮬 직접 인용 |
| 한국 단계 전략 | 🟡 | RSA + narrow + bridge 정성 + V3c d2 paths 정량 |

## 핵심 통찰 (M8 최종)

- 🥇 **Tier-1 (즉시) = PCSK9 mAb** — 2026 현재 한국 유일 가용 옵션
- 🥈 **Tier-2 (2027-28) = pelacarsen + olpasiran** — first-in-class, NHIS wall 돌파 필요
- 🥉 **Tier-3 wild-card = obicetrapib + muvalaplin** — 경구 dual/single → 약가 wall 우회 가능
- 🚨 **NHIS wall = 진짜 한국 entry barrier** — RSA + narrow + bridge 3-축 동시 발동 필수
- 🌱 **2030+ moonshot = VERVE-301** — 1회 평생 침묵 (game over scenario)
- ✅ **Lp(a) field 분기점 = HORIZON 2026 H1** — 양성/null/음성 시나리오 4-축 전체 재정렬
