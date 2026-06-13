# CaAuH3 (A11) — RTSC DFT el-ph 런북

🧪 **CaAuH3** · 별칭 **칼슘-금-수소 페로브스카이트** · SrAuH3 의 Ca 치환 변형

A-site 양이온을 Sr → Ca (더 가벼움) 로 바꿔 페로브스카이트-수소화물을 더 높은 Tc / 더 낮은
압력 쪽으로 튜닝되는지 검증한다. 페로브스카이트 금속-수소화물은 클라스레이트 초수소화물과는
**구분되는 메커니즘 클래스**다 (Au-H 팔면체 골격 + A-site 양이온).

- **anchor**: SrAuH3 cubic perovskite Pm-3m, celldm=7.2340 Bohr (=3.828 Å), 5-atom cell (d19 재사용).
- **구조**: ibrav=1 simple cubic, nat=5, ntyp=3 — Ca @ A-site (½,½,½), Au @ B-site (0,0,0),
  H @ 3개 face-center → Au-H 팔면체 골격.
- **격자 START**: celldm(1)=6.8361 Bohr (=3.618 Å, SrAuH3 ×0.945, ~5.5% 수축). vc-relax 가 진짜 a 를 찾음.
  Ca(1.00Å) < Sr(1.18Å) → ~5-7% 수축 예상, 50 GPa 하에서 목표 ~3.4-3.5 Å 로 더 수축 전망.
- **압력**: vc-relax `press=50.0` GPa (페로브스카이트는 중간압에서 안정인 경우 많음).
  ⚠ **ambient 안정성 테스트**는 vc-relax.in 의 `press` 를 `0.0` (1 atm) 으로 바꿔 재실행.

---

## 의사퍼텐셜 (d13)

PSL 1.0.0 (PBE, RRKJUS ultrasoft) 패밀리로 통일. **3종 모두 `pseudo/` 에 스테이징 + 실행 전 grep 확인**.

| 원소 | UPF 파일명 | 상대론 처리 | 비고 |
|------|-----------|------------|------|
| Ca | `Ca.pbe-spn-rrkjus_psl.1.0.0.UPF` | scalar | semicore s,p,n |
| Au | `Au.pbe-n-rrkjus_psl.1.0.0.UPF` | **scalar-relativistic** | ⚠ 5d — 아래 SOC 노트 |
| H  | `H.pbe-rrkjus_psl.1.0.0.UPF` | — | SrAuH3 anchor 재사용 |

> ⚠ **Au 는 5d 전이금속 — SOC + 상대론 의사퍼텐셜이 중요하다.**
> baseline 은 **scalar-relativistic** PSL Au UPF (`Au.pbe-n-rrkjus_psl.1.0.0.UPF`,
> 헤더 `relativistic="scalar" has_so="false"` 로 확인됨). 5d 밴드의 SOC 스플리팅이
> 페르미 준위 부근 DOS 와 EPC 에 영향을 줄 수 있으므로, full-relativistic Au UPF
> (예: `Au.rel-pbe-*_psl.1.0.0.UPF`, `lspinorb=.true.`) 가 라이브러리에 있으면
> 그것으로 교차검증한다. scalar 결과를 1차 baseline 으로, full-rel 을 SOC 보정 비교로.

> ⚠ **Au, H 는 로컬(`~/rtsc_srauh3_stage/pseudo/`)에 이미 확인됨**.
> **Ca 는 로컬 디스크에 없음** — 위 파일명은 PSL 1.0.0 표준 명명규칙 기준이며,
> 실행 직전 반드시 grep 확인할 것 (d13). 없으면 pslibrary 에서 받아 스테이징:
> ```bash
> ls -l ~/rtsc_caauh3/pseudo/Ca.pbe-spn-rrkjus_psl.1.0.0.UPF || \
>   echo "MISSING_CA_PSEUDO — pslibrary 에서 다운로드 필요 (psl.1.0.0 spn)"
> ```

---

## preflight 사이징 (#1885)

```bash
hexa cloud preflight --kind dft-phonon --atoms 5 --nq 8 --metallic
# atoms=5 (5-atom perovskite cell) · nq=8 (SC 4^3 → 8 IBZ q-points) · metallic (×3)
# → est_max_seconds = 42000 (11.6 h) · 권장 floor (×1.5) = 63000 (17.5 h)
```

- **추정 walltime: ~11.6 h** (권장 floor **17.5 h**).
- `recover=.true.` (ph.in 에 설정됨) → 언더사이징이어도 체크포인트로 작업 손실 0.
- ph.x 단계 timeout 은 권장 floor 이상으로 (`timeout 20h`) 잡는다.

---

## 실행 체인

vast.ai GPU 팟 (또는 pool ubu-1 free) 에서 아래 체인 실행. workdir = `/home/aiden/rtsc_caauh3`.

```bash
set -e

# 0) 환경 + 워크디렉터리
SRC=/home/aiden/rtsc_caauh3
mkdir -p "$SRC/out" "$SRC/pseudo"
cd "$SRC"
export OMP_NUM_THREADS=1
NP=6                                    # physcores; --oversubscribe 금지 (feedback: load thrash)
source ~/miniforge3/etc/profile.d/conda.sh
conda activate qe

# 0.1) 의사퍼텐셜 존재 확인 (d13) — 3종 모두
for f in Ca.pbe-spn-rrkjus_psl.1.0.0.UPF \
         Au.pbe-n-rrkjus_psl.1.0.0.UPF \
         H.pbe-rrkjus_psl.1.0.0.UPF; do
  ls -l "$SRC/pseudo/$f" || { echo "MISSING_PSEUDO: $f"; exit 1; }
done

# 1) vc-relax — 격자/위치 완화 (press=50 GPa). 진짜 celldm 을 찾는다.
timeout 6h mpirun -np $NP --bind-to none pw.x -in vc-relax.in > vc-relax.out 2>&1
grep -q "JOB DONE" vc-relax.out || { echo "VCRELAX_FAIL"; exit 1; }

# 1.1) 완화된 celldm(1) + 좌표를 scf.in 으로 반영 (수동 또는 파서)
#   vc-relax.out 의 final 'CELL_PARAMETERS' / 'ATOMIC_POSITIONS' 블록을 읽어
#   scf.in 의 celldm(1) 와 ATOMIC_POSITIONS 를 갱신한다.
grep -A2 "Begin final coordinates" vc-relax.out
echo ">>> scf.in 의 celldm(1) 을 위 완화값으로 갱신했는지 확인"

# 2) scf — dense 16^3 k (electron_phonon=simple 의 double-delta EPC 용)
timeout 4h mpirun -np $NP --bind-to none pw.x -in scf.in > scf.out 2>&1
grep -q "JOB DONE" scf.out || { echo "SCF_FAIL"; exit 1; }

# 3) ph.x — 4^3 q 포논 + el-ph (electron_phonon='simple', recover=.true.)
timeout 20h mpirun -np $NP --bind-to none ph.x -in ph.in > ph.out 2>&1
grep -q "JOB DONE" ph.out || { echo "PH_FAIL"; exit 1; }

# 4) 완료 플래그
touch "$SRC/ALL_DONE.flag"
echo "JOB DONE"
```

---

## 하베스트 / 파서

- **parser**: `rtsc-dft-elph` (Allen-Dynes Tc).
- λ (전자-포논 결합): sigma-plateau (sigma ≳ 0.025 Ry) 에서 읽는다 — 단조 broadening 꼬리 ❌.
- ω_log: 실수 모드에 대한 Allen-weighted exp(<ln ω>), BZ 평균.
- 안정성: 모든 IBZ q 의 모드가 실수여야 함 (허수 → 동적 불안정 → 이 압력에서 비안정).
- Tc: Allen-Dynes
  ```bash
  hexa verify --expr allen_dynes_tc <lambda> <omega_log> 0.10 --compute   # μ*=0.10
  hexa verify --expr allen_dynes_tc <lambda> <omega_log> 0.13 --compute   # μ*=0.13
  ```

## 정직성 (d6 · g3)

- λ_BZ 는 이 런 전까지 미측정 → Tc 는 추정뿐이었음. full-BZ Allen-weighted ω_log 가 진실값.
- plateau 강요 금지 — 정직한 sigma-plateau 또는 under-converged 로 보고.
- 허수 모드가 나오면 50 GPa 에서 비안정 → 압력 스윕(다른 press) 또는 ambient(press=0) 재시도.

---

## INFRA-READY 계약

- **runnable**: 위 실행 체인 (RUNBOOK.md)
- **inputs**: `vc-relax.in` · `scf.in` · `ph.in`
- **parser**: `rtsc-dft-elph` (allen_dynes_tc)
- **workdir**: `exports/rtsc/decks/CaAuH3/`
