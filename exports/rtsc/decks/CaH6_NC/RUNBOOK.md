# CaH6 — RTSC 7-atom Im-3m 소달라이트 런북 (NC-vs-NC M6 앵커)

> CaH6 sodalite clathrate (Im-3m, Ma 2022 측정 215K @ 170 GPa).
> ibrav=3 BCC-primitive, nat=7 (1 Ca + 6 H), ntyp=2.
> ⚠ PSEUDO 클래스: 이 앵커는 NORM-CONSERVING — m=Ca_ONCV_PBE_sr.upf · H=H_ONCV_PBE_sr.upf.
> 목적: QFORGE(NC)↔QE(NC) apples-to-apples 교차검증 (동일 pseudo+grid). PWFORGE M6.
> ⚠ vc-relax 가 진짜 평형구조를 찾는다. celldm/positions 는 시작 추정치.

체인: vc-relax -> scf (16^3 k) -> ph (el-ph simple, 2^3 q). recover=.true.
> NC-vs-NC 앵커는 coarse 2^3-q 로 충분 (수렴 생산 Tc 가 아니라 동일 grid+pseudo 일치가 목표).
