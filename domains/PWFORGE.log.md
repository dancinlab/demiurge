# PWFORGE — historical log

Spec at [`./PWFORGE.md`](./PWFORGE.md).

## Log

- **2026-06-01 KST** — **🧱 PWFORGE 도메인 신규 등록 — QFORGE 평면파 H 조립기 front-end 독립 도메인**. trigger: 사용자 directive "조립기 도메인도 하나만들자". source: QFORGE 마이그레이션 게이트 blocker #1 분석 — correlation-XC 에이전트(hexa-lang PR#2402 PZ81/PW92 · #2405 PBE GGA, g5-green)가 정직 보고(d6/g6)로 발견: XC 항은 닫혔으나 `qforge_scf`가 `H_of_rho`를 caller closure(d4)로 받는데 원자위치+UPF→평면파 H 를 만드는 조립기가 stdlib/qforge 에 부재 (grep 확인: S(G)·V_loc→V_ext·kinetic·KB projectors 全 absent). **scope**: cell→H_of_rho 평면파 해밀토니안 front-end — QE pw.x 핵심의 hexa-native 포팅. M1~M6 (S(G)·kinetic·V_loc·KB-projector·조립기·CaH6 독립 cross-val) 全 [ ] OPEN. **honest status(g6)**: ⚙️ IN-PROGRESS — front-end 스택 에이전트가 g4 stacked PR 로 빌드 중 · speculation 아님(全 단계 g5-verifiable analytic anchor) · @D d6 no forced number(QE 모멘트 경계 재진입 후 "독립" 라벨링 금지). **게이트 관계**: M6 통과 ⇒ QFORGE migration blocker #1 완전 CLOSED, 단 blocker #2(LaH10·Li2MgH16 QE terminal)까지 충족해야 full flip (d_qforge_engine). **cross-link**: QFORGE(소비처 SCF·DFPT·λ·Tc · 같은 stdlib 홈) · RTSC(최종 캠페인 엔진) · NEXUS `@X c8` PWFORGE→QFORGE reuse-candidate. artifacts: `domains/PWFORGE.md` + `domains/PWFORGE.log.md` + NEXUS.tape c8. governance d1·d3·d4·d6·d_qforge_engine·d10·d19·g4·g5·g6.
