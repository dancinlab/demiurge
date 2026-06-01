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
- **현재 상태(정직 g6, 2026-06-01)**: ✅ **front-end LIVE** — M1~M5 全 landed+g5-green (hexa-lang PR#2407~#2411), 실제 Si SCF 가 원자위치부터 in-repo 독립 수렴 실증. M6(CaH6 독립 cross-val)만 ⚠ input-blocked(NC 의사퍼텐셜 부재 · 구조 아님). XC 항은 QFORGE 에 기 landed(PR#2402·#2405). blocker #1 **구조 갭 CLOSED**, |g|² acceptance 는 PP-input 대기.

## 1. front-end 스택 (마일스톤 · 각 g5 anchor)

- [x] **M1 — S(G) 구조인자** · `stdlib/qforge/structure.hexa` · hexa-lang PR#2407 · g5-green (단원자→S(G)=1 · 2원자 간섭 · 병진위상)
- [x] **M2 — plane-wave kinetic** · `stdlib/qforge/kinetic.hexa` · PR#2408 · 자유전자 |k+G|²/2 closed-form 🔵
- [x] **M3 — V_loc(G)→V_ext** · `stdlib/qforge/vloc.hexa` · PR#2409 · 순수-Coulomb anchor rel 0.0 · −Z·4π/G² 점근
- [x] **M4 — KB 비국소 projector** · `stdlib/qforge/projector.hexa` · PR#2410 · Gaussian projector closed-form rel ~1e-11 · V_NL hermiticity
- [x] **M5 — 조립기 (H_of_rho)** · `stdlib/qforge/assembler.hexa` · PR#2411 (tip 9ba148db6) · **실증**: 실제 Si NC UPF + 원자위치로 27-PW H 조립 → `qforge_scf` 독립 수렴 (converged=true, 26 iters, lowest KS −3.47 Ha) — atoms→SCF front-end LIVE in-repo
- [ ] **M6 — CaH6 독립 cross-val (payoff)** · ⚠ **input-blocked (구조 아님 · d6 정직)** — `upf.hexa`=norm-conserving 전용인데 디스크의 유일한 H 의사퍼텐셜이 ultrasoft, Ca 의사퍼텐셜 부재, QE CaH6 ref 는 PBE PAW → NC-vs-PAW pseudization 혼입(d6 금지). 컴퓨트 무관(free ~7-atom). breakthrough paths(@D d2): ① ONCV NC Ca+H set + QE NC ref 재생성 · ② upf 파서 US/PAW 확장 · ③ matched-NC ref 있는 형제 수소화물에서 |g|² 종결

## 2. 게이트 관계 (QFORGE 마이그레이션)

```
QFORGE production 마이그레이션 게이트
├─ blocker #1  el-ph front-end
│   ├─ XC 항          ✅ CLOSED (correlation landed, g5-green)
│   └─ cell→H 조립기  ⬅ PWFORGE 가 닫는 부분 (M1~M6)
└─ blocker #2  3-anchor terminal (CaH6 ✅ / LaH10·Li2MgH16 QE pending)
```

- M6 통과 ⇒ blocker #1 완전 CLOSED. 그래도 full migration flip 은 blocker #2(LaH10·Li2MgH16 QE terminal+일치)까지 충족해야 함 (@D d_qforge_engine — un-cross-val'd 결과로 absorbed 금지 · no forced flip).

## 3. 거버넌스 · reuse

- governance: d1·d4(generic dispatch · H_of_rho = caller closure)·d6(no forced number)·d_qforge_engine·g4·g5·g6·d10·d19.
- reuse lattice (NEXUS): `@X c8` PWFORGE provides `H_of_rho` front-end → QFORGE (reuse-candidate until M6 g5 passes → verified-edge 승격). QFORGE.md SSOT.
- SSOT 코드: hexa-lang `stdlib/qforge/` (scf·upf·screening·elph 와 같은 집). PWFORGE 모듈도 동일 stdlib 홈 (d3 — topical folder 분산 금지).
