# Li2MgH16 — RTSC 38-atom 클라스레이트 런북 (BUILD 산출물)

> 수소-과잉 클라스레이트 Li2MgH16 (예측 Tc~473K @ 250 GPa, Sun et al.). 압력 250 GPa.
> ibrav=0 + CELL_PARAMETERS, nat=38 (4 Li + 2 Mg + 32 H), ntyp=3.
> ⚠ memory: ecutwfc=60.0/ecutrho=480.0 (가벼운 예산 — 80/800 OOM 회피).
> k/ecut/nq 는 /deck spec 키(k_relax·k_scf·ecutwfc·ecutrho·nq)로 메모리 튜닝 가능.

체인: vc-relax -> scf (8^3 k) -> ph (el-ph simple, 2^3 q). recover=.true.
