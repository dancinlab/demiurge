@title: 🏗️ QFORGE-PAW — "QE급 바닥상태 엔진" (PAW/USPP pseudopotential + PBE-converged SCF)

@goal: align QFORGE's from-scratch ground-state engine to QE-grade so the el-ph vertex |g(k,k+q,ν)| magnitude reproduces QE — i.e. replace norm-conserving(NC)+LDA with USPP/PAW pseudopotentials + a PBE-converged SCF. This is the SOLE remaining lever for the RTSC migration gate after every single axis (functional Dyson-kernel · off-diag assembler · basis/k×q-mesh · FS-mesh N(E_F)) was ruled out 2026-06-12: CaH6 from-scratch λ=1.1545 (rel-ε 0.736 vs QE 4.376) is an IRREDUCIBLE from-scratch(NC+LDA) vs QE-PBE vertex-magnitude difference. Gate flips (CaH6/LaH10/Li2MgH16 λ within 1% of QE) when this closes. d6/@L5: never force 4.376; hybrid (QE |g|² → QForge L3, 1.65e-7) stays production until then.

icon 🏗️ · name QFORGE-PAW · alias "QE급 바닥상태 엔진" (ground-state engine)
**부모(parent)**: 🔨 QFORGE (engine · `QFORGE/QFORGE.md`) · siblings: 🧰 QFORGE-FEATURE · ⚙️ QFORGE-PROCESS · 🚀 QFORGE-PERF

- 하는 일: from-scratch |g| 크기가 QE와 맞도록 바닥상태(의사퍼텐셜+XC함수자)를 QE급으로 재구축
- 비유: 엔진의 "연료+점화플러그" 자체를 정품으로 교체 (지금은 호환부품 NC+LDA라 출력이 다름)
- 비교: off-diag assembler = 조립법(닫힘·×1.06) · QFORGE-PAW = 부품 자체(QE-grade PBE+PAW augmentation)

> **round-1 재구성 (2026-06-12)**: ~3.3e4× 결핍은 ARTIFACT(n=51+q=Γ+bare)였고 pseudo-type은 magnitude 레버가 아님(NC=PAW off-core, arXiv:2507.06749). 실 culprit = **LDA→PBE in SCF**(un-tried). 타깃 4.376은 under-converged outlier → **~2.69**(PNAS 2012)로 재앵커. 경로 = Route B(풀 PAW 회피). 풀 USPP/PAW는 B1-B3 미달시 fallback.

- [x] round-1 — lit-grounding DONE (d18): ~3.3e4×=artifact · pseudo는 레버 아님 · culprit=PBE-SCF · 타깃 재앵커 ~2.69 · 경로 Route B. draft `drafts/qforge-paw-round1-design.md`
- [ ] **B1 — LDA→PBE ground-state SCF** (최대 λ-레버·최소변경, manifest `xc="pbe"`, `qforge_h_pbe`/`correlation_pbe.hexa` 존재·SCF서 미실행) → CaH6 λ 재측정
- [ ] **B2 — 빠진 비국소 ∂V_NL/∂u** (`dvnl_du.hexa`: Σ|∂β⟩D⟨β|, NC·무augmentation) — round-2 첫 brick: ∂β_i(q)/∂u_d=−iG_d·β_i(q) + g5(Hermiticity<1e-10·finite-diff<1e-6) on `projector_selftest.hexa` l=0
- [ ] **타깃 재앵커** — CaH6 수렴 λ 기준 4.376→**~2.69**(PNAS 2012 PAW+PBE+QE·수렴 lit 1.6-2.7) 교정 후 게이트 측정
- [ ] **B3 — augmentation-density overlay** ∂ρ_aug/∂u (일반화 고유문제 회피, B1·B2 미달시)
- [ ] CaH6 λ ≤1% vs 재앵커 타깃 → 마이그레이션 게이트 flip + dispatch=qforge
- [ ] LaH10 · Li2MgH16 2·3차 앵커 λ ≤1% (3-물질 삼각측량 완결)
- [ ] Route A — 풀 USPP/PAW overlap-S/Q_ij 재구축 (B1-B3 전부 미달시만)
