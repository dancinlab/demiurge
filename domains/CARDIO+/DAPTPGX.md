# DAPTPGX — current state

@goal: 한국인 PCI 환자 항혈소판제(DAPT) 약물유전체 맞춤 결정맵 — CYP2C19 LoF 보유자(≈60%)에서 clopidogrel 효과 저하 회피 + 출혈위험 균형 → 스텐트 혈전증 / MACE 최소화

## milestones

- [x] CYP2C19 *2 / *3 / *17 한국인 allele 빈도 + diplotype 분포 → `DAPTPGX/M1_allele.md`
- [x] clopidogrel 활성화 경로 + LoF 효과 정량 (platelet reactivity index) → `DAPTPGX/M2_pathway.md`
- [x] 약제 전환 결정 트리 — clopidogrel → prasugrel / ticagrelor → `DAPTPGX/M3_switch.md`
- [x] 출혈 risk score — PRECISE-DAPT · ARC-HBR · 한국인 calibration → `DAPTPGX/M4_bleed.md`
- [x] platelet function test 통합 — VerifyNow · LTA · MEA cut-off → `DAPTPGX/M5_pft.md`
- [x] 신규 P2Y12 후보 — selatogrel · revacept · 향후 → `DAPTPGX/M6_next.md`
- [x] 한국인 통합 결정맵 (유전형 × 출혈위험 × 시술복잡도) → `DAPTPGX/M7_map.md`
- [x] cost-effectiveness + universal vs targeted PGx 전략 → `DAPTPGX/M8_econ.md`
- [x] arxiv/PubMed deep dive 2024-2026 — M1-M8 cite 보강 + new findings → `DAPTPGX/M9_arxiv.md`
- [x] web 임상 readout · 가이드라인 update — SOS-AMI · VICTORY · POPular II · KSC 2025 → `DAPTPGX/M10_readouts.md`
- [x] PGx 라이브러리/도구 인벤토리 — hexa-lang/atlas SSOT handoff → `demiurge/archive/session-notes/daptpgx-pgx-library-inventory.md` (+ 카테고리별 분할)
## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

- [x] V1 DAPTPGX claim inventory + tier triage (🔵/🟢/🟡/🟠) → `DAPTPGX/verify/V1_claim_inventory.md`
- [x] V2 🔵 push (honest 0 — promoter bug · 4 shard staged · 2 inbox patches upstream to hexa-lang) → `DAPTPGX/verify/V2_formal_identities.md`
- [x] V3 🟢 push (v1) — HW + phenotype 🟢 escalation 성공 · ICER/budget 🟠 DEFERRED (model reconciliation, V3.5 후속) → `DAPTPGX/verify/V3_numerical_recompute.md` + `DAPTPGX/sims/v3_recompute.hexa`
- [x] V4 final tier ledger — 30 claim (🔵 0 → 4 + 🟢 5 → 12 escalation 예상 V2-bis 후) → `DAPTPGX/verify/V4_tier_ledger.md`

## extension (cycle 6+ auto-seed · V4 §13 후속)

- [x] V5 ICER reconciliation v2 — HBR=0.45 합집합 + S4 de-escalation 통합 sim · ICER V3 -3,221 → V5 -503 M/QALY (6.4× 개선, sign 미반전 → V6 P5 deferred) · C15·C20 🟢 escalation 성공 → `DAPTPGX/verify/V5_icer_reconcile.md` + `DAPTPGX/sims/v5_recompute.hexa`
- [x] M12 special populations — 임산부 · 투석 · 소아 · ultra-elderly subgroups + 결정맵 4D tesseract 확장 → `DAPTPGX/M12_special_pop.md`
- [x] M13 caller cross-tool validation — PyPGx · PharmCAT · Aldy · Stargazer 비교 + head-to-head data gap 정직 보고 + acquisition plan → `DAPTPGX/M13_caller_validation.md`

## fg-loop (cycle 7 foreground sequential · 고갈시까지)

- [x] V6 ICER P5 patch — IM excess 0.008→0.005 double-count fix · closed-form sign 반전 예측 +5,500 M/QALY (V5 -503→ V6 +5,500, sim exec pool-route 차단 → defer) → `DAPTPGX/verify/V6_icer_p5.md` + `DAPTPGX/sims/v6_recompute.hexa`
- [x] M14 frontier scan — CRISPR ex vivo · organ-on-chip · single-cell PGx · 5 NEW axes 정리 · 결정맵 5D→6D 확장 + 한국 unique adoption path (PRS 6th axis 가장 빠름) → `DAPTPGX/M14_frontier.md`
- [x] M15 EMR CDS 구현 spec — CDS Hooks 표준 (HL7) + FHIR · 분당서울대 BESTCare 우선 partner · 5-stage roadmap · break-even ~10 EMR sites → `DAPTPGX/M15_emr_cds.md`
- [x] M16 ABCB1·PON1·CES1·Lp-PLA2 modifier deep dive — PON1 🔴 FALSIFIED · ABCB1 MID (additive 5-8%) · CES1 HIGH for vicagrel 시대 · Lp-PLA2 5D 후보 → `DAPTPGX/M16_modifiers.md`
- [x] M17 AI/ML PGx prediction state-of-art — AUC ceiling 0.80 정체 · 5 NEW axes 통합 hub · M7 cube refinement layer (대체 아님) · 한국 KAMIR cohort leverage · RCT 검증 0건 evidence gap → `DAPTPGX/M17_ai_pgx.md`
