# H3S — RTSC Im-3m BCC hydride 런북 (BUILD 산출물 · INFRA-READY)

> Im-3m (SG 229) BCC H3S, isostructural to Im-3m H3S. 압력 200 GPa.
> H @ 6b symmetrized-bond 위치 — H3S 의 high-symmetry 메커니즘 클래스.

## 1. 구조

- 공간군: **Im-3m (SG 229)**, BCC — H3S prototype
- QE ibrav = 3 (BCC primitive), nat = 4 (1 S + 3 H), ntyp = 2
- S @ 2a (0,0,0), H @ 6b (1/2,0,0)/(0,1/2,0)/(0,0,1/2)
- 목표 압력: **200 GPa**

> ⚠ vc-relax 가 진짜 평형 a 를 찾는다. celldm 은 시작 추정치.

## 2. Pseudopotential (d13)

| 원소 | UPF | 라이브러리 |
|------|-----|-----------|
| S | `S.pbe-n-rrkjus_psl.1.0.0.UPF` | PSL 1.0.0 (PBE) — main-group, 란타나이드 이슈 없음 |
| H  | `H.pbe-rrkjus_psl.1.0.0.UPF` | PSL 1.0.0 (PBE) |

## 3. 실행 체인

vc-relax → scf (16^3 k) → ph (el-ph simple, 4^3 q). NP=$(nproc), oversubscribe 금지.

## 4. 비조화 (anharmonic): true

> H3X 계열은 H 의 큰 ZPE 로 **비조화 보정 필수** (H3S SSCHA 선례). 본 deck 의
> 조화 ph.x el-ph 가 baseline; SSCHA 비조화 보정은 downstream 단계로 ω_log/λ 재계산.
