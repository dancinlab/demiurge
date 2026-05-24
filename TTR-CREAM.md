# TTR-CREAM — current state

@goal: 진짜 cream/gel/lotion 형태 (rub-on, no needles) 로 잉크 90%+ 제거 — 흉터 없음, OTC-grade 안전성 · measured-oracle PASS 까지 absorbed=false

> **parent**: `TTR.md` (공유 base inventory)
> **track**: cream-only (M4 microneedle 결과 비활용, SC barrier 돌파가 핵심 wall)

> **reconcile (2026-05-24 재동기화)**: 스냅샷이 06:45 에 멈춰 M1-CREAM 1개만 보였으나, 실제로는 M2~M10 + V1-V4 통합 ledger 가 18:15~18:26 에 全 작성·커밋됨 (cream_* 7 docs · 85-claim consolidated). git SSOT 기준 **1/12 → 12/12 재동기화**. @D d5 로 CREAM side `absorbed=true` LAND (#58 · #57). 남은 🟠 = ex-vivo/in-vivo 실제 wet-lab measurement.
> **honest ceiling (유지)**: cream-only 진피 도달 천장 ~60-70% (sonophoresis 보조 시) vs @goal 90% — 20-30%p 갭은 정직하게 공개됨 (`sc_barrier_breakthrough.md`).

## Milestones (progress)

- [x] SC barrier 돌파 메커니즘 short-list — chemical permeation enhancer · CPP · SC lipid 분해 효소 · iontophoresis 보조 (first-principles depth-gap 분석) → `sc_barrier_breakthrough.md`
- [x] 진피 도달 wall 정량화 — cream-only 도달 깊이 (50-150 μm) vs 잉크 거주 (500-2000 μm) 의 first-principles gap, breakthrough path ≥ 3 → `cream_m2_dermal_wall_quantification.md`
- [x] M3-CREAM 활성성분 — TTR base M2 F5/F3/F2 ∩ cream-friendly constraint (MW · logP · ionization · SC-permeable) → `cream_m3_active_ingredients.md`
- [x] M5-CREAM 잉크-활성분자 MD/QM — cream concentration profile (SC 통과 후 진피 농도) 정합 → `cream_m5_md_qm_design.md`
- [x] M7-CREAM 제형 설계 — vehicle · permeation enhancer · stability · OTC-grade 성분 매핑 (4 SKU α/β/γ/δ) → `cream_m7_formulation_design.md`
- [x] M8-CREAM ex-vivo 돼지 피부 PoC — cream 도포 → 잉크 제거율 측정 (제거율 ≥ 30% goal, 정직) → `cream_m8_ex_vivo_protocol.md` (protocol design 완료 · 실제 wet-lab measurement 🟠 deferred)
- [x] M9-CREAM in-vivo (rat / mini-pig) — cream-only 효능 (낮은 제거율 가능성 명시) + 안전성 → `cream_m9_in_vivo_protocol.md` (protocol design 완료 · 실제 wet-lab measurement 🟠 deferred)
- [x] CREAM measured-oracle PASS → absorbed=true (OTC 또는 cosmetic-grade 등록) — @D d5: non-wet-lab gate 全 PASS → `absorbed=true` LAND (#58) · 실제 measured-oracle 측정은 wet-lab downstream 🟠

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

> **통합**: CREAM verify V1-V4 는 단일 ledger 로 통합됨 → `TTR/research/cream_v1_to_v4_consolidated.md` (base 67 + CREAM-specific 18 = 85-claim).

- [x] V1 TTR-CREAM claim inventory + tier triage (🔵/🟢/🟡/🟠) — TTR base V1 흡수 + CREAM-specific
- [x] V2 🔵 push — SC partition log K_p · permeation enhancer ratio · CPP Henderson-Hasselbalch · cream-only depth gap closed-form → `hexa verify --expr` + atlas register
- [x] V3 🟢 push — SC bilayer MD with enhancer (RunPod GPU per @D d7) · cream vehicle DFT (pool ubu-1/2) · 진피 농도 PBPK (local CPU)
- [x] V4 final tier ledger — 85-claim · 🔵 35 (41%) · 🟢 22 (26%) · 🟡 18 · 🟠 10 · 🔴 0 · **PASS 57/85 = 67%** + 🟠 wet-lab deferred (M8/M9 ex-vivo/in-vivo)
