# DEEP DC3 — arm③ 영구화 7-기전 비교 (durability × risk → relapse-0 fit)

"영구는 AAV만?" → NO. 7-기전 스펙트럼. cure-fit = relapse-0-eff × (1−risk) × reversibility-bonus (lifetime 50yr horizon).

| rank | mechanism | dur(yr) | self-renew | risk | relapse-0 | cure-fit |
|---|---|---:|---|---:|---|---:|
| 1 | **epigenetic edit (dCas9 Wnt-on/DKK1-off)** | 15 | ✓ | 0.30 | ✓ | **0.77** ★ |
| 2 | synthetic bistable circuit | 30 | ✓ | 0.45 | ✓ | 0.61 |
| 3 | CRISPR KO (AR/SRD5A2) | 50 | ✓ | 0.55 | ✓ | 0.45 |
| 4 | cell replace (androgen-resistant iPSC DPC) | 50 | ✓ | 0.60 | ✓ | 0.40 |
| 5 | integrating (lenti/transposon) | 50 | ✓ | 0.65 | ✓ | 0.35 |
| 6 | **AAV episomal (★기존 arm③)** | 8 | ✗ | 0.20 | ✗ | 0.14 |
| 7 | senolytic 1× | 3 | ✗ | 0.10 | ✗ | 0.06 |

## 발견 (기존 arm③ 업그레이드)
- 기존 **AAV episomal anti-DKK1은 relapse-0 미달**: 비분열 DPC에 ~8yr 잔존하나 평생(50yr) 못 감 + 비-self-renewing → 결국 희석·재발. 안전하나 "영구" 불충분.
- **균형 최적 = 후성유전 편집(dCas9)**: Wnt-on/DKK1-off 상태를 durable하게 lock (hit-and-run 후성기억), DNA 안 자름(mutagenesis↓), 필요시 reversible (안전망). self-renewing 후성상태.
- **최강 영구 = CRISPR KO(AR/SRD5A2)/통합**: relapse-0 확실하나 비가역+삽입돌연변이.

## arm③ 권고 전환
1차 = **후성유전 편집** (durable+안전+가역) · 강력옵션 = **CRISPR KO** (영구 확실, 고위험 수용 시) · prep = 세놀리틱 병용(단독 X).
design MC에서 arm③ 영구잠금이 최대 가치동인(−37%p)이었으므로, 그 기전을 AAV→후성유전으로 올리면 cure 확실성↑·위험↓ = 전체 cure-fit 직접 상승. (단일경로 AAV 고착에서 탈피 — arm④ 5축 확장과 같은 교정.)
