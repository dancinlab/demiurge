# RTSC V4 — 최종 tier ledger (V1+V2+V3 통합)

> Cross-domain unified verify schema · **step 4/4** (V1 inventory → V2 🔵 replay → V3 🟢 recompute → **V4 ledger**).
>
> 본 문서는 재-도출이 아니라 **통합 인덱스**: V1 52-claim 분류 + V2→V3 escalation 서사 + 🟠 wet-lab deferred → M9 handoff. 세부는 sibling 문서가 SSOT.
>
> Stamp: 2026-05-24 · §9.14 fanout 4/8 LANDED + h3cl 8³q converged + CaH₆/H₃S anchor.

## V-series 흐름 (escalation 서사)

```
V1 inventory ──▶ V2 replay ───────▶ V3 recompute ──▶ V4 ledger
 52 claim        7 identity          10/10 🟢          (이 문서)
 tier triage     0/7 🔵 (gap!)       Allen-Dynes Tc    통합 인덱스
                 calc path 부재       hexa-native
                      │                    ▲
                      └─ PR #745 ──────────┘
                         (verify_cli supercon fns 추가 → gap 닫힘)
```

**핵심**: V2 작성 시점(2026-05-24 07:06Z)엔 `hexa verify` calculator 에 supercon fn 0개 → 7/7 🟠 INSUFFICIENT (정직한 gap finding). 이후 **hexa-lang PR #745** 가 `tool/verify_cli.hexa` 에 supercon fn 6종(allen_dynes_tc·mcmillan_tc·bcs_gap_ratio·migdal_ratio·lambda_eliashberg·beenet_grid_bins)을 등록 → **V3 가 그 gap 을 실현**: Allen-Dynes Tc 10/10 🟢 SUPPORTED-NUMERICAL. V2 의 "path forward" 가 닫혔다.

## 통합 tier 분포 (V1 inventory 기준 + V3 갱신)

| tier | count | 대표 | V3 영향 |
|---|---:|---|---|
| 🔵 SUPPORTED-FORMAL | 14 | §C precommit 항등식 · §E closed-form (BCS ratio 3.528 등) · §D7 grid ceiling | 변동 0 (순수 symbolic) |
| 🟢 SUPPORTED-NUMERICAL | 30 | §A anchor DFT(9) · §B novel DFT(9) · §G infra(6) · §D ML 진단(5) · imaginary mode(2) | **강화** — DFT-Tc 10건이 hexa-native 재검증 (QE/parse → hexa libm 이중) |
| 🟡 SUPPORTED-BY-CITATION | 12 | §F 문헌(Drozdov 203K · Ma 215K · Flores-Livas · Liu …) | — |
| 🟠 INSUFFICIENT/DEFERRED | 6 | §C6 PENDING 4/8 fanout + §I wet-lab(5) | → **M9 handoff** (아래) |
| 🔴 FALSIFIED | 3 | ALIGNN/BETE-NET hydride 91–98% under · 보편 "light-X→Tc↑" 반증 | d6 audit trail |
| ⚪ SPECULATION-FENCED | 4 | §H frontier (8³q h3cl 추월 · SSCHA 안정화 가설) | — |
| **합** | **~52** | (primary tier 기준) | |

## 🔵+🟢+🟡 verbatim 앵커 (per milestone)

### 🔵 SUPPORTED-FORMAL (대표)
- **BCS gap ratio** `2Δ(0)/k_B·T_c = 3.528` — weak-coupling universal (π·exp(-γ_Euler)), closed-form (V1 §E3 · PR #299 Nb attestation).
- **§9.15 precommit protocol** `|Tc_pred − Tc_sim| < range_width → PASS` — verifiable rule, 5/5 LANDED 판정 재현 가능 (V1 §C1·C7).

### 🟢 SUPPORTED-NUMERICAL (V3 verbatim — 대표 1/10)
```
verify --expr allen_dynes_tc(1.368,1349.8,0.1)=140.324
  calc   = 140.324  ≈ expected 140.324  (|Δ|=2.7967e-11 ≤ ε=1e-9)
  tier   = 🟢 SUPPORTED-NUMERICAL  (hexa-native libm-class recompute, TECS-L n6-rep Tier2)
```
나머지 9종(h3cl-6q·h3o·h3f·h3si·h3se·h3te·h3po·H₃S·CaH₆) 전부 동일 tier · |Δ|≤ε — 상세 [[V3_numerical_recompute]].

### 🟡 SUPPORTED-BY-CITATION (oracle 앵커)
- **Drozdov 2015** H₃S 203K @ 150 GPa (Nature 525:73) — A1–A3 DFT 검증 대상.
- **Ma 2022** CaH₆ 215K @ 170 GPa (Nature 605:147) — A4 (DFT 213K, 2K 정합).

## 🟠 wet-lab deferred → M9 handoff 후보

V1 §I + §C6 의 🟠 항목 중 **M9 wet-lab handoff** 대상 (per @D d5: wet-lab = downstream 확인, non-wet-lab gate 와 분리):

| id | 항목 | M9 경유 | 비고 |
|---|---|---|---|
| I1/I2 | §8.9 5-gate (b)+(c)+(d): Tc≥270K + ambient + ≥3 lab | Tier-2 recipe-as-record | **현 후보 0건 통과** — 최선 stable=h3cl ~140K @ high-P |
| C6 | PENDING 4/8 fanout (h3n·h3p·h3as·**h3br**) | DFT 완료 후 재분류 | h3br = group-17 critical test |
| (N5) | SrAuH₃·Mg₂IrH₆·RbTlH₃ N5 funnel | ubu-2 DFT 진행 중 | M8(<50GPa·stable·Tc>200K) 게이트 의존 |

**M9 1순위 = h3cl** (유일 dynamically-stable novel, Tc 🟢 123–140K). recipe-as-record 초안 LANDED → `exports/material_discovery/rtsc_h3cl_tier2_wetlab_handoff_20260524.json` (EOS 합성압력 1건 pending = wet-lab 실행 blocker).

## absorbed 상태 (정직)

- **absorbed = false 유지**. 새 @D d5("absorbed=true ⇔ all non-wet-lab gates PASS")로 재정의됐어도, RTSC §8.9 의 핵심 게이트(Tc ≥ 270K **ambient**)는 현재 어떤 후보도 **예측조차 통과 못 함** (h3cl 140K @ high-P · h3o 191K = unstable upper-bound). 즉 non-wet-lab gate 자체가 미통과 → absorbed flip 불가. d5 인버트는 "측정 대기"가 아니라 "non-wet-lab 게이트 미충족"이 차단 사유임을 명확히 한다 (R4 invariant intact).
- V-series(V1–V4)는 **evidence ledger** 이지 absorbed 승급 경로가 아님 — Section A anchor 정합은 *파이프라인의 measurement-grade 능력* 증거일 뿐, 후보의 RTSC status 증거가 아니다.

## SSOT cross-link
- [[V1_claim_inventory]] (52-claim · 10-section) · [[V2_formal_identities]] (replay + gap) · [[V3_numerical_recompute]] (10/10 🟢)
- 수치 권위: `exports/material_discovery/rtsc_*.json` · 현재 상태: `RTSC.md` §3·§9.14·§9.15·§10.1
- governance: @D d1(완료-형) · d2(wall→path) · d5(absorbed gate) · d6(physics breaks ML wall) · g5(verdict verbatim)
- 갱신 트리거: §9.14 fanout 종료(h3br) · SrAuH₃ N5 funnel 종료 시 V1→V4 재실행
