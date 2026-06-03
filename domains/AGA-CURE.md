# AGA-CURE — current state

@goal: 남성형 탈모 완전-복원 CURE — "탈모 있는 사람을 없는 사람으로". 유지/완만한 역전(SoC·AGA-RX)을 넘어 모든 미니어처화 모낭의 terminal 밀도 완전 복원 + 재발 영구 차단(disease-modifying). 4-arm 조합: ①깨우기(HFSC 재활성) ②되돌리기(Wnt복원, AGA-RX 상속) ③영구잠금(AAV anti-DKK1, AGA-RX VIROCAPSID 상속) ④신생(de novo neogenesis 완전소실부). in-silico 완치 게이트(terminal 밀도 100% 복원 + 재발 0) → wet-lab. 종료점 없는 frontier
@title: 🌱 AGA-CURE — "탈모 완치 (있는→없는 완전복원)"

(edit me — describe current state in completed-form; no history, no changelog inside this file)
- [x] spec: 완치 정의 + 재생 기전 맵 — AGA 모낭 미니어처화↔terminal 가역성, HFSC reservoir 잔존 증거, "완전소실(fibrosis)" 경계 + 완치 게이트(terminal 밀도 100% 복원·재발 0) 정량 정의
- [x] spec: 재생 frontier deep-research (arxiv+web) — HFSC 재활성(PP405/MPC·LDH) · de novo neogenesis(Wnt/SCUBE3/YAP-verteporfin·wound-induced) · 모낭 multiplication/cloning(Stemson/Tsuji) 정량
- [x] arm① 깨우기(HFSC 재활성): 휴면 모낭 줄기세포 metabolic 재활성 — PATH C LDHA/대사 상속(AGA-RX) → terminal 전환율 모델
- [x] arm② 되돌리기(Wnt복원): WAY-316606/SFRP1 + Dkk1-LRP6 소분자 상속(AGA-RX) — 미니어처화 역전
- [x] arm③ 영구잠금(disease-modifying): AAV anti-DKK1 shRNA 유전자치료 상속(AGA-RX VIROCAPSID) — 재발 영구 차단, 1회 투여
- [x] arm④ 신생(de novo neogenesis): 완전소실/fibrosis 영역 새 모낭 생성 — Wnt/β-catenin 유도 + dermal condensate 재형성 in-silico 모델
- [x] design: 4-arm 조합 레지멘 in-silico 모델(Bliss/Loewe) → "있는→없는" 완전전환 확률·시간 예측 + 순서(깨우기→되돌리기→신생→잠금) 최적화
- [x] verify: 완치 게이트 — in-silico 모낭주기 모델(anagen% 100% 복원 + 중단 후 재발 0) g5 + non-wet-lab gate ledger
- [x] handoff: 완치 IND 초안 + 재생의약품(RMAT/첨단재생) 규제경로 + 조합 IP
- [x] DEEP DC1 분자 신생모델: arm④ Gray-Scott을 분자-접지 Wnt/Dkk/BMP 2-morphogen Turing으로 심화 + 실제 모낭간격(~0.6mm)으로 grid 보정 → 현실적 신생 밀도 검증
- [x] DEEP DC2 in-vivo 게이트: arm①②③④ 각각 in-silico→in-vivo 전환 게이트 정의 (어떤 측정이 각 arm을 닫는가 · E_max·신생효율·tropism·재발)
- [x] DEEP DC3 영구-기전 비교: arm③ 영구화 7-기전(세놀리틱·AAV episomal·통합·CRISPR KO·후성유전편집·세포치환·합성회로) durability×risk 정량 → relapse-0 게이트 최적 기전
- [x] DEEP DC4 arm② 되돌리기 다중기전: Wnt복원 5경로(SFRP1억제·Dkk1차단·GSK3β억제·CXXC5-PPI·Wnt-agonist) potency×selectivity×topical×oncogenic 정량 → 최적
- [x] DEEP DC5 arm① 깨우기 다중기전: HFSC재활성 5경로(MPC/LDH대사·IL-36α·SCUBE3·JAK-STAT·PGF2α-FP) 깨우기효율×안전 정량 → 최적
- [x] DEEP DC6 4-arm 시퀀싱·타이밍 최적: 4 arm(깨우기·되돌리기·신생·영구) 투여순서×타이밍 동적모델 — arm결합(신생효율∝되돌리기Wnt톤; 영구락은 이득실현後)→복원극대 재발극소 순서
- [x] DEEP DC7 arm③ 후성유전편집기 전달: dCas9-KRAB(~4.1kb) AAV패키징한계(4.7kb) — 전달5경로(단일AAV·이중AAV split-intein·CasMINI/Cas12f·LNP-mRNA·나노입자) cargo적합×피부tropism×durability 정량
- [x] DEEP DC8 arm④ 신생 유도인자 비율: Turing 활성:억제(Wnt:Dkk/BMP) 생산비 스윕 → 파장→밀도 — 이산 native(200-300/cm²) vs 융합 plaque 경계 윈도우
- [x] DEEP DC9 통합 재게이트: DC3-8(후성락·SFRP1+Dkk1·MPC/LDH·락@18mo·Cas12f·신생강건) 전부 투입 → ≥90% 완치게이트가 E_max 단일변수로 환원 (E_max≥0.96 ⇒ CLOSE)
- [x] DEEP DC10 누적안전: 다중모달(AAV-Cas12f+SFRP1국소+MPC/LDH+신생) 합산 safety — 각 arm 위험 독립가정 1-∏(1-r_i) 누적 + 최악조합 → 허용역치
- [x] DEEP DC11 후성유전편집 특이성: locus-targeted Cas12f 메틸화 off-target — gRNA seed 미스매치 허용 vs 게놈 유사부위 수 → on:off 특이성비
- [x] DEEP DC12 후성유전 마크 유전성: dCas9/Cas12f 메틸화 마크가 HFSC 자기재생 분열에 걸쳐 50년 유지되나 — 분열당 유지율 vs 마크소실 → DC3 영구화 가정 falsify-test
- [x] DEEP DC13 E_max 임상앵커: wet-lab 전용 주장 반증 — Van Neste 용량반응에서 현행 2-arm 천장 E_max≈0.59(생물학적, 섬유화25% 일치) 역산, 잔차=arm④ 신생효율(in-vitro 오가노이드 브래킷)
