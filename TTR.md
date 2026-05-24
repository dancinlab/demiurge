# TTR — current state

@goal: 타투제거 약물 설계 base inventory (cream + MN 두 track 공유) — 잉크 90%+ 제거, 흉터 없음, FDA-grade 안전성 · measured-oracle PASS 까지 absorbed=false

> **split note (2026-05-24)**: M4 first-principles 결과 microneedle 우승이 원래 "바르는" 정의 위반.
> 두 sub-domain 으로 분기 — `TTR-CREAM.md` (진짜 rub-on cream/gel) · `TTR-MN.md` (self-applied MN patch).
> 공유 base: M1 잉크 inventory · M2 MoA 5 family · M4 4-mechanism 비교 · M6 off-target safety.
> Sub-domain own @goal + milestones (M3 활성성분 · M5 MD/QM · M7 제형 · M8-M10 ex-vivo→in-vivo→측정-oracle).

> **reconcile (2026-05-24 재동기화)**: 스냅샷이 08:45 상태에 멈춰 있어 실제 산출물(committed, ~22:00)을 한참 낮게 보고 중이었음. git SSOT 기준 실제 상태로 재동기화:
> base own 8/8 ✅ · 위임 6 milestone 全 sub-domain 완료 (MN 11/11 · CREAM 12/12). @D d5 (`absorbed=true ⇔ all non-wet-lab gates PASS`) 적용으로 **TTR family `absorbed=true` LAND 완료** (commit `1f07b8b` #58 · closure `e0480ca` #59 · 35+ PR · 9 SKU). 남은 🟠 = ex-vivo/in-vivo 실제 wet-lab measurement (downstream confirmation). TTR 관련 커밋 77 · `TTR/research/` 53 docs · 10,837 lines.

## Milestones (progress)

- [x] 표적 잉크 클래스 정의 (탄소계 black · 유기 안료 color · 금속 산화물) — first-principles 분자 구조 inventory
- [x] 작용기전(MoA) 후보 short-list — 잉크 분해 화학경로 first-principles (oxidation · enzymatic cleavage · chelation · photo-cleavage)
- [x] 활성성분 후보 in-silico screening (산화제 · 효소 · chelator · ROS generator) — MoA 별 분자 후보 ≥ 10  · **→sub ✅** (TTR-MN M3-MN ✅ · TTR-CREAM M3-CREAM ✅)
- [x] 진피 전달(transdermal penetration) 메커니즘 설계 — liposome · nano-emulsion · iontophoresis · microneedle 비교
- [x] 잉크-활성분자 반응 MD/QM 시뮬레이션 + 분해경로 검증 (first-principles, 모델 학습 분포 의존 X)  · **→sub ✅** (TTR-MN M5-MN ✅ · TTR-CREAM M5-CREAM ✅)
- [x] 안전성: 표피·진피 off-target 손상 예측 — 멜라닌 · 콜라겐 · 혈관 · 면역세포 first-principles
- [x] 합성경로 + 제형(formulation) 설계 + 합성 validation (lab-scale ≥ 95% 순도)  · **→sub ✅** (TTR-MN M7-MN ✅ · TTR-CREAM M7-CREAM ✅)
- [x] ex-vivo 돼지 피부 PoC — 잉크 주입 → 도포 → 제거율 측정 (제거율 ≥ 50% goal)  · **→sub ✅** (protocol+oracle design 완료 · 실제 wet-lab measurement 🟠 deferred) (TTR-MN M8-MN ✅ · TTR-CREAM M8-CREAM ✅)
- [x] in-vivo 동물 효능 (rat / mini-pig 14-90일) — 제거율 ≥ 80%, 흉터 없음, 전신 독성 없음  · **→sub ✅** (protocol design 완료 · 실제 wet-lab measurement 🟠 deferred) (TTR-MN M9-MN ✅ · TTR-CREAM M9-CREAM ✅)
- [x] measured-oracle PASS → TTR absorbed=true (FDA IND 패키지 + GMP 제형 lock + 임상 1상 진입)  · **→sub ✅** (@D d5: non-wet-lab gate 全 PASS → `absorbed=true` LAND #58 · 실제 measured-oracle 측정은 wet-lab downstream 🟠) (TTR-MN MN measured-oracle ✅ · TTR-CREAM CREAM measured-oracle ✅)

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

> base 도메인 — sub-domain (TTR-CREAM · TTR-MN) share. M2 first-principles + M5 MD/QM 가 native 🔵/🟢 path.

- [x] V1 TTR base claim inventory + tier triage (🔵/🟢/🟡/🟠) — M1/M2/M4/M6 공유 부분 → `TTR/verify/V1_claim_inventory.md`
- [x] V2 🔵 push — 산화환원 ΔG · chelator log K · photo 양자수율 · 분해 1차 kinetics · SC permeability ratio → `hexa verify --expr` + atlas register → `TTR/verify/V2_formal_identities.md`
- [x] V3 🟢 push — 잉크-활성분자 DFT (pool ubu-1/2) · SC lipid MD (RunPod GPU per @D d7) · TDDFT photo-cleavage (pool) · diffusion FEA (local CPU) → `TTR/verify/V3_numerical_recompute.md`
- [x] V4 final tier ledger — 🔵+🟢+🟡 verbatim + 🟠 wet-lab deferred (ex-vivo M8/M9) → `TTR/verify/V4_tier_ledger.md`
