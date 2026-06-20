# RTSC general-cell deck — LiBeB (ibrav=0 · Materials Project mp-aaacfzbz)

> 일반셀(monoclinic/triclinic 등) flat-band SC 후보용. 고정대칭 프로토타입이 못 덮는 구조를 MP/CIF 임포트로 직접 받는다 (caller가 CELL_PARAMETERS·ATOMIC_SPECIES·ATOMIC_POSITIONS 포맷).

## 게이트 순서 (d_roomt_ambient g5 · d6 정직)
1. **vc-relax** (상압 press=0) → 평형 CELL_PARAMETERS/positions. 수렴 확인.
2. **scf** (verbosity high) → E_F·밴드폭·flat-band@E_F·자성. 완화 셀/positions 전파.
3. **matdyn 동적안정** (ph_gamma 또는 full-q) → 허수모드 0 확인 (상압 동적안정 = g5 #2).
4. **el-ph** (ph.in) → lambda·omega_log → Allen-Dynes/Eliashberg Tc. broadening-matched sigma scan.

## 규율
- d16: 발사 전 free `pool on <host>` 1-iter dry-run.
- pseudo/ 에 ATOMIC_SPECIES UPF 배치 (d13 element 커버 확인).
- 동적불안정(허수모드)이면 el-ph 신뢰불가 (d6) — 절대 λ/Tc 박제 금지.
- 신규성: 이미 출판된 조성/Tc는 재현 금지 (d_novel_only) — 미지 Δ만 발사.
