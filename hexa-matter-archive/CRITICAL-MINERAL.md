# CRITICAL-MINERAL — 수출통제 광물 우산 도메인 (한글 SSOT)

> **구조 사이블링**: [`CRITICAL-MINERAL.tape`](CRITICAL-MINERAL.tape)
>
> **범위**: REE + Ga + Ge + Sb + W + Co + Li + graphite + Mg + Ti + Nb + Ta 12개. 1-카드 요약 + 2023-2026 PRC 수출통제 연대표. 깊이는 verb / 도메인 파일로 위임.

---

## 1. 12개 commodity 선정 근거

다음 3개 리스트의 교집합:
- USGS Critical Minerals List 2022
- EU Critical Raw Materials Act 2024 (strategic + critical 그룹)
- 2023-2025 PRC 수출통제 발표 대상

수요견인(Li · Co · graphite — 배터리) + 공급견인(Ga · Ge · Sb · W — 수출통제) 둘 다 의도적으로 포함.

---

## 2. 중국 가공 점유 (2024-2025)

| 광물 | 중국 점유 |
|---|---|
| REE 정제 | ~90% |
| 흑연 음극재 (구상화) | ~75% |
| 텅스텐 (W) | ~80% |
| 안티몬 (Sb) | ~60% |
| 갈륨 (Ga) | ~98% (1차 저순도) / ~80% (7N+ 고순도) |
| 게르마늄 (Ge) | ~60% (1차 정제) |
| 마그네슘 (Mg) | ~85% (1차 금속 제련) |
| 코발트 (Co) 정제 | ~70% (DRC 채굴 → 중국 정제) |
| 리튬 (Li) 정제 | ~65% (배터리급 LiOH/Li₂CO₃) |
| Nb / Ta | 낮음 (브라질 + 호주가 우세 — 중국 집중 아님) |

출처: USGS MCS 2025 + IEA Critical Minerals Outlook 2024 + Adamas Intelligence quarterly

---

## 3. PRC 수출통제 연대표 (2023-2026)

| 일자 | 조치 |
|---|---|
| 2023-08 | Ga + Ge 이중용도 라이선스 요구 시행 |
| 2023-12 | 흑연(graphite) 라이선스 요구 시행 |
| 2024-08 | Sb 라이선스 요구 시행 |
| 2024-12 | Ga + Ge + Sb 對美 수출 봉쇄 (specific block) |
| 2025-04 | 7개 중/중희토 원소 + REE 영구자석 라이선스 요구 시행 — Sm · Gd · Tb · Dy · Lu · Sc · Y (**Nd/Pr는 아직 미포함**) |
| 2025-10 | 확장 REE 통제 발표 (역외 관할권 포함) |
| 2025-11 | 미·중 12개월 휴전 합의 — 통제 일시중단 2026-11-10까지 |
| 2026-01 | (보도) 對日 REE 사실상 통제 — 방위 공급망 표적 |
| 2026-? | 2026-11-10 만료 — 연장 / 선별 재시행 / 전면 복귀 3시나리오 |

출처: CSIS, FDD, European Parliament, IEA

---

## 4. Commodity 1-카드 요약

### 4.1 REE-17
- 지배 공급자: 중국 (정제 90%, 채굴 ~70%)
- 주 용도: 영구자석 (Nd/Pr/Dy/Tb), 형광체 (Eu/Tb/Y), 촉매 (La/Ce)
- 대체: 6-트랙 로드맵 → [`RARE-EARTH+ALTERNATIVE.md`](RARE-EARTH+ALTERNATIVE.md)
- 세부 → [`RARE-EARTH.md`](RARE-EARTH.md)

### 4.2 갈륨 (Ga)
- 지배: 중국 (~98% 1차, ~80% 고순도)
- 용도: GaAs / GaN 전력 + RF 반도체, LED, CIGS PV
- 대체: GaN ↔ SiC 부분 (전력); InP (일부 RF); HEMT는 drop-in 없음
- 세부 → [`COMPOUND-SEMI.md`](COMPOUND-SEMI.md)
- 상태: 2023-08부터 PRC 라이선스, 2024-12부터 對美 봉쇄

### 4.3 게르마늄 (Ge)
- 지배: 중국 (~60% 정제), DRC + 러시아 보조
- 용도: 광섬유 코어, IR 광학, PET 중합 촉매, GaAs/Ge tandem PV
- 대체: 제한적 — Si 일부; 광섬유 코어 / 4-junction concentrator PV는 drop-in 없음
- 상태: 2023-08 라이선스, 2024-12 對美 봉쇄

### 4.4 안티몬 (Sb)
- 지배: 중국 (~60%), 러시아 + 타지키스탄 보조
- 용도: 납축전지 grid, 난연제 (Sb₂O₃), 탄약, liquid-metal 배터리
- 대체: Bi 일부; 탄약 primer는 drop-in 없음
- 상태: 2024-08 라이선스

### 4.5 텅스텐 (W)
- 지배: 중국 (~80%)
- 용도: WC cemented carbide(절삭공구), 필라멘트, 전극, 합금화
- 대체: 세라믹 절삭공구 일부; 공구강 고온강도는 drop-in 없음
- 세부 → [`METALLURGY-DEEP.md`](METALLURGY-DEEP.md) · [`SUPERALLOY.md`](SUPERALLOY.md)

### 4.6 코발트 (Co)
- 지배: DRC 채굴 (~70%), 중국 정제 (~70%)
- 용도: NMC 양극(Li-ion), 초합금(제트엔진), 공구강
- 대체: LFP (Tesla 2022+ 전환); Ni-rich (NMC 9-0.5-0.5) Co 감축; 제트엔진 초합금은 drop-in 없음
- 세부 → [`SUPERALLOY.md`](SUPERALLOY.md) · `NOVEL.md` §3.2 (`hxm-cath-*`)

### 4.7 리튬 (Li)
- 지배: 호주 + 칠레 채굴, 중국 정제 (~65%)
- 용도: Li-ion 배터리 (양극 + 전해질염 LiPF₆)
- 대체: Na-ion (CATL 2023+ 상용, ~70% Wh/kg of LFP); 고체전해질 Li (Li 자체 대체 아님)
- 세부 → `NOVEL.md` §3.2 + §3.3

### 4.8 흑연 (배터리급)
- 지배: 중국 (~75% 구상화 음극재)
- 용도: Li-ion 음극 (천연 + 합성)
- 대체: Si-anode 하이브리드 (5-10% Si 2024+ 일반화); 순수 Si / Li-metal 음극 R&D 단계
- 세부 → [`GRAPHENE-CARBON.md`](GRAPHENE-CARBON.md) · `NOVEL.md` §3.2

### 4.9 마그네슘 (Mg)
- 지배: 중국 (~85%)
- 용도: 경량 합금 (자동차 + 항공), Al-합금 탈황, Mg-air 배터리 R&D
- 대체: Al 합금 부분; 최경량 구조 금속은 drop-in 없음

### 4.10 티타늄 (Ti)
- 지배: 중국 (~50% 스폰지), 러시아 (~25%) — VSMPO-AVISMA가 최대 단일 공급자
- 용도: 항공기 동체, 제트엔진, 의료용 임플란트, 해수 열교환기
- 대체: Al-Li 일부; 초합금 부분; 팬블레이드 / 생체적합 임플란트 drop-in 없음

### 4.11 / 4.12 Nb / Ta
- 지배 분포: 브라질 + 호주 우세, 중국 집중 아님
- 본 위협 매트릭스에 포함은 EU CRM Act 2024 strategic 리스트 정합성 위해

---

## 5. 거버넌스

### 5.1 본 파일 = 우산만 (`@D g1_scope_umbrella`)

CRITICAL-MINERAL은 1-카드 요약 + 통제 연대표만. material-property deep dive는 verb / 도메인 파일로 위임:

- REE → [`RARE-EARTH.md`](RARE-EARTH.md) · [`RARE-EARTH+ALTERNATIVE.md`](RARE-EARTH+ALTERNATIVE.md)
- Ga · Ge → [`COMPOUND-SEMI.md`](COMPOUND-SEMI.md)
- Co · Li · graphite (배터리) → `NOVEL.md` §3.2-§3.4
- W · Ti · 초합금 원소 → [`METALLURGY-DEEP.md`](METALLURGY-DEEP.md) · [`SUPERALLOY.md`](SUPERALLOY.md)
- graphite (탄소) → [`GRAPHENE-CARBON.md`](GRAPHENE-CARBON.md)

### 5.2 공급률 anchor (`@D g2_concentration_anchors`)

공급 점유율은 USGS MCS / IEA / EU CRM만 인용. 벤더 / 산업협회 수치는 권위적으로 인용 금지 (정부 통계와 1.5-3× 괴리).

### 5.3 정책 추측 금지 (`@D g3_no_political_speculation`)

발표/검증된 수출통제만 기록. 미래 PRC/US/EU 정책 추측 금지. 단, 명명된 분석(CSIS · FDD · EP · IEA)의 시나리오 인용은 허용.

---

## 6. 금지 패턴

| ID | 패턴 |
|---|---|
| `@F f1_substitution_as_solved` | 벤더 대체 가용성 마케팅 클레임을 envelope-match 검증 없이 수용 금지 |
| `@F f2_recycling_silver_bullet` | 수요 2배 상품(Li · Co · graphite)은 향후 10년 재활용 >20% 공급 불가 (배터리 1차 수명 8-15년, EoL wave 미진) |

---

## 7. 외부 anchors

| 출처 | 역할 |
|---|---|
| USGS Critical Minerals List 2022 | "critical" 판정 anchor |
| IEA Global Critical Minerals Outlook 2024 | 글로벌 수급 전망 |
| EU CRM Act 2024 | EU 전략/위기 광물 + 2030 소싱 threshold |
| [CSIS — REE Export Restrictions](https://www.csis.org/analysis/consequences-chinas-new-rare-earths-export-restrictions) | think-tank |
| [FDD — China Blocks REE to Japan](https://www.fdd.org/analysis/2026/01/12/china-reportedly-blocks-rare-earth-exports-to-japan-targeting-defense-supply-chains/) | think-tank |
| [EP Briefing — China REE Restrictions](https://epthinktank.eu/2025/11/24/chinas-rare-earth-export-restrictions/) | EU 정부 |
| [arxiv:2605.02926](https://arxiv.org/abs/2605.02926) | QCCM critical mineral resilience |
| [arxiv:2508.00556](https://arxiv.org/abs/2508.00556) | REE 산업 시스템 무역 리스크 |
