# IVD-CURE — current state

@goal: 추간판(IVD) 퇴행으로 소실된 수핵·섬유륜을 재생하는 disease-modifying 치료 — CURE-PRIMITIVE 첫 BOUNDARY 사례: 병목=소실조직 신생이나 무혈관+종판석회화+빈약한 progenitor reserve로 senolytic 단독 불충분. SENOLYX+세포치료+종판영양복구 3제 병용 요건 규명. d1/d5/d19
@title: 🦴 IVD-CURE — "척추 디스크 재생 (수핵·섬유륜 복원)"

(edit me — describe current state in completed-form; no history, no changelog inside this file)
- [x] spec: IVD 퇴행 생물학 + 조직클래스 분해(가역 경증NP/AF·휴면 progenitor稀少·소실 NP/AF/종판) + NP세포 SASP 문헌
- [x] design: CURE-PRIMITIVE 축붕괴 — 병목=소실신생 η0.30(5도메인 최저) + 무혈관·종판석회화 보정
- [x] verify: BOUNDARY 검증 — η_lost=1.0서도 ceiling=0.90 턱걸이 → senolytic 단독 게이트 불가 (#548 경계조건 실증) g5
- [x] design: 3제 병용 요건 — SENOLYX(좀비청소)+exogenous progenitor(세포치료)+종판 탈석회/영양복구 정량
- [x] axis: SENOLYX·CURE-PRIMITIVE reused[] — 범용 프레임의 첫 BOUNDARY 인스턴스 (NEXUS)
- [x] axis ⚛️ QUANTUM: pocket-VQE 정밀 ΔG — 디스크 senolytic 표적(BCL-xL 재사용)+이화효소(ADAMTS5/MMP13) (3제 senolytic leg 정밀화)
- [x] axis 🧶 WEAVE: 자기조립 주입형 하이드로겔/cage — 수핵(NP) 부피복원 + 이식세포 담체 scaffold (3제 cell-therapy leg)
- [x] axis 🤖 NANOBOT: 디스크内 pH(~6.5 산성)/효소 게이트 트리거-방출 — 퇴행디스크 산성 미세환경 활용 국소방출 (AGA-RX NANOBOT pH게이트 재사용)
- [x] axis ✂️ RIBOZYME: siRNA/ribozyme — NP 이화/SASP 유전자(ADAMTS5·MMP13·IL-6) knockdown (기질분해+노화분비 동시억제)
- [x] axis 🦠 VIROCAPSID: AAV 동화 페이로드(TGF-β/GDF5/SOX9) → NP세포 형질도입 — 소실기질 신생 구동 (3제 regen leg)
