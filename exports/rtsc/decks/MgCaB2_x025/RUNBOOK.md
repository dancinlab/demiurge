# MgCaB2 x=0.25 (A25) — RTSC DFT el-ph 런북

🧪 **Mg₀.₇₅Ca₀.₂₅B₂** · 별칭 **칼슘-도핑 이붕화마그네슘** · MgB2 의 Ca 치환 (BCS · 상압)

MgB2 의 39K BCS 천장을 **Ca 치환**으로 넘어설 수 있는지 검증한다. Ca 가 보론 σ-밴드 채움 /
격자(a, c)를 튜닝해 honeycomb 보론층의 E2g 포논-전자 결합을 강화하는지가 핵심. 이 후보는
**BCS 쪽** (비-수소화물) 이며 **상압(AMBIENT, 1 atm / 0 GPa)** — 파일럿에서 유일한 **압력-축
없는 라인**으로, 고압 수소화물 라인의 상보 대조군이다.

- **anchor**: 순수 MgB2 P6/mmm (AlB2 prototype #191), a=3.086 Å (5.832 Bohr), c/a=1.1418
  (Akimitsu 2001 측정, Tc=39K). 이 repo 의 **검증된 baseline**:
  `exports/material_verdict/mgb2_budko2001_v1/` — McMillan/Allen-Dynes Tc 일치 **PASS**
  (conductor:MgB2 spec.tc_k=39 ↔ 측정 r_t headline.tc_k=39, |Δ|/Tc=0.000). d19 재사용.
- **구조**: 프리미티브의 **2×2×1 슈퍼셀** = 4 metal + 8 B = **12 atoms**. Mg 1개 → Ca 치환
  → **x=0.25** (1 Ca / 4 metal). 조성 **Mg₀.₇₅Ca₀.₂₅B₂** (1 Ca + 3 Mg + 8 B).
- **셀**: `ibrav=0` 명시 CELL_PARAMETERS (2×2×1 육방 슈퍼셀 벡터, Bohr 단위).
  in-plane 2배(11.664 / -5.832,10.101 Bohr), c 동일(6.659 Bohr).
- **대칭 가드**: `nosym=.true.` — Ca 치환이 슈퍼셀 점군 대칭을 깨므로 자동 대칭검출을 끈다.
- **압력**: vc-relax `press=0.0` (AMBIENT, 1 atm). **도핑 연구**이지 고압 클라스레이트 아님.
  `cell_dofree='all'` 로 a + c 모두 상압에서 완화.

---

## 의사퍼텐셜 (d13)

PSL 1.0.0 (PBE, RRKJUS ultrasoft) 패밀리로 3종 통일. **모두 light/standard 커버리지 —
란타나이드/5d 이슈 없음**. 실행 전 `pseudo/` 에 스테이징 + grep 확인.

| 원소 | UPF 파일명 | 출처 | 비고 |
|------|-----------|------|------|
| Ca | `Ca.pbe-spn-rrkjus_psl.1.0.0.UPF` | PSlibrary 1.0.0 PBE rrkjus | semicore s,p,n (CaAuH3 캠페인 재사용) |
| Mg | `Mg.pbe-spnl-rrkjus_psl.1.0.0.UPF` | PSlibrary 1.0.0 PBE rrkjus | semicore s,p,n,l (mgb2_pure / mg2irh6 재사용) |
| B  | `B.pbe-n-rrkjus_psl.1.0.0.UPF` | PSlibrary 1.0.0 PBE rrkjus | n (mgb2_pure anchor 재사용) |

> ⚠ Mg, B 는 `mgb2_pure` / `mg2irh6` 캠페인에서, Ca 는 `CaAuH3` 캠페인에서 **사용된 적 있음**.
> 위 파일명은 PSL 1.0.0 표준 명명규칙 기준이며, 실행 직전 반드시 grep 확인할 것 (d13).
> 없으면 pslibrary 1.0.0 (PBE, spn/spnl/n) 에서 받아 스테이징.

---

## preflight 사이징 (#1885)

```bash
hexa cloud preflight --kind dft-phonon --atoms 12 --nq 4 --metallic
# atoms=12 (2x2x1 SC) · nq=4 (2x2x1 q-grid, nosym -> 4 q-points) · metallic (×3, 깨끗한 금속)
# -> est_max_seconds = 290304 (80.6 h) · 권장 floor (×1.5) = 435456 (120.9 h)
```

- **추정 walltime: ~80.6 h** (권장 floor **120.9 h**).
- `recover=.true.` (ph.in 에 설정됨, `max_seconds=432000`) → 언더사이징이어도 체크포인트로 손실 0.
- MgB2 는 깨끗한 금속(σ+π 밴드가 E_F 횡단) → metallic ×3 팩터 적용.
- ph.x 단계 timeout 은 권장 floor 이상으로 (`timeout 130h`) 잡는다.

---

## $0 팟 재사용 (rent 금지)

이 후보는 **작은 셀(12 atom) + 상압** → 신규 rent 대신 **기존 팟 재사용**이 이상적.

- **재사용 타깃**: ssh9 (38095989, ~120 core 여유) 또는 ssh6. `-np 8~12` 로 점유.
- **신규 rent 하지 말 것** — $0 재사용 (d7 small-cell, d17 cost-bearing 이지만 여기선 재사용이 우선).
- 동일 팟에서 다른 잡과 병행 시 `-np` 를 여유 코어 내로 제한 (oversubscribe 금지 — load thrash).

---

## 실행 체인

기존 팟(ssh9/ssh6, $0 재사용) 에서 아래 체인 실행. workdir = `/home/aiden/rtsc_mgcab2_x025`.

```bash
set -e

# 0) 환경 + 워크디렉터리 (detached/non-login 셸 → conda source 직접: feedback detached env loss)
SRC=/home/aiden/rtsc_mgcab2_x025
mkdir -p "$SRC/out" "$SRC/pseudo"
cd "$SRC"
export OMP_NUM_THREADS=1
NP=8                                    # physcores (재사용 팟 여유 내, np8-12); --oversubscribe 금지
source ~/miniforge3/etc/profile.d/conda.sh
conda activate qe

# 0.1) 의사퍼텐셜 존재 확인 (d13) — 3종 모두
for f in Ca.pbe-spn-rrkjus_psl.1.0.0.UPF \
         Mg.pbe-spnl-rrkjus_psl.1.0.0.UPF \
         B.pbe-n-rrkjus_psl.1.0.0.UPF; do
  ls -l "$SRC/pseudo/$f" || { echo "MISSING_PSEUDO: $f"; exit 1; }
done

# 1) vc-relax — 12-atom 슈퍼셀 격자/위치 완화 (press=0, AMBIENT). 진짜 a,c 를 찾는다.
timeout 8h mpirun -np $NP --bind-to none pw.x -in vc-relax.in > vc-relax.out 2>&1
grep -q "JOB DONE" vc-relax.out || { echo "VCRELAX_FAIL"; exit 1; }

# 1.1) 완화된 CELL_PARAMETERS + ATOMIC_POSITIONS 를 scf.in 으로 반영 (수동 또는 파서)
#   vc-relax.out 의 final 'CELL_PARAMETERS' / 'ATOMIC_POSITIONS' 블록을 읽어
#   scf.in 의 CELL_PARAMETERS 와 ATOMIC_POSITIONS 를 갱신한다.
grep -A20 "Begin final coordinates" vc-relax.out
echo ">>> scf.in 의 CELL_PARAMETERS + ATOMIC_POSITIONS 를 위 완화값으로 갱신했는지 확인"

# 2) scf — dense 12^3 k (electron_phonon=simple 의 double-delta EPC 적분용)
timeout 6h mpirun -np $NP --bind-to none pw.x -in scf.in > scf.out 2>&1
grep -q "JOB DONE" scf.out || { echo "SCF_FAIL"; exit 1; }

# 3) ph.x — 2x2x1 q 포논 + el-ph (electron_phonon='simple', recover=.true.)
timeout 130h mpirun -np $NP --bind-to none ph.x -in ph.in > ph.out 2>&1
grep -q "JOB DONE" ph.out || { echo "PH_FAIL"; exit 1; }

# 4) 완료 플래그
touch "$SRC/ALL_DONE.flag"
echo "JOB DONE"
```

---

## 하베스트 / 파서

- **parser**: `rtsc-dft-elph` (Allen-Dynes Tc).
- λ (전자-포논 결합): sigma-plateau (sigma ≳ 0.025 Ry) 에서 읽는다 — 단조 broadening 꼬리 ❌.
- ω_log: 실수 모드에 대한 Allen-weighted exp(<ln ω>), BZ 평균. MgB2 의 E2g 모드가 지배적.
- 안정성: 모든 q 의 모드가 실수여야 함 (허수 → 동적 불안정 → 이 조성/상압에서 비안정).
- Tc: Allen-Dynes
  ```bash
  hexa verify --expr allen_dynes_tc <lambda> <omega_log> 0.10 --compute   # μ*=0.10
  hexa verify --expr allen_dynes_tc <lambda> <omega_log> 0.13 --compute   # μ*=0.13
  ```
- **falsifier**: Tc_AD(x=0.25) 가 순수 MgB2 baseline 39K 를 **넘으면** Ca-튜닝 가설 지지(🟢
  방향); 39K 이하 / 동적 불안정(허수 모드) 이면 x=0.25 는 BCS 천장 돌파 실패 (🔴 / 음성 결과도 publishable).

## 정직성 (d6 · g3)

- λ_BZ 는 이 런 전까지 미측정 → Tc 는 추정뿐. full-BZ Allen-weighted ω_log 가 진실값.
- plateau 강요 금지 — 정직한 sigma-plateau 또는 under-converged 로 보고.
- 허수 모드가 나오면 상압에서 비안정 → x 스윕(다른 도핑) 또는 셀 재완화 재시도.
- isotropic Allen-Dynes 는 MgB2 의 σ+π double-gap 을 single 평균으로 환원 — Tc 근접해도
  physical-correct 아님. anisotropic Eliashberg / EPW 필요 시 별 cohort (honest scope 명기).
- R4 absorbed=false (simulation tier, no measured oracle PASS).

---

## INFRA-READY 계약

- **runnable**: 위 실행 체인 (RUNBOOK.md)
- **inputs**: `vc-relax.in` · `scf.in` · `ph.in`
- **parser**: `rtsc-dft-elph` (allen_dynes_tc)
- **workdir**: `exports/rtsc/decks/MgCaB2_x025/`
