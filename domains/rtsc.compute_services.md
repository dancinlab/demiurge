# RTSC — 컴퓨팅 서비스 분석 (vast.ai 외 · walltime 단축 · 2026-05-28)

> 본 문서는 RTSC DFT el-ph 캠페인에 적합한 **vast.ai 외 컴퓨팅 서비스** + **walltime 단축 기법** 을 정리한다. 현 캠페인 구성: QE pw.x/ph.x · CPU-heavy MPI · ~16잡 동시 · 압력·구조별 9-22h+ walltime.

## A. vast.ai 직접 대안 (CPU pod 렌탈)

| 서비스 | 특징 | $/CPU-hr (대략) | RTSC 적합성 |
|---|---|---|---|
| **RunPod** | 이미 hexa cloud 지원, CPU+GPU 혼합 | $0.10–0.50 | ★★★ — vast 동급, 다양한 instance |
| **Tensordock** | 분산 GPU + CPU, 저가 | $0.05–0.20 | ★★ — 가격 우위, 안정성 변동 |
| **Hyperstack** | UK GPU cloud, NVMe 빠름 | $0.20–0.60 | ★★ — EU 데이터 거주성 필요 시 |
| **Massed Compute** | 저가 GPU, 학생 친화 | $0.10–0.30 | ★★ — H100 cheap, CPU 옵션 약함 |
| **Paperspace (Core/Gradient)** | GPU 중심 | $0.30–1.50 | ★ — DFT 보단 ML |
| **Salad Cloud** | 분산 소비자 GPU, 매우 저렴·저우선 | $0.02–0.10 | ★ — 인터럽트 빈번, 짧은 잡 only |
| **Voltage Park** | H100/H200 전용 | $1.50–3.00 | GPU 가속 시 검토 |
| **Crusoe Cloud** | 메탄가스 → GPU, ESG | $0.80–2.50 | GPU 가속 시 |
| **Genesis Cloud** | EU GPU | $0.50–1.50 | EU 거주성 |
| **CoreWeave** | 엔터프라이즈 GPU | $2–4 | 대형 H100 클러스터 |

## B. HPC-tier (walltime 단축 최강)

QE el-ph 의 병목 = MPI all-to-all + memory bandwidth. **InfiniBand/EFA** 인터커넥트 + **고대역 RAM** 이 핵심.

| 서비스 | instance | vCPU | 인터커넥트 | $/hr | RTSC walltime 영향 |
|---|---|---|---|---|---|
| **AWS EC2 hpc7a-96xlarge** | AMD EPYC 9R14 (Genoa) | 192 | EFA 300 Gbps | ~$8 (on-demand) / ~$2 (spot) | ★★★ **3-5× 단축** vs vast 80c (큰 q-grid 에서 결정적) |
| AWS hpc6a.48xlarge | AMD EPYC 7R13 (Milan) | 96 | EFA 100 Gbps | ~$3 / ~$1 spot | 2-3× 단축 |
| **Azure HBv4** | AMD EPYC 9V33X (Genoa-X 768MB L3!) | 176 | NDR400 IB | ~$10 / ~$3 spot | ★★★ **MEMORY-BOUND DFT 에 최강** (Genoa-X 의 큰 L3) |
| Azure HBv3 | AMD EPYC 7V73X (Milan-X) | 120 | HDR200 IB | ~$5 / ~$1.5 spot | 2-3× 단축, L3 768MB |
| **GCP C3-highcpu / C2D** | AMD EPYC Genoa | up to 360 | gVNIC 200 Gbps | ~$5–10 | ★★ — IB 없음, BUT 코어 수 ↑ |
| Oracle Cloud HPC2 | Intel Xeon | 36 | RDMA 100 Gbps | ~$2 | ★★ — 가성비 |

**핵심**: hpc7a 또는 HBv4 spot ($2-3/hr) → vast.ai 80c 대비 **3-5× walltime 단축** + **MPI scaling 안정**. Mg₂IrH₆ 같은 22h+ 잡이 5-7h 로 줄어듦.

## C. GPU-accelerated DFT (QE-GPU · 10x+)

QE 7.x 가 NVIDIA CUDA 지원. el-ph 의 dvscf/calphi 단계가 GPU 친화적.

| 서비스 | GPU | $/hr | RTSC el-ph 영향 |
|---|---|---|---|
| **RunPod H100 80GB** | NVIDIA H100 | $2-4 | ★★★ **10×+ 단축** (큰 k-grid·dense q 잡) |
| RunPod A100 80GB | A100 | $1-2 | 5-7× |
| Lambda Labs H100 | H100 | $2-3 | ★★★ 동급 |
| AWS p5.48xlarge | 8× H100 | ~$98 / ~$30 spot | ★★ — multi-GPU 큰 잡 |
| TensorDock H100 | H100 | $1.5-2.5 | ★★ |

**제약**: QE-GPU 빌드 + 호환 deck (pseudo·k-grid). 첫 셋업 cost ↑ 단 후속 잡 walltime 압도적.

## D. 학술/무료 (allocation 신청 필요)

| 프로그램 | 자원 | 신청 | RTSC 적합 |
|---|---|---|---|
| **NSF ACCESS** (구 XSEDE) | TACC Frontera·SDSC Expanse 등 | proposal (1-2주) | ★★★ — 미국 학술 무료, 큰 노드 풀 |
| **DOE INCITE** | Frontier·Aurora exascale | 경쟁 신청 (연 1회) | 큰 캠페인용 |
| **EU PRACE / EuroHPC** | LUMI·Leonardo 등 | proposal | EU 거주성 |
| **KISTI Nurion** (Korea) | Knights Landing | 학술 신청 | 한국 학술 ★★ |
| **KISTI-5** | 신규 시스템 | proposal | 한국 학술 |
| **NHR / GENCI / CINECA** | 독·프·이 학술 HPC | proposal | EU 학술 |

**비용 $0** 단 신청·승인 시간(1-4주) 소요. **다음 cycle 계획**에 포함 권장.

## E. Walltime 단축 — $ 무관 software tip

비용 안 들이고 walltime 즉시 줄이는 방법.

### E1. QE 빌드 최적화
- **AVX-512 활성 빌드** (Intel/AMD Genoa) → **20-40% 빠름** vs 기본 빌드
- ELPA / ScaLAPACK 활용 (특히 큰 행렬 diag)
- Apptainer/Singularity image 로 packaging → 어느 클라우드에서도 같은 성능

### E2. 파라미터 튜닝
- `-npool N` 정확히 k-point 수와 일치 (불균형 시 idle CPU 발생)
- `-ntg M` (task-group) — pw 계산에서 FFT 병렬화 (보통 4-8)
- OpenMP hybrid: `-np 8 -ntg 4` + `OMP_NUM_THREADS=4` (메모리 절약 + 코어 활용)
- `electron_phonon='interpolated'` (vs 'simple'): coarse q 로 ph 후 Fourier interp → **5-10× 빠름**
- `lqdir = .true.` (#1701 h3cl interp ablation 가 이미 사용) — q-별 디렉터리 분리

### E3. 사전 점검
- **`cloud preflight --kind dft-phonon`** (#1885) — 발사 전 walltime 정확 추정. under-size 경고
- d16 dry-run (commons) — 1-iter 검증, syntax/PATH 오류 선차단
- 동일 deck 의 이전 결과 lookup → q-grid 외삽

### E4. 데이터 재사용
- `pseudo/` UPF 풀 공유 (모든 잡에 mount)
- 동일 구조의 EOS 결과 재사용 (e.g. CaH6 압력 scan 의 SCF 캐시)

## F. 현 캠페인 추천 조합

| Tier | 용도 | 서비스 | 예상 비용 (월) | 효과 |
|---|---|---|---|---|
| **유지** | 일반 16잡 grinding | vast.ai (현재) | $200-400 | 안정 |
| **추가 1** | 하드 잡 walltime crunch | AWS hpc7a spot ($1-2/hr × ~50h/월) | $50-100 | Mg₂IrH₆-class 22h → 5-7h |
| **추가 2** | el-ph 큰 잡 | RunPod H100 + QE-GPU (필요 시) | $50-200 | dense q-grid 10× 단축 |
| **장기** | next cycle 무료 풀 | NSF ACCESS proposal | $0 | 1년치 학술 무료 (승인 시) |

**즉시 적용 가능**:
- E1 AVX-512 빌드 (1-2h 작업, 영구 효과)
- E2 npool/electron_phonon=interpolated (deck 1줄, 즉시 5-10× 빠름)
- E3 cloud preflight (#1885 이미 머지)

## G. hexa cloud 통합 상태

| Provider | hexa cloud 지원 | 통합 비고 |
|---|---|---|
| vast.ai | ✅ 완비 (rent/down/list/exec/nohup/tail · #1864·#1883·#1885·#1889 등) | 현 1순위 |
| RunPod | ✅ 완비 | 즉시 추가 사용 가능 |
| AWS / Azure / GCP HPC | ⏳ 미구현 (대용 sshd 직접 또는 awscli) | 추가 시 INBOX 갭 (g60) |
| Lambda / Paperspace / 기타 | ⏳ 미구현 | 추가 시 INBOX 갭 |

**hexa cloud 미지원 provider 사용 시**: ssh-form host (`ec2-user@<ip>`) 직접 사용 + `hexa cloud adopt` 로 registry 등록. `--source ~/qe-env.sh` 로 env 보장(#1864 이미 작동).

## H. 우선순위 결정 가이드

| 상황 | 추천 |
|---|---|
| **현 캠페인 maintenance** (16잡 + 추가 5-10) | vast.ai 유지로 충분 |
| **하드 candidate 단축** (Mg₂IrH₆/q-grid 큰 잡) | hpc7a spot 1-2 노드 추가 |
| **A37 Kagome-H3 같은 신메커니즘 탐사 (큰 k-grid)** | H100 + QE-GPU |
| **장기 학술 캠페인** (6+ 개월) | NSF ACCESS proposal 동시 진행 |
| **첫 ambient verdict (srauh3/cabeh8) 대기** | 현 vast 유지 (이미 막판) |

---

## 참조

- 현 hexa cloud 통합: PR #1864 (--source) · #1883 (host-guard) · #1885 (preflight walltime) · #1887 (forget) · #1889 (tail 3-tier)
- 캠페인 첫 verdict: YH₁₀ #486 · atlas #1909
- /system 0.9.0 watch 위임 (#216)
