# 2026-05-22 — ALIGNN cross-model 검증: hydride 한계 confirmation (돌파 path 정정)

세션 재개 직후 작업 (직전 crash = macOS APFS purgeable-space 일시 ENOSPC · 재개 시 163Gi free · `~/.claude.json` 139K 정상). pool:ubu-1 으로 heavy ML 이전 (disk-pressure 교훈).

## 가설 & 결과

**가설 (D2 survey)**: ALIGNN+JARVIS pressure-aware 모델이 hydride Tc 를 BETE-NET 의 91-97% miss 보다 잘 예측.

**결과 (FALSIFIED for generic model)**: `jv_supercon_tc_alignn` 은 arxiv:2312.12694 의 high-P hydride 모델이 *아님* — ambient JARVIS-DFT supercon (Choudhary-Garrity ~1058 conventional). hydride 에서 BETE-NET 보다 더 나쁨 (전부 1.5-2.6K cap, ≥98.9% rel_err).

## 환경 (pool:ubu-1)

- DGL torch-2.12 호환 block → torch 2.4 별 venv `~/local/alignn_v2` 로 해소 (dgl 2.4.0 wheel)
- `jv_supercon_tc_alignn` 0.17s/structure (vs BETE-NET 100-ensemble 25-35s · ~150×)
- pip 모델 zoo supercon 4종: tc · edos · debye · a2F — 전부 ambient
- 입력 = D1 publication-grade CIF (Drozdov/Somayazulu/Troyan/Ma) → scp ubu-1

## 3 finding

1. **Cross-model 한계 confirmation** — 독립 2 architecture 둘 다 hydride ≥98.9% under-predict → ambient-trained ML extrapolation 한계 강화 (honest, 돌파 아님)
2. **A15 2-model 일치** — Nb₃Sn 49.6/50.0% · V₃Si 69.7/71.3% → 2-model consensus funnel 가능
3. **ALIGNN OOD 우세** — FeSe 47.5% vs 97% · BaPbO₃ 72% vs 2978% (blowup 없음)

## 돌파 path 재정밀화

- generic ALIGNN 으로 hydride 해소 불가 확정
- (1) arxiv:2312.12694 별도 figshare hydride 모델 (900+ hydride 0-500 GPa · pip 미포함) 획득
- (2) **direct EPW** (pool QE+W90+EPW · MP.md Phase 3) — pressure-aware by construction · ML 훈련분포 무관 · 가장 robust
- (3) jv_supercon_a2F_alignn → Allen-Dynes (sim.hexa) cheap 테스트 (동일 ceiling 예상)

## 산출물

- `exports/material_discovery/rtsc_alignn_vs_betenet_crossmodel_20260522.json` (typed record · absorbed=false)
- `RTSC.md §9.11.H` (§E 가설 정정 + 비교표)
- ubu-1: `~/rtsc_alignn/{run_alignn_compare.py, cifs/, alignn_compare.json}`

R4 보호: 모든 record absorbed=false · gate_type=simulation-only-prediction · domain=material. Pattern 2 회피 — null result 가 돌파 path refine.
