# TTR-LAC V4 — final tier ledger (track A 마취 + track B 제거 · 레이저 병용 topical)

> ❄️ **TTR-LAC** — "레이저 마취·지움 크림" (laser-companion topical · 마취 가속 + 세션당 제거율↑)
> milestone: verify "V4 final tier ledger". V1 inventory (38 claim) + V2 🔵 (52/52 closed-form PASS) + V3 🟢 (in flight) + 🟠 wet-lab deferred 통합 정산 + 최종 absorbed 판정.
> parent: TTR-LAC.md (@goal: onset↓·진피 도달↑ + 세션당 제거율↑ · measured-oracle PASS 까지 absorbed=false) · sibling: TTR-ORAL/verify/V4_tier_ledger.md (format mirror).

## bottom line

| 항목 | 상태 |
|---|---|
| 비-wet-lab 게이트 (A1·A2/A3·A4·A5 · B1·B2·B3·B4 · V1·V2 · V3 in flight) | ✅ **완료** (@D d1 completed-form, V3 🟢 recompute는 7-step local-CPU 천장 안 · landing 보류) |
| track A (마취) verdict | **CONDITIONAL-GO (thin-SC ≤20min · 일반 ≤30min)** — D-boost 20× + epi 1:200k + 14% eutectic 정합, 단 in-vivo retention envelope 5-10× 의존 |
| track B (제거) verdict | **CONDITIONAL-GO** — 모델 fold-cut 4.94× (B2+B3+B4), carbon-25% floor 적용 honest-cut 3.83× (~1.5세션·~2.4mo) |
| **absorbed** | **false** (@goal = measured-oracle PASS 까지 · β_topical=0.50 (LB-6) · in-vivo retention · LAST 가산 stack · clearance ≥75% 실측 모두 미달) |
| 결정적 wet-lab measurable (A) | **A5 in-vivo retention** (MD 42× → Franz → in-vivo 5-10×? · h=10-20μm population sweep) |
| 결정적 wet-lab measurable (B) | **β_topical = 0.50 (LB-6 · rhein 토픽 SR-A)** — M8 ex-vivo on real tattoo 1순위 게이트 |
| 결정적 wet-lab measurable (safety) | **stack LAST Cmax @ 100cm²×30min+epi ≤ 18 ng/mL (273× 마진)** — Pliaglis-PK k=0.0533 ng/mL/mg 외삽 in-vivo 확인 |

## tier roll-up (V1 38-claim inventory + V2 52 unit identity 기준 + V3 in flight)

| tier | 의미 | 갯수 | 대표 claim |
|---|---|---|---|
| 🔵 SUPPORTED-FORMAL | closed-form identity (V2 52/52 PASS) | 8 (claim) / 52 (unit ledger) | t_lag=h²/6D · C(z)=C_surf·exp(−z/λ) · c_session=1−(1−φ(1−r))^n · N=log0.1/log(1−c) · r(β)=(1−β)·r₀ · β_combined=1−(1−β_pre)(1−β_post) · μ_s_frost=N_bub·Q_sca·π·a² · T=exp(−μ_s·z) |
| 🟢 SUPPORTED-NUMERICAL | hexa-native recompute verbatim (sim/a1·b1·b2·b3 + V2 §1-§6 hand-arith) | 13 + (V3 in flight 7-step planned) | onset 55.6min(EMLA정합) · 진피 200μm 2.35%→0.67% · Pliaglis 14%×λ60μm = 0.499% ≈ MEC · B1 calib N=5.74 (6-10세션 anchor) · PFD 3.7p N=2.17 · fold 2.64× · μ_s_frost 162.83·T 0.039(71.5% 차단) · PFD T 0.134 (98.75% 회복) · β=0.50 → N=2.97 · JOINT N=0.80 · B4 double-coat N=0.67 · LAST Cmax 18 ng/mL (273× 마진) |
| 🟡 SUPPORTED-BY-CITATION | 문헌/라벨 verbatim | 11 | EMLA FDA label (60min 무폐색 · 1300cm²/150g) · LMX-4/Pliaglis/BLT compounded · Biesman 2017 (PFD 3.7p pivotal) · Kossida 2012 (R20 4p) · Reddel 2020 (PFD fluence/온도) · DESCRIBE FDA-cleared · Ho 2002 (기포 광학) · Jacques 2013 (dermis μ_s=100) · PFD 물성 (n=1.313·O₂ 50mL) · Mohammed 2012 / Baranska 2018 / TTR-ORAL carbon floor 상속 |
| 🟠 INSUFFICIENT/DEFERRED | wet-lab / 외부 dep | 6 | β_topical=0.50 직접 실측 (LB-6 · M8 ex-vivo) · λ 절대값 partition (A5 Franz) · in-vivo retention envelope · PFD-lido 직접 호환성 · BLT compounded 정확 onset · stack LAST 가산 in-vivo 안전 |
| ⚪ SPECULATION-FENCED | honest fence (V2 §0) | 1 | "Stacked PFD(3.7p) + topical r-down(β=0.50) cuts laser tattoo sessions ~5.74→0.80 in model, floored ~1.5 by carbon-25%" → ⚪ (single-trial anchor 의존 + feasibility 주장) |
| 🔴 FALSIFIED | — | **0** (B3.8 "<1세션 절대" self-flag → V2 §6 L6.6 honest-floor 로 자체 reframe, 닫힌 부정 아님) |

> V2 ledger 단위 결의: §1 SC 8/8 · §2 depth 8/8 · §3 multipass 10/10 · §4 recapture 10/10 · §5 광학 10/10 · §6 fold-cut 6/6 = **52/52 PASS**. 13 atlas-register 후보 (AR-1~AR-13) V4 입력.

## 두 트랙 최종 status

| 트랙 | 벽 | status | 근거 |
|---|---|---|---|
| **A 마취** | A-W1 onset ≤20min 임상 | ✅ closed-form 닫힘, 🟠 retention 의존 | t_lag=h²/6D → D-boost 20× × h=10μm → 2.78min ; h=20μm → 11.1min. 단 MD 42×는 in-vivo 5-10×로 보수환원 → P(≤20min)=33-67% (A5 envelope) → **honest target ≤30min** (EMLA 60→2× 단축 device-free 보장) |
| **A 마취** | A-W2 진피 자유신경말단 차단 (200μm) | ✅ closed-form 닫힘 | C(200μm) = 14% × exp(−200/60μm) = **0.499% ≈ MEC 0.5%** (Pliaglis-eq × epi-1:200k λ=60μm) — V2 L2.6 첫 plausible threshold |
| **A 마취** | A-W3 LAST 가산 안전 | ✅ envelope 닫힘 (Pliaglis-PK anchor) | A_max envelope: ≤200cm² v1 default(135× 마진) / 200-400 split / >600 de-rate 5+5% · 100cm²×30min+epi Cmax 18 ng/mL (273× LAST 마진) · 🚨 epi 1:200k = LAST-MANDATORY (없으면 마진 2× 좁아짐) |
| **B 제거** | B-W1 frosting 차단 (1패스 ceiling) | ✅ closed-form 닫힘 (PFD optical) | μ_s_frost +62.83 cm⁻¹ → T@200μm 0.039 (71.5% 차단) · PFD RI 매칭 → T 0.134 (98.75% 회복) — V2 §5 first-principles. Biesman 2017 (3.7 vs 1.4 패스) 임상 anchor (LB-5) |
| **B 제거** | B-W2 재포획 r↓ (β_topical) | 🟠 wet-lab dep (LB-6) | rhein/SR-A 토픽 β=0.50 외삽 — 직접 잉크-재포획 β 실측 부재. β=0.50 → r=0.35 → N(n=1)=2.97, JOINT(n=3.7) N=0.80. **M8 ex-vivo on real tattoo 1순위 게이트** |
| **B 제거** | B-W3 chair-time + carbon floor | ✅ 닫힘 + honest floor 명시 | B4 5단계 워크플로 83min (R20 140min: −57min · DESCRIBE 70min: +13min) · 모델 N=0.67 (1.07mo, 8.6×) BUT carbon-25% 비분해 → **실용 floor ~1.5세션·2.4mo·3.83×** (V2 L6.6 honest-cut) |
| **B 제거** | B-W4 잉크 화학 floor | ✅ TTR-ORAL 상속 (carve-out) | carbon black 비분해성 — track B 는 *세션당 RATE / 패스 수 / 재포획률* 만 변경, 잉크 화학 변경 ✗ (B1.16). 과장 금지 정직 framing 작동 |

## measured-oracle (LAC absorbed=true ⟺ O1∧O2∧O3∧O4 모두 PASS)

각 기준이 V2 closed-form 예측에 1:1 tie → FAIL 시 어느 가정이 깨졌는지 추적 가능 (falsifiable per @D d1/d5/d6).

| oracle | PASS 기준 | tie to closed-form (V2 §) | tier 종속 |
|---|---|---|---|
| **O1 마취 onset (thin-SC sub)** | 측정 onset ≤ 20min in ≥80% population (h≤15μm SC) for hexa-LAC v1 (lid+tet 7+7% eutectic + linoleic 5% + EtOH 20% + PG 10% + epi 1:200k) | V2 §1 L1.3 + L1.5/L1.7 (D-boost 20× × h≤15μm → 4.6min) ; A5 envelope 보수 5-10× 시 P(≤20min) ≥ 50% | 🟠 → 🟢 if PASS |
| **O1' 마취 onset (general pop)** | 측정 onset ≤ 30min in ≥80% population (h≤20μm SC) — device-free EMLA 60min 대비 ≥2× 단축 | V2 §1 L1.4·L1.7 (h=20μm, boost 20× → 11.1min) ; A5 보수 D-boost 5-10× → 11.1×(4-2)= 22-44min envelope | 🟠 → 🟢 if PASS |
| **O2 진피 마취 농도 (block)** | C(200μm) ≥ MEC 0.5% (Pliaglis 14% eutectic + epi 1:200k λ=60μm) — 자유신경말단 plausible block | V2 §2 L2.6 (14% × exp(−200/60) = 0.4994% ≈ MEC) ; LB-4 λ 절대값 partition 실측 의존 | 🟠 (λ 절대값) → 🟢 if PASS |
| **O3 stack LAST 안전 (가산)** | 100cm²×30min+epi 1:200k 도포에서 Cmax_total (lido+tet+benzo if BLT) ≤ 25 ng/mL (LAST CNS 5000 ng/mL 대비 ≥200× 마진) — Pliaglis-PK k=0.0533 ng/mL/mg 외삽 in-vivo 확인 | A4 (Cmax 18 ng/mL @ 100cm²×30min+epi · 273× 마진) ; epi 1:200k MANDATORY (없으면 2× 좁아짐) | 🟠 → 🟢 if PASS · MetHb sub-oracle (prilo/benzo) ≥1g 시 추가 |
| **O4 세션당 제거율 (cosmetic clearance)** | split-tattoo / paired-design 에서 LAC (PFD + rhein-topical β=0.50) vs SoC 동일 세션수에서 clearance% ↑ ≥ 50%p OR 동일 90% endpoint 도달 세션수 ≤ floor 1.5세션 (3.83× cut vs SoC 5.74) | V2 §3 L3.3·L3.7 + §4 L4.6·L4.8 + §6 L6.3·L6.6 (B2+B3 JOINT N=0.80 모델 천장, carbon-25% floor 적용 honest N=1.5) | 🟠 (LB-6 β_topical=0.50) → 🟢 if PASS |

> 4 oracle 모두 V2 closed-form 식의 *변수 1개* 의 in-vivo 실측치를 input 으로 받음 — FAIL 시 어느 closed-form 가정이 빠졌는지 1:1 attribution 가능 (e.g., O1 FAIL → D-boost MD 42× → in-vivo 보존율이 5× 미만 → A5 retention envelope 하한 깨짐). 강제 fitting 금지 (@D d6).

## honest closure (per @D d1 · d5 · d6)

- **비-wet-lab march 완료 (@D d1)**: A1 baseline → A2/A3 가속·진피 도달 → A4 LAST envelope → A5 retention 폭포 → B1 세션 모델 → B2 frosting 광학 → B3 토픽 β · → B4 통합 protocol → V1 38-claim tier triage → V2 52/52 closed-form ledger PASS. V3 (🟢 numerical 2nd-method cross-check) 7 step 은 모두 local CPU 천장 안 (@D d7) — landing 보류이나 *경로 명확*. 닫힌 부정 (🔴) **0건**.
- **absorbed=false 유지 (@D d5)**: @goal 의 measured-oracle 정의는 4 wet-lab gate (O1·O2·O3·O4) 의 *직접 측정* — 비-wet-lab 게이트는 conditional PASS 이나 *결정적 measurable* 가 in-vivo 실측에 본질 의존 (LB-6 β_topical=0.50 · A5 retention envelope · stack LAST 가산 · clearance 비율). d5 의 "non-wet-lab PASS"가 여기선 *conditional* — unconditional PASS 아님 → flip 금지.
- **인플레 가드 작동 (@D d6)**: 모델 N=0.67 (<1세션) 절대값을 *그대로 보고 않음*. carbon-25% 비분해 floor 적용 → 실용 N≥1.5세션·2.4mo·**3.83× cut** 으로 honest-bound 명시 (V2 L6.6). 5.74 → 0.80 (모델 7.16×) 는 ⚪ feasibility fence (V2 §0), 5.74 → 1.5 (honest 3.83×) 가 보고 기준. carve-out 없음.
- **브레이크스루 path (@D d2)**: 닫힘 한계 = `hexa verify --expr` 가 dermatologic PK / laser optics / multipass 미지원 → V2 §10 의 stdlib 확장 (`fick_lag`/`beer_lambert`/`mie_mu_s`/`multipass_cumulative`/`sessions_to_90pct`/`recapture_beta`) 제안 → `hexa-lang/INBOX.log.md` patch (TTR-ORAL V2 §4 의 PK fn proposal 과 합쳐 단일 dermatologic stdlib 모듈) — *concrete path* (per @D d2, 미러로 단순화 폐기 금지).
- ⇒ 비-wet-lab march 고갈. 다음 실제 전진 = wet-lab — **M8 ex-vivo on real tattoo (β_topical 직접 측정)** = 1순위 게이트 (LB-6) · **Franz cell PK (in-vivo retention envelope)** = 2순위 (A5 envelope) · **stack LAST in-vivo PK** = 3순위 (epi 1:200k MANDATORY 확인) · **split-tattoo clearance trial** = 4순위 (O4). 모두 외부 의존 🟠.

## §A V4 ledger summary (재현용 표)

| 항목 | 값 |
|---|---|
| 추출 claim | 38 (A1:15 · B1:16 · B2:13 · B3:10) |
| closed-form unit identity (V2) | 52 / 52 ✅ PASS |
| atlas-register 후보 (AR-1~AR-13) | 13 atom (11 🔵 + 5 🟢 + 1 🟡, family 교집합 중복 포함) |
| 🔵 / 🟢 / 🟡 / 🟠 / ⚪ / 🔴 | 8 / 13 / 11 / 6 / 1 / 0 |
| load-bearing assumption (V1 §7) | LB-1~LB-8 (가장 약한 고리: **LB-6 β_topical=0.50**) |
| 모델 천장 (carbon floor 미적용) | B4 N=0.67 · 8.6× cut · 1.07mo |
| **honest-floor (carbon-25% 적용, 보고 기준)** | **N≥1.5 · 3.83× cut · ~2.4mo** |
| chair-time (B4 5단계) | 83min (R20 140min 대비 −57min) |
| LAST 마진 (Cmax 18 ng/mL @ 100cm²×30min+epi) | 273× (CNS 5000 ng/mL 기준) |
| absorbed | **false** (oracle 4/4 미충족 — wet-lab pending) |
| 🔴 falsified | **0** |
| verdict | **CONDITIONAL-GO** (track A + track B 모두) — 비-wet-lab 영역 닫힘, oracle 게이트 wet-lab dep |

## §B 자체-falsify 가드 명시

- 모델 <1세션 (B3.8 / V2 L4.8 N=0.80, L4.10 N=0.67) 은 c_session<1 상한 없는 기하급수 모델 천장 — *절대 세션수* 로 주장 시 자체 falsify. V2 §6 L6.6 honest-floor 3.83× / N≥1.5세션 으로 reframe. **이 ledger 의 보고 기준은 floor**.
- D-boost 20× × MD 42× 의 *in-vivo* 보존율 (A5 폭포 42× → 10-15× Franz → 5-10× 인간 SC) 미실측 — A2/A3 의 P(≤20min)=95% 는 retention ≥50% 상한 가정. 보고 target 은 **thin-SC ≤20min · 일반 ≤30min** (보수 envelope).
- ⚪ V2 §0 fence: stack feasibility 주장은 *단일* PFD pivotal trial (Biesman 2017) + carbon floor 상속에 의존 → atlas 인증 N/A (g4 honest fence) · 5.74→0.80 *모델 fold-cut* 는 ⚪, 5.74→1.5 honest-floor *만* 🟢 hand-arith PASS.

---

## §C 트랙 verdict 합성 (final)

| 트랙 | 비-wet-lab gate | wet-lab measurable | absorbed contribution | verdict |
|---|---|---|---|---|
| A 마취 | ✅ closed-form 닫힘 (V2 §1·§2) + LAST envelope (A4) 닫힘 | O1/O1' onset · O2 진피 농도 · O3 stack LAST | false (3 oracle pending) | **CONDITIONAL-GO** (thin-SC ≤20min · 일반 ≤30min · LAST 273× 마진) |
| B 제거 | ✅ closed-form 닫힘 (V2 §3·§4·§5·§6) + B4 protocol 닫힘 | O4 세션당 clearance% (LB-6 β_topical=0.50) | false (1 oracle pending) | **CONDITIONAL-GO** (honest 3.83× cut · ~1.5세션 floor · 83min chair) |
| 도메인 합계 | ✅ V1 + V2 + V3 in flight + 8 research doc 모두 completed-form | O1·O2·O3·O4 4 게이트 all pending | **false** | **CONDITIONAL-GO** — domain not falsified, march to wet-lab |

⇒ TTR-LAC 도메인 **closed-form 영역은 closed**, **wet-lab 영역은 4-gate oracle 정의됨 (각 V2 closed-form 1:1 tie · falsifiable)**, **🔴 0건**. @goal 정의대로 **absorbed=false 유지** — wet-lab measurement 까지 march. d1/d5/d6 모두 정합.
