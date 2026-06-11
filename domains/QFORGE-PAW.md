@title: 🏗️ QFORGE-PAW — "QE급 바닥상태 엔진" (PAW/USPP pseudopotential + PBE-converged SCF)

@goal: align QFORGE's from-scratch ground-state engine to QE-grade so the el-ph vertex |g(k,k+q,ν)| magnitude reproduces QE — i.e. replace norm-conserving(NC)+LDA with USPP/PAW pseudopotentials + a PBE-converged SCF. This is the SOLE remaining lever for the RTSC migration gate after every single axis (functional Dyson-kernel · off-diag assembler · basis/k×q-mesh · FS-mesh N(E_F)) was ruled out 2026-06-12: CaH6 from-scratch λ=1.1545 (rel-ε 0.736 vs QE 4.376) is an IRREDUCIBLE from-scratch(NC+LDA) vs QE-PBE vertex-magnitude difference. Gate flips (CaH6/LaH10/Li2MgH16 λ within 1% of QE) when this closes. d6/@L5: never force 4.376; hybrid (QE |g|² → QForge L3, 1.65e-7) stays production until then.

icon 🏗️ · name QFORGE-PAW · alias "QE급 바닥상태 엔진" (ground-state engine)
**부모(parent)**: 🔨 QFORGE (engine · `QFORGE/QFORGE.md`) · siblings: 🧰 QFORGE-FEATURE · ⚙️ QFORGE-PROCESS · 🚀 QFORGE-PERF

- 하는 일: from-scratch |g| 크기가 QE와 맞도록 바닥상태(의사퍼텐셜+XC함수자)를 QE급으로 재구축
- 비유: 엔진의 "연료+점화플러그" 자체를 정품으로 교체 (지금은 호환부품 NC+LDA라 출력이 다름)
- 비교: off-diag assembler = 조립법(닫힘·×1.06) · QFORGE-PAW = 부품 자체(QE-grade PBE+PAW augmentation)

> **round-1 재구성 (2026-06-12)**: ~3.3e4× 결핍은 ARTIFACT(n=51+q=Γ+bare)였고 pseudo-type은 magnitude 레버가 아님(NC=PAW off-core, arXiv:2507.06749). 실 culprit = **LDA→PBE in SCF**(un-tried). 타깃 4.376은 under-converged outlier → **~2.69**(PNAS 2012)로 재앵커. 경로 = Route B(풀 PAW 회피). 풀 USPP/PAW는 B1-B3 미달시 fallback.

- [x] round-1 — lit-grounding DONE (d18): ~3.3e4×=artifact · pseudo는 레버 아님 · culprit=PBE-SCF · 타깃 재앵커 ~2.69 · 경로 Route B. draft `drafts/qforge-paw-round1-design.md`
- [x] **B1 — LDA→PBE ground-state SCF** (xc_mode=3 RS3D, `qforge_vxc_pbe_3d` SCF 배선) → CaH6 측정 완료: **λ 1.65742→0.742514, Δλ(B1)=−0.914903** (PBE-SCF가 λ를 *내림* — 가설 반증). verdict `.verdicts/qforge-paw-round2/`
- [x] **B2 — 빠진 비국소 ∂V_NL/∂u** (`dvnl_du.hexa`+`dvnl_du_block.hexa`, NC·무augmentation, g5 PASS VERBATIM: Hermiticity max=0.0 · FD-vs-analytic 1.45e-10) → CaH6 측정: **Δλ(B2)=−0.00309** (무시할 수준·약음). PR hexa-lang `qforge-paw-round2` (3 stacked)
- [x] **타깃 재앵커** — 4.376→~2.69(PNAS 2012) 적용. B1+B2 λ_full=**0.743699** vs 2.69 rel-ε=**0.7235** (vs 4.376: 0.8301). 게이트 HELD (강제 없음)
- [ ] **B3 — augmentation-density overlay** ∂ρ_aug/∂u (round-1이 B1/B2 뒤로 미룬 유일한 PAW 레버·일반화 고유문제 회피) — round-3 후보. ⚠ 2507.06749: 수렴 hydride el-ph는 core 밖에서 pseudo-독립 → B3도 작을 것으로 예상
- [ ] CaH6 λ ≤1% vs 재앵커 타깃 → 마이그레이션 게이트 flip + dispatch=qforge (B1·B2로는 미달, HELD)
- [ ] LaH10 · Li2MgH16 2·3차 앵커 λ ≤1% (3-물질 삼각측량 완결)
- [ ] Route A — 풀 USPP/PAW overlap-S/Q_ij 재구축 (B3까지 미달시만)
- ⚠ **CLOSED-NEGATIVE (재시도 금지)**: B1(PBE-SCF λ 내림) · f_xc-in-χ ALDA Dyson 커널 — 둘 다 닫힘. 잔차는 SCF XC함수자도 KB 비국소 정점도 아님 → 더 깊은 NC-vs-PAW core/augmentation 또는 phonon-side magnitude
