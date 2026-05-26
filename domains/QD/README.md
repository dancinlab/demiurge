# 💊 QD — 의약외품(quasi-drug) 라인업 컨테이너

> 🧪 **R&D 정공법** ([PLAYBOOK.md](PLAYBOOK.md)) — 모든 자식 도메인은 7-verb (spec → structure → design → analyze ⟲ → synthesize → verify → handoff) 따라 진행.
> 단순 sourcing/OEM 카피가 아닌 **분류 바운더리 내 first-principles 효능 우위 자체 R&D + 실측 검증**. 시판 TOP 대비 head-to-head 우위 입증이 목표.

> 쿠팡 등 일반 유통 채널에 풀 의약외품 SKU 라인업을 도메인 단위로 진행하는 컨테이너 폴더.

---

## 폴더명 결정 기록

### 후보 비교

| 후보 | 길이 | 의미 | 평가 |
|---|---|---|---|
| **`QD/`** ⭐ | 2자 | quasi-drug (의약외품 영문 약어) | **채택** — Occam, 도메인 prefix와 1:1 일치 |
| `QD-LINEUP/` | 9자 | 라인업 의도 명시 | 폴더가 도메인스러워 자식과 혼동 |
| `quasi-drug/` | 10자 | 국제 표기·풀네임 | 안전·검색성은 좋으나 폴더 prefix와 불일치 (자식은 `QD-`) |
| `OTC/` | 3자 | over-the-counter | ❌ **부정확** — OTC = 일반의약품(약국 전용) ≠ 의약외품 |
| `medsupply/` | 9자 | medical supplies | ❌ 의료기기(medical device)와 혼동 |

### 채택 사유

- **자식 도메인 prefix와 1:1 일치** — 폴더 `QD/` ↔ 자식 `QD-MASK`, `QD-SANITIZER` … 식별 명확
- **Occam (g0)** — 가장 짧으면서 의미 충분
- **OTC와의 구분 강조** — QD(의약외품)는 약국 외 일반 유통 가능, OTC(일반의약품)는 약국 전용. 약어 혼동을 막기 위해 명시적으로 `QD` 채택

---

## 자식 도메인 구조

```
domains/QD/
├── README.md              ← 이 문서
├── DOMAINS.tape           ← 로스터 (자식 5개)
├── QD-MASK.md             ← 🪧 마스크
├── QD-MASK.log.md
├── QD-SANITIZER.md        ← 🧴 손소독제
├── QD-SANITIZER.log.md
├── QD-BAND.md             ← 🩹 밴드·창상피복재
├── QD-BAND.log.md
├── QD-PAD.md              ← 🌸 생리대
├── QD-PAD.log.md
├── QD-GARGLE.md           ← 💧 가글액
├── QD-GARGLE.log.md
├── QD-FWASH.md            ← 🌷 여성청결제
├── QD-FWASH.log.md
├── QD-MWASH.md            ← 🧔 남성청결제
├── QD-MWASH.log.md
├── QD-HSHAMPOO.md         ← 💈 남성 탈모 샴푸 (분류 경계 — 기능성 화장품 가능성↑)
├── QD-HSHAMPOO.log.md
├── QD-HSPRAY.md           ← 💨 남성 탈모 스프레이 (비-미녹시딜만)
├── QD-HSPRAY.log.md
├── QD-INCONT.md           ← 🍼 요실금 패드 (TOP1 · 시니어 폭발)
├── QD-INCONT.log.md
├── QD-TPASTE.md           ← 🦷 약용 치약 (TOP2 · 반복구매 끝판)
├── QD-TPASTE.log.md
├── QD-LENS.md             ← 👁 렌즈 세정액 (TOP3 · 구독 락인)
├── QD-LENS.log.md
├── QD-ECOPAD.md           ← 🌱 친환경 생리대 (TOP4 · 프리미엄)
├── QD-ECOPAD.log.md
├── QD-PETHYG.md           ← 🐾 펫 위생용품 (TOP5 · 동물용 별도 분류)
├── QD-PETHYG.log.md
├── QD-KIDS-KIT.md         ← 🧒 키즈 위생 키트 (캐릭터 라이선스)
├── QD-KIDS-KIT.log.md
├── QD-POSTPART.md         ← 👶 산모 회음부 케어
├── QD-POSTPART.log.md
├── QD-INSECT.md           ← 🦟 모기 기피·살충 (의약외품+살생물제)
├── QD-INSECT.log.md
├── QD-SANSURF.md          ← 🧹 표면 살균제 (B2C+B2B)
├── QD-SANSURF.log.md
├── QD-AWAKE.md            ← 🎓 졸음방지 패치 (수능 시즌)
└── QD-AWAKE.log.md
```

---

## 자식 도메인 일람

| 도메인 | 아이콘 | 별칭 | 주요 SKU 예시 |
|---|---|---|---|
| `QD-MASK` | 🪧 | 마스크 | 보건용(KF80/KF94) · 비말차단(KF-AD) · 수술용 |
| `QD-SANITIZER` | 🧴 | 손소독제 | 에탄올계 젤 · 액상 · 미스트 |
| `QD-BAND` | 🩹 | 밴드 | 일반밴드 · 방수밴드 · 습윤 드레싱 |
| `QD-PAD` | 🌸 | 생리대 | 일반형 · 슬림 · 오버나이트 · 면 생리대 |
| `QD-GARGLE` | 💧 | 가글액 | 구강세정제 · 인후염 가글 |
| `QD-FWASH` | 🌷 | 여성청결제 | 약산성 데일리 · 생리기용 · 유기농 |
| `QD-MWASH` | 🧔 | 남성청결제 | 데일리 · 스포츠 · 민감용 |
| `QD-HSHAMPOO` | 💈 | 남성 탈모 샴푸 | 비오틴·카페인·살리실산 (★ 의약외품 인증 라인업 차별화 — 시장 90% 기능성화장품) |
| `QD-HSPRAY` | 💨 | 남성 탈모 스프레이 | 두피 토닉·비-미녹시딜 (★ 의약외품 인증 차별화 · 미녹시딜=일반의약품 제외) |
| `QD-INCONT` | 🍼 | 요실금 패드 | 시니어·산후 (🔥🔥🔥🔥🔥 TOP1) |
| `QD-TPASTE` | 🦷 | 약용 치약 | 잇몸·미백·항균 (🔥🔥🔥🔥 TOP2) |
| `QD-LENS` | 👁 | 렌즈 세정액 | 다목적·과산화수소·하드 (🔥🔥🔥🔥 TOP3) |
| `QD-ECOPAD` | 🌱 | 친환경 생리대 | 비건·유기농·생분해 (🔥🔥🔥🔥 TOP4) |
| `QD-PETHYG` | 🐾 | 펫 위생용품 | 동물용 의약외품 (⚠ 별도 분류 · TOP5) |
| `QD-KIDS-KIT` | 🧒 | 키즈 위생 키트 | 캐릭터 라이선스·KC+의약외품 이중 |
| `QD-POSTPART` | 👶 | 산모 회음부 케어 | 산후조리원 B2B 채널 |
| `QD-INSECT` | 🦟 | 모기 기피·살충 | DEET·이카리딘 (⚠ 기피제+살생물제 분리) |
| `QD-SANSURF` | 🧹 | 표면 살균제 | 차아염소산·과산화수소 (B2C+B2B) |
| `QD-AWAKE` | 🎓 | 졸음방지 패치 | 멘톨·카페인 (수능 시즌) |

---

## QD vs 약사법 카테고리 (혼동 방지)

| 약어 | 정식 | 한국 약사법 분류 | 일반 유통 |
|---|---|---|---|
| **QD** | quasi-drug (의약외품) | ✅ 일반 유통 가능 | 쿠팡·마트·편의점 OK |
| OTC | over-the-counter (일반의약품) | ❌ 약국 전용 | 약국·온라인약국만 |
| RX | prescription drug (전문의약품) | ❌ 처방 필요 | 처방전 + 약국만 |

---

## 진행 공통 단계 (4-funnel)

자식 도메인 마일스톤 공통 템플릿:

1. **discovery** — 시장·카테고리·경쟁 SKU·규제 스캔
2. **sourcing** — 제조사/OEM 발굴 · 식약처 허가증 확보
3. **listing** — 쿠팡 셀러센터 등록 · 광고 문구 규제 점검 (식약처 행정처분 회피)
4. **launch** — 발주·재고·첫 노출 (광고 키워드/리뷰 워밍)

---

## 운영 규칙

- **광고 문구**: "치료", "효능 100%", "예방" 등 의약품 효능 표현 금지 (식약처 행정처분 리스크)
- **품목 허가증**: 직접 제조/수입 시 필수, 단순 재판매는 불요 (통신판매업 신고만 필요)
- **수입자 자격**: 해외직구 형태 판매 시 수입자 별도 자격 필요 (구매대행과 구분)
