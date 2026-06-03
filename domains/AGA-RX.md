# AGA-RX — current state

@goal: 남성형 탈모(androgenetic alopecia·AGA) first-in-class/best-in-class 신규 처방의약품 — 기존 미녹시딜/피나스테리드/두타스테리드 한계(성기능 부작용·중단 시 reversal·완만한 효능) 돌파. NOVEL 표적 발굴(non-AR / Wnt·DPC axis) → in-silico 결합·ADMET·PK → 비임상 in-vivo 모델까지 non-wet-lab 게이트 PASS. d1/d5/d6/d19 적용
@title: 💊 AGA-RX — "남성형 탈모 신약(처방약)"

(edit me — describe current state in completed-form; no history, no changelog inside this file)
- [x] spec: AGA 기전 맵 + 시판/파이프라인 신약 TOP-N (미녹시딜·피나·두타·클라스코테론·여성용 + 임상 II/III 후보) 효능·부작용·MoA 정량
- [x] spec: NOVEL 표적 발굴 (non-AR axis — Wnt/β-catenin·DPC Dkk1·PGD2/GPR44·SFRP1·JAK-STAT) — arxiv + web 딥리서치 round-1
- [x] structure: 표적 단백질 구조 확보 (PDB / AlphaFold) + 결합 포켓 정의
- [x] design: NOVEL 후보 분자 설계 + in-silico 도킹·자유에너지 (best-in-class affinity)
- [x] analyze: ADMET + PK 예측 (경구/국소) + 성기능 부작용 off-target(AR) 스크린
- [x] synthesize: 선도물질 합성경로 in-silico 설계 + 제형(국소 전달체계) 후보
- [x] verify: 비임상 in-vivo 모델(in-silico PK/PD·모낭 anagen% 예측) non-wet-lab 게이트 — hexa verify g5
- [x] handoff: IND 패키지 초안 + 규제경로(US 505(b)(1)/(2)·KR) + IP 포트폴리오
- [ ] axis QUANTUM (compute bridge): pocket-VQE quantum-accurate ΔG on SFRP1/Dkk1-LRP6/AR pockets — upgrade docking → chem-accuracy (hexa-bio quantum F-Q-6 pocket-VQE)
- [x] axis WEAVE (Caspar-Klug + Zlotnick cage-assembly): self-assembling delivery cage/scaffold for follicular delivery of the Wnt-restorer payload
- [x] axis NANOBOT (molecular machine / DNA-origami switch): trigger-release nanocarrier targeting dermal papilla (pH/enzyme-gated topical release) — CLOSED 2026-06-03 (bc1d498): pH(pKa6.0)/esterase Hill gate on inherited 4-state actuator; gating 33.6×, DPC release fidelity 90–94 % vs 3.8 % ungated. exports/AGA-RX/round5-nanobot/
- [x] axis RIBOZYME (RNA-targeting catalytic): ribozyme/siRNA vs DKK1 · SRD5A2 · AR mRNA — non-small-molecule AGA arm (cf OLX104C topical anti-AR siRNA precedent)
- [x] axis VIROCAPSID (capsid T-number assembly): AAV/capsid gene therapy delivering Wnt-restoring / anti-Dkk1 payload to dermal papilla cells

## hexa-bio 5축 ↔ AGA-RX 모달리티 매트릭스 (inherited from hexa-bio-archive)

n=6 invariant lattice · τ-quartet tetrahedron (weave·nanobot·ribozyme·virocapsid = write-side bio sandboxes)
+ quantum compute bridge (VQE / qpu_bridge). 각 축 = AGA에 대한 직교 치료 모달리티이며, 모두 동일 앵커 경로
(DHT→DPC Dkk1↑/SFRP1↑→Wnt↓→모낭 위축)를 AR 하류에서 공격한다.

| hexa-bio 축 | hexa-bio 원의미 | AGA-RX 모달리티 매핑 | 1차 표적 / 자산 |
|---|---|---|---|
| ⚛️ QUANTUM | VQE / qpu_bridge 컴퓨트 브리지 | **pocket-VQE 양자정확 ΔG** — 도킹값을 chem-accuracy로 승급 | SFRP1 CRD · Dkk1-LRP6(3S2K) · AR-LBD 포켓 (F-Q-6 pocket-VQE 적용) |
| 🧶 WEAVE | Caspar-Klug + Zlotnick cage-assembly ODE | **자기조립 전달 케이지** — 모낭 국소 전달 scaffold | Wnt-복원 페이로드 캡슐화 케이지 |
| 🤖 NANOBOT | molecular machine / DNA-origami 스위치 | **트리거-방출 나노캐리어** — DPC 표적 (pH/효소 게이트) | 국소 도포 → 모낭 침투 → DPC 방출 |
| ✂️ RIBOZYME | RNA-targeting catalytic | **ribozyme / siRNA** — 비-소분자 arm | DKK1 · SRD5A2 · AR mRNA (cf OLX104C 국소 anti-AR siRNA 선례) |
| 🦠 VIROCAPSID | capsid T-number assembly | **AAV/capsid 유전자치료** — DPC 형질도입 | Wnt-복원 / anti-Dkk1 페이로드 → 모낭 dermal papilla |

> 전략: 소분자 4경로(PATH A SFRP1 · PATH B Dkk1-LRP6 · PATH C 대사+노화)는 QUANTUM 축으로 ΔG 정밀화,
> WEAVE/NANOBOT 은 전달(delivery) 모달리티, RIBOZYME/VIROCAPSID 는 비-소분자 치료 모달리티로 병렬 확장.
> 각 축은 hexa-bio-archive/ 의 검증된 시뮬레이터(σ(6)=12 audit · Caspar-Klug · cage-assembly ODE · VQE)를 상속 (d19).
