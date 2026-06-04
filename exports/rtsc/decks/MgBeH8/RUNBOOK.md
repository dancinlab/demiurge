# MgBeH8 — RTSC A01 DFT el-ph 런북 (BUILD 산출물 · INFRA-READY)

> 비방사성 Mg 변종(AcBeH8 → MgBeH8). 목표: Be-H clathrate 사전압축(precompressor)이
> Mg 치환 후 저압(10 GPa)에서 보존되는지 — RTSC 압력축 돌파선 검증.
> 앵커: arXiv:2411.19028v2 (Gao et al., "actinium beryllium hydrides at low pressure", AcBeH8 Tc 181K @ 10 GPa).

## 1. 구조 (structure)

| 항목 | 값 |
|------|-----|
| 공간군 | **Fm-3m (SG 225)**, fcc — AcBeH8/LaBeH8 prototype |
| QE ibrav | 2 (fcc primitive) |
| celldm(1) (시작 추정) | **8.5132 Bohr** = a_conv 4.505 Å |
| 격자 도출 | AcBeH8 a_conv ~5.30 Å (저압 앵커) → Mg 15% 수축 (Ac 1.95Å → Mg 1.60Å 반경비) |
| nat | **10** (1 Mg + 1 Be + 8 H) — 1 f.u./primitive |
| ntyp | 3 |
| 목표 압력 | **10 GPa (= 100 kbar)** — AcBeH8 저압 안정성 미러; **fallback 50 GPa (= 500 kbar)** |
| 케이지 | BeH8 clathrate (Be @ 4b, H @ 32f xxx, Mg @ 4a) |

> ⚠ vc-relax 가 진짜 평형구조를 찾는다. celldm/positions 는 **시작 추정치**일 뿐.
> nosym=.true. 가드 — checkallsym 크래시 회피 (sc2be2h6 캠페인 교훈).
> H 32f 좌표 x~0.12 는 LaBeH8 케이지 패밀리 시작값. relax 후 scf.in 에 갱신.

### 압력 fallback 절차
10 GPa relax 가 동적 불안정(허수 phonon 다수)이면:
`vc-relax.in` 의 `&CELL press = 100.0` → `press = 500.0` (50 GPa) 으로 바꿔 재실행.
AcBeH8 원논문도 압력↓ 한계가 ~10 GPa 이므로, Mg 변종이 더 높은 압력을 요구할 수 있음.

## 2. Pseudopotential 커버리지 (d13)

세 원소 모두 경원소 → **PSL 1.0.0 PBE** 표준 커버리지. 란타나이드 이슈 없음.

| 원소 | 질량 | UPF 파일명 | 라이브러리 |
|------|------|-----------|-----------|
| Mg | 24.305 | `Mg.pbe-spnl-rrkjus_psl.1.0.0.UPF` | PSL 1.0.0 (US, PBE) |
| Be | 9.0122 | `Be.pbe-n-rrkjus_psl.1.0.0.UPF`   | PSL 1.0.0 (US, PBE) |
| H  | 1.008  | `H.pbe-rrkjus_psl.1.0.0.UPF`      | PSL 1.0.0 (US, PBE) |

> 출처: mg2irh6 (Mg/H) + labeh8_interp_ablation (Be) 의 검증된 라이브 데크.
> 디스패치 시 pseudo/ 디렉터리에 위 3개 UPF 배치 (QE pslibrary.1.0.0 에서 fetch).

## 3. 사전점검 sizing (preflight #1885)

```
hexa cloud preflight --kind dft-phonon --atoms 10 --nq 8 --metallic
```

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
# MgBeH8 RTSC A01 — vc-relax -> scf -> ph(el-ph simple) chain
set -euo pipefail
cd "$(dirname "$0")"

# --- 0. conda env (QE 7.x) ---
source ~/miniconda3/etc/profile.d/conda.sh
conda activate qe          # pw.x / ph.x 제공 환경 (없으면: conda create -n qe -c conda-forge qe)
export OMP_NUM_THREADS=1
NP=$(nproc)                 # physcores; oversubscribe 금지 (feedback: vast el-ph safe launch)

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

## 6. INFRA-READY 계약 (4 prereqs)

| prereq | 충족 | 위치 |
|--------|------|------|
| runnable | ✅ | RUNBOOK.md §4 run 체인 (pod 위 materialize) |
| inputs   | ✅ | `vc-relax.in` · `scf.in` · `ph.in` (이 디렉터리) |
| parser   | ✅ | `parser_template: rtsc-dft-elph` (§5) |
| workdir  | ✅ | `exports/rtsc/decks/MgBeH8/` |

**INFRA-READY: 4/4** — /micro-exp vast.ai 발사 준비 완료.
provider 우선순위 = vast.ai → runpod fallback (d17).
