# QFORGE=QE white-box 진단 — CaH6 λ 5.47% 발산점 특정

Lane "qe-whitebox". QE 소스(gitlab QEF/q-e, /tmp/qe-src) verbatim 정독 + CaH6 ph.out 중간값 캡처 대조.
c1 root-cause · d6 first-principles · c9 정직(추정 0 · 모든 수치는 캡처/파일:라인).

## (1) QE el-ph 알고리즘 핵심 (파일:라인 verbatim)

### 차폐 = self-consistent DFPT dvscf (Broyden 혼합)
- 드라이버 `PHonon/PH/solve_linter.f90:256` → `CALL dfpt_kernel(...)`.
- 자기수렴 루프 `LR_Modules/dfpt_kernels.f90:243` `do kter = 1, niter_ph`:
  1. `sternheimer_kernel` (line 300) → Δρ_scf (drhos)
  2. `dv_of_drho(dvscftmp, ...)` (line 386/388) → 응답 HXC 포텐셜
  3. `mix_potential(2*ndim_pot, dvscftmp, dvscfp, alpha_mix(kter), dr2, tr2_ph, ...)` (line 404)
  4. `IF (convt) EXIT` — 수렴판정 `dr2 = [(vout-vin)/ndimtot]^2 < tr2_ph` (`mix_pot.f90:83-85`)
- **차폐 커널** `LR_Modules/dv_of_drho.f90`:
  - XC: `dv(ir,is) += dmuxc(ir,is,is1)*drhotot(ir,is1)` (line 350) — f_xc 실공간, GGA는 `dgradcorr` (line 368)
  - Hartree: `dvhart(G) = e2*fpi*drho(G)/(tpiba2*qg2)`, `qg2=|q+G|^2`, qg2>1e-8 (line 191/226-239), G-공간
  - 즉 dvscf = f_xc[Δρ] + v_H[Δρ], 자기무리.
- **Broyden 혼합** `LR_Modules/mix_pot.f90` = modified Broyden(D.D.Johnson PRB 38,12807). w0=0.01, n_iter=nmix_ph.
- **기본값** `PHonon/PH/phq_readin.f90`: tr2_ph=1e-12(251), alpha_mix(1)=0.7(256), nmix_ph=4(258), el_ph_sigma=0.02·el_ph_nsigma=10(273-4).

### |g|² + double-delta + λ
- |g|: `elphon.f90:341` elphel → `el_ph_mat = <ψ(k+q)|dvscf/du|ψ(k)>` (line 344).
- double-delta(가우스곱): `elphon.f90:1058` `exp(-((Ef-εk)²+(Ef-εk+q)²)/σ²)*noint`, `/σ²/π` (line 1062).
- γ_nu = π/2·Σ z*·gf·z (line 1090-1094); **λ_nu = γ_nu/(π·N(Ef)·ω²)** (`elphon.f90:1112` `lamb=gam/pi/w2(nu)/dosfit`).

## (2) QE vs QFORGE 성분별 대조

| 단계 | QE (ph.out 캡처) | QFORGE from-scratch (state 캡처) | 일치? |
|---|---|---|---|
| dvscf 자기수렴 | **conv=true, 8-9 iter, |ddv_scf|²~5e-15 < tr2 1e-14**, alpha_mix=0.30 (ph.out:453-583) | **conv=FALSE, 18 iter, ‖fp_res‖=311, ‖ΔV_scr‖/‖ΔV_bare‖=1.0** (fxc-vertex-recovery log:7) | ❌ |
| 차폐 비 | <1 (물리적 차폐) | 1.0(붕괴)/3.5e7·1.2e9(발산)/0.96-0.98(과약) | ❌ |
| λ (BARE, σ=0.02) | sum_λ(이 q-star)=5.421 | 4.13647 | — |
| λ headline | "4.376" = **외부 상수, 이 ph.out서 도출 불가**(lambda.x 후처리 없음); xval에 하드코딩 (cah6_fxc_in_chi_xval.hexa:31) | 4.13658 | — |

## (3) ★ 발산점 특정 (정직)

**A. QFORGE 차폐 자기수렴이 QE를 못 따라감 = 1차 발산점 (확정).**
QE는 alpha_mix=0.30 Broyden으로 **8-9 iter만에 tr2 1e-14 수렴**(ph.out 모든 q-블록 동일). QFORGE의
Picard/Anderson/exact-Woodbury 고정점은 이 작은 셀서 (a)붕괴(ratio 1.0·커널이 수렴 basis서 소멸,
screening_pwfft.hexa:11-23) (b)발산(metallic gain ρ(L)>1) (c)강제 bound시 과약(0.96-0.98) 중 하나로
귀결 — **QE의 안정 수렴을 재현 못 함**. 이전 진단(‖ΔV_scr‖/‖ΔV_bare‖=1.0)이 정확히 이 지점.

**B. 그러나 "5.47%"의 진짜 출처는 차폐가 아니라 broadening σ + answer-key 정의 불일치 (NEW, 결정적).**
QE ph.out 자체가 보여주는 σ-의존성 (단일 q-star Σλ, 캡처):
  σ=0.005→13.806 · 0.010→7.227 · 0.015→6.465 · 0.020→5.421 · 0.025→4.525
λ가 broadening에 ×3 흔들린다. "4.376" 앵커는 이 ph.out의 **어떤 σ·풀BZ 평균에도 직접 대응 안 됨**
(lambda.x 후처리 산출물, 이 fixture에 부재). 즉 QFORGE 4.137 vs "4.376"의 5.47%는
**(i) 차폐 자기수렴 미수렴 + (ii) σ/BZ-정규화 정의가 두 fixture서 불일치**(xval은 σ=0.010·BZ합 8.516825를
또 다른 "QE λ"로 씀, qforge_cah6_qe_xval_test.hexa:181)의 **합성 잔차**. 단일 "차폐만" 원인 아님.

## (4) 코드 처방 (정확한 레버)

1. **dyson-sc 레인 정답지**: QFORGE 차폐를 QE와 **알고리즘적으로 동일하게** —
   damped Picard/Anderson이 아니라 **`alpha_mix≈0.30`의 modified-Broyden(Johnson) + tr2 수렴판정**으로
   교체. 현재 `screened_dv.hexa:175`는 β linear-mix(β=1 발산); QE는 n_iter=4 Broyden history로 안정화.
   → screened_dv에 mix_pot.f90:160-209의 Broyden(df/dv history + DSYTRF/DSYTRI β-역행렬) 이식.
   단, 이전 캠페인이 exact-Woodbury(conv=true)서도 ratio 0.96·λ 4.15(방향 틀림)를 봤으므로 —
   차폐 안정화만으론 +5.5% 못 메움(CLOSED-NEGATIVE 기록됨, fxc-vertex-recovery/VERDICT).

2. **answer-key 정합 먼저(차폐 코드보다 우선)**: "QE λ" 정의를 **하나로 통일** —
   같은 σ·같은 BZ 정규화로 QE lambda.x를 실제 돌려 4.376의 (σ, nq) 출처를 박제하고, QFORGE도 **동일 σ**로
   대조. 현재 4.376(하드코딩) vs 8.516825(BZ합) vs 4.137(QFORGE)이 **서로 다른 정규화** — 이 불일치를
   먼저 제거해야 "5.47%"가 진짜 물리 잔차인지 정의 차이인지 분리됨. (d6 — 4.376으로 강제 금지.)

**PR 보류(정직)**: 차폐 Broyden 이식은 실코드 변경이나, 이전에 동등 안정화(exact-Woodbury)가 이미
CLOSED-NEGATIVE(방향 틀림)로 박제됨 → 같은 레버 재발사는 d_novel_only 위반. 진짜 다음 수 = (4-2)
answer-key σ/BZ 정규화 통일(QE lambda.x 1회 앵커) 후 동일-σ 재대조. 이게 dyson-sc/gs-chi0 레인의 정답지.

## 출처 (파일:라인)
- QE: /tmp/qe-src/{LR_Modules/dfpt_kernels.f90, dv_of_drho.f90, mix_pot.f90; PHonon/PH/elphon.f90, solve_linter.f90, phq_readin.f90}
- QE 중간값: ~/.hx/src/stdlib/qforge/fixtures/cah6_elph/cah6.ph.out (lines 288,327-8,453-583,1226-1357)
- QFORGE: ~/.hx/src/stdlib/qforge/{screened_dv.hexa:175, screening_pwfft.hexa:11-23, elph.hexa:160}
- QFORGE 캡처: state/qforge-cah6-{fxc-vertex-recovery,dvscf-r5,fxc-localfield-r7,gga-fxc-in-chi}/
