# MAIN — current state

@title: 🎯 MAIN — 활성 메인 트랙 (active main track)
@goal: 활성 작업 트랙 단일 진입점 — 진행 중인 메인 마일스톤을 한 곳에서 추적·구동

## 진행 (progress)

- [ ] **RTSC Li2MgH16 dense-mesh 수렴 + 3번째 독립 QE-λ 꼭짓점 승격** — 현 8-q(2×2×2) coarse 어셈블: λ=5.79 · ω_log=741 K · Tc_AD=164 K(μ\*=0.10)/158 K(μ\*=0.13), verdict `.verdicts/qforge-li2mgh16-8q-assembled/`. coarse = Γ 과대가중 → λ over-shoot, Tc 문헌(Sun 2019: 473 K, λ≈3.3 @250 GPa)의 ~1/3. **4×4×4 q QE el-ph 재실행** → (a) λ↓~3.3·ω_log↑로 473 K 수렴 실증, (b) QE lambda.x 자체 λ로 "독립 QE-λ cross-val" 3번째 삼각측량 꼭짓점 승격. nat=38, 250 GPa, 비용 ≈ 38-atom dense-q QE el-ph GPU pod 다일(~$수십). 데크 = `exports/rtsc/decks/Li2MgH16` (8-q → 4×4×4 q-mesh 상향). 게이트 data-half는 현재 3/3 terminal(CaH6·LaH10·Li2MgH16 8-q).
