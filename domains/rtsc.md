# RTSC — axis taxonomy + per-axis progress board

@goal: 상온 상압 초전도체 293K 1atm — 경로 고압 수소화물 파이프라인 검증부터 상압 안정 구조 탐색까지 R4 absorbed false until measured oracle PASS

@engine: QFORGE (hexa-native SCF·DFPT·λ·Tc · stdlib/qforge · NEXUS c7 RTSC←QFORGE) = canonical 계산엔진. QE(Quantum ESPRESSO) = cross-val reference/legacy. 전환 게이트 = QFORGE vs QE λ·Tc g5 일치(LaH10·CaH6·Li2MgH16) 통과 시 full migration. cross-val 통과 전 신규 결과는 QE로 검증 · absorbed 판정은 게이트 후.

## Milestones (progress)

- [x] **QFORGE 엔진 채택 + GATE A PASS** (2026-06-01) — QFORGE L0 Tc ↔ QE 12/12 일치(hexa-lang PR#2362, rel-ε≤2.5e-3). **발견(g6)**: 캠페인 기록 "Allen-Dynes Tc"는 실제 McMillan 하한 = QFORGE 진짜 AD(f1·f2)는 λ-monotone 리프트(Nb +6%→CaH6 +35%) → 기록 Tc 보수적. AD f1·f2 전수 재산정 진행중(QFORGE). 차폐커널 PR#2363(Hartree+LDA-exch). NEXUS c7 verified. 잔여 = L3 |g| (Li2MgH16/LaH10 terminal).
- [ ] **QFORGE 프로덕션 마이그레이션 게이트 — HELD (정직, 2026-06-01 · 상관-XC blocker CLEARED 2026-06-08)** — 프로덕션 경로 구축 완료: el-ph→Tc 오케스트레이터 + selftest(hexa-lang PR#2395), `hexa qforge run` CLI + `dft-run --engine qforge` 라우트(PR#2396, default=qe). 전 selftest verbatim PASS (orchestrator_selftest · qforge selftest λ=4.37654/Tc_AD=344.507K · dft_dispatch_test 5/5 · qforge_qe_xval 10/10 rel-ε≤2.5e-3 · l3_qe_xval λ rel-ε=9.8e-5). **CaH6 end-to-end g5 cross-val PASS** (QE textbook-proof ref λ=4.376/ω_log=1236.4K/Tc): QFORGE 체인 λ rel-ε=**1.2e-4** · ω_log rel-ε=2.2e-6 · McMillan Tc(μ*=0.10/0.13) rel-ε≤**1.1e-4** (캠페인이 기록한 동일 공식 apples-to-apples). **🔴 from-scratch 차폐정점 6-라운드 CLOSED-NEGATIVE (2026-06-08)**: 독립 QFORGE-only CaH6 차폐 λ을 게이트 ≤1%로 못 닫음 — basis(R1 24×→±15%)·kernel(R2 ALDA-floor)·연산자(R3 Adler-Wiser χ₀ bounded)·정규화(R4 Ntot²/Ω ratio=1.0🔵)·자기일관 vertex(R5 Woodbury exact)·phonon-FC(R6) 6 채널 전부 구현+측정. **λ 궤적 4.137(bare)→2.924→2.806→3.094→3.063, 어느 것도 bare 못 넘음**. R6 결정타: 차폐가 H-optical 모드를 **연성화 아닌 경화**(soft_ratio=1.014) → R4/R5 가설 FALSIFIED. 3 채널(vertex 감쇠0.97·phonon 경화1.01·local-field f_xc 죽음) 모두 bare 미돌파. 더 깊은 blocker = local-field f_xc-on-arbitrary-n(pow2-FFT-Poisson @n=645) 벽. verdicts: `.verdicts/qforge-cah6-{aldafloor,rpa-chi0,rpa-chi0-r4,dvscf-r5,phonon-scr-r6}/`. **결론**: bare full-basis vertex(4.137, 5.47% off)가 QFORGE-only 최선 · 게이트급 후보검증 = **하이브리드(QE|g|²→QFORGE L3 조립, rel-ε 1.65e-7)** 가 production 경로. 차폐정점 추가 round = local-field f_xc 벽 해결 필요(별도 대형 작업). **🟢 R7 UPDATE (2026-06-08) — local-field f_xc 死채널 CURED, bare 최초 돌파**: R6 가 명명한 dead-channel(folds=0, ‖f_xc·Δρ‖=0) 의 진짜 blocker 는 pow2-FFT 벽이 아니라 — pow2 padding 은 n=645→grid 32³ 항상 작동 — Woodbury vertex 가 **uniform-gas 스칼라 f_xc head 만** 운반하고 공간변화 f_xc[ρ(r)] convolution(`qpwfft_dvscr_from_dpsi`)을 **호출 안 함**이었다. FIX: `qpwfft_fxc_localfield_from_dpsi`(Hartree 제외 f_xc[ρ(r)]·Δρ, pow2 실공간 FFT, FULL n=645) 신설 + 차폐 vertex 에 배선(Sternheimer→Δψ→fold→ΔV_fxc·ψ). **f_xc-LIVE 검증: folds=24 local-ALDA-folds=24 xc-pts=27648 "ENGAGED — f_xc[ρ(r)]"**. **VERBATIM 결과: λ=4.1518 vs QE 4.376 (rel-ε=5.12%, Δλ vs bare 4.137 = +0.0153 → 7라운드 만에 bare 최초 돌파)** · Tc(AD)=386.65K · Tc(ME)=415.75K. 7라운드 궤적: 4.137→2.924→2.806→3.094→3.063→**R7 4.1518(5.1%, bare 돌파+baseline 5.47%도 beat)**. R5/R6 enhancement 가설 CONFIRMED — dead f_xc 가 누락 물리였음. **게이트 = NOT MET (5.12% > 1%, 비-flip · 4.376 강제 안 함)**; 잔여 5.12% = LDA-vs-QE 차폐-functional 차이(@L5). 하이브리드(1.65e-7)는 여전히 production; R7 = from-scratch 사상 최강 결과(~6× gap 축소). verdict: `.verdicts/qforge-cah6-fxc-localfield-r7/`. **🟠 FULL ε(G,G') MATRIX — IMPROVED, NON-CONVERGED (2026-06-09)**: R7 의 잔여(5.12%)를 명명한 마지막 미시도 구조 레버 = full off-diagonal 유전행렬 ε_{G,G'}=δ−v_c·χ⁰ (Adler-Wiser χ⁰ off-diagonal local-field, dense matrix-Dyson ε⁻¹) 구현+전개. 모든 이전 라운드는 **G-대각** 유전체(Woodbury head / diagonal Poisson / R7 local-f_xc fold)만 — full ε(G,G') 행렬 역산은 미시도였다. 신설 `qpwfft_eps_matrix_screen` (χ⁰ KS-orbital sum via FFT cross-density ρ_vc(G)=FFT[ψ_v·ψ_c], dense Gauss 역산, ε⁻¹ 캐시) + `qpwd_set_full_epsilon` 토글 + fixture `cah6_fulleps_xval` + smoke `eps_matrix_smoke`. **검증: ε NON-SINGULAR (min|pivot|=1.0) · off-diagonal LIVE (‖offdiag ε‖/‖ε‖≈1.3%) · n=645.** **VERBATIM 결과 — χ⁰ conduction-band 수렴 안 됨(NON-MONOTONE): ncond=8 → λ=3.75221 (14.25%, QE 아래) · ncond=16 → λ=4.57638 (4.58%, QE 위).** ncond=16 의 4.58% 가 **from-scratch 차폐 사상 QE 최근접**(R7 5.12% 보다 우수), 하지만 χ⁰ 가 비수렴(off-diag 가중치는 1.28→1.34% 거의 불변인데 χ⁰ magnitude 가 차폐 방향을 뒤집음). **OUTCOME (2): 개선 but 비수렴 — 잔여 = χ⁰ 재료(conduction-band truncation 가 지배적 · f_xc-inside-χ · pseudopotential), 행렬 구조 아님.** 다음 레버(d2) = χ⁰ 를 FULL empty-state (ncond=n−nocc) 또는 Sternheimer-completed χ⁰ (모든 빈상태 implicit) 로 수렴 → off-diagonal local-field 의 진짜 λ 기여 단일값 확정. **🟠 STERNHEIMER-χ⁰ — TRIED + g5-VALIDATED, 벽 유지 (2026-06-09)**: 명명된 마지막 레버 = conduction-truncation-FREE Sternheimer χ⁰ (각 valence v·각 G-pert 마다 (H−ε_v)|Δψ⟩=−P_c·e^{iG·r}|ψ_v⟩ 풀어 모든 빈상태 implicit 합산, ncond 없음). 신설 `qpwfft_eps_matrix_screen_sternheimer` (cosine real-pert ½[c_v(Gi−Gj)+c_v(Gi+Gj)] + Hermitize + 3중 finiteness-guard) + `qpwd_set_sternheimer_chi0` 토글 + fixture `cah6_sternheimer_chi0_xval` + smoke `sternheimer_chi0_smoke`. **g5 정확성 anchor PASS**: Sternheimer χ⁰ 가 EXPLICIT FULL-conduction χ⁰ 와 rel-ε **0.5%** 일치 (G≠0 exact; 잔차는 explicit ref 자체의 G=0 ∫ψ_vψ_c artifact). **실 n=645 결과(cap=64 부분행렬, 512 solve 전부 성공): ε NON-SINGULAR(min|pivot|=0.99990) · ‖offdiag ε‖/‖ε‖=1.63% · ‖ΔV_scr‖/‖ΔV_bare‖=0.9657(차폐 활성, ~3.4% 감쇠) → λ=3.87614 (QE 4.376 대비 rel-ε=11.42%, QE 아래) · ω_log=1370.5K · Tc(AD)=366K.** **OUTCOME (2/3): Sternheimer(ncond-free) LDA 차폐 λ 이 QE 아래(3.876, explicit ncond=8=3.752 와 동방향)로 안착 — 즉 ncond-swing(3.75→4.58)은 QE 를 bracket 한 게 아니라 수렴-방향 LDA 차폐가 QE 아래에 있고 4.58%@ncond16 은 비수렴 합의 우연 over-shoot 였다. 진짜 잔차 = LDA/RPA χ⁰ functional(f_xc-in-χ 없음 = QE DFPT 의 self-consistent KS response 미반영), 수렴축 아님 = DFT-레벨 한계.** full n=645 빌드(5160 solve)는 특정 high-|G| 컬럼에서 interpreter 런타임 fault + 비용으로 **intractable**(d11; isolated n=645 역산은 6.5s 정상 → OOM/역산 아님). **게이트 = NOT MET (차폐 λ≈5.47% > 1%, flip 금지, 4.376 강제 안 함)**. 하이브리드(1.65e-7)가 여전히 production. verdict: `.verdicts/qforge-cah6-sternheimer-chi0/`. 별개로 **V_NL-bound bare-vertex 재실행 = λ=20.04 (357.9% off, 반대방향 발산)** (`.verdicts/qforge-cah6-vnl-bound-rerun/`). **게이트 flip 금지(4.58% > 1%, 4.376 강제 안 함)**. 하이브리드(1.65e-7)가 여전히 production. verdict: `.verdicts/qforge-cah6-full-epsilon-matrix/`.
  - **🏁 DEFINITIVE TERMINAL (2026-06-12) — from-scratch |g| 환원불가 증명, 모든 path 소진**: off-diag assembler 통합(g5 theorem·off-diag lift ×1.06=갭 원인 아님) + 별개 도메인 `QFORGE-PAW` 5라운드(lit 재앵커 QE 4.376→~2.69 PNAS2012 · B1 PBE-SCF Δλ=−0.915 역방향 · B2 빠진 ∂V_NL/∂u −0.003 무시 · ω QFORGE vs QE 0.67% 일치=범인 아님 · B3 augmentation overlay Δλ=0.0 EXACT · Route A 풀 USPP/PAW Δλ=−0.003 **RIGOROUS**: overlap S=1+Σ|β⟩q⟨β| positive-definite ⇒ δ≥0 ⇒ |g| 축소만 가능). **9개 path(NC 8레버 + USPP/PAW Route A) 전부 CLOSED-NEGATIVE — from-scratch(NC/USPP + LDA/PBE) |g| 가 QE 대비 환원불가임이 측정 아닌 증명으로 확정.** ω·|g| 두 magnitude 인자 모두 audit 완료. **하이브리드(QE |g|² → QForge L3, rel-ε 1.65e-7) = 영구 production · dispatch=qe · 게이트 HELD · 4.376/2.69 강제 없음(d6/@L5).** bricks 전부 g5-PASS + hexa-lang main merged(PR#3038·3039·3058·3059·3061·3065·3067·3070). 종착 기록: domain `QFORGE-PAW.{md,log.md}` + memory `qforge-migration-gate-status` + `.verdicts/qforge-{offdiag-integrated,paw-round{1..5}*}/`.
  - **상관-XC blocker (d8 PR#2401) = IMPLEMENTED + g5-VERIFIED (2026-06-08)**: `stdlib/qforge/correlation.hexa` 가 PZ81·PW92 LDA 상관 ε_c/V_c + PBE GGA 상관 H(r_s,t) 를 closed-form 으로 구현. `screening.hexa` 에 배선됨 — `xc_mode`=0(Hartree)·1(+LDA-x)·**2(+LDA-x + PW92-c)** generic 선택(d4, 재료 하드코딩 없음). g5 verbatim PASS: `correlation_selftest` **26/26**(PW92 ε_c vs lit −0.0598/−0.0448/−0.0282/−0.0186 abs<5e-4; V_c analytic=FD abs<1e-7; PZ81≈PW92), `correlation_pbe_selftest` **21/21**(t→0 ⇒ PW92 환원, H 닫힌형, 단조성), `screening_selftest` **23/23**(case G: mode2−mode1 = f_c[ρ]·Δρ 비자명·unknown mode→[] 무날조). cell→|g|² front-end(`pw_frontend.hexa`)도 SCF→Sternheimer DFPT→Anderson-damped Dyson 차폐(x+c)→|g|²→λ 로 배선 완료 — `qforge_pw_frontend_phonons_scr` 가 xc_mode=2(H+x+c) 차폐 vertex 실행. ⇒ **patch 의 "screening = Hartree+LDA-exch only" 전제는 stale; 상관 functional gap = CLOSED.**
  - **독립-경로 CaH6 λ — MEASURED (2026-06-08, 숫자강제 없음 d6/@L5)**: `pw_frontend_selftest` 의 (c) end-to-end 게이트를 **실 CaH6 deck**(`exports/rtsc/decks/CaH6_NC`)으로 완주 — SCF 수렴(n=16, nelec=16, nocc=8, 182 iters, e_band=−14.7504 Ha) → Sternheimer DFPT → Anderson-damped 차폐 vertex(x+c) → |g|² → α²F → λ. **VERBATIM 결과: λ=0.180634 · ω_log=115.91 K · Tc_AD=2.03e-6 K (6-stage trace).** **vs QE 4.376 → rel-ε≈0.959 (~24× LOW MISS).** selftest 는 PASS 이지만 그건 (c)가 **λ>0 조성만 assert**(QE 4.376 정합 assert 아님)이기 때문 — 정합은 통과 못 함. (역사적 추이: 상수 stand-in λ=0.0208 → 진짜 |g| 단일-δ λ=0.000115 → 분산+상관-XC+차폐 vertex 현재 λ=0.18 = ~3 자릿수 개선했으나 여전히 24× MISS.)
  - **게이트 잔여 HELD 사유(d6/@L5 — 정직)**: (1) **상관-XC sub-blocker = CLEARED**(구현+g5+배선). 그러나 (2) **accuracy-half 전체 = NOT CLEARED** — 독립-경로 CaH6 λ=0.18 이 QE 4.376 을 **24× MISS**. ⇒ **상관 functional 만으로는 front-end gap 이 안 닫힘**(@L5 정직 결론). 진짜 잔여 blocker = **차폐 vertex(ε⁻¹-dressed |g|²)의 정량 부족** — QE 의 self-consistent DFPT 차폐 강도를 현재 Anderson Dyson 경로가 재현 못 함(npw_cap=16 tractable-verify basis · Einstein-default ω₀ · 단일-셀 Γ FC 등 front-end 근사 누적). (3) QE 데이터-half: CaH6 **TERMINAL** · **LaH10 = TERMINAL (2026-06-08)** · **Li2MgH16 = TERMINAL (2026-06-09)** — 세 앵커 동시 terminal 達成(아래). data-half 게이트는 이제 3/3 terminal; 잔여 HELD 는 오직 front-end 차폐-vertex accuracy-half(λ=0.18 MISS). dispatch default = qe 유지(차폐-vertex 닫힘 전). `--engine qforge` opt-in 은 이미 동작.
    - **Li2MgH16 QE el-ph data-half — TERMINAL (2026-06-09, @L5 정직 · 숫자강제 없음 d6)**: 2×2×2 q ldisp(8/8 q-points, nat=38 = Li2MgH16 ×2 fu, 114 modes/q, ecut 60/480, k 8×8×8, MP-smear 0.020 Ry) **회수 완료** — 파괴된 vast anchor pod **39610026** 가 kill 전 8 q 전부 완료, dyn1-8 + elph.1-8 로컬 회수(`exports/rtsc/Li2MgH16/harvest_final/`). 검증된 하이브리드 조립기(`qforge_a2f_lambda` 경로, CaH6 rel-ε 1.65e-7 g5 RE-VERIFIED · .elph layout byte-identical)와 동일 결정론적 가중합(QE lambda.x 수식, w_q/W=1/8 ∀q)로 직접 조립(`exports/rtsc/Li2MgH16/harvest_final/assemble_lambda.py`, d19 LaH10 재사용). **primary 0.020 Ry(scf degauss): λ=5.79 · ω_log=741 K · Tc_AD=164 K(μ*=0.10)/158 K(μ*=0.13).** broadening plateau(0.010–0.030 Ry) λ=5.3–5.9. **vs 문헌(Sun 2019, 473 K@250 GPa, λ≈3.3): 8-q coarse mesh = UNDER-CONVERGED(d6 정직, 473 K 강제 안 함)** — λ over-shoot(coarse 그리드가 Γ/small-q 발산에 1/8 과대가중, q1(Γ)=12.07) + ω_log under-shoot(soft small-q 모드가 log-avg 지배) → Tc_AD≈문헌의 1/3. 473 K 도달 = denser q-mesh 수렴 필요. verdict: `.verdicts/qforge-li2mgh16-8q-assembled/`. cost=$0(기 회수 el-ph 로컬 조립, 신규 rent 없음).
    - [ ] **Li2MgH16 dense-mesh 수렴 + 3번째 꼭짓점 독립 QE-λ 승격 (보류·마일스톤 등록만, 2026-06-09)** — 현 8-q(2×2×2)는 coarse(λ=5.79 over-shoot · Tc 164K = 문헌 473K의 1/3, Γ 과대가중). **un-defer = 사용자 go(비용 동반)**: 4×4×4 q QE el-ph 재실행 → (a) λ↓~3.3·ω_log↑ 로 473K 수렴 실증, (b) QE lambda.x 자체 λ 산출로 3번째 삼각측량 꼭짓점을 "검증된-integrator 적용" → "독립 QE-λ cross-val" 승격. 비용 ≈ 38-atom dense-q QE el-ph(GPU pod 다일, ~$수십). 현 상태: tail-삼각측량은 8-q coarse 로 마감(어셈블러 충실도 = CaH6 1.65e-7 전이).
    - **LaH10 QE el-ph data-half — TERMINAL (2026-06-08, @L5 정직 · 숫자강제 없음 d6)**: 2×2×2 q ldisp(8 q-points, Fm-3m, alat=9.64 a.u., 868 k-pts MP-smear 0.01 Ry) **JOB DONE**(2026-06-04 21:57, 모든 dyn1-8 + elph.1-8 회수). QE `electron_phonon='simple'` 출력에서 λ·ω_log·Tc 직접 조립(QE lambda.x 와 동일 결정론적 가중합 — lambda.x 자체는 QE-7.5 DOS-consistency 체크 비호환으로 우회; assembler=`exports/rtsc/LaH10/lambda_terminal/assemble_lambda.py`). **수렴 plateau(broadening 0.025–0.030 Ry, 868 k-pt 전자 smear 0.01 Ry 스케일): λ=3.39–3.87 · ω_log=1009–1014 K · Tc_AD(μ*=0.10)=191–201 K · Tc(μ*=0.13)=182–193 K.** (under-converged 0.005 Ry = λ=4.18/Tc=384 K 는 double-delta 미수렴이므로 비채택.) 측정 Tc=250–260 K@170 GPa 대비 DFT-harmonic 보수 일관(cf. Errea 비조화 보정 상향). 회수=`exports/rtsc/LaH10/lambda_terminal/`(dyn0-8·elph1-8·ph.out·scf.out·sweep). cost=$0(summer pool postprocessing, 신규 rent 없음 — el-ph 본 계산은 기 완료분 회수).
  - **게이트 닫힘 조건(갱신)** = 상관-XC ✅ → 남은 것 = (a) **front-end 차폐 vertex 정량화** — 독립 CaH6 λ 를 0.18→4.376(≤0.5%)로 끌어올림: 후보 = full-basis(npw_cap↑) 차폐 SCF · 진짜 BZ-dispersed FC(Einstein-default 탈피) · 차폐 강도 ε⁻¹ Dyson 수렴 점검(차폐 vertex 가 vertex 를 충분히 dress 못 하는지 검증), 필요시 beyond-LDA/GGA · (b) LaH10·Li2MgH16 QE terminal 후 3-앵커 재실행. d8 패치 = inbox/patches/qforge-correlation-xc.md — **acceptance 1·2(PZ81/PW92 + PBE 상관 + 단위테스트) = DONE; acceptance 3(독립 CaH6 |g|² ≤0.5% xval) = FAILED(λ=0.18, 24× miss) → 차폐-vertex 가 진짜 blocker; acceptance 4(3-앵커 flip) = 잔여**.
- [x] H₃S 측정-grade DFT 6³q — 2015 Drozdov 203K anchor 재현 (Tc_AD 175–195K)
- [x] CaH₆ 측정-grade DFT — Ma 2022 215K vs 213K (2K 정합 · clathrate topology)
- [x] H₃X 5/8 LANDED + d7 wall α²F grid ceiling 100 meV 정량 식별
- [x] BEE-NET grid-extended (101→140 meV) fine-tune launch — Vast 37496985 4-shard
- [x] h3cl 8³q convergence (stable #1 Tc 확정) — ubu-1 ALL DONE · λ_BZ=1.21–1.37 · ω_log~1350K · Tc(μ0.10)=123–140K · broadening plateau · Tc 🟢 hexa verify (allen_dynes_tc=140.324, |Δ|=2.8e-11)
- [x] h3o anharmonic SSCHA 안정화 — imaginary mode (−682 cm⁻¹) renormalization 완료 · imaginary→real 확정 · anharmonic Tc 9–109K (SSCHA-stabilized, M8 1/3) · SSCHA #141 + anharmonic Tc #144 (harmonic λ=2.479 → anharmonic λ=0.52–1.48 붕괴 = stability↔strong-λ 트레이드오프 직접 증거)
- [x] N5 binary-hydride sweep **CLOSED as wall** (§9.16 funnel) — h3cl 140K · h3o 9–109K (SSCHA, M8 1/3) · h3br 110K · h3si 78K 전부 stable이나 Tc<200K · h3po unstable → "stability ↔ strong-λ" 트레이드오프 confirmed (binary 는 RTSC 에 대해 고갈)
- [x] N6 ternary cation-stuffed DFT — **Mg₂IrH₆ ambient 🔴 FALSIFIED** (2026-05-26 · q1-q5/13 · min_freq=−2235 cm⁻¹ · 48% modes hard-imag · Tc 미정의 d6). cation-VEC sweet-spot (VEC=19) 가 σ\* 부분충전 필요조건일 뿐 격자 안정 충분조건은 아님을 first-principles로 확인. Li₂CuH₆ 큐는 Cu UPF 부재 d13 게이트 — 별도 milestone. record: `exports/material_discovery/rtsc_mg2irh6_partial5q_elph_20260526.json`.
- [x] X₂MH₆ family 다음 큐 — Li₂CuH₆ ambient **🔴 FALSIFIED (HARVESTED 2026-06-08)** — 2026-05-26 dispatch 를 pool host `aiden`(구 alias `ubu-1`, `/home/aiden/rtsc_li2cuh6/`)에서 회수. ph.x 는 JOB DONE 아님(q2 representation#3 에서 SIGTERM kill, ~2.75h 만에 — host reboot 추정, ~11일 추정 대비)이나 **q1(Γ) 완주분만으로 d17 게이트 TRIGGER**: g5 결정론 재산정(`q1_terminal/li2cuh6.dyn1` 직접) **min_freq=−944.92 cm⁻¹ · 8/27 modes hard-imag(29.6%) · 깊은 OPTIC 불안정(−945/−916/−643/−583 cm⁻¹)**. Γ elph 도 λ(5,6)=**−2.276 음수**(ω²<0 직접 signature). **Tc_AD = UNDEFINED(허수모드 → α²F·ω_log 형성 불가, d6 숫자강제 없음)** — 86 K lit 예측(others-predicted, 미측정) ambient Fm-3m harmonic 레벨에서 기각. 원인 = **vc-relax 셀 +65.7% 부피팽창**(604.10 a.u.³ vs 초기 364.57, ρ=1.55 g/cm³) — early ω_log↓ 경고가 단순 softening 이 아니라 완전 dynamical instability 로 실현. **F-N6-2 CONFIRMS**: Mg₂IrH₆(F-N6-1, VEC=19, Fm-3m, 🔴)와 합쳐 **X₂MH₆ Fm-3m VEC=19 prototype 이 cation 양축(Mg/Ir·Li/Cu) 모두에서 falsified** → VEC=19 σ\* sweet-spot 은 격자 안정의 필요조건이지 충분조건 아님(first-principles 확정). harvest=`exports/rtsc/Li2CuH6/q1_terminal/` · record=`exports/rtsc/Li2CuH6/rtsc_li2cuh6_q1_terminal_falsified_20260608.json` · cost=$0(기 완료 el-ph 회수, 신규 rent 없음). **re-dispatch 불필요**(Γ 단독 terminal; q2-q13 완주해도 허수 q 만 추가, 이미 Γ 불안정 구조를 구제 못 함). 잔여 d2 paths(별도 milestone): polymorph escape(저대칭 variant·soft-mode condensation) · 가압 안정화(P>0 GPa).
- [ ] 압력 < 50 GPa AND stable(m>0) AND Tc > 200K 후보 발견 · **M8** (refined: stable axis = m>0 anharmonic ESCAPE, not just imaginary-free · `stability_coupling_margin` cf. `RTSC/verify/V5_stability_coupling_wall.md`) — Tc > 200K 충족 후보 0건 (binary N5 stable 후보는 low-Tc / unstable-high-Tc 양분 · d6 honest) → N6 ternary funnel 로 이월
- [x] h3o anharmonic λ 재계산 (SSCHA dyn → ph.x EPC → anharmonic Tc · /gap #1) — SSCHA 안정화 후 필수 후속 (harmonic λ 폐기, anharmonic α²F 로 Tc 재산정)
- [x] h3br ω_log 향상 probe (stable strong-λ base · 압력/lighter substitution → Tc ∝ ω_log) — N5 breakthrough (stable·강λ 확보, ω_log bottleneck 만 남음) — **200 GPa full 4³q el-ph LANDED 2026-05-27**: stable 전 8 IBZ q real (min_freq=5.02 cm⁻¹) · λ_BZ=2.16 (σ=0.025 plateau) · ω_log=1046K · **Tc(μ0.10)=158K · Tc(μ0.13)=148K** (🟢 hexa verify SUPPORTED-NUMERICAL) → 🟢 data point. Γ-only ω_log=1766K 는 full-BZ Allen-weighted 1046K 대비 **41% over-estimate** 확인 → 200K extrapolation 미성립 (ω_log ceiling 가 Tc cap · tropical isocontour). 압력 효과 정량: 69 GPa ~110K → 200 GPa ~158K (sub-linear, λ-saturation 트레이드오프). record `exports/material_discovery/rtsc_h3br_200gpa_fullbz_elph_20260527.json`
- [x] N5 wall 재정의 — λ-포화 → ω_log bottleneck 축 전환 (h3o unstable↔h3br stable-low-Tc 대조 — λ 는 충분, ω_log·dynamical stability 가 진짜 벽) · cf. `RTSC/walls/N5_wall_redefinition.md`
- [x] PROTOCOL discipline 4-doc landed (Tier-3 from /gap full) — `RTSC/protocols/VALIDATION_FIRST.md` (4-gate mandate · pre-dispatch stability_pre_check) + `RTSC/protocols/CANDIDATE_SCORING.md` (5-term composite + JSON schema · F5 closed-loop) + `RTSC/walls/tropical_isocontour.md` (Tc=200K isocontour ASCII plot · F1 min-plus bottleneck) + `RTSC/protocols/ACTIVE_ACQUISITION.md` (info_gain/(cost+time) triage · F7 priority) — next 1순위: **h3br ω_log 향상 probe** (rank_score 0.167)
- [x] wet-lab handoff (Tier 2 recipe-as-record · §8 4-tier 경유) — h3cl recipe `exports/material_discovery/rtsc_h3cl_tier2_wetlab_handoff_20260524.json` · EOS 합성압력 **200.5 GPa @ Tc 구조** pinned (`rtsc_h3cl_eos_im3m_20260524.json`, ubu-1) · pressure-executable (잔여: Cl precursor·metastability = partner/optional)
- [ ] Non-hydride RTSC family pilot (Nb₃Al, MgB₂) — BETE-NET trustworthy frontier 검증 · /gap full F8 (landscape) 응답 · **DISPATCHED + RUNNING (2026-06-08, d16→d17)** — RunPod pod `gw5m1iyxzhfbrn` (16-core CPU, QE 7.5, vast SSH-key 장애로 fallback · d8 handoff [e6aa86d1]). MgB₂(3-atom P6/mmm 6³q) + Nb₃Al(8-atom A15 4³q) PARALLEL. **MgB₂ PARTIAL 15/28 q (lower-bound, weight=1/28): λ≈0.99 · ω_log≈723 K · Tc_AD=49 K(μ*=0.10)/42 K(μ*=0.13) — 측정 39 K 를 이미 bracket, all q stable(min_freq>206 cm⁻¹)** ⇒ 파이프라인 MgB₂ 재현 ✅(강한 partial). Nb₃Al 1/10 q(Γ clean, optical λ 양수) — A15 heavy long-pole 진행중. pod-side `harvest_watch.sh` 자동 λ·Tc 조립(μ*=0.10/0.13). ANCHOR pod 39610026(Li2MgH16) 미접촉. `decks/nb3al/`+`decks/mgb2_pure/` · `domains/RTSC/research/non_hydride_candidates_brainstorm_20260527.md`
- [ ] **Flat-band 상압 RTSC 피벗 — CoSn kagome quantum-geometry 트랙** (anima handoff [8e6ad1b2] 흡수, 2026-06-14) — **방향전환 가설(anima RTSC_01-20, $0 모델)**: hydride RTSC(Li2MgH16 355K@250GPa 등)는 **앱 무용**(상압 아님) → no-cooling(상압+≥300K)이 모든 앱 게이트. **병목 = flat-band E_F 미정렬(ΔE) + 경쟁질서(CDW/자성), 이론 아님**(Törmä quantum-geometry: 고-⟨g⟩ flat band → superfluid-weight 하한 → flat이어도 SC; kagome ⟨tr g⟩=1.33→U≈1.24eV). **처방**: clean base CoSn(비자성/no-CDW) + electron-dope로 flat band E_F 정렬 → ~200-240K 예측(RTSC_14 x≈0.6). **구현 경로**: QFORGE PW front-end(`stdlib/qforge/scf_pw`·`orchestrator_pw`) → 전이금속 kagome 확장(Co d + nspin=2 자성진단). deck = `exports/rtsc/decks/cosn/` (P6/mmm No.191, ibrav=4, a=5.279Å c/a=0.807, Co 3f kagome + Sn 1a/2d, nat=6, ecut 65/520). **1차 측정 = flat-band ΔE vs E_F + ⟨g⟩**(scf nspin=2 → bands), DFPT/λ/Tc는 정렬 후 phase-2. **게이트**: QFORGE vs QE λ/Tc g5 일치(cross-val). **현 상태(2026-06-14) — QFORGE LSDA 엔진 구현+검증 완료**: anima 핸드오프 [bb095261]가 정밀화한 2 blocker 제거.
  - **gap2 (spin-polarized SCF) = DONE+g5**: QFORGE nspin=2/LSDA 4-PR 스택(hexa-lang `qforge-lsda-spin`, `e3917e8b4`→`33f88e288`). PR1 spin PW92 corr+spin LDA exch+shared-EF Fermi · PR2 spin SCF driver(2-channel·magnetization) · PR3 multi-species spin PW closure+entry · PR4 CoSn fixture. g5: xc_spin/smearing_spin/scf_spin/scf_pw_spin selftest 全PASS(회귀 핀 ζ=0≡unpol 1e-12) + **cah6_realcell_spin_xval PASS**(실셀 nspin2≡nspin1: e_total −10.7157·12 evals 1e-5·m=0.0 정확). 기존 selftest 무회귀.
  - **gap1 (pseudo) + 3rd blocker(USPP) = RESOLVED**: QFORGE=NC전용 확인 → deck NC 전환(Co/Sn_ONCV_PBE_sr, ecut 90/360). **SG15 ONCV(UPF v2.0.1) fetch+upf_parse 통과**(summer→mini 데크). gap1 closed.
  - **CoSn run = CONVERGED, number 닫힘(g5, d6 정직)**: 2개 breakthrough(d2) 실행으로 compute 벽 돌파 — PR5 **bare-H cache**(V_loc form-factor ρ-독립 → 1회 조립, cah6 fast≡restricted bit-identical 검증) + **Anderson-per-spin**(metal 수렴 ~3-5× 단축). CoSn **수렴**(iters=12, Anderson+bare-cache): **m=2.9e-5≈0(비자성)·e_total=−122.454 Ha** @ Γ·LDA·σ=0.02Ry. 두 seed(3.0→0.155↓, 1.0→0.00003) 모두 0 = robust.
  - **CoSn cross-val vs QE[33976daa] = 불일치, 원인 규명(d6)**: QFORGE Γ-only-LDA **m≈0** vs QE PBE-k-mesh **m=0.43μB**. 핵심 = **Γ-only SCF**: 이동전자 Stoner 자성은 BZ-적분 N(E_F) 의존 — 단일 Γ점은 flat band(−0.44eV)이 양 스핀 모두 점유라 exchange-split driver 부재 → m≈0(예상된 결과). QE는 k-mesh+PBE(GGA)+작은 σ. ⇒ QE 0.43 재현 = **k-mesh spin SCF(+spin-GGA) = 명시된 다음 capability**(d2). LSDA 엔진·CoSn 파이프라인은 g5 완료; moment-match만 k-mesh gated. flat-band ΔE(NSCF K–M) 동일 capability 의존.
  anima `RTSC/decks/cosn/` + `RTSC/HYPOTHESES.md` RTSC_01-20 xref. NEXUS: anima→demiurge cross-repo는 handoff-only(d19 intra-project 예외).
  - **QE cross-val REFERENCE (anima 핸드오프 [33976daa], RTSC_21, QE 7.5 PBE nspin=2 on summer)** — QFORGE 게이트 타깃 확정: **Co-kagome flat band 확정** E_F=14.7132 eV, flat band45 @14.2697 eV(분산 0.167 eV) → **ΔE=−0.4435 eV**(E_F 아래 0.44 eV), band44 −0.55 eV, 전 경로 Γ-K-M-Γ-A(Γ-A 포함) flat = 진짜 국소 kagome flat band. **mag=0.43 μB**(RTSC_13 ~0.2 eV 부호·차수 확증, 2× 깊음 — CoSn은 비자성-clean이 아니라 약자성). ALIGN=**hole-dope ~0.6-0.8 e/cell**(flat band가 E_F 아래; DOS는 tetrahedron BZ 필요). QE pseudo=Sn.pbe-dn-rrkjus_psl.1.0.0+Co.pbe-spn-rrkjus_psl.0.3.1(USPP). 데이터 summer `~/rtsc_cosn`(scf.out·bands.out·cosn_bands.dat.gnu). **QFORGE 게이트=ΔE≈−0.44 eV·m≈0.43 μB 재현**(NC pseudo 차이 허용) → DFPT λ/Tc → hole-doping sweep로 flat band 정렬 → Tc 예측.
- [ ] F-N6 pre-registered falsifier ledger (F-N6-1..4) — /gap full F4 응답 · `domains/RTSC/falsifiers/F-N6.md` · F-N6-1 (Mg₂IrH₆ PASSED 2026-05-26 PR#247) · F-N6-2 (Li₂CuH₆ PASSED 2026-05-27 PR#275) · F-N6-3 (LaBeH₈ anharm SSCHA Tc≥100K pre-register) · F-N6-4 (h3br pressure-scan ω_log slope ≥0.5K/GPa pre-register)
- [x] Superlattice cell-design protocol (역할분리 가설 — stabilizer clamp + 강결합 H층) — `RTSC/protocols/SUPERLATTICE_CELL_DESIGN.md` (5-step commensurate stacking: sub-layer 독립 relax → ε_lattice<2% match → interstitial H placement [on-top Mg 금지, motif 차용] → LCM stacking AA/AB → stability pre-check gate). mgb2_mgh2 🔴 (Γ −1373×2) = 셀 결함 (on-top Mg naive), 가설 미반증 (d6 honest). 5 deferred 후보 cell-design table (lah_bn · cah6_b · h3as_h3o · mgb2_h3s · h3as_h3o_h3s) — blind-dispatch 금지, protocol 선행. compute $0 (doc only · DFT 다음 round). cf. `RTSC/protocols/VALIDATION_FIRST.md` gate 4 셀-구성 선행
- [ ] h3o SSCHA x2 surgery × x18 ZPE 동시 작동 직접 증명 — anharmonic SSCHA 가 -682cm⁻¹ imaginary mode → +stable 회복하는 단일 사례에서 soft-mode surgery (x2) 와 ZPE 안정화 (x18) 두 메커니즘이 동시 실현됨을 직접 증명 · target: dispatch h3o anharmonic SSCHA + verify Tc bracket 9-109K · provenance: `domains/rtsc.mining.md` cycle 17 E34
- [x] **RTSC-TRIANGULATE — N-dim 독립성-가중 consensus 후보탐색 LANDED** (2026-06-08, NOVEL d18) — 4-bearing(ω_log 강성·N(E_F)·H성·H-연결성·ML-Tc) 교집합 + PCA 유효차원 정직체크. 42 hydride 실행 → DFPT 확정 앵커 4개(Li2MgH16·CaH6·YH9·LaH10) 전부 top-10 재현 = 측량법 검증. 21/21 g5 PASS. 코드 = hexa-lang `stdlib/rtsc/triangulate*`. cf. §11 + [`.discoveries/rtsc-triangulate.tape`]. **한계(d6/L5)**: 조성-only PROXY bearing 중복(유효차원 **1.51/4**, max corr 0.94) → 랭킹 휴리스틱이지 4개 독립측정 아님 → **다음 마일스톤에서 탈상관으로 해소(family 3.08/4)**.
- [x] **RTSC-TRIANGULATE bearing 탈상관 (진짜 N-차원화) — superhydride family 達成** (2026-06-08, d2) — 4개 프록시를 **다른 정보채널의 실제 producer**로 교체(`triangulate_decorr.hexa`, d4 1줄-컬럼 교체·fusion+PCA core 불변): A=force-constant Debye ω(탄성/결합, 평균질량 아님) · B=**real N(E_F)** 문헌/DFT 앵커표(전자구조 채널 — 핵심 swap; CeH9 4f-suppression이 high-h_frac에서 LOW N(E_F) → 조성 lock-step 깨짐) · C=**real H-배위수**(결정구조, sodalite cage 4–6 vs 분자 1–2) · D=독립 feature-basis Tc(EN-spread+VEC, McMillan-over-λ 아님). **측정결과(PCA=truth-teller)**: 유효차원 **1.51 → 3.08/4** on high-Tc superhydride family(real N(E_F)≥1.5, n=21 — DFPT 타깃 고르는 regime), **redundancy warn 해제**, max|corr| 0.94→**0.53**(B↔C 0.94→**0.079**). 독립측정 k개 = 1/k 분산축소 family에서 정식 성립. **정직(d6)**: full 42-set는 **2.04/4**(분자/절연체 tail PdH·H2O·B2H6가 B·C에서 동시소멸 = 실제물리, 중복 아님) — 숫자강제 없음, 측정값 그대로. 68/68 g5 PASS. **남은 단계**: tail까지 올리려면 앵커표→on-the-fly 1-SCF `qforge_dos_nef` + ELF 배위수. cf. f4 [`.discoveries/rtsc-triangulate.tape`].
- [x] **RTSC-TRIANGULATE 앵커표 → TABLE-FREE on-the-fly bearing — full-set 천장 분해(artifact vs physics)** (2026-06-08, d2/d6) — 문헌 N(E_F)/배위 앵커표를 **테이블-프리 producer**로 교체(`triangulate_otf.hexa`, d4 1줄-컬럼·core 불변): **B″**=자유전자가스 N(E_F)(Sommerfeld `g(E_F)=(3/2)N_val/E_F`, V는 원소반경 Wigner-Seitz sphere-sum에서 유도 — 셀 자체 `(N_val,V)`의 도출, **포뮬러별 테이블 없음**)×H-1s 금속화 게이트×EN-gap 절연체억제 · **C″**=기하 H–H 배위(shell부피×ρ_H×H:former **위상** 게이트). **측정(PCA=truth-teller)**: full-set 유효차원 **2.04 → 2.50/4**(순수 기하 B″/C″) — 결정증거 **B↔C 0.80 → −0.19**: 0.80은 **거의 전부 프록시-테이블 인공물**(손-테이블 동반변동), 독립 raw 채널로 계산하면 무상관 → **(a) 인공물 제거**. **그러나** 환원불가 저차원성은 **다른 쌍**에 실재 — 모든 변형에서 **B↔D=0.79**(N(E_F)·feature-Tc 둘 다 가전자수/밴드충전 채널) → **(b) 실제물리**, B,C 분리해도 ~2.5 천장. 분자꼬리 동시소멸은 실재하나 주로 B–C 효과 아님: 순수 밀도배위는 조밀 분자수소물(B₂H₆·SiH₄)을 **고배위로 오순위**(작은 셀→높은 ρ_H, 진실 역전) → H:former 위상게이트로 교정하면 **B↔C 0.66 재결합**·full-set **1.95/4**. ⇒ *올바른 분자순위*와 *최대 B–C 독립*은 **트레이드오프**(공간이 former-chem 축에서 본질적 저차원). **정직 결론(d6/d_paper_negative_ok)**: full-set은 테이블 제거 후에도 ~2.5/4 못 넘김 — **그게 결과**(2.04 = 일부 인공물 + 일부 실제물리). 테이블은 family DFPT-타깃 변별에 우수(3.08), 테이블-프리는 인공물-없는 full-set 측정에 우수 — regime별 부호반전 보고. 랭킹·앵커 top-10 보존. **77/77 g5 PASS**. cf. f5 §11 [`.discoveries/rtsc-triangulate.tape`].
- [ ] **삼각측량 지목 후보 DFPT el-ph 큐 — 경로정정 → QE DFPT + QFORGE 하이브리드 조립 (보류, 마일스톤 등록만 · 비용 등록 2026-06-08)** — RTSC-TRIANGULATE 미확정 top 후보 **CaH10·ScH9·MgH6·SrH10·YH10·ScH6** 의 λ·Tc 확정. **경로정정(2026-06-08, 6-레인+cycle-bg 진단 결과)**: from-scratch QFORGE 차폐정점이 게이트 ≤1%에 못 닿음(CaH6 λ=5.05 = 15.4% over QE 4.376 · 잔여=screening-XC 함수 갭 · 삼중검증 `.verdicts/qforge-cah6-{fullbz-nq4,lindhard}/`). 따라서 후보검증은 **QE DFPT(|g|² 생산) → QFORGE α²F→λ→Tc 하이브리드 조립기(rel-ε=1.65e-7 작동 검증, `sim/qforge_hybrid_lambda_tc.hexa`)** 로 수행 — from-scratch 엔진 완성을 기다리지 않음. **비용 예상(d11·캠페인 패턴)**: 각 후보 = 초수소화물 6~10원자급 QE el-ph(앵커 Li2MgH16/LaH10 패턴) → 후보당 vast GPU pod 다일(~$0.3~6/hr × 1~3일) · 6후보 = 대략 **$수십~$100+ 밴드**(셀크기·q-mesh·병렬-q 샤딩에 의존, dispatch 시점 d11 sizing으로 확정). **하이브리드 경로 = VERIFIED-READY (2026-06-08 종결)**: from-scratch SCREENED 정점은 **6-round CLOSED-NEGATIVE** (`.verdicts/qforge-cah6-{aldafloor,lindhard,fullbz-nq4,dvscf-r5,phonon-scr-r6}/` + bare baseline `qforge-lane1-basis-sweep`; bare 5.47%이 차폐 15~5006%보다 정확 — 차폐가 정확도를 떨어뜨림 · d6 honest). 따라서 **남은 엔진 작업은 0** — hybrid 어셈블러 드라이버(`sim/qforge_hybrid_lambda_tc.hexa`)가 **CaH6 rel-ε 1.65e-7 g5 RE-VERIFIED**(`qforge_cah6_qe_xval_test PASS`)되어 즉시-사용 준비됨. **후보 Tc의 유일한 남은 게이트 = QE DFPT dispatch(비용)이지 엔진 작업이 아님** — 후보가 QE DFPT `.elph` 하베스트를 얻는 순간 `hexa run sim/qforge_hybrid_lambda_tc.hexa <elph_dir> <base> <nq> <sigma> <W> <mu*>` 한 줄로 λ·ω_log·Tc 즉시 산출. cf. QFORGE engine-status SSOT(`QFORGE/QFORGE.md` ⭐ENGINE STATUS) + `QFORGE/HYBRID_VALIDATION.md`. **un-defer 조건**: 사용자 명시 go (비용 동반·user-deferred). 켜지면 후보별 1 deck → QE DFPT dispatch(d17·parallel-q) → 하이브리드 즉시 λ/Tc.
- [ ] measured-oracle PASS → RTSC absorbed=true (최종 d5 invariant 충족)

## verify (🔵 SUPPORTED-FORMAL push · per @D g5 · demiurge 자산 필수)

> RTSC 는 가장 verify-native 한 도메인 — §4 in-flight · §9 5-gate sim stack · §10 d7 wall roadmap 이 native 구현. 아래 V1-V4 는 cross-domain 통일 schema 매핑.

- [x] V1 RTSC claim inventory + tier triage (🔵/🟢/🟡/🟠) — §3 state matrix + §5 per-axis ledger 흡수 → `RTSC/verify/V1_claim_inventory.md` (PR #25 MERGED)
- [x] V2 🔵 push — Eliashberg λ closed-form · McMillan Tc identity · BCS gap ratio 2Δ/kT_c · BEE-NET grid invariant · DFT 충격 boundary → `hexa verify --expr` + atlas register → `RTSC/verify/V2_formal_identities.md` (PR #33 MERGED · supercon fns atlas PR #745 · V2.1 retry 가능)
- [x] V3 🟢 push — Allen-Dynes Tc 10/10 🟢 SUPPORTED-NUMERICAL (h3cl·h3o·h3f·h3si·h3se·h3te·h3po·H₃S·CaH₆ · hexa verify libm, |Δ|≤1e-9) → `RTSC/verify/V3_numerical_recompute.md`
- [x] V4 final tier ledger — V1+V2+V3 통합 (🔵14·🟢30·🟡12·🟠6·🔴3·⚪4) + V2→V3 escalation(PR #745 gap 닫힘) + 🟠 wet-lab→M9 + absorbed=false 정직 명시 → `RTSC/verify/V4_tier_ledger.md`

> **sub-track note — NOVEL-TOOL cross-ref (2026-05-25)**: NOVEL-TOOL 13 stdlib
> primitive (Wheeler 인덕턴스·elliptic 적분·gauss 구적·welford 누적분산 등) 가
> atlas tier 승급 + register 진단으로 land (NOVEL-TOOL#135). 이 primitive 들은
> RTSC 도구 기반 — §5 Axis C 의 "scipy closed-form parallel verifier (Wheeler
> formula on-axis B)" 및 V2/V3 hexa verify recompute 를 가속 (magnet 검증·numerical
> Tc recompute 둘 다 stdlib-native 로 흡수). cross-ref only — RTSC 자체 milestone
> 카운트 변동 없음.

> Root-level domain expansion. SSOT for "the rtsc work" until each axis
> moves to its own UPPERCASE.md (ai-native principle 4 — domain-meta-domain).
>
> opened: 2026-05-21 KST · status: **axis-split in progress**
> parent ticket: rtsc + verify producer 실제 solve 확장 (Path 4)

---

## 0. TL;DR

`domain — RTSC` 라는 이름이 **두 축을 한 슬롯에 욱여넣은 상태**다:

1. **device 축** — 자석 / 코일 (솔레노이드 · 팬케이크 · 토로이드 · dipole · quadrupole)
2. **conductor material 축** — LTS / **HTS** / RTSC(가설) / 일반 Cu

현재 코드 (`RtscGeometry.swift::htsSolenoidProxy`, `pyfemm_magnetics.py`,
`getdp_hts.py`) 는 전부 **HTS 솔레노이드** — 즉 "device=솔레노이드 · conductor=HTS(REBCO 77 K)"
하나의 cell. 그런데 domain id 는 RTSC(Room-Temp, 300 K) 라서 **이름과 내용물의
온도 영역이 정반대**다. RTSC 는 conductor material 축의 한 값(미재현 RT-SC 가설)에
불과한데 도메인 전체 이름이 돼버렸다.

이 파일에서 두 축을 명시적으로 분리하고, 다른 3개 축(solver / verb / formulation)
까지 5축 progress board 로 펼친다. 그리고 **§8 에서 device-side 와 직각으로 놓인
"물질합성 (material synthesis)" 트랙** — 후보 family · 합성 루트 · falsifier
characterization · demiurge↔hexa-rtsc handoff schema · g3 honest stance — 까지
같이 박는다 (코드 SSOT 는 hexa-rtsc 가 가지되, 문서로는 RTSC.md 가 양쪽을 보유).

---

> **Naming note (2026-05-23, scope-shrink decision B)**: 본 도메인 RTSC 는
> *abstract discovery hypothesis* (§9.12 H₃S · §9.15 H₃X 8-fanout · MONDALOY ·
> h3cl novel 등) 와 *concrete cockpit proxy* (HTS REBCO 77K · life-hts/cube ·
> H-formulation) 를 한 우산 아래 함께 다룬다. 현재 cockpit Swift 코드
> (`RtscView3D` · `RtscGeometry` · `RtscVerifyProducer` 등) 는 전부 **HTS
> proxy** — 즉 device=솔레노이드 · conductor=HTS REBCO 77K · formulation=GetDP
> H-formulation cell 하나. RTSC 가설 자체 (상온 R=0) 는 §3.2 material-side 표의
> "Claim-only RT-SC" 칸과 §9 의 fanout 영역에 속하며 **`absorbed=false` 의
> simulation-only-prediction** 상태로 박혀 있다. Swift 파일 prefix rename
> (`Rtsc*` → `Hts*` 또는 `SCMagnet*`) 은 별도 stacked PR 로 분리 처리한다
> — §6 Domain rename plan 의 코드 footprint(71 grep hit · 7 파일) 영역.
>
> ```
> RTSC (도메인 우산)
> ├─ abstract:  discovery 가설 (8-fanout H₃X · MONDALOY · h3cl novel)
> │             → absorbed=false · falsifier preregister · simulation-only
> └─ proxy:     HTS REBCO 77K (cockpit 3D view · GetDP H-formulation · cube/life-hts)
>               → 실제 동작 · cross-check Δ=-1.40% · 본 세션 cell
> ```

---

## 1. Diagnosis (naming collision)

| 증상 | 위치 | 메모 |
|---|---|---|
| domain id "rtsc" 가 device 도메인을 가리킴 | `domains/rtsc.md:1` "RTSC (high-field / superconducting magnet & coil)" | RTSC 는 material category, 도메인 이름 자격 없음 |
| 본문/proxy/producer 가 전부 HTS | `domains/rtsc.md §1 §6` (REBCO · Bi-2212), `RtscGeometry.swift:93` (REBCO HTS tape), `pyfemm_magnetics.py:127` (HTS_proxy), `getdp_hts.py` 파일명 | HTS = 77 K, RTSC = 300 K — 정반대 temperature regime |
| sibling 줄: `room-temp-sc · superconductor` | `domains/rtsc.md:7` | 이건 그래도 "parent 안에 두 material 갈래" 의도지만 parent 이름이 잘못됨 |
| 71 occurrences in cockpit (`grep rtsc`) | LatticeInvariant / RtscGeometry / FalsifierCascade / RtscAnalyzeRecord / RtscVerifyRecord / SiblingRepoSpawner / RtscAnalyze·VerifyProducer / SubstrateLinksLoader / ActionDispatch | rename 시 7+ 파일 + record schema 마이그레이션 필요 |

---

## 2. The 5 axes (proposed split)

### Axis A — device geometry

| 값 | 형상 | 2-D axisym? | 현재 코드 | 진행 가능 (this session) |
|---|---|---|---|---|
| **솔레노이드** | 직사각 단면 환형 권선 | ✓ | `RtscGeometry::htsSolenoidProxy`, `solenoid_axisym.geo` (작성 중) | ✓ — 본세션 작업 cell |
| 팬케이크 | 평면 나선 (radial 권선) | ✓ (z=0 평면) | — | pancake_axisym.geo stub 추가 가능 |
| 토로이드 | toroidal coil (D자형) | ✗ (3-D) | — | 3-D 메쉬 — 별도 cohort |
| dipole | accelerator bending magnet | △ (2-D cross-section) | — | cern 도메인 (별개) |
| quadrupole | accelerator focusing magnet | △ (2-D) | — | cern 도메인 (별개) |

→ **이 도메인의 device 기본값은 solenoid**. dipole/quadrupole 는 `cern` 도메인에 살아야 함 (이미 `CernSynthProducer` 등 분리됨).

### Axis B — conductor material

| 값 | Tc (K) | Jc 모델 | 본 세션 producer 적용 | 메모 |
|---|---|---|---|---|
| Cu (normal) | — | σ(T) (Wiedemann-Franz) | linear nu=1/μ₀ 로 즉시 가능 | baseline |
| LTS NbTi | 9 | Bean / Kim Anderson | μ_r linear 근사 OK <2 T | baseline 코일 |
| LTS Nb₃Sn | 18 | scaling law (Summers/Bordini) | linear 근사 | ITER / 8 T 급 |
| **HTS REBCO** | ~93 | E-J power law (n=20-30), J_c(B,T,θ) anisotropy | **본 세션 cell** — linear μ_r=1 근사 (저전류 한정) | 본 producer 의 default. HONEST: 임계상태/quench 미적용 |
| HTS Bi-2212 | ~85 | E-J power law (n=10-15) | linear 근사 | round-wire 가능 → 등방 |
| RTSC (가설) | ~300 (미재현) | **empirically unproven** | μ_r=1 가정 (재현 미확정) | hexa-rtsc 의 falsifier preregister 영역 (43/43 closure 별개) |

→ producer 입장에서 B 축은 **(a) μ_r 값 결정 (b) source J_phi = N·I / A_coil (c) saturation guard** 3가지로 환원. 본 세션은 (a)=1, (b)=parametric, (c)=경고만.

### Axis C — solver / verification path

| 솔버 | 차원 | 설치 | 본 세션 cell | 메모 |
|---|---|---|---|---|
| **GetDP** | 2-D axisym + 3-D | macOS arm64 binary 다운로드 진행 중 (3.5.0-r) | **본 producer 의 backend** | A-φ formulation; H-A-φ HTS 본해는 multi-week |
| Gmsh | mesh only | brew installed ✓ | mesher 로 사용 | OK |
| pyfemm | 2-D axisym | macOS=blocked (Windows binary + Wine) / Linux pool=OK | 별도 cell (κ-48 analyze) | 이미 platform-gated record 떨굼 |
| Elmer | 2-D/3-D | brew available | 미사용 | 후보 |
| scipy closed-form | analytic | numpy/scipy ✓ | 추가 가능 (cross-check) | Wheeler / Lorentz 공식, on-axis only |
| ANSYS Maxwell / COMSOL | 3-D coupled | 상용 (public docs only) | 미사용 | clean-room 위반 |
| HTS Workgroup `.pro` files | 3-D HTS | downloadable | 미사용 — multi-week scope | 본해 reference |

### Axis D — verb (7-verb spine)

| verb | 현재 producer | 본 세션 작업 |
|---|---|---|
| 명세 SPECIFY | (없음) | stub만 가능 — target field/current/temp spec text |
| 구조 ARCHITECT | (없음) | `RtscGeometry::htsSolenoidProxy` 자체가 architect 산출물 격 |
| 설계 DESIGN | (없음) | 본 세션 범위 밖 (FEMM winding definition 영역) |
| 해석 ANALYZE | `RtscAnalyzeProducer` → `pyfemm_magnetics.py` (Linux pool) | 이미 κ-48 landing, macOS=platform-gated skip |
| 합성 SYNTHESIZE | (없음) | FEM Magnetics Toolbox 영역, FEMM 종속 → 별개 |
| **검증 VERIFY** | `RtscVerifyProducer` → `getdp_hts.py` (record-only) | **본 세션 — 실제 solve 로 확장** |
| 인계 HANDOFF | (없음) | winding/cryostat fab handoff doc — 본 세션 범위 밖 |

### Axis E — formulation (EM physics layer)

| formulation | 차원 | HTS-grade? | 본 세션 |
|---|---|---|---|
| **Magnetostatic A-φ** (linear) | 2-D axisym | ✗ (선형 매질만) | **본 producer 의 default** — 저전류 한정 |
| Magnetostatic A-φ (nonlinear B-H) | 2-D | iron yoke OK / HTS ✗ | 후속 |
| MagDyn A-V (transient) | 2-D/3-D | ramp-loss 가능 | 후속 |
| H-formulation (A. Stenvall) | 2-D/3-D | ✓ HTS E-J power law | hexa-rtsc 의 `numerics_tdgl_vortex.hexa` 와 인접; multi-week |
| H-A-φ coupled (Sirois) | 3-D | ✓ HTS REBCO tape stack | arxiv:0811.2883 — multi-week |

→ 본 세션은 가장 얇은 layer (선형 magnetostatic) 만. 헤드라인 측정: B_center, B_max(on-axis), L = 2W/I².

---

## 3. State matrix (axis × axis)

기호: ✓ done · ◐ in-flight (this session) · ○ workable · ✗ blocked · — N/A

### 3.1 device × verb (device-side)

> 각주 (2026-05-23): 본 테이블의 "HTS" 행 전체 = cockpit Swift proxy (REBCO 77K).
> "RTSC" 행 = abstract 가설 (상온 R=0, 미재현). 두 행이 한 도메인 우산 아래 공존
> — naming note 박스 참조.

|              | 솔레노이드 | 팬케이크 | 토로이드 | dipole | quadrupole |
|---|:---:|:---:|:---:|:---:|:---:|
| Cu  · analyze | ✗ pyfemm macOS-gated | ○ | — (3-D) | — (별 도메인) | — |
| HTS · analyze | ✓ κ-48 record (Linux pool 본해) | ○ | — | — | — |
| HTS · **verify** | ✓ 본 세션 cross-check Δ=-1.40% | ○ | — | — | — |
| HTS · design | ✗ FEMM 종속 | ○ | — | — | — |
| RTSC · verify | ✗ empirically unproven — hexa-rtsc falsifier 영역 | — | — | — | — |

### 3.2 material-side (§8 — 합성/특성평가 트랙)

|              | LTS | MgB₂ | FeSC | HTS Cuprate | Hydride | TBG | Claim-only RT-SC | hexa-rtsc n=6 |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 합성 (synthesis) | ✓ industry | ✓ industry | ✓ lab | ✓ industry | △ DAC only | △ lab | ✗ claim only | — closed-form only |
| Meissner 검증 | ✓ | ✓ | ✓ | ✓ | ✓ (under GPa) | ✓ | ✗ | — |
| device-side ingest | ○ vendor datasheet | ○ vendor datasheet | ✗ | ◐ §8.5 schema | ✗ (압력 풀면 unstable) | ✗ | ✗ never (claim-only) | ✗ never (empirically unproven) |
| demiurge absorbed? | 가능 if datasheet ingest | 가능 | 미정 | 가능 if Jc table | 절대 (device 불가) | 절대 (1.7 K) | 절대 | 절대 |

---

## 4. In-flight (this session, 2026-05-21)

### 4.1 작업 단위 (one cell)
device=**솔레노이드** · conductor=**HTS REBCO (μ_r≈1)** · solver=**GetDP 3.5.0** · verb=**verify** · formulation=**2-D axisym A-φ 선형 magnetostatic**

> 각주 (2026-05-23): 본 cell 의 conductor = **HTS REBCO 77K proxy** (상온 RTSC 가설
> 이 아님). 즉 cockpit Swift 의 `Rtsc*` prefix 가 가리키는 실제 물리는 *HTS 77K*.
> RTSC 가설 (상온) 의 verify 트랙은 §3.2 material-side 표 + §9 fanout 영역.

### 4.2 진행 상태 (세션 종료 시점 스냅샷)

| step | 상태 | 산출물 |
|---|---|---|
| getdp 바이너리 확보 (macOS arm64, Rosetta) | ✓ getdp 3.5.0 (`bin/getdp`, x86_64, Rosetta 경유) | `~/local/getdp/getdp-3.5.0-MacOSX/bin/getdp` (PATH 미등록; `$GETDP_BIN` env로 producer 인식) |
| `solenoid_axisym.geo` 파라메트릭 템플릿 (OCC + BooleanFragments) | ✓ | `~/core/hexa-lang/stdlib/rtsc/templates/solenoid_axisym.geo` |
| `solenoid_axisym.pro` 파라메트릭 템플릿 (Form1P A-φ, axis Dirichlet) | ✓ | `~/core/hexa-lang/stdlib/rtsc/templates/solenoid_axisym.pro` |
| `getdp_hts.py` 5-axis 확장 (closed-form V1 + getdp V2 + 2π post-correction + cross-check) | ✓ | `~/core/hexa-lang/stdlib/rtsc/getdp_hts.py` |
| `RtscVerifyRecord` 5-axis 스키마 | ✓ | `cockpit/Sources/DemiurgeCore/Models/RtscVerifyRecord.swift` |
| `RtscVerifyProducer` nested-dir fix | ✓ | `cockpit/Sources/DemiurgeCore/Loaders/RtscVerifyProducer.swift` |
| 첫 closed-form-only record (FEM install-gated skip) | ✓ | `exports/rtsc/verify/2026-05-21T05-27-14Z/...` |
| **첫 cross-check record (FEM + closed-form)** | ✓ | `exports/rtsc/verify/2026-05-21T06-06-21Z/rtsc_verify_20260521T060621Z.json` |

### 4.2.1 cross-check record headline (V1 closed-form ⨯ V2 getdp FEM)

```
device       = solenoid (L=200 mm · r∈[30,55] mm · 120 turns · I=100 A)
conductor    = rebco_hts_linear_mu1  (HONEST: μ_r=1 가정, HTS critical state 미반영)
solver       = getdp 3.5.0 (Rosetta) + scipy closed-form
formulation  = magstat_a_axisym_linear (Form1P A-φ · VolAxiSqu · OCC mesh)

                  closed-form     FEM            Δ
B_center [T]      0.06939        0.06842        -1.40%   ← excellent agreement
B_max_axis [T]    0.06939        0.06842        (= B_center; both)
L [μH]            431.0 (Wheeler) 340.2 (FEM)   -21%    ← Wheeler은 thin-coil 근사 한계 (b/a=1.83 thick)
W [J]             2.155          1.701          (∝ L)

gate_type        = hexa-native-absent  (D80: getdp 미흡수 — hexa-native EM 커널 없음)
absorbed         = false
measurement_gate = GATE_OPEN
provisional      = true
```

### 4.2.1.b Stage 1+2 cohort 결과 (post-FEM cross-check)

세션 후속에서 5축 cell 을 더 확장 + material 트랙도 평행 진행:

| Stage | Cohort | 산출물 | 핵심 결과 |
|---|---|---|---|
| 1 | M5 (hexa port) | `stdlib/material/sim.hexa` | hexa-native 4-formula port (BCS · McMillan · AD · WHH) — Python sim_adapter 와 **0.0000 K 차** (libm 정밀도) |
| 1 | D1 (HTS Workgroup) | `stdlib/rtsc/templates/hts_workgroup/{benchmark1_tape,life_hts_pancakes_ref}/` | 외부 reference benchmark provenance manifests. **license-unclear → 콘텐츠 vendor 거부**, fetch.sh + gitignored `_external/` 캐시. |
| 1 | M4 (MPRester) | `stdlib/material/mp_query.py` | Materials Project REST API thin adapter. 3-gate path (install · api-key · external-api) 전부 honest skip 검증. |
| 2 | GetDP 4.0.0 ARM | `~/local/getdp/getdp-4.0.0-MacOSARM/bin/getdp` | Apple Silicon native (Rosetta 불필요). `RhoPowerLaw` 내장 → HTS Workgroup .pro 즉시 실행 가능. |
| 2 | F (Tier 4 dispatch) | `MaterialVerdictRecord.swift` + `MaterialFalsifierDispatch.swift` + XCTest 2건 | **Claim-only first verdict (HONEST DEMO · anonymized 2026-05-22 aggressive scrub · historic seed deleted from exports/)** — synthetic claim-only Tier 2 recipe with replicated=0 yields aggregate_verdict=FAILS-AT-LEAST-ONE, F-RTSC-3 replication FAIL, 나머지 SKIPPED-MISSING-INPUT. **absorbed=false 불변** (testAbsorbedAlwaysFalseEvenWithReplication 보호). |
| 2 | G (H-formulation adapter) | `stdlib/rtsc/h_formulation_adapter.py` | 3 skip mode (license-unclear · install-gated · getdp_solve_timeout) — getdp_hts.py 의 gate-landing 상태 유지하면서 별 파일로 H-formulation 진입 경로 확보. |

### 4.2.1.c HTS Workgroup H-formulation 본해 실증 (cube benchmark)

GetDP 4.0.0 + life-hts `cube` benchmark (single SC cube, RhoPowerLaw E-J power law) 로 **진짜 H-formulation transient solve 가 macOS Apple Silicon 에서 동작 확인**:

```
solver        = GetDP 4.0.0 ARM native
benchmark     = life-hts/cube/cube.pro (HTS Modelling Workgroup ref)
formulation   = H-formulation (h-φ MagDyn) · RhoPowerLaw E-J power law
mesh          = 1937 nodes / 5589 elements (3-D tet)
DOFs          = 3601
solver iter   = MUMPS LU (PETSc) · KSP residual ~1.9 → 5e-16 per time-step (수렴)
post-ops      = MagDyn_energy 8/8 per time-step (정상 진행)
gate_type     = hexa-native-absent (D80)
absorbed      = false  (외부 reference benchmark, license-unclear 콘텐츠)
measurement   = transient solve 정상 — full-cycle 완주는 별 cohort
```

→ **세션의 진짜 결론**: 4.2.1 의 linear A-φ FEM cross-check (Δ=-1.40%) 위에 **HTS-grade H-formulation 본해 toolchain 이 완전히 동작**한다는 것을 가벼운 cube benchmark 로 확정. §4.3 의 (s1) "linear magnetostatic — HTS critical state 미반영" caveat 의 *해결 경로가 실제로 열려 있음*. 다음 단계는 cube 본해 결과 풀-사이클 수렴 + life-hts/benchmark1_tape 의 EUCAS REBCO tape 실측 비교.

### 4.2.1.d Cube benchmark **full-cycle 완주 확정** (2026-05-21 후속)

§4.2.1.c 의 "다음 단계 = full-cycle 완주" 가 같은 세션 후속 run 에서 **자연 종료로 달성**:

```
wall_time    = 617.636 s   (10.3 min)
cpu_time     = 558.961 s
memory peak  = 177.703 MB
final_step   = TimeStep 248~249 (t = 0.025 s, AC-cycle 끝)
ksp residual = ~5-8 × 10⁻¹⁶ per step (전 step 수렴)
exit         = GetDP natural `Stopped` (timeout 1800s 도달 X)
last postop  = res/dummy.txt — t=0.025s · 6-PostOp 값 (energy / current / etc.)
```

→ 4.2.1.c 의 "partial-cycle 1/3 (217 of expected ~250)" 가 본 run 에서 풀-사이클 정상 수렴 + GetDP 의 깨끗한 exit 까지 **macOS Apple Silicon native 에서 10 분 안에 종결**. Linux pool 불필요. cube.pro 가 `res/dummy.txt` 에 overwrite-only 로 마지막 step 만 보존 (전 transient 데이터 외부 capture 는 별 cohort) — 본 결과는 *솔버 수렴 + 종료* 자체의 실증.

→ **RTSC.md §4.3 (s1) "linear magnetostatic — HTS critical state 미반영" caveat 의 해결 경로가 코드-레벨 뿐 아니라 솔버 수렴 레벨까지 검증됨**. 다음 단계는 cube postop 출력 capture 보강 + benchmark1_tape EUCAS REBCO tape 실측 비교.

### 4.2.2 디버그 여정 (참고 — 동일 패턴 재발 시 빠른 진단)

5축 producer를 실제 solve로 확장할 때 부딪힌 4가지 함정 — 둘 다 "FEM이 돌긴 도는데 결과가 이상함" 류:

1. **placeholder prefix collision** — `$R_OUT` substitution이 `$R_OUTC`까지 잡아먹어 `0.25C` 라는 invalid identifier 생성. 길이 내림차순 치환으로 해결 (`getdp_hts.py::_render_template`).
2. **gmsh classical kernel edge-recovery 실패** — `Curve Loop` 내부 hole 으로 정의한 coil 경계를 air 표면이 회수 못 함 (19 warnings, "Impossible to recover edge"). **OpenCASCADE + BooleanFragments** 로 air-around-coil 을 사전 stitch 시켜 해결.
3. **Form1P scalar js → 0 RHS** — `js[Coil] = scalar` 로 정의하면 `[ -js[], {a} ]` 가 RHS=0 떨굼 (perpendicular-edge 테스트 함수가 vector라 scalar inner product 가 0). `js[Coil] = Vector[0, 0, J_phi]` 로 perpendicular-z 벡터 명시.
4. **axis(r=0) DOF unconstrained → numerical garbage** — `VolAxiSqu` Jacobian이 r²·A_φ 치환으로 r=0 특이점을 *암묵적으로는* 처리하지만, Form1P node DOF에 명시 Dirichlet 안 걸어주면 axis 근처 B field 가 wild artifact (B_max=0.168 T at z=-0.12, outside coil!). `Constraint Axis → 0` 명시 추가하니 즉시 깨끗해짐 (B_max = B_center, 1.4% closed-form 일치).
5. **VolAxiSqu 2π 누락** — getdp의 axisym Jacobian은 (r,z) 평면 적분만 하고 azimuthal 2π 적분은 user post-multiplication. Stored energy / L 계산 시 producer에서 `w_stored *= 2π` 보정 (`getdp_hts.py` parse 단계).

이 5개 함정은 흔한 패턴이라 RTSC.md 영구 보존. 동일한 5-axis 시각화/검증을 다른 device(pancake, toroid) 로 확장할 때 1·2·5 는 그대로 재발할 수 있음.

### 4.3 honest scope caveats (record 에 반드시 박을 것)

- (s1) 선형 magnetostatic — HTS critical state / quench dynamics 미포함
- (s2) 2-D axisym — leads / support / 3-D return path 미포함
- (s3) μ_r=1 가정 — HTS magnetization (M ≠ 0) 미반영, persistent current 미포함
- (s4) procedural geometry — sourced coil 아님; absorbed=false, GATE_OPEN

---

## 5. Per-axis next-step ledger (this session에서 progress 가능한 것들)

### Axis A — device
- [x] **솔레노이드** geo template 작성
- [x] 솔레노이드 .pro template 작성 — PR #92 (`RTSC/magnet/getdp/solenoid_axisym.pro`)
- [x] **팬케이크** geo stub 추가 (`pancake_axisym.geo`) — 동일 .pro 재사용 가능 — PR #92
- [ ] device enum 추가 (`RtscDevice = solenoid | pancake | toroid`), default=solenoid
- [ ] (deferred) 토로이드 — 3-D 별 cohort

### Axis B — conductor material
- [ ] `ConductorMaterial` enum 추가 (cu | nbti | nb3sn | rebco | bi2212 | rtsc_hypothetical)
- [ ] producer 파라미터로 받아 J_phi 계산에 N·I/A 만 사용 (μ_r=1 공통)
- [ ] record 에 `conductor` 필드 박기 (default="rebco_hts")
- [ ] (deferred) Jc(B,T,θ) data table — 측정/문헌 참조 필요, 별 PR

### Axis C — solver
- [x] gmsh 4.15.2 확보
- [ ] getdp 3.5.0 (다운로드 완료 대기)
- [ ] solver path enum 추가 (`getdp | pyfemm | scipy_analytic`)
- [ ] **scipy closed-form parallel verifier** 추가 (`getdp_hts.py` 에서 cross-check) — Wheeler formula on-axis B
- [ ] (deferred) Elmer 후보

### Axis D — verb
- [x] verify (본 세션)
- 그 외 verb 는 본 세션 범위 밖. 단 record schema 는 4축 (device·conductor·solver·formulation) 동일하게 분리해두면 향후 verb 추가 시 재사용

### Axis E — formulation
- [x] 2-D axisym A-φ 선형 (본 세션)
- [ ] formulation enum 추가 (`magstat_a_linear | magstat_a_nonlinear | magdyn_av | h_formulation`)
- [ ] (deferred) nonlinear B-H — iron yoke 옵션 받을 때
- [ ] (deferred) H-formulation — HTS-grade, multi-week

---

## 6. Domain rename plan (NOT this session)

축 분리만으로는 "이름과 내용이 반대" 문제는 안 풀림. 별도 PR 로:

- **옵션 B (권장)** — domain id `rtsc` → `sc-magnet` (또는 `hts-magnet` / `magnet`). cockpit Rtsc* prefix → Magnet* / SCMagnet*. RTSC(상온) 는 conductor 축의 한 값으로 내려가고, hexa-rtsc 리포는 sibling material 영역 (room-temp-sc + superconductor) 그대로 유지.
- 코드 footprint: 71 grep hit, 7 파일 + record schema (`rtsc_analyze_*.json`, `rtsc_verify_*.json` 파일명 prefix). 마이그레이션 PR 1건 + record codec backward-compat alias 1개.
- `domains/rtsc.md` 헤더 + sibling 줄 + 본문 §1 §6 다시 씀.
- 이 RTSC.md 는 그 PR landing 후 `SC-MAGNET.md` 로 rename + 헤더 disclaimer 갱신.

본 세션에서는 **rename 보류**, 대신 record 에 `domain`, `device`, `conductor`, `solver`, `formulation` 5필드를 모두 박아 *데이터 레벨에서는 축 분리가 이미 끝나 있게* 만든다. 다음 PR 에서 이름만 갈아끼우면 됨.

---

## 7. Cross-reference

- `domains/rtsc.md` — legacy domain doc (rename 대상)
- `~/core/hexa-rtsc/` — sibling material substrate (n=6 closed-form, falsifier preregister, 43/43 closure). **별개 substrate** — 이쪽은 RTSC 물질 자체의 empirical falsifier 트랙.
- `archive/session-notes/cohort-pickup-rtsc-femm-producer.md` — κ-35 pickup note, 본 세션 Path 4 진행의 출발점
- `~/core/hexa-lang/stdlib/rtsc/{getdp_hts.py, pyfemm_magnetics.py}` — substrate SSOT
- `~/core/hexa-lang/stdlib/rtsc/templates/` — `.geo`/`.pro` parametric templates (신설)
- D61 — producer SSOT 위치 정책
- D72 — em-kernel promotion candidate (pyfemm + getdp 2 consumers)

---

## 8. 물질합성 (material synthesis) — domain의 다른 반쪽

지금까지 §1–§7 은 전부 **device-side** (자석/코일 engineering: 주어진 conductor가 있을 때 어떻게 감고 어떻게 자기장을 풀어내는가). 그런데 RTSC 라는 이름의 진짜 출신지는 **material-side** — *어떤 물질이 상온에서 R=0 인가, 그리고 어떻게 만들 것인가*. 이 §은 그 반쪽을 RTSC.md 안에 정합적으로 박는다.

### 8.1 두 트랙의 분리

```
┌──────────────────────────────────┬───────────────────────────────────────┐
│  device-side (이 repo · demiurge) │  material-side (~/core/hexa-rtsc)     │
├──────────────────────────────────┼───────────────────────────────────────┤
│ 입력: conductor record (Tc · Jc · │ 입력: BCS / Eliashberg / DFT 후보       │
│       Hc2 · 이방성 등)           │       물질 family + 합성 레시피         │
│ 출력: B-field map · L · stored E ·│ 출력: T_c 예측 · falsifier 통과 여부 ·   │
│       coil winding/cryostat 사양 │       Meissner / R(T) 데이터           │
│ 도구: gmsh · getdp · pyfemm ·     │ 도구: hexa-lang verify scripts (35개) · │
│       FEM (EM)                    │       arxiv 메타 audit · DFT 외부 호출 │
│ verb 위치: 검증 VERIFY (본세션) +  │ verb 위치: hexa-rtsc 자체가 substrate · │
│             해석/설계 등          │       n=6 closed-form spec PR 형태     │
│ 절대 안 다루는 것: T_c 자체가       │ 절대 안 다루는 것: 코일 권선 / 자력선   │
│   몇 K냐, 합성이 가능하냐         │   배치 / cryostat (= device-side)     │
└──────────────────────────────────┴───────────────────────────────────────┘
```

→ **demiurge 의 rtsc 도메인은 device-side 만 직접 다룬다**. material-side 의 진척은 hexa-rtsc 가 가지고, demiurge 는 그 결과(예: "REBCO Jc(B,T,θ) tape spec record")를 *consume* 한다. 본 RTSC.md 는 양쪽 트랙을 모두 *문서로는* 보유하지만 *코드 SSOT 는 분리*되어 있음.

### 8.2 Candidate material families matrix

| family | Tc 범위 | 대표 화합물 | 합성 난이도 | empirical status (2026-05) |
|---|---|---|---|---|
| **LTS** (저온) | 4–18 K | NbTi · Nb₃Sn · Nb₃Ge | low (industry mature) | ✓ replicated 60+ years · MRI/LHC standard |
| **MgB₂** | ~39 K | MgB₂ (단일 화합물) | low–mid (PIT wire) | ✓ replicated 2001~, 상용화 |
| **Iron-based** (FeSC) | 25–55 K | LaFeAsO · BaFe₂As₂ · FeSe | mid (single crystal hard) | ✓ replicated 2008~, no large-scale device yet |
| **HTS Cuprates** | 77–135 K | YBCO (REBCO) · BSCCO · Hg-1223 | mid–high (텍스처 제어) | ✓ replicated 1986~, 본 데모 producer 의 default |
| **Heavy hydrides** (≥GPa 압력) | 200–260 K | H₃S · LaH₁₀ · CaH₆ · ScH₉ · YH₆ | very high (DAC + 150 GPa) | ✓ replicated 2015~ (Eremets 등), **GPa 압력 풀면 unstable** — device 불가 |
| **Twisted bilayer graphene** | ~1.7 K (UTBG) | TBG @ 1.1° magic angle | high (exfoliation + alignment) | ✓ replicated 2018~ (Cao/Jarillo-Herrero) |
| **Claim-only RT-SC** | 가설 300 K | (anonymized — see RTSC.md §8.9 5-criteria gate) | low (claimed) | **✗ NOT replicated** — any unreplicated RT-SC claim sits in this slot; aggressive-scrubbed 2026-05-22 |
| **hexa-rtsc n=6 candidate** | 가설 300 K | n=6 σ·τ=48 closed-form spec | ? | **closed-form only** — `~/core/hexa-rtsc` falsifier preregister, 합성 sandbox 부재 |

→ 본 producer의 `conductor=rebco_hts_linear_mu1` default 는 위 표의 **HTS Cuprates** 행. RTSC 가설 (claim-only RT-SC · hexa-rtsc n=6) 은 *실제 device 권선의 입력으로 사용 금지* — empirical proof 가 없음. demiurge 가 가설 물질을 "absorbed=true" 로 기록하면 그 자체가 g3 위반.

### 8.3 합성 루트 (synthesis routes)

| 루트 | 적용 family | 대표 장비 | 본 세션 demiurge 영역? |
|---|---|---|---|
| **Solid-state reaction** | Cuprates · MgB₂ · FeSC · claim-only RT-SC families | 박스 furnace · 진공 ampoule | ✗ — material-side만 |
| **Diamond Anvil Cell (DAC)** | Heavy hydrides | DAC + Raman + 라이저 | ✗ — material-side, 압력 풀면 무너짐 |
| **Single-crystal growth** | Cuprates · FeSC · TBG | melt-textured / floating-zone / CVT | ✗ |
| **MOCVD · sputtering · PLD** | REBCO tape · 박막 | reactor · target · 기판 | ✗ (외주 / 상용 tape 매입) |
| **Twisted exfoliation** | TBG | scotch-tape + AFM + 정렬 | ✗ |
| **Sol-gel + 소결** | Cuprates (Bi-2212 round wire) | precursor 합성 + draw + heat | ✗ |
| **합금 가공 (PIT wire)** | NbTi · Nb₃Sn · MgB₂ | drawing / bundling / 열처리 | ✗ |

→ **모든 row 의 demiurge 영역 = ✗**. demiurge 는 합성을 *직접 수행/시뮬* 하지 않음. 합성 결과로 나온 conductor 의 *측정된 spec* 만 consume.

### 8.4 Characterization (falsifier set) — "RTSC인지 어떻게 검증하나"

material-side 의 verify verb. hexa-rtsc 의 35 verify 스크립트 + 6 falsifier (F-RTSC-{1,2,3} + F-SC-{1,2,3}) 가 여기에 정렬됨.

| 테스트 | 측정량 | 통과 조건 (RTSC claim) | hexa-rtsc verifier |
|---|---|---|---|
| **R(T) drop** | 4-probe 저항 vs T | T<Tc 에서 R → 0 (실험 noise 한도) | `verify/empirical_*_arxiv.hexa` (hexa-rtsc archival proxies) |
| **Meissner 효과** | 외부 B-field 차폐 (zero-field-cooled / field-cooled) | χ < 0 (반자성) · 자기 levitation | `empirical_abrikosov_sans_arxiv.hexa` |
| **AC susceptibility** | χ'(T,ω) · χ''(T,ω) | dissipation peak @ Tc | (hexa-rtsc verify pool 포함) |
| **Specific heat 도약** | Cp(T) at Tc | BCS 도약 ΔCp/γT_c ≈ 1.43 | `empirical_specific_heat_arxiv.hexa` · `calc_bcs.hexa` |
| **Isotope effect** | Tc vs isotope mass | T_c ∝ M⁻ᵅ (α ≈ 0.5 BCS) | (BCS 검증 트랙) |
| **Hc2 측정** | resistive transition vs B | WHH 외삽으로 Hc2(0) | `calc_hc2_48t.hexa` · `numerics_whh_full.hexa` · `numerics_hc2_48t*.hexa` |
| **McMillan/Allen-Dynes** | λ · ω_log · μ* 로 Tc 예측 | predicted Tc 일관성 | `calc_mcmillan.hexa` · `numerics_mcmillan*.hexa` |
| **Vortex lattice (Abrikosov)** | STM/SANS 로 vortex 격자 관측 | type-II SC 확인 | `empirical_abrikosov_sans_arxiv.hexa` · `numerics_tdgl_vortex.hexa` |
| **DFT band structure** | first-principles N(E_F) · λ | EM coupling 추정 | hexa-rtsc `verify/numerics_*_dft.hexa` (claim-class numerics) |

→ "RTSC 라고 주장한다" → 위 9개 테스트 중 최소 **R(T)=0 + Meissner + 재현성** 3 개를 동시에 통과해야 함. 미재현 RT-SC 가설은 일반적으로 R(T) 단독 (재현 실패) 까지만 통과 → "claim only" 영역. hexa-rtsc 는 본 9-test 매트릭스의 closed-form 일관성을 43/43 닫았지만 **empirical sandbox 없음** (= 진짜 합성+측정이 없음).

### 8.5 demiurge ↔ material-side handoff schema (planned)

본 세션에서 진짜 wire 는 안 함 — 다음 PR 의 ingredient. 현재는 schema 만 박음:

```yaml
# ~/core/demiurge/exports/conductor/<family>/<stamp>/conductor_<id>.json
domain: conductor
verb: ingest                       # material-side → device-side handoff
kind: rebco_2g_hts_tape
stamp: 2026-XX-XXTXXZ
provenance:
  source_substrate: hexa-rtsc      # or external paper / vendor datasheet
  source_record_url: ...
  vendor: SuperPower / Fujikura / SuperOx / ...
spec:
  family: hts_cuprate
  compound: "YBa2Cu3O7-δ"
  Tc_K: 92.5
  Hc2_T_at_4K: 150
  Jc_data_table_url: ...           # J_c(B, T, θ) typed table
  anisotropy_gamma: 5.0
absorbed: false                    # device-side absorption 별개
gate_type: vendor-datasheet | hexa-rtsc-derived | external-paper
provisional: true
scope_caveats:
  - "Vendor datasheet Jc curves — not per-batch lot-tested"
```

→ device producer (`getdp_hts.py` 등) 가 시작할 때 위 record 를 읽어 `nu[Coil]`, `Jc_limit`, `Hc2_limit` 같은 함수를 채워야 함. 본 세션은 그 단계 전 — `nu=1/μ₀` 상수 + 임계상태 미반영 (s1/s3 caveat 으로 명시).

### 8.6 진행 가능한 작업 (this session에서 actionable / deferred)

#### 본 세션에서 즉시 가능 (record-level)
- [x] §8 작성 — RTSC.md 의 material-side 반쪽 문서화 (본 작업)
- [x] `exports/conductor/` 디렉토리 + handoff schema stub JSON 1개 (HTS REBCO baseline, vendor=null, source=hexa-rtsc-derived) — PR #90 (`exports/conductor/hts_rebco/.../conductor_rebco_hts_baseline.json`)

#### deferred (별 PR)
- [ ] hexa-rtsc 의 `numerics_*_solver.hexa` 35개 verifier 결과를 `exports/conductor/hexa-rtsc-baseline/` 로 ingest 하는 thin adapter
- [ ] `ConductorRecord` Swift 모델 + `ConductorLoader` (DemiurgeCore) — `RtscAnalyzeProducer` / `RtscVerifyProducer` 가 시작 시 conductor record 1건을 인자로 받는 형태로 리팩
- [ ] `ConductorMaterial` enum (§5 Axis B 의 ledger 와 동일) — record 의 `spec.family` 와 1:1
- [ ] vendor datasheet ingest (예: SuperPower 2G HTS tape Jc(B,T,θ) CSV)
- [ ] hexa-rtsc n=6 후보를 `absorbed=false · provisional=true · gate_type=empirically-unproven` 로 import (claim-only 영역 명시 · claim-only RT-SC family slot 동일 contract)

### 8.7 demiurge 영역으로 들이려면 — 4-tier expansion path

§8.3 의 "모든 합성 루트 = demiurge ✗" 는 **현재의 상태이지 영구 한정이 아님**. demiurge clean-room (`DESIGN.md` D1) 은 "public-surface 측정 / 시뮬레이션 / typed record" 까지 허용 — *물리적 합성 자체* 만 바깥. 그래서 4-tier 로 쪼개면 각 tier 가 독립 PR 로 demiurge 영역에 들어올 수 있음.

#### Tier 1 — Computational synthesis (first-principles 시뮬레이션)
- **무엇**: BCS · McMillan · Allen-Dynes · Eliashberg 로 Tc 예측. λ · ω_log · μ* 가 입력.
- **위치**: `~/core/hexa-lang/stdlib/material/{bcs,mcmillan,allen_dynes,eliashberg}.py` (D61)
- **이미 존재**: hexa-rtsc `calc_bcs.hexa` · `calc_mcmillan.hexa` · `numerics_*.hexa` (n=6 closed-form)
- **demiurge ✓ 진입 조건**: hexa-rtsc 의 .hexa 스크립트를 thin adapter (D72 패턴) 로 `exports/material_sim/` 에 떨구는 Python wrapper 1개
- **honest 한계**: 시뮬레이션 결과는 *예측* 이지 *측정* 이 아님 → **absorbed=false 영원히**. gate_type=`hexa-native-absent` (Eliashberg 본해 부재) 또는 `closed-form-only` (BCS).

#### Tier 2 — Recipe-as-record (typed 합성 레시피)
- **무엇**: 합성 단계 (reagent · 비율 · 온도 프로파일 · 분위기 · 시간) 를 typed JSON record. demiurge 가 *직접 합성 안 하지만* 레시피의 SSOT 는 보유.
- **위치**: `exports/synthesis_recipe/<family>/<id>.json` + Codable `SynthesisRecipeRecord` (DemiurgeCore Models)
- **demiurge ✓ 진입 조건**: 레시피는 paper / vendor datasheet 인용 (provenance.source_url 필수). 실행은 외부 lab — demiurge 는 *recipe authoring* + *citation* 만 책임.
- **honest 한계**: 레시피 있음 ≠ 합성 성공. claim-only RT-SC 레시피는 ingest 가능하되 `replicated_by_independent_labs: 0` 명시 → claim-only 영역.

#### Tier 3 — Measurement ingest (외부 측정 결과 흡수)
- **무엇**: R(T) · Meissner χ(T,B) · AC susceptibility · Cp(T) · Jc(B,T,θ) · Hc2(T) 등 §8.4 의 9-test 결과를 typed record 로 ingest.
- **입력**: 외부 instrument csv/json (PPMS · MPMS · 4-probe rig · vendor datasheet)
- **위치**: `exports/measurement/<test>/<sample_id>/<stamp>.json` + `MeasurementRecord` + `MeasurementIngestProducer`
- **demiurge ✓ 진입 조건**: provenance.instrument · operator · sample_id · raw_data_hash 필수. measurement_gate 에 새 값 `MEASURED` 추가 (현재 GATE_OPEN / GATE_CLOSED 외).
- **honest 한계**: 1회 측정 ≠ 재현. `replication_count` 필드 + 독립 lab confirm 후에야 absorbed 후보.

#### Tier 4 — Falsifier dispatch (3-tier 통합 verdict)
- **무엇**: Tier 1 시뮬레이션 ⨯ Tier 2 레시피 ⨯ Tier 3 측정 의 일관성 검사. hexa-rtsc 의 6 falsifier (F-RTSC-{1,2,3} + F-SC-{1,2,3}) 와 1:1 매핑.
- **입력**: 위 3-tier 의 record_id triple
- **출력**: `exports/material_verdict/<sample_id>/<stamp>.json` with `passes_falsifier_set` · `gate_decision`
- **위치**: `cockpit/.../Loaders/MaterialFalsifierDispatch.swift`
- **demiurge ✓ 진입 조건**: 3-tier triple 의 record_id 가 전부 박혀야 dispatch 가능. 하나라도 누락이면 honest skip.
- **honest 한계**: PASS 라도 absorbed=true 가 자동 아님. 별도 cohort 가 `replicated_by_independent_labs ≥ 2` 같은 메타 조건과 결합해 결정.

#### Roll-out 순서 (가장 가벼운 cohort 부터)
1. **Tier 1 thin adapter** — hexa-rtsc `calc_*.hexa` 5개 (BCS · McMillan · Hc2 · claim-only RT-SC · Abrikosov) 결과를 `exports/material_sim/` 로 떨구는 thin adapter (D72 패턴, ROI 견조)
2. **Tier 2 schema + claim-only recipe stub** — Codable + synthetic claim-only recipe 1건 (replicated=false; aggressive-scrubbed 2026-05-22)
3. **Tier 3 ingest + REBCO baseline** — SuperPower 2G HTS tape Jc(B,T,θ) csv 1건 → typed record (vendor datasheet 인용)
4. **Tier 4 dispatch** — 위 3개를 묶어 verdict 떨구는 Swift loader

각 tier 는 독립 PR. 1→2→3→4 순서로 가면 매 단계마다 demiurge 책임 영역이 한 칸씩 늘어남.

#### 4-tier 적용 후 §8.3 재분류

| 합성 루트 | Tier 1 sim | Tier 2 recipe | Tier 3 measure | Tier 4 absorbed? |
|---|:---:|:---:|:---:|:---:|
| Solid-state (claim-only RT-SC 류) | ◐ Eliashberg | ○ recipe | ○ R(T) | ✗ (재현 실패) |
| DAC + 고압 (hydride) | ✗ 압력 DFT | △ recipe (압력 포함) | △ under GPa only | ✗ (device 불가) |
| Single-crystal growth | ✗ | ○ growth spec | ○ Hc2/Jc | △ |
| MOCVD/sputter/PLD (REBCO) | ✗ | ○ deposition recipe | ✓ **vendor Jc** | ✓ **가능** |
| TBG exfoliation | △ flat-band sim | △ angle spec | △ R(T,n) | ✗ (Tc=1.7 K) |
| Sol-gel + 소결 | ✗ | ○ recipe | ○ | △ |
| PIT wire (NbTi/Nb₃Sn/MgB₂) | ✗ | ○ recipe | ✓ **vendor Ic** | ✓ **가능** |

→ **REBCO HTS** 와 **PIT wire (LTS/MgB₂)** 만 4-tier 전부 ✓ 가능 — vendor datasheet 충실 + BCS 시뮬레이션 영역. **claim-only RT-SC / hydride / TBG** 는 Tier 1-3 부분 ✓, Tier 4 absorbed 영역 ✗ (재현성/device 한계).

→ **demiurge 가 가장 가까이서 absorbed=true 까지 갈 수 있는 진짜 길은 HTS REBCO baseline ingest** (Tier 3 SuperPower datasheet) — §8.5 의 handoff schema 가 가리키는 첫 PR이 이 자리.

### 8.8 g3 honest stance (material 축)

- 합성 자체는 demiurge clean-room 의 *바깥*. §8.7 의 4-tier 는 *합성을 둘러싼* typed record / 시뮬레이션 / 검증 만 demiurge 로 들임 — *물리적 합성은 영원히 외부*.
- **RTSC 가설은 never absorbed=true** (구체적 정의는 §8.9 의 5-criteria gate 참조). 미재현 RT-SC 가설 / hexa-rtsc n=6 가 *합성+측정으로* 재현되기 전까지 claim-only (Tier 2-3 까지 ✓ 도달 가능, Tier 4 absorbed ✗).
- HTS REBCO 는 `absorbed=true` 가능하지만, 그러려면 *vendor 측정 Jc(B,T,θ)* 테이블이 Tier 3 record 로 박혀야 함. 본 세션은 그것도 없음 → `nu=1/μ₀` 선형 근사 + s1/s3 caveat 으로 GATE_OPEN 유지.
- 모든 material-side claim 의 source 는 `provenance.source_record_url` 로 추적 가능해야 함. 추적 불가능한 claim 은 ingest 거부.

---

## 8.9 진짜 RTSC absorbed=true 5-criteria gate

§8.8 의 "RTSC 가설 never absorbed=true" 라는 invariant 를 *형식적 정의* 로 강화한다. *진짜 RTSC* (Room-Temperature SuperConductor — Tc ≥ 270 K + ambient pressure) 의 `absorbed=true` 는 다음 5가지 hard gate **전부** 통과해야 한다. 하나라도 SKIP / FAIL 이면 `absorbed=false` 로 강제 lock.

| gate | 조건 | 검증 record 위치 | 현재 상태 (2026-05) |
|---|---|---|---|
| **(a) 합성 가능성** | 화합물 자체가 합성 루트로 *재현* 가능. recipe 가 `replicated_by_independent_labs ≥ 3` | `exports/synthesis_recipe/<family>/<id>.json` (Tier 2) | claim-only RT-SC = 0 · hexa-rtsc n=6 = 0 · hydride = DAC only · **none qualifies** |
| **(b) Tc ≥ 270 K** | resistive transition · Meissner · AC susceptibility 셋 다 *상온 (≥ 270 K)* 에서 SC 거동 관측. measured 값이 사양과 일치 (per-test rel_err < 5%) | `exports/measurement/{r_t, meissner_chi_t, ac_susceptibility}/<sample>.json` (Tier 3) | 현재 어떤 후보도 충족 못 함 |
| **(c) ambient/저압 조건** | 측정 압력 ≤ 1 atm (commercial / device-relevant). DAC GPa 영역의 hydride 는 **자동 FAIL** (device 불가) | measurement record 의 `pressure_GPa` 필드 | H₃S/LaH₁₀ = ~150 GPa → FAIL |
| **(d) 다중 독립 lab 재현** | 측정 결과가 **≥ 3 독립 lab** 에서 동일 sample 또는 동일 합성 recipe 로 재현됨. `replicated_by_independent_labs ≥ 3` AND **independent** (= 다른 기관 + 별 instrument + 다른 sample batch) | Tier 4 dispatch 의 `replication_count_independent` 필드 | claim-only RT-SC = 0 · hexa-rtsc n=6 = 0 |
| **(e) 측정-오라클 parity** | 모델 (Tier 1) vs 측정 (Tier 3) delta < 사전 등록 임계 (default 5%). 솔라 pyranometer (§4.2.1.b 의 absorbed=true 패턴) 동일 형식. **fit-parameter 없는 first-principles model** 권장 | Tier 4 verdict 의 `oracle_parity` block | 진짜 RTSC 의 first-principles model 부재 (Eliashberg 가 d-wave/unconventional 까지 안 미침) |

### 5-criteria gate 의 *결정적* 의미

위 5 gate 의 **AND** 가 `absorbed=true` 의 *유일한* 정문이다. 게이트 위반 시 동작 (코드-레벨 invariant):

```
if !(a && b && c && d && e):
    absorbed = false
    measurement_gate = GATE_OPEN
    gate_type = match first_failed:
      a -> "synthesis-not-replicated"
      b -> "tc-below-270K"
      c -> "high-pressure-only"
      d -> "single-lab-claim"
      e -> "oracle-parity-failed"
```

→ 현 시점 (2026-05) 어떤 후보도 (b)+(c)+(d) 셋 다 동시 통과 불가. 즉 **RTSC absorbed=true 는 물리학이 새 물질을 발견할 때까지 도달 불가**.

### 후보 family 매트릭스 (5-gate 별 현재 상태)

| family | (a) 합성 | (b) Tc≥270K | (c) ambient | (d) ≥3 lab 재현 | (e) parity | absorbed? |
|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **Claim-only RT-SC** | △ paper recipe | ✗ unrepl | varies | **✗ 0 labs** | ✗ no model | **never** |
| **H₃S, LaH₁₀** | △ DAC only | ✓ ~200K | **✗ 150 GPa** | ✓ replicated | △ Eliashberg | **never** (c FAIL) |
| **hexa-rtsc n=6** | ✗ no recipe | — | — | — | — | **never** (a FAIL) |
| **CSH 가설 2020** | ✓ DAC | ✓ 287K (claim) | **✗ 270 GPa** | ✗ retracted 2022 | ✗ | **never** |
| **YBCO/REBCO** | ✓ industry | ✗ 92 K only | ✓ ambient | ✓ many labs | △ d-wave model 한계 | (LTS/HTS, **RTSC 아님**) |
| **Nb** | ✓ industry | ✗ **9.25 K** | ✓ ambient | ✓ many labs | ✓ BCS universal | (LTS, **RTSC 아님**) |

→ Nb · REBCO 는 (a)+(c)+(d)+(e) 통과 가능하지만 **(b) Tc ≥ 270 K 가 본질적 FAIL** — 즉 RTSC 가 아닌 것. 본 세션의 `lts_nb_bcs_universal_gap_ratio_attestation` 은 **LTS attestation 일 뿐 RTSC 가 아님** (§8.10).

### 유의사항 (claim 평가 시 흔한 honest 함정)

1. **DAC-pressure SC ≠ RTSC**. 하이드라이드 superconductivity (H₃S 2015, LaH₁₀ 2019) 는 ~150-170 GPa 압력 하에서만 존재. 압력 풀면 분해 → device 불가. (c) 가드가 이를 *영구* 거부.
2. **단일 lab 측정 ≠ 검증**. 어떤 RT-SC claim 도 *동일 lab single-shot* (R(T) drop 영상 + Meissner 사진 만으로는 불충분) 은 본 §8.9 의 (d) gate "≥ 3 독립 lab" 요구를 만족 못함 — 사진 다수 ≠ 독립 재현.
3. **합성 성공 ≠ SC 성공**. 가설 화합물 자체는 다수 lab 이 합성 성공해도, SC 특성 (R=0 + Meissner + 비열 도약) 이 *어디서도 재현 안 되면* (b) 실패.
4. **claim 의 부분 통과는 통과 아님**. 일부 sample 에서 "diamagnetic response 관측" 이라는 보고가 있어도 *완전 R=0 + 완전 Meissner + Cp jump* 3-test 동시 통과 없으면 (b) FAIL.
5. **closed-form spec ≠ recipe**. hexa-rtsc 의 n=6 σ·τ=48T 닫힌 형식 spec 은 *합성 루트가 없음* — 어떤 화합물이 그 spec 을 satisfy 하는지 미지정. (a) 영구 FAIL.
6. **이론 prediction ≠ measurement**. Tier 1 (sim_adapter / sim.hexa) 의 BCS/McMillan/Allen-Dynes/Eliashberg 결과는 모두 *예측*. (e) parity 는 model 측 만 채우며, (b)+(c)+(d) 가 동시에 측정 측을 채워야 통과.
7. **graphene 류 도 RTSC 아님**. Twisted bilayer graphene (Cao 2018) Tc ~ 1.7 K. fancy 물질이라도 (b) 미달.

→ 향후 어떤 RTSC 후보가 등장하면 본 §8.9 의 5-gate matrix 에 row 추가, 5-gate 각각 결과 명시. 통과 row 가 *발생하면* 그때 absorbed=true 후보 — 그 전까지 §8.8 invariant 그대로.

> **NUCLEAR×RTSC bridge (2026-05-25)**: SHE/장수명 nuclear isomer 는 §8.9 (a) bulk 합성 시료를 영구 공급 못함 — 벽은 반감기 아닌 *생산량* (SHE = atom-at-a-time, <20 원자; 거시 결정과 10¹⁵+ 배 격차). SHE single-atom 화학은 실재하나 bulk SC 아님 (원자 1개엔 Tc 미정의). 상세: `exports/nuclear_discovery/bridge/2026-05-25-nuclear-rtsc-bridge.md` · NUCLEAR.md §3.4.

## 8.10 Nb attestation 은 RTSC 가 아니다 (honest 정정)

본 세션의 `lts_nb_bcs_universal_gap_ratio_attestation` 산출물 (`exports/material_attestation/nb_bcs_v1/`, paper `PAPERS/sample-nb-bcs-absorbed/`) 의 **honest 정정** 기록.

### 무엇이 잘못 표현됐나
- attestation record 의 `domain` 필드가 `"rtsc"` 로 박혀 있음. 이는 §1 진단의 **naming collision** 결과 (도메인 id `rtsc` 가 실제로는 device/magnet 영역을 가리킴) — 즉 *namespace ID* 일 뿐 *materials category* 가 아님.
- paper 의 abstract 가 "first RTSC-domain absorbed=true" 라고 표현 — *RTSC 도메인 안의 첫 absorbed=true* 의 의미인데 *RTSC material* 로 오독될 소지.

### 정확한 사실
- Nb 의 임계 온도는 **9.25 K** (LTS, 액체 헬륨 영역) — RTSC.md §8.9 의 (b) gate 통과 *불가* (절대 9.25 ≪ 270 K).
- 따라서 Nb attestation 은 §8.9 의 5-criteria 평가 시 **(b) FAIL → absorbed=true 자격 없음** (만약 §8.9 의 5-gate 로 평가했더라면).
- 본 attestation 이 absorbed=true 를 받은 이유는 *다른 게이트* (BCS 보편 비 parity 5% threshold) 를 통과했기 때문 — 이는 *BCS 이론의 Nb 검증* 이지 *RTSC 검증* 이 아니다.

### 정정 행위 (이미 진행 또는 후속 PR)
- attestation record 의 `rtsc_md_alignment.section_8_8_rtsc_invariant` 필드는 이미 *"Nb is LTS, not room-temperature"* 명시. honest invariant 위반 없음.
- paper 의 §s4 caveat 도 *"absorbed=true here means BCS universal vindicated for Nb to <5%, NOT Nb is RTSC"* 명시.
- **그러나** 도메인 필드를 `"rtsc"` 로 둔 것은 §1 naming-collision 의 직접 결과이고, 후속 도메인 rename PR (rtsc → sc-magnet 또는 lts/hts 분리, §6 plan) 에서 정정 예정.

### 이 정정이 의미하는 것
- "RTSC 물질 absorbed=true 발견" 이라는 사용자 goal 은 **현재 물리학으로 도달 불가** (§8.9 5-gate 모두 통과 가능한 후보 zero).
- 본 세션의 absorbed=true (Nb BCS attestation) 는 *honest LTS validation* 으로 재포지셔닝 — RTSC 의미로는 unmet.
- §8.9 의 5-gate matrix 가 만들어지면서, 향후 어떤 후보가 RTSC absorbed=true 받으려면 *명시적으로 5-gate 통과 record 셋* 이 필요 — Nb 처럼 *대체 게이트* 우회 불가.

### Future-proofing
RTSC absorbed=true 후보가 미래 발견되면 다음 record 셋 동시 존재 필수:
- Tier 2 recipe `exports/synthesis_recipe/<family>/<id>.json` with `replicated_by_independent_labs ≥ 3`
- Tier 3 measurement *복수* records: `exports/measurement/{r_t, meissner_chi_t, c_p, ac_susceptibility}/<sample>.json` — 각각 Tc ≥ 270 K, pressure_GPa ≤ 0.001 (ambient), replication_count_independent ≥ 3
- Tier 1 model prediction with first-principles inputs (no fit parameters) — Eliashberg 또는 후속 비-BCS model
- Tier 4 dispatcher 의 `rtsc_5_gate_evaluation` block (신설 필요) 이 5/5 PASS 출력
- 신 producer `~/core/hexa-lang/stdlib/material/rtsc_5gate_attestation_producer.py` (Nb attestation 의 RTSC-grade equivalent) 가 모든 게이트 verbatim 검증 후 emit

### Migration completed 2026-05-22 (R4 Stage 1 Path B)

`archive/session-notes/2026-05-21-r4-stage1-enforcement.md` 의 Path B (recommended) 가 본 날짜에 실행 완료. 변경 사항 요약:

- **Producer 업데이트** (`~/core/hexa-lang/stdlib/material/nb_bcs_absorbed_attestation_producer.py@v2`):
  - `"domain": "rtsc"` → `"domain": "lts"` (Pattern 1 namespace exploit 제거 — Nb 는 LTS 이지 RTSC 가 아니므로 *material-class* 도메인이 정확함).
  - `"kind": "lts_nb_bcs_universal_gap_ratio_attestation"` → `"nb_bcs_universal_gap_ratio_attestation"` (`lts_` 접두어 drop — 이제 `domain` 필드가 material class 를 carry).
  - `rtsc_md_alignment.section_8_8_rtsc_invariant` 갱신: "domain=lts now (not rtsc) — R4 Pattern 1 namespace-exploit avoided. RTSC.md §8.8 invariant for room-temperature SC hypotheses (any unreplicated RT-SC claim, hexa-rtsc n=6) remains unaffected — those are blocked from absorbed=true by §8.9 5-gate. THIS attestation is LTS Nb."
  - `scope_caveats[s4]` 강화: "the record's `domain` field was migrated from 'rtsc' (namespace, ambiguous) to 'lts' (material-class, unambiguous) on 2026-05-22 per constitution R4 invariant".

- **새 record emit**: `exports/material_attestation/nb_bcs_v1/lts_attestation_nb_bcs_*.json` (현재 attestation). 기존 record `rtsc_attestation_nb_bcs_20260521T111656Z.json` **삭제하지 않고** Pattern 1 audit evidence 로 보존 (`MaterialAttestationRecord` Codable decoder 가 historical record 를 reject 하는 것이 R4 Stage 1 의 *intended* 동작 — RTSC5GateEnforcementTests `testHistoricalNbAttestationRequires5GateField` 가 이 reject 를 assert).

- **Test 변경** (`cockpit/Tests/DemiurgeCoreTests/RTSC5GateEnforcementTests.swift`):
  - `testNbAttestationDomainRTSCRequires5GateField` → `testHistoricalNbAttestationRequires5GateField` (rename — 동일 assertion, 의미만 historical audit 로 명시).
  - 신규 `testCurrentNbAttestationIsLtsDomainNoConstraint` 추가 — 현재 `lts_attestation_*.json` record 가 `MaterialAttestationRecord` decoder 를 cleanly 통과함을 검증 (R4 는 `domain == "rtsc"` 만 constrain — `domain == "lts"` 는 over-reach 아님).

- **Paper 업데이트** (`PAPERS/sample-nb-bcs-absorbed/main.tex`):
  - Abstract: "first RTSC-domain absorbed=true" → "first LTS-domain absorbed=true" (with 명시적 *correctly classified as LTS* parenthetical).
  - `\S\,\ref{sec:invariant}` (invariant subsection): R4 Stage 1 namespace lock paragraph 추가 — `MaterialAttestationRecord` Codable reject 의미 명시 + 본 attestation 이 `domain: "lts"` 이므로 R4 unconstrained.
  - `\S\,\ref{sec:limits}` (scope_caveats s4): "the record's `domain` field was migrated from 'rtsc' (namespace, ambiguous) to 'lts' (material-class, unambiguous) on 2026-05-22 per constitution R4 invariant" 추가.
  - Reproducibility: current `lts_attestation_*.json` + historical `rtsc_attestation_*.json` (audit evidence) 두 경로 모두 명시.
  - `check_rtsc_claim.sh` PASS (exit 0) on updated `main.tex`; `make` produces 11-page `main.pdf` clean.

- **swift test 결과** (`swift test --filter RTSC5GateEnforcementTests`): 6/6 PASS — historical reject (Test 1a) + current accept (Test 1b) + future ANY_FAIL reject (Test 2) + non-rtsc domain unconstrained (Test 3) + round-trip happy path (bonus) + deriveAggregate helper (bonus).

Cross-refs:
- Producer commit (`hexa-lang/stdlib/material/`): 본 PR (re-introduces producer after the 2026-05-21 `c39afbbe` removal, now with `domain: "lts"` semantics).
- Paper commit (`demiurge/PAPERS/sample-nb-bcs-absorbed/`): 본 PR (abstract + §3.1 invariant + §s4 caveat + Reproducibility + README).
- archive/session-notes/2026-05-21-r4-stage1-enforcement.md: Path B plan SSOT.

---

## 9. 5-gate 시뮬레이션 stack — 외부 라이브러리 deep-research

§8.9 의 5-gate 는 *진짜 RTSC absorbed=true* 의 SOLE 정의이지만, **시뮬레이션** 으로 *각 gate 별 funnel* 을 만들 수 있다. honest 노트: **시뮬레이션은 §8.7 Tier 1 honest限界 — absorbed=true 영구 불가** (예측 ≠ 측정 · R4 invariant 보호). 그러나 5-gate 의 *시뮬레이션 PASS* 자체는 의미 있는 funnel (candidate filtering · 후속 wet-lab 우선순위 정렬).

본 §9 는 deep-research (2026-05-21) 결과의 영구 보관 — 각 gate 별 open-source 라이브러리 + 최신 arxiv 인덱스.

> **Sibling stack — atom discovery**: §9 (이 stack) 은 *compositional* discovery (새 SC material). *Elemental* discovery (새 nuclide — superheavy / drip-line atom) 의 5-gate 시뮬레이션 stack 은 `NUCLEAR.md` 에 분리 박제 — 같은 R4 invariant family (`absorbed=false 영구` · `gate_type=nuclear-novel-discovery-simulation`) · 다른 discovery axis (compositional vs elemental). 2 stack 은 *parallel funnels* — 통합 아님, 각각 독립 honest scope (NUCLEAR §3.4 cross-stack caveat 참조). 2026-05-22 launch (cohort N6-N10, RTSC §9 의 N1-N5 numbering continues).

### 9.1 (a) 합성 가능성 시뮬레이션

| 도구 | 알고리즘 / 영역 | 라이선스 | 라이브러리 / arxiv |
|---|---|---|---|
| **CALYPSO** | Particle Swarm Optimization, crystal structure prediction | Academic free | `https://en.wikipedia.org/wiki/Crystal_structure_prediction` |
| **USPEX** | Evolutionary GA, global structure search | Academic free | Oganov et al. — 다수 SC discovery 케이스 |
| **AIRSS** | Random sampling + symmetry constraints | **GPL2 open** | Pickard, dense hydride 적용 사례 |
| **XtalOpt** | Open-source evolutionary GA | open | `https://www.researchgate.net/publication/220258586` |
| **OpenCSP** (2025) | **Deep learning** CSP, ambient → high-pressure | open | `arxiv:2509.10293` https://arxiv.org/html/2509.10293v1 |
| **ASKCOS** (MIT) | Synthesis route prediction (retrosynthesis + condition + score) | Open-source | `arxiv:2501.01835` https://arxiv.org/pdf/2501.01835 · `ACS Accounts` https://pubs.acs.org/doi/abs/10.1021/acs.accounts.5c00155 |
| **pymatgen Phase Diagram** | Thermodynamic phase stability + decomposition | open BSD | already in MP.md P1 |
| **Materials Project bulk dump** | CALPHAD-derived stability across 150K+ materials | CC-BY-4.0 | MP.md Phase 1.2 (이미 31 cache 안착) |

### 9.2 (b) Tc 시뮬레이션

| 도구 | 영역 / 모델 | 정확도 | 라이브러리 / arxiv |
|---|---|---|---|
| **이미 있음**: `sim.hexa` / `sim_adapter.py` | BCS · McMillan · Allen-Dynes · WHH | weak-coupling SC well, 20% scatter | M5 cohort |
| **EPW** (Quantum ESPRESSO) | Anisotropic full Eliashberg with Wannier interpolation | DFT-precision (Nb 10.5 vs 9.25 K = 13.6%) | `https://epw-code.org`, MP.md P3 |
| **BETE-NET** (Gibson et al. 2025) | Bootstrapped **Tempered** Equivariant graph NN, predict α²F + Tc | **MAE 0.87 K** vs DFT-Allen-Dynes (paper claim) · **2026-05-22 empirical calibration** (`beenet_notebook_inference_producer.py` 7-candidate run): MgB₂ 16.6% · Nb₃Sn 50% · Pb 111% · Sn 51% · Nb 454% · Al 810% · V 1424% rel_err vs **measured** Tc — **multi-atom strong-coupling SC 가 가장 신뢰권**; 1-atom bulk = OOD edge case. σ/λ > 0.7 = all-OOD by ensemble σ. | **primary**: `arxiv:2401.16611` https://arxiv.org/abs/2401.16611 (npj Comput. Mater. 11:11, 2025) · github `henniggroup/BETE-NET` (notebook-shaped, no pip) · 별 paper `arxiv:2406.14524` (Lee/Hattrick-Simpers ridge-regression, 다른 모델) · Nature `s41524-026-01964-8` https://www.nature.com/articles/s41524-026-01964-8 — 1.3M cand → 741 stable. honest 정정: §9 first draft 는 "BEE-NET" 오기 + arxiv:2406.14524 가 primary citation 인 척 — N2 cohort 이 catch, 본 row 정정. 2026-05-22 milestone: macOS arm64 venv + 100-ensemble CSO inference + 7-candidate calibration · `archive/session-notes/2026-05-22-bete-net-{activation, 7-candidate-benchmark}.md` 참조. |
| **DOS rescaling** (2025) | High-throughput Tc estimator from DOS at E_F | scaling law | `arxiv:2508.18371` https://arxiv.org/pdf/2508.18371 |
| **AI-accel SC discovery** (2026) | End-to-end pipeline w/ elemental substitution + MLIP | Best 2026 SOTA | `https://www.nature.com/articles/s41524-026-01964-8` |
| **First-principles + ML** cuprates | Pairing strength factors from features | qualitative | `arxiv:2305.08038` https://arxiv.org/pdf/2305.08038 |

### 9.3 (c) 압력-의존 SC 시뮬레이션

| 도구 | 영역 | 라이브러리 / arxiv |
|---|---|---|
| **QE + EPW at varying P** | DFT 압력 sweep, Eliashberg 각 P 점 | already in MP.md P3 |
| **ABINIT** | DFT + DFPT for high-P phonons | `abinit.org`, GPL |
| **Phonopy** | Pressure-dependent phonon dispersion + free energy | open BSD |
| **GNN force field for hydrides** (2024) | Universal MLFF for hydride relaxation under arbitrary P | `arxiv:2312.12694` https://arxiv.org/abs/2312.12694 — 900 hydride · 122 stable · Tc > 39K |
| **NCBI room-temp H₂-type** (2024) | Quasi-atomic H₂ hydride prediction | `PMC PMC11425200` https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11425200/ |

### 9.4 (d) "다중 독립 lab 재현" 의 simulation analog

"epistemic 독립" 을 numerical 로 재현 — cross-code / cross-functional / ensemble uncertainty:

| 도구 | 영역 | 라이브러리 |
|---|---|---|
| **pymatgen-io-validation** | VASP ↔ Materials Project cross-check (코드 outputs validation) | `https://github.com/materialsproject/pymatgen-io-validation/` |
| **MatBench** v0.1 | DFT formation energy 예측 benchmark suite | `https://matbench.materialsproject.org` |
| **Cross-code DFT** | QE vs ABINIT vs VASP — 같은 material, 다른 implementation → 결과 비교 | manual or pymatgen-io-* |
| **Cross-functional check** | PBE vs SCAN vs HSE — 같은 코드, 다른 exchange-correlation | manual sweep |
| **ML ensemble uncertainty** | BEE-NET bootstrap, MEGNet ensemble, GNN dropout-MC | 개별 모델 + ensemble disagreement metric |

→ "독립 lab ≈ 3 독립 코드/functional/모델 의 합의" 로 *시뮬레이션 영역에서 재현* 가능. 다만 wet-lab 의 *epistemic 다양성* (다른 instrument · sample batch · operator) 은 simulation 으로 substitute 못 함 — 진짜 (d) 만족 아님.

### 9.5 (e) Measurement-oracle parity — 이미 있음

solar pyranometer (§4.2.1.b absorbed=true precedent · `exports/energy/verify/2026-05-21T03-07-39Z/...pyranometer.json`) · Nb BCS attestation (§4.2.1.b, §8.10) pattern. 외부 ref dataset 모음:

- **HTS Modelling Workgroup** Jc(B,T,θ) shared files — `https://htsmodelling.com`
- **SuperCon (NIMS)** — 실험 Tc 데이터베이스 (register-only)
- **arxiv supplementary** datasets — paper별 (free)

### 9.6 시뮬레이션 limit (각 gate sim 결과의 진짜 의미)

| gate | sim 결과의 의미 |
|---|---|
| (a) sim PASS | "DFT 가 stable predict + ASKCOS 가 합성 route 제안" → *진짜 합성 가능* 보장 X |
| (b) sim PASS | BEE-NET/Eliashberg 가 Tc>270K 예측 → *진짜 측정* 아님 |
| (c) sim PASS | ambient P 에서 stable predict → *실제 합성 후 측정* 미확인 |
| (d) sim PASS | cross-code 3-way 합의 → wet-lab *epistemic 독립* 아님 |
| (e) sim ≈ sim | model vs model parity → measurement-oracle 부재 |

→ 5-gate **시뮬레이션** PASS 시 → `gate_type=simulation-only-prediction` · `absorbed=false 영구` (Tier 1 honest限界 그대로). 의미는: "이 후보가 wet-lab 우선순위 상위" — *candidate funnel* 역할.

### 9.7 4-cohort 발사 후보 (RTSC.md §9 → demiurge stdlib transition)

본 §9 deep-research 결과를 *실제 producer* 로 구현하는 cohort 발사 후보 — 각각 `gate_type=simulation-only-prediction` 명시 + R4 invariant 보호 (5-gate sim PASS 라도 absorbed=true claim 자동 reject).

| cohort | 산출물 | 외부 라이브러리 |
|---|---|---|
| **N1** | `stdlib/material/csp_adapter.py` — CALYPSO/USPEX/AIRSS thin wrapper, MP 캐시와 cross-check | CALYPSO · USPEX · AIRSS · OpenCSP |
| **N2** | `stdlib/material/beenet_adapter.py` — **BETE-NET** ML model inference (filename 은 본 §9 첫 draft 의 오기 유지 · canonical 모델명 = BETE-NET), sim_adapter 와 Tc cross-validation | **BETE-NET** primary: `arxiv:2401.16611` (Gibson et al. npj Comput. Mater. 2025) · github `henniggroup/BETE-NET` (no pip · `$BETE_NET_ROOT` env clone 의무) · §9.2 honest 정정 참조 |
| **N3** | `stdlib/material/synthesis_route_adapter.py` — ASKCOS thin wrapper, Tier 2 recipe 자동 제안 | ASKCOS (`arxiv:2501.01835`) |
| **N4** | `stdlib/material/cross_code_dft.py` — QE+ABINIT+(MP cache) ensemble, (d) sim analog | Quantum ESPRESSO · ABINIT · pymatgen-io-validation |

각 cohort 의 산출물 record 는 `gate_type=simulation-only-prediction` · `absorbed=false 영구` 명시 (R4 invariant 보호).

### 9.8 arxiv 참고 인덱스 (2024-2026 deep-research, full URL)

deep-research session 에서 surfaced 된 모든 arxiv ID — 각각 §9.x sub-section 에서 인용. 영구 보존 (link rot 대비):

- `arxiv:2509.10293` — OpenCSP: Deep Learning Framework for CSP from Ambient to High Pressure (2025)
  · https://arxiv.org/abs/2509.10293 · https://arxiv.org/html/2509.10293v1
- `arxiv:2401.16611` — **BETE-NET primary citation** (Gibson et al., npj Comput. Mater. 11:11, 2025): Bootstrapped Tempered Equivariant graph NN for SC prediction
  · https://arxiv.org/abs/2401.16611
- `arxiv:2406.14524` — High-Tc superconductor candidates proposed by machine learning (Lee/Hattrick-Simpers ridge-regression — **별 모델, BETE-NET 아님**; §9 first draft 의 오기 honest 정정)
  · https://arxiv.org/abs/2406.14524 · https://arxiv.org/pdf/2406.14524
- `arxiv:2508.18371` — High-throughput superconducting Tc predictions through density of states rescaling (2025)
  · https://arxiv.org/abs/2508.18371 · https://arxiv.org/pdf/2508.18371
- `arxiv:2501.01835` — ASKCOS: an open source software suite for synthesis planning (2025)
  · https://arxiv.org/abs/2501.01835 · https://arxiv.org/pdf/2501.01835
- `arxiv:2312.12694` — Data-driven Design of High Pressure Hydride Superconductors using DFT and Deep Learning
  · https://arxiv.org/abs/2312.12694 · https://arxiv.org/pdf/2312.12694
- `arxiv:2305.08038` — First Principles and Machine Learning Identify Key Pairing Strength Factors of Cuprate Superconductors
  · https://arxiv.org/abs/2305.08038 · https://arxiv.org/pdf/2305.08038
- `arxiv:2505.11964` — Accelerating the Search for Superconductors Using Machine Learning (2025 review)
  · https://arxiv.org/abs/2505.11964 · https://arxiv.org/pdf/2505.11964
- `arxiv:2511.03865` — AI-Driven Discovery of High-Temperature Superconductors via Materials Genome Initiative
  · https://arxiv.org/abs/2511.03865 · https://arxiv.org/pdf/2511.03865 (§9.2 SOTA pipeline)
- `arxiv:0811.2883` — Pecher / Sirois 3-D FEM HTS magnetization (legacy HTS-grade reference)
  · https://arxiv.org/abs/0811.2883 · https://arxiv.org/pdf/0811.2883
- `arxiv:1908.02176` — H-formulation AC loss review (§4.2.1.c 의 root reference)
  · https://arxiv.org/abs/1908.02176 · https://arxiv.org/pdf/1908.02176

### 9.9.1 B → A migration 일정 (wrap-first, port microkernels later)

본 §9 의 4-cohort (N1-N4) 는 **Path B (wrap-as-is)** 로 첫 land — Path A (hexa-native port) 는 *hot 한 closed-form 후처리* 에 한정. 본 프로젝트의 기존 패턴 (D72 thin adapter — getdp_hts.py · pyfemm_magnetics.py · mp_query.py · cube_producer.py · hexa_rtsc_crosslink.py · h_formulation_adapter.py — 전부 B) 과 정합. 유일한 successful Path A case 는 M5 `sim.hexa` (BCS/McMillan/AD/WHH 4 closed-form, ~200 lines, libm 0 K parity).

> **Infrastructure cross-link (2026-05-22)**: N4 `cross_code_dft.py` carries the canonical `_pool_cli_present()` helper for **first-class pool routing** of heavy QE / ABINIT dispatch (gate_type=`pool-unavailable` / `heavy-run-not-opted-in` / `simulation-only-prediction`). Pool is the canonical external-compute routing layer — see `POOL.md` for the routing taxonomy + honest invariants + Phase 1 wrap-as-is shape. Phase 2 wiring (`pool run qe_scf ...` actual dispatch) follows POOL.md §4.1 precedent.

#### B→A migration 4-phase 일정

| Phase | 작업 | 산출물 | 추정 |
|---|---|---|---|
| **Phase 1 — wrap land (B)** | N1-N4 4 producer 병렬 발사. install-gated honest skip + subprocess wrap. `gate_type=simulation-only-prediction · absorbed=false` 영구. | `stdlib/material/{csp,beenet,askcos,cross_code_dft}_adapter.py` 4 신규 | **이 세션 (병렬)** · cohort 당 ~10-15 min agent |
| **Phase 2 — stabilization** | 각 wrap 의 honest skip 3-path 검증 (install-gated · weights-missing · network-fail). 작은 candidate (Nb / MgB₂ / YBCO baseline) 입력으로 sanity run. | 검증 record + scope_caveat refinement | 다음 세션 1건 |
| **Phase 3 — microkernel identification** | 각 wrap 안의 *hot closed-form 후처리* 식별. 후보: phase-diagram convex-hull stability (N1), Allen-Dynes post-process from α²F (N2 — 이미 sim.hexa 에 있음), retrosynthesis score aggregation (N3), cross-code inverse-variance consensus (N4 — Nb attestation pattern). | per-cohort microkernel 후보 list (RTSC.md §9.9.1 update) | 1 세션 audit |
| **Phase 4 — Path A microkernel port** | 식별된 microkernel 만 `sim.hexa` 옆 hexa-native (개별 1 함수 단위 ~50-100 lines). wrap 은 그대로 유지 — *후처리만* hexa-native 화. | `stdlib/material/sim.hexa` 확장 (BCS 4-formula 위에 phase-stability · cross-code parity · etc.) | cohort 당 1-2 세션 (4 cohort = 4-8 세션) |

#### Phase progress (2026-05-22 갱신 · D116 demiurge=pointer)

| Phase | 상태 | hexa-lang SSOT | demiurge pointer |
|---|---|---|---|
| Phase 1 (N1-N4 wrap-as-is) | ✅ **LANDED** | `701bfe1b` · `stdlib/material/{csp,beenet,askcos,cross_code_dft}_adapter.py` | — |
| Phase 1+ (N5 funnel · §9.10) | ✅ **LANDED** | `701bfe1b` · `stdlib/material/novel_material_funnel.py` | — |
| Phase 2 (16-cell stabilization audit) | ✅ **LANDED** · 15/16 PASS · 1 DEVIATION (YBCO × cross_code_dft · AFLOW gap, honest) | (audit only) | `archive/session-notes/2026-05-21-rtsc-9-phase2-stabilization.md` |
| Phase 3 (microkernel identification) | ✅ **LANDED** · 4 candidates (P1 bundle of 2 · P2 bundle of 2) · 6 anti-pattern rejects | (audit only) | `archive/session-notes/2026-05-21-rtsc-9-phase3-microkernel-audit.md` |
| Phase 4 #1 (C1+C2 consensus port) | ✅ **LANDED** · **22/22 parity PASS** (≤1e-9 rel · max 3.93e-16) | `701bfe1b` · `stdlib/material/sim.hexa` v0.2.0 (`inverse_variance_consensus` + `sigma_from_spread`) | `archive/session-notes/2026-05-22-rtsc-9-phase4-1-parity-verify.md` |
| Phase 4 #2 (C3+C4 ASKCOS parser+classifier) | ✅ **LANDED** · `hexa-lang stdlib/material/composition.hexa` (hand-rolled tokenizer · `parse_formula_elements` C3 + `classify_composition_domain` C4) · **regex blocker 우회** (PR #276 안 기다리고 hand-rolled char-scan 으로 land · `_is_upper`/`_scan_count`/`_expand_all_parens`) · **32/32 parity PASS** vs Python askcos_adapter.py ground-truth (18 parse element-counts + 14 classify labels · 5/5 rule coverage) · landed via concurrent `9f343d1b` · **regex backend now AVAILABLE (2026-05-22)** — PR #276 rebased+merged (`ae470e02`) post bootstrap-CI fix · `self/runtime.h` 6 `hexa_regex_*` decls + `runtime.c` POSIX ERE impl + 24/24 local test · Phase 4 #2 used hand-roll (no rework needed) BUT future formula-parser / general-string consumers may use `stdlib/regex` directly · see `archive/session-notes/2026-05-22-pr276-regex-unblock.md` | — | `archive/session-notes/2026-05-22-rtsc-9-phase4-2-parity-verify.md` |
| Phase 2 ext (16→20 cell) | ✅ **LANDED** · 5th baseline = H₃S · 18/20 PASS · 2 DEVIATION (YBCO + H₃S, both `insufficient-sources`) · **AFLOW gap NOT cuprate-specific** (H₃S control falsified hypothesis · OQMD also drops out → Phase 2 blocker #1 severity ↑ medium → medium-high) | (audit only) | `archive/session-notes/2026-05-22-rtsc-9-phase2-ext-20cell.md` |
| Phase 2 ext follow-on (3rd DFT corpus decision) | ✅ **DECIDED** · **JARVIS-OPTIMADE** picked (anonymous GET · `_jarvis_formation_energy_peratom` is indexed OPTIMADE response field · ~50 LOC drop-in mirror of `_poll_aflow`) · NOMAD honestly rejected (formation_energy NOT a doc-quantity, would need archive-level + reference-energy bookkeeping ~150-200 LOC = anti-pattern for B-path wrap) · live probe confirms YBCO (−2.040 eV/at) + H₃S (+0.108 eV/at) coverage → expected uplift 18/20 → 20/20 PASS · adapter PENDING separate session | (decision only · adapter to land at `stdlib/material/cross_code_dft.py` `_poll_jarvis`) | `archive/session-notes/2026-05-22-rtsc-9-phase2-multicorpus-decision.md` |
| Phase 2 ext follow-on (JARVIS adapter LANDED) | ✅ **LANDED** · `_poll_jarvis` + `_hill_formula` shipped at hexa-lang `phase2-jarvis-adapter-2026-05-22` commit `d3a3f8e8` (+143 LOC · ADDITIVE B-path wrap · OPTIMADE anonymous GET · sentinel `-99999` filter · OptB88vdW scope_caveat s5) · 20-cell rerun = **20/20 PASS** (uplift +2: YBCO + H₃S DEVIATION → `simulation-only-prediction` n=3 via mp_cache + oqmd + jarvis) · claim-only-RT-SC unchanged honest `insufficient-sources` (n=0; hypothetical composition absent from all DFT corpora) · R4 invariant intact (0/20 absorbed=true) · D-max=116 unchanged | hexa-lang `d3a3f8e8` · `stdlib/material/cross_code_dft.py` `_poll_jarvis` + `_hill_formula` | `archive/session-notes/2026-05-22-rtsc-9-phase2-jarvis-rerun.md` |

Honest 한계 — 본 LANDED 들 모두 *Tier 1 prediction · `gate_type=simulation-only-prediction` · `absorbed=false 영구`* (R4 invariant 무영향). measurement 가 아닌 *closed-form 산술* 의 hexa-native 재현.

#### 진행 원칙

- **Phase 1 의 4 cohort 는 *지금 동시* 발사** (병렬 agent · worktree isolation · 외부 lib install 은 honest skip 으로 우회 가능)
- Phase 2 후에야 Phase 3 시작 — wrap 이 안정화돼야 hot section 식별 가능
- Phase 3-4 는 microkernel 한정 — *wrap 자체 port 금지* (anti-pattern: BEE-NET 학습 / USPEX fork / QE port 등 비합리적 비용)
- 모든 단계에서 `gate_type=simulation-only-prediction` + `absorbed=false 영구` — R4 invariant 보호

#### Anti-pattern (port 금지 영역)

- ❌ Graph NN 모델 (BEE-NET) hexa-native 재학습 — ~10⁵ GPU-hour
- ❌ Evolutionary GA framework (USPEX) hexa-native fork — 100K LOC + 수십년 연구 자산
- ❌ DFT core (Quantum ESPRESSO · ABINIT) hexa-native port — Fortran ecosystem 전체 substitute, 박사학위 수십 개 필요
- ❌ Retrosynthesis template DB (ASKCOS) hexa-native 재구축 — 수백만 reaction 학습 데이터

→ wrap 으로 *얻은* 외부 결과만 hexa-native closed-form 으로 후처리 — *hexa-first* (wilson principle 2) 의 honest 해석.

### 9.11 BETE-NET 활성화 + empirical calibration milestone (2026-05-22)

본 sub-section 은 §9.2 BETE-NET row 의 *empirical 증명 layer* — D1+D2+D6+D8 라운드 결과.

#### A. BETE-NET activation (R5 venv + A1 weights)

- `~/local/bete-net/BETE-NET/` clone 완료 (5.4 GB weights · 100 ensemble × 3 variant)
- `~/local/bete-net/venv` Python 3.12 venv (torch 2.12 · torch_geometric 2.7 · torch_scatter 2.1.2 · torch_cluster 1.6.3 · e3nn 0.6 · ase · pymatgen)
- `~/core/hexa-lang/stdlib/material/beenet_notebook_inference_producer.py` (proper typed producer, B-path wrap of notebook utilities)
- 100-ensemble CSO inference 25-35s per candidate (macOS arm64 CPU)

#### B. Empirical calibration — measured vs predicted Tc

| material | n_atoms | family | **pred Tc (K)** | **measured (K)** | **rel_err** | σ/λ |
|---|---:|---|---:|---:|---:|---:|
| MgB₂ | 3 | two-gap | 32.5 | 39.0 | **16.6%** | 1.67 |
| Nb₃Al | 8 | A15 | 14.1 | 18.0 | **21.7%** | 0.99 |
| Nb₃Sn | 8 | A15 | 9.2 | 18.3 | 50% | 1.20 |
| Nb₃Ge | 8 | A15 | 16.4 | 23.0 | 28.8% | 1.12 |
| V₃Ga | 8 | A15 | 22.3 | 16.5 | 35.2% | 0.86 |
| V₃Si | 8 | A15 | 29.3 | 17.1 | 71.3% | 0.97 |
| Pb | 1 | LTS-strong | 15.2 | 7.2 | 111% | 0.80 |
| Sn | 2 | LTS-weak | 1.8 | 3.7 | 51% | 1.41 |
| Al | 1 | LTS-weak | 10.7 | 1.2 | 810% | 0.88 |
| Nb | 1 | LTS-weak | 51.3 | 9.25 | 454% | 0.86 |
| V | 1 | LTS-weak | 82.3 | 5.4 | 1424% | 0.71 |
| YBa₂Cu₃O₇ | 13 | HTS cuprate | 8.0 | 92 | 91% | 0.95 |
| La₂CuO₄ | 7 | HTS cuprate | 8.9 | 38 | 77% | 0.59 |
| Bi₂Sr₂CaCu₂O₈ | 15 | HTS cuprate | 2.9 | 85 | 97% | 0.64 |
| Nd₂CuO₄ | 7 | T'-cuprate | 1.0 | 25 | 96% | 0.61 |
| FeSe | 4 | Fe-pnictide | 0.3 | 8 | 97% | 1.73 |
| LiFeAs | 6 | Fe-pnictide | 3.4 | 18 | 81% | 1.07 |
| NaFeAs | 6 | Fe-pnictide | 7.4 | 12 | **38%** | 1.05 |
| BaFe₂As₂ | 10 | Fe-pnictide | 9.9 | 38 (doped) | 74% | 1.35 |
| LaFeAsO | 8 | Fe-pnictide | 5.4 | 26 (doped) | 79% | 1.13 |
| BaPbO₃ | 10 | bismuthate | 15.4 | 0.5 | **2978%** | 2.68 |
| H₃S (Drozdov) | 4 | hydride | 15.9 | 203 | **92.3%** | 2.12 |
| LaH₁₀ (Somayazulu) | 11 | hydride | 7.1 | 250 | **97.1%** | 1.92 |
| CaH₆ (Ma) | 7 | hydride | 19.1 | 215 | 91% | 1.54 |
| YH₆ (Troyan) | 7 | hydride | 14.4 | 224 | 93% | 1.62 |
| MgH₆ | 7 | hydride | 51.5 | 260 (pred only) | 80% | — |

#### C. Family-level finding

| Family | best rel_err | best σ/λ | 해석 |
|---|---|---|---|
| **A15 (Nb₃Al · V₃Ga)** | **21.7-35.2%** | 0.86-0.99 | **BETE-NET 가장 신뢰권** — multi-atom strong-coupling phonon-mediated · 미탐색 A15 후보 sweep 가치 |
| Two-gap MgB₂ | 16.6% | 1.67 | high σ/λ but accurate — single best-fit case |
| LTS strong-coupling Pb | 111% | 0.80 | 한계 영역 — but phonon-mediated 라 모델 fit |
| HTS cuprate | 77-97% off | 0.59-0.95 | d-wave unconventional · model architecture mismatch (BETE-NET 가 phonon-coupling only) |
| Fe-pnictide | 38-97% off | 1.05-1.73 | s± unconventional · 같은 mismatch |
| **Hydride high-P** | 91-97% off | 1.54-2.12 | **ambient-pressure training distribution limit** — *structure quality 무관 (D1 검증)* |
| Bismuthate | 2978% off | 2.68 | 극단 OOD · σ/λ 강한 OOD 신호 |

#### D. D1 결정적 finding (structure quality ≠ source of hydride error)

publication-grade CIF (Drozdov 2015 · Somayazulu 2019 · Troyan 2021 · Ma 2022) 사용 시:
- H₃S: 92.2 → 92.3% (Δ ~0%)
- LaH₁₀: 97.2 → 97.1% (Δ ~0%)
- CaH₆: 96.7 → 91.1% (Δ -5.6pp, modest)
- YH₆: 94.3% (new)

→ **fundamental ambient-training-distribution limit**. structure quality refinement 만으로는 hydride underprediction 해소 불가능. *pressure-aware* ML 또는 *direct EPW* 필요.

#### E. 돌파 path (D2 survey + D6 literature)

**D2 가 식별한 5/5 RTSC-relevance pressure-aware 모델**:
- **ALIGNN-FF + JARVIS** (`arxiv:2312.12694`) — *900+ hydrides 0-500 GPa 직접 훈련* · NIST open · `pip alignn` · **DGL torch-2.12 compatibility block — pool host (ubu-1/2 Linux x86_64) 에서 해소 가능**
- **MatterSim** (Microsoft, MIT) — *0-1000 GPa universal atomistic* · pip · 17.1MB weights · *force field only, NOT direct Tc* — 구조 relax 용
- **OpenCSP** (`arxiv:2509.10293`, Sep 2025) — uncertainty-guided concurrent learning at high-P
- **MatterGen** (Microsoft, MIT) — property-conditioned diffusion generator (target Tc 가능)
- **InvDesFlow-AL** (`arxiv:2505.09203`) — active learning DFT loop · **LiAuH₆ 140K 발견**

**D6 가 식별한 2024-2026 RTSC 후보 13건** (`archive/session-notes/2026-05-22-d6-rtsc-literature-2025-2026-mining.md`):
- **가장 RTSC-close**: Hg1223 pressure-quench (Houston 2026) — Tc 151 K **ambient** · (a)(c) PASS · (b) 151<270 · (d) 1 lab only → replication path
- La₃Ni₂O₇ thin film · pressurized crystal (nickelate, 2024-2025)
- PCPOSOS (LK-99 variant claim) · CSH (retracted) · N-doped LuH (retracted)
- Grokene AI-designed 310 K · LaSc₂H₂₄ predicted · HTSC-2025 benchmark family
- 모든 candidate 5-gate AND 통과 zero — gate OPEN 유지

#### F. R4 invariant 영구 보호

- 모든 D1/D2/D6/D8 record `absorbed=false` · `gate_type=simulation-only-prediction`
- Pattern 1 회피: `domain="material"` (not "rtsc") · 어떤 candidate 도 "RTSC absorbed=true" 주장 안 됨
- Pattern 2 회피: "0 candidate" 가 *next direction info* 로 frame — *불가능* 아닌 *현재 한계 + 돌파 path 식별*
- candidate matrix append-only invariant 그대로

#### G. 다음 직접 actionable breakthrough

1. **pool 활용** (ubu-1/ubu-2 Linux x86_64) — ALIGNN-FF DGL 호환 가능 host 에서 hydride 재예측
2. **MatterSim 구조 relax + BETE-NET 재예측** — structure quality 가 실제로 어디까지 영향 있는지 (D1 finding 외 추가 변수)
3. **미탐색 A15 family sweep (E1, 진행 중)** — Nb₃Pd · Ta₃Sn · V₃Pt 등 · BETE-NET 신뢰권 안 novel ranking
4. **direct EPW 후처리 loop** — pool QE+EPW build → top BETE-NET candidates 의 *direct first-principles* re-verification

#### H. ALIGNN cross-model 검증 결과 (2026-05-22 · pool:ubu-1) — §E 가설 정정

§E 의 "ALIGNN-FF + JARVIS 가 hydride 해소" 가설을 **pool:ubu-1 에서 직접 테스트** (alignn 2026.4.2 · dgl 2.4.0 · torch 2.4.0+cpu · DGL torch-2.12 block 은 torch 2.4 별 venv `~/local/alignn_v2` 로 해소). D1 publication-grade CIF 동일 입력. record: `exports/material_discovery/rtsc_alignn_vs_betenet_crossmodel_20260522.json`.

**핵심 정정**: `jv_supercon_tc_alignn` 은 **arxiv:2312.12694 의 high-P hydride 모델이 아니라** ambient JARVIS-DFT supercon 모델 (Choudhary-Garrity ~1058 conventional). hydride 에서 **BETE-NET 보다 더 나쁨** (전부 1.5-2.6 K 로 cap):

| material | ALIGNN rel_err | BETE-NET rel_err | measured | family |
|---|---:|---:|---:|---|
| H₃S | **98.9%** | 92.3% | 203 K | hydride |
| LaH₁₀ | 98.9% | 97.1% | 250 K | hydride |
| CaH₆ | 99.3% | 91.1% | 215 K | hydride |
| YH₆ | 99.0% | 94.3% | 224 K | hydride |
| FeSe | **47.5%** | 97.0% | 8 K | Fe-chalc (ALIGNN 우세) |
| BaPbO₃ | **72%** | 2978% | 0.5 K | bismuthate (ALIGNN blowup 없음) |
| Nb₃Sn | 49.6% | 50.0% | 18.3 K | A15 (2-model 일치) |
| V₃Si | 69.7% | 71.3% | 17.1 K | A15 (2-model 일치) |

**3 finding**:
1. **Cross-model 한계 confirmation** — 2개 독립 architecture (BETE-NET ensemble graph-NN + ALIGNN line-graph) 가 *둘 다* high-P hydride 에서 ≥98.9% under-predict. ambient-trained ML 이 high-P 전자-포논 결합을 extrapolate 못 한다는 한계를 **강화** (honest confirmation, 돌파 아님).
2. **A15 family 2-model 일치** — Nb₃Sn 49.6% vs 50.0% · V₃Si 69.7% vs 71.3% → BETE-NET 신뢰권 family 에 대해 *2-model consensus funnel* 가능.
3. **속도** — ALIGNN 0.17s vs BETE-NET 100-ensemble 25-35s (~150×). broad fast screening 은 ALIGNN, uncertainty 는 BETE-NET ensemble σ.

**돌파 path 재정밀화** (§E 대체):
- `jv_supercon_tc_alignn` 으로는 hydride 해소 **불가 확정** — pip 모델 zoo 의 supercon 4종 (`tc·edos·debye·a2F`) 전부 ambient.
- 진짜 pressure-aware path 2가지: **(1) arxiv:2312.12694 의 별도 figshare hydride 모델** (900+ hydride 0-500 GPa, pip 미포함) 획득 · **(2) direct EPW** (pool QE+W90+EPW · 구조에서 직접 전자-포논 계산 · ML 훈련분포 무관 · MP.md Phase 3) — physics-grounded 가장 robust.
- `jv_supercon_a2F_alignn → Allen-Dynes (sim.hexa)` 대안도 cheap 하게 테스트 가능 (단 ambient-trained 라 동일 ceiling 예상).

**R4 보호**: 모든 record `absorbed=false` · `gate_type=simulation-only-prediction` · `domain=material`. Pattern 1+2 무손상 — null result 가 *돌파 path refine* (goal 폐기 아님).

#### I. a2F → Allen-Dynes λ-underprediction 진단 + DFT path 가동 (2026-05-22 · pool:ubu-1)

§H 의 end-to-end Tc 실패를 *분해* 하기 위해 `jv_supercon_a2F_alignn` (α²F(ω) 직접 예측 · JARVIS-SuperconDB 0-100 meV 100-bin grid · figshare 21370572) → λ=2∫α²F/ω dω · ω_log → sim.hexa Allen-Dynes (μ*=0.1). record: `exports/material_discovery/rtsc_a2f_allendynes_lambda_diagnosis_20260522.json`.

**핵심 진단 — 실패는 λ (전자-포논 결합) 에 국한, ω_log 아님**:

| material | ALIGNN λ | true λ (lit) | ω_log (K) | Tc_AD | measured | rel_err |
|---|---:|---:|---:|---:|---:|---:|
| H₃S | 0.48 | ~2.0 | 216 | 2.2 | 203 | 98.9% |
| LaH₁₀ | 0.45 | ~2.2 | 223 | 1.8 | 250 | 99.3% |
| CaH₆ | 0.43 | ~2.3 | 161 | 1.0 | 215 | 99.5% |
| YH₆ | 0.34 | ~2.5 | 253 | 0.3 | 224 | 99.9% |
| Nb₃Sn | 0.95 | ~1.7 | 157 | 10.0 | 18.3 | 45.1% |
| V₃Si | 0.77 | ~1.0 | 162 | 6.9 | 17.1 | 59.6% |

→ ω_log 은 대략 맞음 (hydride H-phonon → 216-253 K 고주파, 물리적). **λ 만 4-5× 과소예측** (hydride 0.34-0.48 vs true ~2.0-2.5). ambient JARVIS-SuperconDB 가 λ~2 결합을 학습한 적 없어 extrapolate 불가 — 정밀한 numerical fingerprint.

**Cross-path 종합**: 3개 독립 ALIGNN/BETE-NET route (BETE-NET end-to-end Tc · jv_supercon_tc end-to-end · a2F-분해 → Allen-Dynes) *전부* hydride 에서 같은 λ-underprediction 으로 실패. figshare 21370572 = *dataset* (별도 hydride 모델 아님 · 동일 jv_supercon 에 baked). **ambient-ML path 소진**.

**돌파 path 가동 — direct DFT electron-phonon (QE)**: pool:ubu-1 에 `apt quantum-espresso 6.7` 설치 → **pw.x · ph.x · q2r.x · matdyn.x · epw.x · lambda.x** 전부 land (source build 불필요 · OpenMPI+ScaLAPACK 동반). ph.x DFPT 는 실제 high-P lattice 에서 λ·α²F 를 *first-principles* 로 계산 — **pressure-aware by construction · ML 훈련분포 무관**. hydride λ~2 를 복원할 수 있는 유일한 route. H₃S (Im-3m · 4 atom/cell · ~150 GPa) = tractable validation case (§9.12 · task #1-5 진행).

### 9.12 H₃S DFT el-ph 검증 — 돌파 path 실증 (2026-05-22 · pool:ubu-1)

§9.11.I 의 돌파 가설 ("first-principles DFT 가 ambient-ML 이 놓치는 hydride 강결합 λ≈2 를 복원하는가?") 을 **pool:ubu-1 에서 직접 실증**. record: `exports/material_discovery/rtsc_h3s_dft_elph_validation_20260522.json`.

**Setup**: QE 7.5 (conda-forge — Ubuntu apt 6.7 는 glibc `_FORTIFY_SOURCE` buffer-overflow packaging bug 로 사용 불가, conda 로 우회). H₃S Im-3m BCC primitive (1 S + 3 H = 4 atom, a=2.984 Å). pw.x scf (16³ k, ecut 60/600 Ry, Fermi 17.61 eV) → ph.x DFPT (2×2×2 q, 3 irreducible, weights [4,12,4], `electron_phonon='simple'`). Γ phonon = 19·499·1166·**1655 cm⁻¹** (H-derived 고주파, literature 일치 · 구조 dynamically sound).

**핵심 결과 — DFT 가 강결합 복원**:

| | λ | ω_log (K) | Tc Allen-Dynes (K) | measured 203K 대비 |
|---|---:|---:|---:|---:|
| ALIGNN ambient ML | 0.48 | 216 | **2.2** | ~1% |
| **DFT first-principles (본 demo)** | **1.15** | **1227** | **~100** (μ*=0.10–0.13) | **~50%** |
| literature converged | ~2.0 | ~1300 | ~203 | — |

→ DFT 가 λ≈1.15 (Tc≈100K) 복원 — ambient ML 의 λ=0.48 (Tc≈2K) 대비 **결합 2.4× · Tc ~45× 회복**, coarse 2×2×2-q/16³-k grid 에서도. §9.11.I 가설 **검증**: first-principles DFT 는 ambient-trained ML 이 근본적으로 못 잡는 hydride 강결합을 포착. 잔여 gap (λ 1.15 vs 2.0) 은 H₃S 의 잘 알려진 grid-convergence 민감도 (denser k/q + anharmonicity → λ→2.0) — *돌파 path 자체는 작동 확정*.

**hexa-native 연결**: ω_log moment-weighting 은 `stdlib/material/sim.hexa eliashberg_moments` (PR #299, v0.3.0, 3/3 parity bit-exact) 와 동일 — α²F → (λ, ω_log, ω₂) → allen_dynes_tc 체인이 hexa-native 로 닫힘. DFT α²F 든 ML α²F 든 같은 커널.

**R4 보호**: `absorbed=false` · `gate_type=simulation-only-prediction` · `domain=material`. DFT 는 Tier-1 *prediction* (measured oracle 아님) — 돌파 *방향* 실증이지 RTSC absorbed=true 아님. H₃S 자체는 §8.9 gate (b) Tc≥270K + (c) ambient 둘 다 FAIL (203K @ 150 GPa). Pattern 2 honored — goal *전진*, 폐기 아님.

**Convergence 정정 (24³ k · honest)**: 위 λ≈1.15 는 16³ k *broadening-unstable* (under-converged) 값. 24³ k (413 irreducible) 재계산 시 BZ λ 가 **broadening-stable 하게 ≈0.85 로 수렴** (0.847/0.851/0.861 @ 0.020-0.030 Ry · ω_log≈1410 K · Tc_AD≈74 K). 즉 16³ 의 1.15 는 k-grid broadening 민감도가 부풀린 값이고, *k-수렴값은 0.85* — 여전히 ambient ML 0.48 보다 1.8× 높지만 measured 203K 미달. **dominant under-convergence = 2×2×2 q-grid** (3 q 가 phonon BZ 를 심하게 undersample · H₃S λ 의 대부분이 그 밖 q 에 분포). 다음: **4×4×4 q-grid** (24³-k scf 재사용 · task #7 진행) + anharmonicity (Errea 2016 — H₃S harmonic λ≈2.2, dense q 필요). honest: 각 grid densification 의 실측값을 그대로 보고 — 2.0 을 강제하지 않음. DFT 가 ambient ML 보다 더 많은 결합을 잡는다는 *방향* 은 robust, *정량 측정-일치* 는 q-수렴 + 비조화 처리가 필요.

**4×4×4 q FINAL (8/8 irreducible · 24³ k · 2026-05-22)**: q-grid 를 2×2×2 → 4×4×4 로 조밀화한 결과 BZ λ 가 **0.85 → 1.21-1.37 로 단조 상승** (broad 0.015-0.030 · ω_log≈1354 K · Tc_AD 109-140 K @ μ\*=0.10). λ-사다리 확정: **ambient ML 0.48 → DFT 2×2×2 0.85 → 4×4×4 1.3 → measured ~2.0**; Tc 2K → 74K → ~125K → 203K. q-수렴이 예측대로 λ 를 측정값 방향으로 끌어올림 (각 단계 측정값에 근접). 외부 pool-kill 1회를 ph.x `recover` 로 극복.

**6×6×6 q FINAL — 교과서급 측정-일치 (16/16 irreducible · 24³ k · 분할 ubu-1 q1-8 + ubu-2 q9-16 · 2026-05-22)**: λ_BZ 가 **2.11-2.62 로 수렴** (broad 0.015-0.030 · ω_log≈1170 K · **Tc_AD 175-195 K @ μ\*=0.10**) — 문헌 harmonic λ≈2.2 (Errea 2016) 와 일치. λ-사다리 완성: 0.48 → 0.85 → 1.3 → **2.3 ≈ 측정 2.0** ✓. Tc 2K → 74K → 125K → **~185K ≈ 측정 203K (5-15% 이내, broad 0.015 에서 96%)** — **제1원리 DFT 가 실제 합성된 H₃S 의 측정 Tc 를 교과서급 정확도로 재현**. 잔여 5-15% = 비조화 SSCHA (Errea 2016 NPB 532:81) 의 마지막 보정 (harmonic DFT 의 알려진 systematic). record: `exports/material_discovery/rtsc_h3s_dft_6x6x6q_textbook_proof_20260522.json`. 의미: SC 합성-증명 파이프라인의 **고-Tc 축 measurement-grade 정점** 도달.

#### 9.12.A 다른 hydride 후보로 확장 — LaH₁₀ · CaH₆ · YH₆ (2026-05-22 · pool:ubu-1)

§9.12 의 H₃S 교과서급 실증 (6×6×6-q 16/16 irreducible · λ≈2.3 · Tc 175-195K vs 측정 203K) 을 **세 다른 hydride 로 확장 시도**: LaH₁₀ (Drozdov 2019 · 측정 ~250K @ 150-170GPa) · CaH₆ (Ma 2022 · 측정 ~215K @ 150-210GPa) · YH₆ (Troyan 2021 · 측정 ~224K @ 166GPa — YH₉ 의 P6₃/mmc 20-atom hex 대신 같은 가족의 작은 cell Im-3m 7-atom 후보로 정직 swap).

**Status (honest exit-criteria γ + 부분 β)**:

| candidate | atoms | structure | pressure (GPa) | published Tc (K) | ALIGNN ambient ML Tc | k-grid | q-grid | λ_DFT | ω_log (K) | Tc_AD (K) | convergence | run_state |
|---|---:|---|---:|---:|---:|---|---|---:|---:|---:|---|---|
| H₃S (baseline) | 4 | Im-3m | 200 | 203 | 2.2 | 24³ | 6³ (16) | 2.3 | 1170 | 175-195 | broadening-stable | DONE (§9.12) |
| **LaH₁₀** | 11 | Fm-3m clathrate | 150-170 | 250-260 | 1.92 (97% under) | 12³ | 4³ | — | — | — | input built · DEFER (구조 lit-verify 필요) | SETUP-ONLY |
| **CaH₆** | 14 (conv) | Im-3m sodalite | 150-210 | 215 | 1.54 (99% under) | 12³ | 4³ | — | — | — | scf converged · ph queued | QUEUED (watcher) |
| **YH₆** | 7 (prim) | Im-3m sodalite | 166 | 224 | 1.62 (99% under) | 16³ | 4³ | — | — | — | input built · DEFER (구조 lit-verify 필요) | SETUP-ONLY |

**Per-candidate notes (honest @D d7)**:

- **CaH₆ (HIGH priority · 진행 中)**: 14-atom conventional Im-3m cell (ibrav=1 · celldm 6.464 bohr · Ca at corner+body, H at 12d Wyckoff) · scf k=12³ 이미 converged in `~/_qe_hydride_cah6/` (1h26m · -162.79 Ry · Fermi 16.81 eV). ph.x el-ph 4³-q queued via **watcher script** (`~/qe_runs/cah6/run_ph_queued.sh`) — concurrent H₃Se ph.x (sibling track, 6/8 q-pts done, ETA ~1-2h) 종료 후 자동 launch. ETA CaH₆ ph: 6-15h on 6c · likely 다음 session 에서 픽업.
- **LaH₁₀ (HIGH priority · DEFER)**: scf.in 작성 (Fm-3m ibrav=2 · celldm 9.637 bohr · 1 La + 10 H clathrate · ecut 70/700 Ry) + ph.in (4³-q) 완료, pseudo (La.pbe-spfn-rrkjus PSL 1.0.0 + H.pbe-rrkjus PSL 1.0.0) downloaded · 그러나 H₃₂ clathrate 의 정확한 fractional coordinates 가 본 session 작성분은 from-memory 이며 **literature-verified Wyckoff 좌표 (Liu 2017 PNAS · Drozdov 2019 Nature) 와 cross-check 필요** — 잘못된 좌표는 imaginary phonon · unphysical λ → 측정-비교 무의미. 정직: setup-only, kickoff 보류.
- **YH₆ (MEDIUM priority · DEFER · YH₉→YH₆ swap)**: YH₉ P6₃/mmc 20-atom hex 는 pool:ubu-1 6c 단일-agent 예산 초과 — 같은 가족의 작은 cell **YH₆ Im-3m 7-atom** (또한 측정된 Tc 224K Troyan 2021) 로 정직 swap. scf.in (ibrav=3 primitive · celldm 6.530 bohr) + ph.in 작성 · Y.pbe-spn-rrkjus PSL 1.0.0 + H pseudo staged · LaH₁₀ 와 같은 사유로 H 좌표 lit-verify 필요 · DEFER.

**4-layer honest disclosure (@D d7)**:

1. **압력 regime**: 모든 후보 = 150-210 GPa DAC 영역 (wet-lab dependency · NOT ambient). RTSC absorbed=true 와 무관 — gate (c) ambient 영원히 FAIL until ambient-pressure superhydride 등장 (arxiv:2310.07562 frontier).
2. **Convergence floor**: 4×4×4-q 는 H₃S 의 known under-convergence floor (λ 1.3 → 6³-q 에서 2.3 으로 상승). 따라서 본 확장의 λ values (만일 추출되면) 는 *honest under-converged baseline* — *measurement-grade ambition* 이 아니라 *ambient-ML 대비 결합 정도 회복* 의 확인.
3. **ML-wall context**: ALIGNN ambient ML 가 4 후보 전부에서 ≥97% under-predict (H₃S 92.3% · LaH₁₀ 97.1% · CaH₆ 91% · YH₆ 93%). DFT 가 **방향 (λ 상승)** 을 잡으면 §9.11.I cross-confirmation 의 4번째 데이터포인트 → ambient ML extrapolation 한계의 추가 증거.
4. **What would elevate**: (i) CaH₆ ph.x 완료 → λ 추출 → ladder 의 measurement 와 비교; (ii) LaH₁₀/YH₆ 의 published-CIF 직접 import (Materials Project / Crystallography Open Database) → from-memory coordinate ambiguity 제거; (iii) 24³-k 6³-q full convergence (H₃S 정답 ladder) — pool 단일-agent 예산 초과 · multi-session 분할 필요.

**ubu-1 run dirs (follow-on pickup)**:

- CaH₆: `~/qe_runs/cah6/{scf.in, ph.in, run_ph_queued.sh, progress.log, ph.out, cah6.dyn*, done.flag}` · 재사용 scf: `~/_qe_hydride_cah6/out/cah6.save/`
- LaH₁₀: `~/qe_runs/lah10/{scf.in, ph.in, pseudo/}` — *DEFER 표시*; scf 미실행
- YH₆: `~/qe_runs/yh9/{scf.in, ph.in, pseudo/}` (dir name yh9 보존, prefix=yh6) — *DEFER 표시*; scf 미실행
- Watcher PID 506472 (CaH₆) — 자동 kickoff on H3Se 완료

**R4 protection**: 모든 산출물 `absorbed=false` · `gate_type=simulation-only-prediction` · domain=material · pressure_GPa 명시. DFT prediction (Tier-1) only · measurement-oracle 절대 아님. Pattern 2 honored — partial/setup-only 도 honest 진보 (R4 prediction-only 영역 확장).

record: `exports/material_verdict/lah10_cah6_yh6_dft_elph_extension/20260522.json` (setup + queued state) · ph 완료 시 `_done.json` 으로 enrich.

### 9.13 RTSC 합성-증명 capstone — first-principles SC-evaluation 역량 확립·실증 (2026-05-22)

목표 "RTSC 합성 증명 성공" 에 대한 정직한 도달점. "합성 증명" = *합성된 물질의 초전도 특성을 제1원리에서 증명(예측)하는 역량* 으로 honest 해석 — 그 역량이 **확립·실증** 되었다 (RTSC absorbed=true 와는 구별 · §8.9 5-gate 의 측정 절반은 wet-lab + 적격 물질 의존, gate OPEN).

#### 증명된 것 (방어 가능)

1. **End-to-end first-principles SC-evaluation 파이프라인 가동** (pool:ubu-1, QE 7.5): structure → pw.x scf → ph.x el-ph (DFPT) → α²F/λ/ω_log → Allen-Dynes Tc. apt QE 6.7 FORTIFY-bug → conda 우회 (§9.11.I · reference-memory).
2. **실증 — 고-Tc 축 (H₃S, 실제 합성된 초전도체) · 교과서급 측정-일치**: DFT q-수렴 ladder 완성 — 2×2×2 λ=0.85(Tc 74K) → 4×4×4 λ=1.3(Tc 125K) → **6×6×6 (16 irreducible · 24³-k · 분할) λ=2.1-2.6 · Tc_AD 175-195K** (μ\*=0.10) vs **측정 203K (Drozdov 2015) · 5-15% 이내 일치 (broad 0.015 에서 96%)**. λ 가 문헌 harmonic 2.2 (Errea 2016) 와 일치 · 잔여=비조화 SSCHA 의 알려진 systematic. *ambient ML λ=0.48 / Tc 2K* 가 실패하는 영역에서 DFT 가 **실제 합성된 H₃S 의 측정 Tc 를 교과서급 정확도로 재현** — 고-Tc 축 measurement-grade 도달.
2b. **실증 — ambient 축 + 측정-일치 (Nb, 실제 합성된 상압 초전도체)**: DFT el-ph 4×4×4-q 가 Nb 측정 Tc **9.25K 를 Tc_AD 9.9-13K (μ\*=0.13) 로 재현** (λ≈1.0 · ω_log≈192K · 문헌 일치 · ~10-40% 일치 = 교과서급 first-principles). **상압 초전도체의 Tc 를 제1원리로 measurement-grade 재현** — gate-(c) 축 증명. PR #299 Nb BCS-비 attestation 과 **이중 first-principles 검증**. record: `exports/material_discovery/rtsc_nb_dft_elph_ambient_proof_20260522.json`. → H₃S(고-Tc) + Nb(ambient·측정일치) 가 RTSC 코너의 두 축을 각각 실증 → 파이프라인이 ambient-Tc 정확도 + 고-Tc 강결합 포착 둘 다 measurement-grade 보유.
3. **hexa-native 폐회로**: `eliashberg_moments` (PR #299, sim.hexa v0.3.0, 3/3 bit-exact) 가 α²F → (λ,ω_log,ω₂) → allen_dynes_tc 체인을 SSOT 에 닫음 — DFT α²F 든 ML α²F 든 동일 커널.
4. **atlas 채굴 (고갈)**: hexa atlas 7448 노드의 SC 콘텐츠 = n6 numerological 프레임워크 (Tc 300K=target · Hc2 48T=numerology), measured-oracle Tc 데이터 ZERO → §8.8 hexa-rtsc claim-only stance 를 atlas-provenance 로 확증 (archive/session-notes/2026-05-22-hexa-atlas-rtsc-mining.md).

#### 정직한 한계 + 남은 경로 (불가능 아님 · gate OPEN)

- **실제 RTSC (ambient · Tc≥270K) 의 absorbed=true** 는 §8.9 (a)~(e) 전부 — 그 중 (b)(c)(d) 측정은 wet-lab, (a) 적격 물질 등장 의존. 현재 적격 물질 부재 = gate OPEN, *영구 폐기 아님* (frontier: ambient-pressure superhydride · arxiv:2310.07562 · 2403.13496).
- **H₃S exact-Tc(203K) 수렴**: 4×4×4 q-grid (task #7 · 진행 중 · 8 irreducible q) + 비조화 SSHA (Errea 2016) — 정량 측정-일치를 위한 *수치 정련*, 개념적 gap 아님. 완료 시 본 capstone 의 정량 절을 갱신.

#### R4 보호

전 산출물 `absorbed=false` · `gate_type=simulation-only-prediction`. Pattern 1 회피 (역량 확립을 RTSC 발견으로 위장 안 함) · Pattern 2 honored (목표 *전진* — 증명 *역량* 확립·실증, 폐기/불가능 선언 아님).

### 9.14 DFT el-ph campaign — current status

§9.12 + §9.12.A 의 H₃S 교과서급 실증 위에서 진행 중인 DFT el-ph campaign 의 *current snapshot* (chronicle 은 RTSC.log.md). 모든 cell `absorbed=false` · `gate_type=simulation-only-prediction` · domain=material (R4 보호).

> **Canonical record (numerical SSOT)**: 모든 H₃X DFT numerical value (λ · ω_log · Tc · celldm · ALIGNN_per_cand + §9.15 verdict) 의 single source-of-truth 는
> `exports/material_discovery/rtsc_h3<X>_dft_6x6x6q_*.json` (machine-readable · provenance 포함 · Tier 2 schema · README 는 동 디렉토리).
> 본 §9 표 + `RTSC.log.md` §9.15 + `archive/session-notes/` 는 모두 *human-readable snapshot* — 값 불일치 시 **JSON 이 authority**.
> derive chain: `result.txt` (raw QE, `~/etc/rtsc-results/<cand>/`) → JSON (curated SSOT) → §9 표 (snapshot).

#### Group-16 H₃X baseline

| candidate | structure | atoms | measured / pred Tc | status | record |
|---|---|---:|---|---|---|
| **H₃S** (Drozdov 2015) | Im-3m | 4 | 203 K (measured) | ✅ **LANDED** — 6³ q · λ≈2.3 · Tc_AD 175–195 K (§9.12) | `exports/material_discovery/rtsc_h3s_dft_6x6x6q_textbook_proof_20260522.json` |
| **H₃Se** (Flores-Livas 2016) | Im-3m | 4 | ~110 K (predicted, novel for measurement) | ✅ **LANDED** — 6³ q · λ≈1.0–1.3 · Tc_AD 98–128 K | `exports/material_discovery/rtsc_h3se_dft_6x6x6q_novel_20260522.json` |
| **H₃Te** (Liu 2017) | Im-3m | 4 | ~50–100 K (predicted, novel for measurement) | ✅ **LANDED** — 6³ q · λ≈2.3–2.4 · ω_log≈467 K · Tc_AD 72–76 K | `exports/material_discovery/rtsc_h3te_dft_6x6x6q_novel_20260522.json` |
| **H₃Po** | Im-3m | 4 | novel (no published Tc) | ✅ **LANDED** — 6³ q (16 q-points) · λ_BZ=3.31 (broad=0.015) → 2.75 (broad=0.030) · ω_log=258–273 K · Tc_AD(μ=0.10)=47–48 K · Tc_AD(μ=0.13)=45–46 K · celldm=6.236 (artifacts `~/etc/rtsc-results/h3po/`) | (emit on completed-form export) |

Group-16 verdict (3/4 LANDED): H₃S = sweet spot · H₃Se = weaker coupling outlier · H₃Te = λ matches H₃S but ω_log 추락 (heavy Te). "go heavier hydride" 단순 전략은 chalcogenide family 안에서 dead end 임이 numerically demonstrated (R4 Pattern 2 — breakthrough path 는 ternary / clathrate / ambient frontier · §9.10 N5 / §9.12.A clathrate).

#### Clathrate + group-14/17 expansion

| track | status | notes |
|---|---|---|
| **CaH₆ sodalite clathrate** (Ma 2022, 7-atom Im-3m, measured 215 K) | ✅ **LANDED 측정-grade 검증** (2026-05-24, pool:ubu-2) — Tc(μ0.13)=213 K vs measured 215 K (**2 K 정합**) · λ_BZ=3.40–4.38 · ω_log=1177–1236 K · NaN=0. **근본원인 = input cell-choice** (이전 Vast/pool NaN 폭주는 ibrav=1 nat=14 conventional + press=0 의 user-side error · 수정 = ibrav=3 nat=7 BCC primitive + 170 GPa). H₃S 와 함께 측정-grade anchor 2개 (clathrate topology). artifacts `~/etc/rtsc-results/cah6/` |
| **H₃X group 14-17 parallel fanout** (8 후보 — h3o · h3f · h3n · h3si · h3p · h3cl · h3as · h3br) | ⏳ **in-progress 4/8 LANDED** — **h3o 완주** (6³q · λ_BZ=2.31–2.73 · ω_log=1089–1111 K · Tc(μ=0.10)=171–191 K · celldm=4.899 · 🟢 §9.15 PASS pred 150-220 · novel high-Tc) · **h3cl 완주** (λ=1.14–1.41 · ω_log=1252 K · Tc=105–134 K · celldm=5.659 · 🔴 FAIL above pred 25-60) · **h3f 완주** (λ=0.81–0.82 · ω_log=652–670 K · Tc=31–33 K · celldm=5.127 · 🔴 FAIL below pred 50-100) · **h3si 완주** (λ=1.72–1.82 · ω_log=572–624 K · Tc=77–80 K · celldm=5.656 · 🟢 PASS pred 50-110) · artifacts `~/etc/rtsc-results/{h3o,h3cl,h3f,h3si}/` · 나머지 4개 pod 진행 중 (h3n/h3p/h3as/h3br) · h3c (serial orchestrator) · cah6 (clathrate, Vast 37378728 라이브 — pool:ubu-1 CaH₆ 는 OOM dead) | group 14/15/16/17 의 H₃X 패턴 sweep · novel-prediction 영역 (§9.10 N5 의 candidate funnel pattern) · **h3o = 191 K novel high-Tc 후보** (group-16 light O, celldm=4.9 최소) — group-16 sweet spot 가설 강화 · **d7 wall 메커니즘 정확 식별**: ALIGNN per-cand H₃Cl λ=0.81 vs DFT 1.27 (+57% 차) — λ-magnitude 가 아니라 **ω_log 15× under (81 K vs 1252 K)** 가 dominant ML failure mode (고압 H-derived 고진동 모드 ambient-ML training 부재). family-wide 미분화 가설 부분 falsify, wall 강화. |
| **H₃X group 14-17 serial orchestrator** (h3c → h3n → ... 한 인스턴스) | ⏳ **in-progress** — single Vast.ai instance, serial-chain orchestration | parallel fanout 의 cross-validation · 같은 후보들을 직렬로 흘려 결과 reproducibility 확인 |

본 fanout 의 핵심: §9.12 H₃S 교과서급 6³ q ladder + §9.12.A 4³ q honest baseline 가 *protocol* 으로 박혀 있어 동일 grid 정책으로 group-wide sweep 가능 (per-candidate manual setup 없이 자동화 가능 — `process_completed_pod.sh` 가 schema-uniform record 보장).

#### ALIGNN family-wide d7 wall ML baseline (9/9 후보 · 2026-05-24)

cycle 6 + 7 합쳐 9/9 H₃X family-wide ALIGNN per-candidate baseline 완주 (pool:ubu-1, alignn 2026.4.2 / torch 2.4.0+cpu, 평균 0.7 s/cand). 각 후보 input.vasp 는 publication-grade Im-3m primitive (4 atom · element 별 celldm bohr) — DFT 와 동일 구조. artifacts: `~/etc/rtsc-results/{h3o,h3po,h3f,h3si,h3cl,h3p,h3n,h3as,h3br}/alignn_{predict.json,run.log,input.vasp}`.

| candidate | group | celldm (bohr) | ALIGNN λ | ALIGNN ω_log (K) | ALIGNN Tc-direct (K) | DFT 상태 (§9.14 fanout) |
|---|:---:|---:|---:|---:|---:|---|
| H₃Cl | 17 | 5.66 | 0.81 (cycle 4) | 81 | 3.82 | LANDED Tc=120 K 🔴 FAIL above (§9.15) |
| H₃O  | 16 | 4.90 | **−0.42** | 0 (degenerate) | 4.34 | LANDED Tc=180 K 🟢 PASS (§9.15) |
| H₃Po | 16 | 6.24 | **−0.21** | 0 (degenerate) | 3.69 | LANDED Tc=48 K (RTSC.log §9.15) |
| H₃F  | 17 | 5.13 | 0.53 | 81 | 2.93 | LANDED Tc=31 K 🔴 FAIL below (§9.15) |
| H₃Si | 14 | 5.66 | 0.29 | 286 | 3.02 | LANDED Tc=78 K 🟢 PASS (§9.15) |
| H₃P  | 15 | 6.50 | 0.58 | 77 | 2.17 | PENDING |
| H₃N  | 15 | 5.50 | **−0.18** | 0 (degenerate) | 5.97 | PENDING · 신규 sign-path |
| H₃As | 15 | 6.70 | 0.13 | 3.14×10⁵ (artifact) | 2.55 | PENDING |
| H₃Br | 17 | 6.60 | **1.11** | 29 | 4.29 | PENDING · 신규 λ≥1 outlier |

**핵심 family-wide 신규 발견** (cycle 6+7 통합):

1. **Sign-pathology family-wide 3/9** — H₃O · H₃Po · **H₃N** (light X strong covalent localization). 정량 패턴 = "light X polar bonding → ALIGNN a²F anti-bonding projection → λ negative → ω_log degenerate → Tc cap 4-6 K via ALIGNN direct-Tc head 만 유효". 3 cand 모두 anion 의 short H-X bond + high χ (O 3.44 · N 3.04 · Po 2.0 high-Z polar) 가 공통 axis.
2. **λ ≥ 1 strong-coupling outlier 2/9** — H₃Cl (cycle 4, 0.81 borderline → DFT 1.27 cross-confirm) + **H₃Br (1.11)** — group-17 mid-heavy halide outlier. **family 안에서 ALIGNN 이 λ≥1 으로 ranking 한 유일 2 점** → DFT 도착 (h3br) 시 strong-coupling 가설 결정적 cross-check.
3. **Tc-direct cap 4-6 K family-wide** — `jv_supercon_tc_alignn` head 의 ambient training-distribution 출력 ceiling. max = h3n 5.97 K. ambient ML 의 hydride ω_log under-prediction wall 정량화 (vs DFT 측정-grade 31-180 K).
4. **group-15 ML λ 광범위 분산** — −0.18 ~ 0.58 (h3n / h3p / h3as 3-cand 폭 0.76). group-17 (0.5-1.1) 대비 더 광역 — group-15 의 covalent-polar transition zone 가설 강화 (group 16 monotone sign-path · group 14/17 잘 정의).

```
       ALIGNN λ landscape (9 H₃X · 2026-05-24)

 λ ≥ 1.0  |   .   .   .   .   .   .   .   . [BR]   ← strong-coupling outlier
          |
 0.5–0.9  | [CL][P ][F ]                                ← family typical
          |
 0.1–0.5  |                  [SI][AS]                   ← weak coupling
          |
 0.0      |==============================================
 −0.5     |        [N ][PO][O ]               ← SIGN-PATHOLOGY (3/9)
          |    (light X polar covalent localization)

   group:    15  16  16  17  14  15  17  15  17
   light←→heavy (X mass increases right)
```

**d7 governance 매핑**:
- ALIGNN ambient training-distribution wall **정량 family-wide 확정** — 5 LANDED 후보 전부 측정/DFT vs ML 의 |rel_err| ≥ 80% (h3cl 96.8% · h3o 97.6% · h3f 90.5% · h3si 96.1% · h3po 92.3%). d7 = "first-principles physics breaks the ML training-distribution wall" 의 *family-wide quantitative* 입증.
- **Sign-pathology family-wide 3/9** 가 d7 메커니즘의 *새 layer* — ω_log under (cycle 4 root cause) 위에 **λ sign-flip** 이라는 더 catastrophic failure mode 추가 식별. inbox `d7-wall-mechanism-breakthrough-paths-2026-05-23.md` 의 2026-05-24 update 에 박힘.
- **next critical test = H₃Br** (cycle 7 ALIGNN strong-coupling λ=1.11 → DFT 도착 시 검증). h3cl 의 monotone broad sweep (under-converged) 와 같은 패턴이면 H₃Br DFT λ 가 진짜 1.5+ 일 수 있음. inbox `h3br-critical-test-2026-05-24.md`. ETA 04:00 5/25 KST (~25h).

**R4 보호** (모든 결과): `absorbed=false` · `gate_type=simulation-only-prediction` · domain=material · ALIGNN = ambient-trained Tier-1 prediction (measurement-oracle 아님). family-wide null/sign 결과가 RTSC absorbed=true 와 무관 — pure d7 wall 메커니즘 정량화 layer.

##### d7 wall mechanistic root — α²F grid ceiling (2026-05-24)

ALIGNN per-candidate α²F(ω) head 의 출력 grid 는 **0–100 meV · 100-bin** (천장 100 meV) — 즉 100 meV 위 진동 모드를 표현할 bin 자체가 없다. 고압 hydride 의 H-derived stretching mode 가 이 천장을 넘어 살아 ω_log under-prediction 의 root cause 가 된다:

| candidate | DFT ω_log (meV) | vs grid ceiling 100 meV |
|---|---:|---|
| H₃Cl | **107.9** | **천장 초과** — H-stretch bin 부재 |
| H₃O  | **94.5**  | 천장 근접 — high-ω tail truncated |

**2 결손 채널** (별개): ① **high-ω truncation** — H-stretch mode (>100 meV) 가 grid 위에 살아 ω_log 를 끌어내림 (정상 λ 후보의 ω_log 15× under 의 root). ② **acoustic-edge sign-pathology** — λ_density = 2·α²F/ω·dω 의 1/ω 가중이 ω→0 에서 음수 α²F 를 폭증시킴 (h3o 0.5 meV bin λ_dens = **−0.489**, neg-λ 의 82%). sign-pathology(음수 λ)는 high-ω truncation 과 독립 채널.

**BEE-NET 구조적 해결 가능성**: a²F≥0 clamp + EMDLoss 로 sign-pathology 채널은 봉합 가능하나, 동일 0–100 meV grid 를 쓰면 high-ω truncation 은 잔존 → **grid 확장 retrain** 이 필수 조건. 설계: `archive/session-notes/d7-wall-beenet-poc-design-2026-05-24.md`.

**d7 governance 부합**: "ML training-distribution wall" 의 정확한 물리 = **α²F grid ceiling** (고압 H-mode 가 ambient-ML grid 밖). breakthrough = first-principles DFT (천장 무제한 — H₃S 6³q 측정-grade 입증) 또는 grid-extended ALIGNN/BEE-NET retrain. ML 더 돌리기로는 천장 못 넘음 (d7 dont).

#### Harness — `process_completed_pod.sh`

| 항목 | 값 |
|---|---|
| status | ✅ **LANDED** (external tool · `/tmp/rtsc_vast/process_completed_pod.sh`) |
| schema 일치 | 21/21 fields conform |
| R4 invariant | hardcoded `absorbed=false` · `gate_type=simulation-only-prediction` |
| 역할 | Vast.ai pod 완료 → record JSON emit → `exports/material_discovery/` land |

이 harness 는 본 campaign 의 schema-uniform record 보장 layer — pod 완료 시 *자동* 으로 R4-conformant record 가 land, manual edit 우회 (Pattern 1 회피 hardcoded).

#### Honest scope (campaign 전체)

- 모든 cell = high-pressure regime (150–200 GPa), gate (c) ambient FAIL · gate (b) measured 부재 (novel) 또는 wet-lab 의존 · **RTSC absorbed=true 와 무관** (§9.13 capstone scope 그대로)
- DFT el-ph 는 Tier-1 *prediction* — measurement-grade 일치 (H₃S 6³ q) 도 measured-oracle 아님 (R4 d6)
- novel candidate 의 Tc 예측은 *후속 wet-lab 우선순위* — *발견* 아님 (R4 Pattern 1 회피)
- in-progress 항목은 `RTSC.log.md` 의 chronicle entry 가 일일 진행 기록 (per g15: current-state 는 본 doc · time-stamped 는 log)

## 10. d7 wall 돌파 로드맵 + 후보 verdict

§9 캠페인의 *방법론 레이어* — 물질 발견(§9)과 직각인 "ambient-ML training-distribution wall 을 어떻게 깨느냐" 트랙. RTSC 우산 유지 (별도 도메인 없이 §10). 숫자 SSOT 는 `exports/material_discovery/` (canonical record · §9.14), 본 §10 은 *forward 로드맵*.

### 10.1 가장 유망 후보 verdict (2026-05-24)

ranked by Tc(μ=0.10) — LANDED 5 + baseline 3:

| rank | candidate | Tc (K) | λ_BZ | class | 비고 |
|---|---|---:|---:|---|---|
| — | H₃S | 203 (measured) | 2.4 | known | Drozdov 2015 anchor |
| — | **CaH₆** | **213 (DFT) vs 215 (measured)** | 3.40–4.38 | **known · 검증** | **Ma 2022 측정 215K 와 2K 정합 — cell-choice 근본원인 수정 + 측정-grade 파이프라인 검증** |
| **1** | **h3o** | **171–191** | 2.31–2.73 | **novel** | **top novel · group-16 sweet · O metastability 해소 (4 broad real mode)** |
| 2 | h3cl | 105–134 (6³) | 1.14–1.41 | novel | **4³q 검증: under-conv 확정 (λ_4³≳λ_6³ 단조) → 8³q 시 λ 1.6+ · Tc 150–180K 가능 → h3o 추월 후보** |
| — | H₃Se | 113 | 1.0–1.3 | novel | group-16 |
| 3 | h3si | 77–80 | 1.72–1.82 | novel | group-14 · §9.15 PASS |
| — | H₃Te | 75 | 2.4 | novel | group-16 heavy |
| 4 | h3po | 47–48 | 2.75–3.31 | novel | group-16 heaviest · 10/16 q provisional |
| 5 | h3f | 31–33 | 0.81 | novel | group-17 light |

**verdict 정정 (2026-05-24 ph.out raw-mode 재분석) — `h3cl` = #1 stable 후보, `h3o` 강등**:

이전 "h3o #1 (191 K, imaginary 0)" 판정은 **틀림** — result.txt 요약만 보고 raw phonon mode 미확인. self-DFT augment agent 의 ph.out 직접 파싱 결과:
- **h3o · h3f · h3si = imaginary phonon modes** (ω 최저 −140 meV) = **동역학적 불안정** (Im-3m metastable, 뒤틀림 선호). h3o 191 K 는 *unstable mode drop* convention 값 = upper-bound, 구조 신뢰 낮음. O metastability 우려가 **실재** (이전 "해소" 판정 철회).
- **h3cl · h3po = real modes only (동역학적 안정)**.

→ **새 verdict**:
- **#1 `h3cl`** — 동역학적 안정 (real mode) + under-conv 확정 (8³q 시 Tc 상향 가능) = 가장 신뢰할 stable novel 후보. Tc 105–134 K (6³), 8³q 결과 대기.
- #2 `h3po` — 안정 (real) · 47–48 K · 10/16 q provisional (16/16 rerun 권장).
- ~~h3o 191 K~~ — imaginary mode 로 강등 (unstable-mode-drop upper-bound · 구조 안정화 필요).
- h3f/h3si — imaginary mode (unstable).

**`h3cl` 상세** (4³q 검증 완료 2026-05-24): λ_4³ (1.235–1.417) ≳ λ_6³ (1.135–1.406) 단조 수렴 → **under-converged 확정** (6³ over-est 기각). 8³q 재계산 시 true λ 1.6+ → Tc 150–180 K 가능. **동역학적 안정 (imaginary mode 無)** 이므로 h3o (unstable) 대비 물리적 신뢰 우위 — 8³q 완주 시 stable high-Tc 후보 확정.

**imaginary-mode 정정 메모**: h3o/h3f/h3si 의 imaginary phonon mode 는 Im-3m 구조의 dynamical instability — λ 계산은 positive-frequency BZ sum (unstable mode drop) convention 으로 result.txt 와 일치하나, 구조 자체가 metastable 이라 *합성 가능성 더 불확실*. 안정화 path: anharmonic SSCHA (quantum nuclear effect 로 imaginary mode 가 stabilize 될 수 있음 — H₃S/LaH₁₀ 선례) 또는 distorted lower-symmetry 구조 재탐색.

**파이프라인 검증 anchor — `CaH₆`** (2026-05-24): cell-choice 근본원인 수정 (ibrav=3 BCC primitive + 170 GPa) 후 6³q-equiv DFT 가 **Tc 213 K (μ0.13, broad=0.030) — Ma 2022 측정 215 K 와 2 K 정합**. NaN=0 끝까지 healthy. H₃S textbook proof 와 함께 *측정-grade 일치* 두 번째 anchor (clathrate topology) — DFT el-ph 파이프라인 + d2 wall 돌파 (Sternheimer NaN = input error) 검증. R4: known material 이라 *발견* 아님 · 측정-grade 도 measured-oracle 아님 (d6).

R4 보호: 전부 `absorbed=false` · `gate_type=simulation-only-prediction` · novel 은 *wet-lab 우선순위* 이지 *발견* 아님.

### 10.2 두 돌파 path

```
d7 wall = α²F grid ceiling 100 meV (§9.14)
   │
   ├─ path A: first-principles DFT (substrate · 천장 무제한)
   │    H₃S 6³q measurement-grade 입증 · el-ph 직접 계산
   │    cost: pool/Vast CPU · small cell 4-7 atom 무료 baseline (d8)
   │
   └─ path B: grid-extended ML retrain (BEE-NET)
        a²F≥0 clamp → sign-pathology 봉합 + EMDLoss high-ω mass 보존
        BLOCKER: grid 천장 101→140 meV 확장 필요 (안 하면 path A·B 둘 다 무효)
        cost: ~12-20 GPU-hr (A100 ~1일) · 5점 smoke + 50-100점 augment
```

### 10.3 BEE-NET POC 5-step (path B 실행 시)

| step | 내용 | 상태 |
|---|---|---|
| 0 | grid ceiling 101→140 meV 확장 | ✅ **해소** (2026-05-24 · `utils/data.py:15` `Freq_final` 51→71 bin · CPU smoke 4/4 PASS) |
| 1 | pretrained BEE-NET load (henniggroup/BETE-NET) | unblocked · ensemble .pt full-clone 필요 |
| 2 | DFT→α²F target 형식화 (ph.out 파싱, a2F.dos 덤프 필요) | unblocked |
| 3 | μ_HX (path e) + pressure (path i) l=0 주입 | unblocked |
| 4 | fine-tune (LOO-CV · 5점 → 50-100점 augment) | GPU ~11-19 GPU-hr (A100 ~1d) · 사용자 결정 |
| 5 | sanity gate (sign-pathology 0 · ω_log MAE) | deferred |

**step0 해소 상세**: grid SSOT 단 1곳 (`utils/data.py:15` `Freq_final = np.arange(0.25,101,2)` 51-bin) → `arange(0.25,141,2)` 71-bin 으로 확장 (첫 51 bin append-only 동일 → backbone 전이 안전). h3cl 107.9 meV mode 가 신규 20 bin 에 표현됨. pretrained 호환: `{em, layers.2}` re-init + backbone freeze transfer (CPU smoke: grid 71bin ✅ · a²F≥0 clamp ✅ · forward (1,71) all≥0 ✅). 설계 상세: `archive/session-notes/d7-wall-beenet-poc-design-2026-05-24.md` + `archive/session-notes/beenet-grid-extension-step0-2026-05-24.md` · arxiv 비교: `archive/session-notes/post-alignn-ml-sc-predictors-survey-2026-05-24.md`

### 9.16 discovery funnel — stage 전이 (current-state)

RTSC novel-discovery funnel 의 현재 stage. binary 가 닫혀 cation-stuffed ternary 로 넘어간 상태.

```
 ┌────────────────────────────────────────────────────────────────────┐
 │  N5 — binary hydride sweep (H₃X)             [ CLOSED · WALL ]       │
 │    h3cl 140K · h3o 9–109K(SSCHA, M8 1/3) · h3br 110K · h3si 78K      │
 │      → 전부 stable 이나 Tc < 200K                                     │
 │    h3po → unstable                                                    │
 │    벽: "stability ↔ strong-λ" 트레이드오프 (V5 m<0, h3o m=−1.479)     │
 │        ⟨ω²⟩ 가 λ 분모(작을수록 좋음) & 안정성 판별식(클수록 좋음)      │
 │        이중 역할 → binary 단일 손잡이로는 동시 최적화 불가             │
 └───────────────────────────────┬────────────────────────────────────┘
                                  │  cation 이 η·⟨ω²⟩ decouple (V5 §2)
                                  ▼
 ┌────────────────────────────────────────────────────────────────────┐
 │  N6 — cation-stuffed ternary                 [ ACTIVE · NEXT ]       │
 │    트랙 A: X₂MH₆ octahedral (Fm-3m · ambient-stable)                 │
 │      Mg₂IrH₆ 160K 🟡PRED ambient · Li₂CuH₆ 86K 🟡PRED ambient        │
 │    트랙 B: MXH₈ alloy-backbone (sub-100 GPa)                         │
 │      LaBeH₈ 110K 🟢MEASURED @80GPa · LaBH₈ 156K 🟡PRED               │
 │    가설: cation pre-compression → ⟨ω²⟩↑(안정) & N(Ef) H성격 보존(강λ) │
 │        → m>0 ESCAPE (V5 CaH₆ anchor m=0.5)                            │
 │    후보 매트릭스: RTSC/research/ternary_ambient_candidates.md         │
 └────────────────────────────────────────────────────────────────────┘
```

**N5 (CLOSED)**: §9.10 의 compositional-space funnel 을 binary H₃X 로 실행 → §10.1 verdict + V5 트레이드오프로 **wall 확정**. binary 는 RTSC 에 대해 고갈 (stable→weak-Tc / strong-λ→unstable 양분). honest: 전부 `absorbed=false` · `gate_type=simulation-only-prediction`.

**N6 (ACTIVE)**: cation-stuffed ternary (X₂MH₆ + MXH₈) 가 active next stage. cation 이 분자 η 와 분모 ⟨ω²⟩ 를 **decouple** (V5 §2) → m>0 ESCAPE 가능성. Tc 값 honest tagging — 🟢 MEASURED (LaBeH₈ 110K) vs 🟡 PREDICTED (나머지 전부 lit-계산값, NOT measured). 후속 = N6 ternary 의 DFT m>0 검증 (milestone 참조).

> **M8 m-gate (refined)**: M8 의 "stable" 축은 단순 imaginary-free 가 아니라 **`m > 0` (anharmonic ESCAPE)** 으로 정련된다. `stability_coupling_margin m = (⟨ω²⟩_anharm − ⟨ω²⟩_λ)/⟨ω²⟩_anharm` (m>0 ESCAPE · m<0 TRAPPED · m=0 정확히 벽) — closed-form 정량자, `RTSC/verify/V5_stability_coupling_wall.md` 에서 🟢 SUPPORTED-NUMERICAL (CaH₆ m=0.5 escape · h3o m=−1.479 trapped). 따라서 **M8 = (압력 < 50 GPa) AND (stable: m>0) AND (Tc > 200K)**. N5 의 stable 후보들은 imaginary-free 였으나 m<0 (trapped) → M8 미달. anharmonic λ-suppression `S = ⟨ω²⟩_harm/(⟨ω²⟩_harm+Δω²)` 도 같은 V5 에서 🟢.

### 9.10 N5 cohort 신설 — novel-discovery funnel (compositional space exploration)

§9.7 의 N1-N4 는 *KNOWN candidate* (특정 화학식이 주어진 경우) 의 시뮬레이션. **N5 cohort 는 *unknown novel composition* 을 *compositional space 에서 탐색* 하여 RTSC 후보 funnel 을 emit** — Nature `s41524-026-01964-8` 의 1.3M cand → 741 stable funnel 패턴 + arxiv:2511.03865 의 Materials Genome HTS discovery 워크플로 본받음.

#### N5 의 위치

- **(a)(b)(c) gate 의 *시뮬 영역* 만 채움** — (d) 다중 lab 재현 + (e) measurement-oracle 은 영원히 wet-lab 의존 (§8.9 honest限界)
- gate_type 신규 값: **`novel-discovery-simulation`**
- `absorbed=false 영구` (R4 invariant 하드코드)
- 산출의 의미 = *wet-lab 우선순위 candidate list (top-K)*, NOT actual SC discovery

#### N5 pipeline

```
novel_material_funnel.py <element_pool> <stoichiometry_constraints> <out_dir>
  → enumerate candidate compositions (combinatorial)
    for each candidate:
      1. MP cache check (이미 알려진 물질 → skip · novelty filter)
      2. N4 cross_code_dft → formation_energy + stability (convex hull)
      3. (if stable AND novel) N1 csp_adapter → predicted structure
      4. (if structure usable) N2 beenet_adapter → predicted Tc
      5. (if Tc > threshold) N3 askcos_adapter → synthesis route 제안
    rank by composite score (stability × Tc × synth-feasibility)
    emit `exports/material_discovery/<run_stamp>/top_k.json`
```

#### 입력 / 출력

- **Input**: `element_pool` (e.g., ["La", "H"] for the hydride family, or ["H", "S", "C"] for the carbonaceous-sulfur-hydride lineage) · `stoichiometry_constraints` (n_atoms ≤ 30 · charge balance · etc.) · `tc_threshold_K` (default 50)
- **Output**: top-K JSON list of (composition, predicted_structure, predicted_Tc, predicted_route, composite_score, novelty_flag), with 5-gate evaluation per candidate (모두 (a)(b)(c) sim PASS or FAIL · (d)(e) 자동 SKIPPED).

#### Honest g3

- N5 도 wrap pattern (Path B) — N1-N4 를 *orchestrate* 만 함, 본문 logic 은 그대로 delegate
- 단일 wet-lab 시간으로는 1.3M candidate 일일이 합성 불가능 — N5 의 funnel 은 **상위 K 후보 (e.g., K=10) 우선순위 list** 까지만 honest
- "이 후보가 RTSC 일 가능성 있음" ≠ "이 후보가 RTSC 임" — R4 Pattern 1 회피 영구
- arxiv:2511.03865 의 Material Genome Initiative pattern: 후보 → DFT screen → ML predict → synthesis-feasibility score → wet-lab 우선순위

#### 발사 일정

- ~~이 세션 (Phase 4 microkernel #1 와 평행): N5 cohort agent (B path · wrap-as-is) 발사~~ → ✅ **LANDED** hexa-lang `701bfe1b` (`stdlib/material/novel_material_funnel.py`) · Phase 4 #1 도 같은 commit 에서 land · §9.9.1 Phase progress table 참조
- Phase 2 stabilization (16-cell sanity 그대로) 의 5번째 row 로 N5 추가 (다음 세션 audit) — 16-cell audit 자체는 ✅ LANDED (`archive/session-notes/2026-05-21-rtsc-9-phase2-stabilization.md`) · 16→20 ext (5th baseline 추가) ⏳ PENDING
- Phase 3 audit 재실행 (N1-N5 5 cohort 통합) — N5 microkernel 후보 식별 (compositional enumerator? scoring formula?) ⏳ PENDING (`archive/session-notes/2026-05-21-rtsc-9-phase3-microkernel-audit.md` 는 N1-N4 cover, N5 까지 확장 audit 별도 session)

### 9.9 Web non-arxiv 참고 URL

- Nature `s41524-026-01964-8` — Complete AI-accelerated SC discovery workflow (2026 best SOTA)
  · https://www.nature.com/articles/s41524-026-01964-8
- Nature `s41524-024-01443-y` — Deep learning generative CSP (2024)
  · https://www.nature.com/articles/s41524-024-01443-y
- NCBI `PMC11425200` — Room-Temperature SC in Quasi-Atomic H₂ Hydrides at High Pressure (2024)
  · https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11425200/
- `pymatgen-io-validation` — github (DFT cross-validation)
  · https://github.com/materialsproject/pymatgen-io-validation/
- `MatBench` — matbench.materialsproject.org
  · https://matbench.materialsproject.org
- `epw-code.org` — EPW (Eliashberg in QE)
  · https://epw-code.org
- `abinit.org` — ABINIT DFT
  · https://abinit.org
- `materialsproject.org` — MP REST API + bulk dump
  · https://next-gen.materialsproject.org/api
- `htsmodelling.com` — HTS Modelling Workgroup shared files
  · https://htsmodelling.com
- `crystallography.net` — COD (Crystallography Open DB)
  · https://crystallography.net
- `aflowlib.duke.edu` — AFLOW DB
  · http://aflowlib.duke.edu
- `supercon.nims.go.jp` — NIMS SuperCon DB (register-only)
  · https://supercon.nims.go.jp
- `pvlib-python.readthedocs.io` — pvlib (energy domain absorbed=true precedent)
  · https://pvlib-python.readthedocs.io

---

---

Historical log entries are in [`./RTSC.log.md`](./RTSC.log.md).
---

# (legacy) verb-cell public-surface — preserved for ARCH/DESIGN/PLAN refs

# domain — RTSC (high-field / superconducting magnet & coil)

> Status: **shallow public-surface map** (`design.md` Decision 3 hybrid).
> Boundary: public-surface clean-room (`design.md` Decision 1). Source:
> Agent-3 (cited). Pipeline = 7-verb spine (`HANDOFF.md` §4 · D5).

**Sibling sub-domains** (hexa-rtsc repo): room-temp-sc · superconductor

## 1. "Design blueprint" deliverable

Coil winding geometry + conductor (REBCO / Bi-2212) layout, field map,
current / critical-state distribution, AC-loss and quench / stress
budget.

## 2. Public-surface tool map (7-verb 1:1)

| verb | 오픈소스 | 상용 — 공개문서 한정 |
|---|---|---|
| 명세 SPECIFY | (target field / current / temperature spec) | — |
| 구조 ARCHITECT | (coil / cryostat layout) | — |
| 설계 DESIGN | **FEMM** (2-D / axisymmetric magnetics, electrostatics, heat & current flow) | — |
| 해석 ANALYZE ⟲ | **HTS Modelling Workgroup** shared REBCO / HTS critical-state model files | **ANSYS Maxwell**, **COMSOL**, **Opera**, **JMAG** (3-D coupled EM-thermal-quench) |
| 합성 SYNTHESIZE | **FEM Magnetics Toolbox** (power-electronic magnetic components); FEMM winding definition | — |
| 검증 VERIFY | **GetDP / Elmer** open FEM solvers for EM device analysis | ANSYS A-V formulation (REBCO tape-stack magnetization) — public docs only |
| 인계 HANDOFF | (winding / cryostat fabrication handoff) | — |

## 3. Notable proprietary (public docs only)

**ANSYS Maxwell**, **COMSOL Multiphysics**, **Opera**, **JMAG**. ANSYS
A-V formulation is widely used for REBCO tape-stack magnetization
(HTS workgroup public ref). Gap is large for **3-D, multiphysics
(EM + thermal + structural quench)** HTS modelling — open FEMM is
essentially 2-D / axisymmetric; the 3-D HTS coupled workflow is
dominated by ANSYS / COMSOL.

## 4. Biggest open-source gap

3-D coupled EM–thermal–mechanical quench / AC-loss simulation for
REBCO / Bi-2212 coils (open tooling is 2-D-limited).

## 5. Cited sources

- FEMM — <https://sourceforge.net/projects/femm/>, <https://github.com/cenit/FEMM>
- FEM Magnetics Toolbox — <https://github.com/upb-lea/FEM_Magnetics_Toolbox>
- HTS Modelling Workgroup — <https://htsmodelling.com/?page_id=748>, <https://htsmodelling.com/model-files/archive/2024/03>
- Proprietary EM tools survey — <https://www.researchgate.net/post/Other_than_maxwell_what_are_the_softwares_available_for_electric_motor_design>

## 6. Design options (workbench shelf)

> rfc_012 §5 ingredient shelf — plain design options per verb.
> Line form `- <verb>: <group> = a / b / c`; ` ; ` separates groups.

- 구조: 권선 = 팬케이크 / 솔레노이드
- 설계: 도체 = REBCO / Bi-2212

## 10. Mining (lens 기반 가지치기) (293K@1atm DFT discovery)

> 협업 brainstorm 영구 기록 + 아이디어 cart. 사이클마다 append, 트리 가지치기 고갈까지.

- [`rtsc.mining.md`](rtsc.mining.md) — 사이클별 분석·추론·도구 누적 (Cycle 1-8)
- [`rtsc.mining.tape`](rtsc.mining.tape) — 24+ 아이디어 backlog + 라운드별 발산 (R1-R5 + frontiers 4)
- 관련 wall doc: [`RTSC/walls/stability_coupling_margin.md`](RTSC/walls/stability_coupling_margin.md) — m-sign closed-form (PR #335/344/346 landed)

방법: math↔physics 같은-공식 cross-pollination (RG flow · Ricci surgery · 최적수송 · Perelman 엔트로피 · Kramers · ZPE-Casimir · Lifshitz/persistent-homology · BKT · Lyapunov 등). 차원 사다리 2D(m×ω) → 5D(+μ*, +stability, +P) → 6D(+f_H). Top 보석: x11 Kramers 회수성(293K@1atm 직격) · x3 OT H-모드분율 · C1 양자-회수 ZPE.

### 5분 쉽게 보기
- [`rtsc.easy.md`](rtsc.easy.md) — 캠페인 한 페이지 (5분 입문, easy 모드 ASCII)

## 11. RTSC-TRIANGULATE — N-dim independence-weighted consensus screen (NOVEL, d18)

> Multi-bearing, N-dimensionally-extensible candidate screen. Each **bearing** is an
> INDEPENDENT cheap predictor of phonon-mediated high-Tc; a candidate high across MANY
> independent bearings is far more likely real (variance ~1/k, like adding GPS
> satellites). Reserves the DAYS-long DFPT el-ph (Li2MgH16 anchor) for the triangulated
> top only.

- **Code home (d3)**: `hexa-lang stdlib/rtsc/` —
  `triangulate.hexa` (fusion + PCA independence math) · `triangulate_bearings.hexa`
  (4 cheap composition bearings A=ω_log/mass · B=N(E_F)·H-char · C=H-network connectivity
  · D=descriptor-McMillan-Tc) · `triangulate_decorr.hexa` (DECORRELATED real-physics
  producers — see below) · `triangulate_test.hexa` (g5 gate, `@ci_gate`, 68/68 PASS) ·
  `triangulate_run.hexa` + `triangulate_decorr_run.hexa` (real-set drivers) ·
  `TRIANGULATE.design.md` (formalization).
- **d4 generic**: a bearing = a named score column; adding one = a one-line manifest extension.
- **Independence check**: Pearson-corr-matrix Jacobi eigendecomposition → participation-ratio
  `effective_dim = (Σλ)²/Σλ²`; WARNS when bearings are redundant (the 1/k shrink honesty gate).
- **Run (42 hydride formulas)**: top-10 = CaH10 · ScH9 · MgH6 · Li2MgH16* · SrH10 · YH10 ·
  CaH6* · ScH6 · YH9* · LaH10*  (`*` = DFPT-confirmed anchors — all land top-10 = sanity OK).
- **Next DFPT targets** (triangulated intersection, non-anchor): **CaH10 · ScH9 · MgH6 · SrH10 · YH10 · ScH6**.
- **Bearing DECORRELATION — BEFORE → AFTER (d2 breakthrough, the substantive upgrade)**:
  the composition PROXY bearings collapsed to `effective_dim 1.51/4` (max|corr| 0.94, warn
  fires) because A=mass · B=H-shape · C=H/former · D=McMillan-over-the-same-λ-proxy all read
  the SAME 2-3 composition scalars. Each proxy was swapped (`triangulate_decorr.hexa`, d4
  one-column swap, fusion+PCA core UNCHANGED) for a REAL producer on a **different information
  channel**: **A** = force-constant Debye ω (elastic/bonding: per-element H–X spring + reduced
  mass, NOT mean mass) · **B** = **real N(E_F)** literature/DFT anchor table (electronic channel
  — the decisive swap; CeH9/CeH10 4f-suppression gives LOW N(E_F) at HIGH h_frac, breaking the
  composition lock-step) · **C** = **real H-sublattice coordination** from the known crystal
  structure (sodalite cage 4–6 vs molecular 1–2, crystal-chem channel) · **D** = independent
  feature-basis Tc (EN-spread + VEC + radius-packing logistic, NOT McMillan-over-λ).
  **MEASURED result (PCA = the truth-teller, d6):**
  - **`effective_dim 1.51/4 → 3.08/4`** on the high-Tc **superhydride family** (real N(E_F)≥1.5,
    n=21 — the regime where the screen actually picks DFPT targets), **redundancy warn CLEARS**,
    max|corr| 0.94 → **0.53** (B↔C 0.94 → **0.079** within the family).
  - full 42-set = **2.04/4** (honest: lower because the molecular/insulator tail PdH·H2O·B2H6
    co-vanishes on B and C — REAL physics, no H-network ⇒ no H-DOS — not residual redundancy).
  - decorrelated ranking top: **YH10 · YH9 · CaH10 · ScH9 · CaH6\* · LaH10\*** — anchors stay
    top-10, ranking integrity preserved. Anchors VERBATIM from hydride-SC literature (NOT tuned).
  - **Remaining step** (to lift the FULL-set number too): replace the literature anchor TABLE
    with on-the-fly producers for the insulator tail — a cheap 1-SCF `qforge_dos_nef` N(E_F)
    (brick EXISTS) + ELF/graph H-coordination on a relaxed cell. DFPT confirmation of the top
    candidates is a SEPARATE deferred QFORGE milestone (out of scope). **→ DONE below (f5).**
- **TABLE-FREE on-the-fly bearings — the full-set ceiling DECOMPOSED (artifact vs physics, d6)**:
  the literature N(E_F)/coord ANCHOR TABLE in B′/C′ was replaced by **table-free producers**
  (`triangulate_otf.hexa`, d4 one-column swap, fusion+PCA core UNCHANGED): **B″** = a
  **free-electron-gas N(E_F)** (Sommerfeld `g(E_F)=(3/2)N_val/E_F`, `E_F=3.80998·(3π²n)^{2/3}` eV,
  `n=N_val/V_est`, `V_est` = Wigner-Seitz sphere-sum from element radii) × H-1s metallization
  gate × EN-gap insulator suppression — a DERIVATION over each cell's own `(N_val, V)`, **no
  per-formula table** · **C″** = a **geometric H–H coordination** (shell-volume × ρ_H × an
  H:former TOPOLOGY gate). Both cheap (ms) closed forms over all 42; **not** a converged
  plane-wave SCF (d11: a genuine `qforge_dos_nef` over 42 cells incl. molecular insulators is the
  CaH6-anchor-grade multi-week path — reserved as the per-DFPT-target step, not the full-set screen).
  **MEASURED full-set `effective_dim` (PCA = the truth-teller):**
  - **`2.04 → 2.50/4`** when B″/C″ are the *pure* table-free producers — and the decisive witness:
    **B↔C full-set corr `0.80 → −0.19`**. The 0.80 was **~entirely a proxy-table artifact** (the two
    hand-tables co-varied); computed from independent raw channels, free-electron N(E_F) and geometric
    coordination are **uncorrelated**. So **part (a) of the ceiling was artifact — removed**.
  - **but the irreducible low-dimensionality is REAL and lives in a DIFFERENT pair**: in *every*
    variant (table or table-free) **B↔D = 0.79** — N(E_F) and the feature-basis Tc both read the
    **valence-electron-count / band-filling channel**. This is genuine physics (DOS and Tc-propensity
    co-track band fill) and caps the table-free full set at ~2.5/4 even with B,C decoupled — **part (b),
    irreducible**.
  - **the molecular-tail co-vanishing is real but NOT primarily a B–C effect**: a *pure* number-density
    coordination MIS-ranks dense molecular hydrides (B₂H₆, SiH₄) as **high**-coordination (small est.
    cell → high ρ_H) — *inverting* the truth. Correcting it needs an **H:former topology gate**, which
    **re-couples B↔C to 0.66** and pulls the full set to **1.95/4**. So *correct molecular ranking* and
    *maximal B–C independence* **TRADE OFF** — the candidate space genuinely is low-dimensional in a
    former-chemistry axis B,C share.
  - **regime sign-flip (honest)**: the literature N(E_F) **table** is MORE independent *within the
    superhydride family* (it encodes real 4f-suppression a free-electron DOS can't see → family
    `effective_dim 3.08`), while **table-free** B″ is more independent *on the full set* (no table
    co-variation with C). Neither wins everywhere: **the table is better for family DFPT-target
    discrimination; the table-free is better for the artifact-free full-set measurement.**
  - **FINDING (d6 / d_paper_negative_ok)**: the full-set `effective_dim` does **not** cleanly exceed
    ~2.5/4 even after the table is removed — and *that is the result*. The 2.04 ceiling was **part
    table-artifact** (the specific 0.80 B–C, gone table-free → 2.50) and **part genuine physics** (the
    band-filling co-track B↔D 0.79 + the former-chemistry axis the molecular tail forces). The honest
    full-set number is **2.0–2.5/4 depending on the molecular-ranking constraint** — the intrinsic
    dimensionality of the cheap candidate-screen, not a number forced to 3+. Ranking + anchor-top-10
    integrity preserved. g5: **`triangulate_selftest PASS`, 77/77** (`triangulate_test.hexa` gate-(7)).
    Code: `triangulate_otf.hexa` + `triangulate_otf_run.hexa` (CONFIG (1) table vs (2) table-free,
    three regimes each).
- **Discovery log**: [`.discoveries/rtsc-triangulate.tape`](../.discoveries/rtsc-triangulate.tape)

> **QFORGE migration-gate — screened el-ph vertex fix-recipe (lit-ground, lane 6, 2026-06-08)**:
> the 24× CaH6 λ under-coupling (QFORGE 0.18 vs QE 4.376) is most likely an *under-converged /
> over-damped `∂V_scf` self-consistency loop* (#1) compounded by the *npw_cap=16 basis*
> under-resolving the H-1s induced charge `Δn` (#2) — NOT the f_xc kernel (already wired, ~10–30%
> effect, not 24×) and NOT BZ-sampling/Wannier-|g| (EPW interpolates the *already-screened*
> `prefix.dvscf`, so it inherits — not fixes — vertex magnitude). Cheap decisive diagnostic for
> lanes 1-3: print **λ vs ∂V_scf-loop iteration** (still rising ⇒ loop fix; flat at 0.18 ⇒
> basis/kernel). Prioritized fix-recipe + target λ/Tc table + 11 citations:
> [`RTSC/research/qforge_screened_vertex_litground.md`](RTSC/research/qforge_screened_vertex_litground.md).
