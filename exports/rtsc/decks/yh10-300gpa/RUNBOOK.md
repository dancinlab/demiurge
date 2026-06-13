# YH10 — RTSC Fm-3m sodalite clathrate 런북 (BUILD 산출물 · INFRA-READY)

> Fm-3m (SG 225) sodalite clathrate YH10, LaH10-isostructural. 압력 300 GPa.
> H32 cage 가 Y 를 둘러싸는 클라스레이트 — 초수소화물 고-Tc 메커니즘.

## 1. 구조

- 공간군: **Fm-3m (SG 225)**, fcc sodalite — LaH10/YH10 prototype
- QE ibrav = 2 (fcc primitive), nat = 11 (1 Y + 10 H), ntyp = 2
- Y @ 4a (0,0,0), H @ 8c (1/4,1/4,1/4), H @ 32f (x,x,x) x~0.375
- 목표 압력: **300 GPa**

> ⚠ vc-relax 가 진짜 평형 a + 32f x 를 찾는다. celldm/x 는 시작 추정치 (LaH10 family).

## 2. Pseudopotential (d13)

| 원소 | UPF | 라이브러리 |
|------|-----|-----------|
| Y | `Y.pbe-spn-rrkjus_psl.1.0.0.UPF` | PSL 1.0.0 (PBE) — d13 실행 전 grep 확인 |
| H  | `H.pbe-rrkjus_psl.1.0.0.UPF` | PSL 1.0.0 (PBE) |

## 3. 실행 체인

vc-relax → scf (12^3 k) → ph (el-ph simple, 2^3 q). NP=$(nproc), oversubscribe 금지.
recover=.true. → under-size 여도 0 work loss.
