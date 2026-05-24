# CARDIO+ PAPER — arxiv-style 통합 논문

> 4개 cardio 트랙 (NOREFLOW · DAPTPGX · ISR · LPA) 통합 arxiv-style LaTeX 논문 scaffold.
> demiurge CARDIO+ 메타도메인 X10 (paper-ready) 산출물.

## 구조

| 파일 | 내용 |
|---|---|
| `main.tex` | 본문 (abstract + §1-§9 + appendix + 14 refs) — ~10 pages 목표 (g51) |
| `figures/overview_prompt.txt` | Figure 1 생성용 fal.ai 프롬프트 (provenance) |
| `figures/overview.png` | Figure 1 — 4-track + 3-axis stratification (⏳ 생성 대기) |

## 본문 섹션 매핑

| § | 내용 | source (CARDIO+/) |
|---|---|---|
| §2 | g5 verification rubric | `CARDIO+.md` g5 |
| §3 | T1 No-reflow + PK eq + IRI ODE | `NOREFLOW/M2·M4·M12` |
| §4 | T2 DAPT PGx + Hill eq | `DAPTPGX/M1·M2` |
| §5 | T3 ISR non-mTOR | `ISR/M3` |
| §6 | T4 Lp(a) silencing + Δ% eq | `LPA/M1·M3·M4` |
| §7 | cross-domain synthesis (MC robustness · 3-axis · 4-trial) | `X1` + `NOREFLOW/M12.3` |
| appendix | verification ledger | `X1_unified_claims.md` |

## 핵심 수식 (verify oracle 매핑)

| eq | 식 | hexa verify calc fn | tier |
|---|---|---|---|
| (1) pk_2comp | `∫C(t)dt = D/(V·k10)` mass-balance | `pk_2comp` (atlas, PR #658) | 🟢→🔵 trajectory |
| (2) hill | `θ = L^n/(Kd^n+L^n)` | `hill(L,Kd,n)` (atlas) | 🟢→🔵 trajectory |
| (3) ldl_pct | `Δ% = (final-baseline)/baseline×100` | `ldl_pct` (atlas) | 🟢→🔵 trajectory |

## figure 생성 (toolchain 복구 후)

⚠ 2026-05-25 현재 pool-route escalated 환경에서 `_imagine.hexa` skill `--root` compile error로 차단됨.

복구 후:
```
/imagine CARDIO+/PAPER/figures/overview_prompt.txt CARDIO+/PAPER/figures/overview.png -s landscape_16_9
```
또는 toolchain 정상 host에서:
```
hexa run $(command -v _imagine.hexa) <prompt> <out.png> -s landscape_16_9
```

## compile (toolchain 복구 후)

```
/paper compile CARDIO+/PAPER
```
또는 직접:
```
cd CARDIO+/PAPER && pdflatex main && pdflatex main && pdflatex main
```
(3-pass: TOC + ref 해소)

## g51 lint 상태

| 요구 | 상태 |
|---|---|
| ≥10 pages | ⏳ compile 후 확인 (abstract + 9 §+ appendix + 14 refs로 충족 예상) |
| ≥1 fal.ai figure | ⏳ figure 생성 대기 (pool-route 복구 후) |

## g5 honest 고지

- 본문 수치 (PK · IRI ODE · MC · power) = 🟢 SUPPORTED-NUMERICAL (CARDIO+/*/verify/V3 재현)
- 메커니즘 · 역학 = 🟡 SUPPORTED-BY-CITATION
- 5-axis 가중치 · trial effect-size 투영 = ⚪ SPECULATION-FENCED
- colchicine acute-MI = 🔴 FALSIFIED (OASIS-9 / CLEAR SYNERGY null)
- 임상 효능 주장 없음 — wet-lab + RCT는 downstream
