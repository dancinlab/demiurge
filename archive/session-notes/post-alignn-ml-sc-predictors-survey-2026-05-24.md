# post-ALIGNN ML SC predictors — arxiv survey (2026-05-24)

조사 mission: ALIGNN `jv_supercon_a2F_alignn` d7 wall (ω_log 2-15× under-pred · Tc cap ~4K · sign-pathology) 우회 가능한 후속 ML predictor 가 있는가? path (c) eval.

## 조사된 모델: 6 개 (5 ML SC predictor + 1 SISSO 보조)

## 비교 표

| model | year | data | pressure | arch | output | reported acc | hydride 적용 |
|---|---|---|---|---|---|---|---|
| **ALIGNN a2F** (baseline) | 2022 | JARVIS 818 mat | ambient only | ALIGNN line-graph | α²F(ω) → λ,ω_log,Tc | (d7 wall) | family-wide Tc cap ~4K |
| **BETE-NET** (2401.16611) | 2024 | 818 dyn-stable (DFT α²F) | ambient | E(3)-equiv bootstrap ensemble | α²F(ω) → λ,ω_log,Tc | MAE λ=0.18, ω_log=29K, Tc=2.1K | screening 5× over random; hydride 미보고 |
| **BEE-NET** (2503.20005, BETE-NET 후속) | 2025 | scaled-up DFT α²F + Allen-Dynes labels | not stated as P-aware | Bootstrapped E(3)-equiv GNN ensemble | α²F(ω) → Tc (Allen-Dynes) | MAE Tc=0.87K, TNR=99.4%; 1.3M 구조 screen → 2 신규 실험확인 | 신규 확인 화합물 비공개 hydride 여부 미명시 |
| **BSGNN** (2308.11160) | 2023 | SuperCon DB (~16K) | ambient (composition-DB) | bond-sensitive GNN | Tc 직접 회귀 | MAE 미공개 (bond-length corr) | composition-only, α²F 없음 |
| **XGBoost ensemble** (2512.20228) | 2025 | ~2000 hydride DFT entries | **100-300 GPa** | 30-XGBoost ensemble (composition) | Tc class/regr | ensemble-consistency 기반 | **ternary hydride 명시** — Ca-Ti-H, Li-K-H, Na-Mg-H |
| **GNoME + ab-initio** (2508.19781) | 2025/2026 | GNoME DB → DFT 후속 | **ambient만** (의도적) | ML pre-screen + SCDFT | 25 cubic hydride, Tc | Tc > 4.2K @ ambient | hydride targeted, ambient-pressure |
| **SISSO Tc fit** (2106.05235) | 2021 | Eliashberg theory closed-form | implicit (theory) | symbolic regression | Allen-Dynes 개선식 | high-Tc 영역 Allen-Dynes 능가 | strong-coupling 정정 |

## path (c) eval — post-ALIGNN 우회 가능?

### ω_log under-prediction 우회?
- **BETE-NET**: ω_log MAE=29K reported (ALIGNN 보다 좋을 수 있음) — but ambient-trained, hydride domain shift 미검증 → **conditional**
- **BEE-NET**: ω_log MAE 미보고 (Tc-end-to-end만 reported) — α²F 출력은 유지 → **uncertain**
- **XGBoost (2512.20228)**: composition-only, ω_log 직접 출력 안함 → **no**
- **GNoME pipeline**: ML 은 pre-screen 만, ω_log 는 SCDFT가 계산 → **bypasses ML wall via ab-initio fallback**

### sign-pathology (음수 λ at strong coupling) 회피?
- BETE-NET / BEE-NET: equivariant ensemble + α²F 전체 곡선 출력 → in-principle phonon-DOS-resolved. 그러나 ambient 818-mat 학습 → strong-coupling hydride extrapolation 보장 없음 → **conditional**
- **XGBoost (2512.20228)** = ternary hydride 100-300 GPa 학습 → **sign-pathology 영역에 직접 학습됨** → **yes (단 α²F 자체 미출력, Tc/class 만)**
- BSGNN / SISSO: λ 직접 모델 아님 → **N/A**

### pressure-variable retrain 필요?
- 거의 모든 α²F-출력 모델 (BETE-NET, BEE-NET, ALIGNN) = ambient 학습
- **유일 pressure-aware = XGBoost ensemble (2512.20228)** — but composition feature only, α²F 잃음
- **결론: path (c) 단독 우회 불가능, path (i) pressure-variable retrain 필수.**
  - 단 BEE-NET / BETE-NET 의 equivariant ensemble code-base 를 hydride α²F 데이터 (~수백 점) 로 fine-tune 하는 것이 가장 빠른 path

## 추천 (2개)

1. **BEE-NET (2503.20005)** — ALIGNN 직계 successor, equivariant ensemble, Tc MAE 0.87K @ ambient. 코드/데이터 공개 (Hennig group). hydride α²F 로 fine-tune 시도가 path (c)+(i) 최소비용 entry-point. ω_log under-pred 측정치 미공개라 1차 sanity 필요.
2. **2512.20228 XGBoost hydride ensemble** — 직접적으로 high-pressure ternary hydride 학습, Ca-Ti-H / Li-K-H / Na-Mg-H 후보 목록. α²F 잃지만 Tc cap ~4K wall 회피 증거 제공 (high-P regime). h3o/h3po sign-pathology 검증용 reference 로 사용.

## 출처
- 2401.16611 (BETE-NET, Gibson 2024)
- 2503.20005 (BEE-NET, Gibson 2025)
- 2308.11160 (BSGNN, Gu 2023)
- 2512.20228 (XGBoost ternary hydride, Tokuyama 2025)
- 2508.19781 (GNoME ambient hydride, Sanna 2025)
- 2106.05235 (SISSO Allen-Dynes, Xie 2021)
