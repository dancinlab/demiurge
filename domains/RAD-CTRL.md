@title: 🧱 RAD-CTRL — "방사능 제어막"

@goal: 방사능 노출을 in-silico 설계로 제어한다 — 차폐(shielding) · 봉쇄(containment) · 붕괴열 관리 · 거리·시간(ALARA). ⚠ 방사능 자체를 줄이는 게 아니라 **노출을 관리**한다(핵은 그대로, 방출을 막거나 거리로 약화). RADGUARD 우산의 제어 축. RTSC 방사성 초수소화물(ThH₁₀·AcH₁₀) 후보의 핸들링 참조.

## 정체 (d10 head)
- 🧱 아이콘 · `RAD-CTRL` canonical · "방사능 제어막" alias
- 하는 일: 방사선이 사람·환경에 도달하는 경로를 물질·기하 설계로 차단/약화
- 비유: 햇빛 자체는 못 끄지만 **양산·차양으로 쬐는 양을 줄이는** 것
- vs RAD-REMOVE(핵 수준 소멸) · vs RAD-BIND(화학 고정) — CTRL은 **노출 경로** 담당

## 진행 (milestones)
- [ ] 차폐물질 설계 — 감쇠계수 μ(E) · 두께-감쇠 Beer-Lambert in-silico (γ: 고-Z Pb/W/Bi · 중성자: H-rich/B/Li · α/β: 저-Z) 해석 또는 openMC-grade
- [ ] 봉쇄 설계 — 다층 배리어 · 누설률 모델
- [ ] 붕괴열 관리 — decay-heat Q(t) · 방열 설계
- [ ] ALARA 기하 — 거리(1/r²)·시간 노출 최적화 closed-form
- [ ] RTSC 연계 — 방사성 하이드라이드별 필요 차폐 두께 시트

## 참조
- 우산: [[RADGUARD]] · sibling: [[RAD-REMOVE]] · [[RAD-BIND]]
- NEXUS.tape: RTSC ↔ RADGUARD(→RAD-CTRL) · 인접 NUCLEAR
