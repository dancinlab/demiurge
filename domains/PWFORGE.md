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
- [ ] **M6 — CaH6 독립 cross-val (payoff)** · ⚠ **blocker A RESOLVED(QE-NC 가동중) · NEW d6 residual 표면화: aperiodic ground-state Hartree (M5.7) · 2026-06-01**. ①번 path(ONCV NC): **PP-input CLOSED** — `Ca_ONCV_PBE_sr.upf`(NC·PBE·scalar·Zval=10·nproj=6·mesh=1766) + `H_ONCV_PBE_sr.upf`(NC·Zval=1·nproj=2·mesh=1166) 소싱+d13 검증 + hexa `upf.hexa` upf_parse 깨끗이 소비(probe verbatim: ok=true 양쪽 · CaH6 cell valence e⁻=16.0). CaH6_NC deck(7-atom Im-3m, 2×2×2-q, NC 양면) emit 완료(exports/rtsc/decks/CaH6_NC/). **blocker A (compute-dispatch) — RESOLVED**: cloud_cli GC-race fix(hexa-lang #2415) 후 QE-NC ref 가동중 — vast pod `38891053@158.181.52.19:42271`, vc-relax phase(3 BFGS step·enthalpy −77.87→−78.34 Ry·SCF acc 2.3E-10 Ry·7×pw.x 99.9% CPU), `/root/deck`. DFPT(2×2×2-q)는 시간 소요·pod-side self-resume(recover=.true.). harvest: `hexa cloud copy-from 158.181.52.19 /root/deck/ph.out exports/rtsc/decks/CaH6_NC/ --port 42271`. **NEW residual (d6 정직 · QFORGE-NC 독립 run)**: orchestrator_pw 체인은 free-electron/Einstein 앵커에서 g5-green(pw selftest 10/10 PASS)이고 실 ONCV NC UPF 도 ingest 되지만, **실 CaH6 SCF 자기무모순 ρ 는 미수렴** — CaH6 의 비균질 ρ 는 V_H[ρ]≠0 인데 `qforge_scf_pw` 의 ground-state Hartree `vh_diag` 를 in-loop 으로 만드는 in-repo 경로가 NONE(scf_pw.hexa L38-40 자인). 유일한 G-공간 Hartree(`qforge_vhartree_from_drho`)는 DFPT **response Δρ** 차폐 커널(dense FFT)이지 ground-state V_H[ρ] 가 아님. M5.5 가 닫은 건 V_H=0 jellium/free-electron 케이스뿐. λ 날조·QE 모멘트 경계 fallback·QE 타겟 튜닝 모두 금지(d6) — residual 정직 보고. **breakthrough path(@D d2): M5.7 — aperiodic ground-state Hartree V_H[ρ] 를 `qforge_scf_pw` 에 wire-in** (`qforge_vhartree_from_rho`: ground-state ρ 의 dense FFT-Poisson, response Δρ 버전 재사용) → 그 후 CaH6 atoms→scf_pw→elph_scf→λ→Tc 재실행 → QE-NC harvest 와 cross-val.
- [x] **M5.5 — self-consistent H_of_rho(ρ) 통합 (engine-chain blocker B 절반)** · `stdlib/qforge/scf_pw.hexa` · hexa-lang PR#2412 · 매 SCF iter V_scr=V_H(ρ)+V_xc(ρ) 재평가 → assembler 재조립 → density-INDEPENDENT stub 졸업. g5 16/16 PASS: (A) free-electron 재현(M5 일치) · (B) jellium V_xc shift=해석적 LDA(V_x=−0.781593·V_xc=−0.855151) · (C) 자기무모순 fixed point(Δρ<1e-7·Σρ=nelec) · (D) 에너지 단조/mixing-invariant(E=0.535729).
- [x] **M5.6 — Sternheimer→|g|² atoms-경로 (engine-chain blocker B 절반)** · `stdlib/qforge/elph_scf.hexa` · hexa-lang PR#2413 · 수렴 SCF(ψ,ε)에서 Sternheimer 자기무모순 ΔV_scf → g_{mn}=⟨ψ_m|ΔV_scf|ψ_n⟩ atoms 직접 산출(QE dvscf 경계 아님). g5 11/11 PASS: (A) Hellmann-Feynman frozen-phonon FD(g_00=−0.223116=dε_0/du) · (B) bare limit · (C) SC 차폐 수렴 · (D) hermiticity · (E) acoustic sum rule.
- [x] **PR3 — atoms→SCF→|g|²→λ→Tc in-repo 오케스트레이터** · `stdlib/qforge/orchestrator_pw.hexa` · hexa-lang PR#2414 · 풀체인 in-repo(QE 무참여). g5 10/10 PASS: (A) chain 완주(ok=1·λ>0·Tc finite) · (B) |g|² SCF-sourced(ΔV 2배→λ ratio=4.0) · (C) Einstein round-trip(λ=0.04076=해석적).
- [ ] **M5.7 — aperiodic ground-state Hartree V_H[ρ] (M6 독립 CaH6 SCF 의 마지막 조각)** · ⚠ d6 residual(2026-06-01 M6 final-run 에서 표면화). orchestrator_pw 체인은 free-electron/Einstein 앵커 g5-green 이지만 실 CaH6(비균질 ρ, V_H≠0) SCF 는 미수렴 — `qforge_scf_pw` 가 ground-state `vh_diag` 를 in-loop 으로 만들지 못함(scf_pw.hexa L38-40). M5.5 가 닫은 건 V_H=0 jellium 한정. **할 일**: `qforge_vhartree_from_rho`(ground-state ρ → dense FFT-Poisson V_H, response Δρ 커널 `qforge_vhartree_from_drho` 재사용 d19) 신설 → `qforge_scf_pw` 내부에서 매-iter vh_diag 산출(caller-supplied 졸업) · g5 게이트(중성셀 H₂-like 분자에서 알려진 V_H 재현). 닫히면 CaH6 atoms→Tc 독립 실행 가능.
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
