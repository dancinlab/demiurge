# SENOLYX R12 RBFE — record skeleton (PREP ONLY · values are placeholders)

> Prep-lane scaffold. **DO NOT commit values until ALL_DONE + ddG_result.json + MBAR converged.**
> `<…>` = placeholder, fill VERBATIM from `analyze_rbfe.py` output. Never fabricate (d6/g63).
> Final record PR is owned by the watch session (branch `senolyx-rbfe-done`); this file is `senolyx-rbfe-prep` input only.

**Context**: HSP90 single-topology RBFE, 17AG↔17AAG (C17 8-atom perturbation, shared 77-atom ansamycin core NOT decoupled — structural fix for the gold ABFE-difference sign flip R12=−1.42 vs gold=+2.74). summer FREE GPU ($0), `~/rbfe-prod/`, deck `exports/SENOLYX/round12-rbfe/rbfe_hsp90.py` (PR #616/#617/#618/#619). 11 λ · 1ns eq · 5ns prod/rep · 3 repeats · 2 legs (complex+solvent) · HREX.

**Sign convention**: `ddG_bind_17AG_to_17AAG_kcal` = ΔG_bind(17AAG) − ΔG_bind(17AG). exp ≈ **+1.9** (17AG binds ~1.9 stronger). PASS = sign(+) AND |ΔΔG − (+1.9)| ≲ 1.5.

---

## VERSION A — if PASS (sign +, in band, converged)

### domains/SENOLYX.md  (R12 milestone line)
- [x] **R12 single-topology RBFE 17AG↔17AAG — PASS, 골드 부호뒤집힘 SUPERSEDED (2026-06-1?, summer-free $0)**: ΔΔG_bind = **<+ΔΔG>** kcal/mol vs exp **+1.9** (|Δ|=<dev>, ≤1.5 band). 부호 양(+) = single-topology가 ABFE-difference(gold +2.74 vs R12 −1.42 부호뒤집힘)를 구조적으로 교정 — 공유 ansamycin 코어 decouple 안 하고 C17 8원자만 섭동 → 계통/bistable 오차 상쇄. MBAR 수렴(overlap min <ov>, cross-repeat sd <sd>). verdict `analyze_rbfe.py`.

### domains/SENOLYX.log.md
## 2026-06-1? · R12 single-topology RBFE — PASS (부호 교정 입증, summer-free $0, d6)
- HSP90 17AG↔17AAG single-topology(C17 8원자 섭동·77원자 코어 유지) HREX RBFE, 11λ·3rep·2leg. **VERBATIM: ΔΔG=<+ΔΔG>±<err> kcal/mol vs exp +1.9** (PASS: 부호+ AND |Δ|=<dev>≤1.5). MBAR overlap min=<ov>·cross-repeat sd=<sd>. 골드 ABFE-difference 부호뒤집힘(R12=−1.42 vs gold=+2.74) SUPERSEDED — single-topology가 계통오차 구조적 상쇄. PR #616-#619. analyze_rbfe.py 진단.

---

## VERSION B — if FAIL / closed-negative (sign −, or out-of-band)

### domains/SENOLYX.md  (R12 milestone line)
- [x] **R12 single-topology RBFE 17AG↔17AAG — CLOSED-NEGATIVE (2026-06-1?, d6 정직·날조 없음)**: ΔΔG_bind = **<±ΔΔG>** kcal/mol vs exp +1.9 (부호/밴드 벗어남). single-topology로도 실험 부호 미재현 = HSP90 ansamycin 17AG/17AAG 차이가 현 FF/sampling 수준에서 더 깊은 closed-negative. 측정값 verbatim, +1.9 강제 안 함. verdict `analyze_rbfe.py`.

### domains/SENOLYX.log.md
## 2026-06-1? · R12 single-topology RBFE — CLOSED-NEGATIVE (정직 d6/g63)
- single-topology HREX RBFE도 부호/밴드 미달: **VERBATIM ΔΔG=<±ΔΔG>±<err> vs exp +1.9**. 골드 부호뒤집힘을 single-topology가 교정 못 함 = 시스템-레벨 더 깊은 잔여(FF 거대고리 정확도 R11 / sampling 수렴 / ansamycin 코어 차이). 측정값 그대로, 날조 금지. 다음 후보(d2): QM-refit FF · 더 긴 sampling · 다른 변이쌍. PR #616-#619.

---

## ⚠ UNDER-CONVERGED case (ddG present, cross-repeat sd > 1.0)
값은 있으나 미수렴 → PASS/FAIL 판정 보류, "🟠 ΔΔG=<…>±<큰err> UNDER-CONVERGED, 더 긴 sampling 필요" 로 기록. 부호 주장 금지.

## Join trigger (watch → this lane)
progress-log `ALL_DONE` + `ddG_result.json` → `python3 exports/SENOLYX/round12-rbfe/analyze_rbfe.py` → verdict를 기록 세션에 전달(walkie/handoff) → 본 PR 통합.
