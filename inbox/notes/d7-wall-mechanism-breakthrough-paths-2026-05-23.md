# d7 wall mechanism — ω_log under-prediction breakthrough paths

**status**: archive (inline triage, /gap full nested 회피)
**scope**: ambient-ML (ALIGNN) 고압 H-derived 고진동 모드 missing → ω_log 15× under wall
**evidence**: cycle 4-5 H₃Cl per-candidate audit — ALIGNN λ=0.81 vs DFT λ=1.27 (+57% gap on λ) BUT ω_log 81 K vs 1252 K (**15× under**) — ω_log axis 가 dominant failure mode

---

## headline finding

- λ axis 가 아니라 **ω_log axis 가 dominant ML failure**
- Tc ∝ ω_log × f(λ, μ*) — ω_log 15× under → Tc 1/15 prediction (ML 2 K vs DFT 100 K)
- root cause 가설: ambient-pressure training data 에 **고압 hydride 고진동 phonon mode (1000+ K) 부재**
- d7 governance: "first-principles physics breaks the ML training-distribution wall" — ML 추가 학습보다 DFT 가 정공법, 단 ML breakthrough path 도 병렬 surface

## breakthrough paths brainstorm (10)

### (a) ALIGNN training data extension — high-pressure hydride retrain
- JARVIS-SuperconDB + 새로 합친 H₃X DFT 결과 (H₃S, H₃Se, H₃Te, h3o, h3p 등) retrain
- evidence: 현재 ALIGNN-FF 가 ambient pressure 만 본 — 직접 시도 없음
- cost: GPU pod 1-2일 retrain · feasibility: 높음 (data 모일수록)

### (b) physics-informed loss — α²F(ω) high-ω tail 가중치
- α²F spectrum 의 high-ω tail (> 800 K) 에 loss weight × 5
- evidence: 일반 MSE loss 는 low-ω dominant 평균 흡수 → high-ω missed
- cost: loss 수정만 (1일) · feasibility: 중간 (정상화 까다로움)

### (c) BETE-NET ensemble — alternative GNN architecture
- ALIGNN 단일 모델 외 BETE-NET, M3GNet, MACE 등 비교
- evidence: BETE-NET 노트 `2026-05-22-bete-net-7-candidate-benchmark.md` 진행 — 결과 미상
- cost: BETE-NET 활성화 + 7-cand 통과 (이미 진행 중) · feasibility: 높음

### (d) phonon-DOS 분리 prediction — λ 와 ω_log dual-head
- 단일 Tc head 가 아니라 (λ, ω_log) 별도 head + 합산은 Allen-Dynes formula
- evidence: single-target prediction 의 averaging bias 회피 가설
- cost: architecture 변경 (3-5일) · feasibility: 중간

### (e) feature engineering — H-X bond length · vibrational reduced mass μ_HX
- 입력에 explicit H-X bond length, μ_HX = (m_H × m_X) / (m_H + m_X) 추가
- evidence: 고진동 모드는 short bond + light H → bond-length-aware feature 직접 도움
- cost: feature pipeline 수정 (1-2일) · feasibility: 높음 (low-hanging)

### (f) graph transformer for atom embedding (long-range dependency)
- GNN message passing 의 short-range bias → transformer self-attention 으로 대체
- evidence: 고압 hydride 의 collective mode 는 multi-atom 협력 → long-range 필요 가설
- cost: 모델 교체 (1주) · feasibility: 낮음 (대형 작업)

### (g) DFT-emulator (ALIGNN-FF) phonon 모듈 직접 호출
- ALIGNN-FF (force field) 로 phonon DOS 직접 계산 → α²F 적분
- evidence: end-to-end Tc prediction 대신 phonon 단계까지만 ML
- cost: ALIGNN-FF integration (3-5일) · feasibility: 중간 (FF accuracy 의존)

### (h) hybrid ML+DFT — ML screen → DFT 정밀
- ML 가 candidate 빠른 screening (low-cost) → top-N 만 DFT 정밀
- evidence: 이미 현재 워크플로우의 사실상 모드 (RTSC §9.x sweep) · 정량화만 필요
- cost: 워크플로우 정리만 (0.5일) · feasibility: 매우 높음 (이미 사실상 진행 중)

### (i) atom embedding 에 압력 변수 추가 (P missing feature)
- 현재 ALIGNN 입력에 압력 (GPa) 명시적 변수 없음 — atom embedding 에 P 추가
- evidence: 고압 hydride 의 핵심 distinguishing variable 부재 = 직접 root cause
- cost: feature + retrain (3-5일) · feasibility: 높음

### (j) feedback loop — DFT 결과 매번 학습 데이터에 합쳐 incremental update
- 각 cycle DFT 결과 (h3o, h3p, h3cl, …) 자동 학습 데이터 합산 → online learning
- evidence: 현재 single-shot · feedback 없음 — RTSC sweep 자체가 data factory
- cost: pipeline 설계 (1주) · feasibility: 중간 (data versioning 까다로움)

## 추천 ranking

**1순위 = (e) feature engineering — H-X bond length + μ_HX**
- low-hanging fruit (1-2일) · root cause 직접 타겟 (short bond → 고진동) · retrain 불필요 (feature-only)
- 즉시 검증 가능 — 현재 5-cand sweep 데이터로 fitting test

**2순위 = (i) pressure feature + retrain**
- 고압 hydride 의 missing variable 직접 보강 · evidence-strong (P 가 핵심 distinguishing)
- 단점: retrain 필요 (GPU 1-2일)

### 보류 (low priority)
- (f) graph transformer — 작업량 대비 evidence 약함
- (j) feedback loop — data versioning 인프라 부재 시 비용 큼

## d7 governance 위치

- d7 = "first-principles physics breaks the ML training-distribution wall" → **DFT 가 정공법 (현재 RTSC §9.x sweep 가 이미 그 길)**
- 본 노트의 (a)–(j) = **ML breakthrough path 의 병렬 후보**, DFT 의 대체가 아니라 보완
- 즉시 액션: (e) bond-length feature → 1-2일 안에 답 나옴 · DFT sweep 와 병렬 진행 가능

## 연관

- `h3cl-d7-wall-breakthrough-2026-05-23.md` — H₃Cl 사례 발견 노트 (이 노트의 root data)
- `h3o-novel-191k-group16-sweet-spot-2026-05-23.md` — d7 wall 재확인 (h3o ML 0.48 vs DFT 2.48)
- `2026-05-22-d2-pressure-aware-ml-survey.md` — 압력-aware ML survey (path i의 background)
