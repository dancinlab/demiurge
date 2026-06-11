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
