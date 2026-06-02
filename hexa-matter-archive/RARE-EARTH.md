# RARE-EARTH — 17-원소 가족 레퍼런스 (한글 SSOT)

> **구조 사이블링**: [`RARE-EARTH.tape`](RARE-EARTH.tape) — agent용 structured supplement
>
> **범위 분리** (governance #4 domain-meta-domain):
> - 본 파일 = 17원소 가족 / 응용 / 공급 / 위기 anchors (REFERENCE)
> - 대체 로드맵 → [`RARE-EARTH+ALTERNATIVE.md`](RARE-EARTH+ALTERNATIVE.md)
> - 광물 우산 → [`CRITICAL-MINERAL.md`](CRITICAL-MINERAL.md)
> - 재활용 → [`RECYCLING.md`](RECYCLING.md) · [`HEXA-RECYCLE.md`](HEXA-RECYCLE.md)
> - 자석 심층 → [`MAGNETIC-MATERIALS.md`](MAGNETIC-MATERIALS.md) · [`METALLURGY-DEEP.md`](METALLURGY-DEEP.md)
> - 신소재 후보 → [`NOVEL.md`](NOVEL.md) §3.5 `hxm-mag-*`

---

## 1. 원소 가족 (n=17)

| 분류 | 원소 | 비고 |
|---|---|---|
| **LREE** (경희토) | La, Ce, Pr, Nd, Pm, Sm, Eu | Pm은 방사성 — 자연 부존 없음 |
| **HREE** (중희토) | Gd, Tb, Dy, Ho, Er, Tm, Yb, Lu, Y | Y는 이온반경상 HREE 분류 |
| 별도 | Sc | USGS / IEA 별도 취급 |

부존 패턴:
- LREE: 모나자이트(monazite) + 바스트내사이트(bastnaesite) 광석
- HREE: 화남 + 미얀마의 이온흡착점토(ion-adsorption clay)에 집중

---

## 2. 주요 응용

| 원소 | 핵심 응용 |
|---|---|
| Nd, Pr | NdFeB 영구자석 — EV 모터, 풍력 발전기, HDD 보이스코일, 로보틱스 |
| Dy, Tb | NdFeB 보자력 첨가제 — 150°C 이상 열안정성 (EV 모터 운전 envelope) |
| Sm | SmCo (1:5, 2:17) 자석 — 고온 항공우주, 의료, 방산 |
| Eu, Tb, Y | 형광체 — 레거시 CRT, 백색 LED 적/녹 emitter, 디스플레이 |
| La, Ce | FCC 촉매 (석유 정제), Ni-MH 배터리 (레거시 HEV) |
| Gd | MRI 조영제, 자기열량 냉각 / H₂ 액화 |
| Er, Yb | EDFA 광섬유 증폭기, 고체 레이저 호스트 |
| Sc | Al-Sc 항공우주 합금 (Airbus A380 floor beam, 적층제조 wire) |
| Ho, Tm, Lu | 연구급 — 니치 광학, 의료 동위원소, NMR shift reagent |

---

## 3. 공급 집중도 (2024-2026)

| 지표 | 값 | 출처 |
|---|---|---|
| 중국 채굴 점유 | ~70% | USGS MCS 2025 |
| 중국 정제(분리+금속+합금) 점유 | ~90% | USGS MCS 2025 |
| 중국 HREE 정제 점유 | ~100% | (Dy/Tb 독점) |
| 한국 희토류 수입 의존도 | 91.2% from China | 산업통상자원부 2025-2026 |
| ROW NdPr 생산 확대 (2024→2030) | 4.4× | Bloomberg Intelligence |
| 2030 글로벌 NdPr 부족 전망 | 36% | (위 확대해도) |
| 글로벌 수요 성장률 | ~7%/yr | (EV + 풍력 견인) |
| 독자 공급망 재건 소요 | 20-30년 | (mine → separation → metal → alloy → magnet) |

---

## 4. 비중국 공급 프로젝트

| 단계 | 프로젝트 |
|---|---|
| 가동 중 | Lynas (Mt Weld AU + Kuantan MY), MP Materials (Mountain Pass US), Energy Fuels / Neo Performance (US/EE) |
| 램프업 | Iluka Resources (Eneabba AU 정제소 2026+), Vital Metals (Saskatoon CA — paused), Pensana (Longonjo AO) |
| 재활용 (상용 규모) | Solvay La Rochelle FR (2025+), Cyclic Materials CA, REEsolve · Phoenix Tailings (Boston) |

**정직 caveat**: 2030년까지 모든 프로젝트가 nameplate 도달해도 글로벌 정제 capacity의 ~10% 수준. 중국 구조적 우위 유지.

---

## 5. 외부 anchors

| 출처 | 역할 |
|---|---|
| [USGS Mineral Commodity Summaries 2025](https://pubs.usgs.gov/periodicals/mcs2025/mcs2025-rare-earths.pdf) | 미 정부 1차 anchor — 글로벌 채굴 + 매장량 |
| [IEA Global Critical Minerals Outlook 2024](https://www.iea.org/reports/global-critical-minerals-outlook-2024) | 2040 수요 3-7× 전망 |
| EU Critical Raw Materials Act (2024) | EU 전략/위기 광물 리스트; 17 REE 그룹 포함; 2030 ≥10% 채굴 / ≥40% 정제 / ≥25% 재활용 EU 내 |
| 한국 희토류 공급망 종합대책 (산업통상자원부 2026-02) | 1조 원 5년 기금; 17 REE 핵심광물 지정; 비축 확대; 재활용 보조금; 자석 컨소시엄 |

---

## 6. 거버넌스 — 본 파일 범위 한정

`RARE-EARTH.md` / `.tape`는 17원소 가족의 REFERENCE만 담당합니다.
- 대체 / 공정 / 후보 detail은 sibling 파일들로 위임 (위 frontmatter 참조)
- 공급률 수치는 USGS / IEA / EU CRM / Bloomberg / Adamas 등 명명 anchor만 인용 — 벤더 self-report는 금지 (관행적으로 정부 통계와 1.5-3× 괴리)
