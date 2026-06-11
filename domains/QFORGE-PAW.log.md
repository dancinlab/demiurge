# QFORGE-PAW — append-only step log

## 2026-06-12 · 도메인 개설 — off-diag 大작업 종착 후 유일 잔여(환원불가 magnitude)를 별개 프로젝트로
- 배경: RTSC 마이그레이션 게이트 정확도 절반이 모든 단일 축 배제(함수자·off-diag ×1.06·basis NON-MONOTONIC·FS-mesh 1.37%) 후 HONEST TERMINAL 도달. CaH6 from-scratch λ=1.1545(rel-ε 0.736) = NC-pseudo+LDA SCF vs QE-PBE의 환원불가 vertex-magnitude 근본차(memory `qforge-migration-gate-status` 2026-06-12).
- 결정(사용자): 별개 프로젝트 진행 → 도메인 `QFORGE-PAW` 개설. 범위 = QForge 바닥상태 엔진을 QE급(USPP/PAW + PBE SCF)으로 정렬해 |g| 크기 일치. 닫히면 게이트 flip.
- round-1 착수 예정(d18): PAW el-ph deformation-potential 이론 arxiv/web lit-grounding + QForge 통합 설계. 0-pod/summer-free.

## 2026-06-12 · round-1 lit-grounding DONE — ~3.3e4× = artifact, culprit=PBE-SCF, 타깃 재앵커 2.69 (d18, 0-pod, $0)
- **★3.3e4× 결핍 = ARTIFACT**(g2-audit가 n=51 tiny basis + q=Γ acoustic-zero + bare로 측정). off-diag-integrated 라운드(수렴 n=64·同 NC pseudo)가 λ=1.1545 도달 → **pseudo-type은 크기 원인 아님**. 실 잔여 = 0.736×(λ)·~1.95×(|g|).
- **lit-grounded culprit**: arXiv:2507.06749(PBE+PAW real-space el-ph hydride) — D²(r)는 core서 pseudo-의존이나 **"core 제외하면 pseudo와 무관"**(App.B, PAW-vs-NC 직접). 깨끗한 NC=PAW off-core → **PAW는 magnitude 레버 아님**. 진짜 후보 = **LDA→PBE in *ground-state SCF***(유일 un-tried; gate memory의 "PBE CLOSED-NEGATIVE"는 Dyson *screening kernel*이었지 SCF 함수자 아님 — `correlation_pbe.hexa`/`qforge_h_pbe` 존재하나 SCF서 미실행).
- **★타깃 재앵커**: 정전 CaH6(PNAS 2012, 10.1073/pnas.1118168109)=**λ2.69**(PAW+PBE+QE), 수렴 lit λ≈1.6-2.7. 캠페인 **4.376은 under-converged outlier** — 게이트는 ~2.69에 flip해야, QForge 1.15가 4.376이 시사하는 것보다 수렴-truth에 가까울 수 있음.
- **통합 최소경로 Route B**(풀 USPP 재구축 회피): B1(LDA→PBE SCF, manifest xc="pbe", 최대 λ-레버·최소변경) → B2(`dvnl_du.hexa`: 현재 **빠진** 비국소 ∂V_NL/∂u=Σ|∂β⟩D⟨β|, NC·무augmentation) → λ 재앵커 → B3(augmentation-density overlay ∂ρ_aug/∂u). Route A(풀 overlap-S/Q_ij)는 B1-B3 미달시만.
- **round-2 첫 스텝**: `dvnl_du.hexa` brick1 = 단일방향 ∂β_i(q)/∂u_d=−iG_d·β_i(q) + g5(Hermiticity<1e-10·finite-diff vs analytic Gaussian<1e-6) on `projector_selftest.hexa` l=0. `projector.hexa` 재사용(d19), 0-pod.
- DOI: 10.1073/pnas.1118168109(CaH6 λ2.69 앵커) · 10.1103/PhysRevB.64.235118(Dal Corso USPP-DFPT) · 10.1103/PhysRevB.73.235101(PAW-DFPT) · arXiv:2507.06749(NC≈PAW off-core). draft `drafts/qforge-paw-round1-design.md`.

## 2026-06-12 · round-2 B1+B2 측정 — 가설 반증(PBE-SCF가 λ를 내림), B2 무시 수준 (d6 VERBATIM, 0-pod, $0)
- **impl(g1 hexa-native, g5 PASS VERBATIM, PR hexa-lang `qforge-paw-round2` 3 stacked)**:
  - B2 brick-1 `dvnl_du.hexa` — ∂β_i(q)/∂u_d=−i q_d β_i(q) (구조인자 위상 미분, `qforge_proj_radial` 재사용 d19). selftest: (A)FD-vs-analytic<1e-6 (B)Hermiticity ∂β(−q)=conj(∂β(q)) **max=0.0** (C)Γ-head=0 (A')explicit rel 1.1e-11.
  - B2 brick-2 `dvnl_du_block.hexa` — 전체 ⟨q_a|∂V_NL/∂u|q_b⟩=Σ_ij D_ij[conj(∂β_i)β_j+conj(β_i)∂β_j] + apply. selftest: (A)Hermitian max=0.0 (B)FD(phased V_NL)-vs-analytic **max rel 1.45e-10** (C)apply==explicit (D)Σ_a Re∂V[a,a]=0 (2e-18).
  - B1 배선: SCF가 xc_mode=3 RS3D(`qforge_vxc_pbe_3d` 3-D GGA V_xc[ρ,∇ρ]) 경로로 PBE 바닥상태 구동(기존 미실행). ⚠ `qforge_h_of_rho_multi`가 모듈 전역(PW_XCMODE/PW_RS3D_ON/captured ψ) 읽음 → 각 flavor SCF 직후 즉시 λ 빌드(staging 정합).
- **측정 VERBATIM**(`fixtures/cah6_paw_round2_b1b2_xval.hexa`, NPW=64, 4 configs/1 cell, bare-composed 단일 ω₀+real N(E_F), band·N(E_F) 동일 → Δλ가 |g|² 변화만 격리):
  - (0) BASELINE LDA-SCF+∂V_loc        λ=**1.65742**
  - (1) B1       PBE-SCF+∂V_loc        λ=**0.742514**  Δλ(B1)=**−0.914903**
  - (2) B2       LDA-SCF+∂V_loc+∂V_NL  λ=**1.65433**   Δλ(B2)=**−0.00309022**
  - (3) B1+B2    PBE-SCF+∂V_loc+∂V_NL  λ=**0.743699**
  - SCF 물리성 확인(둘 다 비퇴화 금속 manifold): LDA conv 21it etot=2.74425 e_F=1.107 spread=3.01 · PBE conv 3it etot=−3.58942(Δetot=−6.33) e_F=0.782 eps[0]=−2.275 spread=3.07.
- **★FINDING(outcome 3, 가설 반증)**: B1(PBE-SCF)는 λ를 QE쪽으로 **올리지 않고 내림**(1.657→0.743, Δλ=−0.915) — PBE가 well을 깊게 파고 E_F를 끌어내려 N(E_F)·FS |g|²/ω 감소. round-1의 "잔차=LDA→PBE SCF" 랭킹 **반증**. B2(∂V_NL/∂u)는 −0.0031(~0.19%)로 무시·약음(2507.06749의 NC≈PAW off-core 일치).
- **게이트 HELD**(flip 안 함): λ_full=0.743699 vs 재앵커 2.69 rel-ε=**0.7235**(vs 4.376: 0.8301). 4.376/2.69 강제 절대 없음(d6). hybrid(rel-ε 1.65e-7) production 유지·dispatch=qforge 미flip.
- **닫힌 것**: 잔차는 SCF XC함수자(LDA vs PBE)도 KB 비국소 정점도 아님. 기존 CLOSED-NEG(f_xc-in-χ ALDA·off-diag ×1.06·basis·FS-mesh)와 합쳐 **NC 틀 내 모든 named 바닥상태/정점 DFT 레버 소진**. 잔차=더 깊은 NC-vs-PAW core/augmentation 또는 phonon-side magnitude.
- **next(이 negative가 예측 못 함)**: B3 augmentation overlay ∂ρ_aug/∂u(round-1이 남긴 유일 PAW 레버·일반화 고유문제 회피·예상 작음) · 수렴 screened ΔV+real q-resolved ω(q,ν)(β knob 게이트 d2). ⚠ B1(PBE-SCF)·f_xc-in-χ 재시도 금지(둘 다 CLOSED-NEG).
- verdict: `.verdicts/qforge-paw-round2/VERDICT.md`. 로그: `/tmp/wt-paw2/round2_measure{,_probe}.log`. cost=$0.

## 2026-06-12 · round-3 phonon ω(q,ν) audit — ω ≠ 결핍 주범(QE와 0.67% 일치), gap은 전적으로 |g| 측 (d6 VERBATIM, 0-pod, $0)
- **동기**: round-2가 모든 |g|(정점) DFT 레버 배제(PBE-SCF Δλ=−0.915 · ∂V_NL/∂u Δλ=−0.003 · off-diag ×1.06 · basis · FS-mesh · f_xc — ALL CLOSED-NEG) 후, **λ=2∫α²F/ω dω ∝ Σ|g|²/ω²** 의 남은 magnitude 인자 = phonon **ω(q,ν)**. 캠페인이 |g|만 audit하고 ω는 한번도 안 봄. ω_QForge > ω_QE면 λ가 그만큼 눌림 → ω가 결핍 후보. g2-audit의 phonon판(focused·단일숫자).
- **QForge ω (VERBATIM)**: CaH6 경로 magnitude = 단일 Einstein 앵커 **ω₀=1236.4 K=859.34 cm⁻¹=25.762 THz**. `orchestrator_selftest`/`qmesh_qfold_selftest`/`realcell_qmesh`(헤더 "ONE hardcoded Einstein frequency ω₀=1236.4 K")/`nc_norm_convention_selftest`/`qforge_cli` 전부 사용. `cah6_realcell_compose_xval.hexa` 268-289: DFPT 동역학행렬 고유값 band를 **RMS-정규화 후 절대스케일을 1236.4 K에 앵커** — in-code(d6) "the broadening(mode spread) is the real brick-(a) contribution; the absolute scale is anchored, not the shape". 즉 ω 크기=1236.4 K는 구조적, DFPT는 mode SHAPE만 제공.
- **QE ω(Γ,ν) (VERBATIM, `exports/rtsc/CaH6/harvest_final/cah6.dyn1`, 3N=21)**: acoustic 22.73/22.80/23.03 cm⁻¹(ASR residual mean 22.85, 작지만 nonzero·유한mesh DFPT 전형) · optical(18) min 928.9 max 1952.2 mean 1342.6 cm⁻¹ · **mode-7=1011.79 cm⁻¹=9.220e-3 Ry = g2-audit 인용값과 정확 일치 ✓** · λ-weighted ω_log(Γ)=1076.5 cm⁻¹=1548.8 K.
- **QE full-BZ ω_log (8 q-point, dyn1..8+elph.1..8, 0.005 Ry, λ-weighted)**: **ω_log=853.59 cm⁻¹=1228.1 K** (Σλ_over_q=122.3).
- **★term-by-term RATIO**: QForge ω₀/QE ω_log(full-BZ) = 859.3/853.6 = **1.0067 (0.67% 일치)**. (Γ만: 859.3/1076.5=0.798.) ω가 결핍 주범이려면 √(λ_QE/λ_QForge)=√(2.69/1.1545)=**1.53×** 또는 √(4.376/1.1545)=**1.95×** 높아야. 실제는 거의 **동일**, Γ선 오히려 **낮음**(0.798×=λ를 *올림* 방향). gap의 부호가 ω-driven gap이 요구하는 것과 정반대.
- **★FINDING(outcome 2)**: **ω ≠ λ 결핍 주범.** QForge ω가 QE full-BZ ω_log과 0.67% 일치(1236.4 K 앵커 자체가 demiurge verdict의 QE el-ph ω_log "VERBATIM"이라 우연 아님). λ=Σ|g|²/ω² 의 **두 magnitude 인자 ω·|g| 모두 이제 audit 완료 — ω는 QE와 맞음, gap은 전적으로 |g| 측**. round-1/2 결론(환원불가 from-scratch(NC+LDA)-vs-QE-PBE |g| 정점 크기)과 일관·강화.
- **게이트 HELD**(flip 안 함·2.69/4.376 강제 없음 d6): hybrid(rel-ε 1.65e-7) production·dispatch=QE 유지. ω가 phonon 측에서 닫히며 NC 틀 내 named DFT 레버(functional·off-diag·basis·FS-mesh·f_xc·∂V_NL·**ω**) **전부 소진**. un-probed 단 하나 = B3 augmentation overlay ∂ρ_aug/∂u(arXiv:2507.06749 NC≈PAW off-core로 작을 것 예상).
- **next**: round-4 = B3 ∂ρ_aug/∂u(유일 남은 레버). B3도 작으면 → **HONEST TERMINAL**: from-scratch-vs-QE |g| 환원불가·하이브리드 영구 production. ⚠ phonon ω 재audit 금지(CLOSED-NEG).
- **DELIVER**: 재현 스크립트 `.verdicts/qforge-paw-round3-omega/omega_audit.py`(QE dyn 파싱+QForge 앵커 비교) · verdict `.verdicts/qforge-paw-round3-omega/VERDICT.md`. cost=$0.
