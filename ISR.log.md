# ISR — log

Append-only history sister of `ISR.md`. Each entry starts with `## <ISO timestamp> — <header>` (newest on top); body = `- [x]` (done) / `- [ ]` (pending) checkbox tasks.

## 2026-05-24T22:00:00Z — M2 4종 DES 약물 한계 매핑 완료

- [x] §1 4종 약물 개요 표 (sirolimus · everolimus · zotarolimus · biolimus A9)
- [x] §2 mTORC1 공통 표적 + PI3K→AKT→mTORC1→S6K1/4E-BP1 pathway ASCII
- [x] §3 PK / 약물학 차이 표 (logP · IC50 · release t½ · burst · polymer)
- [x] §4 임상 효능 (LLL + TLR @12mo) — SIRIUS · SPIRIT · ENDEAVOR · RESOLUTE · LEADERS · NOBORI · BIOFLOW-V + Korean (EXCELLENT · HOST-REDUCE · RESET · GRAND-DES)
- [x] §5 5가지 미해결 wall — (a) 단일 표적 escape · (b) NA 미해결 · (c) delayed healing → late ST · (d) HBR DAPT 부담 · (e) DES-in-DES 효과 ↓
- [x] §6 M3 hook — 비-mTOR 표적 5축 (lipid·염증 · healing-selective · DAPT-free · 직교내성)
- [x] 산출물 `ISR/M2_current.md` (188 lines)

🔑 핵심: 4종 모두 FKBP12 → mTORC1 단일 경로 의존 → escape · NA 미해결 → M3 비-mTOR 표적 inventory 필수.

## 2026-05-24T22:00:00Z — M3 비-mTOR 신규 표적 inventory 완료

- [x] §1 5 family overview 표
- [x] §2 YAP/TAZ · HIF · ROCK · BET · Wnt deep-dive
- [x] §3 NA 표적 매트릭스
- [x] §4 mTOR 회피 logic + pathway ASCII
- [x] §5 안전성 우려 first-pass
- [x] §6 M4 short-list hooks
- [x] 산출물 `ISR/M3_targets.md` (~276 lines)

🔑 핵심: 5 family 중 **ROCK (fasudil/netarsudil) · PCSK9 · GLP-1R** 가 NA + safety + maturity 3축에서 우수. HIF · Wnt 는 safety red flag (polycythemia/tumor · 골 toxicity) 로 보류.

## 2026-05-24T21:25:00Z — M1 4-axis 기전 매핑 완료

- [x] §1 ISR 정의 + BMS/DES 세대별 빈도
- [x] §2 시간축 — early (NH) vs late (NA) 패러다임 시프트 ASCII
- [x] §3 4-axis (NH · NA · SF · US) × OCT/IVUS finding
- [x] §4 NH 메커니즘 (mTOR 경로 — 현행 DES 모두 동일 표적)
- [x] §5 NA 메커니즘 (d2 wall — 표적 부재) + 신규 표적 short-list (YAP/TAZ · HIF · ROCK · BET · PCSK9 · GLP-1R)
- [x] §6 세대별 ISR rate 표 (BMS / 1G / 2G / bioabsorbable polymer)
- [x] §7 Mehran 1999 패턴 분류 (DCB 효과 hooks)
- [x] §8 한국인 registry hooks (K-DES · EXCELLENT · HOST-IDEA · GRAND-DES)
- [x] 산출물 `ISR/M1_mechanism.md` (~170 lines)
- [ ] M3 신규 표적 효능 ranking
- [ ] M5 DCB Mehran 패턴별 효과

🔑 핵심 통찰:
- 2nd-gen DES 시대 잔여 wall = **neoatherosclerosis (3-10년)** — 늦은 시점이 새로운 적
- 현행 DES 모두 **mTOR 단일 표적 의존** → 비-mTOR 신규 표적 (M3) 필수
- NA → late stent thrombosis · ACS 인과 (Nakazawa 2011 autopsy)

## 2026-05-24T21:00:00Z — scaffold

- [x] @goal 확립 — ISR 비-mTOR 후보 short-list
- [x] M1-M8 milestone 설계
- [x] M1 4-axis 기전 매핑
