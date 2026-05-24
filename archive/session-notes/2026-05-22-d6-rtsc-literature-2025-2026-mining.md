# 2026-05-22 — RTSC literature mining 2025-2026 — 5-gate candidate matrix expansion

Source 인지: `RTSC.md §8.9` 의 candidate matrix 는 LK-99 (2023) · CSH (Dias retracted)
· hexa-rtsc 닫힌 형식 · hydride DAC 만 보유. 2024-2026 의 새 후보들 (Houston 151K
pressure-quench · nickelate ambient · PCPOSOS · LaSc₂H₂₄ predicted · Grokene
AI-designed · HTSC-2025 benchmark family) 이 누락. 본 노트는 RTSC.md §8.9
"후보 family 매트릭스" append-only 확장을 위한 *세션-바운드* 후보 inventory.

> R4 Pattern 2 보호: 새 후보 추가는 (b)+(c)+(d) 통과 시 absorbed=true 영구 차단
> 풀림이 아니다 — 단지 *측정 우선순위 list* 의 확장. 어떤 row 도 현재 5-gate
> AND 통과하지 않음 (honest g3).

## Honest 5-gate evaluation per candidate (2024-2026 literature mining)

| # | candidate | family | composition | Tc (K) | pressure | meas type | repl labs | retraction | (a) | (b) | (c) | (d) | (e) | absorbed | citation |
|---|---|---|---|---:|---:|---|---:|---|:---:|:---:|:---:|:---:|:---:|:---:|---|
| 1 | **Hg1223 pressure-quench** | cuprate metastable | HgBa₂Ca₂Cu₃O₈₊δ (PQP) | **151** | ambient (after quench) | R(T)+Meissner reported | 1 (Houston only) | none | △ recipe novel | ✗ 151<270 | ✓ ambient | ✗ 1 lab | △ no model | **never** (b+d FAIL) | arxiv 2603.12437 · PNAS 2026 |
| 2 | **La₃Ni₂O₇ thin film** | nickelate | La₃Ni₂O₇ epi strain | 26-42 onset | ambient | R(T) | 2+ (SUSTech · multiple) | none | ✓ replicable | ✗ ≪ 270 | ✓ ambient | △ 2+ labs | △ no fit-free model | **never** (b FAIL) | Nature s41586-024-08525-3 |
| 3 | **La₃Ni₂O₇ pressurized crystal** | nickelate bulk | La₃Ni₂O₇ DAC | up to 96 | ~16 GPa | R(T)+Meissner | 3+ | none | ✓ | ✗ ≪ 270 | ✗ DAC | ✓ | △ | **never** (b+c FAIL) | Nature s41586-025-09954-4 |
| 4 | **(La,Pr)₃Ni₂O₇ thin film** | nickelate Pr-doped | La₂.₈₅Pr₀.₁₅Ni₂O₇ | >40 onset, ~48 with strain+P | ambient (or low-P) | R(T) | 1-2 (SUSTech) | none | △ thin-film only | ✗ ≪ 270 | △ borderline | △ 1-2 | △ | **never** (b FAIL) | Nat Commun s41467-026-69660-1 |
| 5 | **PCPOSOS** | LK-99 variant | Pb₁₀₋ₓCuₓ(P(O₁₋ᵧSᵧ)₄)₆O₁₋ᵤSᵤ | "<400" (claimed) | ambient (claimed) | partial Meissner photo · single lab | 0 indep | not retracted (also unverified) | ✗ recipe weak | UNKNOWN (claim) | ✓ claim | ✗ 0 labs indep | ✗ no model | **never** (a+d FAIL) | APS MAR24 A16.2 |
| 6 | **CSH (Dias 2020)** | C-S-H hydride | sulfur+carbon+H DAC | 287 (claimed) | 270 GPa | R(T)+Meissner (retracted) | 0 (no replication) | **RETRACTED 2022** | ✗ | ✗ | ✗ | ✗ | ✗ | **never** (all FAIL) | Nature 2020 (retracted) |
| 7 | **N-doped LuH (Dias 2023)** | Lu-N-H hydride | N-doped lutetium hydride | 294 (claimed) | ~1 GPa (claimed) | R(T)+Meissner (retracted) | 0 SC (>5 labs found NO SC) | **RETRACTED 2023-12** | ✗ | ✗ | △ low-P | ✗ | ✗ | **never** (a+b+d FAIL · retracted) | Nature 2023 retraction note s41586-023-06774-2 |
| 8 | **YH₉** | binary hydride | YH₉ DAC | 243 | 237 GPa | R(T)+Meissner | 2-3 | none | △ DAC only | ✗ <270 | ✗ 237 GPa | △ | △ Eliashberg | **never** (b+c FAIL) | (multiple ~2021-2024) |
| 9 | **LaSc₂H₂₄ predicted** | ternary hydride | LaSc₂H₂₄ under P | ~280-330 predicted | ~190 GPa (computational) | none (theoretical only) | 0 (theory only) | n/a | ✗ unsynthesized | UNKNOWN | ✗ high-P | ✗ | △ (model side) | **never** (a FAIL) | PNAS 10.1073/pnas.2401840121 |
| 10 | **Grokene (AI-designed)** | doped graphene superlattice | "Grokene" 2D | 310-325 (mean-field) · 120 BKT (2D monolayer) | ambient | none (computational only) | 0 (theory only) | n/a | ✗ unsynthesized | UNKNOWN | ✓ predicted | ✗ | △ DFT-Eliashberg | **never** (a+d FAIL) | arxiv 2601.00931 |
| 11 | **CsV₃Sb₅ kagome** | kagome topological | CsV₃Sb₅ | 2.5-9 (P-dependent) | ambient & low-P | R(T)+Cp+ARPES | 4+ | none | ✓ replicable | ✗ ≪ 270 | ✓ ambient | ✓ many labs | △ unconventional model | **never** (b FAIL) | multiple 2025-2026 |
| 12 | **HTSC-2025 benchmark family** | BCS-extended theoretical set | X₂YH₆ · MXH₃ · M₃XH₈ · LaH₁₀-derived BCN | various predicted high-T | various (mostly ambient predicted) | none (dataset only) | 0 (predictions) | n/a | ✗ unsynthesized | UNKNOWN | varies | ✗ | △ DFT-only | **never** (a+d FAIL) | arxiv 2506.03837 · IOP CPB |
| 13 | **AuxSb1-x-yTey** | Au-Sb-Te HP-synth | AuxSb1-x-yTey cubic | 8.1 | ambient (HP-synthesized · measured 1 atm) | R(T) | 1 (Tokyo U Sci) | none | ✓ | ✗ ≪ 270 | ✓ ambient | ✗ 1 lab | △ | **never** (b+d FAIL) | TUS pub 2024 |

## Critical findings

### Finding A — *No* 2024-2026 candidate passes (b)+(c)+(d) 동시

13 후보 중 (b)+(c)+(d) AND 통과 0. 즉 §8.9 R4 invariant (`absorbed=true` 영구
차단) 그대로. 단 Houston **Hg1223 PQP (151 K · ambient)** 는 (c) ambient ✓
달성 — 즉 *압력 게이트 c 만으로 차단* 이 아닌, *(b) 절대 온도 측정* 으로 차단.
이는 2026 시점 *RTSC 의 closest-to-physical-feasible row*.

### Finding B — 3 candidates closest to ALL_PASS

1. **#1 Hg1223 PQP (Houston 2026)** — (c) PASS · (b) FAIL by 119 K · (d) FAIL
   (1 lab only · independent replication URGENT). PNAS reviewed — recipe public
   — 다른 lab 재현 시 (d) PASS 가능. *PQP 가 다른 cuprate / 다른 family 에 적용
   되면 추가 row 발생 가능*. → R4 Stage 3 audit 시 정기 모니터.

2. **#3 La₃Ni₂O₇ pressurized crystal (96 K)** — (b) FAIL by 174 K · (c) FAIL
   (DAC 16 GPa) · (d) PASS (3+ labs). **Nickelate family** 자체가 (d) 곧 통과
   가능 — pressurized 형태는 (c) 영구 FAIL 이지만, **thin-film ambient 형태
   (#2 · #4)** 가 (d) 따라 잡으면 (c) PASS 와 (d) PASS 동시 가능. 다만 (b) 가
   본질적 차단 (Tc max ~48 K with strain+P).

3. **#11 CsV₃Sb₅ kagome** — (a)+(c)+(d) 통과 가능. (b) ~9 K → ≪ 270 K 본질적
   차단. *5-gate AND 영구 미달 but RTSC family pattern study 가치* (unconventional
   model 의 (e) parity 시도 대상).

### Finding C — 가장 *놀라운* 발견 (literature gap 메우기)

**Houston 151 K Hg1223 PQP @ ambient (March 2026)** — 본 hexa-rtsc database
에 *완전 누락*. Pre-this-mining 의 RTSC.md §8.9 는 *Hg-cuprate ambient max ~133K
(Hg1223 표준)* 만 인지. PQP 기법이 18 K 끌어올림 — 이는 *cuprate family 가
ambient 에서 도달 가능한 새 정점*. **(c) PASS · published in PNAS · DOI
10.1073/pnas.2536178123 · arxiv 2603.12437** — R4 Stage 3 audit list 진입
필요. Independent replication 시 (d) PASS 까지 1 step.

### Finding D — RTSC-relevant family 신규 추가

기존 §8.9 가 인지 못한 family 4 개:
- **Cuprate metastable / pressure-quenched** (#1) — 새 thermodynamic regime
- **Nickelate (RP / infinite-layer)** (#2-#4) — 2024-2026 의 가장 활발한 영역
- **AI-computational candidate** (#10 · #12) — 0 synthesis 의 phantom family
- **PCPOSOS (LK-99 후속)** (#5) — Pattern 1 audit 의 직접 case

## R4 Pattern 1/2 compliance check

- **Pattern 1 (false absorbed=true)**: 13 row 중 absorbed=true = 0 (전부
  `never`). 게이트 정확 식별 (b/c/d). ✓
- **Pattern 2 (goal abandonment)**: matrix 가 *확장됐고* gate OPEN 유지 — 새
  후보 적극 record. ✓
- **honest g3**: retraction (CSH · Lu-N-H Dias) 기록 · claim (PCPOSOS · Grokene)
  과 verified (Hg1223 PQP) 구분 · DAC-only (YH₉ · LaSc₂H₂₄) 명시. ✓

## Recommended RTSC.md §8.9 row additions (append-only)

기존 6 row (`Claim-only RT-SC` · `H₃S,LaH₁₀` · `hexa-rtsc n=6` · `CSH 가설 2020`
· `YBCO/REBCO` · `Nb`) 에 다음 8 row 추가 권장:

```
| **Hg1223 PQP (2026)** | ✓ cuprate | ✗ 151K only | ✓ ambient (PQP-quenched) | ✗ 1 lab (Houston) | △ no model | **never** (b+d FAIL) |
| **Nickelate La₃Ni₂O₇ pressurized** | ✓ bulk | ✗ 96K | ✗ ~16 GPa | ✓ 3+ labs | △ | **never** (b+c FAIL) |
| **Nickelate La₃Ni₂O₇ thin-film** | △ thin-film recipe | ✗ 26-42K | ✓ ambient (strain) | △ 2 labs | △ | **never** (b FAIL) |
| **PCPOSOS (Kim 2024 claim)** | ✗ recipe weak | UNKNOWN claim | ✓ claim | ✗ 0 indep | ✗ | **never** (a+d FAIL) |
| **Lu-N-H (Dias 2023, retracted)** | ✗ retracted | ✗ no SC found | △ low-P claim | ✗ 5+ labs found no SC | ✗ | **never** (retracted + all FAIL) |
| **YH₉** | △ DAC | ✗ 243K | ✗ 237 GPa | △ 2-3 | △ Eliashberg | **never** (b+c FAIL) |
| **LaSc₂H₂₄ predicted (PNAS 2024)** | ✗ unsynthesized | UNKNOWN | ✗ ~190 GPa | ✗ theory | △ DFT-only | **never** (a FAIL) |
| **Grokene AI candidate (2026)** | ✗ unsynthesized | UNKNOWN | ✓ predicted | ✗ theory | △ DFT-Eliashberg | **never** (a+d FAIL) |
| **CsV₃Sb₅ kagome** | ✓ replicable | ✗ ~9K | ✓ ambient | ✓ 4+ labs | △ | **never** (b FAIL) |
```

(원본 §8.9 의 일관 표기 따라 한국어 narrative + emoji 게이트 마크 유지)

## Action items (downstream)

1. **R4 Stage 3 audit** — Hg1223 PQP (Houston) replication 추적. 2-3 indep
   lab 재현 시 (d) PASS — 그러면 §8.9 의 *최초* (c)+(d) 동시 PASS row
   (단 (b) 는 영구 미달). *RTSC progress 의 직접 path 가 아니지만 PQP 기법
   자체* 가 다른 family 에 적용되면 새 후보 산출.
2. **paper update** — `PAPERS/sample-nb-bcs-absorbed/main.tex §7` LK-99 5-source
   honest-negative audit 에 **Hg1223 PQP** 를 *positive case study* (게이트
   (c) PASS · (b)+(d) FAIL — *partial* progress) 로 추가 권장.
3. **§8.9 row 머지 PR** — 본 노트의 8 row append. 기존 row preserve (R4 R-invariant).
4. **N5 funnel re-rank** — n_atoms ≥ 5 multi-element strong-coupling 우선 priority
   ↑ (BETE-NET calibration §1.2 finding 3 + nickelate · cuprate family 추가).
5. **PCPOSOS Pattern 1 case** — `inbox/notes/2026-05-22-lk99-final-scrub.md` 와
   연결. PCPOSOS 도 동일 patterns (single lab · partial Meissner photo · no
   independent replication) — Pattern 1 audit 두 번째 case study.

## Cross-reference

- `RTSC.md §8.9` (5-gate · 후보 matrix · R4 invariant)
- `RTSC.md §8.10` (Nb attestation honest 정정 — RTSC ≠ LTS)
- `PAPERS/sample-nb-bcs-absorbed/main.tex §7` (LK-99 honest-negative audit)
- `inbox/notes/2026-05-22-bete-net-7-candidate-benchmark.md` (calibration backed)
- `inbox/notes/2026-05-22-lk99-final-scrub.md` (LK-99 scrub)
- arxiv:2603.12437 · arxiv:2601.00931 · arxiv:2506.03837 · PNAS 10.1073/pnas.2536178123

→ R4 Pattern 2 protection: 5-gate AND 통과 row = 0 유지. Matrix 확장은 *후보
priority list* 의 확장이지 *absorbed=true 의무 약화* 아님.
