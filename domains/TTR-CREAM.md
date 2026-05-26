# TTR-CREAM — current state

@goal: 진짜 cream/gel/lotion 형태 (rub-on, no needles) 로 잉크 90%+ 제거 — 흉터 없음, OTC-grade 안전성 · measured-oracle PASS 까지 absorbed=false

> **parent**: `TTR.md` (공유 base inventory)
> **track**: cream-only (M4 microneedle 결과 비활용, SC barrier 돌파가 핵심 wall)

## Milestones (progress)

- [x] SC barrier 돌파 메커니즘 short-list — chemical permeation enhancer · CPP · SC lipid 분해 효소 · iontophoresis 보조 (first-principles depth-gap 분석)
- [ ] 진피 도달 wall 정량화 — cream-only 도달 깊이 (50-150 μm) vs 잉크 거주 (500-2000 μm) 의 first-principles gap, breakthrough path ≥ 3
- [ ] M3-CREAM 활성성분 — TTR base M2 F5/F3/F2 ∩ cream-friendly constraint (MW · logP · ionization · SC-permeable)
- [ ] M5-CREAM 잉크-활성분자 MD/QM — cream concentration profile (SC 통과 후 진피 농도) 정합
- [ ] M7-CREAM 제형 설계 — vehicle · permeation enhancer · stability · OTC-grade 성분 매핑
- [ ] M8-CREAM ex-vivo 돼지 피부 PoC — cream 도포 → 잉크 제거율 측정 (제거율 ≥ 30% goal, 정직)
- [ ] M9-CREAM in-vivo (rat / mini-pig) — cream-only 효능 (낮은 제거율 가능성 명시) + 안전성
- [ ] CREAM measured-oracle PASS → absorbed=true (OTC 또는 cosmetic-grade 등록)

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

- [ ] V1 TTR-CREAM claim inventory + tier triage (🔵/🟢/🟡/🟠) — TTR base V1 흡수 + CREAM-specific → `TTR-CREAM/verify/V1_claim_inventory.md`
- [ ] V2 🔵 push — SC partition log K_p · permeation enhancer ratio · CPP Henderson-Hasselbalch · cream-only depth gap closed-form → `hexa verify --expr` + atlas register → `TTR-CREAM/verify/V2_formal_identities.md`
- [ ] V3 🟢 push — SC bilayer MD with enhancer (RunPod GPU per @D d7) · cream vehicle DFT (pool ubu-1/2) · 진피 농도 PBPK (local CPU) → `TTR-CREAM/verify/V3_numerical_recompute.md`
- [ ] V4 final tier ledger — 🔵+🟢+🟡 verbatim + 🟠 wet-lab deferred (M8/M9 ex-vivo/in-vivo) → `TTR-CREAM/verify/V4_tier_ledger.md`
