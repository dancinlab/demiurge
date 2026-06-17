<!-- HANDOFF: parent appends this block to the shared domains/rtsc.log.md (rad-domains-radguard
     working tree) — this isolated agent is off a different branch and must not touch the shared
     uncommitted rtsc.md/rtsc.log (d9 index isolation). Also flip the relevant rtsc.md line. -->

## 2026-06-09 · A1 PBE-XC from-scratch SCF — 🔴 CLOSED-NEGATIVE (차폐벽 PBE-functional 레벨서도 확정, 0-pod)
- **마지막 명명 구조 레버 = PBE-XC from-scratch SCF**: 차폐정점 4-레버(RPA→full ε→Sternheimer-χ⁰→f_xc-in-χ) terminal 진단("잔차 = LDA-vs-PBE functional + from-scratch LDA PW SCF")의 정면돌파. 모든 이전 SCF는 LDA-XC(Slater-x + PW92-c) 자기일관 — A1 = SCF 자체를 **PBE(GGA) V_xc[ρ,∇ρ]** 로 재구축(d4 xc_mode=3 토글, hexa-lang `qforge-pbe-scf-cah6`).
- **구현 (∇ρ 분광)**: `correlation.hexa` PBE-x F_x(s) + GGA 에너지밀도 e_xc(ρ,|∇ρ|) + 편미분 ∂e/∂ρ·∂e/∂g · `screening.hexa` 분광 V_xc^PBE = ∂e/∂ρ − ∇·(∂e/∂g·∇ρ/g), ∇ρ+divergence = core_fft · `scf_pw.hexa` xc_mode=3 SCF 배선. **단위게이트 14/14 PASS**(∇ρ GGA항 실live, 비균질 ρ서 max|Δ|=1.87e-4 vs LDA; 균질 ρ서 정확히 LDA 환원).
- **VERBATIM 결과 (d6, 4.376 강제 안 함 · bare vertex, 함수만 교체 = apples-to-apples)**: pow2 basis마다 PBE-SCF 가 λ를 **악화**(QE서 더 멀어짐): n=16 LDA λ=0.6093→PBE λ=0.0813 · n=64 LDA λ=0.00833→PBE λ=0.00335. **물리적 λ=4.137 basis(n=645 full ecut shell)는 645≠pow2 → core_fft가 [] 반환 → 분광 V_xc^PBE 미가동 → LDA-x+c fallback**(결정론적 확인: `qforge_vxc_pbe_grid` n=645→len=0 vs n=512→len=512). 즉 **수렴 basis서 PBE 는 아예 안 돈다**. n=128/256/512 DFPT(n²-FC Sternheimer)는 로컬 10분창 초과 intractable(d11).
- **OUTCOME (3) 최강 음성 = 벽 PBE-functional 레벨 확정**: (a) PBE 가 가동되는 pow2 basis마다 λ **하락**(f_xc-in-χ ALDA 과잉차폐와 동일 부호) · (b) 수렴 n=645 basis서는 pow2-FFT 벽이 GGA 자체를 차단 · (c) 더 깊은 한계 = from-scratch SCF 의 (1,1,n) 1-D G-인덱스 밀도표현(진짜 3-D ρ(r) 아님)서 GGA gradient 가 비물리적. **게이트 flip 금지(NOT MET)** · 하이브리드(1.65e-7)=production · dispatch=qe · absorbed HELD.
- **정직 잔여(d2, 본 작업 밖)**: 진짜 3-D 실공간 SCF ρ(r) 그리드(현 (1,1,n) G-라인 교체) + n=645 pow2-padding FFT → 그때 수렴 basis서 물리적 PBE V_xc 측정 가능. = SCF-표현 대형 재구축이지 XC-함수 교체 아님. cost=$0(local). verdict: `.verdicts/qforge-pbe-scf-cah6/`.

<!-- rtsc.md line flip suggestion: under the QFORGE migration-gate milestone, append after the
     f_xc-in-χ entry: "🔴 A1 PBE-XC from-scratch SCF CLOSED-NEGATIVE (2026-06-09): 분광 V_xc^PBE[ρ,∇ρ]
     (xc_mode=3, 14/14 unit PASS) — pow2 basis서 λ 악화(n16 0.61→0.08·n64 0.0083→0.0034), 수렴 n=645
     basis는 pow2-FFT 벽이 GGA 차단(645→len0). 벽 = PBE-functional 레벨 + (1,1,n) 1-D 밀도표현 확정,
     XC-함수 아님. flip 금지·하이브리드 production. `.verdicts/qforge-pbe-scf-cah6/`" -->
