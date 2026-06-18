# Mg2PtH6 — X2MH6 antifluorite el-ph RUNBOOK

| 항목 | 값 |
|---|---|
| 공간군 | **Fm-3m (SG 225)**, K2PtCl6 antifluorite · 9-atom fcc primitive |
| 자리 | Pt @ 4a(0,0,0) · Mg @ 8c(¼¼¼)×2 · H @ 24e 8면체 |
| pseudo | Pt 18e semicore(고ecut) · Mg · H — PseudoDojo ONCV stringent (d13) |

## 절차 (d16 → 금속/반도체 게이트 → d6 → el-ph)
1. `pseudo/` 에 ONCV UPF 배치(Pt 18e). pseudo_dir 확인.
2. **vc-relax** → 완화 celldm(1)+ATOMIC_POSITIONS 를 scf.in/nscf.in 에 반영.
3. **scf** (d16 1-iter free dry-run 먼저) → 수렴.
4. **금속/반도체 게이트 (사활)**: `nscf`(tetrahedra·dense-k) → `dos.x < dos.in`.
   - DOS(E_F) > 0 → **METAL** → 5번 진행.
   - 갭 → **SEMICONDUCTOR** → 무도핑 phonon-SC 없음 = closed-negative 박제, el-ph 중단.
5. **d6 동적안정**: `ph.in` 1-q(Γ) matdyn 허수모드 0 확인 후 풀 q.
6. **el-ph**: 풀 mg2pth6.dyn + elph.inp_lambda.* 수확 → λ/ω_log → Allen-Dynes Tc.

> 무도핑 stoichiometric 타깃(d_novel_only) — 떠도는 78K/108K 는 전자도핑 결과(회피).
> 진짜 발견 = 무도핑 수렴 λ(금속이면 Δ vs λ_Γ proxy / 반도체면 closed-negative).
