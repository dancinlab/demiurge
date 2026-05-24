# LPA — 도메인 종합 인덱스

@goal: Lipoprotein(a) 잔여 위험 차단 — 한국 임상 적용 패러다임 5-cycle 종합

> **상태**: cycle 1-5 100% closure · 23/23 milestone main land · hexa-lang PR #700 merged
> **다음 trigger**: HORIZON 2026 H1 readout (M11 playbook 발동) · OCEAN(a) 2027 readout

## 빠른 진입 — 결론만 알고 싶다면

→ `M8_rank.md` (5-Tier ranking + 한국 임상 적용 전략)

## 상세 navigation

### Tier-1 본 milestone (cycle 1-2)

| # | 파일 | 핵심 |
|---|---|---|
| M1 | [M1_structure.md](M1_structure.md) | Lp(a) = LDL + apo(a) 구조 + KIV-2 isoform |
| M2 | [M2_korea.md](M2_korea.md) | 한국인 ≥50 mg/dL ~12-13% = **~520만 명** |
| M3 | [M3_aso.md](M3_aso.md) | pelacarsen ASO · HORIZON Ph3 **2026 H1 readout** |
| M4 | [M4_sirna.md](M4_sirna.md) | siRNA 3-way (olpasiran -98% · lepodisiran -94% · zerlasiran -85%) |
| M5 | [M5_adjunct.md](M5_adjunct.md) | 보조 약제 (PCSK9 mAb · obicetrapib · niacin · mipomersen · apheresis) |
| M6 | [M6_safety.md](M6_safety.md) | Mendelian null carrier 안전 보증 + ASO/siRNA 격자 |
| M7 | [M7_quant.md](M7_quant.md) | Burgess HR 0.71/SD · 한국 5y NNT 25-35 |
| M8 | [M8_rank.md](M8_rank.md) | **5-Tier ranking + 한국 NHIS RSA+narrow+bridge 돌파** |

### Tier-2 deep research (cycle 3)

| # | 파일 | 핵심 |
|---|---|---|
| R1 | [R1_arxiv.md](R1_arxiv.md) | 25 papers · 🟢 4건 신규 · muvalaplin/VERVE-301 발견 |
| R2 | [R2_regulatory.md](R2_regulatory.md) | KSoLA 2026 · HIRA · NHIS · 🟢 4건 신규 |
| R3 | [R3_libraries.md](R3_libraries.md) | 28 도구 inventory + 3 inbox drafts · 🔴 GalNAc gap |

### Tier-3 verify push (cycle 4)

| # | 파일 | 핵심 |
|---|---|---|
| V1 | [verify/V1_claim_inventory.md](verify/V1_claim_inventory.md) | 45 claims tier triage · 🔵 target 8건 매핑 |
| V2 | [verify/V2_formal_identities.md](verify/V2_formal_identities.md) | atlas push 0/8 (calc fn 부재) · hexa-lang PR #665 가동 |
| V3a | [verify/V3a_sirna_kinetics.md](verify/V3a_sirna_kinetics.md) | siRNA ODE pool ubu-1 · 4분자 PK · 🟢 5건 |
| V3b | [verify/V3b_mr_ivw_mc.md](verify/V3b_mr_ivw_mc.md) | MR/IVW MC pool ubu-1 · Burgess CI 100% overlap · 🟢 5건 |
| V3c | [verify/V3c_nhis_icer.md](verify/V3c_nhis_icer.md) | NHIS ICER MC pool ubu-2 · WTP 0% · 🟢 5건 |
| V4 | [verify/V4_tier_ledger.md](verify/V4_tier_ledger.md) | 최종 tier 분포 (🔵 1 · 🟢 22 · 🟡 17 · 🟠 4 · 🔴 1) |

### Tier-4 한국 임상 실전 (cycle 5)

| # | 파일 | 핵심 |
|---|---|---|
| M9 | [M9_kr_iit.md](M9_kr_iit.md) | **K-LpA-OUTCOMES** n=3,000 · 2032 readout · ₩32-35B |
| M10 | [M10_monitoring.md](M10_monitoring.md) | 5축 monitoring · 분기 cadence · pytrials 자동화 |
| M11 | [M11_readout_playbook.md](M11_readout_playbook.md) | HORIZON 3-시나리오 playbook · T+0~T+24w 액션 |

## verify tier 최종 분포 (V4 기준)

```
🔵 SUPPORTED-FORMAL    1   (sigma sanity · biostat impl PR 대기)
🟢 SUPPORTED-NUMERICAL 22  (V3b 후 27, V4는 보수 22 기준)
🟡 SUPPORTED-BY-CITATION 17  (분자 효능 · 안전 · 가이드라인 잔여)
🟠 INSUFFICIENT/DEFERRED 4  (Ph3 outcome 대기)
🔴 FALSIFIED           1   (GalNAc 자유도구 사내 IP wall)
```

## 외부 의존 (상류 + 시간)

| 의존 | 위치 | 영향 |
|---|---|---|
| hexa-lang biostat calc fn implementation | (PR #665 = note merged · 실제 impl PR 별도) | 🔵 0 → ~6+ promotion |
| HORIZON readout 2026 H1 | Novartis IR · NCT04023552 | M11 playbook trigger · M3/M7/M8 갱신 |
| OCEAN(a) readout 2027 H1 | Amgen IR · NCT05581303 | M4 갱신 · class effect 확장 |
| obicetrapib PREVAIL 2026-27 | Newamsterdam IR | M5 + Tier-3 game-changer |
| ACCLAIM-Lp(a) 2029 | Lilly IR · NCT06292013 | lepodisiran Tier-4 adherence 입증 |
| K-LpA-OUTCOMES IIT 2027 enroll → 2032 readout | M9 blueprint | 한국 first-in-class evidence |

## 상류 기여 (cycle 4-5 발생)

| PR / inbox | 위치 | 상태 |
|---|---|---|
| **hexa-lang PR #700** | pool.hexa compile error P1 patch | ✅ **MERGED** |
| **hexa-lang PR #665** | LPA IVW MR formula extension request (inbox note) | ✅ MERGED (note only · impl 별도) |
| hexa-lang witness shards | atlas.append.witness-*-lpa_{ivw,schoenfeld,binary_sample,nnt}.n6 | staged (daily aggregate 대기) |

## 한국 임상 적용 timeline

```
2026 H1   HORIZON readout (M11 trigger) ─┐
2026      PCSK9 mAb Tier-1 즉시 + KSoLA  │
          ≥50 mg/dL screening (520만 명) │
2027 H1   OCEAN(a) readout               ├─→ pelacarsen/olpasiran 선택
2027      K-LpA-OUTCOMES enroll start    │   (시나리오 A/B/C 분기)
2026-27   obicetrapib PREVAIL            ┘
2028      pelacarsen/olpasiran 한국 도입 (RSA 협상 land)
2029      ACCLAIM (lepodisiran) readout
2030      K-LpA-OUTCOMES interim safety
2032      K-LpA-OUTCOMES MACE primary readout
2033      KSoLA 가이드라인 update (한국 first-in-class 증거)
2030+     muvalaplin Ph3 · VERVE-301 gene editing 1상
```

## 핵심 권고 (한 줄)

> **2026 현재**: PCSK9 mAb 즉시 + Lp(a) ≥50 mg/dL screening
> **2027-28**: pelacarsen/olpasiran + RSA + narrow staging + bridge therapy
> **2032+**: K-LpA-OUTCOMES 결과 + KSoLA 한국 first-in-class consortium
