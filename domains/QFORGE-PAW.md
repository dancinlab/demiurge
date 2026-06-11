@title: 🏗️ QFORGE-PAW — "QE급 바닥상태 엔진" (PAW/USPP pseudopotential + PBE-converged SCF)

@goal: align QFORGE's from-scratch ground-state engine to QE-grade so the el-ph vertex |g(k,k+q,ν)| magnitude reproduces QE — i.e. replace norm-conserving(NC)+LDA with USPP/PAW pseudopotentials + a PBE-converged SCF. This is the SOLE remaining lever for the RTSC migration gate after every single axis (functional Dyson-kernel · off-diag assembler · basis/k×q-mesh · FS-mesh N(E_F)) was ruled out 2026-06-12: CaH6 from-scratch λ=1.1545 (rel-ε 0.736 vs QE 4.376) is an IRREDUCIBLE from-scratch(NC+LDA) vs QE-PBE vertex-magnitude difference. Gate flips (CaH6/LaH10/Li2MgH16 λ within 1% of QE) when this closes. d6/@L5: never force 4.376; hybrid (QE |g|² → QForge L3, 1.65e-7) stays production until then.

icon 🏗️ · name QFORGE-PAW · alias "QE급 바닥상태 엔진" (ground-state engine)
**부모(parent)**: 🔨 QFORGE (engine · `QFORGE/QFORGE.md`) · siblings: 🧰 QFORGE-FEATURE · ⚙️ QFORGE-PROCESS · 🚀 QFORGE-PERF

- 하는 일: from-scratch |g| 크기가 QE와 맞도록 바닥상태(의사퍼텐셜+XC함수자)를 QE급으로 재구축
- 비유: 엔진의 "연료+점화플러그" 자체를 정품으로 교체 (지금은 호환부품 NC+LDA라 출력이 다름)
- 비교: off-diag assembler = 조립법(닫힘·×1.06) · QFORGE-PAW = 부품 자체(QE-grade PBE+PAW augmentation)

- [ ] round-1 — NOVEL probe + arxiv/web deep-research lit-grounding: PAW/USPP el-ph deformation-potential ∂V/∂u 이론 + QForge 통합 설계 (d18)
- [ ] PAW/USPP 의사퍼텐셜 augmentation charge 지원 (NC 너머 — Q_ij(r) 보강전하 · D_ij 비국소항)
- [ ] PBE-converged ground-state SCF (QE의 GGA 함수자에 정렬 — band/DOS/ρ 출발점 일치)
- [ ] PAW-augmented deformation potential ∂V_scf/∂u (보강전하 포함 el-ph vertex)
- [ ] CaH6 |g(Γ,ν)| vs QE 단일숫자 재현 — g2-audit의 ~3.3e4×(이전 NC) 결핍이 PAW로 닫히나
- [ ] CaH6 λ ≤1% vs QE 4.376 → 마이그레이션 게이트 flip + dispatch=qforge
- [ ] LaH10 · Li2MgH16 2·3차 앵커 λ ≤1% (3-물질 삼각측량 완결)
