# ScH9 (B10) — RTSC DFT el-ph 런북

🧪 **ScH9** · 별칭 **스칸듐-수소 클라스레이트** · YH9/CeH9 의 Sc 치환 변형 (YH10-family 자매)

클라스레이트 초수소화물의 중심 금속을 Y/Ce → **Sc** (Y 의 가벼운 3d 동족원소) 로 바꿔,
검증된 YH10/YH9 라인을 **더 가벼운 금속 + 더 강한 수축** 방향으로 확장한다. Sc 는 Y 보다
훨씬 작고 가벼우므로 (질량 ↓ → 포논 진동수 ω_log ↑) Tc 가 오를 수 있는지 검증.
**구조적으로는 YH10 의 클라스레이트 메커니즘 클래스 그대로** (H 케이지가 금속을 둘러쌈).

- **anchor**: YH9 / CeH9 H-clathrate (P6₃/mmc-계 육방, H sodalite-유사 케이지가 금속 둘러쌈).
  YH9 Tc~243K@>200GPa (실험); CeH9 는 더 낮은 압력. 둘 다 **클라스레이트 초수소화물** 클래스.
- **구조**: ibrav=4 hexagonal, **SG P6₃/mmc (#194) 계열** (vc-relax 후 실제 대칭 확인),
  nat=10, ntyp=2 — **1 formula unit ScH9** (Sc 1 + H 9). 9 H 가 중심 Sc 주위 클라스레이트 케이지.
- **격자 START**: celldm(1)=5.20 Bohr (a=2.75 Å, YH9 a~3.27 Å ×0.84), celldm(3)=1.57 (c/a).
  Sc(0.87Å) << Y(1.04Å) → ~16% 케이지 수축. vc-relax 가 진짜 a, c/a, H 좌표를 찾음.
- **목표 압력**: vc-relax `press=1500.0` kbar = **150 GPa** (YH9-계 클라스레이트 안정화 레짐).
  ⚠ **lower-P fallback**: 동적 불안정(허수 모드) 시 `press=1000.0` (100 GPa) 으로 재실행.
  Sc 가 작아 더 높은 압력이 필요할 수도 → `press=2000.0` (200 GPa) 도 후보.

> ⚠ **클라스레이트 좌표는 START guess** 다. vc-relax.in 의 9 H 좌표는 물리적으로 동기부여된
> sodalite-유사 케이지 초기 추정이며, **vc-relax 가 진짜 클라스레이트 최소점으로 완화**한다
> (정확한 Wyckoff 세트는 완화에서 emerge). 완화 후 `dynmat`/대칭 분석으로 실제 SG 확인 권장.

---

## 의사퍼텐셜 (d13)

PSL 1.0.0 (PBE, RRKJUS ultrasoft) 패밀리로 통일. **2종 모두 `pseudo/` 에 스테이징 + 실행 전 grep 확인**.

| 원소 | UPF 파일명 | 상대론 처리 | 비고 |
|------|-----------|------------|------|
| Sc | `Sc.pbe-spn-rrkjus_psl.1.0.0.UPF` | scalar | semicore s,p,n (3s3p3d4s) |
| H  | `H.pbe-rrkjus_psl.1.0.0.UPF` | — | YH10/SrAuH3 anchor 재사용 (로컬 확인됨) |

> ⚠ **로컬 확인 결과**: `H` 는 `~/rtsc_srauh3_stage/pseudo/` 에 이미 존재 (확인됨).
> **Sc 는 로컬 디스크에 없음** — 위 파일명은 PSL 1.0.0 표준 명명규칙 (spn semicore, 동족
> Sr/Y 의 `*.pbe-spn-rrkjus_psl.1.0.0.UPF` 와 동일 패밀리) 기준. dispatcher 가 실행 직전
> **반드시 on-pod grep 확인** 할 것 (d13). 없으면 pslibrary 에서 받아 스테이징:
> ```bash
> ls -l ~/rtsc_sch9/pseudo/Sc.pbe-spn-rrkjus_psl.1.0.0.UPF || \
>   echo "MISSING_Sc_PSEUDO — pslibrary 에서 다운로드 필요 (psl.1.0.0 spn semicore)"
> ```
> Sc 는 3d 전이금속이지만 SOC 는 5d Au 대비 미미 → scalar-relativistic baseline 충분.

---

## preflight 사이징 (#1885)

```bash
hexa cloud preflight --kind dft-phonon --atoms 10 --nq 8 --metallic
# atoms=10 (1 f.u. clathrate, Sc+9H) · nq=8 (2^3 q-grid) · metallic (×3)
# → est_max_seconds = 336000 (93.3 h) · 권장 floor (×1.5) = 504000 (140.0 h)
```

- **추정 walltime: ~93.3 h** (권장 floor **140 h**).
- `ph.in` 에 `max_seconds = 504000` (floor) + `recover=.true.` 설정됨 → 언더사이징이어도 작업 손실 0.
- ph.x 단계 timeout 은 권장 floor 이상으로 (`timeout 144h`) 잡는다. **긴 잡 — recover 필수**.
- ⚠ 단일 팟에서 ~6일. q-별 split-q 멀티팟 캠페인이면 nq 당 ~12h 로 병렬화 가능.

---

## 실행 체인

vast.ai GPU 팟에서 아래 체인 실행. workdir = `/home/aiden/rtsc_sch9`.
(긴 잡 — pool free 보다 dedicated GPU pod 권장; recover 로 재-dispatch 안전.)

```bash
set -e

# 0) 환경 + 워크디렉터리
SRC=/home/aiden/rtsc_sch9
mkdir -p "$SRC/out" "$SRC/pseudo"
cd "$SRC"
export OMP_NUM_THREADS=1
NP=6                                    # physcores; --oversubscribe 금지 (feedback: load thrash)
source ~/miniforge3/etc/profile.d/conda.sh
conda activate qe

# 0.1) 의사퍼텐셜 존재 확인 (d13) — 2종 모두
for f in Sc.pbe-spn-rrkjus_psl.1.0.0.UPF \
         H.pbe-rrkjus_psl.1.0.0.UPF; do
  ls -l "$SRC/pseudo/$f" || { echo "MISSING_PSEUDO: $f"; exit 1; }
done

# 1) vc-relax — 격자/위치 완화 (press=1500 kbar = 150 GPa). 진짜 celldm + 클라스레이트 케이지 찾음.
timeout 8h mpirun -np $NP --bind-to none pw.x -in vc-relax.in > vc-relax.out 2>&1
grep -q "JOB DONE" vc-relax.out || { echo "VCRELAX_FAIL"; exit 1; }

# 1.1) 완화된 celldm(1), celldm(3) + 좌표를 scf.in 으로 반영 (수동 또는 파서)
#   vc-relax.out 의 final 'CELL_PARAMETERS' / 'ATOMIC_POSITIONS' 블록을 읽어
#   scf.in 의 celldm(1)/celldm(3) 와 ATOMIC_POSITIONS 를 갱신한다.
grep -A2 "Begin final coordinates" vc-relax.out
echo ">>> scf.in 의 celldm(1)/celldm(3) 을 위 완화값으로 갱신했는지 확인"

# 2) scf — dense 16x16x12 k (electron_phonon=simple 의 double-delta EPC 용)
timeout 6h mpirun -np $NP --bind-to none pw.x -in scf.in > scf.out 2>&1
grep -q "JOB DONE" scf.out || { echo "SCF_FAIL"; exit 1; }

# 3) ph.x — 2^3 q 포논 + el-ph (electron_phonon='simple', recover=.true., max_seconds=504000)
timeout 144h mpirun -np $NP --bind-to none ph.x -in ph.in > ph.out 2>&1
grep -q "JOB DONE" ph.out || { echo "PH_FAIL"; exit 1; }

# 4) 완료 플래그
touch "$SRC/ALL_DONE.flag"
echo "JOB DONE"
```

---

## 하베스트 / 파서

- **parser**: `rtsc-dft-elph` (Allen-Dynes Tc).
- λ (전자-포논 결합): sigma-plateau (sigma ≳ 0.025 Ry) 에서 읽는다 — 단조 broadening 꼬리 ❌.
- ω_log: 실수 모드에 대한 Allen-weighted exp(<ln ω>), BZ 평균. (Sc 경량 → ω_log 높을 전망.)
- 안정성: 모든 IBZ q 의 모드가 실수여야 함 (허수 → 동적 불안정 → 이 압력에서 비안정).
- Tc: Allen-Dynes
  ```bash
  hexa verify --expr allen_dynes_tc <lambda> <omega_log> 0.10 --compute   # μ*=0.10
  hexa verify --expr allen_dynes_tc <lambda> <omega_log> 0.13 --compute   # μ*=0.13
  ```

## 정직성 (d6 · g3)

- λ_BZ 는 이 런 전까지 미측정 → Tc 는 추정뿐이었음. full-BZ Allen-weighted ω_log 가 진실값.
- plateau 강요 금지 — 정직한 sigma-plateau 또는 under-converged 로 보고.
- **사전등록 falsifier**: 150 GPa 에서 허수 모드 → 동적 비안정 → **closed-negative**
  (Sc 클라스레이트 축이 YH10-family Tc 목표에 ⊥). 압력 스윕(100/200 GPa) 재시도.
- Sc 가 작아 H 케이지가 무너질(불안정) 가능성도 falsifier — 정직하게 보고.

---

## INFRA-READY 계약

- **runnable**: 위 실행 체인 (RUNBOOK.md)
- **inputs**: `vc-relax.in` · `scf.in` · `ph.in`
- **parser**: `rtsc-dft-elph` (allen_dynes_tc)
- **workdir**: `exports/rtsc/decks/ScH9/`
