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
- `h3br-critical-test-2026-05-24.md` — group-17 mid-heavy halide outlier (ALIGNN λ=1.11) DFT 도착 시 cross-check 가설

---

## update 2026-05-24 — ALIGNN family-wide 9/9 결과 통합 (cycle 6 + 7)

cycle 6 + 7 합쳐 9/9 H₃X family-wide ALIGNN per-candidate baseline 완주 (artifacts `~/etc/rtsc-results/{h3o,h3po,h3f,h3si,h3cl,h3p,h3n,h3as,h3br}/`). RTSC.md §9.14 의 신설 sub-section "ALIGNN family-wide d7 wall ML baseline (9/9 후보)" 가 SSOT.

### 신규 발견 #1 — Sign-pathology **family-wide 3/9** (light X covalent localization)

cycle 4 (h3cl 만) → cycle 5/6 의 group-16 (h3o, h3po 2개 sign-flip 발견) → cycle 7 의 **H₃N 추가 발견** 으로 family-wide 3/9 패턴 확정:

| candidate | group | celldm | ALIGNN λ | Tc-direct (K) |
|---|:---:|---:|---:|---:|
| H₃O | 16 | 4.90 | −0.42 | 4.34 |
| H₃Po | 16 | 6.24 | −0.21 | 3.69 |
| H₃N | 15 | 5.50 | **−0.18** (신규) | 5.97 |

**공통 axis** (3 cand): light X anion (O 16 · N 14 · Po 209-mass 는 polar high-Z 예외) · short H-X covalent bond · ALIGNN a²F projection 이 anti-bonding 방향 → λ 음수 → ω_log degenerate (0) → Allen-Dynes path 무효, direct-Tc head 만 유효 (4-6 K cap).

**메커니즘 가설** (refined): ambient JARVIS-SuperconDB 의 supercon-Tc 학습 분포가 *intermediate covalent-ionic* (Nb₃Sn · FeSe · MgB₂ · cuprate 등) dominant — *fully covalent localized* hydride 의 polar bonding 영역 projection 이 anti-bonding edge 로 spill. (a)-(j) breakthrough path 위에 **(k) sign-pathology repair — polar covalent fully-localized hydride 의 a²F projection sign convention** path 추가 후보 (실험적, low priority 보류).

### 신규 발견 #2 — H₃Br λ = 1.11 (group-17 mid-heavy halide outlier · cycle 7)

family 안에서 ALIGNN 이 λ ≥ 1 으로 ranking 한 **유일 2 point = H₃Cl (0.81 cycle 4, DFT 1.27 cross-confirm) + H₃Br (1.11)**. group-17 mid-heavy halide outlier — Br (χ 2.96, mass 79.9) 가 family-internal 최고 ALIGNN λ.

**critical-test 가설** (h3br-critical-test-2026-05-24.md 별도 SSOT):
- H₃Cl 의 monotone broad sweep (under-converged) 와 같은 패턴이면 H₃Br DFT λ 가 진짜 1.5+ 일 수 있음 → group-17 안에서 strong-coupling sweet spot 가능성
- χ-damage 가설 (h3f χ=3.98 Tc 31K · h3cl χ=3.16 Tc 120K) 의 extrapolation = Br χ=2.96 → Tc 50-100K 예상
- DFT 도착 ETA ~04:00 5/25 KST (~25h 후)

### 신규 발견 #3 — Tc-direct cap 4-6 K family-wide 정량 확정

`jv_supercon_tc_alignn` head 의 ambient training-distribution 출력 ceiling. 9/9 후보 모두 2.17-5.97 K 범위 안 (max = h3n 5.97 K). DFT 측정-grade 31-180 K 와 비교 시 **rel_err 80-99% family-wide** (h3cl 96.8% · h3o 97.6% · h3f 90.5% · h3si 96.1% · h3po 92.3%). d7 governance 정공법 (DFT) 이 family-wide quantitative 로 입증.

### path priority 갱신 (2026-05-24)

| path | priority 변경 | 사유 |
|---|---|---|
| (e) bond-length feature | 1순위 유지 | sign-pathology 3/9 가 bond-length axis 와 직접 연관 (short H-X bond → sign flip risk) |
| (i) pressure feature + retrain | 2순위 유지 | family-wide rel_err 가 floor → retrain 필수 |
| **(k) sign-pathology repair** (신규) | 보류 | 메커니즘 정밀화 (a²F sign convention) 필요, root cause 가설 단계 |
| 진짜 정공법 = DFT (§9.14 fanout 8/8) | **확정** | ALIGNN family-wide 의 quantitative wall 가 정공법 path 의 numerical justification 완성 |
