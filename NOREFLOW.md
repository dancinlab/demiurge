# NOREFLOW — current state

@goal: PCI 직후 미세혈관 막힘(no-reflow / slow-flow) 차단 — 재관류 손상(IRI) 보호 + microvascular obstruction(MVO) 후보 분자/시술 short-list로 심근 구원 극대화

## milestones

- [x] no-reflow 4-cause 매핑 (distal embolization · vasospasm · edema · ROS/IRI) → `NOREFLOW/M1_causes.md`
- [x] mPTP 차단 후보 inventory — cyclosporin-A · sanglifehrin · TRO40303 · 후속 → `NOREFLOW/M2_mptp.md`
- [x] 미세혈관 보호 약물 short-list — adenosine · nicorandil · nitroprusside · verapamil → `NOREFLOW/M3_microvasc.md`
- [x] 국소 전달 vs systemic — IC bolus · distal protection · thrombectomy → `NOREFLOW/M4_delivery.md`
- [x] 임상 측정 endpoint — TIMI flow · MBG · cMRI LGE · IMR → `NOREFLOW/M5_endpoint.md`
- [x] M6 off-target / 안전성 — 부정맥 · 저혈압 · 출혈 → `NOREFLOW/M6_safety.md`
- [x] 후보 통합 ranking + d2 wall breakthrough → `NOREFLOW/M7_rank.md`
- [x] 한국인 KAMIR / K-ACTION registry 매핑 → `NOREFLOW/M8_korea.md`
- [x] M9 web/arxiv deep evidence — 최신 5년 임상/preclinical + arxiv ML 논문 inventory → `NOREFLOW/M9_deep_research.md`
- [ ] M10 honest fence — ⚪ SPECULATION-FENCED 분류 (bio/clinical closed-form 미가능 영역) → `NOREFLOW/M10_fence.md`
- [ ] M11 formal grade-up pass — atlas 확장 후 🔵 도달 검증 (hexa-lang inbox `noreflow-clinical-calc-extension` merge 후) → `NOREFLOW/M11_formal.md`
- [ ] M12 simulation pass — demiurge 자산 (d1: non-wet-lab completed-form) — PK 시뮬 · IRI ODE · M7 Monte Carlo · Trial-A power calc → `NOREFLOW/M12_simulation.md`

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

> M10 (fence) / M11 (formal grade-up) / M12 (simulation) 가 이 phase 의 native 구현. 아래 V1-V4 는 통일 schema 매핑.

- [ ] V1 NOREFLOW claim inventory + tier triage (🔵/🟢/🟡/🟠) — M10 ⚪ fence 결과 흡수 → `NOREFLOW/verify/V1_claim_inventory.md`
- [ ] V2 🔵 push — mPTP Δψ_m identity · adenosine Hill · IMR closed-form · TIMI flow ratio · M11 atlas 확장 → `hexa verify --expr` + atlas register → `NOREFLOW/verify/V2_formal_identities.md`
- [ ] V3 🟢 push — M12 PK/IRI ODE (local CPU) · cyclosporin-A binding MD (pool ubu-1/2) · adenosine receptor docking (RunPod GPU per @D d7) → `NOREFLOW/verify/V3_numerical_recompute.md`
- [ ] V4 final tier ledger — 🔵+🟢+🟡 verbatim + 🟠 honest deferred + M10 ⚪ fence 통합 → `NOREFLOW/verify/V4_tier_ledger.md`
