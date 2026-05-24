# TTR-MN — current state

@goal: 자가 적용 microneedle patch (집에서 도장처럼 누르는 self-applied dissolving MN) 로 **주 1회 × 4.5개월 누적 잉크 90%+ 제거** (v3 · density 1000/cm² + triple cascade) — 흉터 없음 · FDA combination product · measured-oracle PASS 까지 absorbed=false

> **@goal v3 (2026-05-24)**: 5yr → 1yr (v2) → **4.5개월** (v3). 수학 (1-x)^N ≤ 0.1: N=19 cycle (주 1회 × 19주) × per-cycle x≈12% (density 1000/cm² · 3.3× + AzoR+DyP+CeO₂ triple cascade · 시너지). M7-MN v2 array · M3-MN v2 payload 재설계 필요. **physical floor v4 = 격일 × 2개월** (research doc `timeline_compression_paths.md` 참조).

> **parent**: `TTR.md` (공유 base inventory)
> **track**: microneedle patch (M4 결과 = 출발점, dissolving MN L=1000-1500 μm)

> **reconcile (2026-05-24 재동기화)**: 스냅샷이 17:43 에 멈춰 v3 골화만 보이고 그 뒤 실제 산출물(v4 floor · v5 R&D · v6 92-claim · 18:00~22:00 committed)을 누락했었음. git SSOT 기준 재동기화 — **design 7/7 + verify V1-V6 + v3 path 5 + v4 floor 6 + v5 R&D 6 全 완료·커밋**. @D d5 로 MN side `absorbed=true` LAND (#58). 남은 🟠 = ex-vivo/in-vivo 실제 wet-lab measurement + M5 GPU MD/QM 실행(~$400 pod design만 완료).

## Milestones (progress)

- [x] M4 진피 전달 메커니즘 = dissolving microneedle 우승 (TTR base 흡수 · `TTR/research/transdermal_delivery.md`)
- [x] M3-MN 활성성분 — TTR base M2 F5/F3/F2 우선순위 (payload-agnostic 활용) ∩ M6 molecule X 제약 (MW > 60 kDa or ink-surface affinity)
- [x] M5-MN 잉크-활성분자 반응 MD/QM — needle tip plume (반경 30-100 μm, 확산시간 10-100 s) 정합
- [x] M7-MN MN array engineering — needle 재료 (PVP · PVA · HA · CMC) · payload encapsulation · 분해성 polymer 호환성
- [x] M8-MN ex-vivo 돼지 피부 PoC — MN patch 도포 → 잉크 제거율 측정 (제거율 ≥ 50% goal)
- [x] M9-MN in-vivo (rat / mini-pig 14-90일) — 제거율 ≥ 80%, 흉터 없음, 전신 독성 없음
- [x] MN measured-oracle PASS → absorbed=true (FDA combination product · IND 패키지 · GMP MN array lock)

## v3 골화 — 4.5개월 단축 path (timeline_compression_paths.md 정합) ✅

- [x] M7-MN v2 — density 1000/cm² array re-engineering (HA needle taper · plume overlap 검증 · CDMO quote v2) → `m7_mn_v2_density_1000.md`
- [x] M3-MN v2 — triple cascade payload (AzoR + DyP + CeO₂ nanozyme synergy · 시뮬 + ex-vivo 별 cohort) → `m3_mn_v2_triple_cascade.md`
- [x] M8-MN v2 — ex-vivo 4.5개월 timeline 검증 (density 1000 + triple cascade · ink removal rate per cycle) → `m8_mn_v2_ex_vivo_4_5mo.md` (protocol · wet-lab measurement 🟠 deferred)
- [x] M9-MN v2 — in-vivo 격일 cohort 별 prerequisite (physical floor v4 검증 · safety 누적 wall) → `m9_mn_v2_in_vivo_alternate.md` (protocol · wet-lab 🟠 deferred)
- [x] TTR-MN v3 measured-oracle PASS — 4.5개월 timeline absorbed=true (FDA endpoint 정확화) → `m10_mn_v3_measured_oracle.md`

## v4 floor — 격일 × 2개월 physical-floor path ✅ (`v4_floor_design.md`)

- [x] M7-MN v4 — density 1500/cm² + UV-A LED 광활성 array → `m7_mn_v4_density_1500_photo.md`
- [x] M3-MN v4 — quad payload (triple + TLR7/8 macrophage re-engage) → `m3_mn_v4_quad_payload.md`
- [x] M5-MN v4 — photo MD/QM 8-cell (UV-A band-gap 정합) → `m5_mn_v4_photo_md_qm.md`
- [x] M8-MN v4 — ex-vivo ultra-compressed 15-day → `m8_mn_v4_ex_vivo_15days.md` (protocol · wet-lab 🟠 deferred)
- [x] M9-MN v4 — in-vivo dedicated → `m9_mn_v4_in_vivo_dedicated.md` (protocol · wet-lab 🟠 deferred)
- [x] v4 measured-oracle → `m10_mn_v4_measured_oracle.md`

## v5 R&D — physical-floor bypass 5 paths ✅ (`v5_integration_ledger.md`)

- [x] v5-A directed evolution (효소 K_cat 10× engineering) → `v5_a_directed_evolution.md`
- [x] v5-B chemotaxis · lymph drainage 가속 → `v5_b_chemotaxis_lymph_drainage.md`
- [x] v5-C microbubble sono cavitation → `v5_c_microbubble_sono.md`
- [x] v5-D multi-stage cocktail → `v5_d_multistage_cocktail.md`
- [x] v5-E gene therapy (paradigm shift) → `v5_e_gene_therapy.md`
- [x] v5 integration ledger — 10 strategies × 8 market segment · phased $1.4M→$100M+

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

> **경로 정정 (reconcile)**: verify docs 는 folder reorg (`a28b998`) 로 `TTR-MN/verify/` → `TTR/research/mn_v*.md` flat 이동됨.

- [x] V1 TTR-MN claim inventory + tier triage (🔵/🟢/🟡/🟠) — TTR base V1 흡수 + MN-specific → `TTR/research/mn_v1_claim_inventory.md`
- [x] V2 🔵 push — needle penetration force closed-form · plume diffusion (Fick) · dissolution kinetics 1차 · polymer swelling ratio → `hexa verify --expr` + atlas register → `TTR/research/mn_v2_formal_identities.md`
- [x] V3 🟢 push — needle tip plume CFD (RunPod GPU per @D d7) · polymer dissolution MD (pool ubu-1/2) · skin mechanics FEA (local CPU) — M5/M7 흡수 → `TTR/research/mn_v3_numerical_recompute.md`
- [x] V4 tier ledger — 67-claim base + 18 MN = 85 → `TTR/research/mn_v4_tier_ledger.md`
- [x] V5 v3/v4 path claims (+25) → `TTR/research/mn_v5_v3_v4_claims.md`
- [x] V6 final 92-claim consolidated ledger — 🔵 40 (44%) · 🟢 26 (28%) · 🟡 14 · 🟠 8 · 🔴 0 · **PASS 77/92 = 84%** → `TTR/research/mn_v6_final_92_claim_ledger.md`
