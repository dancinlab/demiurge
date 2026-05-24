# d7 wall — BEE-NET fine-tune POC entry 설계 + ALIGNN α²F 결손 분석

**status**: design (scaffold only · 실제 학습 미실행) · **scope**: cycle 8 d7 wall path (e)/(i)
**근거**: 5 LANDED DFT (`~/etc/rtsc-results/{h3o,h3po,h3cl,h3f,h3si}`) + ALIGNN predict.json + BEE-NET(arXiv:2503.20005, henniggroup/BETE-NET)

---

## 1. ALIGNN α²F frequency-resolved 결손 (read-only 정량)

ALIGNN a²F 출력 = **100-bin, 0–100 meV grid** (bin center 0.5…99.5 meV, dw=1 meV — `alignn_h3cl_run.py` L105). 이게 root cause: H-derived stretching mode 가 **grid 천장(100 meV) 위**에 산다.

| cand | DFT ω_log (K) | DFT ω_log (meV) | ML ω_log (K) | a²F hi-band(60–100meV) | grid 천장 초과? |
|---|---:|---:|---:|---:|:---:|
| h3cl | 1251.7 | **107.9** | 81.5 | **−0.342** (음수 수렴) | **YES** |
| h3o | 1096.6 | **94.5** | 0.0 | +2.753 | ceiling 직전 |
| h3po | 265.2 | 22.9 | 0.0 | +1.938 | no |
| h3f | 658.6 | 56.8 | 80.6 | +1.134 | no |
| h3si | 590.1 | 50.9 | 285.7 | **−0.370** (음수 수렴) | no |

**결손 정량**: DFT ω_log 가 천장(100 meV)을 넘는 h3cl(107.9)·근접 h3o(94.5)는 high-ω H-stretch peak 를 **그릴 grid 자체가 없음**. h3cl·h3si 는 60–100 meV 밴드 a²F 합이 **음수로 수렴** (−0.34, −0.37) → high-ω amplitude 가 0 이 아니라 *음수*로 빠짐 = 가장 심한 결손 형태.

## 2. Sign-pathology 메커니즘 (음수 λ 의 bin 위치)

음수 λ 의 출처는 high-ω 가 **아니라** soft-ω(저주파) bin. λ density = 2·a²F/ω·dw 에서 1/ω 가중이 ω→0 의 음수 a²F 를 폭증시킨다:

| cand | ML λ | 최대-음수 bin (ω, a²F, λ_dens) | 2번째 음수 bin |
|---|---:|---|---|
| h3o | **−0.417** | **0.5 meV**, a²F=−0.122, λ_dens=**−0.489** | 2.5 meV, a²F=−0.472, λ_dens=−0.377 |
| h3po | **−0.213** | **0.5 meV**, a²F=−0.161, λ_dens=**−0.645** | 2.5 meV, a²F=−0.181, λ_dens=−0.145 |

→ sign-flip 은 ALIGNN a²F head 가 **acoustic edge(0.5–2.5 meV)에 음수 amplitude** 를 산출 → 1/ω 가중으로 λ 전체를 음수로 끌어내림. high-ω 누락(§1)과는 **별개의 결손 채널**. (h3o neg-λ-contrib −1.19 의 82%가 0.5–2.5 meV 두 bin.)

## 3. BEE-NET POC entry plan (5 step)

repo `henniggroup/BETE-NET` (BEE-NET 동거): 모델 dir CSO/CPD/FPD 각 **100-member bootstrap ensemble** (.pt), entry = `notebooks/Pred_*.ipynb` / `Train_*.ipynb`, code = `utils/{model,data,training}.py`. 스펙트럼 head = `PeriodicNetworkPhdos`, loss = `EMDLoss`(earth-mover)+`weighted_MSELoss`. conda(py3.9·torch1.10·cu113·torch-geometric).

| step | 내용 | GPU-hr |
|---|---|---:|
| **0** | **[BLOCKER] grid 천장 확장** — `utils/data.get_target` 의 `np.arange(0.25,101,0.1)` → ~140 meV. 안 하면 h3cl/h3o high-ω 표현 불가 | 0 (코드) |
| 1 | pretrained FPD ensemble load (100 .pt) | 0.5 |
| 2 | 5 DFT 결과 → α²F target. **차질**: ph.out 만 있고 a2F.dos 미덤프 → (2a) ph.out 파싱 필요 or (2b) Lorentzian 대용 smoke-test | 1 (파싱) |
| 3 | feature 주입 — μ_HX·bond length [path e] + pressure [path i] 를 l=0 그래프 scalar 로 (E(3)-equiv 보존) | 0 (코드) |
| 4 | fine-tune (FPD readout freeze-partial · LOO-CV across 5 · EMDLoss) | 8–16 |
| 5 | sanity gate G1(hi-ω mass>0) · G2(λ>0 for h3o/po/n) · G3(ω_log within 2×) | 1 |

**총 ~12–20 GPU-hr** (A100 1장 ~1일). data 5점은 domain-adaptation smoke-test 수준 — 일반화엔 공개 high-P hydride(H3S·LaH10·CaH6·H3Se) α²F augment 로 ~50–100점 확보 필요.

## 4. path (e) vs (i) 추천

- **BEE-NET 의 두 구조적 이점** (ALIGNN 대비): ① a²F target 이 **≥0 clamp** (`get_target`) → §2 sign-pathology 를 **구조적으로 못 만든다** = 3/9 음수-λ 자동 치유. ② EMDLoss = high-ω mass 보존(notes path b 무료 내장).
- **그러나 grid 천장은 ALIGNN 과 동일(~101 meV)** → §1 high-ω 결손은 BEE-NET 도 그대로 → **step 0 확장 없으면 path (i) 단독으로도 못 고침**.

**추천 = (e) 우선, (i) 동반**. μ_HX·bond length [path e] 는 step 0+3 코드만으로 high-ω peak 위치를 모델에 직접 알려줌 (root cause = short bond·light μ → high stretch). pressure [path i] 는 같은 l=0 주입 자리라 **한계비용 0** — 함께 넣는다. retrain GPU 비용(step 4)은 (e)/(i) 공통이므로 **분리할 이유 없이 묶어서** 1회 fine-tune. **단 step 0 grid 확장이 진짜 blocker** — 이게 없으면 (e)·(i) 둘 다 무효.

**결과 파일**: `/tmp/beenet_hydride_finetune_poc.py` (scaffold 작성·실행금지) + 본 md.
