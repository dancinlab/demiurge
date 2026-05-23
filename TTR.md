# TTR — current state

@goal: 타투제거 약물 설계 base inventory (cream + MN 두 track 공유) — 잉크 90%+ 제거, 흉터 없음, FDA-grade 안전성 · measured-oracle PASS 까지 absorbed=false

> **split note (2026-05-24)**: M4 first-principles 결과 microneedle 우승이 원래 "바르는" 정의 위반.
> 두 sub-domain 으로 분기 — `TTR-CREAM.md` (진짜 rub-on cream/gel) · `TTR-MN.md` (self-applied MN patch).
> 공유 base: M1 잉크 inventory · M2 MoA 5 family · M4 4-mechanism 비교 · M6 off-target safety.
> Sub-domain own @goal + milestones (M3 활성성분 · M5 MD/QM · M7 제형 · M8-M10 ex-vivo→in-vivo→측정-oracle).

## Milestones (progress)

- [x] 표적 잉크 클래스 정의 (탄소계 black · 유기 안료 color · 금속 산화물) — first-principles 분자 구조 inventory
- [x] 작용기전(MoA) 후보 short-list — 잉크 분해 화학경로 first-principles (oxidation · enzymatic cleavage · chelation · photo-cleavage)
- [ ] 활성성분 후보 in-silico screening (산화제 · 효소 · chelator · ROS generator) — MoA 별 분자 후보 ≥ 10
- [x] 진피 전달(transdermal penetration) 메커니즘 설계 — liposome · nano-emulsion · iontophoresis · microneedle 비교
- [ ] 잉크-활성분자 반응 MD/QM 시뮬레이션 + 분해경로 검증 (first-principles, 모델 학습 분포 의존 X)
- [x] 안전성: 표피·진피 off-target 손상 예측 — 멜라닌 · 콜라겐 · 혈관 · 면역세포 first-principles
- [ ] 합성경로 + 제형(formulation) 설계 + 합성 validation (lab-scale ≥ 95% 순도)
- [ ] ex-vivo 돼지 피부 PoC — 잉크 주입 → 도포 → 제거율 측정 (제거율 ≥ 50% goal)
- [ ] in-vivo 동물 효능 (rat / mini-pig 14-90일) — 제거율 ≥ 80%, 흉터 없음, 전신 독성 없음
- [ ] measured-oracle PASS → TTR absorbed=true (FDA IND 패키지 + GMP 제형 lock + 임상 1상 진입)
