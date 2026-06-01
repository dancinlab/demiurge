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
- **현재 상태(정직 g6)**: ⚙️ IN-PROGRESS — front-end 스택 에이전트가 PR 단위로 빌드 중. XC 항(Hartree+exchange+correlation)은 이미 QFORGE 에 landed(PR#2402 PZ81/PW92 · #2405 PBE GGA, g5-green). 남은 4조각 + 조립기 = PWFORGE 범위.

## 1. front-end 스택 (마일스톤 · 각 g5 anchor)

- [ ] **M1 — S(G) 구조인자** · anchor: 단원자@원점 → S(G)=1 ∀G · 2원자 basis 간섭패턴 · 병진위상 일관성
- [ ] **M2 — plane-wave kinetic** · anchor: 자유전자 고유값 |k+G|²/2 closed-form (🔵)
- [ ] **M3 — V_loc(G)→V_ext** · anchor: G=0 보상 처리 · Coulomb tail −Z·4π/G² 점근 · 실제 UPF local 채널 샘플값
- [ ] **M4 — KB 비국소 projector** · anchor: projector 정규화 · V_NL 블록 hermiticity · 1-projector analytic case
- [ ] **M5 — 조립기 (H_of_rho)** · S(G)+kinetic+V_loc+V_NL+Hartree+XC 합성 → qforge_scf 입력 · anchor: H hermiticity · 소형계(H atom/전자가스) SCF 기준 총에너지 수렴 (🟢)
- [ ] **M6 — CaH6 독립 cross-val (payoff)** · 원자위치부터 atoms→SCF→|g|²→λ→Tc QFORGE-only 실행 → QE ref(λ=4.376·ω_log=1236.4K·Tc 255.1K)와 λ·Tc rel-ε g5 대조 (목표 ≤0.5%)

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
