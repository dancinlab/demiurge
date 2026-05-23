# V4 — NOREFLOW final tier ledger (partial · V2 placeholder)

> NOREFLOW verify schema V4 · current-state · no history.
> 거버넌스: @D g5 rubric · @D d1 (non-wet-lab completed-form) · @D d2 (wall → breakthrough path 명시).
> 입력 = V1 master inventory (72 claim) + V3 numerical (4 track) + M10 ⚪ fence (15 항목) + M12 simulation.
> **partial 사유**: V2 🔵 push가 hexa-lang PR #658 (`noreflow-clinical-calc-extension`) **OPEN** 상태 — 🔵 row는 placeholder + PR merge gate 명시. d2 거버넌스에 따라 "포기" 대신 "fill 예약 + re-fire 트리거".

---

## 1. V4 ledger 정의 + 거버넌스

### 1.1 V4 = NOREFLOW 도메인 전체 claim의 final tier verdict ledger

V4는 V1 (claim inventory + tier triage) · V2 (🔵 formal push) · V3 (🟢 numerical push) · M10 (⚪ fence) · M12 (simulation) 전체를 흡수해 **하나의 final tier 표**로 통합한다. 다음과 같은 invariants:

- 모든 LLM grade self-declare 금지 — V1 · V3 · M10 verbatim 인용만.
- `hexa verify` CLI verdict는 verbatim block으로 보존 (LLM 가공 X).
- 🔵 row는 atlas-registered identity proof 도달 후 fill — 현재 V2 PR #658 OPEN 상태이므로 **placeholder + gate state 명시**.

### 1.2 g5 rubric verbatim (`hexa verify rubric`)

```
hexa verify — cross-project tier rubric (TECS-L-aligned, LATTICE_POLICY real-limits-first)

  🔵 SUPPORTED-FORMAL      hexa-native calc reproduces a CLOSED-FORM/symbolic
                           identity exactly — TECS-L n6-rep Tier 1 (pure-math,
                           deterministic) · g_self_verify · anima HEXAD g_verdict_tier_blue(a)
  🟢 SUPPORTED-NUMERICAL   hexa-native NUMERICAL recompute matches (libm/Newton,
                           non-symbolic) — TECS-L n6-rep Tier 2 (~10min suite)
  🟡 SUPPORTED-BY-CITATION atlas/literature registered, NO hexa recompute
                           (external sympy/citation carry — never auto-🔵)
  🟠 INSUFFICIENT          not in atlas + no calc path (g_tier_default default)
  🟠 DEFERRED              external hw/data/API dep — TECS-L Tier 3 (GPU) /
                           g_external_calc_forbidden (closure-external)
  🔴 FALSIFIED             calc DETERMINISTICALLY disagrees with the claim —
                           a CLOSED negative (TECS-L result-agnostic: PASS or
                           FAIL both verified-closed; ≠ INSUFFICIENT)
  ⚪ SPECULATION-FENCED    imagination/metaphor (hexa-bio AXIS) — verify N/A,
                           SF ≠ proven (g4 honest fence)
```

→ V4 는 본 rubric 정확히 6 등급 + 1 deferred 변형을 verdict 형식으로 채택.

### 1.3 partial gate — PR #658 state

```
gh pr view 658 --repo dancinlab/hexa-lang --json state,mergedAt,title,url
{
  "mergedAt": null,
  "state":    "OPEN",
  "title":    "inbox(patches): NOREFLOW clinical calc atlas extension RFC (5 fns)",
  "url":      "https://github.com/dancinlab/hexa-lang/pull/658"
}
```

→ 🔵 row 11건은 `mergedAt = null` 동안 placeholder. PR merge 후 V2 agent re-fire (NOREFLOW/verify/V2_formal_identities.md 생성 + `hexa verify --expr` 5건 + atlas `register --from-verify --auto-pr`).

---

## 2. 도메인 요약 (NOREFLOW 12 base + V1-V4 schema)

### 2.1 milestone roster

| M | title | status | output |
|---|---|---|---|
| M1 | no-reflow 4-cause 매핑 | [x] | NOREFLOW/M1_causes.md |
| M2 | mPTP 차단 후보 inventory | [x] | NOREFLOW/M2_mptp.md |
| M3 | 미세혈관 보호 약물 short-list | [x] | NOREFLOW/M3_microvasc.md |
| M4 | 국소 전달 vs systemic | [x] | NOREFLOW/M4_delivery.md |
| M5 | 임상 측정 endpoint | [x] | NOREFLOW/M5_endpoint.md |
| M6 | off-target / 안전성 | [x] | NOREFLOW/M6_safety.md |
| M7 | 후보 통합 ranking + d2 wall breakthrough | [x] | NOREFLOW/M7_rank.md |
| M8 | 한국인 KAMIR / K-ACTION registry | [x] | NOREFLOW/M8_korea.md |
| M9 | web/arxiv deep evidence (2021-2026) | [x] | NOREFLOW/M9_deep_research.md |
| M10 | ⚪ honest fence | [x] | NOREFLOW/M10_fence.md |
| M11 | formal grade-up pass (atlas 확장 후 🔵) | [ ] | (pending PR #658) |
| M12 | simulation pass (PK · IRI · MC · power) | [x] | NOREFLOW/M12_simulation.md |

### 2.2 verify schema status

| V | title | status | output |
|---|---|---|---|
| V1 | claim inventory + tier triage | [x] | NOREFLOW/verify/V1_claim_inventory.md (437 lines · 72 claims) |
| V2 | 🔵 push (formal identities) | [ ] | (PR #658 OPEN gate) |
| V3 | 🟢 push (numerical recompute) | [x] | NOREFLOW/verify/V3_numerical_recompute.md (134 lines · 4 tracks) |
| V4 | final tier ledger (본 파일) | partial | NOREFLOW/verify/V4_tier_ledger.md |

### 2.3 cross-domain context

```
demiurge cli list-domains  →  Domains (21):
  $DOM:bio · $DOM:brain · $DOM:chem · $DOM:chip · $DOM:clinical · ...
```

→ NOREFLOW 은 현재 demiurge **명시 domain 등록 없음** (clinical 아래 sub-thread). V4 ledger 합산 후 `clinical/noreflow` 등록 또는 별도 `cardio` 도메인 신설 고려 — atlas 확장과 별도 절차.

---

## 3. 🔵 SUPPORTED-FORMAL ledger (placeholder · V2 pending)

> 본 섹션은 **placeholder** — V1 §4 에서 🔵 도달 후보 11건 추출. 모든 row 마다 다음 gate 명시:
> 
> **⏳ V2 atlas 확장 PR #658 OPEN — gate pending**

### 3.1 PR #658 state (verbatim)

```
{
  "state":    "OPEN",
  "mergedAt": null,
  "title":    "inbox(patches): NOREFLOW clinical calc atlas extension RFC (5 fns)",
  "url":      "https://github.com/dancinlab/hexa-lang/pull/658"
}
```

### 3.2 🔵 placeholder 11 row (V1 §4 verbatim subset)

| # | claim | source | expected closed-form | expected `hexa verify --expr` (PR merge 후) | gate state |
|---|---|---|---|---|---|
| B1 | mPTP open prob Ca²⁺ Hill cooperativity n=4-6 | M2 §1 | `P_open(Ca) = (Ca/K)^n / (1+(Ca/K)^n)` | `hexa verify --expr hill_mptp 900 0.998` | ⏳ PR #658 OPEN |
| B2 | IR lethal window mPTP 누적 fraction (0-5min) | M1 §2 | `∫₀^5 dF_open/dt dt` | `hexa verify --expr lethal_window_cum 300 <v>` | ⏳ PR #658 OPEN |
| B3 | TIMI flow grade 0-3 frame-based 정의 | M1 §3, M5 §2 | `TIMI = f(distal_landmark_frame)` | `hexa verify --expr timi_grade <frame> <v>` | ⏳ PR #658 OPEN |
| B4 | cTFC LAD 보정 1.7× identity | M1 §3, M5 §2 | `cTFC_LAD = raw × 1.7` | `hexa verify --expr ctfc_lad_correct <raw> <v>` | ⏳ PR #658 OPEN |
| B5 | IMR = Pd × Tmn identity (Fearon 2003) | M1 §3, M5 §2.1 | `IMR = Pd × Tmn @ hyperemia` | `hexa verify --expr imr_pdtmn 0.8 50 40` | ⏳ PR #658 OPEN |
| B6 | CsA Ki selectivity ratio (CypD/CypA/calcineurin) | M2 §3 | `selectivity = Ki_target / Ki_off` | `hexa verify --expr selectivity_ki <kt> <ko> <v>` | ⏳ PR #658 OPEN |
| B7 | arm-to-heart compartment lag | M4 §2.1 | `t_lag = V_circ / Q_cardiac` | `hexa verify --expr armheart_lag <V> <Q> <v>` | ⏳ PR #658 OPEN |
| B8 | IC vs IV Cmax ratio closed-form | M4 §2.2 | `C_IC/C_IV = dilution × t½_factor` | `hexa verify --expr cmax_ic_iv_ratio <args> <v>` | ⏳ PR #658 OPEN |
| B9 | TIMI/MBG/IMR cutoff (per-endpoint formal) | M5 §2 | per-endpoint formal definition table | `hexa verify --expr endpoint_cutoff <e> <v>` | ⏳ PR #658 OPEN |
| B10 | CypD Ser191 phospho fraction → ΔP_open shift | M9 §3 | `ΔP_open(phospho) atlas-registered` | `hexa verify --expr popen_phospho_shift <f> <Δ>` | ⏳ PR #658 OPEN |
| B11 | M7 5-axis weighted score formal compute | M7 §1 (정의만) | `Σ w_i × s_i` (score = closed-form 합산) | `hexa verify --expr weighted_score <vec> <v>` | ⏳ PR #658 OPEN |

### 3.3 fill 예약 + re-fire 트리거

```
gate: PR #658 mergedAt != null  AND  hexa-lang main rebuild includes 5 new fns
trigger: V2 agent fan-out  →  /Users/ghost/core/demiurge/NOREFLOW/verify/V2_formal_identities.md
action:  per-row  →  hexa verify --expr <fn> <n> <v>  →  verbatim verdict block paste
follow: atlas register --from-verify <fn> <n> <v> --auto-pr   (per @D g_atlas_binary_builtin)
```

**d2 governance**: PR #658 review 지연 시 — (a) PR 직접 review/merge nudge, (b) inbox patch 별도 sibling repo dance, (c) atlas `register --from-drill` 우회 (manual 등록 + 후속 PR). 포기 X — fill 경로 3개 boundary.

---

## 4. 🟢 SUPPORTED-NUMERICAL ledger (V3 4 tracks verbatim)

### 4.1 track 별 verdict (V3 §3.1 verbatim)

```
V3.1 PK (IC vs IV lethal window timing) = 🟢 SUPPORTED-NUMERICAL
  recompute: ssh ubu-1 'python3 /tmp/m12_pk.py'
  artifact : tmax_ic = 3.0 s · tmax_iv = 300.0 s · ratio = 536×
  claim    : M4 §3 IC tmax ≤ 3s · IV tmax > 180s (lethal window)
  match    : YES (direction · timing) · magnitude broader

V3.2 IRI ODE (mPTP Hill + salvage + ferroptosis) = 🟢 SUPPORTED-NUMERICAL
  recompute: ssh ubu-1 'python3 /tmp/m12_iri.py'
  artifact : Hill(900, 200, 4) = 0.998 · CIRCUS 93.5% → IC-sync 56.9% · Δ=36.6 pp
  claim    : M2 §4 Path B "IC + reperfusion-synced 가 d2-wall 돌파" 정량 정당화
  match    : YES (Δ=36.6 > 15 pp threshold)

V3.3 Monte Carlo (M7 robustness) = 🟢 SUPPORTED-NUMERICAL
  recompute: ssh ubu-2 'python3 /tmp/m12_mc.py'
  artifact : adenosine IC 100% Tier-A · nicorandil 100% Tier-A · volatile=0 all
  claim    : M7 ranking robust under weight perturb + milestone ablation (F2 gap)
  match    : YES

V3.4 Power calc primary (n=500 · 15% rel red) = 🟢 SUPPORTED-NUMERICAL
  recompute: ssh ubu-1 'python3 /tmp/m12_power.py'
  artifact : power(n=250/arm) = 0.798 ≈ 0.80
  claim    : M7 §5.1 Trial-A NICORADENO design adequate
  match    : YES
```

### 4.2 🟢 4 track table

| Track | Claim | Numerical method | Host | Verdict | Grade |
|---|---|---|---|---|---|
| V3.1 | IC tmax ≤ 3s · IV tmax > 180s · Cmax ratio direction | `two_comp` ODE · scipy odeint | ubu-1 | ratio = 536× (dir match) | 🟢 |
| V3.2 | Hill mPTP + lethal window 누적 + Path B Δ ≥ 15pp | `hill(Ca,K,n)` libm + scipy odeint + cumsum | ubu-1 | Δ = 36.6 pp · open_frac 0.998 | 🟢 |
| V3.3 | M7 Tier-A persistence (top-2 · volatile=0) | numpy MC 10,000 iter | ubu-2 | adenosine IC 100% · nicorandil 100% | 🟢 |
| V3.4 | Trial-A primary power ≈ 0.80 | scipy.stats.norm + libm sqrt | ubu-1 | 0.798 (Δ=0.002 from target) | 🟢 |

### 4.3 🟢 → 🔵 trajectory (PR #658 merge 후)

| V3 산출 | atlas K/id 후보 | 🔵 push 명령 (예상) |
|---|---|---|
| V3.2 Hill mPTP | `F clinical/hill_mptp` | `hexa verify --expr hill_mptp 900 0.998` |
| V3.2 salvage exp_decay | `F clinical/salvage_exp` | `hexa verify --expr salvage_exp 300 0.368` |
| V3.4 power continuous | `F clinical/power_2sample` | `hexa verify --expr power_2sample 0.798 0.80` |
| V3.1 PK 2-comp | `F clinical/pk_2comp_tmax_ic` | `hexa verify --expr pk_2comp_tmax_ic 3.0` |
| V3.3 MC Tier-A | not formal-target (stochastic) | 🟢 유지 (🔵 비대상) |

→ V3 합계 **10/12 🟢 + 1/12 🟡 hybrid + 2/12 🟠** (verbatim from V3 §3.2).

---

## 5. 🟡 SUPPORTED-BY-CITATION ledger (V1 majority subset)

V1 target 분포 33건 중 변경 불가 citation carry 만 추출 — primary trial/review/registry 출처 보유.

### 5.1 🟡 carry — M1-M9 분포

| M | § | claim | citation | rationale |
|---|---|---|---|---|
| M1 | §1 | no-reflow 정의 (TIMI3 회복+perfusion X) | Niccoli 2009 EHJ | framework consensus carry |
| M1 | §1 | STEMI primary PCI 후 no-reflow 5-25% | guideline+meta carry | epidemiology carry |
| M1 | §1 | cMRI MVO 기준 30-50% | de Waha 2017 meta | meta-analysis carry |
| M1 | §2 | 4-cause 분해 (DE·VS·ED·IR) Niccoli framework | Niccoli 2009 EHJ | framework consensus |
| M1 | §4 | 4-cause × strategy 매핑 | M1 본문 표 | inference from M1+M3 |
| M1 | §5 | d2 wall — CIRCUS·CYCLE·EMBRACE·MITOCARE 4건 neutral | NEJM/JACC/EHJ | 1차 출처 carry |
| M2 | §1 | CypD 1차 표적 (Baines 2005 KO infarct 50%↓) | Baines 2005 Nature | mechanism carry |
| M2 | §2 | 5-family · 14 candidate inventory | M2 §2 본문 | inventory carry |
| M2 | §3 | CIRCUS n=970 OR 1.04 p=0.69 neutral | Cung 2015 NEJM | primary carry |
| M2 | §3 | CYCLE n=410 OR 0.99 p=0.94 neutral | Ottani 2016 JACC | primary carry |
| M2 | §3 | EMBRACE n=297 p=0.78 neutral | Gibson 2016 JACC | primary carry |
| M2 | §3 | MITOCARE n=163 + sepsis signal | Atar 2015 EHJ | primary carry |
| M2 | §5 | 후보 ranking ★★★ (NIM811·debio-025·MTP-131·NMN) | compositional | inventory-driven carry |
| M3 | §1 | 5-family overview (A2A·K-ATP·NO·CaB·IIb/IIIa) | pharm review | standard carry |
| M3 | §2.1 | AMISTAD-II n=2118 primary neutral · high-dose ↓ p=0.03 | Ross 2005 JACC | primary carry |
| M3 | §2.1 | REOPEN-AMI MVO 14% vs 35% p=0.001 | Niccoli 2013 JACC | primary carry |
| M3 | §2.2 | J-WIND n=545 nicorandil primary neutral | Kitakaze 2007 Lancet | primary carry |
| M3 | §2.3 | Hillegass meta IC nitroprusside OR 0.40 | Hillegass 2010 meta | meta carry |
| M3 | §2.4 | Werner IC verapamil TIMI3 회복 88% | Werner 2002 RCT | small RCT carry |
| M3 | §2.4 | VAPOR IC verapamil SVG 0% vs 33% | Michaels 2002 RCT | RCT carry |
| M3 | §2.5 | INFUSE-AMI borderline p=0.03 | Stone 2012 JAMA | primary carry |
| M4 | §1 | 5-tier (T1 IC · T2 IV · T3 thrombec · T4 DPD · T5 DEC) | Niccoli 2016 review | guideline carry |
| M4 | §3 | REOPEN-AMI IC > AMISTAD-II IV (head-to-head pattern) | trial pair | comparative carry |
| M4 | §4.1 | TASTE n=7244 mortality neutral · TOTAL n=10732 stroke ↑ | Fröbert 2013/Jolly 2015 NEJM | primary carry |
| M4 | §4.2 | DPD SAFER SVG positive · EMERALD native neutral | Baim 2002 / Stone 2005 | trial pair carry |
| M5 | §1 | 5-layer endpoint pyramid (TIMI→MBG→IMR→CMR→MACE) | guideline carry | standard carry |
| M5 | §5 | trial endpoint 가이드 (Ph2 CMR · Ph3 MACE) | FDA guidance | regulatory carry |
| M6 | §1 | 5-domain safety classification | pharmacovigilance | standard carry |
| M6 | §2 | CIRCUS 2.5 mg/kg 단회 IV safety = placebo | Cung 2015 NEJM | safety carry |
| M6 | §3 | adenosine transient AV-block (t½ <10s) 가역성 | textbook pharmacology | carry |
| M6 | §3 | nicorandil ulcer 0.5-2% long-term | ENABLE pharmacovigilance | carry |
| M8 | §1 | KAMIR-NIH n>20,000 · K-ACTION n~4,000 | Sim 2017 KCJ | registry carry |
| M9 | §2 | EMMY (2022) empagliflozin NT-proBNP ↓ 15% | Tromp 2022 Circulation | primary carry |
| M9 | §2 | COLCOT (2019) HR 0.77 · LoDoCo2 0.69 (chronic) | Tardif 2019 NEJM / Nidorf 2020 NEJM | chronic carry |
| M9 | §3 | cGAS-STING-NLRP3 IRI 악화 축 | Front Immunol review | mechanism carry |
| M9 | §5 | ALDH2*2 East Asian 40% 보유 · NO bioavailability ↓ | JAHA 2021 | ethnicity carry |

→ **🟡 총 33-36 row (V1 target 33 ± metaphor 별도)** — 모두 1차 출처 변경 불가 carry.

---

## 6. 🟠 INSUFFICIENT/DEFERRED ledger

V1 §7 8 row + V3 §3.1 2 row (V3.5/V3.6 under-powered) = 10 deferred.

| # | claim | source | deferred reason | expected unblock gate |
|---|---|---|---|---|
| D1 | 한국 ALDH2 ethnicity gap (mPTP threshold 직접 측정) | M2 §6 | wet-lab — KAMIR-V sub-arm 또는 mPTP biomarker 측정 | KAMIR-V → 🟡 ; biomarker → 🟢 |
| D2 | M3 §5 d2 wall 3-fork (IMR-stratify · multi-drug · individualized) | M3 §5 | RCT readout 의존 | NICORADENO-MVO Ph3 readout |
| D3 | M4 §6 d2 wall 돌파 매트릭스 (M2 Path A/B + M4 T1/T5) | M4 §6 | 임상 진행 의존 | Path A/B trial 단계별 readout |
| D4 | M5 §6 한국 다기관 CMR consortium 부재 | M5 §6 | 인프라 미구축 | HOST-IRI consortium MOU |
| D5 | M6 §7 한국인 CYP3A4 variant CsA · alisporivir 대사 | M6 §7 | DAPTPGX cross + PK study 의존 | DAPTPGX 도메인 cross |
| D6 | M7 §5 Trial-A NICORADENO-MVO protocol + enrollment | M7 §5.1 | consortium MOU · KHIDI funding | KHIDI grant 결정 · MOU 체결 |
| D7 | M8 §6 Path A/B/C 한국 적용 outcome | M8 §6 | trial readout 의존 | 각 trial Gate 후 |
| D8 | M9 §4 arxiv ML 논문 reproducibility (CaRe-CNN·DEC+GNN·SurvTrace) | M9 §4 | atlas 미등록 + code release 부분적 | external reproducibility audit |
| D9 | V3.5 Cox 1y MACE HR 0.75 power = 0.157 | V3 §3.1 | n=500 under-powered for secondary | n 증가 또는 effect 강화 |
| D10 | V3.6 ALDH2*2 subgroup power = 0.654 | V3 §3.1 | exploratory only at n=201 carrier | enrich design (~ALDH2*2 only) |

---

## 7. 🔴 FALSIFIED ledger

V1 §8 + M9 §2/§5 verbatim — 4 row 명시적 falsified.

| # | claim | falsifying trial | citation (DOI) | result |
|---|---|---|---|---|
| R1 | SGLT2i acute MI MACE 가설 | EMPACT-MI | Butler et al., NEJM 2024 (DOI 10.1056/NEJMoa2314051) | HR 0.90 NS — acute MACE 가설 falsify (chronic carry 분리) |
| R2 | colchicine acute MI MACE 가설 | CLEAR SYNERGY | Jolly et al., NEJM 2024 (TCT 2024 presentation) | HR 0.99 NS — acute colchicine 가설 falsify |
| R3 | nicorandil 한국 STEMI 6mo infarct size 차이 가설 | Korean nicorandil RCT | Heart 2023 | 6mo infarct size 차이 없음 — nicorandil 6mo 가설 falsify |
| R4 | nicorandil 동아시아 PO 6mo MACE 가설 | CHIPS-PCI (China 2023) | Lancet Reg Health W Pac 2023 | 6mo 무효 — 동아시아 nicorandil null confirm |

→ 모두 large RCT primary endpoint deterministic disagreement — g5 🔴 cutoff 충족 (calc DETERMINISTICALLY disagrees with the claim · CLOSED negative).

---

## 8. ⚪ SPECULATION-FENCED ledger (M10 15건)

M10 §3 9 핵심 + 6 metaphor verbatim 흡수.

### 8.1 9 핵심 fence (C1-C5 카테고리)

| # | source | claim | category | hexa verify --fence verdict (sample) |
|---|---|---|---|---|
| F1 | M6 §6 | Tier-A/B/C 분류 (효능+safety 균형 자의적) | C3 subjective | (대표 sample F2 verbatim 아래) |
| F2 | M7 §1 | 5-axis 가중치 30/20/25/15/10 | C3 subjective | **verbatim sample 1** ↓ |
| F3 | M7 §4 | 3-path 권고 신호 강도 ★★/★★★ | C2 hypothetical | (동 카테고리 fence) |
| F4 | M7 §5.2 | Trial-B NMN-PRECON 효과 가설 | C2+C5 | (future trial readout 의존) |
| F5 | M7 §5.3 | Trial-C DERWIRE-PRECLIN frontier 가치 | C2+C5 | (preclinical · sponsor 부재) |
| F6 | M7 §6 | Gate-1/2/3 decision gates trajectory | C5 future | (prospective trajectory) |
| F7 | M8 §5 | 한국 IMR-guided RCT "first-in-class 기회" | C4 prognostic | **verbatim sample 2** ↓ |
| F8 | M9 §7 | 신규 d2 path (STING·다축·PPARα·ALDH2) | C2 hypothetical | (preclinical 가설) |
| F9 | M9 §8 | RFC 신규 endpoint (T1·DT-CMR·HOST-IRI) | C5 future infra | (RFC adoption 미정) |

### 8.2 6 metaphor sub-item (C1)

| # | source | metaphor | use intent |
|---|---|---|---|
| M1 | M2 §1 | "재관류 첫 5-10분 lethal window" | 직관 (mPTP open prob ODE는 🔵 별개) |
| M2 | M1 §1 | epicardial vs 미세혈관 "큰 길 vs 골목" | 직관 (TIMI3 + MBG≤1 산식 🔵 별개) |
| M3 | M3 §5 | "small Ph2 positive → large Ph3 neutral" 깔때기 | 직관 (meta-regression 🟢 별개) |
| M4 | M4 §6 | "diamond" trade-off ASCII (IC+sync 꼭대기) | 시각화 (Cmax ratio 산식 🔵 별개) |
| M5 | M9 §3 | "다축 cell-death" fan (apoptosis/necrosis/pyroptosis/ferroptosis/necroptosis) | 분류 도식 (각 축 메커니즘 🟡) |
| M6 | M7 §4 | "d2 wall" 자체 (4 trial neutral을 "벽"으로) | 도메인 d2 governance 비유 |

### 8.3 verbatim `hexa verify --fence` sample 1 (F2)

```
verify --fence
  claim  = M7 5-axis 가중치 30/20/25/15/10 (efficacy/delivery/safety/korea/phase)
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

### 8.4 verbatim `hexa verify --fence` sample 2 (F7)

```
verify --fence
  claim  = 한국 IMR-guided RCT first-in-class 기회
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification
           N/A by design; NOT a proven atlas atom (g4 honest fence,
           SF ≠ verified — atlas certification intrinsically N/A)
```

→ `hexa verify --fence`는 모든 ⚪ 항목에 대해 동일 reason 출력 — fence 자체가 verification N/A by design.

---

## 9. tier 분포 종합

### 9.1 V4 ledger 흡수 — 현재 상태 (V2 OPEN)

| tier | count | % (of 72) | M? coverage | source |
|---|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | **0 (filled) / 11 (placeholder)** | 0% filled · 15.3% pending | M1·M2·M4·M5·M7·M9 | V1 §4 — gate PR #658 |
| 🟢 SUPPORTED-NUMERICAL | **10** (+ 1 hybrid) | 13.9% (+1.4%) | M2·M4·M5·M7 | V3 §3.1 |
| 🟡 SUPPORTED-BY-CITATION | **~33** | 45.8% | M1-M9 분산 | V1 §5 majority |
| 🟠 INSUFFICIENT/DEFERRED | **10** (8 V1 + 2 V3) | 13.9% | M2·M3·M4·M5·M6·M7·M8·M9 | V1 §7 + V3 §3.1 |
| 🔴 FALSIFIED | **4** | 5.6% | M9 §2·§5 | V1 §8 |
| ⚪ SPECULATION-FENCED | **15** (9 핵심 + 6 metaphor) | 12.5% (V1 외부 + metaphor) | M6·M7·M8·M9 | M10 §3 |

```
📊 NOREFLOW V4 final ledger (partial · V2 OPEN)
─────────────────────────────────────────────────
🔵 SUPPORTED-FORMAL        ░░░░░░░░░░░░░░░░░░░░░░░░░░  0  (  0.0% filled · 11 placeholder pending PR #658)
🟢 SUPPORTED-NUMERICAL     ████░░░░░░░░░░░░░░░░░░░░░░ 10  ( 13.9%)
🟡 SUPPORTED-BY-CITATION   ███████████████░░░░░░░░░░░ 33  ( 45.8%)
🟠 INSUFFICIENT/DEFERRED   █████░░░░░░░░░░░░░░░░░░░░░ 10  ( 13.9%)
🔴 FALSIFIED               ██░░░░░░░░░░░░░░░░░░░░░░░░  4  (  5.6%)
⚪ SPECULATION-FENCED      ██████░░░░░░░░░░░░░░░░░░░░ 15  ( 12.5% V1 외부 + metaphor)
                                                      ─────
                                                       72 (+ metaphor 6)
```

### 9.2 target 분포 (V2 PR #658 merge 후 예측)

| tier | count | % | gain vs 현재 |
|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | **11** | 15.3% | +11 (placeholder → filled) |
| 🟢 SUPPORTED-NUMERICAL | 10 (+1 hybrid) | 13.9% (+1.4%) | unchanged |
| 🟡 SUPPORTED-BY-CITATION | 33 | 45.8% | unchanged |
| 🟠 INSUFFICIENT/DEFERRED | 10 | 13.9% | unchanged (외부 unblock 시 escalate) |
| 🔴 FALSIFIED | 4 | 5.6% | unchanged |
| ⚪ SPECULATION-FENCED | 15 | 12.5% | unchanged |

→ PR #658 merge 단일 사건으로 **🔵 0 → 11 (15.3% 도메인 커버리지)** 즉시 도약.

---

## 10. honest gate map — 다음 unblock 시점

### 10.1 단기 (현재-Q3) — 단일 PR merge

| event | unblocks | new tier |
|---|---|---|
| PR #658 merge | V2 🔵 11 row 즉시 fill | 🔵 0 → 11 |
| V3.1/V3.2/V3.4 atlas register --from-verify | V3 → 🔵 trajectory (PR merge 후 4건 추가) | 🔵 +4 (potential 15 total) |

### 10.2 중기 (12-18mo) — 임상 readout

| event | unblocks | from tier → to tier |
|---|---|---|
| NICORADENO-MVO Ph3 readout (KHIDI funded) | D2/D6 (3-fork · Trial-A outcome) | 🟠 → 🟡/🟢 또는 🔴 |
| HORIZON sub-analysis | M3 §6 SGLT2i carry update | 🟡 carry refresh |
| OCEAN(a) Korean cohort | M8 §6 Path A/B/C 한국 적용 | 🟠 → 🟡 |
| KAMIR-V no-reflow biomarker arm | D1 ALDH2 gap | 🟠 → 🟡/🟢 |

### 10.3 장기 (24mo+) — 인프라

| event | unblocks |
|---|---|
| HOST-IRI consortium MOU 체결 | D4 한국 다기관 CMR · F9 RFC adoption |
| cardio 도메인 demiurge 등록 | cross-domain V4 통합 (clinical/noreflow → 별도 cardio root) |
| DAPTPGX cross | D5 한국인 CYP3A4 variant 약물 metabolism |

---

## 11. g5 grade 표 (V4 자체 grade)

| 항목 | 등급 | 근거 |
|---|---|---|
| §1 V4 정의 + rubric verbatim | 🟡 | `hexa verify rubric` CLI output 그대로 |
| §2 도메인 요약 + cross-domain | 🟡 | NOREFLOW.md + demiurge cli output 인용 |
| §3 🔵 placeholder 11 row | 🟠 DEFERRED | external dep — PR #658 OPEN gate (g_external_calc_forbidden 해당) |
| §4 🟢 ledger (V3 verbatim) | 🟢 | V3 4-track recompute 산출 그대로 |
| §5 🟡 carry ledger | 🟡 | 1차 출처 citation 변경 불가 carry |
| §6 🟠 deferred ledger | 🟠 | wet-lab/임상/외부 데이터 dep |
| §7 🔴 falsified ledger | 🔴 | M9 large RCT primary endpoint disagreement |
| §8 ⚪ fence ledger | ⚪ | M10 9 + metaphor 6 honest declaration verbatim |
| §9 분포 종합 | 🟢 | count aggregation arithmetic |
| §10 gate map | 🟡 | future unblock 시점 — prognostic 부분만 ⚪로 별도 |
| V4 자체 (partial) | **🟡 partial** | compositional · 🔵 11 placeholder pending PR #658 |
| V4 future (PR merged) | 🟢 numerical complete | V3 + V2 fill 후 |
| V4 final goal | 🔵 atlas-attested | PR #658 + register --from-verify chain |

### 11.1 V4 trajectory

```
V4 현재         V4 (PR #658 merge 후)        V4 final goal
🟡 partial   →  🟢 numerical complete    →   🔵 atlas-attested
(11 placeholder)  (11 → filled)                 (V2 + V3.1/2/4 register --from-verify)
```

---

## 12. 참고 — 사용 CLI commands log

### 12.1 hexa verify rubric (verbatim §1.2)

```
$ hexa verify rubric
hexa verify — cross-project tier rubric (TECS-L-aligned, LATTICE_POLICY real-limits-first)
  🔵 SUPPORTED-FORMAL · 🟢 SUPPORTED-NUMERICAL · 🟡 SUPPORTED-BY-CITATION
  🟠 INSUFFICIENT · 🟠 DEFERRED · 🔴 FALSIFIED · ⚪ SPECULATION-FENCED
(full output §1.2)
```

### 12.2 hexa verify --fence (verbatim §8.3-§8.4)

```
$ hexa verify --fence "M7 5-axis 가중치 30/20/25/15/10 (efficacy/delivery/safety/korea/phase)"
verify --fence
  claim  = M7 5-axis 가중치 30/20/25/15/10 (efficacy/delivery/safety/korea/phase)
  tier   = ⚪ SPECULATION-FENCED
  reason = imagination/metaphor class (hexa-bio AXIS) — verification N/A by design;
           NOT a proven atlas atom (g4 honest fence, SF ≠ verified — atlas
           certification intrinsically N/A)

$ hexa verify --fence "한국 IMR-guided RCT first-in-class 기회"
verify --fence
  claim  = 한국 IMR-guided RCT first-in-class 기회
  tier   = ⚪ SPECULATION-FENCED
  reason = (동일)
```

### 12.3 demiurge cli list-domains (1 line context §2.3)

```
$ demiurge cli list-domains
Domains (21): antimatter · aura · bio · bot · brain · cern · chem · chip ·
              clinical · component · energy · firmware · fusion · grid · matter ·
              mobility · rtsc · scope · space · sscb · ufo
```

→ NOREFLOW = clinical 아래 sub-thread 현재 · cardio 도메인 신설 또는 clinical/noreflow 등록은 V4 ledger 합산 후 별도 절차.

### 12.4 gh pr view 658 (verbatim §3.1)

```
$ gh pr view 658 --repo dancinlab/hexa-lang --json state,mergedAt,title,url
{
  "mergedAt": null,
  "state":    "OPEN",
  "title":    "inbox(patches): NOREFLOW clinical calc atlas extension RFC (5 fns)",
  "url":      "https://github.com/dancinlab/hexa-lang/pull/658"
}
```

→ PR merge → V2 agent fan-out 트리거. PR review 지연 시 d2 governance 3-path (직접 review nudge · sibling repo dance · register --from-drill 우회) 적용.

---

## 13. V4 산출 요약 (partial)

- **총 final tier 분포**: 🔵 0 filled (11 placeholder) · 🟢 10 (+1 hybrid) · 🟡 33 · 🟠 10 · 🔴 4 · ⚪ 15 (V1 외부 + metaphor)
- **🔵 placeholder 11 row** (V1 §4 verbatim subset): mPTP Hill · lethal window 누적 · TIMI grade · cTFC ×1.7 · IMR=Pd×Tmn · CsA Ki ratio · arm-heart lag · Cmax IC/IV ratio · TIMI/MBG/IMR cutoff · CypD Ser191 phospho · 5-axis weighted score
- **V2 gate**: PR #658 (`noreflow-clinical-calc-extension`) — **OPEN · mergedAt: null** · review pending
- **🟢 V3 verbatim**: 4 track (PK · IRI · MC · power) on ubu-1/ubu-2 — 10/12 🟢 · 1/12 🟡 hybrid · 2/12 🟠
- **⚪ M10 fence**: 9 핵심 + 6 metaphor — 산식 forcing 금지 절차 정직성
- **🔴 falsified**: 4 large RCT (EMPACT-MI · CLEAR SYNERGY · Korean nicorandil 6mo · CHIPS-PCI 6mo)
- **🟠 deferred**: 10 (8 V1 wet-lab/임상 + 2 V3 power gap)
- **V4 자체 grade**: 🟡 partial (compositional) — PR merge 후 🟢 complete, register chain 후 🔵 atlas-attested.
- **d2 governance** 충족: PR #658 review 지연에도 fill 경로 3-path 명시, 포기 X.

→ 다음 액션: PR #658 merge nudge (priority 1) · merge 후 V2 agent re-fire (NOREFLOW/verify/V2_formal_identities.md fill) · V3.1/V3.2/V3.4 → atlas `register --from-verify --auto-pr`.
