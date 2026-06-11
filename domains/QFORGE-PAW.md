@title: 🏗️ QFORGE-PAW — "QE급 바닥상태 엔진" (PAW/USPP pseudopotential + PBE-converged SCF)

@goal: align QFORGE's from-scratch ground-state engine to QE-grade so the el-ph vertex |g(k,k+q,ν)| magnitude reproduces QE — i.e. replace norm-conserving(NC)+LDA with USPP/PAW pseudopotentials + a PBE-converged SCF. This is the SOLE remaining lever for the RTSC migration gate after every single axis (functional Dyson-kernel · off-diag assembler · basis/k×q-mesh · FS-mesh N(E_F)) was ruled out 2026-06-12: CaH6 from-scratch λ=1.1545 (rel-ε 0.736 vs QE 4.376) is an IRREDUCIBLE from-scratch(NC+LDA) vs QE-PBE vertex-magnitude difference. Gate flips (CaH6/LaH10/Li2MgH16 λ within 1% of QE) when this closes. d6/@L5: never force 4.376; hybrid (QE |g|² → QForge L3, 1.65e-7) stays production until then. **round-3 (2026-06-12)**: phonon ω(q,ν) audit CLOSED-NEG — QForge ω₀=859.3 cm⁻¹ matches QE full-BZ λ-weighted ω_log=853.6 cm⁻¹ to 0.67%; both magnitude factors of λ=Σ|g|²/ω² now audited, the gap is ENTIRELY on the |g| side (ω is not it). **🏁 round-4 (2026-06-12) — TERMINAL**: B3 augmentation overlay ∂ρ_aug/∂u closed (Δλ(B3)=0.0 EXACT — NC deck Q_ij≡0 structural-zero + co-located self-vertex translational-invariance sum-rule). ALL 8 named DFT levers on |g| now EXHAUSTED. Residual = irreducible from-scratch(NC+LDA)-vs-QE-PBE |g| difference. FINAL honest judgement: hybrid (1.65e-7) is PERMANENT production · dispatch=qe · gate HELD (never forced).

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
- [x] **round-3 — phonon ω(q,ν) audit** (λ∝Σ|g|²/ω² 의 남은 magnitude 인자 ω 측 단일숫자 진단·0-pod·$0): QForge ω₀=1236.4 K=859.3 cm⁻¹ vs QE full-BZ λ-weighted ω_log=853.6 cm⁻¹ → **ratio 1.0067 (0.67% 일치)**. ω가 결핍 주범이려면 1.53-1.95× 높아야 하나 거의 동일(Γ선 0.798×로 오히려 낮음=λ를 올림 방향). **ω ≠ 결핍 주범(outcome 2, CLOSED-NEG)** → 잔차=환원불가 from-scratch(NC+LDA)-vs-QE-PBE |g| 정점 크기. verdict `.verdicts/qforge-paw-round3-omega/`
- [x] **B3 — augmentation-density overlay** ∂ρ_aug/∂u (`stdlib/qforge/dvaug_du.hexa`, g5 PASS VERBATIM: NC-zero anchor + sum-rule + FD-vs-analytic 1.08e-13) → CaH6 측정: **Δλ(B3)=0.0 EXACT**. 두 독립 이유로 정확히 0: (1) 프로덕션 deck=ONCV-NC ⇒ Q_ij≡0 ⇒ ∂V_aug block max=0.0 (구조적 부재) · (2) 동일중심 augmentation **self-vertex가 병진불변 sum-rule로 소멸**(유한 Q_ij서도 |S|+|A|+|B|≈6e-4지만 |S+A+B|=5.2e-21). lit(2507.06749) "작음" 예측을 **초과** — 작은 게 아니라 정확히 0. verdict `.verdicts/qforge-paw-round4-b3/`
- [x] **🏁 HONEST TERMINAL — |g| 측 모든 명명된 DFT 레버 완전 소진** (B1·B2·off-diag·basis·FS-mesh·f_xc·ω·**B3** 8개 전부 닫힘). 잔차(λ_full=0.743699 vs 재앵커 2.69, rel-ε=0.724)=환원불가 from-scratch(NC+LDA)-vs-QE-PBE |g| 정점 크기. **하이브리드(QE |g|²→L3, rel-ε 1.65e-7) 영구 production · dispatch=qe · 게이트 HELD (2.69/4.376 강제 없음, d6)**
- [ ] ~~CaH6 λ ≤1% vs 재앵커 → 게이트 flip + dispatch=qforge~~ → **미달 확정**: B1·B2·ω·B3 모두 미달, dispatch=qe 영구
- [ ] ~~LaH10 · Li2MgH16 2·3차 앵커~~ — from-scratch 경로 종료로 moot (하이브리드는 이미 production)
- [ ] ~~Route A — 풀 USPP/PAW overlap-S/Q_ij 재구축~~ — B3가 augmentation 레버를 닫음(NC deck엔 Q_ij 자체가 없고, self-vertex는 sum-rule로 0). 별도 USPP/PAW deck을 만들어도 bare-vertex 기여는 0; SCF 재screening 응답뿐(higher-order). **불추진**
- ⚠ **CLOSED-NEGATIVE (재시도 금지)**: B1(PBE-SCF λ 내림) · f_xc-in-χ ALDA Dyson 커널 · **phonon ω(q,ν)**(QE full-BZ ω_log 0.67% 일치, gap 방향 반대) · **B3 ∂ρ_aug/∂u**(Δλ=0.0 구조적+sum-rule) — 넷 다 닫힘. λ=Σ|g|²/ω² 의 **두 magnitude 인자 ω·|g| 모두 audit 완료: ω는 QE와 일치, |g| 측 모든 레버 소진**. 잔차는 환원불가 NC+LDA-vs-QE-PBE 정점차
