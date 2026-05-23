# LPA — current state

@goal: Lipoprotein(a) 잔여 위험 차단 — 스타틴 + PCSK9 후에도 남는 30% 잔여 위험 표적 + 한국인 Lp(a) 분포 매핑 + 침묵화(ASO/siRNA) 후보 short-list로 2차 예방 패러다임 갱신

## milestones

- [x] Lp(a) 구조 + apo(a) KIV-2 isoform 다양성 → `LPA/M1_structure.md`
- [x] 한국인 Lp(a) 분포 매핑 (KoGES · KARE 등) → `LPA/M2_korea.md`
- [x] ASO 후보 — pelacarsen (HORIZON) · 후속 분자 → `LPA/M3_aso.md`
- [x] siRNA 후보 — olpasiran (OCEAN(a)) · lepodisiran · zerlasiran → `LPA/M4_sirna.md`
- [x] CETP / PCSK9 보조 (obicetrapib · evolocumab Lp(a) 부분 효과) → `LPA/M5_adjunct.md`
- [x] M6 off-target / long-term immune 안전성 → `LPA/M6_safety.md`
- [x] 잔여 위험 정량 — Lp(a) 감소 mg/dL × MACE 위험 감소 → `LPA/M7_quant.md`
- [ ] 통합 후보 ranking + 한국인 임상 적용 전략 → `LPA/M8_rank.md`

## research deepening (cycle 3)
- [x] R1 arxiv deep research → `LPA/R1_arxiv.md`
- [x] R2 web/regulatory (FDA/EMA/MFDS/KSoLA/NHIS + Schoenfeld 🟢) → `LPA/R2_regulatory.md`
- [x] R3 libraries (MR · cohort · PK/PD · ASO/siRNA · ctgov · 28 도구 · inbox 3건) → `LPA/R3_libraries.md`

## simulation (cycle 4 · demiurge 자산)
- [x] S1 siRNA mRNA 분해 ODE — pool ubu-1 dispatch · 4분자 PK/PD → `LPA/verify/V3a_sirna_kinetics.md` (V3a 흡수)
- [ ] S2 MR/IVW Burgess 재계산 — closed-form + atlas 등록 시도 + Monte Carlo CI → `LPA/S2_mr_ivw.md`
- [ ] S3 NHIS ICER Monte Carlo — Lp(a) ↓ × MACE × QALY × 약가 sensitivity → `LPA/S3_nhis_icer.md`

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

- [x] V1 LPA claim inventory + tier triage (45 claims · 🔵 target 8건) → `LPA/verify/V1_claim_inventory.md`
- [ ] V2 🔵 push — Burgess MR closed-form · KIV-2 log · Schoenfeld 🟢 · Lp(a) Δ% identity · IVW estimator → `hexa verify --expr` + atlas register → `LPA/verify/V2_formal_identities.md`
- [x] V3a 🟢 push — siRNA ODE on pool ubu-1 (C10/C13/C15/C16/C27/C43 · 4분자 PK · closed-form steady-state) → `LPA/verify/V3a_sirna_kinetics.md`
- [ ] V3b 🟢 push — MR/IVW Monte Carlo CI bootstrap (C22/C23) → `LPA/verify/V3b_mr_ivw_mc.md`
- [ ] V3c 🟢 push — NHIS ICER Monte Carlo (C26/C34) → `LPA/verify/V3c_icer_mc.md`
- [ ] V4 final tier ledger — 🔵+🟢+🟡 verbatim + 🟠 honest deferred → `LPA/verify/V4_tier_ledger.md`
