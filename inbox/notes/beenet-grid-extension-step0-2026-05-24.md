# BEE-NET phonon-DOS grid 천장 101→141 meV 확장 — §10.3 step0 BLOCKER

**status**: ✅ 해소 · **scope**: code 분석 + grid 확장 + CPU smoke (학습/GPU 없음)
**repo**: `henniggroup/BETE-NET` (arXiv **2401.16611** — 설계노트의 2503.20005 와 불일치, 정정 요)
**clone**: `/tmp/betenet` (blobless `--filter=blob:none`, 300×.pt ensemble 미다운 — code만)

## 1. grid ceiling 정의 위치

| 무엇 | 파일:라인 | 값 |
|---|---|---|
| **출력 grid (천장 결정)** | `utils/data.py:15` | `Freq_final = np.arange(0.25,101,2)` → **51 bin**, max **100.25 meV** |
| 보간 fine grid | `utils/data.py:121,132,163` | `xl = np.arange(0.25,101,0.1)` (×3) |
| 학습 weight grid | `utils/training.py:140` | `np.arange(0.25,101,2.)` (주석) |
| out_dim 전파 | `notebooks/Train_FPD.ipynb` cell4/5 | `out_dim=len(target)`, `irreps_out=f"{out_dim}x0e"`, `in_dim=118+51` |

→ 천장은 `Freq_final` 단 1곳이 SSOT. 설계노트가 지목한 `np.arange(0.25,101,0.1)` 는 보간 중간 grid 일 뿐 — **실제 출력 grid 는 step=2 의 51-bin** (107.9 meV h3cl mode 가 표현 bin 없음 = root cause 확정).

## 2. grid 확장 (101→141 meV)

- `Freq_final` → `np.arange(0.25,141,2)` = **71 bin**, max **140.25 meV** (step=2 유지 = append-only)
- `xl` ×3 → `np.arange(0.25,141,0.1)`
- **첫 51 bin 완전 동일** (np.allclose PASS) → backbone 전이 안전
- 추가 20 bin 이 100–140 meV 커버 (h3cl 107.9 · h3o 94.5 H-stretch 표현 가능)
- 변경 파일: `/tmp/betenet/utils/data.py` (demiurge/hexa-lang 외부 · 4줄)

## 3. pretrained 호환성 (FPD_100.pt state_dict 실측)

| layer | pretrained shape | 확장 후 | 조치 |
|---|---|---|---|
| `em.weight` | (64, **169**) =118+51 | 118+71=**189** | **re-init** (입력폭 변경) |
| `layers.2` final conv (`sc/lin2`) | out=**51** | **71** | **re-init** (출력폭 변경) |
| `layers.0`, `layers.1` 내부 conv | hidden mul=32, l≤1 | 불변 | **FREEZE** 가능 (25 tensor) |

- **전략 = backbone(layers.0/1) freeze + {em, layers.2} re-init** transfer learning.
- 추가 발견: 공개 ensemble 은 **base `PeriodicNetwork`** (no `output.` head). `PeriodicNetworkPhdos` 의 `output=Linear(out_dim*2,out_dim)` phdos-concat head 는 학습노트 변형 — fine-tune 시 신규 head 라 어차피 fresh init (확장과 무관).

## 4. CPU smoke test 결과 (venv `/tmp/beenet_venv`, torch2.8cpu·e3nn0.6·pyg2.6·scatter2.1·cluster1.6)

`/tmp/betenet/smoke_grid_extension.py` — 전 4단계 PASS:
- [grid] 71 bin / 140.25 meV / 첫51 동일 ✅
- [pipe] `get_target` → (71,), **a²F≥0 clamp 동작** (min=0.0), 합성 108 meV peak 가 신규 21 bin 에 mass 3.84 ✅
- [arch] `PeriodicNetworkPhdos(in_dim=189,out_dim=71)` 빌드, head Linear **142→71** ✅
- [fwd] SH₃ 합성셀 forward → out **(1,71)**, **전부 a²F≥0** (relu clamp) ✅

## 5. step0 BLOCKER verdict

# ✅ 해소

grid 천장 확장이 1-file(`Freq_final`) 변경으로 architecture(in_dim·out_dim·head) 까지 정확히 전파됨을 정적+동적(forward)으로 검증. sign-pathology a²F≥0 clamp 도 확장 grid 에서 그대로 동작. step1–5 의 전제(>100 meV bin 존재)가 충족됨.

## 6. step1–5 GPU retrain readiness + GPU-hr

| step | readiness | GPU-hr |
|---|---|---:|
| 1 pretrained load | ⚠ ensemble 전체 .pt 미다운(blobless). full clone 또는 .pt 선택다운 필요 | 0.5 |
| 2 DFT→a2F target | ph.out 파싱 필요(a2F.dos 미덤프) | 1 (CPU) |
| 3 μ_HX·bond·pressure 주입 (l=0 scalar) | grid 확장으로 자리 확보, 코드만 | 0 |
| 4 fine-tune (backbone freeze + em/layers.2 re-init, EMDLoss, LOO-CV) | **확장 완료로 unblock** | 8–16 |
| 5 sanity gate G1–G3 | — | 1 |

**총 ~11–19 GPU-hr** (A100 1장 ~1일). 5 DFT 점은 domain-adaptation smoke 수준 — 일반화엔 공개 high-P hydride α²F augment(~50–100점) 권장. **GPU 학습은 별도 사용자 결정** (본 작업은 step0 code+CPU 한정).
