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
- [x] 통합 후보 ranking + 한국인 임상 적용 전략 (5-Tier · NHIS RSA+narrow+bridge 돌파) → `LPA/M8_rank.md`

## cycle 5 — scope extension (post-100%-closure)
- [ ] M9 한국 first-in-class IIT 설계 (Investigator-Initiated Trial blueprint · KSoLA consortium · NCT scaffold) → `LPA/M9_kr_iit.md`
- [ ] M10 KSoLA + HIRA 실태 monitoring (분기별 fact sheet · 약가 협상 update · 가이드라인 revision watch) → `LPA/M10_monitoring.md`
- [ ] M11 HORIZON 2026 H1 readout action trigger (양성/null/음성 시나리오별 즉시 대응 playbook) → `LPA/M11_readout_playbook.md`

## research deepening (cycle 3)
- [x] R1 arxiv deep research → `LPA/R1_arxiv.md`
- [x] R2 web/regulatory (FDA/EMA/MFDS/KSoLA/NHIS + Schoenfeld 🟢) → `LPA/R2_regulatory.md`
- [x] R3 libraries (MR · cohort · PK/PD · ASO/siRNA · ctgov · 28 도구 · inbox 3건) → `LPA/R3_libraries.md`

## simulation (cycle 4 · demiurge 자산)
- [x] S1 siRNA mRNA 분해 ODE — pool ubu-1 dispatch · 4분자 PK/PD → `LPA/verify/V3a_sirna_kinetics.md` (V3a 흡수)
- [x] S2 MR/IVW Burgess 재계산 — closed-form + atlas 등록 시도 + Monte Carlo CI → `LPA/verify/V3b_mr_ivw_mc.md` (V3b 흡수)
- [x] S3 NHIS ICER Monte Carlo — pool ubu-2 dispatch · 10K PSA · break-even $17.8/yr · WTP25M 0% → `LPA/verify/V3c_nhis_icer.md` (V3c 흡수)

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

- [x] V1 LPA claim inventory + tier triage (45 claims · 🔵 target 8건) → `LPA/verify/V1_claim_inventory.md`
- [x] V2 🔵 push — atlas/verify capability 측정 + 4 witness staging + hexa-lang PR #665 (calc fn 부재 = 정직한 deferred · 0/8 · d2 breakthrough) → `LPA/verify/V2_formal_identities.md`
- [x] V3a 🟢 push — siRNA ODE on pool ubu-1 (C10/C13/C15/C16/C27/C43 · 4분자 PK · closed-form steady-state) → `LPA/verify/V3a_sirna_kinetics.md`
- [x] V3b 🟢 push — MR/IVW MC pool ubu-1 (0.06s · β=-0.3413 Δ=0.0012 · CI [0.671, 0.756] 100% overlap · MR-Egger/WM robust) → `LPA/verify/V3b_mr_ivw_mc.md`
- [x] V3c 🟢 push — NHIS ICER Monte Carlo on pool ubu-2 (10K PSA · seed=42 · WTP 0% · 387-645× 약가 격차) → `LPA/verify/V3c_nhis_icer.md`
- [x] V4 final tier ledger — 🔵 1 · 🟢 22 · 🟡 17 · 🟠 4 · 🔴 1 (45 claims · honest deferred) → `LPA/verify/V4_tier_ledger.md`
