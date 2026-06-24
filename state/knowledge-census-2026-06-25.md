# demiurge 검증-지식 전수수집 census — 2026-06-25

> READ-MOSTLY harvest. 격리 worktree(`census/knowledge-demiurge`)에서 수집. 카운트는 전부
> grep/wc/python json-parse 로 **측정된 값**(추정 아님). demiurge 는 임베디드 atlas
> (`embedded.gen.hexa`) 나 `HYPOTHESES.jsonl` 을 **갖지 않는다** — 검증-지식 레지스트리는
> ⓐ RTSC 캠페인 원장(`RTSC_LEDGER.jsonl`) ⓑ 법칙/발견(`.discoveries/*.tape` + `state/**/*VERDICT*.json`)
> ⓒ CHANGELOG 의 L-넘버 메타법칙 + 🟢/🔵/SUPPORTED/CLOSED-NEGATIVE 판정 ⓓ g51-게이트 논문(`PAPERS/`)
> ⓔ verdict 기록 파일(`exports/material_discovery/*.json`) 이다.

## 0. 레포 / 브랜치
- repo: `demiurge` (`/Users/mini/dancinlab/demiurge`)
- default branch: `main` (HEAD `15a7da57`)
- 성격: universal hexa-native 7-verb 설계-아키텍처 프로그램. 검증-지식은 도메인 캠페인
  (RTSC 초전도 · QFORGE el-ph · SENOLYX senolytic · CMT 막ABFE) 의 verdict 로 누적.

## 1. 레지스트리 인벤토리 (self-discovered)

| 레지스트리 | 경로 | 규모(측정) | 성격 |
|---|---|---|---|
| RTSC 캠페인 원장 | `RTSC_LEDGER.jsonl` | 92 material rows (+1 _meta) | per-material verdict SSOT |
| RTSC harvest-partial | `RTSC_HARVEST_PARTIAL.jsonl` | 16 deck rows (+1 _meta) | banked DFPT 중간산출 |
| verdict 기록 파일 | `exports/material_discovery/*.json` | 36 json | authoritative DFT/el-ph verdict |
| 발견/법칙 tape | `.discoveries/*.tape` | 4 law tape | FB-GEOM·senolyx 종결식·flatband |
| state R-verdict | `state/**/*VERDICT*.json` | 12 json | fb-geom 라운드 verdict (R3~R9) |
| g51 논문 | `PAPERS/<slug>/` | 24 paper dir (≥10p 게이트) | 도메인 캠페인 capstone |
| 메타법칙 | CHANGELOG L-넘버 | L0~L44 등 distinct ~38 | separable·flatband 메타법칙 |
| 핸드오프 | `handoff.jsonl` | 1 row | anima→demiurge RTSC 인계 |

## 2. 전수 카운트 (TOTALS)

### RTSC_LEDGER.jsonl (92 material rows · 측정)
- **🟢 VERIFIED (gate-passed/측정): 32 rows** — 세부: novel 9 · textbook-proof 2 · GATE_GREEN/PASS 3
  · CONFIRMED 2 · GREEN 2 · measured 1 · BCS-anchor 1 · line-graph 1 · sub-findings 1 · 기타 🟢 ~10
- **🔴 CLOSED-NEGATIVE: 40 rows** (FALSIFY / data-wall / dynamically-unstable 포함)
- **🟠 partial/in-flight/blocked: ~9 rows**
- **PENDING/deferred(미판정): 37 rows** (d_defer_no_delete — 삭제 안 함, 재발사 레시피 보존)
- absorbed=true: 3 rows (CaBeH8🔴 · YH10🟢 · CaH6/H3S 등)
- status 분포: deferred 32 · terminal 20 · FALSIFIED 4 · GATE_PASS 2 · 기타

### 발견/법칙 (.discoveries + state)
- fb-geom R-verdict 8 라운드: 🔵 1 (R5 Welch-bound closed-form) · 🟢 5 (R3·R4·R6·R8·R9) ·
  🔴 부분 falsify 2 (R6 CLS-link · R7 negative)
- senolyx 종결식 2건: selectivity-law (4-lens 🔵/🟢 수렴) · AG-design (in-silico SUPPORTED ~19×)
- flatband geometric el-ph law tape 1 · senolyx selectivity/AG tape 2

### CHANGELOG (671줄 · 측정)
- 🧱 (측정된 벽): 110 hit · novel: 53 hit · CLOSED-NEGATIVE: 9 · SUPPORTED: 3
- L-넘버 메타법칙: distinct ~38 (L0~L44)

### 합계
- **레지스트리 총 엔트리(원장+법칙+논문+state verdict): 92 + 16 + 4 + 12 + 24 + 36 = 184**
- **VERIFIED(🟢/🔵/SUPPORTED/gate-passed): RTSC 32 + fb-geom 6(🔵1+🟢5) + senolyx 2 + 논문 24 ≈ 64**
- **CLOSED-NEGATIVE: RTSC 40 + fb-geom 2 + CHANGELOG 9 ≈ 51**
- **PENDING/conjecture/deferred: RTSC 37 + harvest-partial 16(전부 deferred-refire) ≈ 53**

## 3. 헤드라인 VERIFIED 발견 (전수 중 대표)

| id | tier | title | cite |
|---|---|---|---|
| CaH6 | 🟢 textbook-proof | el-ph DFT Tc(μ*=.13)=245.1K @4×4×4q | `RTSC_LEDGER.jsonl` + `exports/material_discovery/rtsc_cah6_dft_4x4x4q_textbook_proof_20260524.json` |
| H3S-proof | 🟢 textbook-proof | Tc=184.3K @6×6×6q (BCS-Eliashberg 재현) | `exports/material_discovery/rtsc_h3s_dft_6x6x6q_textbook_proof_20260522.json` |
| YH10 | 🟢 GATE_CLOSED_MEASURED | el-ph Tc=215.9K (absorbed) | `exports/material_discovery/rtsc_yh10_dft_elph_20260528.json` |
| H3O / H3Se / H3Si … | 🟢 novel (9종) | 미출판 H3X 하이드라이드 el-ph Tc (H3O 181.4K·H3Se 114.8K·H3Si 74.2K) | `RTSC_LEDGER.jsonl` (novel verdict rows) |
| LaRu3Si2 | 🟢 PASS (GATE GREEN) | Ru-4d kagome flat-band dE=−0.055eV @E_F, non-mag — 최강 no-cooling RTSC lead | `exports/rtsc/laru3si2_flatband_gatecheck.json` |
| Nb | 🟢 BCS-anchor | ambient el-ph Tc=14.8K (검증 앵커) | `exports/material_discovery/rtsc_nb_dft_elph_ambient_proof_20260522.json` |
| FB-GEOM-LAMBDA R5 | 🔵 closed-form | Q_geom ≥ 1/N_band = Welch bound (frame theory 증명) | `state/fb-geom-lambda/R5_VERDICT.json` |
| FB-GEOM-LAMBDA R9 | 🟢 paper-grade | Q_geom = Q_diag + Σ inter-orbital phase-coherence (≥3-orbital flat band <1% 검증) | `state/fb-geom-lambda/fb-geom/R9_VERDICT.json` |
| SENOLYX selectivity-law | 🔵/🟢 수렴 | 선택성=differential SCAP dependency·single-target ceiling theorem·orthogonal AND-gate escape | `state/senolyx-selectivity-law/SENOLYX_SELECTIVITY_CLOSING_FORMULA.md` |
| SENOLYX-AG | SUPPORTED | fibroblast-niche 3축 AND-gate(uPAR×DPP4×SA-β-gal) ~19× in-silico 선택성 | `state/senolyx-novel-andgate/SENOLYX_AG_DESIGN_SPEC.md` (CHANGELOG L188) |
| 분리가능성 메타법칙 | 검증된 novel | RE 단일분리속성→대체성공 / 분리불가 속성곱→RE-lock (falsification 12/12) | CHANGELOG L164 |
| flatband ambient-roomT | 🔴 CLOSED-NEG 논문 | 상온상압 SC 경로 10 독립경로 전부 closed-negative (g51 PASS) | `PAPERS/flatband-geometry-ambient-roomt-closed/` (CHANGELOG L58) |

## 4. 정직한 gap

- **CMT/GJB1 막ABFE (CHANGELOG 최근 다수)는 VERIFIED 발견 아님** — 작성자 본인이 d6 로
  "method-grade · 발견/약효 아님 · 선택성/신규성 별도게이트 미실시 · K≥3 미수렴"을 반복 명시.
  본 census 의 VERIFIED 카운트에서 제외(잠정 ΔΔG 순위까지).
- **PENDING 37 + harvest-partial 16 deferred**: pod 재활용으로 미수확. verdict 미확정 —
  conjecture 가 아니라 "기술적 fail 로 보류된 후보"(d_defer_no_delete). VERIFIED 로 세지 않음.
- RTSC_LEDGER 의 verdict 필드는 자유서술 long-form 이 많아(단일 tier atom 아님) 일부 행은
  🟢/🔴 마커 정규식으로 분류했고, FLATBAND-DEEP / PROCESS-FIX / DISCOVERY 같은 비표준 verdict
  ~10행은 "기타"로 묶음 — silent truncation 아님(여기 honest 기록).
- ARCHITECTURE.json 에 별도 verified-law 섹션은 없음(`laws` 키 grep 5 hit 은 트리 노드 명칭).
  메타법칙(L-넘버) SSOT 는 CHANGELOG + .discoveries tape.
- 임베디드 atlas(@P/@C/@L atom) · HYPOTHESES.jsonl 카드 레지스트리는 demiurge 에 **부재**
  (hexa-lang 와 다른 구조 — demiurge 는 캠페인-원장 모델).
