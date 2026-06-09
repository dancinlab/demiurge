<!-- HANDOFF: parent appends this block to the shared domains/rtsc.log.md (rad-domains-radguard
     working tree) — this isolated agent is off a different branch and must not touch the shared
     uncommitted rtsc.md/rtsc.log (d9 index isolation). Also flip the relevant rtsc.md line. -->

## 2026-06-10 · TRUE 3-D real-space SCF ρ(r) — pow2-FFT wall BROKEN, screening root RE-DIAGNOSED (0-pod, d6/@L5)

- **마지막 명명 구조 레버 = 진짜 3-D 실공간 SCF ρ(r)**: A1 PBE-SCF verdict 가 명명한 두 root((a) pow2-FFT 벽이 n=645서 spectral GGA 차단 · (b) (1,1,n) 1-D G-인덱스 밀도서 GGA ∇ρ 비물리적)의 정면 재구축. (1,1,n) 1-D G-라인 밀도 → **pow2-PADDED 3-D 실공간 ρ(r) 격자**(Nx×Ny×Nz, 각 축 2의 거듭제곱)로 교체. hexa-lang PR#3003.
- **구현**: `stdlib/qforge/scf_pw_realspace.hexa`(신설) — Miller(h,k,l)→pow2 32³ 큐브 매핑(n=645≠pow2도 항상 유효 FFT 격자) · ρ(r)=Σocc|ψ(r)|²(ψ(G) scatter→ifft3) · 축별 분광 ∇ρ(iG_x·iG_y·iG_z) · 분광 PBE V_xc[ρ,∇ρ]+F_x(s)+3-D Hartree · 재사용 버퍼(jetsam 가드). `scf_pw.hexa` rs3d SCF 라우트(opt-in, LDA 무회귀) + `pw_frontend.hexa` qpw_set_rs3d 토글. **g5 게이트 10/10 PASS**(해석적 평면파/cos 표적: cos(G·x)⇒peak|∇ρ|=A·|G| 정확 — 진짜 3-D 그래디언트, (1,1,n)은 불가). scf_pw_selftest 회귀 20/20 PASS.
- **헤드라인 (HONEST, 4.376 강제 안 함)**: **PBE V_xc[ρ,∇ρ] 가 물리적 n=645 basis서 ENGAGE + SCF 수렴(처음, 3 iters, e_band=−61.79, cube=32³)** — A1 이 "n=645≠pow2 → core_fft [] → LDA fallback, PBE 아예 안 돔"이라 명명한 **pow2-FFT 벽 제거 확정. Root (a) RESOLVED.**
- **VERBATIM λ (d6)**: LDA(1,1,n) cap16 = 0.609302(A1 baseline 일치) → **LDA-3D cap16 = 1.15e-57 ≈ 0 · PBE-3D cap16 = 7.16e-242 ≈ 0 · PBE-3D n=645 = 1.43e-88 ≈ 0**(ω_log=1224.7K, Tc=0). 
- **ROOT RE-DIAGNOSED (가장 깊은 진단)**: 벽은 밀도-표현이 아니라 **diagonal-only assembler**. assembler.hexa 는 vscr_diag[a]를 **대각 H[a][a]에만** 더함(off-diagonal V(G_a−G_b) 폐기). 국소 전위 V(r)의 정확한 대각원소 = ⟨G_a|V|G_a⟩=(1/Ω)∫V dr = V(G=0)=V̄(모든 a 동일). ⇒ 진짜 3-D V_scr(r)은 **공간평균 V̄만** 대각에 기여 = 균일 상수 시프트 = el-ph 비변조 → **λ→0**. n=645서 폐기되는 구조(offdiag RMS/|V̄|): V_H=4.8e15(거의 100%)· V_xc=0.69 · V_scr=5.56. **(1,1,n) λ=0.609는 ARTIFACT** — 비물리적 per-G 대각(V_xc(rho[a]), rho[a]=G-공간 점유)이 만든 가짜 구조. 즉 "3-D가 닫는다" 가설은 **예측 반대방향으로 FALSIFIED**: 물리 올바르게 하면 대각 assembler는 4.376 아닌 ~0.
- **OUTCOME (2)+(3)**: 3-D 재구축이 pow2-FFT 벽을 **실제로 돌파**(전진)하면서, 진짜 남은 root 를 **diagonal-only assembler**로 정밀 지목. **게이트 = NOT MET(λ≈0, ≤1% 아님, 4.376 강제 안 함)** · 하이브리드(1.65e-7) production 유지 · dispatch=qe · absorbed HELD.
- **정직 잔여(d2 다음 레버, 본 작업 밖)**: 차폐를 **off-diagonal** V_scr(G_a−G_b) dense 행렬로 assembler 에 투입(대각전용 vscr_diag → 밀집 ⟨G_a|V_scr|G_b⟩=V_scr(G_a−G_b), n² 스케일링). 본 작업이 만든 3-D 실공간 ρ(r)이 바로 그 off-diagonal 조립의 입력. = assembler 재작성(별도 대형). cost=$0(local). verdict: `.verdicts/qforge-3d-realspace-scf/` · impl: hexa-lang PR#3003.

<!-- rtsc.md line flip suggestion: under the QFORGE migration-gate milestone, append after the A1
     PBE-SCF entry: "🟢→🔴 3-D real-space SCF ρ(r) REBUILD (2026-06-10, hexa-lang PR#3003): pow2-padded
     3-D 큐브 + 분광 GGA ∇ρ (g5 10/10) — PBE V_xc 가 n=645서 처음 ENGAGE+수렴(pow2-FFT 벽 돌파, e_band=−61.79).
     BUT λ→0 (PBE-3D n=645 λ=1.43e-88): root 가 diagonal-only assembler(국소 V(r)→대각은 V̄만, offdiag
     RMS/|V̄|=5.56 폐기)로 RE-DIAGNOSED. (1,1,n) λ=0.609 는 비물리적 per-G 대각 artifact. 게이트 NOT MET·
     하이브리드 production·absorbed HELD. 다음=off-diagonal V_scr(G,G') assembly. `.verdicts/qforge-3d-realspace-scf/`" -->
