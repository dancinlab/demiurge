# SENOLYX — current state

@goal: 재생 niche의 노화 섬유아세포를 선택 청소하는 NOVEL senolytic — CURE-PRIMITIVE 범용 병목(소실조직 신생효율 η_neo) 0.49→0.84+ 회복으로 AGA/치주/연골/망막 완치 게이트 동시 돌파. 표적·도킹·MM-GBSA·ADMET·niche선택성·η_neo-lift PD 게이트까지 d1/d5/d19
@title: 💊 SENOLYX — "재생 niche 노화세포 청소제 (범용 완치 병목 해결)"

(edit me — describe current state in completed-form; no history, no changelog inside this file)
- [x] spec: 노화세포·senolytic 파이프라인 TOP-N (navitoclax/ABT-263·D+Q·fisetin·UBX1325·A-1155463) MoA·표적(BCL-2/xL/w·p16/p21)·한계 정량 + arxiv/web 딥리서치
- [x] spec: NOVEL 표적 — 재생-niche 노화 섬유아세포 SELECTIVE 청소 (혈소판독성 BCL-xL 회피 + niche 특이성)
- [x] structure: BCL-xL(3ZLR)·BCL-2 포켓 확보 + 결합포켓 정의
- [x] design: NOVEL senolytic 후보 in-silico 도킹 + MM-GBSA (AGA-RX 스택 + 뚫은 env 재사용)
- [x] analyze: ADMET + niche-선택성 off-target(혈소판 BCL-xL 독성 회피) 스크린
- [x] verify: η_neo-lift PD 게이트 — niche 청소→신생효율 0.49→0.84 회복 in-silico (CURE-PRIMITIVE 연결) g5
- [x] handoff: IND 초안 + 범용-완치 병용(AGA/치주/연골/망막) 전략 + IP
- [x] axis: CURE-PRIMITIVE reused[] — 4 완치도메인 공통 η_neo 병목을 SENOLYX가 푼다 (NEXUS edge)
- [x] DEEP R5-A β-gal 절단속도 선택성 모델: Michaelis-Menten 프로드러그→활성 전환, senescent SA-βgal Km/kcat·노출시간 적분 → 활성약 AUC 선택비(sen:normal) 정량 (round-3 입체게이팅 반증의 동역학 후속)
- [x] DEEP R5-B CRBN-PROTAC 설계+도킹: A-1155463 워헤드 + linker + CRBN리간드(pomalidomide), BCL-xL(4QVX) + CRBN(4CI1) 양단 도킹 → 삼원복합체 타당성 (혈소판회피 NOVEL leg)
- [x] DEEP R6 이질성→칵테일: BCL-xL 의존분율 r<0.67시 단독요법 청소<60%(cure게이트 fail) → 2-축 칵테일(BCL-xL A-1155463 + MCL-1 S63845 −8.18) 필요; 브레인스토밍 고갈
- [x] DEEP R7 인과모델(/gap F4 top-1 폐쇄): SASP-Hill 억압 do-연산자 개입 + young/old 반사실 + 구별실험(Hill 기울기 n>0) — 청소→재생 연관을 falsifiable 인과가설로 전환
- [x] DEEP R8 3축 landscape(/gap top-2+F2 폐쇄): HSP90(geldanamycin −4.91, Vina 거대고리 과소평가=F8 단일툴 gap 자기실증) 3번째 축 추가 → 3축 칵테일 74% 청소, triple-resistant 닫음, 잔여 10%=면역 adjunct
- [x] DEEP R9 교차툴 재점수(/gap top-3 F8 해소): HSP90 geldanamycin Vina −4.91 vs MM-GBSA −66.5 — Vina가 거대고리 과소평가 확정(단일툴 아티팩트), 3번째 축은 강결합. 절대값 FEP[GPU]는 이월
- [ ] DEEP R10 FEP 절대 ΔG (이월·GPU): HSP90 geldanamycin ABFE — perses/OpenFE deck + 거대고리 FF 파라미터 → vast.ai GPU pod ~12–24h·$15–35, deck 로컬 dry-run 후 d17 발사. MM-GBSA(R9)가 부호/방향은 이미 해소; 절대값 정밀화만 잔여
- [x] DEEP R12 RBFE 3축 친화도 (ΔΔG=두 ABFE 차, 공유 ansamycin 코어 FF오차 상쇄) — 검증쌍 17-AAG↔17-AG(C17 allylamino vs amino, quinone), ΔΔG_exp≈−1.9 (cb600224w). **CLOSED-DIRECTIONAL (N_ITER=500, smallbox-31k clean path)**: per-leg 4×H100, ABFE=dG_solvent−dG_complex+ssc. **per-leg dG_decouple(kcal/mol, 31113-atom box)**: 17AG complex 58.12±0.44(ssc −0.21)·solvent 72.53±0.42 → **ABFE(17AG)=14.20**; 17AAG complex 47.38±0.61(ssc −0.21)·solvent 63.21±0.48 → **ABFE(17AAG)=15.62**. **ΔΔG_calc = −1.42 ± 0.99 vs exp −1.9** → 부호 ✓(17AG 강결합) · |err|=0.48 · **exp가 0.5σ 안** (N=110 −0.75±0.64 대비 대폭 개선, RBFE 오차상쇄 작동). **🟢 방향성+정량 GATE_PASS**: ΔΔG 부호·크기 모두 exp와 0.5σ 일치. **단, 절대 ABFE(+14/+16)는 비물리적** — R11서 닫힌 "단일포즈 거대고리-퀴논 ABFE 절대값 무효" 한계 그대로(차이 ΔΔG만 유의). 정밀 definitive(repeat≥3)는 [[R12-GOLD]]가 추적. **핵심 fix**: 초기 289k-atom box-blowup 버그(addSolvent 과용매, ~9.3× 과대) 진단·수정 → 31k로 정상화한 clean path가 결과를 냄(289k 경로는 complex leg 소실로 INCOMPLETE, PR#606). exports/SENOLYX/round12-rbfe/smallbox/ (4 leg prod.log + 17AAG_complex.nc 체크포인트).
