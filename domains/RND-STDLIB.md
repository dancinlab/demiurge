# 📚 RND-STDLIB — QD·COSME 공통 R&D 표준 라이브러리

> 모든 R&D 도메인(QD/* + COSME/*)이 참조하는 공통 SSOT.
> 분리한 이유: PLAYBOOK은 컨테이너별 (QD 의약외품 / COSME 화장품) 인데, **시험 표준·활성성분 메커니즘·전달체계·인증 기관·광고 표현**은 양쪽 공통.

---

## 1. 시험 표준 stdlib (in vitro · in vivo · 임상)

### 1-1. in vitro 효력·안전성

| 시험 | 표준 | 적용 도메인 | 견적 (만원/검체) | 시간 |
|---|---|---|---|---|
| 항진균 MIC (효모·곰팡이) | CLSI M27 / M44 (M27M44S:2026) | HSHAMPOO·HSPRAY·SCALP·LENS·FOOT | 60-150 / 균주 | 2-3주 |
| 항균 MIC (세균) | CLSI M07 / M100 | GARGLE·TPASTE·FWASH·MWASH·BAND·INCONT·POSTPART·PETHYG | 50-120 / 균주 | 1-2주 |
| 살균력 log-reduction | BS EN 1276 (5-log, 5min/20°C, 4균주) | SANITIZER·SANSURF·LENS | 200-400 / 패키지 | 3-4주 |
| Franz cell 경피흡수 | OECD TG 428 | HSPRAY·SCALP·AMPOULE·SUN·EXOSOME·ACNE·EYE | 250-500 / 3조건 | 4-6주 |
| HET-CAM 안자극 | ICCVAM / INVITTOX 96 | LENS·SUN·MAKEUP·EYE·전반 | 80-150 / 검체 | 2주 |
| 각막세포독성 | OECD TG 492 (SIRC/MTT) | LENS | 100-200 / 검체 | 2-3주 |
| 콘택트렌즈 살균력 (5균주) | MFDS 27295 (S.aureus·P.aeruginosa·S.marcescens·C.albicans·F.solani) | LENS | 300-600 / 패키지 | 4-6주 |
| 입자차단 (마스크) | NaCl 0.3μm aerosol @ 85 L/min · KMOEL-2017-64 | MASK | 50-100 | 1-2주 |

### 1-2. in vivo (동물·GLP)

| 시험 | 표준 | 견적 (만원) | 시간 |
|---|---|---|---|
| LD50 급성경구 (UDP) | OECD TG 425 | 400-700 | 3-4주 |
| 90일 반복투여 NOAEL | OECD TG 408 | 5,000-9,000 | 5-7개월 |
| 피부 자극 (재구성표피 RhE) | OECD TG 404 / 439 | 150-400 | 2-4주 |
| 48h 패치 (Buehler/LLNA) | OECD TG 406 / 429 | 800-1,500 | 6-8주 |

### 1-3. 인체적용시험 (CRO 24주)

| 시험 | 표준 | 견적 (만원, n=30-44) | 시간 |
|---|---|---|---|
| 모근 카운트·모발 두께 | TrichoScan® (ICC 0.91-0.97) | 5,000-9,000 | 24주 + 분석 4주 |
| 치주염 BoP (4-pocket) | PI·GI·BoP·PD | 6,000-12,000 | 12-24주 |
| 자외선차단 SPF | ISO 24444 in vivo · ISO 24443 in vitro | 1,500-3,500 | 4-8주 |
| 미백·주름 | Mexameter·PRIMOS·이미지 분석 | 1,500-3,500 | 12-24주 |
| Stinging test | lactic acid 10% (n=30) | 300-600 | 2-3주 |
| 인체 첩포 48h closed | (n=30) | 400-800 | 4주 |

### 1-4. 마이크로바이옴

| 항목 | 서비스 | 견적 (만원/샘플) | 시간 |
|---|---|---|---|
| 16S rRNA V3-V4 (Illumina MiSeq 300×2) | 마크로젠·디엔에이링크·CJ바이오사이언스 | 12-25 (n≥48 묶음 할인) | 4-6주 |
| EzBioCloud MTP 분석 (α·β·LEfSe) | CJ바이오사이언스 | 5-15 (분석) | 1-2주 |
| Shotgun metagenomics | 마크로젠·CJ | 60-120 / 샘플 | 8-10주 |

### 1-5. VOC·알러지·전성분

| 시험 | 표준 | 기관 | 견적 (만원/검체) | 시간 |
|---|---|---|---|---|
| VOC 84종 (생리대·기저귀) | MFDS HS-GC/MS | KOTITI·KTR·KTL·KCL | 80-150 | 2-3주 |
| 알러지 26종 향료 | EU 2003/15/EC Annex III | KOTITI·KTR | 35-70 | 2주 |
| 다이옥신·퓨란 (생리대) | MFDS HRGC-HRMS | KOTITI·KTL | 100-200 | 3-4주 |
| 전성분 화학분석 | 자가품질 | KTR·KCL·KOTITI | 50-120 / 패키지 | 2-3주 |

---

## 2. 활성성분 메커니즘 stdlib (first-principles)

| 활성성분 | 1차 표적 | 분자 메커니즘 | 표준 측정 |
|---|---|---|---|
| 케토코나졸·클림바졸 | Cyp51 (ERG11) | lanosterol → ergosterol 14α-demethylation 차단 → 막불안정 | CLSI M27/M44 MIC |
| 징크피리치온 (ZPT) | Fe-S cluster · CutC | 세포내 Cu²⁺ 과축적 → Fe-S 단백질 손상 (non-azole) | M.restricta MIC + ASFS |
| 살리실산 (BHA) | 각질층 corneocyte | 각질용해 → 진균 서식지 제거 + sebum plug 분해 | 각질박리지수 |
| 5α-환원효소 inhibitor | Type I/II 5αR | T → DHT 차단 → DPC Wnt/β-catenin 회복 → anagen 유지 | TrichoScan 4축 |
| CPC (cetylpyridinium chloride) | 박테리아 세포막 | 4차 암모늄 cationic → 음전하 막 결합·permeabilize | MIC/MBC |
| CHX (chlorhexidine) | 막 + 단백질 침전 | bis-biguanide → 막손상 + substantivity 8-12h | BoP, S.mutans CFU |
| 자일리톨 | S.mutans 대사 | 5탄당 phosphorylation 헛돌이 → ATP 고갈 | 카리에스 발생률 |
| 트라넥삼산 | plasminogen→plasmin | antifibrinolytic → 잇몸 출혈 응고 보조 | BoP |
| 살리실산 (여드름) | 모낭 내 sebum/keratin | lipophilic 침투, comedolytic + C.acnes↓ + sebum gland↓ | Sebumeter SM815 |
| 아젤라산 | 5α-환원효소 NADPH site | 경쟁적 5αR 억제 + C.acnes 항균 + anti-inflam | Sebumeter |
| 니아신아마이드 | NF-κB · sebum TG | 항염 + sebogenesis 억제 | Sebumeter·TEWL |
| 정전기 필터 (meltblown PP) | 0.3μm aerosol MPPS | hydrocharging → 정전기 흡착 | NaCl 0.3μm @ 85 L/min |
| PHMB | 세포막 인지질 | polycationic biguanide → 음전하 막 결합·파괴, 렌즈 흡착축적 | ISO 14729 stand-alone 3-log |
| 폴리쿼터늄-1 (PQ-1) | 박테리아 막 | 고분자 4차암모늄, 렌즈 흡수↓ → 안구자극↓ | ISO 14729 4종 |
| 에탄올 (62-83%) | 세포막·단백질 | 막 용해 + 단백질 변성 | 5min log reduction |
| DEET·이카리딘 | 모기 후각 수용체 | OR/Or7a 차단 → 후각 신호 교란 | 모기 챔버 시험 (WHO) |

---

## 3. 전달체계 stdlib (vesicle/emulsion)

| 시스템 | 입자크기 | 조성 | 침투 깊이/경로 | 잔류·flux 특성 | 적용 도메인 |
|---|---|---|---|---|---|
| 나노에멀젼 80nm | 80nm | oil-in-water + surfactant | viable epidermis + **모낭관 588μm** | 모낭 표적 최적 | HSPRAY·SCALP·ACNE |
| 나노에멀젼 200nm | 200nm | 동 | 중간 transdermal | 표층 SC 통과 가능 | AMPOULE·SUN |
| 나노에멀젼 500nm | 500nm | 동 | SC 통과 불가, 모낭관 표면만 | rinse-off 표층 | HSHAMPOO (linse-off) |
| 리포좀 (전통) | 145-202nm | phospholipid 이중층 | SC 상부 위주 | 가장 낮은 cumulative permeation | DERM·BABY (저자극) |
| 니오좀 | 100-300nm | non-ionic surfactant + cholesterol | 리포좀 유사 | 화학적 안정성↑·원가↓ | VEGAN·BODY |
| 에토좀 | ~150nm | phospholipid + 20-45% 에탄올 | SC lipid fluidize, **진피층** | flux 리포좀 대비↑↑ | AMPOULE (고침투) |
| 트랜스퍼좀 | 145-200nm | phospholipid + edge activator (Span 80) | hydration-gradient → **진피·전신** | cumulative permeation·flux·skin retention 최고 | AMPOULE·EYE·EXOSOME |
| 마이크로니들 | 100-1000μm | dissolving polymer | 진피·전신 (각질층 우회) | 약물 침투 최강 (강제) | AWAKE·EXOSOME |
| Electret meltblown + nano-layer | — | PP·PVDF·PA | 정전기 흡착 0.3μm | 99% @ <100Pa | MASK |

표준: OECD TG 428 (in vitro skin absorption) · Franz Diffusion Cell static/flow-through 모두 compliant.

---

## 4. 분류 결정 트리 (의약품 vs 의약외품 vs 화장품 vs 의료기기)

```
효능 표방 강도 = 강 ─┐
                    │ + 침습성 / 위해 강
                    ▼
                의료기기 (3등급) 또는 의약품 (전문)
                예: 콘돔 · 미녹시딜 · 클로르헥시딘 0.1%↑

효능 표방 = 치료·예방 ─┐
                       │ + 침습 ↓
                       ▼
                  일반의약품 (약국 전용·쿠팡 X)
                  예: 헥사메딘 · 잇치 · 마이녹실

효능 표방 = 완화·예방 ─┐
                       │ + 침습 ↓
                       ▼
                  의약외품 (식약처 신고/허가·쿠팡 OK)
                  예: 가그린 · 디펜드 · 항비듬 샴푸 · 콘택트렌즈 관리액

효능 표방 = 도움·완화 (기능성 11종) ─┐
                                      │
                                      ▼
                                기능성 화장품 (식약처 심사)
                                예: 탈모완화 샴푸 (6대 자동허가) · SPF · 미백 · 주름

효능 표방 = 청결·미용 한정 ─┐
                              │
                              ▼
                         일반 화장품 (신고제)
                         예: 시트마스크 · 향수 · 바디로션
```

### ⚠ 경계 케이스

| 제품 | 분류 갈림 |
|---|---|
| 콘돔 | 의료기기 3등급 (피임·성병예방) |
| 습윤드레싱 | 의료기기 1-2등급 (창상치유) vs 일반 밴드 (의약외품) |
| LED 마스크 | 의료기기 2등급 (주름·여드름 표방) vs 화장품 (쿨링만) |
| 식염수 분무 | 의약품 (점안) vs 화장품 (미스트) |
| 가글 | 의약품 (CHX 0.1%↑) vs 의약외품 (CPC·자일리톨) |
| 탈모 케어 | 일반의약품 (미녹시딜) vs 의약외품 (항비듬) vs 기능성 화장품 (탈모완화 6대) vs 일반 화장품 (두피 청량) |

---

## 5. 인증 기관 stdlib (한국)

| 기관 | 전문 분야 | 견적 시스템 |
|---|---|---|
| KTR (한국화학융합시험연구원) | 화장품·의료기기·미생물·피부임상 | https://www.ktr.or.kr |
| KCL (한국건설생활환경시험연구원) | 안전성평가·의약품·식품 | https://www.kcl.re.kr |
| KOTITI | 화장품·위생용품·VOC·알러지 | http://www.kotiti-global.com |
| KTL (한국산업기술시험원) | 다이옥신·미생물·표시검사 | https://customer.ktl.re.kr |
| 디티앤씨알오 (DT&CRO) | 임상시험 (모근·치주염·미백) | https://dtncro.com |
| 엘리드 | 인체적용시험·안전성평가 | https://www.ellead.com |
| 피엔케이 피부임상연구센터 | 24주 인체적용·자극 시험 | — |
| GMRC | 모발·탈모 인체적용 | https://gmrc.co.kr |
| CJ바이오사이언스 (구 천랩) | 16S NGS·EzBioCloud | https://www.chunlab.com |
| 마크로젠 | NGS·shotgun metagenomics | https://macrogen.co.kr |

---

## 6. 광고 표현 매트릭스 stdlib

| 표현 | 의약품 | 의약외품 | 기능성 화장품 | 일반 화장품 |
|---|---|---|---|---|
| 치료·치유 | ✓ | ✗ | ✗ | ✗ |
| 예방 | ✓ | △ (범위지정 한정) | ✗ | ✗ |
| 완화·도움 | ✓ | ✓ | ✓ (고시 11종) | ✗ |
| 살균·소독 | ✓ | ✓ (소독제) | ✗ | ✗ |
| 면역력 강화 | △ | ✗ | ✗ | ✗ |
| 재생·염증 완화 | ✓ | ✗ | ✗ | ✗ |
| 미백·주름 | — | — | ✓ | ✗ |
| 청결·미용 | ✓ | ✓ | ✓ | ✓ |
| 절대적 표현 (최고·끝판·확실) | ✗ | ✗ | ✗ | ✗ |

### ⚠ 적발 사례 (식약처 모니터링)

| 사례 | 처분 |
|---|---|
| 잇치 의약외품 "끝판왕" 광고 (2011) | 광고정지 |
| 여성청결제 "질염 예방·치료" (2022-23) | 169건 적발 (80건 의학적 효능 무허가) |
| 화장품 의약품 오인 광고 (2024-25) | 8,727건 적발 (전체 부당광고 70%) |

---

## 7. R&D 단계별 표준 패키지 (도메인 매핑)

| 단계 | QD 도메인 패키지 | COSME 도메인 패키지 |
|---|---|---|
| **spec** | 시판 TOP-N + 활성성분 농도 HPLC/GC-MS 정량 | 동일 + 기능성 인증 사례 |
| **structure** | 활성성분 first-principles 매트릭스 (본 stdlib §2) | 동일 |
| **design** | 농도 × 전달체계 (본 stdlib §3) × 보조 시너지 | 동일 + 6대 자동허가 정량 |
| **analyze** | in vitro head-to-head (§1-1) + Franz cell | 동일 |
| **synthesize** | GMP 시제품 제작 (의약외품 GMP) | CGMP 시제품 |
| **verify** | 인체적용시험 (§1-3) + 마이크로바이옴 (§1-4) | 동일 + 24주 임상 (기능성 시) |
| **handoff** | 의약외품 신고/품목허가 (식약처) + 양산 + 쿠팡·약국 | 화장품 신고 (+ 기능성 심사) + 양산 + 쿠팡·D2C |
