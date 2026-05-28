# PROVIDERS — 친근 비교 (easy 모드)

> 컴퓨팅 서비스를 비유 + ASCII + 표로 풀어쓴 가이드. 데이터 SSOT = 글로벌 `hexa cloud providers list|fit|recommend` (`~/.hx/cloud/providers.json`) · 분석 = [`domains/rtsc.compute_services.md`](./domains/rtsc.compute_services.md).

## 🚗 vast.ai vs ☁️ AWS — "동네 PC방 vs 슈퍼컴 부스"

- **하는 일**: 둘 다 원격 컴퓨터를 빌려 DFT 돌림
- **비유**: vast = 24시 PC방(싸고 즉시) · AWS hpc7a = 전문 슈퍼컴 부스(비싸지만 빠르고 안정)

### 한 컷 ASCII

```
                vast.ai                    AWS hpc7a-96xl (spot)
   ┌─────────────────────────┐         ┌─────────────────────────┐
   │ 🖥️ 80 vCPU 일반 desktop   │         │ 🚀 192 vCPU AMD Genoa    │
   │   다양한 품질·세대        │         │   AVX-512 · 768MB L3    │
   │                          │         │                          │
   │ 🔌 일반 Ethernet         │         │ 🔥 EFA 300 Gbps low-lat  │
   │   (MPI all-to-all 병목)  │         │   (MPI 이상적 scaling)  │
   │                          │         │                          │
   │ 💰 $0.10-0.30/c-hr       │         │ 💰 $2/hr spot (~$0.01/c) │
   │   = 매우 쌈              │         │   = 시간당 비쌈, 코어당↓  │
   │                          │         │                          │
   │ ⏱️ 잡당 22h (Mg₂IrH₆)    │         │ ⏱️ 잡당 5-9h (2-4× 빠름) │
   │                          │         │                          │
   │ ✅ hexa cloud 완비       │         │ ⏳ ssh+adopt 우회 필요    │
   │ ⚡ 5분 만에 발사          │         │ ⚙️ IAM/VPC/EFA 셋업 1회  │
   └─────────────────────────┘         └─────────────────────────┘
```

### 축별 직접 비교

| 축 | vast.ai 80c | AWS hpc7a 192c (spot) | 의미 |
|---|---|---|---|
| 코어 | 80 일반 | 192 Genoa AVX-512 | AWS 코어당 1.5-2× 빠름 |
| 인터커넥트 | Ethernet | EFA 300 Gbps | MPI 4-8 노드 stacking 시 AWS 압도 |
| 메모리 L3 | ~32 MB | **768 MB** | DFT 큰 행렬에 결정적 |
| 시간 (22h 잡) | 22h | 5-9h (3-4×) | hpc7a 가 일·주 단위 단축 |
| 시간당 $ | ~$3-8/h (80c) | $2/h spot | AWS 시간당 쌈 |
| 잡당 총 $ | ~$70-180 | ~$10-18 | **AWS 가 코어 효율 ↑ → 더 쌈!** |
| 안정성 | 가끔 interrupt | spot 도 90%+ 완주 | AWS ↑ |
| 셋업 시간 | 5분 | 2-4h (1회만) | vast ↑↑ (즉시성) |
| hexa cloud | ✅ 완비 | ⏳ ssh-form 우회 | vast ↑ (현 워크플로우 호환) |
| reliability | Spot-style 인터럽트 | EFA + Genoa 안정 | AWS ↑ |

### 시나리오별 추천

| 시나리오 | 추천 | 이유 |
|---|---|---|
| 소규모·다잡 (16잡 maintenance) | vast.ai 유지 ← 현 캠페인 | 즉시·싸다 |
| 하드 잡 walltime 압박 (22h+ Mg₂IrH₆) | AWS hpc7a | 22h → 5-9h, 잡당 $ 도 더 쌈 |
| 짧고 많은 시도 (decay 짧음) | vast.ai | 즉시 발사 + cheap |
| 장기 단일 큰 잡 | AWS hpc7a | walltime 안정 + spot 90%+ 완주 |

### 실전 결합 패턴

```
   유지 (vast)                추가 (AWS, 필요 시만)
   ──────────────────         ────────────────────
   16잡 일반 grinding   ──┐
   srauh3·cabeh8       ──┤   (특별 트리거 시만)
   wave-3 시리즈       ──┤   ↓
   wave-4 dispatch     ──┤   AWS hpc7a spot
                       ──┤   ──────────────────
                          │   • Mg₂IrH₆-class 22h 잡
                          │   • Kagome-H3 큰 k-grid
                          │   • TBL-YH3 8×8×8 q
                          ↓   • Quench/strain (정밀 요구)
                       vast 충분               AWS 가치
```

### 한 줄 결정 규칙

- 잡 walltime < 12h + 코어 < 80c 필요 → **vast** (직관·즉시·싸다)
- 잡 walltime > 12h or 큰 q-grid + 코어 > 100c → **AWS hpc7a spot**
- 압박 없음 = vast 기본 · 압박 있음 = AWS 보조

### honest 수치 비교 (대략)

```
Mg₂IrH₆ 동일 잡 (22h on vast 80c) — vast vs AWS hpc7a spot
   vast 80c × 22h × $0.20/c-hr = $352, 22h
   AWS 192c × 9h × $2/h spot   = $18,  9h
   → AWS 가 2.4× 빠르고 19× 저렴 (spot 가정, 큰 잡 한정)

YH10-class 일반 잡 (10h on vast 16c) — vast vs AWS
   vast 16c × 10h × $0.15/c-hr = $24, 10h
   AWS 192c × 4h × $2/h spot   = $8,  4h (스케일링 손실 보수적)
   → AWS 가 2.5× 빠르지만 $24 → $8 동급 절약
```

## 🚀 RunPod — "vast 의 형제"

- **하는 일**: vast 와 비슷한 GPU/CPU 렌탈, 안정성·UX 더 좋음
- **비유**: 같은 PC방 체인의 더 깔끔한 지점
- 차이: H100/A100 GPU 옵션 많음. CPU 가격은 vast 비슷.
- **결정**: GPU 가속 DFT(QE-GPU) 가 필요하면 RunPod H100 ★

## 🏛️ NSF ACCESS / KISTI — "학술 무료 풀"

- **하는 일**: 학술 신청으로 대형 HPC 무료 사용
- **비유**: 대학 도서관처럼 입회만 하면 큰 자료실 무료 이용
- 신청: 1-4주, 1년치 무료
- **결정**: 6+개월 장기 캠페인이면 proposal 병행 가치

## 📌 정리

```
이번 RTSC 캠페인 = vast.ai 충분 ✅
다음 wave (큰 잡 들어오면) = AWS hpc7a spot 보조 추가
GPU 가속 신메커니즘 (Kagome·TBL) = RunPod H100
장기 = NSF ACCESS proposal 병행
```

세부 데이터·쿼리는 글로벌 `hexa cloud providers list|fit|recommend` (`~/.hx/cloud/providers.json`), 정량 분석은 [`domains/rtsc.compute_services.md`](./domains/rtsc.compute_services.md) 참조.
