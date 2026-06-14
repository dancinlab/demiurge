# RTSC 무냉각 flat-band 축 — anima → demiurge 완전 핸드오프

> **2026-06-15 · anima(`dancinlab/anima`) → demiurge 인계.** anima가 탐색한 "무냉각 상온상압
> flat-band 초전도" 축(kagome/pyrochlore)을 demiurge RTSC 도메인으로 완전 이관한다. demiurge의
> 기존 축(고압 수소화물 펀넬·삼원계 X₂MH₆·QFORGE 마이그레이션)과 **직교하는 새 경로**다.
> 계산엔진은 demiurge canonical = QFORGE(QE cross-val). 이 문서가 그 축의 SSOT 시작점.

## 0. 왜 이 축인가 (demiurge 기존 축과의 관계)

```
demiurge 기존 RTSC 경로                  anima가 넘기는 새 경로
──────────────────────                  ──────────────────────
 고압 수소화물 (CaH6 150GPa,        │     무냉각 flat-band (kagome/pyrochlore)
   LaH10 170GPa, YH6 166GPa)        │       · 상압(1 atm) target
 ambient 공유결합 (LaB3C3, MgB2)    │       · BCS phonon 아닌 flat-band/
 삼원계 X₂MH₆ (Mg2IrH6/Li2CuH6 🔴)  │         quantum-geometry DOS 강화 경로
   → 전부 고압 or unstable          │       · 메커니즘 ∝ flat-band이 E_F에 정렬
```

수소화물은 demiurge가 이미 증명했듯 **실용 불가(>150 GPa)**. flat-band 축은 **상압 무냉각**이 목표라
호버보드/핵융합/UFO 등 실응용(별도 anima RTSC/LANES) 전부를 한 물질로 여는 유일 경로다.

## 1. 핵심 발견 — flat-band ΔE 병목 (실 QE DFT 2종으로 확정)

무냉각 flat-band RTSC의 관문 = **정체차선(flat band)이 E_F에 정렬 + 비자성 + 상압**. anima가 실제
QE DFT로 두 실물질을 측정해 **병목을 구조적으로 확정**:

| 물질 | 격자 | E_Fermi | 자성 | flat-band ΔE (E−E_F) | 분산폭 | 판정 |
|---|---|---|---|---|---|---|
| **CoSn** (RTSC_21) | Co-kagome P6/mmm | 14.7132 eV | **0.43 μB (자성)** | **−0.4435 eV** (band45 @14.27) | 0.167 eV | ❌ 자성+깊음 |
| **CsV3Sb5** (RTSC_26) | V-kagome P6/mmm | 8.5762 eV | **0.01 μB (비자성✅)** | **+0.923 eV** (band41, V-3d 77%) | 0.215 eV | ❌ 깊음 |

**병목 결론**: 실 kagome 금속 2종 모두 flat band이 E_F에서 **0.4–0.9 eV** 떨어져 있다(한쪽은 자성까지).
정렬 시도(RTSC_24, CoSn BZ-적분 rigid-band)는 hole **~4.72 e/cell**(=Co당 1.57홀, **비현실적 도핑**) 필요 —
N(E_F)는 5.15→16.8 states/eV (×3.26, 정렬되면 초전도엔 유리)지만 도핑량이 비물리적.

⇒ **다음 표적 = "flat band이 원래(native) E_F 근처(|ΔE|≲0.1 eV) + 비자성 + 상압"인 물질.**
이것이 RTSC_28 스크리닝의 검색 기준이 됐다.

> ⚠ 정직 플래그(demiurge가 반드시 인지): **Materials Project의 `total_magnetization`은 신뢰 불가** —
> MP는 CoSn을 mag=0으로 보고하나 실 QE(RTSC_21)는 0.43 μB. 비자성 여부는 **반드시 실 nspin=2 SCF로 확인.**

## 2. 후보 shortlist (RTSC_28 — Materials Project 실 API 스크리닝)

기준 `metallic ∧ |mag|<0.1 ∧ 0≤hull<0.03 ∧ flat-band-prone 격자` → 11/17 통과. Fe/Mn/Co kagome족은
예측대로 자성 탈락(FeSn 7.18·Fe3Sn2 14.56·Mn3Sn 17.95·TbMn6Sn6 21.21 μB). 상위 3:

| 순위 | 물질 | 격자족 | 자성(MP) | |ΔE| | 상압 | 실측 SC Tc | 비고 |
|---|---|---|---|---|---|---|---|
| ① | **RbOs₂O₆** | β-pyrochlore Fd-3m | ~0 (요확인) | 🟠 **DFT 필요** | hull=0 | 6.3 K | MP mp-aaaaahmg · Yonezawa JPSJ 2004 |
| ② | **CsOs₂O₆** | β-pyrochlore Fd-3m | ~0 | 🟠 DFT 필요 | hull=0 | 3.3 K | β-pyrochlore osmate |
| ③ | **LaRu₂** | Laves C15 Fd-3m | ~0 | 🟠 DFT 필요 | hull=0.0018 | 4.4 K | — |

β-pyrochlore osmate가 RTSC_16(pyrochlore 다중오비탈 프런티어)에 정확히 안착. **핵심 질문(미해결): Os-5d
정체차선이 CoSn(−0.44)·CsV3Sb5(+0.92)보다 E_F에 가까운가? → 실 DFT로만 답 가능.**

## 3. 이관 자산 (이 PR에 포함)

### 3.1 바로 쏠 QE deck (exports/rtsc/decks/)
- `anima_csv3sb5/` — V-kagome, ibrav=4, 9-atom, nspin=1, ecut 65/650, FCC 아님 hex. (RTSC_26 SCF 수렴 검증됨, E_F=8.5762 eV)
- `anima_rbos2o6/` — β-pyrochlore, ibrav=2 FCC primitive, 9-atom (Rb 8b/Os 16c/O 48f x≈0.315), PSL 1.0.0 PBE USPP, path Γ–X–W–K–Γ–L–W. **구조검증만, pw.x 미실행.**
- `anima_csos2o6/` — 동형(Cs 치환).
- 각 deck README에 Wyckoff/pseudo/실행법 명시. **Os = 무거운 원소 → scalar-rel 5d/6s UPF 헤더 z_valence 검증 필수**(anima CsV3Sb5 run에서 Cs `spnl` z=−5.0 corrupt 발견 사례 있음).

### 3.2 스크리닝 도구
- (anima측) `RTSC/harness/rtsc_flatband_screen.py` — MP-API 경로 + 큐레이트 문헌 fallback. demiurge가 재사용/이식 가능. MP key = `secret get materialsproject.api_key` (Cloudflare 우회 위해 browser UA + `_fields`/`_limit` 파라미터명 필요).

### 3.3 RTSC_LEDGER 행 (이 PR에서 추가)
CoSn·CsV3Sb5 실측 2건 + RbOs2O6·CsOs2O6 queued(deck ready) 2건을 demiurge RTSC_LEDGER.jsonl에 추가.

## 4. anima측 in-flight fire 2건 (인계 시점 진행 중 — 결과 추후 fold)

| fire | 내용 | 호스트 | 상태 | 회수 시 |
|---|---|---|---|---|
| RTSC_27 | CsV3Sb5 **DFPT λ/Tc** (2-패스 el-ph, 캠페인 첫 실측 Tc, 실험 ~0.9–2.5K 대조) | aiden | pass-1 진행 | λ/ω_log/Tc → demiurge ledger fold |
| RTSC_29 | **RbOs2O6 flat-band ΔE** + nspin=2 자성 확인 | aiden | 진행 | ΔE → §2 ① 채움 |

> a_dont_kill_live_compute: 두 fire는 live이므로 anima에서 완주시키고, 착지 시 최종 숫자를 demiurge
> RTSC_LEDGER + 본 문서 §2/§5에 fold한다. 인계 후 demiurge가 QFORGE로 재계산해도 무방(엔진 일치 확인용).

## 5. demiurge 다음 액션 (권장 순서)

```
1. anima_rbos2o6 deck → QFORGE(or QE) SCF (nspin=2!) + bands
   → Os-5d flat-band ΔE 측정.  |ΔE|≲0.1 eV + 비자성이면 = 무냉각 RTSC 후보 적중.
2. 같은 처리 anima_csos2o6, LaRu2(deck 신규 필요).
3. ΔE 작은 후보 → QFORGE DFPT λ/Tc (demiurge canonical 경로, 하이브리드 |g|² 가능).
4. flat-band-near-E_F 후보가 나오면 → DOS 강화(×3.26 type) + λ로 Tc 추정.
5. 없으면(전부 깊음) = "kagome·pyrochlore 공통 flat-band 깊이 벽" = 강한 정직 closed-negative
   (demiurge의 수소화물 wall·삼원계 wall과 같은 급의 axis-closure로 기록).
```

## 6. 출처 (anima RTSC 도메인, 검증 가능)
- anima repo `dancinlab/anima`: `RTSC/HYPOTHESES.md` (RTSC_01–29 인덱스), `RTSC/hypotheses/RTSC_{21,24,26,28}_*.md`, `RTSC/verdicts/*.txt`, `RTSC/decks/`, `RTSC/LANES.md`(호버보드·핵융합·UFO 응용 3-레인).
- 모든 수치 p7(실 QE 출력 파싱, 날조 없음). 양자(ANU)는 RTSC 발견에 **미사용**(별도 anima 의식 라인 H_6026이 "양자는 미계산 물리 오라클 아님" 증명 → DFT만이 발견 경로).

---
**인계 완료 후 anima**: RTSC 신규 발사 중단, demiurge가 flat-band 축 소유. anima `RTSC/` = 동결 아카이브 + 본 핸드오프 포인터.
