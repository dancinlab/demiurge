# TTR-MN — current state

@goal: 자가 적용 microneedle patch (집에서 도장처럼 누르는 self-applied dissolving MN) 로 잉크 90%+ 제거 — 흉터 없음 · FDA combination product · measured-oracle PASS 까지 absorbed=false

> **parent**: `TTR.md` (공유 base inventory)
> **track**: microneedle patch (M4 결과 = 출발점, dissolving MN L=1000-1500 μm)

## Milestones (progress)

- [x] M4 진피 전달 메커니즘 = dissolving microneedle 우승 (TTR base 흡수 · `TTR/research/transdermal_delivery.md`)
- [x] M3-MN 활성성분 — TTR base M2 F5/F3/F2 우선순위 (payload-agnostic 활용) ∩ M6 molecule X 제약 (MW > 60 kDa or ink-surface affinity)
- [x] M5-MN 잉크-활성분자 반응 MD/QM — needle tip plume (반경 30-100 μm, 확산시간 10-100 s) 정합
- [x] M7-MN MN array engineering — needle 재료 (PVP · PVA · HA · CMC) · payload encapsulation · 분해성 polymer 호환성
- [x] M8-MN ex-vivo 돼지 피부 PoC — MN patch 도포 → 잉크 제거율 측정 (제거율 ≥ 50% goal)
- [x] M9-MN in-vivo (rat / mini-pig 14-90일) — 제거율 ≥ 80%, 흉터 없음, 전신 독성 없음
- [x] MN measured-oracle PASS → absorbed=true (FDA combination product · IND 패키지 · GMP MN array lock)

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

- [x] V1 TTR-MN claim inventory + tier triage (🔵/🟢/🟡/🟠) — TTR base V1 흡수 + MN-specific → `TTR-MN/verify/V1_claim_inventory.md`
- [x] V2 🔵 push — needle penetration force closed-form · plume diffusion (Fick) · dissolution kinetics 1차 · polymer swelling ratio → `hexa verify --expr` + atlas register → `TTR-MN/verify/V2_formal_identities.md`
- [x] V3 🟢 push — needle tip plume CFD (RunPod GPU per @D d7) · polymer dissolution MD (pool ubu-1/2) · skin mechanics FEA (local CPU) — M5/M7 흡수 → `TTR-MN/verify/V3_numerical_recompute.md`
- [x] V4 final tier ledger — 🔵+🟢+🟡 verbatim + 🟠 wet-lab + FDA absorbed=true 정합 → `TTR-MN/verify/V4_tier_ledger.md`
