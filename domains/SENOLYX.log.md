# SENOLYX — log

Append-only history sister of `SENOLYX.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-06-16 (2) — R12 close-negative 확정 종결 + pod 회수

- [x] R12 K=5 ensemble 10/10 완주: 17AG ABFE 25.02±2.06 · 17AAG 21.88±1.95 → **ΔΔG=+3.13±2.83 (exp −1.9, |err|=5.03, 부호 ❌ FAIL)**.
- [x] R12 + R12-GOLD 마일스톤 🧱 CLOSED-NEGATIVE flip — ensemble로도 sign 불변 = R10b·R11·R12 3독립라인 "거대고리 안사마이신 범용FF 부적합" 확증. tune-to-green 불가(c9/d6).
- [x] vast 6-pod 회수(결과 seen.prog 10/10·RESULT_FINAL_10of10.txt 보존 후 destroy) — 비용정지. R13 5-pod·watcher 무중단.
- [ ] R13(후보 결합)만 잔존 open: MCL1 3rd rep + BCLXL/CRBN 완료 대기.

## 2026-06-16 — vast 재가동 + R12 ensemble + R13 후보 전수 ABFE + 하니스 하드닝

- [x] B4(PTX-222) 근본해결: conda `cuda-version=12.6` 선핀 → vast RTX_4090 가동 (이전 "vast 비가용·summer 단독" 무효화). host CUDA 13.0 < conda기본 13.3 충돌이 진짜 원인.
- [x] R12를 K=5 ensemble로 재구성(run_ens.sh) — vast 6-pod 10셀. 잠정 ABFE(17AG)=25.02±2.06, ΔΔG≈+2.3 (exp −1.9 부호 ❌) → close-negative 수렴중(R10b·R11 FF-부적합 진단 확증 방향). 17AAG solvent leg 마무리중.
- [x] R13 신설 — 후보 전수 ABFE 검증, 일반화 deck(abfe_cand.py) + co-crystal bound-pose(extract_pose.py, rdkit). vast 5-pod 9셀.
- [x] 🟢 R13 MCL-1/S63845 ABFE=−14.18±1.67 (n=2/3) vs 실험 ~−13 → |err|~1.2 일치 = **후보 결합력 첫 계산 확증** (positive). BCLXL(3CQ NaN충돌→bound-pose fix)·CRBN 진행중.
- [x] ABFE 하니스 10-실패모드 하드닝 main 머지: PR #631(6모드: bound-pose·harvest-stdin·copy-verify·retry-resume·ssh-alive·orphan-reap) + PR #637(F7 단일발사·F8 watcher재무장·F9 harvest영속병합·F10 완주auto-down). SSOT=round13 README.
- [ ] R12 ΔΔG 확정(17AAG 완료 대기) · R13 BCLXL/CRBN 완료 + MCL1 3rd rep → 후보별 결합 확정. watcher 무인 수확중.

## 2026-06-07T04:35 — R12 B5 bottleneck quantified (summer RTX 5070 HREX throughput)

Empirical timing of the R12 ΔΔG validation run on summer (only reliable GPU — vast blocked by
B4 CUDA-PTX 222, openfe RBFE blocked by B3 conda hang).

- [x] 17AG complex leg HEALTHY but SLOW — `abfe_complex.nc` mtime fresh (04:34), GPU 243W/100%,
      yet ~8h in (`sampler.run (1000 iters)` since 20:39 KST) with NO `dG_decouple` printed yet.
- [x] `.nc` growth ~14KB / 3min → iterations crawling. R10b's FULL run (complex+solvent, 20 win ×
      1000 iter) converged in 4.95h; summer 5070 is empirically ~5–6× slower on identical protocol.
- [x] B5 (MD throughput) recorded in QFORGE.log.md — this entry adds the SENOLYX-side measured rate.
- [ ] R12 ΔΔG = dG_bind(17AG) − dG_bind(17AAG) vs ΔΔG_exp −1.9(quinone)/−0.65(hydroquinone):
      gated on MD completion (sequential 4-leg on single GPU, ETA many hours). Autonomous harvest
      scheduled (1h cadence) — harvest grep validated vs script line 259 output format.
- harvest constraint: let it finish (d_defer_no_delete) · no fabricate (d6/g63) · no vast (B4) ·
      no co-agent fleet touch.

