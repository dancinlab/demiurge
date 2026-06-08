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
- [x] DEEP R10 FEP 절대 ΔG — **SUPERSEDED (closed-negative, g63)**: R11이 "단일포즈 거대고리-퀴논 절대 ABFE는 무효"를 닫힘-음성으로 입증(원인=거대고리 FF 부적합) → 절대 ΔG 정밀화는 이 방법으론 불가. R12가 **RBFE(상대 ΔΔG, 오차상쇄)**로 피벗해 ΔΔG=−1.42±0.99 vs exp −1.9(0.5σ) 달성 = 절대값 우회 성공. 따라서 R10(절대 ABFE)은 추구 불요·R11/R12로 대체 종결.
- [x] DEEP R12 RBFE 3축 친화도 (ΔΔG=두 ABFE 차, 공유 ansamycin 코어 FF오차 상쇄) — 검증쌍 17-AAG↔17-AG(C17 allylamino vs amino, quinone), ΔΔG_exp≈−1.9 (cb600224w). **방향성 결과 확정(부호 −, 17AG⊃17AAG) · 크기는 solvent-leg λ 불안정으로 unreliable, definitive=R12-GOLD · box-blowup fixed 289k→31k.** **box-blowup 수정(R12-smallbox, N_ITER=500)**: 직전 PR(#604)은 kos_pose.sdf 리간드가 원점-중심·단백질은 ~9.8nm 떨어진 좌표 → modeller.add 후 분자범위 9.4nm → addSolvent(padding=) 14.3nm 큐브 → **289k atom**(거의 빈 bulk water, complex-leg이 사실상 2nd solvent leg = silently wrong). 수정: 리간드 centroid→단백질 centroid 이동(HSP90 N-도메인 ATP pocket)·전체 원점재중심·explicit rectangular box(extent+2×1.0nm) → **31,166 atom (9.3× 감소), r0=0.39nm (리간드 pocket 결합 확인)**. **per-leg dG_decouple(kcal/mol, smallbox N=500)**: 17AG complex **58.12±0.44**(ssc −0.21)·solvent **72.53±0.42** → **ABFE(17AG)=+14.20**; 17AAG complex **47.38±0.61**(ssc −0.21)·solvent **63.21±0.48** → **ABFE(17AAG)=+15.62**. **ΔΔG_calc=−1.42±0.99 vs exp −1.9** (**부호 일치·방향 correct**, 편차 0.48=0.49σ stat — #604의 −0.75/1.8σ보다 개선). **속도**: complex ~4× (289k 50 iter/h → 31k ~170 iter/h, HREX swap CPU-bound이 병목 → atom-ratio 9.3× 만큼은 못 나옴), solvent ~20× (1000 iter/h). **🟠 magnitude unreliable(g6/g63 정직)**: 절대 ABFE가 양수(+14~+16, 비물리적) — solvent leg이 알려진 불안정 분기(6.55 vs 72.97 bistable, 이번엔 72.53/63.21 high-branch) → 절대값 무의미, **ΔΔG(상대·공유코어 계통상쇄)만 신뢰**. R12 방향성 종결, definitive 크기는 R12-GOLD(solvent λ 조밀화)로 이월. exports/SENOLYX/round12-rbfe/smallbox/{agc,ags,aagc,aags}_*_smallbox.log.
