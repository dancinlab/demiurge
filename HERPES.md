# HERPES — current state

@goal: HSV-1 입술물집 + HSV-2 성기물집 완치법 확립 — 잠복 재활성화 차단 + 신경절 reservoir 제거까지 둘 다 달성 (sterilizing cure)

## milestones

- [x] HSV-1/2 게놈 구조 + LAT locus 매핑 → `HERPES/M1_genome_lat.md`
- [x] 신경절 reservoir 정량화 — per-neuron 게놈 copy → `HERPES/M2_reservoir.md`
- [x] 잠복기 chromatin 상태 모델링 — H3K9me3 · CTCF → `HERPES/M3_chromatin.md`
- [x] 재활성화 트리거 네트워크 시뮬 — HCF-1 · JNK · DLK → `HERPES/M4_reactivation.md`
- [x] CRISPR/메가뉴클레아제 게놈 절단 설계 — Jerome Lab 노선 → `HERPES/M5_crispr.md`
- [x] shock-and-kill — LRA로 잠복 깨우고 면역으로 정리 → `HERPES/M6_shock.md`
- [x] block-and-lock — LAT 영구 침묵화 → `HERPES/M7_lock.md`
- [x] T-cell exhaustion 역전 — PD-1 · LAG-3 신경절 침투 → `HERPES/M8_tcell.md`
- [x] 치료적 mRNA 백신 — BNT163 · mRNA-1608 후속 → `HERPES/M9_mrna.md`
- [x] sterilizing cure 임상 엔드포인트 정의 + 검증 프로토콜 → `HERPES/M10_clinical_protocol.md`
- [x] M11 Müller-Ott rate constant 5-fold sensitivity sweep → `HERPES/M11_sensitivity_sweep.md` (25/25 grid · Arm S cycles [18.94, 21.58] · worst 1.09× baseline · F7 weak-link resolved-deferred · dosing 유지)
- [x] M12 Pre-declared falsifier protocol → `HERPES/M12_falsifier_protocol.md` (11 falsifier · Tier I 5 + II 3 + III 3 · 3 standalone-decisive: F-II-7 post-mortem TG · F-III-10 NHP AAV · F-I-2 LAT-miRNA blood)
- [x] M13 M5 §6 heavy-tail residual 보정 → `HERPES/M13_heavytail_correction.md` (🔵 closed-form R = N·exp(μ+σ²/2)·(1-εφ) = 6897 · MC 6891 (0.084%) · root cause = lognormal mean-vs-median 분리 · 새 Arm S 13-18 cycles · M12 F-I-4 >25 falsifier 여전히 7-12 cycle margin)
- [x] M14 u_crit Jacobian-based bifurcation → `HERPES/M14_jacobian_bifurcation.md` (🔴 V5.3 proxy 0.31 FALSIFIED · 1-D Hill h=2 NO saddle-node · h_c ≈ 3.72 · M4 §5 spec 0.20은 cascade h_eff ≈ 2.03와 일치 · M11 robustness 보존)
- [x] M15 M10 §5.5 falsifier cross-link summary → updated `HERPES/M10_clinical_protocol.md` §5.5 (1-paragraph · M12 11 falsifier 요약 + Popper standard frame)

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

- [x] V1 HERPES claim inventory + tier triage → `HERPES/verify/V1_claim_inventory.md` (248 claims · 25🔵 / 44🟢 / 144🟡 / 35🟠 / 0🔴)
- [x] V2 🔵 push — Poisson · LAT · CRISPR · decay · Hill → `HERPES/verify/V2_formal_identities.md` (5/5 ⚪ fence — hexa verify CLI는 NT-only · 해결 inbox patch 필요)
- [x] V3 🟢 push → `HERPES/verify/V3_numerical_recompute.md` (2/4 🟢: LAT Markov on ubu-1 + 3-comp PK on ubu-2 · 2/4 🟠: cas-offinder/GRCh38 + bio toolchain 미설치)
- [x] V4 final tier ledger → `HERPES/verify/V4_tier_ledger.md` (25🔵 / 44🟢 / 144🟡 / 35🟠 / 0🔴 + 5⚪ · 26 compute-promotable · 9 wet-lab essential)
- [x] V5 cross-tool 2nd-witness round → `HERPES/verify/V5_cross_tool.md` (5/5 sub-jobs · 4/5 🟢 double-witness · 1/5 🟡 partial V5.3 · 2 deferred V5.6/V5.7 tooling)
- [x] V6 CRISPR off-target + bio toolchain → `HERPES/verify/V6_crispr_offtarget.md` (5 spacer · ZERO MM≤2 hits 모두 · g1+g2 UL30 dual-guide 권고 🟢 · g4 NEUROG2 redesign 권고 🔴 · M5 §7 framework 🟠→🟢 promoted)
