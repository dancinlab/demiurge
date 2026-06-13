@title: ⚛️ RAD-REMOVE — "방사능 소멸"

@goal: 방사능을 실제로 제거한다 — 유일하게 방사능 자체를 줄이는 축(핵 수준). 핵변환(transmutation: 중성자흡수→안정핵종 · ADS 가속기구동) · 동위원소 선택(애초에 안정/장반감기) · 붕괴 대기(decay storage). ⚠ 화학으로는 불가 — 방사능은 핵 성질이라 핵 과정만이 실제 제거. in-silico: 중성자 흡수단면적 σ · transmutation chain · 동위원소 붕괴계통 계산.

## 정체 (d10 head)
- ⚛️ 아이콘 · `RAD-REMOVE` canonical · "방사능 소멸" alias
- 하는 일: 불안정 핵을 안정핵종으로 바꾸거나, 애초에 안정 동위원소를 골라 방사능을 0으로
- 비유: 시한폭탄을 **해체(핵변환)** 하거나 **애초에 폭탄 아닌 걸 고르는(동위원소 선택)** 것 — 가두는 게 아니라 없앰
- vs RAD-CTRL(노출관리) · vs RAD-BIND(화학고정) — REMOVE만 **방사능 자체↓**

## 진행 (milestones)
- [ ] 동위원소 선택 축 — 원소별 안정/장반감기 동위원소 카탈로그 + α/β/γ 방출 프로파일 (Th-232 vs 단반감기 등) in-silico 스크린
- [ ] 핵변환 경로 — 방사핵종 + n → 안정핵종 chain · 중성자 흡수단면적 σ(E) · burn-up 계산
- [ ] ADS(가속기구동) 개념 설계 — 변환 효율 closed-form
- [ ] 붕괴 대기 모델 — 활성도 A(t)=A₀e^(−λt) 시간경과 감쇠
- [ ] RTSC 연계 — 방사성 하이드라이드의 동위원소-선택 가능성 (예: Th-232 base) 평가

## 참조
- 우산: [[RADGUARD]] · sibling: [[RAD-CTRL]] · [[RAD-BIND]]
- NEXUS.tape: RTSC ↔ RADGUARD(→RAD-REMOVE) · 인접 NUCLEAR
