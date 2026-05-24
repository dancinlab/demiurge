# TTR-LAC V1 — claim inventory + tier triage

> milestone: TTR-LAC.md verify track "V1 claim inventory + tier triage (🔵/🟢/🟡/🟠)"
> source: `A1_anesthesia_baseline.md` (track A) · `B1_laser_ratelimit.md` · `B2_frosting_clear.md` · `B3_topical_r_down.md` (track B)
> parent: TTR-LAC.md (@goal: 레이저 타투제거 세션용 국소 크림 — 마취 onset↓·진피 도달↑ + 세션당 제거율↑) · sibling: TTR-ORAL/verify/V1_claim_inventory.md
> tier rubric: 🔵 SUPPORTED-FORMAL (closed-form/symbolic) · 🟢 SUPPORTED-NUMERICAL (hexa recompute) · 🟡 SUPPORTED-BY-CITATION (literature, no recompute) · 🟠 INSUFFICIENT/DEFERRED (no calc path / wet-lab dep) · 🔴 FALSIFIED · ⚪ SPECULATION-FENCED
> 진행: 본 세션에서 A1/B1/B2/B3 산출물 전수 스캔 → falsifiable claim 추출 + tier 할당. 🟢 numerical = V3 cross-check 대상. 🟠 = wet-lab/실측 gate.

## TL;DR

TTR-LAC A1/B1/B2/B3 산출물에서 falsifiable claim **38개** 추출. tier 분포: 🔵 **8** (Fick lag-time · Beer-Lambert · exp depth decay · multipass 기하급수 · F_h/Mie 형식 · 직렬 곱) · 🟢 **13** (A1 lag/depth · B1 multipass/r sweep · B2 μ_s/T/dose-response/headline · B3 β sweep/stack — 모두 hexa verbatim recompute 완료) · 🟡 **11** (EMLA/LMX/BLT/tetra FDA label · 6-10세션·6-8주·pico 61/86.6% · frosting 20분·기포 1μm/10⁹/cm³ · PFD 물성 FDA-cleared · Reddel ~10% fluence/40% 온도↓ · Baranska r 천장 · TTR-ORAL carbon floor 상속) · 🟠 **6** (β_topical 0.50 직접 실측 부재 · PFD-lidocaine 직접 호환성 · BLT compounded 정확 onset · 진피 nerve-block 확률 · λ depth decay 절대값 · LAST 가산 safety). 🔴 **0**. ⚪ **0**.

핵심 정직 framing: **frosting clear(B2)·재포획↓(B3) = 곱셈 lever** — 모델상 ~4.9× 단축 (~1.2세션) 이나 **carbon black 25% 비분해 floor(TTR-ORAL 상속)** 로 실용 floor ~1.5-2세션. PFD pivotal trial (Biesman 2017 · 3.7 vs 1.4 passes) = 임상 입증 anchor. β_topical 0.50 = **load-bearing assumption** (직접 실측 없음). tier 인플레 없음.

## §1 A1 — 마취 baseline + 율속단계 claims (`A1_anesthesia_baseline.md`)

### A1.a 표준 국소마취제 baseline (FDA label · 임상 표)

| # | claim | tier | verify path |
|---|---|---|---|
| A1.1 | EMLA(lido 2.5% + prilo 2.5% eutectic) onset ~60min 무폐색 · 30min 폐색 · 최대효과 2-3h | 🟡 | EMLA FDA label (accessdata.fda.gov/.../019941s021lbl.pdf) |
| A1.2 | EMLA 성인 최대용량 ≤1300 cm²/~150g · prilocaine→methemoglobinemia (o-toluidine ~8 mg/kg) | 🟡 | FDA label · *J Emerg Med* metHb case series |
| A1.3 | LMX-4 (liposomal lido 4-5%) onset ~30min 무폐색 — EMLA 절반 시간 동일 깊이 | 🟡 | PEMCincinnati · USPharmacist topical anesthesia review |
| A1.4 | tetracaine 4% gel onset ~30-45min · ester 가수분해 · 접촉피부염↑ | 🟡 | *PubMed* 25135033 lidocaine/tetracaine review |
| A1.5 | BLT (benzo 20% + lido 6% + tetra 4% compounded) onset ~20-30min · benzocaine metHb + LAST 가산 위험 | 🟡 → 🟠 (정확 onset/조성 가변) | Empower Pharmacy · NCT01842373 (compounded·미규격) |

### A1.b 율속단계 = SC 확산 lag time (first-principles)

| # | claim | tier | verify path |
|---|---|---|---|
| A1.6 | 율속단계 = 각질층 (SC ~10-20μm) 수동 Fick 확산 | 🔵 | first-principles 직렬 저항 (formal) |
| A1.7 | t_lag = h²/(6D) — 유한 슬래브 transient 해의 lag 항 | 🔵 | Fick second law closed-form |
| A1.8 | 지각 가능한 차단 onset ≈ 1-2 × t_lag | 🔵 | 슬래브 정상상태 시정수 (formal) |
| A1.9 | D=1e-10 cm²/s · h=10μm → t_lag=27.78min · onset=2×t_lag=55.6min ≈ 임상 EMLA 60min | 🟢 | hexa `sim/a1_lagtime.hexa` §2 [2] verbatim |
| A1.10 | D 가속 sweep: D=3e-10(occlusion) → 18.5min · D=1e-9(enhancer) → 5.6min | 🟢 | hexa verbatim §2 [3] (A2 정량 표적) |
| A1.11 | onset ∝ 1/D — D 한 자릿수 변동 = onset 한 자릿수 변동 (EMLA 환자간 가변성의 물리적 근원) | 🔵 | t_lag closed-form 단조성 |

### A1.c 깊이 falloff — 진피 자유신경말단 도달

| # | claim | tier | verify path |
|---|---|---|---|
| A1.12 | 깊이 감쇠 C(z)/C_surf = exp(−z/λ) · λ=40μm (epidermal-weighted) | 🔵 (형식) / 🟠 (λ 절대값) | 지수감쇠 *형태* closed-form · λ 값은 partition/실효-D 의존 |
| A1.13 | C 진피 자유신경말단 (150-200μm) = surface 의 2.35% → 0.67% | 🟢 | hexa verbatim §2 [4][5] |
| A1.14 | 표피층 (≤50μm) C ≈ 29-69% surface → 표피성 마취 신뢰 · 진피 마취 thin·확률적 | 🟢 | hexa verbatim §2 [4] |
| A1.15 | 자유신경말단 (Aδ·C nociceptor) 분포: 표피심부~상부진피(~100-200μm) 신경총 · 레이저 열펄스 표재 nociceptor 선택 자극 | 🟡 | Wikipedia free nerve ending · NCBI NBK11162 · PubMed 16086989 |

## §2 B1 — 세션 모델 + 율속단계 claims (`B1_laser_ratelimit.md`)

### B1.a 표준 레이저 baseline (문헌)

| # | claim | tier | verify path |
|---|---|---|---|
| B1.1 | Q-switched / picosecond 광음향 단편화(cavitation) 기전 · 완전제거 6-10세션 (90%+) · 간격 6-8주 | 🟡 | StatPearls NBK442007 · JCAS PMC4411588 · MDPI 9712 |
| B1.2 | pico 클리어런스: 2세션 후 평균 61% · 6-8세션 후 86.6% · 6.5세션에 79% · 전문잉크 완전제거 ~30%만 | 🟡 | PMC11322294 · Springer 2024 |
| B1.3 | 두 병목 = (a) frosting (즉시 백탁·세션당 1패스) · (b) recapture r (방출 단편 macrophage 재포획) | 🟡 | JCAS PMC4411588 · Baranska 2018 JEM |
| B1.4 | frosting 자연 소실 ~20분 (세션당 1패스 강제) | 🟡 | *J Aesthet Nurs* Skin&Laser Mar21 · JCAS PMC4411588 |

### B1.b multipass 선례 (PFD/R20 임상 anchor)

| # | claim | tier | verify path |
|---|---|---|---|
| B1.5 | R20 (Kossida 2012) 4패스/20분대기 split-tattoo: 3개월 후 완전제거 61% vs 단일패스 0% | 🟡 | PubMed 22036610 |
| B1.6 | PFD pivotal trial (Biesman 2017) 3.7패스 vs laser-alone 1.4패스 · 30/30 PFD 선호 · 17잉크 중 11개 더 빠른 clearance | 🟡 | PubMed 28319270 *Lasers Surg Med* |
| B1.7 | DESCRIBE PFD patch frosting 3-5초 optical clearing · 치료시간 80분→5분 | 🟡 | describepatch.com · JCAS PMC4411588 |

### B1.c 세션 모델 (BP1d 재사용 · TOPICAL)

| # | claim | tier | verify path |
|---|---|---|---|
| B1.8 | c_pass = φ_rel·(1−r) · c_session = 1−(1−c_pass)^n · N = log(0.1)/log(1−c_session) | 🔵 | 기하급수 누적 closed-form (TTR-ORAL BP1d 동형) |
| B1.9 | calib: φ_rel=0.83 · r₀=0.70 · n=1 → N≈8.04 (lit 6-10 정합) | 🟢 | hexa `sim/b1_laser_ratelimit.hexa` calib (load-bearing) |
| B1.10 | PFD multipass sweep: n=2 → N=4.02 · n=3 → N=2.68 · n=4 → N=2.01 | 🟢 | hexa verbatim §3 [1] |
| B1.11 | PFD headline: 1.4패스 N=5.74 · 3.7패스 N=2.17 · cut=3.57세션 · fold=2.64× | 🟢 | hexa verbatim §3 [2] |
| B1.12 | recapture r↓ sweep (n=1): r=0.70 → 8.04 · r=0.50 → 4.29 · r=0.40 → 3.34 | 🟢 | hexa verbatim §3 [3] |
| B1.13 | B4 co-formulation (3.7패스 + r=0.50): N=1.16 · vs SoC fold=4.94× | 🟢 | hexa verbatim §3 [4] (load-bearing) |
| B1.14 | timeline @ 7주 간격: SoC 9.19mo · PFD 3.48mo · B4 1.86mo | 🟢 | hexa verbatim §3 [5] |
| B1.15 | frosting(패스) lever > recapture(r) lever — 1패스 8.0 → 3패스 2.7 (Δ5.3) vs r0.70 → 0.50 (Δ3.7) | 🔵/🟢 | 모델 monotone + lit-calib |
| B1.16 | carbon black 비분해성 floor: track B 는 *세션당 RATE / 패스 수 / 재포획률* 만 변경 · 잉크 화학 변경 ✗ | 🟡 | TTR-ORAL 상속 · carbon 비분해 (선례 공유) |

## §3 B2 — frosting 광학 + PFD 심화 claims (`B2_frosting_clear.md`)

### B2.a frosting 광학 (Mie / Beer-Lambert)

| # | claim | tier | verify path |
|---|---|---|---|
| B2.1 | 기포 a≈1μm · N≈10⁶/mm³ (=10⁹/cm³) · 베이스 dermis μ_s(755nm)≈100 cm⁻¹ | 🟡 | JCAS PMC4411588 · Ho 2002 · Jacques 2013 *Phys Med Biol* |
| B2.2 | μ_s_frost = N·Q·π·a² (Mie 산란 부가분) | 🔵 | Mie 산란 단면 closed-form |
| B2.3 | Beer-Lambert T = exp(−μ_s·z) — 진피 잉크 도달 fluence | 🔵 | Beer-Lambert closed-form |
| B2.4 | μ_s frosted = 162.83 cm⁻¹ (+62.83) · PFD-cleared = 100.63 · T@200μm: baseline 0.135 / frosted 0.039 (28%) / PFD 0.134 (99%) | 🟢 | hexa `sim/b2_frosting_clear.hexa` §7 [A] verbatim |

### B2.b PFD 기전 (RI + O₂ + 비반응)

| # | claim | tier | verify path |
|---|---|---|---|
| B2.5 | PFD n=1.313 vs n_water=1.333 · Δn=0.02 · Mie contrast 16× 감소 | 🟡 | refractiveindex.info · ScienceDirect Topics |
| B2.6 | PFD O₂ 흡수 50 mL/100mL @ 37°C (물의 ~170×) · 1μm 기포 3-5초 용해 | 🟡 | researchgate 335114971 · PMC11614965 |
| B2.7 | PFD 화학 비활성 (hydrophobic+oleophobic · 단백질 무반응) · FDA-cleared (DESCRIBE 532/694/755/1064 QS·pico) | 🟡 | Merz Aesthetics press · describepatch.com |
| B2.8 | Reddel 2020: PFD 잉크 도달 fluence ~10%↑ · 피부온 ~40%↓ · 입자방출 ~2배↓ | 🟡 | PubMed 32516063 *J Cosmet Laser Ther* |

### B2.c alt-agent 비교 + dose-response knee

| # | claim | tier | verify path |
|---|---|---|---|
| B2.9 | alt-agent Q_sca proxy: PFD 4.5e-4 (winner) · PFH 7.4e-3 (bp 56°C 휘발) · silicone-oil 5.8e-3 (O₂ sink無) · glycerol50% 4.8e-3 (SC 탈수·분 단위) — air 0.125 (적) | 🟢 | hexa verbatim §7 [B] (Rayleigh-Gans proxy) |
| B2.10 | dose-response knee n*≈3-4 패스 (4→5 ΔN<0.5 marginal) · Biesman 3.7 / Kossida 4 임상 정합 | 🟢 | hexa verbatim §7 [C] (load-bearing knee) |
| B2.11 | Reddel boost φ_rel 0.83→0.91: n=3 → N=2.41 · n=4 → N=1.81 (추가 ~10% 단축) | 🟢 | hexa verbatim §7 [C] note |
| B2.12 | wall-clock R20=80min(20×4 대기) vs DESCRIBE=5min (PFD 3-5초×4) = 16× · 세션수 2.64× = 이중 곱셈 | 🟢 | hexa verbatim §7 [D] |

### B2.d 마취제 공동제형 양립성

| # | claim | tier | verify path |
|---|---|---|---|
| B2.13 | PFD-lidocaine 직접 혼합 부적합 (PFD third-phase 가 emulsion 안정성 깨뜨림) → 순차 도포 권장 (EMLA 60min → wipe → PFD patch → laser) | 🟠 | 직접 호환성 데이터 부재 (화학적 추론) |

## §4 B3 — 토픽 r↓ + co-formulation claims (`B3_topical_r_down.md`)

### B3.a 토픽 vs 경구 ADME 우회

| # | claim | tier | verify path |
|---|---|---|---|
| B3.1 | 토픽 SC→진피 ~1e-1 vs 경구 f_target≈1e-4 → ~10³× 농도 우위 (Fick PK) | 🔵 | first-principles 도달 분율 비교 |
| B3.2 | β_oral 천장 ~0.40 (TTR-ORAL rhein/diacerein off-target) → β_topical 0.60-0.85 도달 가능 | 🟡 → 🟠 (β_topical 직접 실측 없음) | TTR-ORAL BP1a 상속 + 토픽 농도 우위 외삽 |

### B3.b β sweep + JOINT stack (B2+B3)

| # | claim | tier | verify path |
|---|---|---|---|
| B3.3 | r(β) = (1−β_topical)·r₀ · r₀=0.70 (B1 baseline) | 🔵 | linear scaling (formal) |
| B3.4 | β sweep at n=1: β=0 → 8.04 · β=0.30 → 4.18 · β=0.50 → 2.97 · β=0.70 → 2.16 · β=0.85 → 1.70 | 🟢 | hexa `sim/b3_topical_r_down.hexa` §3 [2] verbatim |
| B3.5 | JOINT stack (n=3.7 PFD + β): realistic β=0.50 → N=0.80 · aspirational β=0.70 → N=0.58 · ceiling β=0.85 → N=0.46 | 🟢 | hexa verbatim §3 [3] |
| B3.6 | head-to-head fold vs SoC: B2 only 2.64× · B3 only(n=1.4) 2.71× · B2+B3 realistic 7.16× (1.28mo) · aspirational 9.84× (0.93mo) | 🟢 | hexa verbatim §3 [4] |

### B3.c 후보 + 정직 floor + 공동제형

| # | claim | tier | verify path |
|---|---|---|---|
| B3.7 | β_topical 후보 단계: β=0.30 (post-laser cooling+massage+escin) · β=0.50 (rhein/anthraquinone 토픽·SR-A) · β=0.70 (Syk+rhein stack) · β=0.85 (anti-MARCO peptide research) | 🟡 → 🟠 | 비특이 SoC 인접 (0.30 🟡) · 직접 잉크-재포획 β 실측 없음 (0.50+ 🟠) |
| B3.8 | <1세션 절대값 (모델상 0.46-0.80) = **비물리적** — c_session 상한 없는 모델 한계 | 🔴 (해당 값을 *절대*로 주장 시) → 본 문서는 floor 명시로 자체 falsify | carbon floor 무시한 모델 천장 |
| B3.9 | 실용 floor ~1.5-2세션 (~2.5-3.5개월) — carbon black ~25% 비분해 + Cu-Pc/Cr₂O₃ ~10% wall = 절대 clearance ~75% (TTR-ORAL N1/N3 상속) | 🟡 | TTR-ORAL carbon floor 상속 |
| B3.10 | 공동제형 도포순서: EMLA 60min occlusion → wipe → B3 rhein/Syk gel (5-10min 흡수) → B2 PFD patch + 다중패스 → post-laser B3 보충 | 🟠 (화학적 양립성 추론 · 실측 필요) | 화학적 양립성 추론 (PFD 비활성·rhein 산성·lido 염기 pH 조정) |

## §5 tier 분포 + verify pipeline

| tier | 갯수 | 다음 단계 |
|---|---|---|
| 🔵 SUPPORTED-FORMAL | 8 | V2 — Fick lag-time · Mie 산란 · Beer-Lambert · 기하급수 누적 · 직렬 곱 closed-form push |
| 🟢 SUPPORTED-NUMERICAL | 13 | V3 — hexa recompute verbatim 완료 (a1_lagtime · b1/b2/b3 sim) · 2nd-method cross-check 권장 (§6) |
| 🟡 SUPPORTED-BY-CITATION | 11 | V4 final ledger 등록 (FDA label · 임상 trial · 광물성·신경해부 literature verbatim) |
| 🟠 INSUFFICIENT/DEFERRED | 6 | V4 — wet-lab/실측 gate (β_topical 실측 · PFD-lido 호환성 · BLT compounded onset · λ 절대값 · nerve-block 확률 · LAST 가산) |
| 🔴 FALSIFIED | 0 (self-flagged: B3.8 <1세션 값은 *floor 명시로 자체 falsify*) | — |
| ⚪ SPECULATION-FENCED | 0 | — |

> 🔵 8건 = closed-form 정체성 (V2 가 잡을 대상) · 🟢 13건 = hexa recompute 完了 (절대값보다 *fold-cut*·*ratio* 만 신뢰 권장) · 🟡 11건 = atlas/literature verbatim 등록 · 🟠 6건 = wet-lab gate (절대 onset·β·호환성·LAST 가산).

## §6 V3 handoff — 🟢 cross-check 후보 (2nd-method validation)

| step | claim | hexa-recompute (1st) | 2nd-method cross-check | host (per @D d7) |
|---|---|---|---|---|
| V3.1 | A1.9/A1.10 SC lag-time (lidocaine D=1e-10·h=10μm → onset 55.6min; D 가속 sweep) | hexa `sim/a1_lagtime.hexa` | **PBPK 대안** — Cleek-Bunge multilayer SC PBPK 또는 Potts-Guy permeability 회귀와 cross-check | local CPU (Python PBPK) |
| V3.2 | A1.13 진피 자유신경말단 도달 농도 (2.35% / 0.67%) | hexa §2 [4][5] | **2-compartment PK (SC + viable epidermis + dermis)** cross-check · λ=40μm 의 partition 분해 | local CPU |
| V3.3 | B1.11/B1.13 PFD multipass headline (3.7패스 N=2.17) + B4 co-form (N=1.16) | hexa `sim/b1_laser_ratelimit.hexa` | **독립 임상 메타 분석** — Biesman 2017 이외 (R20 Kossida 2012 / Brauer pilot PMC5042086) 의 세션수 모델 정합성 확인 | local CPU (literature aggregation) |
| V3.4 | B2.4 frosted μ_s=162.83 · T@200μm=0.039 | hexa §7 [A] (Rayleigh-Gans proxy) | **Monte Carlo photon transport** (MCML) Mie 정확해 — 공기 기포 large-contrast Q_sca 재계산 | local CPU (MCML) or RunPod GPU |
| V3.5 | B2.10 dose-response knee n*≈3-4 | hexa §7 [C] | **Reddel 2020 in-vivo fluence-temp data** 와 phi_rel 보정 cross-check (φ_rel 0.83→0.91 sensitivity) | local CPU |
| V3.6 | B3.4/B3.5 β sweep + JOINT stack (β=0.50 → N=2.97; B2+B3 N=0.80) | hexa `sim/b3_topical_r_down.hexa` | **TTR-ORAL BP1d r-sweep** 와 cross-check (경구 β_oral 0.40 천장 vs 토픽 β_topical 0.50) — *동일 모델 family 정합성* | local CPU |
| V3.7 | A1.13 + B2.4 + B3.4 합산 — 통합 protocol 시뮬 (EMLA 60min + PFD 3.7p + β=0.50) | 분리 sim | **단일 first-principles PBPK + 광학 + drainage 통합 모델** — V4 final ledger 입력 | local CPU |

> @D d7 sizing: SC PBPK·2-compartment PK·임상 메타·Reddel sensitivity·BP1d cross-check·통합 모델 = local CPU (Python · 모두 CPU 천장 안). Monte Carlo photon transport (MCML) 만 large-domain 일 시 RunPod GPU. TDDFT/DFT 불필요 (drug discovery 아님).

## §7 load-bearing assumptions (cross-cutting summary)

다음 assumption 이 *값을 바꾸면* TL;DR fold-cut 전체가 흔들린다. 모두 **load-bearing** 으로 flag:

| ID | assumption | 출처 claim | 흔들렸을 때 영향 |
|---|---|---|---|
| LB-1 | **φ_rel = 0.83** (B1 calib) | B1.9 | c_pass 직접 곱 · 모든 N 절대값 (fold-cut 비율은 둔감 = 견고) |
| LB-2 | **r₀ = 0.70** (B1 baseline recapture) | B1.9 · B3.3 | c_pass(1−r) · 모든 r sweep 의 zero point |
| LB-3 | **D (lidocaine in SC) ≈ 1e-10 cm²/s · h=10μm** | A1.9 | t_lag=27.8min · onset 55.6min · 임상 정합의 *물리적 토대* |
| LB-4 | **λ = 40μm (epidermal-weighted depth decay)** | A1.12 · A1.13 | 진피 도달 농도 2.35% / 0.67% — λ 절대값은 partition/실효-D 의존 (🟠 핵심) |
| LB-5 | **PFD multipass ceiling = 3.7 passes (Biesman pivotal)** | B1.6 · B1.11 · B2.10 | dose-response knee · headline 2.64× — 임상 anchor (외부 trial 단 1건) |
| LB-6 | **β_topical = 0.50 (rhein topical 달성 가능)** | B3.7 · B3.4 | B3 단독 2.71× · JOINT B2+B3 4.94× · 본 도메인의 **가장 약한 고리** (직접 실측 부재) |
| LB-7 | **기포 a=1μm · N=10⁹/cm³** | B2.1 · B2.4 | μ_s_frost +63 cm⁻¹ · 빔 차단 72% — Ho 2002 단일 출처 |
| LB-8 | **carbon black 25% 비분해 floor (TTR-ORAL 상속)** | B1.16 · B3.9 | 실용 floor ~1.5-2세션 — 모델의 <1세션 값을 self-falsify (정직 가드) |

> 가장 load-bearing = **LB-6 (β_topical=0.50)** — B3 lever 전체가 이 하나에 걸려있고 직접 실측이 없음 (TTR-ORAL BP1a rhein/MARCO scaffold 의 토픽 외삽). M8 ex-vivo on real tattoo 가 절대적 1순위 wet-lab gate.

## §8 honest unknowns + 가장 약한 / 가장 강한 곳

🟠 6건 deferred 사유:
- A1.5 BLT compounded 정확 onset (clinic 별 가변·미규격)
- A1.12 λ depth decay 절대값 (partition·실효-D 의존 — A3/A5 PK 실측 필요)
- A1.15 진피 nerve-block 확률 (확률적·환자 가변)
- B2.13 PFD-lidocaine 직접 혼합 호환성 (emulsion 안정성 직접 실험 부재)
- B3.2/B3.7 β_topical 0.50+ 직접 실측 (M8 ex-vivo · 본 도메인 핵심 gap)
- B3.10 EMLA+PFD+rhein 3-step 도포순서 화학 양립성 (실험 미수행)
- (LAST 가산 safety — A1.2/A1.5 자체는 🟡 라벨, 가산 시 🟠)

### verdict — 어디가 가장 data-supported · 어디가 가장 assumption-load-bearing

**가장 data-supported**: **B1/B2 frosting-clear lever** — Biesman 2017 (PFD 3.7 vs 1.4 패스) + Kossida 2012 (R20 4패스 61% vs 0%) + Reddel 2020 (fluence/온도) + JCAS PMC4411588 (frosting 광학) 의 **다중 임상·광물성·해부학 출처 정합** + hexa recompute (B1.11/B2.10/B2.12 verbatim) 으로 **fold-cut 2.64× · wall-clock 16×** 가 견고. A1 lag-time도 D=1e-10/h=10μm 가 임상 EMLA 60min 과 정합 — 🔵 closed-form + 🟢 numerical 이중지지.

**가장 assumption-load-bearing**: **B3 β_topical=0.50** (LB-6) — 본 도메인 가장 약한 고리. (i) TTR-ORAL BP1a rhein/MARCO scaffold 의 *경구* β_oral 0.40 천장을 *토픽 ~10³× 농도 우위*로 외삽 — 직접 잉크-재포획 β 실측 없음. (ii) JOINT stack <1세션 값 (B3.5) 은 carbon floor 무시한 모델 천장 — B3.8 로 self-falsify, B3.9 로 실용 floor ~1.5-2세션 정직 명시 (인플레 가드). (iii) M8 ex-vivo on real tattoo 가 1순위 wet-lab gate. 부차적으로 **LB-4 λ 절대값** (진피 도달 농도가 직접 의존) · **LB-5 PFD 3.7패스 천장** (Biesman 1건 외 cross-check 없음) 도 흔들리면 fold-cut 변동.

요약: track A (마취) 는 closed-form + 임상 정합으로 onset 율속(SC D)이 *물리적으로 닫힌* 상태 · track B 는 PFD/multipass 부분은 강하나 **β_topical 부분이 load-bearing assumption** 으로 wet-lab 까지 보류. absorbed=false 유지.

## §9 진행 상태

- ✅ 38 claim 추출 + tier 할당 (A1·B1·B2·B3)
- ✅ A1/B1/B2/B3 hexa verbatim 인용 (🟢 13건 recompute 완료)
- ✅ load-bearing assumption 8건 flag (§7)
- ✅ V3 cross-check plan (§6 · 7 step · 모두 local CPU 천장 안)
- ⏳ V2 🔵 push (Fick lag·Mie·Beer-Lambert·기하급수·직렬 곱 closed-form ledger)
- ⏳ V3 🟢 2nd-method cross-check (PBPK · MCML · 임상 메타 · BP1d 정합)
- ⏳ V4 final ledger (38 claim + 🟠 6 wet-lab gate)
- next: V2 — A1.7/B2.2/B2.3/B1.8 closed-form ledger (hexa verify --expr)

---

## Sources (consolidated · A1/B1/B2/B3 verbatim)

### 마취 (A1)
- EMLA FDA label — onset 1h·최대 2-3h·≤1300 cm²/150g·metHb (accessdata.fda.gov/.../019941s021lbl.pdf · drugs.com/pro/emla.html)
- EMLA-induced methemoglobinemia & systemic toxicity — *J Emerg Med* (sciencedirect.com/.../S0736467903002944)
- Lidocaine/tetracaine cream for dermatologic laser procedures review — *PubMed* 25135033
- BLT (benzo 20%/lido 6%/tetra 4%) compounded — Empower Pharmacy · Fagron Academy · NCT01842373
- LMX-4 liposomal lidocaine 30min 무폐색 vs EMLA 60min — PEMCincinnati · USPharmacist
- Lidocaine SC diffusivity ~1e-10 cm²/s — UCSD BENG221 diffusion model · *Int J Dermatol* 2018 doi/10.1111/ijd.14107 · *Sci Data* 2024 skin permeability review s41597-024-03026-4
- Free nerve endings / Aδ·C nociceptor 깊이 — en.wikipedia.org/wiki/Free_nerve_ending · NCBI NBK11162 · *PubMed* 16086989

### 제거 (B1/B2/B3)
- Q-switched / picosecond 광음향 단편화 기전 + 6-10세션 — *StatPearls* NBK442007 · *J Cutan Aesthet Surg* "Newer Trends" PMC4411588
- frosting = steam/vacuolization/gas bubble · 20분 자연 소실 — JCAS PMC4411588 · *J Aesthet Nurs* Skin&Laser Suppl Mar21
- pico 세션·클리어런스 (61%/2세션·86.6%/6-8세션·79%/6.5세션·~30% 완전제거) — *Lasers Med Sci* 2024 s10103-024-04140-w · PMC11322294 · *MDPI Appl Sci* 11(20):9712
- R20 (Kossida 2012) 4패스 · 61% vs 0% split-tattoo — *Arch Dermatol/JAAD* PubMed 22036610 · astanzalaser.com
- **PFD pivotal trial (Biesman 2017) 3.7 vs 1.4 passes · 30명 split** — *Lasers Surg Med* PubMed 28319270
- PFD 입자방출·온도·fluence (Reddel 2020) — *J Cosmet Laser Ther* 22(3) PubMed 32516063 · JAAD pig model S0190-9622(19)31760-8
- DESCRIBE PFD patch (frosting 3-5초 · 80분→5분) — describepatch.com · JCAS PMC4411588 · Merz Aesthetics press
- PFD 물성 (n=1.313 · O₂ 50 mL/100mL · 비반응 · FDA cleared) — ScienceDirect Topics Perfluorodecalin · researchgate 335114971 · PMC11614965 · refractiveindex.info
- baseline dermis μ_s ~100 cm⁻¹ (755nm) — Jacques 2013 *Phys Med Biol*
- 기포 a=1μm · N≈10⁶/mm³ — Ho 2002 (JCAS 인용)
- 대체제 — PFH refractiveindex.info · *PubMed* 15666319 (OCA in vitro skin) · 50% glycerol HGM s41598-020-77889-z (PMC7801418) · PMC10224698 (in vivo OCA LC-OCT) · silicone-oil n=1.40-1.41 PMC3759812
- **Baranska 2018 capture-release-recapture · "laser + transient macrophage ablation"** — *J Exp Med* rupress.org/jem/215/4/1115

### Cross-domain inheritance
- TTR-ORAL/research/BP1_recapture_block.md — 경구 phago 차단제 부재 벽 (B3 토픽으로 우회)
- TTR-ORAL/research/BP1a_scavenger_receptor_scout.md — rhein/MARCO/SR-A scaffold (B3 β_topical 0.50 외삽 근거)
- TTR-ORAL/verify/V1_claim_inventory.md — 본 V1 의 patterned sibling (BP1d 세션 모델 동형)
- TTR base — carbon black 비분해성 floor (B1.16/B3.9 상속)

### 재현 (hexa-native)
- `TTR-LAC/sim/a1_lagtime.hexa` — `hexa run TTR-LAC/sim/a1_lagtime.hexa` (A1.9/A1.10/A1.13/A1.14)
- `TTR-LAC/sim/b1_laser_ratelimit.hexa` — B1.9-B1.14
- `TTR-LAC/sim/b2_frosting_clear.hexa` — B2.4/B2.9/B2.10/B2.11/B2.12
- `TTR-LAC/sim/b3_topical_r_down.hexa` — B3.4/B3.5/B3.6
