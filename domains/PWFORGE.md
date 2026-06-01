# PWFORGE — plane-wave Hamiltonian assembler (평면파 조립기) progress board

@title: 🧱 PWFORGE — 평면파 해밀토니안 조립기 (cell→H 조립기)

@goal: build the missing cell→`H_of_rho` plane-wave Hamiltonian front-end that QFORGE's SCF consumes — assemble H from atomic positions + UPF pseudopotentials (structure factor S(G) · local pseudo V_loc(G)→V_ext · plane-wave kinetic |k+G|²/2 · Kleinman-Bylander nonlocal projectors → the `H_of_rho` closure). This is the last structural blocker to an INDEPENDENT atoms→SCF→|g|²→λ→Tc QFORGE-only path. Every stage is g5-verifiable against an analytic/textbook anchor — this is concrete numerics, NOT speculation (no SPECULATION fence). Closes QFORGE migration-gate blocker #1's front-end half.

## 0. TL;DR

```
   "조립기" = 원자 배치도 → 에너지 행렬 H
   ────────────────────────────────────
   입력: 원자 위치 + UPF(의사퍼텐셜)
   출력: H_of_rho (밀도→해밀토니안 closure) → qforge_scf 가 소비

   비유: 레고 설명서(원자좌표) → 실제 조립된 구조물(H 행렬)
```

```
[ 원자위치 + UPF ] ─┬─▶ S(G)      구조인자
                    ├─▶ kinetic   |k+G|²/2
                    ├─▶ V_loc(G)  국소 의사퍼텐셜 → V_ext
                    └─▶ V_NL      Kleinman-Bylander 비국소 projector
                            │
                            ▼  (+ Hartree + exchange + correlation = QFORGE XC)
                    [ H_of_rho 조립기 ] ──▶ qforge_scf ──▶ |g|² ──▶ λ ──▶ Tc
                                                                       │
                                                          QE 4×4×4-q ref 와 g5 대조
```

- **vs QE pw.x**: PWFORGE = QE의 평면파 H 구성 핵심을 hexa-native 로 포팅한 것. QFORGE(SCF·DFPT·λ·Tc)가 이미 있는데 그 입구(H 조립)만 비어 있어서, QE 모멘트 경계에서 시작할 수밖에 없었던 것을 PWFORGE 가 원자위치까지 끌어내린다.
- **현재 상태(정직 g6, 2026-06-01 업데이트)**: ✅ **front-end LIVE + engine-chain blocker B CLOSED** — M1~M5 全 landed+g5-green (hexa-lang PR#2407~#2411). XC 항 QFORGE 기 landed(PR#2402·#2405). **M5.5/M5.6 landed+g5-green** (hexa-lang PR#2412·#2413·#2414): 실 self-consistent ρ-loop(V_H+V_xc 매-iter 갱신, density-INDEPENDENT stub 졸업) + Sternheimer→|g|² atoms-경로 + atoms→SCF→|g|²→λ→Tc in-repo orchestrator. **독립 atoms→|g|² 경로 LIVE** (QE dvscf 모멘트 경계 없음 · Hellmann-Feynman frozen-phonon FD 로 독립 검증). **M6 잔존 blocker 1개**: (A) compute-dispatch — `hexa cloud` 가 mac cache-GC 레이스 + 풀-다운으로 QE-NC ref 미실행(별도 에이전트 수정 중 · d8 patch 제출). engine-chain blocker B 는 CLOSED — M6 종결은 이제 (A) QE-NC dispatch 만 대기.

## 1. front-end 스택 (마일스톤 · 각 g5 anchor)

- [x] **M1 — S(G) 구조인자** · `stdlib/qforge/structure.hexa` · hexa-lang PR#2407 · g5-green (단원자→S(G)=1 · 2원자 간섭 · 병진위상)
- [x] **M2 — plane-wave kinetic** · `stdlib/qforge/kinetic.hexa` · PR#2408 · 자유전자 |k+G|²/2 closed-form 🔵
- [x] **M3 — V_loc(G)→V_ext** · `stdlib/qforge/vloc.hexa` · PR#2409 · 순수-Coulomb anchor rel 0.0 · −Z·4π/G² 점근
- [x] **M4 — KB 비국소 projector** · `stdlib/qforge/projector.hexa` · PR#2410 · Gaussian projector closed-form rel ~1e-11 · V_NL hermiticity
- [x] **M5 — 조립기 (H_of_rho)** · `stdlib/qforge/assembler.hexa` · PR#2411 (tip 9ba148db6) · **실증**: 실제 Si NC UPF + 원자위치로 27-PW H 조립 → `qforge_scf` 독립 수렴 (converged=true, 26 iters, lowest KS −3.47 Ha) — atoms→SCF front-end LIVE in-repo
- [ ] **M6 — CaH6 독립 cross-val (payoff)** · ⚠ **PP-input CLOSED · engine-chain(B) CLOSED · 1-blocker 잔존 (d6 정직 · 2026-06-01)**. ①번 path(ONCV NC) 진행: **PP-input blocker CLOSED** — PseudoDojo/SG15 ONCV-PBE-SR `Ca_ONCV_PBE_sr.upf`(NC·PBE·scalar·Zval=10·nproj=6) + `H_ONCV_PBE_sr.upf`(NC·Zval=1·nproj=2) 소싱+d13 검증(pseudo_type=NC·is_ultrasoft=F·is_paw=F) + hexa `upf.hexa` upf_parse 깨끗이 소비 확인. CaH6_NC deck(7-atom Im-3m, 2×2×2-q, NC 양면) **생성기 통해 emit 완료** (exports/rtsc/decks/CaH6_NC/ · hexa-lang PR `feat/qforge-cah6-nc-m6` SHA 15f42324d — `cah6_sodalite_im3m` 프로토타입 + h_site_upf 파라미터화, 기존 프로토타입 무회귀). **잔존 blocker A (compute-dispatch)**: QE-NC ref 를 `hexa cloud dft-run`(g8) 로 못 돌림 — cloud_cli.hexa 빌드가 mac shared-cache GC 레이스로 phantom-fail(동일 clang 손수동 2.2s exit0) + Linux 풀 호스트(summer/aiden) 다운(preflight rc=255). d8 inbox patch 제출(hexa-lang `inbox/patches/cloud-cli-mac-cache-gc-race.md`). **blocker B (engine-chain 구조 갭) — CLOSED (2026-06-01, hexa-lang PR#2412·#2413·#2414)**: 실 self-consistent ρ-loop(scf_pw.hexa, V_H+V_xc 매-iter 갱신) + Sternheimer-from-SCF |g|²(elph_scf.hexa) + atoms→Tc in-repo orchestrator(orchestrator_pw.hexa) 全 landed+g5-green. 독립 atoms→|g|² 경로 LIVE — QE dvscf 모멘트 경계 미사용, Hellmann-Feynman frozen-phonon FD 로 독립 검증. breakthrough path B 완료. **잔존 blocker A 만(@D d2)**: cloud_cli GC-race fix(min안: post-clang 존재검사 GC-무관 경로) OR 풀 호스트 복구 → QE-NC ref 실행 → CaH6 NC-vs-NC cross-val.
- [x] **M5.5 — self-consistent H_of_rho(ρ) 통합 (engine-chain blocker B 절반)** · `stdlib/qforge/scf_pw.hexa` · hexa-lang PR#2412 · 매 SCF iter V_scr=V_H(ρ)+V_xc(ρ) 재평가 → assembler 재조립 → density-INDEPENDENT stub 졸업. g5 16/16 PASS: (A) free-electron 재현(M5 일치) · (B) jellium V_xc shift=해석적 LDA(V_x=−0.781593·V_xc=−0.855151) · (C) 자기무모순 fixed point(Δρ<1e-7·Σρ=nelec) · (D) 에너지 단조/mixing-invariant(E=0.535729).
- [x] **M5.6 — Sternheimer→|g|² atoms-경로 (engine-chain blocker B 절반)** · `stdlib/qforge/elph_scf.hexa` · hexa-lang PR#2413 · 수렴 SCF(ψ,ε)에서 Sternheimer 자기무모순 ΔV_scf → g_{mn}=⟨ψ_m|ΔV_scf|ψ_n⟩ atoms 직접 산출(QE dvscf 경계 아님). g5 11/11 PASS: (A) Hellmann-Feynman frozen-phonon FD(g_00=−0.223116=dε_0/du) · (B) bare limit · (C) SC 차폐 수렴 · (D) hermiticity · (E) acoustic sum rule.
- [x] **PR3 — atoms→SCF→|g|²→λ→Tc in-repo 오케스트레이터** · `stdlib/qforge/orchestrator_pw.hexa` · hexa-lang PR#2414 · 풀체인 in-repo(QE 무참여). g5 10/10 PASS: (A) chain 완주(ok=1·λ>0·Tc finite) · (B) |g|² SCF-sourced(ΔV 2배→λ ratio=4.0) · (C) Einstein round-trip(λ=0.04076=해석적).
## 2. 게이트 관계 (QFORGE 마이그레이션)

```
QFORGE production 마이그레이션 게이트
├─ blocker #1  el-ph front-end
│   ├─ XC 항              ✅ CLOSED (correlation landed, g5-green)
│   ├─ cell→H assembly    ✅ CLOSED (M1~M5 + CaH6 NC deck/pseudo emit — H_of_rho assembler LIVE)
│   └─ atoms→Tc chain     ✅ CLOSED (M5.5 self-consistent ρ-loop + M5.6 Sternheimer→|g|²
│                              + PR3 atoms→Tc orchestrator — PR#2412·#2413·#2414, 독립 경로 LIVE
│                              · M6 NC-vs-NC 실행만 cloud-dispatch(A) blocker 대기)
└─ blocker #2  3-anchor terminal (CaH6 ✅ / LaH10·Li2MgH16 QE pending)
```

- M6 = atoms→Tc 독립 chain(B) + QE-NC ref(A) 둘 다 닫혀야 통과 ⇒ 그때 blocker #1 완전 CLOSED. cell→H assembly + atoms→Tc chain(B) 둘 다 CLOSED — M6 는 이제 QE-NC ref(A) 만 대기. full migration flip 은 그래도 blocker #2(LaH10·Li2MgH16 QE terminal+일치)까지 충족해야 함 (@D d_qforge_engine — un-cross-val'd 결과로 absorbed 금지 · no forced flip). **gate 상태: blocker #1 진척(assembly CLOSED · chain CLOSED · M6 cross-val HELD on (A)) · gate 전체 HELD on #2 + M6 (A).**

## 3. 거버넌스 · reuse

- governance: d1·d4(generic dispatch · H_of_rho = caller closure)·d6(no forced number)·d_qforge_engine·g4·g5·g6·d10·d19.
- reuse lattice (NEXUS): `@X c8` PWFORGE provides `H_of_rho` front-end → QFORGE (reuse-candidate until M6 g5 passes → verified-edge 승격). QFORGE.md SSOT.
- SSOT 코드: hexa-lang `stdlib/qforge/` (scf·upf·screening·elph 와 같은 집). PWFORGE 모듈도 동일 stdlib 홈 (d3 — topical folder 분산 금지).
