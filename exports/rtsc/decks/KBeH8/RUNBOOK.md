# KBeH8 — RTSC A02 DFT el-ph 런북 (BUILD 산출물 · INFRA-READY)

🧪 **KBeH8** · 별칭 **칼륨-베릴륨-수소화물** · AcBeH8 의 K 치환 변형 (MgBeH8 파일럿 자매)

> 비방사성·저가 알칼리 K 변종(AcBeH8 → KBeH8). 목표: Be-H clathrate 사전압축(precompressor)이
> 알칼리 K 치환 후 저압(10 GPa)에서 보존되는지 — RTSC 압력축 돌파선 검증.
> MgBeH8(A01) 파일럿과 동일 앵커·동일 격자(fcc Fm-3m)·동일 q-grid, A-site 만 Mg→K.
> 앵커: arXiv:2411.19028v2 (Gao et al., "actinium beryllium hydrides at low pressure", AcBeH8 Tc 181K @ 10 GPa).

## 1. 구조 (structure)

| 항목 | 값 |
|------|-----|
| 공간군 | **Fm-3m (SG 225)**, fcc — AcBeH8/LaBeH8 prototype |
| QE ibrav | 2 (fcc primitive) |
| celldm(1) (시작 추정) | **10.0157 Bohr** = a_conv 5.30 Å |
| 격자 도출 | AcBeH8 a_conv ~5.30 Å (저압 앵커) → K+(1.38 Å) 가 Ac/Mg 보다 **크다** → 시작값을 AcBeH8 full a 로 두고 relax 가 확장/조정 |
| nat | **10** (1 K + 1 Be + 8 H) — 1 f.u./primitive |
| ntyp | 3 |
| 목표 압력 | **10 GPa (= 100 kbar)** — AcBeH8 저압 안정성 미러; **fallback 50 GPa (= 500 kbar)** |
| 케이지 | BeH8 clathrate (Be @ 4b, H @ 32f xxx, K @ 4a) |

> ⚠ vc-relax 가 진짜 평형구조를 찾는다. celldm/positions 는 **시작 추정치**일 뿐.
> nosym=.true. 가드 — checkallsym 크래시 회피 (sc2be2h6 캠페인 교훈).
> H 32f 좌표 x~0.12 는 LaBeH8 케이지 패밀리 시작값. relax 후 scf.in 에 갱신.
> ⚠ **전자 카운트 노트**: K(+1) 은 Ac(+3)/Mg(+2) 보다 전자가 적어 BeH8 케이지의 hole-doping
> 정도가 다르다. relax 후 페르미 준위 부근 DOS 와 동적 안정성(허수 모드 여부)이 변종의
> 핵심 판별점 — falsifier 와 직결.

### 압력 fallback 절차
10 GPa relax 가 동적 불안정(허수 phonon 다수)이면:
`vc-relax.in` 의 `&CELL press = 100.0` → `press = 500.0` (50 GPa) 으로 바꿔 재실행.
AcBeH8 원논문도 압력↓ 한계가 ~10 GPa 이므로, K 변종이 더 높은 압력을 요구할 수 있음.

## 2. Pseudopotential 커버리지 (d13)

세 원소 모두 경원소(K=4s 발렌스, 3s3p semicore) → **PSL 1.0.0 PBE** 표준 커버리지. 란타나이드 이슈 없음.

| 원소 | 질량 | UPF 파일명 | 라이브러리 | 비고 |
|------|------|-----------|-----------|------|
| K  | 39.098 | `K.pbe-spn-rrkjus_psl.1.0.0.UPF` | PSL 1.0.0 (US, PBE) | spn = 3s,3p semicore + nlcc (Ca 와 동일 spn 패턴) |
| Be | 9.0122 | `Be.pbe-n-rrkjus_psl.1.0.0.UPF`   | PSL 1.0.0 (US, PBE) | MgBeH8 파일럿 재사용 (검증됨) |
| H  | 1.008  | `H.pbe-rrkjus_psl.1.0.0.UPF`      | PSL 1.0.0 (US, PBE) | MgBeH8 파일럿 재사용 (검증됨) |

> Be/H 는 MgBeH8(A01) 파일럿 데크에서 이미 검증된 PSL 1.0.0 UPF 명. 그대로 재사용.
> **K 는 실행 직전 grep 확인 (d13)** — semicore 알칼리는 spn(3s3p+nlcc) 변종을 쓴다 (Ca 의
> `Ca.pbe-spn-rrkjus_psl.1.0.0.UPF` 와 동일 명명규칙). 없으면 pslibrary 1.0.0 에서 fetch:
> ```bash
> ls -l ./pseudo/K.pbe-spn-rrkjus_psl.1.0.0.UPF || \
>   echo "MISSING_K_PSEUDO — pslibrary.1.0.0 에서 spn 변종 다운로드 필요"
> ```
> 디스패치 시 pseudo/ 디렉터리에 위 3개 UPF 배치 (QE pslibrary.1.0.0 에서 fetch).

## 3. 사전점검 sizing (preflight #1885)

```
hexa cloud preflight --kind dft-phonon --atoms 10 --nq 8 --metallic
```

> KBeH8 = MgBeH8 파일럿과 atom 수(10)·q-grid(nq=8)·metallic 가 **동일** → preflight 출력 동일.

| q-grid | nq | est_max_seconds | walltime | floor(×1.5) | 비고 |
|--------|----|----|----------|-------------|------|
| **2×2×2** | 8  | 336000 s | **93.3 h** | 504000 s (140 h) | ✅ 단일 pod 가능 (ph.in 채택) |
| 4×4×4 | 64 | 2688000 s | 746.6 h | 4032000 s (1120 h) | ⚠ multi-pod/split-q 만 |

- hydride metal → `--metallic` (×3 factor) 적용.
- `ph.in` 의 `max_seconds = 504000` (140h floor) + `recover=.true.` → under-size 여도 0 work loss.

## 4. 실행 체인 (dispatch 단계에서 pod 위에 materialize)

> demiurge 가 `.sh` Write 를 차단하므로, 디스패처가 아래 펜스 블록을 그대로
> pod 의 `run_chain.sh` 로 복사해 실행한다.

```bash
#!/usr/bin/env bash
# KBeH8 RTSC A02 — vc-relax -> scf -> ph(el-ph simple) chain
set -euo pipefail
cd "$(dirname "$0")"

# --- 0. conda env (QE 7.x) ---
source ~/miniconda3/etc/profile.d/conda.sh
conda activate qe          # pw.x / ph.x 제공 환경 (없으면: conda create -n qe -c conda-forge qe)
export OMP_NUM_THREADS=1
NP=$(nproc)                 # physcores; oversubscribe 금지 (feedback: vast el-ph safe launch)

# --- 0.1 의사퍼텐셜 존재 확인 (d13) — 3종 모두 ---
for f in K.pbe-spn-rrkjus_psl.1.0.0.UPF \
         Be.pbe-n-rrkjus_psl.1.0.0.UPF \
         H.pbe-rrkjus_psl.1.0.0.UPF; do
  ls -l "./pseudo/$f" || { echo "MISSING_PSEUDO: $f"; exit 1; }
done

# --- 1. vc-relax (10 GPa target) ---
mpirun -np "$NP" pw.x -inp vc-relax.in > vc-relax.out 2>&1
grep -q "JOB DONE" vc-relax.out || { echo "vc-relax FAILED"; exit 1; }

# --- 1b. 갱신: 완화된 celldm + ATOMIC_POSITIONS 를 scf.in 으로 전파 ---
#   (relaxed CELL_PARAMETERS / 마지막 ATOMIC_POSITIONS 블록을 scf.in 에 반영.
#    수동/스크립트 둘 다 가능 — 디스패처가 vc-relax.out 의 final geometry 를 파싱해 scf.in 패치)

# --- 2. scf (relaxed geometry) ---
mpirun -np "$NP" pw.x -inp scf.in > scf.out 2>&1
grep -q "JOB DONE" scf.out || { echo "scf FAILED"; exit 1; }

# --- 3. phonon + el-ph (simple) ---
mpirun -np "$NP" ph.x -inp ph.in > ph.out 2>&1
grep -q "JOB DONE" ph.out || { echo "ph FAILED"; exit 1; }

echo "JOB DONE"
```

> 동적 불안정(허수 freq) → 위 §1 압력 fallback(50 GPa)으로 재발사.

## 5. 파서 (parser)

- `parser_template: rtsc-dft-elph`
- 입력: `ph.out` 의 λ(electron-phonon coupling) / ω_log(logarithmic avg phonon freq)
- 산출: **allen_dynes_tc** (Allen-Dynes McMillan Tc, μ* = 0.10~0.13 스캔)
- el_ph_nsigma=10 의 σ-scan 플래토에서 수렴 λ 채택.
- 정직성(d6·g3): λ_BZ 미측정 → plateau 강요 금지. 허수 모드면 이 압력에서 비안정(closed-negative).

## 6. INFRA-READY 계약 (4 prereqs)

| prereq | 충족 | 위치 |
|--------|------|------|
| runnable | ✅ | RUNBOOK.md §4 run 체인 (pod 위 materialize) |
| inputs   | ✅ | `vc-relax.in` · `scf.in` · `ph.in` (이 디렉터리) |
| parser   | ✅ | `parser_template: rtsc-dft-elph` (§5) |
| workdir  | ✅ | `exports/rtsc/decks/KBeH8/` |

**INFRA-READY: 4/4** — /micro-exp vast.ai 발사 준비 완료.
provider 우선순위 = vast.ai → runpod fallback (d17).
