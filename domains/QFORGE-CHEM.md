@title: 🧪 QFORGE-CHEM — reaction-path & transition-state engine ("화학 반응경로")

@goal: QFORGE 범용 엔진의 **chem scale** front-end — 화학 반응경로(MEP)와 전이상태(TS)를
공통코어 위에서 generic 하게 구한다: NEB(경로) → CI-NEB(saddle 정밀화) → TS-Hessian(1차조건
+ 허수진동수) → dimer/eigenvector-following(endpoint-free saddle). TS-Hessian 단계는 새 코드가
아니라 materials 스케일의 DFPT 선형응답(`qforge_phonons`)을 TS 좌표에서 재사용(d19)하는 thin
layer 다. verify = high-level QM / 실험 배리어 + 해석 정류점(Müller-Brown).

## method

반응경로 엔진은 image chain + spring force + perpendicular projection (NEB) 위에 build 된다.
**NEB**(Jónsson-Mills-Jacobsen 1998) → **improved tangent**(Henkelman-Jónsson 2000, 업윈드 →
kinked-band 제거) → **CI-NEB**(Henkelman-Uberuaga-Jónsson 2000, 최고에너지 image 의 평행력
부호반전 → spring 없이 saddle 등반) → **TS-Hessian**(Γ-점 Hessian = materials `qforge_phonons`
재사용, saddle 의 1-negative-eigenvalue + 허수진동수) → **dimer/MMF**(Henkelman-Jónsson 1999,
endpoint-free minimum-mode following — DFPT 가 내놓는 최저 Hessian eigenmode 를 그대로 소비).
verify 레퍼런스 = Müller-Brown 2D (minima 3 + saddle 2, 해석 정류점) + LEPS H₃.

## milestones

- [x] round-1 — NEB / CI-NEB reaction-path mechanics brick (improved tangent + climbing-image)
      `stdlib/qforge/chem/neb.hexa`. g5 PASS — Müller-Brown MEP + LEPS H₃ 해석 정류점 앵커. (hexa-lang #3126)
- [x] round-2 — NEB-SCF wiring: 반응경로 image energy 를 SCF 코어에 배선 `stdlib/qforge/chem/neb_scf.hexa`
- [x] round-3 — TS-Hessian via materials `qforge_phonons` reuse (d19): saddle 1-negative-eigenvalue
      `stdlib/qforge/chem/ts_hessian.hexa`. g5 32/32 PASS — Γ-점 Hessian = 포논 엔진 재사용, TS 좌표 1회 호출.
- [x] round-4 — dimer / eigenvector-following TS search: endpoint-free saddle, R3 imag-mode init accel
      `stdlib/qforge/chem/dimer.hexa`. g5 PASS — minimum-mode following on the DFPT lowest eigenmode.

### named frontier (within-class)
- [ ] real high-level-QM / 실험 reaction-barrier anchor (현재 Müller-Brown/LEPS 해석 벤치 — 실 분자
      반응 배리어는 MOLSCF/atoms CASSCF·CCSD(T) 에너지 feed + 실험 배리어 data-swap frontier)

## reuse (d19)

| chem term            | 재사용 코어 (rebuild 안 함)                              |
|----------------------|----------------------------------------------------------|
| TS-Hessian (Γ-point) | materials `qforge_phonons` (DFPT 선형응답, round-3)      |
| lowest eigenmode     | DFPT linear-response (dimer/MMF, round-4)                |
| image SCF energy     | `stdlib/qforge/scf` · `scf_etot` (round-2 NEB-SCF)       |
| eigh diagonalization | `stdlib/alloc/math/eigen` (Hessian eigenvalues)         |

NEXUS edge: `QFORGE/chem reuses materials qforge_phonons (DFPT) + qforge/scf_etot`. TS-Hessian =
포논 엔진의 Γ-점 Hessian 재사용 — 반응경로 엔진은 thin layer 이고 새 physics brick 이 아니다.

## honest scope (d6 / @L5)

chem scale = reaction-path mechanics (NEB → CI-NEB → TS-Hessian → dimer) 가 봉인. 모든 앵커는
해석 정류점 벤치 (Müller-Brown 2D, LEPS H₃) + DFPT-reuse identity. 실 분자 반응 배리어(high-level
QM / 실험)는 MOLSCF/atoms 의 correlated 에너지를 image 에 feed + 실험 배리어 data-swap frontier —
이는 새 method-class 가 아니라 energy-source integration. TS-Hessian 이 materials DFPT 를 재사용하는
것이 "one engine" thesis 의 chem-scale 증거다.

설계 SSOT: `drafts/qforge-chem-round1-design.md` (hexa-lang).
